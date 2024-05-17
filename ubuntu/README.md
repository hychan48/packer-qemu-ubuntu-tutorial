# Packker Qemu Ubuntu 24.04 Tutorial
Ubuntu 24.04 Live Server and Desktop Install

Reference tutorial for building Ubuntu images using KVM/QEMU and Packer

Can build in parallel all three images in about 6 minutes (if Packer cached / downloaded the ISOs)

### Build All
* Install / Check dependencies

```bash
# git clone git@github.com:hychan48/packer-qemu-ubuntu-tutorial.git
git clone https://github.com/hychan48/packer-qemu-ubuntu-tutorial.git
# builds the cloud-init meta-data and user-data
cd packer-qemu-ubuntu-tutorial
# modifies cloud-init files like username and password
cd ubuntu/
make configure
make build
```
#### VNC Connection
```bash
# ub24-server
vncviewer localhost:5905
# ub24-desktop
vncviewer localhost:5906
# ub22-server
vncviewer localhost:5907
```
#### ssh Connection
```bash
# ub24-server
ssh -p 3455 -o StrictHostKeyChecking=no root@localhost
# ub24-desktop
ssh -p 3456 -o StrictHostKeyChecking=no root@localhost
# ub22-server
ssh -p 3457 -o StrictHostKeyChecking=no root@localhost
```

#### Output

## Developer Notes
* [ISO Variables](variables-iso.pkr.hcl)
### Single Builds
```bash
make build-ub24-server
make build-ub24-desktop
make build-ub22-server
```

### build with local iso
```bash
packer init .
packer inspect -only "ub24.qemu.ub2*"  \
  -var uri_ub24_server="file:///var/lib/qemu/images/ubuntu-24.04-live-server-amd64.iso" \
  -var uri_ub22_server="file:///var/lib/qemu/images/ubuntu-22.04-live-server-amd64.iso" \
  -var uri_ub24_desktop="file:///var/lib/qemu/images/ubuntu-24.04-live-desktop-amd64.iso" \
  .
```
### Cloud-init files
```bash
ls -l assets/cloud-init/
```
```txt
assets
├── meta-data
├── user-data_desktop_live
└── user-data_server_live
```

## Project Files
* ub-cloudinit_config.pkr.hcl
  * builds the cloud-init config
* ub24-nocloud.pkr.hcl
  * builds with autoinstaller
    1. ub24-server
    2. ub24-desktop
    3. ub22-server
* variables-iso.pkr.hcl
  * ubuntu iso information
* variables.pkr.hcl
  * qemu/host variables
    * `username`
    * `username_password`
    * best practice is to use `*.pkrvars.hcl`
```
.
├── assets
│   ├── meta-data
│   ├── user-data_desktop_live
│   └── user-data_server_live
├── debug.pkr.hcl
├── http
├── Makefile
├── README.md
├── ub24-nocloud.pkr.hcl
├── ub-cloudinit_config.pkr.hcl
├── variables-iso.pkr.hcl
└── variables.pkr.hcl
```
