terraform {
  required_version = ">= 1.15.0"
}

variable "n" {
  type     = number
  const    = true
  nullable = false

  validation {
    condition     = var.n >= 0 && floor(var.n) == var.n
    error_message = "nは0以上の整数にしてください。"
  }
}

module "fibonacci" {
  source = "./modules/fibonacci"

  n = var.n
}

output "result" {
  value = module.fibonacci.result
}
