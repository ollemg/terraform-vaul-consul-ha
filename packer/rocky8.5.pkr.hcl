
variable "iso_urls" {
  type    = list(string)
  default = ["https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-minimal.iso"]
}

variable "config_file" {
  type    = string
  default = "kickstart.cfg"
}

variable "cpu" {
  type    = string
  default = "6"
}

variable "destination_server" {
  type    = string
  default = "download.goffinet.org"
}

variable "disk_size" {
  type    = string
  default = "16384"
}

variable "headless" {
  type    = string
  default = "true"
}

variable "iso_checksum" {
  type    = string
  default = "4eb2ae6b06876205f2209e4504110fe4115b37540c21ecfbbc0ebc11084cb779"
}

variable "name" {
  type    = string
  default = "rocky"
}

variable "ram" {
  type    = string
  default = "4096"
}

variable "ssh_password" {
  type    = string
  default = "rockylinux"
}

variable "ssh_username" {
  type    = string
  default = "root"
}

variable "release" {
  type    = string
  default = "5"
}

variable "version" {
  type    = string
  default = "8"
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
  output_directory = "/home/ollemg/packer.d/"
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
