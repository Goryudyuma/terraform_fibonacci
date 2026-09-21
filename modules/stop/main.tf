# fibonacci と同じ入出力を受け持つ、再帰読み込みの終端。
variable "n" {
  type  = number
  const = true
}

variable "a" {
  type  = number
  const = true
}

variable "b" {
  type  = number
  const = true
}

output "result" {
  # 呼び出し元は n = 0 のとき自身の a を返すため、この値は計算には使わない。
  value = var.a
}
