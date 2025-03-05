# ZFS 应用技巧

保留系统空间
https://openzfs.github.io/openzfs-docs/Performance%20and%20Tuning/Workload%20Tuning.html#free-space
```sh
# 10% of 1T
zfs set reservation=100G mypool
```

查看存储池状态
```sh
zpool status
```

查看存储池信息列表
```sh
zpool list
zpool list -v mypool
```

查看存储池点信息 
```sh
zpool get all mypool
```


查看存储池或文件系统列表
```sh
zfs list
```

查看存储池或文件系统写入同步设置
```sh
zfs get sync
```

查看存储池或文件系统写入压缩设置
```sh
zfs get compression
```
# zdb
# zdb -D data

查看文件系统信息
```sh
zfs get all mypool
zfs get all data/postgres
```

调试工具
```sh
zdb
zdb -D mypool
```


性能调优参数
https://openzfs.github.io/openzfs-docs/Performance%20and%20Tuning/Workload%20Tuning.html#database-workloads
- redundant_metadata=most

故障排除
- https://www.v2ex.com/t/1102533
  ```sh
  zpool import -Fn mypool
  ```
