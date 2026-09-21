variable "n" {
  type  = number
  const = true
}

variable "a" {
  type    = number
  const   = true
  default = 0
}

variable "b" {
  type    = number
  const   = true
  default = 1
}

module "p" {
  source = var.n > 0 ? "./" : "../stop"

  n = max(0, var.n - 1)
  a = var.b
  b = var.a + var.b
}

output "result" {
  value = var.n > 0 ? module.p.result : var.a
}
