
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
# find /etc/yum.repos.d/ -type f -exec sed -i 's|https://mirrors.tuna.tsinghua.edu.cn/|https://mirrors.aliyun.com/|g' {} +
find . -type f -exec sed -i 's|https://mirrors.tuna.tsinghua.edu.cn/|https://mirrors.aliyun.com/|g' {} +
find . -type f -exec sed -i 's|https://mirrors.tuna.tsinghua.edu.cn/|https://mirrors.tencent.com/|g' {} +
pig sty boot                              # install ansible and other pre-deps
sudo find /etc/yum.repos.d/ -type f -exec sed -i 's|https://mirrors.tuna.tsinghua.edu.cn/|https://mirrors.aliyun.com/|g' {} +
sudo dnf makecache
# pig sty conf                              # auto-generate pigsty.yml config file
```

安装
```sh
# (可选) 注销 L322 启用代理
# (可选) 设置 docker_data
# (可选 若 zfs 版本低于 2.2) 设置 docker_storage_driver: zfs
# run the install.yml playbook
pig sty install
```


后续设置
```sh
./docker.yml -l all|infra                 # 在 所有|infra 分组上安装注册 Docker
# MINIO 配置：单节点
# 制作离线软件包 https://pigsty.cc/docs/setup/offline/#%E5%88%B6%E4%BD%9C%E7%A6%BB%E7%BA%BF%E8%BD%AF%E4%BB%B6%E5%8C%85
./cache.yml -l infra  

```

添加扩展包
```sh
pig ext add safeupdate
pig ext install safeupdate
```


无论是主动切换还是故障切换，您都需要在集群成员身份发生变化后，重新刷新服务与HBA规则。您应当在变更发生后及时（例如几个小时，一天内），完成此操作：
```sh
bin/pgsql-svc <cls>
bin/pgsql-hba <cls>
```
