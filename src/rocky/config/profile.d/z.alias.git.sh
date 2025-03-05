#!/bin/sh
# cp -u z.alias.git.sh /etc/profile.d/

if [ -x "$(command -v git)" ]; then
  if ! command -v ___git_complete &>/dev/null; then
    # 加载 Git 补全脚本
    if [ -f /usr/share/bash-completion/completions/git ]; then
        source /usr/share/bash-completion/completions/git
    elif [ -f /mingw64/share/git/completion/git-completion.bash ]; then
        source /mingw64/share/git/completion/git-completion.bash
    fi
  fi

  alias g='git'
  ___git_complete g __git_main
  alias gp='git pull'
  __git_complete gp git_pull
  alias gps='git push'
  __git_complete gps git_push
  alias ga='git add'
  __git_complete ga git_add
  alias gb='git branch'
  __git_complete gb git_branch
  alias gci='git commit -v'
  alias gc='git checkout'
  __git_complete gc git_checkout
  alias gcb='git checkout -b'
  __git_complete gcb git_checkout
  alias gs='git switch'
  __git_complete gs git_switch
  alias gcp='git cherry-pick'
  __git_complete gcp git_cherry_pick
  # alias gd='git diff'
  # alias gdc='git diff --cached'
  # alias gds='git diff --staged'
  # alias gf='git fetch'
  # alias gfa='git fetch --all'
  # alias gfo='git fetch origin'
  alias gl='git log'
  __git_complete gl git_log
  alias glg='git log --graph --oneline --decorate --date=short --pretty=format:"%C(yellow)%h%Creset %Cgreen%ad%Creset %Cblue%an%Creset %Cred%d%Creset %s"'
  __git_complete glg git_log
  alias gls='git log --show-signature'
  __git_complete gls git_log
  alias gla='git log --graph --oneline --decorate --all --date=short --pretty=format:"%C(yellow)%h%Creset %Cgreen%ad%Creset %Cblue%an%Creset %Cred%d%Creset %s"'
  # alias glaff='git log --graph --oneline --decorate --all --date=short --pretty=format:"%C(yellow)%h%Creset %Cgreen%ad%Creset %Cblue%an%Creset %Cred%d%Creset %s" --first-parent'
  # alias glafd='git log --graph --oneline --decorate --all --date=short --pretty=format:"%C(yellow)%h%Creset %Cgreen%ad%Creset %Cblue%an%Creset %Cred%d%Creset %s" --date-order'
  # alias glafa='git log --graph --oneline --decorate --all --date=short --pretty=format:"%C(yellow)%h%Creset %Cgreen%ad%Creset %Cblue%an%Creset %Cred%d%Creset %s" --author-date-order'

  alias gst='git status'
  alias gm='git merge'
  __git_complete gmg git_merge
  alias gms='git merge --squash'
  __git_complete gmgs git_merge
  alias gr='git rebase'
  __git_complete gr git_rebase

  git config --global i18n.commitencoding utf-8
fi


# vim:ts=2:sw=2
