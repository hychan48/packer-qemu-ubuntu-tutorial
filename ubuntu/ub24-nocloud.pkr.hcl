/**
* Qemu Plugin ref - Shared Variables
* https://developer.hashicorp.com/packer/integrations/hashicorp/qemu/latest/components/builder/qemu
*/

// Build Sources
// build source template at the bottom qemu.nocloud


// source "qemu.nocloud" "ub22" {
//   name="ub22-server"
//   vm_name = "${source.name}"
//   http_directory = abspath("${var.output_directory}/http-${source.name}")
//   # todo update url to use a variable
//   iso_url = "file:///var/lib/qemu/images/ubuntu-22.04.4-live-server-amd64.iso"
//   iso_checksum ="45f873de9f8cb637345d6e66a583762730bbea30277ef7b32c9c3bd6700a32b2" # temporary fix later

// }
/* builds */

build {
  name="ub24"
  /* 1. ub24-server */
  source "qemu.nocloud" {
    name="ub24-server"
    iso_url = var.uri_ub24_server
    iso_checksum =lookup(var.map_ubuntu_iso_checksum,basename(var.uri_ub24_server),"none")
    
    host_port_min= "${var.host_port_min}" #3455
    host_port_max= "${var.host_port_min}" #3455
    vnc_port_min= "${var.vnc_port_min}" #5905
    vnc_port_max= "${var.vnc_port_min}" #5905
    vm_name = "${source.name}"
    http_directory = abspath("${var.output_directory}/http-${source.name}")
    output_directory = abspath("${var.output_directory}/${source.name}")
  }
  /* 2. ub24-desktop */
  source "qemu.nocloud" {
    name="ub24-desktop"
    iso_url = var.uri_ub24_desktop
    iso_checksum =lookup(var.map_ubuntu_iso_checksum,basename(var.uri_ub24_desktop),"none")

    host_port_min= "${var.host_port_min + 1}" #3456
    host_port_max= "${var.host_port_min + 1}" #3456
    vnc_port_min= "${var.vnc_port_min + 1}" #5906
    vnc_port_max= "${var.vnc_port_min + 1}" #5906
    vm_name = "${source.name}"
    http_directory = abspath("${var.output_directory}/http-${source.name}")
    output_directory = abspath("${var.output_directory}/${source.name}")
  }
  /* 3. ub22-server */
  source "qemu.nocloud" {
    name="ub22-server"
    iso_url = var.uri_ub22_server
    iso_checksum =lookup(var.map_ubuntu_iso_checksum,basename(var.uri_ub22_server),"none")
    
    host_port_min= "${var.host_port_min + 2}" #3457
    host_port_max= "${var.host_port_min + 2}" #3457
    vnc_port_min= "${var.vnc_port_min + 2}" #5907
    vnc_port_max= "${var.vnc_port_min + 2}" #5907

    vm_name = "${source.name}"
    http_directory = abspath("${var.output_directory}/http-${source.name}")
    output_directory = abspath("${var.output_directory}/${source.name}")
  }
  

  /* provisioners */
  # dev provisioner to backup qemu.sh command
  provisioner "shell-local" {
    inline = [
      "echo building source name '${source.name}'",
      //fixme
      "ps aux | grep qemu-system | grep '${source.name}' | tee ${var.output_directory}/${source.name}/qemu.sh",
    ]
  }
  # Wait till Cloud-Init has finished setting up the image on first-boot
  provisioner "shell" {
    inline = [
      "echo Packer provisioning through ssh...",
      "echo whoami and cloudinit; whoami ; who",
      "echo setting permissions...",
      "echo cloud-init status... waiting",
      "sudo cloud-init status --wait || sudo cloud-init status --long"
    ]
}

  # Finally Generate a Checksum (SHA256) which can be used for further stages in the `output` directory
// post-processor "checksum" {
//   checksum_types      = ["sha256"]
//   output              = "${local.output_dir}/${local.vm_name}.{{.ChecksumType}}"
//   keep_input_artifact = true
// }
}

/* */
// also needs to change or not
/**
* Qemu Plugin ref - Shared Variables
* https://developer.hashicorp.com/packer/integrations/hashicorp/qemu/latest/components/builder/qemu
*/
source "qemu" "nocloud" {
  // output_directory = abspath("${var.output_directory}/${source.name}")
  // iso_url = "file:///var/lib/qemu/images/ubuntu-24.04-live-server-amd64.iso" # to be set
  // iso_checksum ="8762f7e74e4d64d72fceb5f70682e6b069932deedb4949c6975d0f0fe0a91be3" # temporary fix later
  // vm_name = "${local.vm_name}"
  // vm_name = "${source.name}"

  // iso_url = "file:///var/lib/qemu/images/ubuntu-24.04-live-server-amd64.iso"
  // iso_url = "${var.ubuntu_iso_file}"
  // iso_checksum ="${var.ubuntu_iso_checksum}"

  # Boot Commands when Loading the ISO file with OVMF.fd file (Tianocore) / GrubV2
  # basically type in the command. ds=nocloud is for nocloud prov
  boot_command = [
    "<spacebar><wait><spacebar><wait><spacebar><wait><spacebar><wait><spacebar><wait>",
    "e<wait>",
    "<down><down><down><end>",
    " autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
    "<f10>"
  ]
    // " hostname={{ .Name }}",

  boot_wait = "5s"

  # QEMU specific configuration
  # https://developer.hashicorp.com/packer/integrations/hashicorp/qemu/latest/components/builder/qemu
  memory           = "${var.memory}" # "4096"
  cpus             = "${var.cpus}" # "2"
  # use none here if not using KVM
  accelerator      = "${var.accelerator}" 

  format            = "${var.format}"

  vnc_bind_address="${var.host_hostname}"
  // vnc_port_min= "${var.vnc_port_min}" #5905, re-using the same port...
  // vnc_port_max= "${var.vnc_port_max}" #5906 # hmm

# todo move
  // efi_firmware_code = "/usr/share/OVMF/OVMF_CODE_4M.fd" # 4M
  // efi_firmware_vars = "/usr/share/OVMF/OVMF_VARS_4M.fd"
  // efi_boot = true
  efi_boot = "${var.efi_boot}"
  efi_firmware_code = "${var.efi_firmware_code}"
  efi_firmware_vars = "${var.efi_firmware_vars}"

  disk_interface    = "virtio" # default set for clarity and no guessing
  vtpm = false
  qmp_enable = var.qmp_enable
  cpu_model = "host"
  // disk_size = "${var.disk_size}" # "40G"
  # Final Image will be available in `output/packerubuntu-*/`


  # SSH configuration so that Packer can log into the Image
  // host_port_min = "${var.host_port_min}" # 3455 # re-using same port...
  // host_port_max = "${var.host_port_max}" # 3457
  ssh_username     = "${var.ssh_username}" # ubuntu
  ssh_password     = "${var.ssh_password}" # ubuntu

  # ssh is default communicator
  pause_before_connecting = "${var.pause_before_connecting}"
   # "3m" # default starts right away...
  ssh_timeout      = "${var.ssh_timeout}"
  shutdown_command = "sudo -S shutdown -P now"
  headless         = "${var.headless}" # NOTE: set this to true when using in CI Pipelines
  use_default_display = false
  vga = "qxl" # spice uses qxl
  display = "spice-app"
  qemuargs = [
    [ "-usb"],
    [ "-device", "usb-kbd"],
    //removed the spice and guest agent
  ]
  machine_type = "q35"
}



