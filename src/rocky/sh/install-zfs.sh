#!/bin/sh
set -eo pipefail
# https://openzfs.github.io/openzfs-docs/Getting%20Started/RHEL-based%20distro/index.html
# https://www.rockylinux.cn/notes/strong-diy-nas-xi-lie-03-an-zhuang-zfs-wen-jian-xi-tong.html
# https://201.ustclug.org/ops/storage/zfs/#tuning


echo ==================== ZFS-KMOD 方式安装 OpenZFS ====================
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../config/env.sh


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
dnf install -y zfs parted tree

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
# 获取系统总内存（单位kB）
total_memory=$(grep MemTotal /proc/meminfo | awk '{print $2}')
# 计算 40% 的内存值（单位kB）
forty_percent_memory=$((total_memory * 40 / 100))
echo "系统总内存: $total_memory kB"
echo "设置ARC最大使用40%的内存容量: $forty_percent_memory kB"
echo $forty_percent_memory > /sys/module/zfs/parameters/zfs_arc_max

echo 3 > /sys/module/zfs/parameters/zfs_txg_timeout

# 计算 5% 的内存值（单位：kB）
min_percent_memory=$((total_memory * 5 / 100))
echo "设置ARC最少使用5%的内存容量: $min_percent_memory kB"
echo $min_percent_memory > /sys/module/zfs/parameters/zfs_arc_min

# arc_summary | less
# cat /proc/spl/kstat/zfs/arcstats
# arcstat 1
# zpool iostat -r 1
# zpool iostat -l 1
# zpool get all
# zpool iostat -l
# pg_test_fsync
# zpool status -x

systemctl enable zfs-zed.service --now 2>/dev/null

