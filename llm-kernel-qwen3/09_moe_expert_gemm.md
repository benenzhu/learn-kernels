# 09 - MoE Expert GEMM (CK 2-Stage Fused)

## 功能

MoE 的核心计算: 将排序后的 token 分发给各 expert 做 MLP 计算。
每个 expert 是一个标准的 SwiGLU MLP: gate_up → SiLU → down。

```
对每个 expert_i (被选中的):
  tokens_i = sorted_tokens[expert_i 的 token 集合]

  Stage 1 (gate_up + SiLU):
    gate = tokens_i @ W_gate_i     # [n_i, 2048] × [2048, 6144]
    up   = tokens_i @ W_up_i       # [n_i, 2048] × [2048, 6144]
    inter = SiLU(gate) * up         # [n_i, 6144]

  Stage 2 (down):
    out_i = inter @ W_down_i       # [n_i, 6144] × [6144, 2048]
    → 加权 (× sorted_weight) 后累加回 hidden
```

## Kernel (2 个, CK Composable Kernel)

| Kernel | cpu_op | 说明 |
|--------|--------|------|
| `ck::kernel_moe_gemm<...>` (stage1) | `aiter::ck_moe_stage1` | gate_up GEMM + SiLU activation |
| `ck::kernel_moe_gemm<...>` (stage2) | `aiter::ck_moe_stage2` | down GEMM + weighted accumulate |

两个 kernel 用的是 CK (Composable Kernel) 模板实例化，不同之处:
- Stage 1: 输入 hidden → 输出 intermediate, 内含 SiLU activation
- Stage 2: 输入 intermediate → 输出 hidden, 内含 topk weight 加权

## 调用栈

### Stage 1 (gate_up):
```
FusedMoE.forward()                           # moe.py:2540
  → moe_forward() → forward_impl() → apply()
    → fused_moe()                           # aiter/fused_moe.py:119
      → fused_moe_()                        # aiter/fused_moe.py:206
        → fused_moe_2stages()              # aiter/fused_moe.py:1102
          → ck_moe_stage1()                # aiter/fused_moe.py:1688
            → ck_moe_stage1_fwd()          # aiter/ops/moe_op.py:532
              → aiter::ck_moe_stage1 (C++)
```

### Stage 2 (down):
```
(同上路径到 fused_moe_2stages)
  → ck_moe_stage2_fwd()                   # aiter/ops/moe_op.py:576
    → aiter::ck_moe_stage2 (C++)
```

## 源码位置

| 文件 | 行号 | 说明 |
|------|------|------|
| `aiter/fused_moe.py` | 1102 | fused_moe_2stages() 两阶段调度 |
| `aiter/fused_moe.py` | 1688 | ck_moe_stage1() |
| `aiter/ops/moe_op.py` | 532, 576 | CK stage1/stage2 Python 入口 |
| CK C++ templates | - | `ck::kernel_moe_gemm` 模板 |

## GEMM Shape

| Stage | M (per expert) | N | K | 说明 |
|-------|---------------|---|---|------|
| Stage 1 | ~n_i (变长) | 6144×2=12288 | 2048 | gate+up 合并, 包含 preshuffle |
| Stage 2 | ~n_i (变长) | 2048 | 6144 | down projection |

实际 CK 实现中:
- `intermediate_size = 768` 在 config 中 (这是 block-level 的 intermediate per expert group)
- `block_m = 128` (prefill) 或 `block_m = 32` (decode)

## 2-Stage 执行策略

```
选择依据 (aiter/fused_moe.py):
  if estimated_m_per_expert > threshold:
      use 2-stage (default)    # 大多数情况
  else:
      use 1-stage              # 极少 token 时

2-stage 的优势:
  Stage 1: 所有 expert 的 gate_up GEMM 在一个 kernel 中完成
           → 一次 kernel launch 覆盖所有 128 expert
           → 通过 sorted_expert_ids 实现 expert-level batching
  Stage 2: 同理, 所有 expert 的 down GEMM 一次完成

对比 1-stage:
  所有操作 fuse 在单个 kernel 中, 但需要更多 shared memory
```

## 耗时 (最大头! 31% 总时间)

| Stage | Prefill (us) | Decode (us) | 说明 |
|-------|-------------|-------------|------|
| Stage 1 | 60-90 | 23-24 | gate_up + SiLU |
| Stage 2 | 30-48 | 8 | down + accumulate |
| **每层合计** | 90-138 | 31-32 | |
| **每步合计 (48层)** | ~5400 | ~1500 | |

## 为什么 Expert GEMM 这么耗时?

```
1. Expert 数量多 (128 个), 每个 expert 独立权重
2. 每个 token 激活 8 个 expert → 实际计算量 = 8× 单 expert MLP
3. weight 总量: 128 × (2048×6144×2 + 6144×2048) × 2B ≈ 18.4 GB
4. Prefill 时 per-expert M 可能不均匀 (load imbalance)
5. Decode 时 M=8 (1 token × 8 experts), 极度 memory-bound
```

## Preshuffle

CK MoE GEMM 支持 `preshuffle`:
- 权重在加载模型时预 shuffle 到 CK 需要的内存布局
- 避免运行时做数据重排
- 配置: `bpreshuffle=True` 在 `fused_moe_2stages` 中

## 备注

- 这是整个推理流程中**耗时占比最大**的 kernel (31%)
- CK (Composable Kernel) 是 AMD 的高性能 kernel 库，类似 CUTLASS
- SiLU activation: `SiLU(x) = x * sigmoid(x)`
- SwiGLU: `SwiGLU(x) = SiLU(gate(x)) * up(x)`
- 权重量化 (如 FP8/FP4 expert weights) 可以进一步优化这部分
