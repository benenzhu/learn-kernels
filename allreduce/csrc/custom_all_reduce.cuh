#pragma once

#include <hip/hip_bf16.h>
#include <hip/hip_fp16.h>
#include <hip/hip_runtime.h>

#if defined(USE_ROCM)
typedef __hip_bfloat16 nv_bfloat16;
#endif

#include <array>
#include <cstdint>
#include <map>
#include <string>
#include <unordered_map>
#include <vector>

namespace vllm {

constexpr int kMaxBlocks = 256;

#ifndef USE_ROCM
inline constexpr int defaultBlockLimit = 36;
#else
inline constexpr int defaultBlockLimit = 128;
#endif

using FlagType = uint32_t;

struct Signal {
  alignas(128) FlagType start[kMaxBlocks][8];
  alignas(128) FlagType end[kMaxBlocks][8];
  alignas(128) FlagType _flag[kMaxBlocks];
};

struct __align__(16) RankData {
  const void* ptrs[8];
};

struct __align__(16) RankSignals {
  Signal* signals[8];
};

using IPC_KEY = std::array<uint8_t, sizeof(hipIpcMemHandle_t)>;
static_assert(sizeof(IPC_KEY) == sizeof(hipIpcMemHandle_t));
static_assert(alignof(IPC_KEY) == alignof(hipIpcMemHandle_t));

class CustomAllreduce {
 public:
  int rank_;
  int world_size_;
  bool fully_connected_;

  RankSignals sg_;
  std::unordered_map<void*, RankData*> buffers_;
  Signal* self_sg_;

  RankData *d_rank_data_base_, *d_rank_data_end_;
  std::vector<void*> graph_unreg_buffers_;
  std::map<IPC_KEY, char*> ipc_handles_;

  CustomAllreduce(Signal** signals, void* rank_data, size_t rank_data_sz,
                  int rank, int world_size, bool fully_connected = true);

  char* open_ipc_handle(const void* ipc_handle);

  std::pair<std::string, std::vector<int64_t>> get_graph_buffer_ipc_meta();

  void check_rank_data_capacity(size_t num = 1);

  void register_buffer(void** ptrs);

  void register_graph_buffers(const std::vector<std::string>& handles,
                              const std::vector<std::vector<int64_t>>& offsets);

  template <typename T>
  void allreduce(hipStream_t stream, T* input, T* output, int size,
                 int threads = 512, int block_limit = defaultBlockLimit);

  ~CustomAllreduce();
};

}  // namespace vllm
