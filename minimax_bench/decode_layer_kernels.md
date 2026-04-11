# MiniMax-M2.5 单 Decode Layer Kernel 序列

level=3 (CUDA graph), bs=1 decode, PA-to-PA 切分, 305 层统计

## 总览

- **25 个 GPU kernel / layer** (compiled 模式, QK-norm/RoPE 已 fuse 为 Triton kernels)
- 数据来源: 运行时 trace, CUDA graph replay, 305 个标准层的 min/median/mean/max

| 配置 | Mean/layer (us) | × 62 layers (ms) | 通信占比 |
|------|----------------:|------------------:|---------:|
| TP=2 | 226.3 | 14.03 | 14.3% |
| TP=4 | 228.9 | 14.19 | 12.9% |
| TP=8 EP | 242.6 | 15.04 | 22.3% |

---

## Kernel 序列 (3 配置对比, median 值)

```
Pos  Kernel (简称)                  功能               TP=2    TP=4    TP=8EP   备注
                                                      med(us) med(us) med(us)
───  ─────────────────────────────  ──────────────── ─────── ─────── ─────── ─────────────────
 [0] pa_bf16_pertokenFp8_gqa8      Paged Attention    40.5    41.1    40.2   最大单 kernel, 不随 TP 变
 [1] dynamic_per_group_quant       o_proj FP8 quant    5.0     5.7     4.7
 [2] gemm_blockscale_preshuffle    o_proj GEMM        12.6     7.1     8.0   TP=2:[3072,1536] TP=4:[3072,768]
 [3] reduce_scatter_store          attn allreduce      9.5     7.1    14.2   TP=8EP 显著增大
 [4] local_device_load_rmsnorm     fused load+norm     5.6     5.7     5.6
 [5] triton_fused_copy             gate FP32 cast      5.5     5.6     5.0
 [6] Cijk_Alik_Bljk (rocBLAS)     gate GEMM          12.1    12.7    11.8   FP32, [3072,256]→router logits
 [7] grouped_topk_kernel           top-8 选择          7.0     7.1     6.9
 [8] MoeSortingKernel              token→expert 排序   8.2     8.5     9.1
 [9] dynamic_per_group_quant       MoE input quant     4.8     5.6     4.7
[10] kernel_moe_gemm (stage1)      up+gate fused      21.2    19.9    19.6   最大 MoE kernel
[11] dynamic_per_group_quant       intermediate quant  4.8     5.6     4.8
[12] kernel_moe_gemm (stage2)      down_proj           7.8     7.1     8.1
[13] reduce_scatter_store          MoE allreduce       9.2     7.1    13.6   TP=8EP 显著增大
[14] local_device_load_rmsnorm     fused load+norm     4.9     5.7     5.0
[15] dynamic_per_group_quant       qkv input quant     4.7     5.6     4.6
[16] gemm_blockscale_preshuffle    qkv_proj GEMM      10.5    18.5    18.5   TP=4/8: shape 变化导致更慢!
[17] triton_fused (QK-norm 1/6)    mean(x²) reduce     5.6     5.7     5.6   ┐
[18] triton_fused (QK-norm 2/6)    mean reduce         5.7     5.7     5.6   │ QK-norm
[19] triton_fused (QK-norm 3/6)    cat + allreduce     5.8     5.7     5.7   │ 6 个 fused Triton
[20] ncclDevKernel_Generic         NCCL allreduce     13.1    12.0    20.7   │ ← 通信大头
[21] triton_fused (QK-norm 4/6)    rsqrt+scale Q       5.6     5.7     5.7   │
[22] triton_fused (QK-norm 5/6)    rsqrt+scale K       5.6     5.6     4.9   ┘
[23] kn_entry_2c_sbhd_cached      RoPE apply          5.5     5.7     4.8
[24] reshape_and_cache_quant       KV cache FP8 写入   4.8     5.6     4.7
```

---

## 按模块汇总

```
模块                      TP=2 med(us)  TP=4 med(us)  TP=8EP med(us)  TP=2 占比
────────────────────────  ──────────── ──────────── ────────────────  ────────
Paged Attention [0]            40.5         41.1          40.2          17.9%
o_proj (quant+GEMM) [1-2]     17.6         12.8          12.7           7.8%
MoE pipeline [5-12]           71.4         72.1          70.0          31.6%
  ├─ gate GEMM [6]            12.1         12.7          11.8
  ├─ topk+sort [7-8]          15.2         15.6          16.0
  ├─ quant [9,11]              9.6         11.2           9.5
  ├─ stage1 GEMM [10]         21.2         19.9          19.6
  └─ stage2 GEMM [12]          7.8          7.1           8.1
QKV proj (quant+GEMM) [15-16] 15.2         24.1          23.1           6.7%
QK-norm+RoPE [17-23]          47.0         46.1          53.0          20.8%
  ├─ Triton fused [17-19,21-22] 28.3       28.4          27.5
  └─ NCCL allreduce [20]      13.1         12.0          20.7
KV cache write [24]             4.8          5.6           4.7           2.1%
Communication total            32.4         26.2          54.1          14.3%
  ├─ attn RS [3]                9.5          7.1          14.2
  ├─ MoE RS [13]                9.2          7.1          13.6
  └─ NCCL QK-norm [20]        13.1         12.0          20.7
Norm (fused load+norm) [4,14]  10.5         11.4          10.6           4.6%
FP8 Quant [1,9,11,15]         20.3         22.5          18.8           9.0%
```

---

## Min / Median / Max 对比 (TP=2)

```
Pos  Kernel                         Min    Med    Max    Max/Med  波动原因
───  ─────────────────────────────  ─────  ─────  ─────  ───────  ──────────
 [0] PA                             38.2   40.5   44.0    1.09   KV cache 长度变化
 [3] attn reduce_scatter             5.6    9.5   16.7    1.76   跨 XCD 通信抖动
[10] MoE stage1 GEMM                20.0   21.2   24.0    1.13   expert load 不均
[13] MoE reduce_scatter              5.7    9.2   16.0    1.74   跨 XCD 通信抖动
[20] NCCL allreduce                  9.8   13.1   18.8    1.44   网络竞争
 [2] o_proj GEMM                    11.5   12.6   14.4    1.14   稳定
[16] qkv_proj GEMM                   9.6   10.5   13.0    1.24   稳定
```

**通信 kernel 波动最大** (max/med ~1.7x), 计算 kernel 很稳定 (max/med ~1.1x)

---

## 优化建议 (按 median 耗时排序)

### 1. Paged Attention: 40.5 us (17.9%) ← 最大单 kernel

- GQA 8 heads, FP8 KV cache, decode bs=1
- 不随 TP 变化 (每个 rank 处理相同的 heads)
- **优化**: MTP (speculative decode) 增大 effective batch, amortize PA 开销
- **优化**: FlashDecoding / split-K attention 可能更适合长 KV (ISL=8k)

### 2. MoE stage1 GEMM: 21.2 us (9.4%)

- up_proj + gate_proj fused, CK MoE kernel
- stage1 比 stage2 慢 2.7x (output 大 2x + activation)
- **优化**: 检查 CK tile config 是否 tuned; 考虑 MFMA 指令选择

### 3. Communication: 32.4 us (14.3%)

- 3 次通信/layer: attn RS + MoE RS + NCCL QK-norm
- TP=8EP 下通信翻倍到 54 us (22%)
- **优化**: overlap RS 与下一个 kernel 的计算; 合并 attn RS + QK-norm NCCL

### 4. QKV proj GEMM: 10.5 us (TP=2) / 18.5 us (TP=4/8)

- TP=4/8 反而更慢! TP=2: [3072,2048], TP=4: [3072,1024]
- 小 N 导致 CK tile 效率低
- **优化**: 重新 tune CK gemm config for 小 N shapes

### 5. Gate GEMM (rocBLAS): 12.1 us (5.3%)

- FP32 精度 (router 需要), [1, 3072]×[3072, 256]
- **优化**: FP16 gate 如精度允许; 或 fuse gate+topk

### 6. QK-norm Triton: 28.3 us (12.5%)

- 5 个 Triton kernel 做 QK-norm (mean, pow, rsqrt, scale)
- **优化**: fuse 成 1 个 kernel (类似 RMSNorm 的实现方式)

### 7. FP8 Quant: 20.3 us (9.0%)

- 4 次独立量化 (o_proj, MoE input, MoE intermediate, qkv input)
- 每次 ~5 us, 但累计可观
- **优化**: fuse 到前一个 GEMM 的 epilogue

---

## 数据提取方法

从 level=3 运行时 trace 提取:
1. 获取 GPU kernel stream (cat=kernel), 按时间排序
2. 找到所有 `pa_bf16` 的位置 → 每个 PA 标记一层的开始
3. PA[i] 到 PA[i+1] 之间的 kernel = 一层的完整序列
4. 标准层 = gap=25 kernels 的层 (305/310 层, 排除首尾非标准层)
5. 对每个 kernel position 计算 min/median/mean/max
