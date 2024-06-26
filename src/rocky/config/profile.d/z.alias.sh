#!/bin/sh
# cp -u alias.custom.sh /etc/profile.d/


#if [ -f /usr/share/bash-completion/bash_completion ]; then
#  . /usr/share/bash-completion/bash_completion
#fi

alias time='/usr/bin/time '
alias sh='/bin/bash'

alias dfn="dnf"
alias hg="history | grep --color=auto "
alias je="journalctl -xe"
alias ju="journalctl -u"
alias now='date +"DATE: %Y-%m-%d  TIME: %H:%M:%S  EPOCH: %s"'
alias today='date +"%Y%m%d "'

# find . -type f -name "*.rb" -print0 | map0 echo I.foo
alias map0='xargs -0II'
alias map="xargs -n1"

alias ll='ls -l'
alias lla='ls -al'
alias llh='ls -alh'
alias llhm='ls -alh |more'

alias crontab='crontab -i'
alias tailf='tail -f'
alias tarz='tar -I zstdmt'
alias dc='docker-compose'
alias dk='docker'
alias dkc='docker container'
alias dki='docker image'
alias dkv='docker volume'
alias dkis='docker inspect'
alias dkps='docker ps --format "table {{.Image}}\t{{.Command}}\t{{.RunningFor}}\t{{.Status}}\t{{.Names}}\t{{.Mounts}}"'
alias dkst='docker stats'

alias dkiif='docker image inspect -f "Id:{{.Id}} {{println}}\
Created: {{.Created}} {{println}}\
RepoDigests: {{range .RepoDigests}}{{println}}  {{.}}{{end}} {{println}}\
RepoTags: {{range .RepoTags}}{{println}}  {{.}}{{end}} {{println}}\
Layers: {{range .RootFS.Layers}}{{println}}  {{.}}{{end}} {{println}}\
Labels: {{json .Config.Labels}}"'

alias sudo='sudo '
alias su='su -'
# alias vi='vim'
alias rm='rm -i'
alias dstat='dstat -cdlmnpsy'
alias diostat='iostat -d -x -m 2 100'
alias ntt='netstat -tunpl'
alias allnst="netstat -n |awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'"
alias usenst="netstat -an | grep 80 | awk '{print $6}' | sort | uniq -c | sort -rn"
alias webnst="netstat -nat|grep ":80"|awk '{print $5}' |awk -F: '{print $1}' | sort| uniq -c|sort -rn|head -n 10"

alias sctl="systemctl"
alias jctl="journalctl"
alias sdr="systemctl daemon-reload"

alias k='kubectl'
alias ka='kubectl apply --recursive -f'
alias kex='kubectl exec -it'
alias klo='kubectl logs -f'
alias kg='kubectl get'
alias kd='kubectl describe'
# complete -o default -F __start_kubectl k

if [ "$(uname -s)" == Darwin ]; then
  alias sed='gsed'
  alias tar='gtar'
fi

# if git command exists then:
if [ -x "$(command -v git)" ]; then
  alias g='git'
  alias gp='git pull'
  alias gpl='git pull'
  alias gps='git push'
  alias ga='git add'
  alias gb='git branch'
  alias gc='git commit -v'
  alias gco='git checkout'
  alias gcob='git checkout -b'
  alias gs='git switch'
  alias gcp='git cherry-pick'
  # alias gd='git diff'
  # alias gdc='git diff --cached'
  # alias gds='git diff --staged'
  # alias gf='git fetch'
  # alias gfa='git fetch --all'
  # alias gfo='git fetch origin'
  alias gl='git log'
  alias glg='git log --graph --oneline --decorate --all'
  alias glgs='git log --show-signature'
  alias glgg='git log --graph --oneline --decorate --all --date=short --pretty=format:"%C(yellow)%h%Creset %Cgreen%ad%Creset %Cblue%an%Creset %Cred%d%Creset %s"'
  # alias glgga='git log --graph --oneline --decorate --all --date=short --pretty=format:"%C(yellow)%h%Creset %Cgreen%ad%Creset %Cblue%an%Creset %Cred%d%Creset %s" --all'
  # alias glggf='git log --graph --oneline --decorate --all --date=short --pretty=format:"%C(yellow)%h%Creset %Cgreen%ad%Creset %Cblue%an%Creset %Cred%d%Creset %s" --first-parent'
  # alias glggh='git log --graph --oneline --decorate --all --date=short --pretty=format:"%C(yellow)%h%Creset %Cgreen%ad%Creset %Cblue%an%Creset %Cred%d%Creset %s" --date-order'
  # alias glggl='git log --graph --oneline --decorate --all --date=short --pretty=format:"%C(yellow)%h%Creset %Cgreen%ad%Creset %Cblue%an%Creset %Cred%d%Creset %s" --author-date-order'

  alias gst='git status'
  alias gmg='git merge'
  alias gmgs='git merge --squash'

  # complete -o default -o nospace -F _git_alias g

  # git config --global i18n.commitencoding utf-8
  # git config --global alias.br branch
  # git config --global alias.co checkout
  # git config --global alias.ci commit
  # git config --global alias.st status
  # git config --global alias.sw switch
  # git config --global alias.mg merge
  # git config --global alias.hist 'log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
  # git config --global alias.lg 'log --show-signature'

fi

_git_alias() {
  local cur prev words cword
  # _init_completion -s || return
  _get_comp_words_by_ref -n : cur prev words cword

  # 列出所有 Git 别名
  local aliases
  aliases=$(git config --get-regexp ^alias\. | sed 's/^alias\.//')

  # 提供补全建议
  COMPREPLY=($(compgen -W "$aliases" -- "$cur"))
}

# vim:ts=2:sw=2
