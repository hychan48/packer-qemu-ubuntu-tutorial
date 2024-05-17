/* ubuntu - will be override with pkrvar.hcl */

/**
* delibrate hardcoding 
* note the terms: packer best practices is to have static names/state
* can generate this. probably json is easier if generating


ub24-server
ub24-desktop
ub22-server

*/
variable "uri_ub24_server" {
  /* 
  https://releases.ubuntu.com/24.04/ 
  https://releases.ubuntu.com/24.04/SHA256SUMS
  */
  type = string
  // default = "http://releases.ubuntu.com/24.04/ubuntu-24.04-live-server-amd64.iso" # http
  // default = "file:///var/lib/qemu/images/ubuntu-24.04-live-server-amd64.iso"
  default = "http://releases.ubuntu.com/24.04/ubuntu-24.04-live-server-amd64.iso"
  //https
}
variable "uri_ub24_desktop" {
  type = string
  // default = "file:///var/lib/qemu/images/ubuntu-24.04-desktop-amd64.iso"
  default = "http://releases.ubuntu.com/24.04/ubuntu-24.04-desktop-amd64.iso"
}
variable "uri_ub22_server" {
  /* 
  https://releases.ubuntu.com/22.04/ 
  https://releases.ubuntu.com/22.04/SHA256SUMS
  */
  type = string
  // default = "file:///var/lib/qemu/images/ubuntu-22.04.4-live-server-amd64.iso"
  default = "http://releases.ubuntu.com/22.04/ubuntu-22.04.4-live-server-amd64.iso"
}
/* checksums */

variable "map_ubuntu_iso_checksum" {
  type = map(string)
  // https://releases.ubuntu.com/24.04/SHA256SUMS
  // https://releases.ubuntu.com/22.04/SHA256SUMS
  default = {
    "ubuntu-24.04-desktop-amd64.iso":"81fae9cc21e2b1e3a9a4526c7dad3131b668e346c580702235ad4d02645d9455"
    "ubuntu-24.04-live-server-amd64.iso":"8762f7e74e4d64d72fceb5f70682e6b069932deedb4949c6975d0f0fe0a91be3"
    "ubuntu-22.04.4-live-server-amd64.iso":"45f873de9f8cb637345d6e66a583762730bbea30277ef7b32c9c3bd6700a32b2"
  }
}


# todo add the ones only for server-live
## Variable will be set via the Command line defined under the `vars` directory
# fixme not used right now

// variable "ubuntu_iso_base_uri" {
//   type = string
//   // default = "https://releases.ubuntu.com/"
//   default = "https://releases.ubuntu.com/"
//   //todo fix this
// }