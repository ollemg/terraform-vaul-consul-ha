# Output Server IP

output "vms" {
  # value = [
  #   libvirt_domain.libvirt_vm.*.network_interface.0.addresses.0
  # ]
  value = libvirt_domain.libvirt_vm.*.network_interface.0.addresses.0
  description = "VMs"
}

output "names" {
  value = libvirt_domain.libvirt_vm.*.name
}