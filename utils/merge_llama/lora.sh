BASE_MODEL=<base model path>
# LORA_MODEL=$HOME/llarb/sft/FastChat/scripts/checkpoints_qlora_13b_base
LORA_MODEL=<lora adapter path>
OUTPUT_TYPE=<huggingface/pth>
OUTPUT_DIR=<output dir path>


python merge_llama2_with_lora_low_mem.py \
    --base_model $BASE_MODEL \
    --lora_model $LORA_MODEL \
    --output_type $OUTPUT_TYPE \
    --output_dir $OUTPUT_DIR