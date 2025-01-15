#!/bin/sh
set -eu

echo ==================== 升级系统 ====================
dnf update -y
dnf makecache


echo ==================== 卸载 Docker 相关软件 ====================
# dnf remove -y selinux-policy
dnf remove -y firewalld python-firewall firewalld-filesystem ntp \
  docker \
  docker-client \
  docker-client-latest \
  docker-common \
  docker-latest \
  docker-latest-logrotate \
  docker-logrotate \
  docker-engine


echo ==================== 设置时区 ====================
timedatectl set-timezone Asia/Chongqing
# or
# cp /usr/share/zoneinfo/Asia/Chongqing /etc/localtime

echo ========== 安装核心工具 ==========
dnf install -y \
  bash-completion \
  bzip2 \
  curl wget \
  dnf-utils \
  iotop iptraf-ng \
  jq \
  libuv \
  lsof \
  mtr \
  net-tools \
  openssl \
  time \
  traceroute \
  unzip \
  uuid \
  zip \
  zstd


echo ==================== 安装常用工具 ====================
dnf install -y \
  dnsmasq \
  dstat \
  elfutils-libelf-devel \
  libevent libevent-devel \
  lm_sensors \
  lz4 \
  mlocate \
  nfs-utils nmap \
  rpcbind \
  readline-devel \
  rsync \
  smartmontools \
  sysstat \
  telnet \
  usbutils \
  vim \
  vsftpd \
  whois \
  glibc \
  bind-utils


echo ==================== 安装 epel 仓库 ====================
epelRepo="$(dnf repolist | grep epel | head -n1)"
if [[ -n $epelRepo ]]; then
  echo "epel is already installed."
else
  dnf install -y 'dnf-command(config-manager)'
  dnf config-manager --set-enabled crb
  # dnf install -y \
  #   https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm \
  #   https://dl.fedoraproject.org/pub/epel/epel-next-release-latest-9.noarch.rpm

  dnf install -y \
    https://mirrors.aliyun.com/epel/epel-release-latest-9.noarch.rpm \
    https://mirrors.aliyun.com/epel/epel-next-release-latest-9.noarch.rpm

  # 替换有bug，会把 epel-cisco-openh264.repo 也替换掉导致没有有效的 baeurl
  # sed -i 's|^#baseurl=https://download.example/pub|baseurl=https://mirrors.aliyun.com|' /etc/yum.repos.d/epel*
  # sed -i 's|^metalink|#metalink|' /etc/yum.repos.d/epel*

  dnf config-manager --enable epel
  dnf config-manager --set-enabled crb
  # /usr/bin/crb enable
fi

dnf install -y \
  htop \
  iptstate \
  p7zip \
  pwgen \
  ripgrep \
  screen


echo ==================== 安装安装集群相关软件 ====================
dnf install -y \
  ipvsadm \
  keepalived \
  socat


dnf makecache

