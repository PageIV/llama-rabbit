# 安装
待补充，把human-eval的项目submodule到这里，并写下如何安装

# 评估
执行代码
```
with ThreadPoolExecutor(max_workers=n_workers) as executor:

    futures = []
    completion_id = Counter()
    n_samples = 0
    results = defaultdict(list)

    print("Reading samples...")
    for sample in tqdm.tqdm(stream_jsonl(sample_file)):
        task_id = sample["task_id"]
        completion = sample["completion"]
        args = (problems[task_id], completion, full, timeout, completion_id[task_id])
        future = executor.submit(check_correctness, *args)
        futures.append(future)
        completion_id[task_id] += 1
        n_samples += 1

    assert len(completion_id) == len(problems), "Some problems are not attempted."

    print("Running test suites...")
    for future in tqdm.tqdm(as_completed(futures), total=len(futures)):
        result = future.result()
        results[result["task_id"]].append((result["completion_id"], result))
```