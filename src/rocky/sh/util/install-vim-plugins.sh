#!/bin/sh
set -e

curr_user=$(whoami)

if [[ ! -d ~/.vim/bundle ]]; then
    mkdir -p ~/.vim/bundle
fi

if [[ -n "$github_proxy_ip" ]]; then
  echo ">> 设置代理 $github_proxy_ip:$github_proxy_port 下载 vim 插件"
  if [[ -n "$github_proxy_port " ]]; then
    git config --global http.proxy http://$github_proxy_ip:$github_proxy_port
  else
    git config --global http.proxy http://$github_proxy_ip
  fi
fi

vim_bundle_path="/var/lib/vim/bundle"
if [[ ! -d $vim_bundle_path ]]; then
  mkdir -p $vim_bundle_path
  chmod 777 $vim_bundle_path
fi

if [[ ! -d "${vim_bundle_path}/Vundle.vim" ]]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ${vim_bundle_path}/Vundle.vim
  chmod a+rx ${vim_bundle_path}/Vundle.vim
  find ${vim_bundle_path}/Vundle.vim -type d -exec chmod a+rx {} \;
  find ${vim_bundle_path}/Vundle.vim -type f -exec chmod a+r {} \;
fi

if [[ ! -d "${vim_bundle_path}/nerdcommenter" ]]; then
  git clone https://github.com/preservim/nerdcommenter.git ${vim_bundle_path}/nerdcommenter
  chmod a+rx ${vim_bundle_path}/nerdcommenter
  find ${vim_bundle_path}/nerdcommenter -type d -exec chmod a+rx {} \;
  find ${vim_bundle_path}/nerdcommenter -type f -exec chmod a+r {} \;
fi

rm -rf ~/.vim/bundle/Vundle.vim
ln -s ${vim_bundle_path}/Vundle.vim ~/.vim/bundle/Vundle.vim

rm -rf ~/.vim/bundle/nerdcommenter .vim
ln -s ${vim_bundle_path}/nerdcommenter ~/.vim/bundle/nerdcommenter


if [[ -n "$github_proxy_ip" ]]; then
  git config --global --unset http.proxy
fi

set +e
