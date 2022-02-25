variable "domain_name" {
  type        = string
  description = "Nome do dominio"
}

variable "baseimagediskpoll" {
  type        = string
  description = "Local do disco (virsh pool-list)"
  default     =  "default"
}

variable "networkname" {
  type        = string
  description = "Rede do KVM (sudo virsh net-list)"
  default     = "default"
}

variable "sourceimage" {
  type        = string
  description = "Nome da imagem"
}

variable "sourcepathimage" {
  type        = string
  description = "Diretório da imagem do packer"
  default     = "/var/lib/libvirt/pools/"
}

variable "vm_name" {
  type    = list(string)
  description = "Nome das VMS"
}

variable "username" {
  type          = string
  description   = "Usuário administador da VM"
  sensitive     = true
}

variable "password" {
  type          = string
  description   = "Senha do usuário administrador"
  sensitive     = true
}

variable "vm_memory" {
  type          = string
  description   = "Memória da VM"
}

variable "vm_vcpu" {
  type          = string
  description   = "vCPU da VM"
}

variable "libvirt_provider_uri" {
  type          = string
  default       = "qemu:///system"
}

variable "disk_format" {
  type          = string
  default       = "qcow2"
}