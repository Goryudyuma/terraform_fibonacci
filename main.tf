terraform {
  required_version = ">= 1.15.0"
}

variable "n" {
  description = "計算するフィボナッチ数列の項番号（0以上の整数）"
  type        = number
  const       = true
  nullable    = false

  validation {
    condition     = var.n >= 0 && floor(var.n) == var.n
    error_message = "nは0以上の整数にしてください。"
  }
}

module "f" {
  source = "./modules/fibonacci"

  n = var.n
}

output "result" {
  description = "フィボナッチ数列の第n項（第0項は0、第1項は1）"
  value       = module.f.result
}
