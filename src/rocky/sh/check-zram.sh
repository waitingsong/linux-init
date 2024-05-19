#!/bin/sh
set +e
# sudo systemctl restart systemd-zram-setup@zram0.service
# sudo systemctl restart systemd-zram-setup@zram1.service

echo ==================== 服务状态 ====================
sudo systemctl status /dev/zram0
sudo systemctl status /dev/zram1
echo ==================== 块设备状态 ====================
lsblk
echo ==================== SWAP 状态 ====================
swapon --show
echo ==================== 内存 状态 ====================
free -h
echo ==================== zRAM 状态 ====================
zramctl --output-all
echo -e "\n"
date

