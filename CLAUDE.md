# Bench Kernels - Project Conventions

## Project Structure

```
bench_kernels/<kernel_name>/
├── readme.md              # 结论 + 数据 + 使用说明
├── test_<name>.py         # benchmark 脚本（CUDA graph replay）
├── profile_<name>.py      # profiler 采集脚本
└── <name>_source_trace.md # 源码调用链
```

## Benchmark 方法

- **首选 CUDA Graph Replay**: 避免 CPU kernel launch overhead（3~5 us），用 graph capture 100 次不同输入，replay 后除以 100 得纯 GPU kernel 时间
- **快速验证可用 `do_bench`**: 但要意识到包含 CPU launch overhead
- `do_bench` 用 `return_mode="median"` 取中位数
- 单位换算: `do_bench` 返回 ms，乘 1000 转 us，再除 `num_inputs` 得单次
- 创建不同输入避免 cache 命中导致虚高；使用固定 buffer + `copy_` 喂不同数据

## 源码调用链格式

- 用缩进列表表示调用层级：`[函数名](文件路径:行号)  # 注释`
- Python 路径用包名开头: `aiter/ops/quant.py:258`
- C++ 路径用包名开头: `aiter_meta/csrc/kernels/quant_kernels.cu:20`

## 对比分析表格缩写

| 缩写 | 含义 |
|------|------|
| CK q+g | CK quant kernel + CK GEMM kernel（端到端） |
| CK gemm | CK GEMM only（activation 已预量化） |
| fused | Fused quant+gemm（单 kernel） |
| BF16 | `torch.mm` BF16 baseline |
| fused/CK | CK 端到端 / fused 耗时比（>1 表示 fused 更快） |

## Benchmark 结论应包含

1. 各路径的绝对耗时
2. quant overhead 占比（CK e2e - CK gemm only）
3. graph replay vs 普通 do_bench 的差异（反映 CPU launch overhead）
4. 是否有 tuned config（影响性能的重要因素）
5. shape 特点对性能的影响（太小 -> launch-bound, 太大 -> compute-bound）
