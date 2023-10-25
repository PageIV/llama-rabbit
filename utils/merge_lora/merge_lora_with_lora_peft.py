import argparse

from peft import PeftModel
from transformers import AutoTokenizer, AutoModelForCausalLM

parser = argparse.ArgumentParser(description="Using peft to merge lora with base model. \
                                 Whereas is using high memory and high gpu memory.")

parser.add_argument("--base_model_path", type=str, default=None, required=True)
parser.add_argument("--lora_path", type=str, default=None, required=True)
parser.add_argument("--output_path", type=str, default=None, required=True)


def merge_lora_with_base_model(base_model_path, lora_path, output_path):
    tokenizer = AutoTokenizer.from_pretrained(
        base_model_path,
        trust_remote_code=True,
        use_fast=False
        )
    base_model = AutoModelForCausalLM.from_pretrained(
        base_model_path,
        torch_dtype="auto",
        trust_remote_code=True,
        device_map="auto"
    )

    peft_model = PeftModel.from_pretrained(base_model, lora_path)

    model = peft_model.merge_and_unload()
    model.save_pretrained(output_path)
    tokenizer.save_pretrained(output_path)


if __name__ == "__main__":
    args = parser.parse_args()
    merge_lora_with_base_model(args.base_model_path, args.lora_path, args.output_path)

