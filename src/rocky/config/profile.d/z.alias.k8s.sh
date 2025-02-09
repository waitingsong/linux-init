#!/bin/sh
# cp -u z.alias.k8s.sh /etc/profile.d/

alias k='kubectl'
alias ka='kubectl apply --recursive -f'
alias kex='kubectl exec -it'
alias klo='kubectl logs -f'
alias kg='kubectl get'
alias kd='kubectl describe'
# complete -o default -F __start_kubectl k


# vim:ts=2:sw=2
