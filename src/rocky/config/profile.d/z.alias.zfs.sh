#!/bin/sh
# cp -u z.alias.zfs.sh /etc/profile.d/


# compressratio at the end of the line for better column alignment
zlist_opts='name,available,used,referenced,mountpoint,compression,recordsize,logbias,sync,compressratio,'
alias zlist="zfs list -o ${zlist_opts} -d 1 -s creation"

# compressratio at the end of the line for better column alignment
zlist_ext_opts='space,referenced,mounted,type,primarycache,dedup,xattr,volblocksize,written,readonly,exec,creation,compressratio,'
alias zlist_ext="zfs list -o ${zlist_ext_opts} -d 1 -s creation"

zlist_full_opts='space,referenced,mountpoint,mounted,exec,creation,compressratio,'
alias zlist_full="zfs list -o ${zlist_full_opts} -s creation"

zplist_opts='name,size,allocated,free,freeing,checkpoint,expandsize,fragmentation,capacity,dedupratio,health,altroot,readonly,ashift,autoexpand,autoreplace,autotrim,cachefile,'
alias zplist="zpool list -o ${zplist_opts}"

# compressratio at the end of the line for better column alignment
zlist_snapshot_opts='name,used,referenced,creation,compressratio,'
alias zlist_snapshot="zfs list -t snapshot -o ${zlist_snapshot_opts} -s creation"

alias zpstatus="zpool status -vt"

# vim:ts=2:sw=2
