# Definição do volume
# count faz um loop para criar quantas vms forem configuradas na variavel vm_name
resource "libvirt_volume" "rocky8" {
  count  = length(var.vm_name)
  name   = "${var.vm_name[count.index]}.qcow2"
  pool   = var.baseimagediskpoll # List storage pools using virsh pool-list
  source = "${var.sourcepathimage}/${var.sourceimage}"
  format = "qcow2"
}

# Define KVM domain to create
resource "libvirt_domain" "libvirt_vm" {
  count  = length(var.vm_name)
  name   = var.vm_name[count.index]
  memory = "1024"
  vcpu   = 1

  network_interface {
    network_name   = "default" # List networks with virsh net-list
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
}



