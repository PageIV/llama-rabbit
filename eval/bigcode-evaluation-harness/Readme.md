# 安装
由于使用了一些旧的package(例如pyext，其对inspect的用法在python 3.10之后弃用。此外，ds-1000 benchmark也要python 3.7.10)作为依赖，需要建一个旧版python的环境
```
conda create -n bigcode-eval python=3.7.10 -y
conda activate bigcode-eval
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple # 加速pip的安装
```

使用时记得挂代理登陆hugging face，否则数据集下不下来。
```
huggingface-cli login
```

# 评估
利用hugging face上的[code eval](https://huggingface.co/spaces/evaluate-metric/code_eval) metric来估计pass@k。但其内核也是去运行生成的code（见[源代码](https://huggingface.co/spaces/evaluate-metric/code_eval/blob/abf7d37d80d7379e0bef970e9ba1b76c54169a66/code_eval.py)）。

```
with ThreadPoolExecutor(max_workers=num_workers) as executor:
    futures = []
    completion_id = Counter()
    n_samples = 0
    results = defaultdict(list)

    for task_id, (candidates, test_case) in enumerate(zip(predictions, references)):
        for candidate in candidates:
            test_program = candidate + "\n" + test_case
            args = (test_program, timeout, task_id, completion_id[task_id])
            future = executor.submit(check_correctness, *args)
            futures.append(future)
            completion_id[task_id] += 1
            n_samples += 1

    for future in as_completed(futures):
        result = future.result()
        results[result["task_id"]].append((result["completion_id"], result))
```
这里的with ThreadPoolExecutor的处理与human-eval的脚本类似。