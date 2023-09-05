# llama-rabbit

<p align="center">
    <br>
    <img src="./imgs/MashiMaro.jpg" width="100"/>
    <br>
</p>


The Llama-rabbit is a combination of multiple open sources utilized for the purposes of fine-tuning, quantizing, serving, and evaluating on the schedule. The core features include:
- [**FastChat**](https://github.com/lm-sys/FastChat) for finetuning.
- [**AutoGPTQ**](https://github.com/PanQiWei/AutoGPTQ/tree/main) for quantizing
- [**Text-Generation-Inference**](https://github.com/huggingface/text-generation-inference) for serving

## Contents
- [Prerequiste](#prerequisite)
- [FastChat](#finetuning)

## prerequisite
### Docker(option)
You can acquire an image from [here](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/pytorch/tags)  
### Envs
```bash
# pull the repo and submodules
git clone --recursive https://github.com/PageIV/llama-rabbit.git

# create conda enviroment && setup pip source
conda create -n llama-rabbit python=3.9 -y
conda activate llama-rabbit
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# Install prerequisite dependencies
pip install -r requirements.txt

# Install FastChat 
pip install "sft/FastChat[model_worker]"

# Install flash-attention. Make sure you can access github and need some patience
pip install "flash-attn>=2.0" --no-build-isolation

# Install AutoGPTQ
pip install "quantization/AutoGPTQ"
```
If the downloading process is very slow, you can use .yml to install. For example, check https://github.com/Dao-AILab/flash-attention/releases for flash-atten and https://github.com/PanQiWei/AutoGPTQ/releases for auto-gptq. Then
```
pip install name.whl
```


## Finetuning
You can find the arguments for fine-tuning [here](sft/README.md).
```bash
cd sft/FastChat/scripts
sh <your scripts>
```


