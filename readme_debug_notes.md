### autovars
```bash
# todo add to make file
```

## Debug
```bash
sudo apt install -y sshpass
sshpass -p ubuntu ssh -p 3455 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@localhost
sshpass -p ubuntu ssh -p 3455 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ubuntu@localhost
sshpass -p ubuntu ssh -p 3455 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ubuntu-server@localhost # ubuntu-server during install
ssh -p 3455 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@localhost
```
```bash

# QMP
nc -U output/ub24-server/ub24-server.monitor
echo '{ "execute": "qmp_capabilities" }' | nc -U /home/jason/github/packer-qemu-ubuntu-tutorial/ubuntu/output/ub24-server/ub24-server.monitor

dd if=your_disk_image.raw | gzip > your_disk_image.dd.gz
sudo cloud-init schema --system
sudo cloud-init status --long
tree /etc/cloud -f
cat /etc/cloud/cloud.cfg
cat /etc/cloud/clean.d/99-installer
cat /etc/cloud/cloud.cfg.d/99-installer.cfg # this file is the metadata
cat /var/lib/cloud/instances/iid-datasource-none/cloud-config.txt
getent group sudo users cdrom sudo adm users
getent group users
getent group | grep users
getent group
```

```yaml
# cat /etc/cloud/cloud.cfg.d/99-installer.cfg # this file is the metadata
debug_cmd: |
  cat /etc/cloud/cloud.cfg.d/99-installer.cfg
datasource:
  None:
    metadata:
      instance-id: 1f0be9fb-4495-40c2-8db4-0930589a213a
    userdata_raw: "#cloud-config\n..."
datasource_list:
- None
```
