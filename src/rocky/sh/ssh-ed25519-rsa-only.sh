#!/bin/bash
set -euo pipefail

# ssh-copy-id -i ~/.ssh/id_ed25519.pub  root@<ip|服务器名|域名>
# ssh-copy-id -i ~/.ssh/id_ed25519.pub "-p 1022 root@<ip|服务器名|域名>"

echo ==================== 设置仅允许 RSA/Ed25519 算法证书 ====================
# sudo sh -c "sed -i 's/\(^\s*HostKey.\+ssh_host_rsa_key\)/# \1/' /etc/ssh/sshd_config"
sudo sh -c "sed -i 's/\(^\s*HostKey.\+ssh_host_dsa_key\)/# \1/' /etc/ssh/sshd_config"
sudo sh -c "sed -i 's/\(^\s*HostKey.\+ssh_host_ecdsa_key\)/# \1/' /etc/ssh/sshd_config"
sudo sh -c "sed -i 's/^#\s*\(HostKey.\+ssh_host_ed25519_key\)/\1/' /etc/ssh/sshd_config"
sudo sh -c "sed -i 's/^#\s*\(HostKey.\+ssh_host_rsa_key\)/\1/' /etc/ssh/sshd_config"

