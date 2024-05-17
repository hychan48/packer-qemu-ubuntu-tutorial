/**
* Sample breakpoint
*/
variable "enable_debug" {
  type = bool
  default = false
}
source "file" "debug" {
  content = "debug"
  target = "output/debug.txt"
}

build {
  name="debug"
  sources=["file.debug"]
  provisioner "shell-local" {
    inline = [
      "echo 'echo debugging...'",
      "echo ${basename("file:///var/lib/qemu/images/ubuntu-24.04-live-server-amd64.iso")}",
      "echo ${basename("http://releases.ubuntu.com/24.04/ubuntu-24.04-live-server-amd64.iso")}",
      # getchecksum
      "echo ${lookup(var.map_ubuntu_iso_checksum,"ubuntu-24.04-live-server-amd64.iso","default")}",
      "echo ${lookup(var.map_ubuntu_iso_checksum,basename("http://releases.ubuntu.com/24.04/ubuntu-24.04-live-server-amd64.iso"),"none")}",
      "echo ${lookup(var.map_ubuntu_iso_checksum,basename(var.uri_ub24_server),"none")}", // this command 
      "echo others checksums",
      "echo ${lookup(var.map_ubuntu_iso_checksum,basename("ubuntu-22.04.4-live-server-amd64.iso"),"none")}", // this command 
      "echo ${lookup(var.map_ubuntu_iso_checksum,basename(var.uri_ub22_server),"none")}", // this command 
      "echo ${lookup(var.map_ubuntu_iso_checksum,"ubuntu-24.04-desktop-amd64.iso","default")}",
      "echo ${lookup(var.map_ubuntu_iso_checksum,basename(var.uri_ub24_desktop),"none")}", // this command 
    ]
  }
  provisioner "shell-local" {
    inline = [
      "echo ${var.host_port_min + 1}" # works
    ]
  }
  provisioner "breakpoint" {
    disable = false
    note    = "THIS IS A BREAKPOINT"
  }
}