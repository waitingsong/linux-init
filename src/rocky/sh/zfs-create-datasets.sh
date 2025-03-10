#!/bin/sh
set -e


# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# . ${DIR}/../config/env.sh

pool_name="data"

set +x  # must turn off x
# 检查 ZFS 是否安装
if command -v zfs &>/dev/null; then
  pool_name="data"
  set +e  # 必须关闭 errexit
  # zfs_data=$(zfs list -H -o name | grep $pool_name)
  zfs_data=$(zfs get type "$pool_name" 2>/dev/null)
  set -e
  if [[ -n "$zfs_data" ]]; then
    echo ==================== ZFS 创建数据集 ====================
    export zfs_create_quiet=1

    dataset="$pool_name/docker"
    echo "> Creating $dataset"
    exists=$(zfs get type "$dataset" -H 2>/dev/null) || true
    [[ -z "$exists" ]] && zfs-create $dataset /.docker

    dataset="$pool_name/minio"
    echo "> Creating $dataset"
    exists=$(zfs get type "$dataset" -H 2>/dev/null) || true
    [[ -z "$exists" ]] && zfs-create $dataset /minio

    dataset="$pool_name/pg"
    echo "> Creating $dataset"
    exists=$(zfs get type "$dataset" -H 2>/dev/null) || true
    [[ -z "$exists" ]] && zfs-create $dataset /pdata

    dataset="$pool_name/pg_wal"
    echo "> Creating $dataset"
    exists=$(zfs get type "$dataset" -H 2>/dev/null) || true
    [[ -z "$exists" ]] && zfs-create $dataset /pwal


    echo -e "\nZFS dataset list:"
    zfs_opts='name,used,available,mountpoint,compression,recordsize,logbias,sync,primarycache,exec,compressratio,'
    zfs list -o "${zfs_opts}"
    echo -e "\n"
  fi
fi

