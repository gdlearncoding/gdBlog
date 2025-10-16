---
title: Dify本地部署
date: 2025-10-09
tags:
  - Dify
  - LLM
  - tools
  - Docker
categories: 果冻的奇妙小工具
cover: ./img/logoDify.jpg
---
## 什么是Dify？

Dify 是一款开源的大语言模型（LLM）应用开发平台，它巧妙地融合了后端即服务（BaaS）与大型语言模型运维（LLMOps）的核心理念。Dify 的命名源自“Define + Modify”，寓意着开发者可以定义并持续改进其 AI 应用，同时也致力于“为你而做”（Do it for you）。该平台旨在帮助开发者乃至非技术人员，快速构建并上线生产级的生成式 AI 应用，并支持非技术人员便捷地参与 AI 应用的定义与数据运营。

## Dify搭建

用户既可以通过访问 “[https://cloud.dify.ai/](https://cloud.dify.ai/)” 在线使用 Dify（需要 GitHub 或 Google 账号授权），也可以选择在本地环境中部署 Dify 社区版（此为开源版本）。下文将重点介绍如何基于 Docker Compose 部署 Dify 社区版。
在开始安装 Dify 之前，请确保您的设备至少具备 **双核（2 core）处理器** 和 **4GB 以上内存**。以下步骤将演示如何在 Mac 系统中运行 Dify。首先，您需要安装 Docker Desktop 以支持 Docker 容器的运行，随后即可通过 Docker 来部署和运行 Dify。

### **下载安装Docker Desktop**

我们可以使用官网链接“https://docs.docker.com/get-started/get-docker/”下载Docker Desktop使用[[Docker]]

### **基于Docker部署Dify**

在”https://github.com/langgenius/dify″中下载Dify，，下载完成后，将压缩包解压到我们指定的位置，通过如下命令启动Dify:
**进入 Dify 的 Docker 配置目录**:

在终端中，我们需要进入到包含 docker-compose.yaml 文件的目录，使用终端命令进行本地部署Dify,  -d 参数表示在后台运行。
```
cd dify/docker
docker-compose up -d
```

一旦所有容器都成功启动，你就可以在你的网页浏览器中访问 Dify 了。

默认情况下，Dify 应该可以通过以下地址访问：**http://localhost/** 或 **http://127.0.0.1/**

**运行停止命令**

```
docker-compose down
```