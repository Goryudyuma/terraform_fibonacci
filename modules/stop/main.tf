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
  value = var.a
}
