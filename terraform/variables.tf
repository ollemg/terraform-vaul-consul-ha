variable "domainname" {
  type        = string
  default     = "ollemg.br"
  description = "Nome do dominio"
}

variable "baseimagediskpoll" {
  type        = string
  default     = "ssd"
  description = "Local do disco"
}

variable "networkname" {
  type        = string
  default     = "default"
  description = "Rede"
}

variable "sourceimage" {
  type        = string
  default     = "rocky8_5"
  description = "description"
}

variable "sourcepathimage" {
  type        = string
  default     = "/home/ollemg/packer.d"
  description = "Diretório da imagem do packer"
}

variable "vm_name" {
  type    = list(string)
  default = ["consul01", "vault01", ]
  # default     = ["consul01", "consul02", "consul03", "vault01", "vault02", "vault03"]
  description = "vms"
}