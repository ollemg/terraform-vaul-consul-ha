libvirt_provider_uri = "qemu:///system"

libvirt_resource_pool_location = "/var/lib/libvirt/pools/"

vm_image_source = "https://cloud.centos.org/centos/9-stream/x86_64/images/CentOS-Stream-GenericCloud-9-20220217.0.x86_64.qcow2"

########################
# Global configuration #
########################

vm_memory="1024"
vm_vcpu=1

domainname="ollemg.br"

baseimagediskpoll="ssd"

networkname="default"

sourceimage="rocky8_5"

sourcepathimage="../packer/output/"

vm_name= ["consul01", "consul02", "consul03", "vault01", "vault02", "vault03"]

username="root"

password="rockylinux"
