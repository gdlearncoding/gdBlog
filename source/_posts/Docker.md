---
title: Docker
date: 2025-09-29
tags:
  - tools
categories: 果冻的航海日志
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