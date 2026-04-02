#include "custom_all_reduce.cuh"

#include <algorithm>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <limits>
#include <stdexcept>
#include <string>

namespace vllm {
#define CUDACHECK(cmd)                                              \
  do {                                                              \
    hipError_t e = cmd;                                            \
    if (e != hipSuccess) {                                         \
      printf("Failed: Cuda error %s:%d '%s'\n", __FILE__, __LINE__, \
             hipGetErrorString(e));                                \
      exit(EXIT_FAILURE);                                           \
    }                                                               \
  } while (0)

#ifndef USE_ROCM
hipPointer_attribute rangeStartAddrAttr = CU_POINTER_ATTRIBUTE_RANGE_START_ADDR;
#else
hipPointer_attribute rangeStartAddrAttr =
    HIP_POINTER_ATTRIBUTE_RANGE_START_ADDR;
#endif

static int origin_size = 0;
static int origin_blocks = 0;

// like std::array, but aligned
template <typename T, int sz>
struct __align__(alignof(T) * sz) array_t {
  T data[sz];
  using type = T;
  static constexpr int size = sz;
};

// use packed type to maximize memory efficiency
// goal: generate ld.128 and st.128 instructions
template <typename T>
struct packed_t {
  // the (P)acked type for load/store
  using P = array_t<T, 16 / sizeof(T)>;
  // the (A)ccumulator type for reduction
  using A = array_t<float, 16 / sizeof(T)>;
};

#define DINLINE __device__ __forceinline__

// scalar cast functions
DINLINE float upcast_s(half val) { return __half2float(val); }

template <typename T>
DINLINE T downcast_s(float val);
template <>
DINLINE half downcast_s(float val) {
  return __float2half(val);
}

template <>
DINLINE float downcast_s(float val) {
  return val;
}

// scalar add functions
// for some reason when compiling with Pytorch, the + operator for half and
// bfloat is disabled so we call the intrinsics directly
DINLINE half& assign_add(half& a, half b) {
  a = __hadd(a, b);
  return a;
}
DINLINE float& assign_add(float& a, float b) { return a += b; }

DINLINE float upcast_s(float val) { return val; }

#if (__CUDA_ARCH__ >= 800 || !defined(__CUDA_ARCH__))
DINLINE float upcast_s(nv_bfloat16 val) { return __bfloat162float(val); }
template <>
DINLINE nv_bfloat16 downcast_s(float val) {
  return __float2bfloat16(val);
}
DINLINE nv_bfloat16& assign_add(nv_bfloat16& a, nv_bfloat16 b) {
  a = __hadd(a, b);
  return a;
}
#endif

template <typename T, int N>
DINLINE array_t<T, N>& packed_assign_add(array_t<T, N>& a, array_t<T, N> b) {
#pragma unroll
  for (int i = 0; i < N; i++) {
    assign_add(a.data[i], b.data[i]);
  }
  return a;
}

template <typename T, int N>
DINLINE array_t<float, N> upcast(array_t<T, N> val) {
  if constexpr (std::is_same<T, float>::value) {
    return val;
  } else {
    array_t<float, N> out;
#pragma unroll
    for (int i = 0; i < N; i++) {
      out.data[i] = upcast_s(val.data[i]);
    }
    return out;
  }
}

template <typename O>
DINLINE O downcast(array_t<float, O::size> val) {
  if constexpr (std::is_same<typename O::type, float>::value) {
    return val;
  } else {
    O out;
#pragma unroll
    for (int i = 0; i < O::size; i++) {
      out.data[i] = downcast_s<typename O::type>(val.data[i]);
    }
    return out;
  }
}

#if !defined(USE_ROCM)

static DINLINE void st_flag_release(FlagType* flag_addr, FlagType flag) {
  #if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 700
  asm volatile("st.release.sys.global.u32 [%1], %0;" ::"r"(flag),
               "l"(flag_addr));
  #else
  asm volatile("membar.sys; st.volatile.global.u32 [%1], %0;" ::"r"(flag),
               "l"(flag_addr));
  #endif
}

static DINLINE FlagType ld_flag_acquire(FlagType* flag_addr) {
  FlagType flag;
  #if defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 700
  asm volatile("ld.acquire.sys.global.u32 %0, [%1];"
               : "=r"(flag)
               : "l"(flag_addr));
  #else
  asm volatile("ld.volatile.global.u32 %0, [%1]; membar.gl;"
               : "=r"(flag)
               : "l"(flag_addr));
  #endif
  return flag;
}

static DINLINE void st_flag_volatile(FlagType* flag_addr, FlagType flag) {
  asm volatile("st.volatile.global.u32 [%1], %0;" ::"r"(flag), "l"(flag_addr));
}

static DINLINE FlagType ld_flag_volatile(FlagType* flag_addr) {
  FlagType flag;
  asm volatile("ld.volatile.global.u32 %0, [%1];"
               : "=r"(flag)
               : "l"(flag_addr));
  return flag;
}

// This function is meant to be used as the first synchronization in the all
// reduce kernel. Thus, it doesn't need to make any visibility guarantees for
// prior memory accesses. Note: volatile writes will not be reordered against
// other volatile writes.
template <int ngpus>
DINLINE void barrier_at_start(const RankSignals& sg, Signal* self_sg,
                              int rank) {
  uint32_t flag = self_sg->_flag[blockIdx.x] + 1;
  if (threadIdx.x < ngpus) {
    auto peer_counter_ptr = &sg.signals[threadIdx.x]->start[blockIdx.x][rank];
    auto self_counter_ptr = &self_sg->start[blockIdx.x][threadIdx.x];
    // Write the expected counter value to peer and wait for correct value
    // from peer.
    st_flag_volatile(peer_counter_ptr, flag);
    while (ld_flag_volatile(self_counter_ptr) != flag);
  }
  __syncthreads();
  // use one thread to update flag
  if (threadIdx.x == 0) self_sg->_flag[blockIdx.x] = flag;
}

// This function is meant to be used as the second or the final
// synchronization barrier in the all reduce kernel. If it's the final
// synchronization barrier, we don't need to make any visibility guarantees
// for prior memory accesses.
template <int ngpus, bool final_sync = false>
DINLINE void barrier_at_end(const RankSignals& sg, Signal* self_sg, int rank) {
  __syncthreads();
  uint32_t flag = self_sg->_flag[blockIdx.x] + 1;
  if (threadIdx.x < ngpus) {
    auto peer_counter_ptr = &sg.signals[threadIdx.x]->end[blockIdx.x][rank];
    auto self_counter_ptr = &self_sg->end[blockIdx.x][threadIdx.x];
    // Write the expected counter value to peer and wait for correct value from
    // peer.
    if constexpr (!final_sync) {
      st_flag_release(peer_counter_ptr, flag);
      while (ld_flag_acquire(self_counter_ptr) != flag);
    } else {
      st_flag_volatile(peer_counter_ptr, flag);
      while (ld_flag_volatile(self_counter_ptr) != flag);
    }
  }
  if constexpr (!final_sync) __syncthreads();

  // use one thread to update flag
  if (threadIdx.x == 0) self_sg->_flag[blockIdx.x] = flag;
}

#else

template <int ngpus>
DINLINE void barrier_at_start(const RankSignals& sg, Signal* self_sg,
                              int rank) {
  uint32_t flag = self_sg->_flag[blockIdx.x] + 1;
  if (threadIdx.x < ngpus) {
    // simultaneously write to the corresponding flag of all ranks.
    // Latency = 1 p2p write
    __scoped_atomic_store_n(&sg.signals[threadIdx.x]->start[blockIdx.x][rank],
                            flag, __ATOMIC_RELAXED, __MEMORY_SCOPE_SYSTEM);
    // wait until we got true from all ranks
    while (__scoped_atomic_load_n(&self_sg->start[blockIdx.x][threadIdx.x],
                                  __ATOMIC_RELAXED,
                                  __MEMORY_SCOPE_DEVICE) < flag);
  }
  __syncthreads();
  // use one thread to update flag
  if (threadIdx.x == 0) self_sg->_flag[blockIdx.x] = flag;
}

template <int ngpus, bool final_sync = false>
DINLINE void barrier_at_end(const RankSignals& sg, Signal* self_sg, int rank) {
  __syncthreads();
  uint32_t flag = self_sg->_flag[blockIdx.x] + 1;
  if (threadIdx.x < ngpus) {
    // simultaneously write to the corresponding flag of all ranks.
    // Latency = 1 p2p write
    __scoped_atomic_store_n(&sg.signals[threadIdx.x]->end[blockIdx.x][rank],
                            flag,
                            final_sync ? __ATOMIC_RELAXED : __ATOMIC_RELEASE,
                            __MEMORY_SCOPE_SYSTEM);
    // wait until we got true from all ranks
    while (
        __scoped_atomic_load_n(&self_sg->end[blockIdx.x][threadIdx.x],
                               final_sync ? __ATOMIC_RELAXED : __ATOMIC_ACQUIRE,
                               __MEMORY_SCOPE_DEVICE) < flag);
  }
  if constexpr (!final_sync) __syncthreads();
  // use one thread to update flag
  if (threadIdx.x == 0) self_sg->_flag[blockIdx.x] = flag;
}

#endif

template <typename P, int ngpus, typename A>
DINLINE P packed_reduce(const P* ptrs[], int idx) {
  A tmp = upcast(ptrs[0][idx]);
#pragma unroll
  for (int i = 1; i < ngpus; i++) {
    packed_assign_add(tmp, upcast(ptrs[i][idx]));
  }
  return downcast<P>(tmp);
}

template <typename T, int ngpus>
__global__ void __launch_bounds__(512, 1)  
    cross_device_reduce_1stage(RankData* _dp, RankSignals sg, Signal* self_sg,
                               T* __restrict__ result, int rank, int size) {
  using P = typename packed_t<T>::P;
  using A = typename packed_t<T>::A;
  // note: we don't reorder the address so the accumulation order is the same
  // for all ranks, ensuring bitwise identical results
  auto dp = *_dp;
  barrier_at_start<ngpus>(sg, self_sg, rank);
  // do the actual reduction
  for (int idx = blockIdx.x * blockDim.x + threadIdx.x; idx < size;
       idx += gridDim.x * blockDim.x) {
    ((P*)result)[idx] = packed_reduce<P, ngpus, A>((const P**)&dp.ptrs[0], idx);
  }
  barrier_at_end<ngpus, true>(sg, self_sg, rank);
}

template <typename P>
DINLINE P* get_tmp_buf(Signal* sg) {
  return (P*)(((Signal*)sg) + 1);
}

// Non-temporal global traffic (ROCm); P is always 16B packed vec in this file.
// Use Clang vector (not HIP's float4 typedef) — builtins reject HIP_vector_type.
#if defined(USE_ROCM)
using nt_vec16 = __attribute__((__vector_size__(16))) float;
template <typename P>
DINLINE P nt_load_global(const P* p) {
  static_assert(sizeof(P) == 16 && sizeof(nt_vec16) == 16, "nt_load: 16B P");
  union {
    nt_vec16 f;
    P out;
  } u;
  u.f = __builtin_nontemporal_load(reinterpret_cast<const nt_vec16*>(p));
  return u.out;
}
template <typename P>
DINLINE void nt_store_global(P* p, const P& val) {
  static_assert(sizeof(P) == 16 && sizeof(nt_vec16) == 16, "nt_store: 16B P");
  union {
    nt_vec16 f;
    P in;
  } u;
  u.in = val;
  __builtin_nontemporal_store(u.f, reinterpret_cast<nt_vec16*>(p));
}

// Perf experiment: force global_load_dwordx4 (flat ptr cast to AS1) instead of
// compiler flat_load for peer buffer -> smem 16B chunk. Modifier matches
// rocPrim ROCPRIM_ATOMIC_LOAD_GLOBAL on CDNA3 ("off sc1").
template <typename P>
DINLINE void smem_store_p_from_peer_global_asm(P* smem_slot, const P* flat_src) {
  static_assert(sizeof(P) == 16, "packed P is 16B");
  using Gsrc = const __uint128_t __attribute__((address_space(1)))*;
  // Addrspacecast: Clang rejects __builtin_astype(..., Gsrc) in C++; C-cast works.
  Gsrc gsrc = (Gsrc)flat_src;
  __uint128_t w;
  asm volatile("global_load_dwordx4 %0, %1 off sc1\n\t"
               "s_waitcnt vmcnt(0)\n\t"
               : "=v"(w)
               : "v"(gsrc)
               : "memory");
  __builtin_memcpy(static_cast<void*>(smem_slot), &w, 16);
}
#else
template <typename P>
DINLINE P nt_load_global(const P* p) {
  return *p;
}
template <typename P>
DINLINE void nt_store_global(P* p, const P& val) {
  *p = val;
}
#endif

template <typename T, int ngpus>
__global__ void __launch_bounds__(512, 1)
    cross_device_reduce_2stage(RankData* _dp, RankSignals sg, Signal* self_sg,
                               T* __restrict__ result, int rank, int size) {
  using P = typename packed_t<T>::P;
  using A = typename packed_t<T>::A;
  constexpr int pack_size = P::size;
  int part = size / ngpus;
  int start = rank * part;
  int end = rank == ngpus - 1 ? size : start + part;
  int largest_part = part + size % ngpus;
  const P* ptrs[ngpus];
  P* tmps[ngpus];
#pragma unroll
  for (int i = 0; i < ngpus; i++) {
    int target = (rank + i) % ngpus;
    ptrs[i] = (const P*)_dp->ptrs[target];
    tmps[i] = get_tmp_buf<P>(sg.signals[target]);
  }
  auto tmp_out = tmps[0];
  barrier_at_start<ngpus>(sg, self_sg, rank);

  if constexpr (512 % ngpus == 0) {
    constexpr int tnum_gpu = 512 / ngpus;
    int warp_id = threadIdx.x / tnum_gpu;
    int lane_id = threadIdx.x % tnum_gpu;
    int tid = blockIdx.x * tnum_gpu + lane_id;
    int stride = gridDim.x * tnum_gpu;
    __shared__ T tmp_smem[tnum_gpu * ngpus * pack_size];
    for (int idx = start + tid; idx < end; idx += stride) {
      constexpr bool use_opt = true;
      if constexpr(use_opt){
        auto flat_src = ptrs[warp_id] + idx;
        using Gsrc = const __uint128_t __attribute__((address_space(1)))*;
        Gsrc gsrc = (Gsrc)flat_src;
        unsigned __int128 tmp;
        asm volatile("global_load_dwordx4 %0, %1 off\n\t"
                     "s_waitcnt vmcnt(0)\n\t"
                     : "=v"(tmp)
                     : "v"(gsrc)
                     : "memory");
        *(reinterpret_cast<P*>(&tmp_smem[0]) + threadIdx.x) = *(reinterpret_cast<P*>(&tmp));
      }else{
        *(reinterpret_cast<P*>(&tmp_smem[0]) + threadIdx.x) = ptrs[warp_id][idx];
      }
      __syncthreads();
      if (warp_id == 0) {
        A add_reg;
#pragma unroll
        for (int i = 0; i < pack_size; ++i)
          add_reg.data[i] = upcast_s(tmp_smem[pack_size * threadIdx.x + i]);
        constexpr int smem_gpu_loop_stride = tnum_gpu * pack_size;
#pragma unroll
        for (int i = 1; i < ngpus; ++i)
#pragma unroll
          for (int j = 0; j < pack_size; ++j)
            add_reg.data[j] += upcast_s(
                tmp_smem[i * smem_gpu_loop_stride + pack_size * threadIdx.x + j]);
        P write_reg;
#pragma unroll
        for (int i = 0; i < pack_size; ++i)
          write_reg.data[i] = downcast_s<T>(add_reg.data[i]);
        tmp_out[idx - start] = write_reg;
      }
      __syncthreads();
    }
    barrier_at_end<ngpus>(sg, self_sg, rank);
    for (int idx = tid; idx < largest_part; idx += stride) {
      int dst_idx = (warp_id + rank) % ngpus * part + idx;
      ((P*)result)[dst_idx] = tmps[warp_id][idx];
    }
  } else {
    int tid = blockIdx.x * blockDim.x + threadIdx.x;
    int stride = gridDim.x * blockDim.x;
    for (int idx = start + tid; idx < end; idx += stride) {
      tmp_out[idx - start] = packed_reduce<P, ngpus, A>(ptrs, idx);
    }
    barrier_at_end<ngpus>(sg, self_sg, rank);
    for (int idx = tid; idx < largest_part; idx += stride) {
#pragma unroll
      for (int i = 0; i < ngpus; i++) {
        int gather_from_rank = ((rank + i) % ngpus);
        if (gather_from_rank == ngpus - 1 || idx < part) {
          int dst_idx = gather_from_rank * part + idx;
          nt_store_global(((P*)result) + dst_idx, nt_load_global(tmps[i] + idx));
        }
      }
    }
  }
}

CustomAllreduce::CustomAllreduce(Signal** signals, void* rank_data,
                                 size_t rank_data_sz, int rank, int world_size,
                                 bool fully_connected)
    : rank_(rank),
      world_size_(world_size),
      fully_connected_(fully_connected),
      self_sg_(signals[rank]),
      d_rank_data_base_(reinterpret_cast<RankData*>(rank_data)),
      d_rank_data_end_(d_rank_data_base_ + rank_data_sz / sizeof(RankData)) {
  for (int i = 0; i < world_size_; i++) {
    sg_.signals[i] = signals[i];
  }
}

char* CustomAllreduce::open_ipc_handle(const void* ipc_handle) {
    auto [it, new_handle] =
        ipc_handles_.insert({*((IPC_KEY*)ipc_handle), nullptr});
    if (new_handle) {
      char* ipc_ptr;
      CUDACHECK(hipIpcOpenMemHandle((void**)&ipc_ptr,
                                     *((const hipIpcMemHandle_t*)ipc_handle),
                                     hipIpcMemLazyEnablePeerAccess));
      it->second = ipc_ptr;
    }
  return it->second;
}

std::pair<std::string, std::vector<int64_t>>
CustomAllreduce::get_graph_buffer_ipc_meta() {
    auto num_buffers = graph_unreg_buffers_.size();
    auto handle_sz = sizeof(hipIpcMemHandle_t);
    std::string handles(handle_sz * num_buffers, static_cast<char>(0));
    std::vector<int64_t> offsets(num_buffers);
    for (int i = 0; i < num_buffers; i++) {
      auto ptr = graph_unreg_buffers_[i];
      void* base_ptr;
      // note: must share the base address of each allocation, or we get wrong
      // address
      if (hipPointerGetAttribute(&base_ptr, rangeStartAddrAttr,
                                (hipDeviceptr_t)ptr) != hipSuccess)
        throw std::runtime_error("failed to get pointer attr");
      CUDACHECK(hipIpcGetMemHandle(
          (hipIpcMemHandle_t*)&handles[i * handle_sz], base_ptr));
      offsets[i] = ((char*)ptr) - ((char*)base_ptr);
    }
  return std::make_pair(handles, offsets);
}

void CustomAllreduce::check_rank_data_capacity(size_t num) {
    if (d_rank_data_base_ + num > d_rank_data_end_)
      throw std::runtime_error(
          "Rank data buffer is overflowed by " +
          std::to_string(d_rank_data_base_ + num - d_rank_data_end_));
}

void CustomAllreduce::register_buffer(void** ptrs) {
    check_rank_data_capacity();
    RankData data;
    for (int i = 0; i < world_size_; i++) {
      data.ptrs[i] = ptrs[i];
    }
    auto d_data = d_rank_data_base_++;
    CUDACHECK(
        hipMemcpy(d_data, &data, sizeof(RankData), hipMemcpyHostToDevice));
  buffers_[ptrs[rank_]] = d_data;
}

void CustomAllreduce::register_graph_buffers(
    const std::vector<std::string>& handles,
    const std::vector<std::vector<int64_t>>& offsets) {
    auto num_buffers = graph_unreg_buffers_.size();
    check_rank_data_capacity(num_buffers);
    std::vector<RankData> rank_data(num_buffers);
    for (int i = 0; i < num_buffers; i++) {
      auto self_ptr = graph_unreg_buffers_[i];
      auto& rd = rank_data[i];
      for (int j = 0; j < world_size_; j++) {
        if (j != rank_) {
          char* handle =
              open_ipc_handle(&handles[j][i * sizeof(hipIpcMemHandle_t)]);
          handle += offsets[j][i];
          rd.ptrs[j] = handle;
        } else {
          rd.ptrs[j] = self_ptr;
        }
      }
    }
    CUDACHECK(hipMemcpy(d_rank_data_base_, rank_data.data(),
                         sizeof(RankData) * num_buffers,
                         hipMemcpyHostToDevice));
    d_rank_data_base_ += num_buffers;
  graph_unreg_buffers_.clear();
}

template <typename T>
void CustomAllreduce::allreduce(hipStream_t stream, T* input, T* output,
                                  int size, int threads, int block_limit) {
    auto d = packed_t<T>::P::size;
    if (size % d != 0)
      throw std::runtime_error(
          "custom allreduce currently requires input length to be multiple "
          "of " +
          std::to_string(d));
    if (block_limit > kMaxBlocks)
      throw std::runtime_error("max supported block limit is " +
                               std::to_string(kMaxBlocks) + ". Got " +
                               std::to_string(block_limit));

    RankData* ptrs;
    hipStreamCaptureStatus status;
    CUDACHECK(hipStreamIsCapturing(stream, &status));
    if (status == hipStreamCaptureStatusActive) {
      ptrs = d_rank_data_base_ + graph_unreg_buffers_.size();
      graph_unreg_buffers_.push_back(input);
    } else {
      auto it = buffers_.find(input);
      if (it == buffers_.end())
        throw std::runtime_error(
            "buffer address " +
            std::to_string(reinterpret_cast<uint64_t>(input)) +
            " is not registered!");
      ptrs = it->second;
    }

    size /= d;
    auto bytes = size * sizeof(typename packed_t<T>::P);

    // Allow overriding block count via env var for tuning
    const char* env_blocks = std::getenv("VLLM_CUSTOM_AR_BLOCKS");
    if (env_blocks != nullptr) {
      int forced_blocks = std::atoi(env_blocks);
      if (forced_blocks > 0 && forced_blocks <= kMaxBlocks) {
        block_limit = forced_blocks;
      }
    }

#if defined(USE_ROCM)
    // Dynamic block count for MI300/MI355X:
    // - Small tensors: fewer blocks to minimize barrier overhead
    // - Large tensors: more blocks to maximize XGMI bandwidth utilization
    int effective_limit;
    if (env_blocks != nullptr) {
      effective_limit = block_limit;  // env override bypasses dynamic logic
    } else if (bytes <= 256 * 1024) {
      effective_limit = 16;
    } else if (bytes <= 2 * 1024 * 1024) { 
      effective_limit = 64;
    } else {
      effective_limit = 64;
    }
    int blocks = std::min(effective_limit, (size + threads - 1) / threads);
#else
    int blocks = std::min(block_limit, (size + threads - 1) / threads);
#endif
    if (size != origin_size || blocks != origin_blocks) {
      origin_size = size;
      origin_blocks = blocks;
      if (rank_ == 0) {
        fprintf(stderr, "byts: %lu, size: %d, blocks: %d, eles: %.3lf\n", bytes, size, blocks,
                ((size + threads - 1) / threads) * 1.0 / blocks);
      }
    }

    // Check environment variable once
    const char* env_algo = std::getenv("VLLM_CUSTOM_ALLREDUCE_ALGO");
    bool force_1stage = false;
    bool force_2stage = false;
    if (env_algo != nullptr) {
      if (std::strcmp(env_algo, "1stage") == 0 ||
          std::strcmp(env_algo, "oneshot") == 0) {
        force_1stage = true;
      } else if (std::strcmp(env_algo, "2stage") == 0 ||
                 std::strcmp(env_algo, "twoshot") == 0) {
        force_2stage = true;
      } else {
        throw std::runtime_error(
            "Invalid VLLM_CUSTOM_ALLREDUCE_ALGO: " + std::string(env_algo) +
            ". Valid values: 1stage, oneshot, 2stage, twoshot");
      }
    }

#define KL(ngpus, name)                                                       \
 hipLaunchKernelGGL(( name<T, ngpus>), dim3(blocks), dim3(threads), 0, stream, ptrs, sg_, self_sg_, output, \
                                                 rank_, size);
#define REDUCE_CASE(ngpus)                              \
  case ngpus: {                                         \
    if (force_1stage) {                                 \
      KL(ngpus, cross_device_reduce_1stage);            \
    } else if (force_2stage) {                          \
      KL(ngpus, cross_device_reduce_2stage);            \
    } else {                                            \
      if (world_size_ == 2) {                           \
        KL(ngpus, cross_device_reduce_1stage);          \
      } else if (fully_connected_) {                    \
        if ((world_size_ <= 4 && bytes < 512 * 1024) || \
            (world_size_ <= 8 && bytes < 128 * 1024)) { \
          KL(ngpus, cross_device_reduce_1stage);        \
        } else {                                        \
          KL(ngpus, cross_device_reduce_2stage);        \
        }                                               \
      }                                                 \
    }                                                   \
    break;                                              \
  }

    switch (world_size_) {
      // REDUCE_CASE(2)
      // REDUCE_CASE(4)
      // REDUCE_CASE(6)
      REDUCE_CASE(8)
      default:
        throw std::runtime_error(
            "custom allreduce only supports num gpus in (2,4,6,8). Actual "
            "num "
            "gpus = " +
            std::to_string(world_size_));
    }
#undef REDUCE_CASE
#undef KL
}

CustomAllreduce::~CustomAllreduce() {
  for (auto [_, ptr] : ipc_handles_) {
    CUDACHECK(hipIpcCloseMemHandle(ptr));
  }
}

template void CustomAllreduce::allreduce<float>(hipStream_t, float*, float*,
                                                int, int, int);
template void CustomAllreduce::allreduce<half>(hipStream_t, half*, half*, int,
                                               int, int);
template void CustomAllreduce::allreduce<nv_bfloat16>(
    hipStream_t, nv_bfloat16*, nv_bfloat16*, int, int, int);

}  // namespace vllm