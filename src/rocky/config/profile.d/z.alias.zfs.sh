#!/bin/sh
# cp -u z.alias.zfs.sh /etc/profile.d/


export zlist_opts='name,used,available,referenced,mountpoint,compression,compressratio,recordsize,logbias,sync,primarycache,readonly,mounted,creation,'
alias zlist="zfs list -o "${zlist_opts}""

export zlist_full_opts='name,used,available,referenced,logicalreferenced,logicalused,mountpoint,mounted,compressratio,refcompressratio,type,encryption,copies,dedup,xattr,quota,volblocksize,version,written,guid,'
alias zlist_full="zfs list -o "${zlist_full_opts}""

export zpool_full_opts='name,size,allocated,free,freeing,checkpoint,expandsize,fragmentation,capacity,dedupratio,health,altroot,fragmentation,readonly,ashift,autoexpand,autoreplace,autotrim,cachefile,version,'
alias zplist="zpool list -o "${zpool_full_opts}""

alias zps="zpool status"

# vim:ts=2:sw=2
