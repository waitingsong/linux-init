#!/bin/sh
set -euo pipefail

echo ==================== Rocky 使用阿里镜像仓库 ====================
sed -e 's|^mirrorlist=|#mirrorlist=|g' \
    -e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.aliyun.com/rockylinux|g' \
    -i.bak \
    /etc/yum.repos.d/rocky*.repo

dnf makecache

