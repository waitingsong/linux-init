#!/bin/sh
# cp -u z.alias.systemctl.sh /etc/profile.d/

alias s="systemctl"
alias sdr="systemctl daemon-reload"
alias sr="systemctl restart"
alias st="systemctl status"
if [ -f /usr/share/bash-completion/completions/systemctl ] && ! type -f _alias_sr_completion &>/dev/null ; then
  source /usr/share/bash-completion/completions/systemctl

  complete -F _systemctl s
  complete -F _alias_sr_completion sr
  complete -F _alias_st_completion st

  _alias_sr_completion() {
    local cur compopt
    _get_comp_words_by_ref -n : cur
    comps=$( __get_restartable_units --system "$cur" )
    compopt -o filenames
    COMPREPLY=( $(compgen -o filenames -W '$comps' -- "$cur") )
    return 0
  }

  _alias_st_completion() {
    local cur compopt
    _get_comp_words_by_ref -n : cur
    comps=$( __get_non_template_units --system "$cur" )
    compopt -o filenames
    COMPREPLY=( $(compgen -o filenames -W '$comps' -- "$cur") )
    return 0
  }
fi

# vim:ts=2:sw=2
