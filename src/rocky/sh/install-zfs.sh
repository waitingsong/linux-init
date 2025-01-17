#!/bin/sh
set -eo pipefail
# https://openzfs.github.io/openzfs-docs/Getting%20Started/RHEL-based%20distro/index.html
# https://www.rockylinux.cn/notes/strong-diy-nas-xi-lie-03-an-zhuang-zfs-wen-jian-xi-tong.html
# https://201.ustclug.org/ops/storage/zfs/#tuning


echo ==================== ZFS-KMOD 方式安装 OpenZFS ====================
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh

disk="${1}"

if [[ -z "${disk}" ]]; then
  echo "Usage: $0 <disk>|<by-id>|<by-path>|<by-uuid>"
  echo "Example: $0 /dev/nvme0n2 | pci-0000:0b:00.0-nvme-2 | nvme-eui.b1b...d7"
  tree /dev/disk/
  lsblk
  exit 1
fi

# name="${disk##*/}" # nvme0n2 without /dev/
# if [[ -z "${name}" ]]; then
#   echo "Invalid disk: ${disk}"
#   exit 1
# fi

dnf install -y https://zfsonlinux.org/epel/zfs-release-2-3$(rpm --eval "%{dist}").noarch.rpm
# 禁用 dkms 存储库，启用 kmod 存储库
dnf config-manager --disable zfs
dnf config-manager --enable zfs-kmod
# 执行此命令可能需要几分钟时间，具体取决于您的系统性能。
dnf install -y zfs parted

# 加载 ZFS 内核模块
modprobe zfs
echo 检测是否加载成功
lsmod | grep zfs

# 配置开机自动加载
if [[ -f /etc/modules-load.d/zfs.conf ]]; then
  echo "zfs" >> /etc/modules-load.d/zfs.conf
else
  echo "zfs" > /etc/modules-load.d/zfs.conf
fi

# echo 1024000000 > /sys/module/zfs/parameters/zfs_arc_max
# 获取系统总内存（单位：KB）
total_memory=$(grep MemTotal /proc/meminfo | awk '{print $2}')
# 计算 40% 的内存值（单位：KB）
forty_percent_memory=$((total_memory * 40 / 100))
echo "系统总内存: $total_memory KB"
echo "设置ARC为40%的内存值: $forty_percent_memory KB"
echo $forty_percent_memory > /sys/module/zfs/parameters/zfs_arc_max

# arc_summary | less
# cat /proc/spl/kstat/zfs/arcstats

