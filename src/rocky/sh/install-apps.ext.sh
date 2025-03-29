#!/bin/sh
set -euo pipefail


echo ==================== 安装基本编译环境 ====================
dnf groupinstall -y "Development Tools"
dnf install -y \
  cmake \
  clang clang-devel \
  glibc glibc-devel \
  gcc gcc-c++ gcc-toolset-13-gcc  gcc-toolset-13-gcc-c++ \


echo ==================== 安装安装集群相关软件 ====================
dnf install -y \
  conntrack-tools \
  ipset ipvsadm \
  keepalived \
  psmisc \
  socat


dnf makecache

