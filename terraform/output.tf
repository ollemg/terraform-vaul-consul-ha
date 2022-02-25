# Output Server IP

output "ip_address" {
  value = libvirt_domain.libvirt_vm.*.network_interface.0.addresses.0
  description = "Endereços IPs"
}

output "hostname" {
  value = libvirt_domain.libvirt_vm.*.name
  description = "Hostname"
}

output "total_servers" {
  value = length(var.vm_name)
  description = "conta o numero de servidores"
}