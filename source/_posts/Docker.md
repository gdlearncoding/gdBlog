---
title: Docker
date: 2025-10-08
tags:
  - tools
  - Docker
categories: 果冻的航海日志
cover: ./img/bearbug1.jpg
---
远程镜像仓库
本地镜像(镜像是只读的)
本地仓库
## 镜像版本
tag版本是完全独立的,last是最新的
docker pull/push 镜像名
docker images 查看本地镜像
docker search

## 容器
真正的示例,隔离网络,文件.不同容器可能会争抢资源1
容器打包成镜像,再上传到仓库
docker ps
docker ps -a
docekr start/stop/rm ID
docker commit -a "作者名称" -m "log信息" ID 打包成镜像
docker cp 文件目录 容器ID:目标目录   从前拷贝到后
docker exec -it ID /bin/bash  进入容器内部

dickerfile脚本 是可以通过下载文件的一些来创建脚本

网络中的映射一般是端口映射,容器端口8001映射到宿主机的8080


## Docker安装

不要用homebrew 以前其他软件使用下载都很顺利，但这一次安装Docker却不太行，使用了代理，但总是出现报错

Error response from daemon: Get "https://registry-1.docker.io/v2/": EOF

虽然改了很多代理，但是一直不信。知道去官网下载后就没问题了。

出问题的可能是：
1）Mac的新款M4芯片
2）homebrew安装位置不对，或者版本过低

