/**
* Qemu Plugin ref - Shared Variables
* https://developer.hashicorp.com/packer/integrations/hashicorp/qemu/latest/components/builder/qemu
*/

// local variables dont work well with source.name
source "file" "nocloud_user_data_server_live" {
  source = "assets/user-data_server_live"
  target = abspath("${var.output_directory}/http-${source.name}/user-data")
}
source "file" "nocloud_user_data_desktop_live" {
  source = "assets/user-data_desktop_live"
  target = abspath("${var.output_directory}/http-${source.name}/user-data")
}
/* setup files - baes templates*/
/* Metadata */
source "file" "nocloud_meta_data" {
  source = "assets/meta-data" # name will be set by build
  target = abspath("${var.output_directory}/http-${source.name}/meta-data")
}
/* Create http sources */
build {
  name="ub-cloudinit_metadata"
  # 1. meta-data
  source "sources.file.nocloud_meta_data" {
    name="ub24-server"
    # name has to be static. i.e. no functions, variables etc.
    // tag=["ub24-server"]
  }
  # 1.1 meta-data ub22-server, ub24-desktop
  source "sources.file.nocloud_meta_data" { name="ub22-server"}
  source "sources.file.nocloud_meta_data" { name="ub24-desktop" }
}
build {
  name="ub-cloudinit_userdata"


  # 2. user-data - Server
  source "sources.file.nocloud_user_data_server_live" {
    name="ub24-server"
  }
  # 2.1user-data ub22-server, ub24-desktop
  source "sources.file.nocloud_user_data_server_live" { name="ub22-server"}
  source "sources.file.nocloud_user_data_desktop_live" { name="ub24-desktop" } # desktop datasource


  /* provisioner */
  #https://developer.hashicorp.com/packer/docs/provisioners/breakpoint
  # Replace hostname
  provisioner "shell-local" {
    inline = [
      "echo 'echoing SED_REPLACE /${source.name}/' ${abspath("${var.output_directory}/http-${source.name}/user-data")}",
      "sed -i 's/HOSTNAME_REPLACE/${source.name}/g' ${abspath("${var.output_directory}/http-${source.name}/user-data")}",
      "sed -i 's/USER_REPLACE/${var.username}/g' ${abspath("${var.output_directory}/http-${source.name}/user-data")}",
      "sed -i 's/PASSWORD_REPLACE/${var.username_password}/g' ${abspath("${var.output_directory}/http-${source.name}/user-data")}",
    ]
  }
  // quick check
  post-processor "shell-local" {
    inline = [
      "cat ${abspath("${var.output_directory}/http-${source.name}/user-data")} | grep hostname",
      "cat ${abspath("${var.output_directory}/http-${source.name}/user-data")} | grep -q ${source.name}",
      "cat ${abspath("${var.output_directory}/http-${source.name}/user-data")} | grep -q ${var.username_password}",
      "cat ${abspath("${var.output_directory}/http-${source.name}/user-data")} | grep -q ${var.username}",
    ]

  }

}
