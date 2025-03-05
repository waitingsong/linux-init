#!/bin/sh
# cp -u z.alias.sh /etc/profile.d/

alias time='/usr/bin/time '
alias sh='/bin/bash'

alias p="psql"
alias j="jobs"
alias h="history"

alias dfn="dnf"
alias hg="history | grep --color=auto "
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias now='date +"DATE: %Y-%m-%d  TIME: %H:%M:%S  EPOCH: %s"'
alias date_ft='date +%F_%T'
alias today='date +"%Y%m%d "'

alias sd="sudo su - dba"
alias sa="sudo su - root"
alias sp="sudo su - postgres"
alias adm="sudo su - admin"

alias je="journalctl -xe"
alias ju="journalctl -u"
if [ -f /usr/share/bash-completion/completions/journalctl ] && ! type _alias_ju_completion &>/dev/null ; then
  source /usr/share/bash-completion/completions/journalctl
  _alias_ju_completion() {
    local cur
    _get_comp_words_by_ref -n : cur
    comps=$(journalctl -F '_SYSTEMD_UNIT' 2>/dev/null)
    if ! [[ $cur =~ '\\' ]]; then
        cur="$(printf '%q' $cur)"
    fi
    compopt -o filenames
    COMPREPLY=( $(compgen -o filenames -W '$comps' -- "$cur") )
    return 0
  }
  complete -F _alias_ju_completion ju
fi

# find . -type f -name "*.rb" -print0 | map0 echo I.foo
alias map0='xargs -0II'
alias map="xargs -n1"

alias l="ls -lh "
alias la="ls -lha "
alias lap='ls -alh | less'
alias ll='ls -l'
alias lla='ls -al'
alias lsa="ls -a "
alias lsd="ls -lh | grep --color=never '^d'" # List only directories
alias ~="cd ~"
alias ..="cd .."
alias cd..="cd .."
alias esn='cd /etc/sysconfig/network-scripts'
alias ess='cd /etc/systemd/system'
alias mcm='/usr/bin/mc'

alias crontab='crontab -i'
alias tailf='tail -f'
alias tarz='tar -I zstdmt'

alias sudo='sudo '
# alias vi='vim'
alias rm='rm -i'
alias dstat='dstat -cdlmnpsy'
alias diostat='iostat -d -x -m 2 100'
alias ntt='netstat -tunpl'
alias allnst="netstat -n |awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'"
alias usenst="netstat -an | grep 80 | awk '{print $6}' | sort | uniq -c | sort -rn"
alias webnst="netstat -nat|grep ":80"|awk '{print $5}' |awk -F: '{print $1}' | sort| uniq -c|sort -rn|head -n 10"

alias dus='du -sh'
alias dusa='du -sh --apparent-size'

if [ "$(uname -s)" == Darwin ]; then
  alias sed='gsed'
  alias tar='gtar'
fi


# vim:ts=2:sw=2
