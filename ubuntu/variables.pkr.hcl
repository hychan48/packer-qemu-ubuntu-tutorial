/**
* Qemu Plugin ref - Shared Variables
* https://developer.hashicorp.com/packer/integrations/hashicorp/qemu/latest/components/builder/qemu
*/
packer {
  required_version = ">= 1.10.3"

  required_plugins {
    qemu = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/qemu"
    }
  }
}
## Variable will be set via the Command line defined under the `vars` directory
## Debugging ports
/**
 Ip is used for
vnc_bind_address
spice_bind_address
ssh_host
*/
variable "host_hostname" {
  type    = string
  // default="127.0.0.1"
  /*
  PKR_VAR_host_hostname ?= $(shell hostname -I | awk '{print $$1}')
  export PKR_VAR_host_hostname
  */

  default="localhost"
}
variable "output_directory" {
  type    = string
  //export PKR_VAR_output_directory=output
  default = "output"
}
variable "host_port_min" {
  type    = number
  default = 3455 # default is 2222
}
variable "host_port_max" {
  type    = number
  default = 3457 # default is 4444
}
variable "vnc_port_min" {
  type    = number
  default = 5905 # default is 5900 to 5999
}
variable "vnc_port_max" {
  type    = number
  default = 5907 # default is 5900 to 5999
}
// host Spice
// is kinda hardcoded right now
variable "spice_port" {
  type    = number
  default = 5900 # default is 5900 to 5999
  //not used atm
}
/** cpu and memory */
variable "cpus" {
  type    = number
  default = 2
}
variable "memory" {
  type    = number
  default = 4096
}
variable "qmp_enable" {
  type    = bool
  default = true
  // default = false

}

# user name to create with sudo and admin rights
# todo not implemented yet
/**
yq e '.autoinstall.user-data.users[2]' http/ubuntu-server-live/user-data
yq e '.autoinstall.user-data.chpasswd.users[2].name' http/ubuntu-server-live/user-data

*/
variable "username" {
  type    = string
  default = "jason"
}
variable "username_password" {
  type    = string
  default = "jason"
  // type text
}


## Others
variable "headless" {
  type    = bool
  default = true
}

variable "accelerator" {
  type    = string
  default = "kvm"
  # default = "none"
}
# ssh / connection
variable "pause_before_connecting" {
  type    = string
  default = "0m" # useless.. it waits till it's connected first
}
variable "ssh_timeout" {
  type    = string
  default = "60m"
  # default = "none"
}

// same as password
variable "ssh_password" {
  type    = string
  default = "ubuntu"
}
//i wouldn't change this
variable "ssh_username" {
  type    = string
  default = "ubuntu"
}
// create a new user bellow

# efi - fix later to make it smarter... wouldnt change this either
variable "efi_firmware_code" {
  type    = string
  default = "/usr/share/OVMF/OVMF_CODE_4M.fd"
}
variable "efi_firmware_vars" {
  type    = string
  default = "/usr/share/OVMF/OVMF_VARS_4M.fd"
}
variable "efi_boot" {
  type    = bool
  default = true
}
variable "format" {
  type    = string
  // default = "qcow2" # or raw
  default = "raw"
}

