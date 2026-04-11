# 11 - Sampling

## 功能

从 logits 分布中采样出下一个 token_id。

```
logits [1, 151936] (bf16)
    → temperature scaling
    → top-p / top-k 过滤
    → softmax → 概率分布
    → multinomial sampling
    → token_id (int)
```

## Kernel

| Kernel | cpu_op | 说明 |
|--------|--------|------|
| `mix_sample_outer_exponential_kernel<bf16, 1024, 64, 4, true>` | `aiter::mixed_sample_outer_exponential` | Fused sampling kernel |

模板参数:
- `bf16`: logits 数据类型
- `1024`: block size
- `64`: items per thread
- `4`: 向量宽度
- `true`: 启用某个优化

这是一个 **fused kernel**: 将 temperature scaling + top-p/top-k + softmax + sampling 合并到一次 kernel launch。

## 调用栈

```
model_runner.py:1586  postprocess()
  → Sampler.forward()                        # sampler.py:51
    → _temperature_sample()                  # sampler.py:91
      → aiter::mixed_sample_outer_exponential (C++)
```

## 源码位置

| 文件 | 行号 | 说明 |
|------|------|------|
| `atom/model_engine/model_runner.py` | 1586 | postprocess() 入口 |
| `atom/model_ops/sampler.py` | 51, 91 | Sampler forward + _temperature_sample |

## Sampling 算法

```
Gumbel-Max trick (exponential sampling):
  不做显式 softmax + multinomial sampling
  而是用 Gumbel noise 实现等效采样:

  1. logits = logits / temperature
  2. 加 Gumbel noise: logits += -log(-log(uniform_random))
  3. 应用 top-p / top-k mask
  4. argmax(logits) = sampled token_id

  优势: 一次 pass 即可完成, 无需排序 (top-p 近似)
```

## 耗时

| | 耗时 |
|--|------|
| 单次 | ~40 us |
| 占比 | ~0.8% |

## 相关: KV Indices Generate

采样后还有一个小 kernel:

| Kernel | 说明 |
|--------|------|
| `kv_indices_generate_kernel` | 为下一步 decode 准备 KV cache block_table 索引 |

这个 kernel 更新 block_table，确保下一个 token 的 KV 写入正确的 cache block。

## 备注

- Sampling 耗时很小 (0.8%)，不是性能瓶颈
- atom 的 fused sampling 避免了多次 kernel launch (相比 torch 的 softmax + multinomial)
- `outer_exponential` 是一种高效的近似 sampling 方法
- 支持 temperature, top-p, top-k 等参数
- batch sampling 时多个请求在一个 kernel 中并行处理
