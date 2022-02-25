# Definição do volume
# count faz um loop para criar quantas vms forem configuradas na variavel vm_name
resource "libvirt_volume" "rocky8" {
  count  = length(var.vm_name)
  name   = "${var.vm_name[count.index]}.qcow2"
  pool   = var.baseimagediskpoll # List storage pools using virsh pool-list
  source = "${var.sourcepathimage}/${var.sourceimage}"
  format = var.disk_format
}

# Define KVM domain to create
resource "libvirt_domain" "libvirt_vm" {
  # for_each = var.vm_name 
  count  = length(var.vm_name)
  name   = var.vm_name[count.index]
  memory = var.vm_memory
  vcpu   = var.vm_vcpu

  network_interface {
    network_name   = var.networkname # List networks with virsh net-list
    wait_for_lease = true
    hostname       = var.vm_name[count.index]
  }

  disk {
    volume_id = libvirt_volume.rocky8[count.index].id
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
  provisioner "remote-exec" {
    connection {
      host        = self.network_interface.0.addresses.0
      type        = "ssh"
      user        = "${var.username}"
      password    = "${var.password}"
      timeout     = "1m"
      # private_key = file(var.vm_ssh_private_key)
    }
    inline = [ "hostnamectl set-hostname ${var.vm_name[count.index]}"  ]
  }
}
