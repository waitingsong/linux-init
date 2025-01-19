#!/bin/sh
set -eo pipefail
# https://openzfs.github.io/openzfs-docs/Getting%20Started/RHEL-based%20distro/index.html
# https://www.rockylinux.cn/notes/strong-diy-nas-xi-lie-03-an-zhuang-zfs-wen-jian-xi-tong.html
# https://201.ustclug.org/ops/storage/zfs/#tuning


echo ==================== OpenZFS 创建文件系统 ====================
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

fs_data="data"
fs_data_postgres="${fs_data}/postgres"
fs_data_backups="${fs_data}/backups"

if [[ -d "/${fs_data}" ]]; then
  echo "Directory exists: /${mnt_data}"
  exit 1
fi

zpool create -o ashift=12 -o autotrim=on ${fs_data} -m /${fs_data} "${disk}"
# zpool get all data
zfs set dedup=off atime=off relatime=on xattr=sa compression=zstd logbias=throughput recordsize=32K ${fs_data}
# zfs get all data

zfs create ${fs_data_postgres}
zfs set dedup=off atime=off relatime=on xattr=sa compression=zstd-fast-10 logbias=latency recordsize=32K ${fs_data_postgres}
# zfs get all data/postgres

zfs create ${fs_data_backups}
zfs set dedup=off atime=off relatime=on xattr=sa compression=lz4 logbias=throughput recordsize=128k sync=disabled ${fs_data_backups}

set -x
zfs list
zfs get sync
zpool status
# zpool list -v data
# zdb
# zdb -D data

set +x

