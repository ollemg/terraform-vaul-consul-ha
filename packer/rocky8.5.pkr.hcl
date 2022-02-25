
variable "iso_urls" {
  type    = list(string)
}

variable "config_file" {
  type    = string
}

variable "cpu" {
  type    = string
}

variable "disk_size" {
  type    = string
}

variable "headless" {
  type    = string
}

variable "iso_checksum" {
  type    = string
}

variable "name" {
  type    = string
}

variable "ram" {
  type    = string
}

variable "ssh_password" {
  type    = string
}

variable "ssh_username" {
  type    = string
}

variable "release" {
  type    = string
}

variable "version" {
  type    = string
}
source "qemu" "rocky8_5" {
  accelerator      = "kvm"
  boot_command     = ["<up><wait><tab><wait> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.config_file}<enter><wait>"]
  boot_wait        = "40s"
  disk_interface   = "virtio"
  disk_cache       = "none"
  disk_compression = true
  disk_discard     = "unmap"
  disk_size        = "${var.disk_size}"
  format           = "qcow2"
  headless         = false
  http_directory   = "kickstart"
  http_port_max    = 10089
  http_port_min    = 10082
  iso_checksum     = "${var.iso_checksum}"
  iso_urls         = "${var.iso_urls}"
  net_device       = "virtio-net"
  output_directory = "output"
  qemuargs         = [["-m", "${var.ram}M"], ["-smp", "cpus=${var.cpu}"]]
  shutdown_command = "shutdown -P now"
  ssh_port         = 22
  ssh_password     = "${var.ssh_password}"
  ssh_username     = "${var.ssh_username}"
  ssh_wait_timeout = "1200s"
  vm_name          = "${var.name}${var.version}_${var.release}"
}

build {
  sources = ["source.qemu.rocky8_5"]


  provisioner "shell" {
    inline       = ["dnf clean all", "systemctl enable --now cockpit.socket"]
    pause_before = "5s"
  }

}
