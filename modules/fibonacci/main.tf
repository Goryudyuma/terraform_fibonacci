variable "n" {
  description = "残りの更新回数。"
  type        = number
  const       = true
}

variable "a" {
  description = "現在の項。"
  type        = number
  const       = true
  default     = 0
}

variable "b" {
  description = "次の項。"
  type        = number
  const       = true
  default     = 1
}

module "next" {
  # n = 0 では子モジュールを持たない stop に切り替え、読み込みを止める。
  source = var.n > 0 ? "./" : "../stop"

  n = max(0, var.n - 1)
  a = var.b
  b = var.a + var.b
}

output "result" {
  description = "指定回数の更新後の項。"
  value       = var.n > 0 ? module.next.result : var.a
}
