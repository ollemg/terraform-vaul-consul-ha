variable "domainname" {
  type        = string
  description = "Nome do dominio"
}

variable "baseimagediskpoll" {
  type        = string
  description = "Local do disco"
}

variable "networkname" {
  type        = string
  description = "Rede"
}

variable "sourceimage" {
  type        = string
  description = "Nome da imagem"
}

variable "sourcepathimage" {
  type        = string
  description = "Diretório da imagem do packer"
}

variable "vm_name" {
  type    = list(string)
  description = "Nome das VMS"
}

variable "username" {
  type          = string
  description   = "VM username"
}

variable "password" {
  type          = string
  description   = "VM username"
}

variable "vm_memory" {
  type          = string
  description   = "VM memória"
}

variable "vm_vcpu" {
  type          = string
  description   = "VM cpu"
}