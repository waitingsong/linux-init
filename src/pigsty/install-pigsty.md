
```sh
# dnf -y install ansible python3-jmespath createrepo_c modulemd-tools sshpass

# curl https://repo.pigsty.io/pig | bash    # cloudflare
curl https://repo.pigsty.cc/pig | bash    # china cdn
```

切换安装用户
```sh
su - dba
```

```sh
pig sty init                              # install embed pigsty to ~/pigsty
cd pigsty
find . -type f -exec sed -i 's|https://mirrors.tuna.tsinghua.edu.cn/|https://mirrors.aliyun.com/|g' {} +
# find . -type f -exec sed -i 's|https://mirrors.tuna.tsinghua.edu.cn/|https://mirrors.tencent.com/|g' {} +
pig sty boot                              # install ansible and other pre-deps
sudo find /etc/yum.repos.d/ -type f -exec sed -i 's|https://mirrors.tuna.tsinghua.edu.cn/|https://mirrors.aliyun.com/|g' {} +
sudo dnf makecache
# pig sty conf                              # auto-generate pigsty.yml config file
```

安装
```sh
# (可选) 注销 L312 启用代理
# (可选) 设置 docker_data_root
# (可选 若 zfs 版本低于 2.2) 设置 docker_storage_driver: zfs
pig sty install                           # run the install.yml playbook
```


后续设置
```sh
./docker.yml -l all|infra                 # 在 所有|infra 分组上安装注册 Docker
# MINIO 配置：单节点
./cache.yml -l infra  # 制作离线软件包

```

