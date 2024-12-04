#!/bin/sh
# cp -u z.bashrc.sh /etc/profile.d/

export REG1='foo'

export XZ_DEFAULTS='-T 0'
export ZSTD_CLEVEL=9

export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
# export NVM_NODEJS_ORG_MIRROR="https://npmmirror.com/dist"
export NVM_NODEJS_ORG_MIRROR="https://mirrors.aliyun.com/nodejs-release"
export NPM_REG_MIRROR="https://registry.npmmirror.com"

if [[ $- != *i* ]]; then
    return
fi
# ========== 仅交互式shell执行以下代码 ==========

# if bash is used, set shopt and prompt
if [ -n "$BASH_VERSION" ]; then
  shopt -s cdspell    # auto-correct typos in cd
  set -o pipefail     # pipe fail when component fail
  shopt -s histappend # append to history rather than overwrite
  for option in autocd ; do
    shopt -s "$option" 2>/dev/null
  done

  # 获取第一个ip
  IP=$(hostname -I 2>/dev/null | tr ' ' '\n' | grep -v '172.17.0.1' | head -n 1)
  # 获取主机名
  HOSTNAME=$(hostname)
  [[ -z "$IP" ]] && IP=$HOSTNAME

  # 如果主机名是 localhost.localdomain 或者 localhost，则将主机名设为ip
  if [[ "$HOSTNAME" == "localhost.localdomain" || "$HOSTNAME" == "localhost" ]]; then
    HOSTNAME=$IP
  else
    if [[ "$HOSTNAME" != "$IP" ]]; then
      HOSTNAME="$HOSTNAME:$IP"
    fi
  fi
  export PS1="\[\033]0;\w\007\]\[\]\n\[\e[1;36m\][\D{%m-%d %T}] \[\e[1;31m\]\u\[\e[1;33m\]@\[\e[1;32m\]$HOSTNAME\[\e[1;32m\]:\w \n\[\e[1;35m\]\$ \[\e[0m\]"
fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

Z_DIR=/usr/local/z-1.12
[ -s "$Z_DIR/z.sh" ] && \. "$Z_DIR/z.sh"

df -lhT

# vim:ts=2:sw=2
