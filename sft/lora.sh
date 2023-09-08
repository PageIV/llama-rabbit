BASE_MODEL=$HOME/models/llama-2-13b-fp16
# LORA_MODEL=$HOME/llarb/sft/FastChat/scripts/checkpoints_qlora_13b_base
LORA_MODEL=$HOME/func_call/llama-2-13b-base-adapter
OUTPUT_TYPE=huggingface
OUTPUT_DIR=$HOME/models/llama-2-13b-fp16-lora-sharegpt4-ZHOUYOU


python merge_llama2_with_lora_low_mem.py \
    --base_model $BASE_MODEL \
    --lora_model $LORA_MODEL \
    --output_type $OUTPUT_TYPE \
    --output_dir $OUTPUT_DIR