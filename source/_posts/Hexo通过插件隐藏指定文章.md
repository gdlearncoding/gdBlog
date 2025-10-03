---
title: Hexo通过插件隐藏指定文章
date: 2025-10-02
tags:
  - Hexo
categories: 果冻的奇妙小工具
cover: ./img/logoHexo.jpg
---
由于本人感觉记不住昨天或者前几天发生的事情, 因此打算写点日记, 但是又没必要让所有人看到, 不必在首页展示, 因此想添加文章隐藏功能. **同时又不想修改Butterfly主题源代码**, 原因在于作为一名开发者，还是想使用增量更新，而不是修改原来的内容. 终于！找到了[hexo-hide-posts](https://github.com/prinsss/hexo-hide-posts)这个Hexo 插件，它能够隐藏指定的文章，并使它们仅可通过链接访问

可以直接参考[README_ZH | hexo-hide-posts](https://github.com/prinsss/hexo-hide-posts/blob/master/README_ZH.md)来进行配置，这里记录我的配置步骤。
## 安装

在项目目录执行以下命令安装插件：
```
npm install hexo-hide-posts
```
安装完成后在项目根目录的`_config.yml`中添加如下内容：
```
# 文章隐藏：https://github.com/prinsss/hexo-hide-posts
hide_posts:
  enable: true # 是否启用 hexo-hide-posts
  filter: hidden # 隐藏文章的 front-matter 标识，也可以改成其他你喜欢的名字
  noindex: true # 为隐藏的文章添加 noindex meta 标签，阻止搜索引擎收录
  # 设置白名单，白名单中的 generator 可以访问隐藏文章
  # 常见的 generators 有：index, tag, category, archive, sitemap, feed, etc.
  # allowlist_generators: []
  allowlist_generators: ['*']
  
  # 设置黑名单，黑名单中的 generator 不可以访问隐藏文章
  # 如果同时设置了黑名单和白名单，白名单的优先级更高
  # blocklist_generators: ['*']
  blocklist_generators: ['index', 'feed']

```
## 使用

如果在`_config.yml`中的配置为`filter: hidden`，则在文章的 [front-matter](https://hexo.io/docs/front-matter) 中添加 `hidden: true` 即可隐藏文章，如：

```
---  
title: '被隐藏的文章'  
date: '2025-10-02'  
hidden: true  
---
```

## 特别鸣谢

文章作者: [InsectMk](https://insectmk.cn/)
原文链接:[https://insectmk.cn/posts/9c83ed78/](https://insectmk.cn/posts/9c83ed78/)
参考文章:[README_ZH | hexo-hide-posts](https://github.com/prinsss/hexo-hide-posts/blob/master/README_ZH.md)