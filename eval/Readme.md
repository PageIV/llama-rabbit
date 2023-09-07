# Evaluation
用MT-Bench进行测试
```
cd ../sft/FastChat/fastchat/llm_judge
```
然后流程同https://github.com/lm-sys/FastChat/tree/main/fastchat/llm_judge。但注意要使用openai keys，可在shell环境变量中设置
```
export OPENAI_API_KEY=<your api key>
```
测试还可以用athropic评估（自行设置，默认为gpt4），同样要是使用api key。
```
export ANTHROPIC_API_KEY=<your api key>
```