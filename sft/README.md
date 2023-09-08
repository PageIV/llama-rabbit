# 🦙 Supervised finetuning (SFT)
Supervised finetuning (SFT) is very similar to standard language model finetuning on casual language tasks (e.g., WikiText-103). The main difference is from the dataset resources, SFT will collect high-quality query-answer pairs to finetune the model for human-perferred generation.

## 🏃‍♂️ How to train the model
We provide multiple scripts for training LLaMA2 which can be found in the 'sft/FastChat/scripts' directory. For example.

```bash
sft/FastChat/scripts/train_lora_7b_base.sh
 ```

to train a LLaMA2-7b model.


## 🍭 Models and Datasets
You can choose LLaMA1 or LLaMA2 as your base model, only need to upgrade your transformers library >= 4.31.0. Wait a moment, also check your VRAM capacity.
As for the dataset, we also used open-sourced datasets from the Huggingface Datasets, namely [sharegpt_gpt4](https://huggingface.co/datasets/openchat/openchat_sharegpt4_dataset/tree/main). We just chose the sharegpt_gpt4.json file which contain about 6k samples.



## ☀️ Prompt 
You can find prompt templates supported by Vicuna [here](https://github.com/PageIV/FastChat/blob/3c22afa5b28694183f04140903ace486255ff622/fastchat/conversation.py#L335C1-L335C23) or create your own prompt template.

We select `vicuna_v1.1` template
                                                                                                                                                                        |

## 🐰 Some arguments explanation and the largest trainable model
Most of the arguments used is clear if you have previous experience with fintuning decoder model.
 In this section, we provide some specific explanations of the arguments and their usage in train_lora.sh scripts

| Args                                                     | Explanation                                                                              | Note                                                                                                                                                                                       |
|--------------------------------------------------|------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------|
| --data_path                                           | Data used to finetune the model                                                          | You can specify other data source. However, the format maybe need to convert                                                                                 |
| --eval_data_path                                      | Data Used to eval model                                                   | You can specify  every epoch or a certain number of steps to use this data|
|--evaluation_strategy                                  | Not specified, no evaluation |['epoch', 'steps'] if you choose 'steps', --eval_steps needs to be specified|
|--eval_steps                                           | Needed only --evaluation_strategy is specified ||
|--save_strategy                                        | same as --evaluation_srategy| |
|--save_steps                                           | same as --eval_steps||
| --gradient_checkpoint                                    | Enable gradient checkpointing (also known as activation checkpointing)   for the model   | This can significantly reduce the training memory cost                                                                                                                                    |
| --lora_r                                               | lora rank                                                    | Usually, LoRA needs a larger learning rate for better convergence                                                                                                                                                                 |
| --lora_target_modules                                   | The scope to enable LoRA module.                                        | default is ["q_proj","k_proj","v_proj","o_proj","down_proj","gate_proj","up_proj"]    |
| --q_lora                                     | incompatible with `FSDP` and `ZeRO3` | This can | Using q_lora can improve LoRa performance
| --rope_scaling_type   |        Method used to increase context length|   ['linear', 'dynamic'], "linear" refer to  simple linear interpolation,  "dynamic" refer to NTK-Aware Scaled RoPE|
| --rope_scaling_factor |        Factor model length needs to be extended| float(math.ceil(model_max_length / max_position_embeddings))|

An important consideration for the user is to determine the maximum model size that can be trained using the current system. Another significant issue is determining the optimal configuration for models of different scales. Below, I will provide some settings I have used and the related experiences

|Model Size| Lora Rank | Stage | Max Batch Size | Qlora? |
|----------|-----------|-------|----------------|--------|
| 7b       | 8         | zero2 | 16             | true   |
| 13b      | 16        | zero2 | 8              | true   |
| 70b      | 64        | zero3 | 2              | false  |

## 🏒 Context Length 
"The extrapolation of model length is a widely discussed area of research. The ability to extrapolate model length to some extent affects the application scenarios of the model. Research(e.g., ALiBi, KERPLE) on length extrapolation has evolved from previous `local attention mechanisms`  to forms such as **linear interpolation** and **NTK-Aware RoPE**. The latter two is characterized by simplicity of implementation, wide applicability, and good performance.

These two methods are also the two approaches currently implemented in Transformers libraries."
### Linear Interpolation
[LMSYS ORG Blog](https://lmsys.org/blog/2023-06-29-longchat/) 


### NTK-Aware RoPE
[NTK Method Reddit](https://www.reddit.com/r/LocalLLaMA/comments/14lz7j5/ntkaware_scaled_rope_allows_llama_models_to_have/) 

> 中文读者看 苏剑林这篇[博客](https://kexue.fm/archives/9675)


## 👀  Others
Haven't decided what to write