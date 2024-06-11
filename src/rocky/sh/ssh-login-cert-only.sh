#!/bin/bash
set -euo pipefail

# ssh-copy-id -i ~/.ssh/id_ed25519.pub  root@<ip|服务器名|域名>
# ssh-copy-id -i ~/.ssh/id_ed25519.pub "-p 1022 root@<ip|服务器名|域名>"

# 设置服务器**仅**接受ssh公钥登录（可选）
# **确认以上操作成功并且成功使用公钥登录系统后继续下面操作**

if [[ ! -f ~/.ssh/authorized_keys ]]; then
  echo "Error: Please create ~/.ssh/authorized_keys first. or use ssh-copy-id to copy your public key to the remote server."
  exit 1
fi


echo ==================== SSH 设置仅允许证书登录 ====================

cp /etc/ssh/sshd_config /etc/ssh/ori_sshd_config
sed -i "s/^\s*\(PasswordAuthentication.*\)/# \1/g" /etc/ssh/sshd_config
echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config

