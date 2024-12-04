#!/bin/sh
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/../../config/env.sh

# z 可以让你快速地在文件目录之间跳转。它会记住你访问的历史文件夹，经过短暂的学习后，你就可以使用 `z` 命令在目录之间跳转了
# [https://github.com/rupa/z](https://github.com/rupa/z)
# ```sh
# z tmp
# z usr bin
# ```
# wget https://github.com/rupa/z/archive/refs/tags/v1.12.zip

rm -rf /usr/local/z-1.12/
unzip -oq "${ASSERT}/z-1.12.zip" -d /usr/local/
chmod a+x /usr/local/z-1.12/z.sh
# echo ". /usr/local/z-1.12/z.sh"  >> ~/.bashrc
# echo ". /usr/local/z-1.12/z.sh"  >> ~/.profile
# echo ". /usr/local/z-1.12/z.sh"  >> /etc/bashrc
# echo ". /usr/local/z-1.12/z.sh"  >> /etc/profile.d/z.bashrc.sh
# . /usr/local/z-1.12/z.sh

