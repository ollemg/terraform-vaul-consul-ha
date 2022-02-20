# Output Server IP
output "vms" {
  value = [
    libvirt_domain.libvirt_vm.0.name,
    libvirt_domain.libvirt_vm.0.network_interface.0.addresses.0,
    libvirt_domain.libvirt_vm.1.name,
    libvirt_domain.libvirt_vm.1.network_interface.0.addresses.0,
    #libvirt_domain.libvirt_vm.2.name, 
    #libvirt_domain.libvirt_vm.2.network_interface.0.addresses.0,
    #libvirt_domain.libvirt_vm.3.name, 
    #libvirt_domain.libvirt_vm.3.network_interface.0.addresses.0,
    #libvirt_domain.libvirt_vm.4.name, 
    #libvirt_domain.libvirt_vm.4.network_interface.0.addresses.0,
    #libvirt_domain.libvirt_vm.5.name, 
    #libvirt_domain.libvirt_vm.5.network_interface.0.addresses.0
  ]
  description = "VMs"
}