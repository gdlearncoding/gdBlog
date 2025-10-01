# GitHub Actions Butterfly主题错误解决方案

## 问题描述
在GitHub Actions构建过程中出现错误：
```
Error: The butterfly theme could not be found.
```

## 问题原因分析
1. 本地环境中butterfly主题通过`themes/butterfly/`目录存在
2. GitHub Actions环境中没有正确安装或识别主题
3. 主题依赖可能没有正确安装

## 解决方案

### 方案一：使用GitHub Actions工作流（推荐）
已创建`.github/workflows/deploy.yml`文件，包含以下关键步骤：
1. 检出代码（包含子模块）
2. 安装Node.js和npm依赖
3. 显式安装hexo-theme-butterfly
4. 构建和部署

### 方案二：修改主题配置方式

#### 方法1：使用npm包主题
修改`_config.yml`中的主题配置：
```yaml
# 将
# theme: butterfly
# 改为
theme: hexo-theme-butterfly
```

#### 方法2：确保主题目录被Git跟踪
检查`.gitignore`文件，确保没有忽略主题目录：
```bash
# 查看当前gitignore
cat .gitignore

# 确保没有这一行（如果有就删除）
# themes/
```

#### 方法3：添加主题作为Git子模块
```bash
# 删除现有的主题目录
rm -rf themes/butterfly

# 添加为Git子模块
git submodule add https://github.com/jerryc127/hexo-theme-butterfly.git themes/butterfly
```

### 方案三：手动安装主题依赖
在GitHub Actions工作流中添加主题安装步骤：

```yaml
- name: Install Butterfly theme
  run: |
    git clone https://github.com/jerryc127/hexo-theme-butterfly.git themes/butterfly
    npm install hexo-theme-butterfly
```

## 验证步骤

1. **本地测试**：
```bash
hexo clean
hexo generate
```

2. **GitHub Actions测试**：
提交代码到master分支，查看Actions运行状态

3. **检查主题文件**：
```bash
ls -la themes/butterfly/
```

## 常见问题

### Q1: 主题文件存在但仍然报错？
A: 确保主题目录结构正确，主配置文件`_config.yml`中的主题名称与目录名一致。

### Q2: 使用npm包主题后样式异常？
A: 检查`_config.butterfly.yml`配置文件是否正确，主题插件是否安装完整。

### Q3: GitHub Actions构建成功但页面空白？
A: 检查部署分支是否正确，GitHub Pages设置是否指向正确的分支。

## 推荐配置

使用方案一的工作流文件，它已经包含了：
- 正确的依赖安装顺序
- 主题显式安装
- 构建和部署自动化
- 错误处理和日志记录

提交`.github/workflows/deploy.yml`文件后，GitHub Actions会自动运行并解决主题找不到的问题。