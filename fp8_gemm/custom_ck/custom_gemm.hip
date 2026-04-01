// Custom CK FP8 block-scale GEMM kernel
// Based on aiter's a8w8_blockscale, same CK template instantiation.
// This is a standalone scaffold for experimenting with split-K / fused memset.
//
// Build: JIT compiled via torch.utils.cpp_extension.load() in test_custom_ck.py

#ifdef USE_ROCM
#undef __HIP_NO_HALF_OPERATORS__
#undef __HIP_NO_HALF_CONVERSIONS__

#include <cstdlib>
#include <iostream>

#include <ATen/ATen.h>
#include <ATen/hip/HIPContext.h>
#include <ATen/hip/impl/HIPGuardImplMasqueradingAsCUDA.h>
#include <ATen/hip/impl/HIPStreamMasqueradingAsCUDA.h>
#include <torch/extension.h>

#include "ck/ck.hpp"
#include "ck/tensor_operation/gpu/device/gemm_specialization.hpp"
#include "ck/tensor_operation/gpu/device/impl/device_gemm_multiple_d_xdl_cshuffle_v3_ab_scale.hpp"
#include "ck/tensor_operation/gpu/element/element_wise_operation.hpp"
#include "ck/tensor_operation/gpu/element/unary_element_wise_operation.hpp"
#include "ck/library/utility/device_memory.hpp"
#include "ck/utility/blkgemmpipe_scheduler.hpp"

// ---- Type aliases (same as aiter's gemm_a8w8_blockscale_common.cuh) ----
template <ck::index_t... Is>
using S = ck::Sequence<Is...>;

using BF16 = ck::bhalf_t;
using FP8  = ck::f8_t;
using FP32 = float;
using FP16 = ck::half_t;

using Row = ck::tensor_layout::gemm::RowMajor;
using Col = ck::tensor_layout::gemm::ColumnMajor;

using PassThrough = ck::tensor_operation::element_wise::PassThrough;

// ---- Default tile config: 16x128x256 (same as aiter's default for blockscale) ----
// Template: DeviceLegacyGemmHelperF8BlockScale
//   DeviceGemmMultiD_ABScale_Xdl_CShuffle_V3<
//     ALayout, BLayout, DsLayout, ELayout,
//     ADataType, AScaleDataType, BDataType, BScaleDataType,
//     DsDataType, EDataType(=output), AccDataType, CShuffleDataType,
//     AElementOp, BElementOp, CDEElementOp, GemmSpec,
//     BlockSize, Scale_Block_M, Scale_Block_N, Scale_Block_K,
//     MPerBlock, NPerBlock, KPerBlock,
//     AK1, BK1, MPerXDL, NPerXDL, MXdlPerWave, NXdlPerWave,
//     ABlockTransfer..., BBlockTransfer...,
//     CShuffle_MX, CShuffle_NX, CShuffleCluster, CDEScalarPerVec,
//     PipeScheduler, PipeVersion>

using DefaultGemmInstance =
    ck::tensor_operation::device::DeviceGemmMultiD_ABScale_Xdl_CShuffle_V3<
        Row, Col, ck::Tuple<>, Row,                          // layouts
        FP8, FP32, FP8, FP32,                                // A, AScale, B, BScale
        ck::Tuple<>, BF16, FP32, FP32,                       // Ds, E(output), Acc, CShuffle
        PassThrough, PassThrough, PassThrough,                // elementwise ops
        ck::tensor_operation::device::GemmSpecialization::MNKPadding,
        256,                                                  // BlockSize
        1, 128, 128,                                          // Scale_Block_{M,N,K}
        16, 128, 256,                                         // MPerBlock, NPerBlock, KPerBlock
        16, 16,                                               // AK1, BK1
        16, 16,                                               // MPerXDL, NPerXDL
        1, 2,                                                 // MXdlPerWave, NXdlPerWave
        S<16, 16, 1>,                                         // ABlockTransferThreadCluster
        S<1, 0, 2>, S<1, 0, 2>,                               // ABlockTransfer orders
        2, 16, 16, 0,                                         // ABlockTransfer vector dims/sizes
        S<16, 16, 1>,                                         // BBlockTransferThreadCluster
        S<1, 0, 2>, S<1, 0, 2>,                               // BBlockTransfer orders
        2, 16, 16, 0,                                         // BBlockTransfer vector dims/sizes
        1, 2,                                                 // CShuffle MX/NX per wave per shuffle
        S<1, 16, 1, 16>,                                      // CShuffleBlockTransferCluster
        S<8>,                                                 // CDEShuffleBlockTransferScalarPerVec
        ck::BlockGemmPipelineScheduler::Intrawave,
        ck::BlockGemmPipelineVersion::v1,
        FP8>;                                                 // ComputeTypeA

// ---- Kernel wrapper ----

torch::Tensor custom_gemm_a8w8_blockscale(
    torch::Tensor& XQ,       // [M, K] fp8
    torch::Tensor& WQ,       // [N, K] fp8
    torch::Tensor& x_scale,  // [M, K/128] fp32
    torch::Tensor& w_scale,  // [N/128, K/128] fp32
    torch::Tensor& Y,        // [M, N] bf16
    int KBatch)               // split-K factor (1 = no split)
{
    int M = XQ.size(0);
    int N = WQ.size(0);
    int K = XQ.size(1);

    int StrideA = K;
    int StrideB = K;
    int StrideE = N;

    auto a_element_op   = PassThrough{};
    auto b_element_op   = PassThrough{};
    auto cde_element_op = PassThrough{};

    auto device_gemm = DefaultGemmInstance{};
    auto invoker     = device_gemm.MakeInvoker();
    auto argument    = device_gemm.MakeArgument(
        XQ.data_ptr(),
        WQ.data_ptr(),
        std::array<const void*, 0>{},
        reinterpret_cast<BF16*>(Y.data_ptr()),
        M, N, K,
        StrideA, StrideB,
        std::array<ck::index_t, 0>{},
        StrideE,
        reinterpret_cast<FP32*>(x_scale.data_ptr()),
        reinterpret_cast<FP32*>(w_scale.data_ptr()),
        a_element_op,
        b_element_op,
        cde_element_op);

    // Enable split-K
    if (KBatch > 1) {
        device_gemm.SetKBatch(&argument, KBatch);
        // Zero output for atomic add
        hipMemsetAsync(Y.data_ptr(), 0, M * N * sizeof(BF16),
                       at::hip::getCurrentHIPStream());
    }

    TORCH_CHECK(device_gemm.IsSupportedArgument(argument),
                "This GEMM config is not supported!");

    invoker.Run(argument,
                StreamConfig{at::hip::getCurrentHIPStream(), false /* timing */});
    return Y;
}

// ---- Pybind ----

PYBIND11_MODULE(TORCH_EXTENSION_NAME, m) {
    m.def("gemm_a8w8_blockscale", &custom_gemm_a8w8_blockscale,
          "Custom CK FP8 block-scale GEMM with split-K support",
          py::arg("XQ"), py::arg("WQ"),
          py::arg("x_scale"), py::arg("w_scale"),
          py::arg("Y"), py::arg("KBatch") = 1);
}

#endif // USE_ROCM
