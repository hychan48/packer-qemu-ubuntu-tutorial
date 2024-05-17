# Packker Qemu Clean
## Ubuntu
* Install / Check dependencies
## Packer Sources
1. Build http/meta-data
2. Build http/user-data
  * update hostname
  * update username
  * update password
  1. Build Server
  2. Build Desktop
3. Build no-cloud


## parse qemu.sh file
```bash
ps aux --cols 10000 | head -n 2
ps aux --cols 10000 | head -n 2 | awk '{print $11}'

ps aux | awk '{print $11}'
ps auxww | head -n 2
ps auxww | awk '{print $11}'

cat output/ub24-server/qemu.sh | awk '{print $9}'
ps aux --noheaders --cmd | head -n 1 
ps --help
ps -ef | awk '/mintty/&&!/awk/{print $2 } '
ps aux
ps aux | awk '/grep/&&!/awk/{print $2 } '
ps aux | grep -Eo '^[^[:blank:]]+[[:blank:]]+([^[:blank:]]+[[:blank:]]+){9}.*'

ps -o cmd --no-headers | grep qemu-system | head -n 1
ps -o cmd
# pgrep -f qemu-system-x86_64
ps aux --noheaders | head -n 1 | cut -d "/t" -f1
ps aux --no-headers | head -n 1 | cut -f2

| awk '{print $11}'
cat output/ub24-server/qemu.sh | head -n 1 | awk '{print $9}'
cat output/ub24-server/qemu.sh | head -n 1 | awk '{print $11}'
ps aux | awk '{for (i=11; i<=NF; i++) print $i}'
ps aux --no-headers


# cut
cat output/ub24-server/qemu.sh | cut -d ' ' -f19
ps aux | awk '{print $13}'

```

# future
* https://github.com/hashicorp/packer/issues/9024
  * using tags
# todo/fix
* [ ] split the build into two parts
* http/cloud-init
  * meta-data
  * https
* builder
* and just use the make file get it to work properly


```bash
ls assets
man cloud-localds
cloud-localds output/seed.img assets/user-data_server_live assets/meta-data
code output/seed.img
```

```bash
```

```bash
```

### Pre-build
* Prebuild cloud-init
#### Make
```bash
make setup-cloud-init-files
```

#### Raw
```bash
code workspaces/packer-qemu-clean/ubuntu/README.md # this file
cd workspaces/packer-qemu-clean/ubuntu/ # this folder
cd /home/jason/github/packer-tut-1/workspaces/packer-qemu-clean/ubuntu/README.md # this folder


packer build -only="http**" .
tree output 


make build-ub24-server


# replace HOSTNAME_REPLACE with name
sed -i 's/HOSTNAME_REPLACE/ub24-server/g' output/ub24-server/http/user-data
cat output/ub24-server/http/user-data | grep -i hostname_rep
cat output/ub24-server/http/user-data | grep -i "hostname:"

# sed output/ub24-server/http/user-data
lazy replace wiht yq?
sed 


ps aux | grep qemu-system
sudo cloud-init schema --config-file output/ub24-server/http/user-data
code output/ub24-server/http/user-data

cat output/ub24-server/qemu.sh
ls output/ub24-server/

```





# old
```bash
cd 

packer inspect -only=ubuntu-server-live . > /tmp/packer-inspect.txt
packer inspect -only=ubuntu-desktop-live . > /tmp/packer-inspect.txt
```

## manual
```bash
cd /home/jason/github/packer-maas/packer-qemu-ubuntu24/ubuntu
# copy into http? or what or use cloud seed instead

packer inspect -only=ubuntu-server-live -var host_hostname=$(hostname -I | awk '{print $1') .

packer build -only="ub24-server.file.no.cloud" .
packer build -only=ub24-server .
packer build -only="ub24-server*" .
packer build -only="devfile*" .
PACKER_LOG=0 packer build -only="devfile*" .
cat output/debug.txt

packer build -only="nc24*" .
make dev-ub24-cloud-init

packer build -only="dev_build*" -var host_hostname=$(hostname -I | awk '{print $1}') .



```
```bash
# ctrl right for sub
ssh -p 3455 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@localhost
ssh -p 3456 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@localhost
ssh -p 3457 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@localhost
ssh -p 3455 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ubuntu@localhost
```
```bash
```
```bash
/usr/bin/qemu-system-x86_64 -smp 2 -usb -drive file=output/ubuntu-server_live-24.04/ubuntu-server_live-24.04,if=virtio,cache=writeback,discard=ignore,format=raw -drive file=/var/lib/qemu/images/ubuntu-24.04-live-server-amd64.iso,media=cdrom -drive file=/usr/share/OVMF/OVMF_CODE_4M.fd,if=pflash,unit=0,format=raw,readonly=on -drive file=output/ubuntu-server_live-24.04/efivars.fd,if=pflash,unit=1,format=raw -qmp unix:output/ubuntu-server_live-24.04/ubuntu-server_live-24.04.monitor,server,nowait -name ubuntu-server_live-24.04 -netdev user,id=user.0,hostfwd=tcp::3455-:22 -vnc 192.168.1.114:5 -device usb-kbd -device virtio-net,netdev=user.0 -m 4096M -vga qxl -machine type=q35,accel=kvm -cpu host
```
# todo
* [ ] download file / deps
* [ ] username and password with yq
```bash
# users
yq e '.autoinstall.user-data.users[2]' http/ubuntu-server-live/user-data
yq e '.autoinstall.user-data.chpasswd.users[2].name' http/ubuntu-server-live/user-data
yq e '.autoinstall.user-data.chpasswd.users[2].password' http/ubuntu-server-live/user-data

```