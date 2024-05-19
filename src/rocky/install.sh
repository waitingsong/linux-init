#!/bin/sh
set -euo pipefail

clear
echo -e "\n"
echo ===============================================================
echo "                 Rocky Linux 9.x 初始化"
echo "          本脚本可以重复执行, 会自动跳过已经安装的软件"
echo ===============================================================
echo -e "\n"

github_proxy_ip=""
github_proxy_port=""

while true; do
  echo -n "[提问] "; read -e -p "安装 Docker-Compose 需要访问 GitHub, 是否需要为此设置代理（全局代理使用 set-proxy.sh）? [y|n] " -i "" yn
  case ${yn} in
    [Nn]*) break;;
    [Yy]*)
      # 提示用户输入代理的 IP
      while true; do
        read -p "Enter the proxy IP: " proxy_ip
          if [ -z "$proxy_ip" ]; then
            echo "Proxy IP cannot be empty. Please enter a valid IP."
          else
            break
          fi
      done

      # 提示用户输入代理的端口
      default_proxy_port=7890
      read -p "Enter the proxy port (default: $default_proxy_port) : " proxy_port
      # 如果用户没有输入代理端口，则使用默认值
      proxy_port=${proxy_port:-$default_proxy_port}

      # 再次确认是否更改配置
      while true; do
        echo ">> github_proxy_ip: $proxy_ip, github_proxy_port: $proxy_port"
        read -p "Do you want to use these settings? (y/n): " apply
        case ${apply} in
          [Yy]*)
            echo "Applying settings..."
            export github_proxy_ip="$proxy_ip"
            export github_proxy_port="$proxy_port"
            break
            ;;
          [Nn]*)
            echo "Settings not applied. Exiting..."
            exit 1
            ;;
          *) echo "Please enter y or n." ;;
        esac
      done;

      break ;;

    *)     echo '输入 (y)es or (n)o';;
  esac;
done;

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/config/env.sh

./.install.sh

