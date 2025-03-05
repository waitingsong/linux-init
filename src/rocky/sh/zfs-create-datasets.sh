#!/bin/sh
set -eo pipefail


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

    echo "> Creating /$pool_name/docker"
    zfs-create $pool_name/docker /.docker

    echo "> Creating /$pool_name/minio"
    zfs-create $pool_name/minio /minio

    echo "> Creating /$pool_name/pg"
    zfs-create $pool_name/pg /zpdata

    echo "> Creating /$pool_name/zwal"
    zfs-create $pool_name/zwal /zwal

    # echo "> Creating /$pool_name/pg_log_dir"
    # zfs-create $pool_name/pg_log_dir /zlog

    echo -e "\nZFS dataset list:"
    zfs_opts='name,used,available,mountpoint,compression,recordsize,logbias,sync,primarycache,exec,compressratio,'
    zfs list -o "${zfs_opts}" ${dataset}
  fi
fi

