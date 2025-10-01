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
3. 清理现有主题目录避免冲突
4. 使用npm安装hexo-theme-butterfly包
5. 创建主题目录链接
6. 构建和部署

**关键修复点**：
- 清理`themes/butterfly`目录避免本地主题与npm包冲突
- 使用符号链接将npm包主题链接到themes目录
- 确保Hexo能够正确识别主题

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

### 方案三：GitHub Actions专用配置
针对GitHub Actions环境的特殊处理：

#### 方法1：使用sed修改主题配置（推荐）
创建备用工作流文件`.github/workflows/deploy-alternative.yml`，自动修改主题配置：
```yaml
- name: Setup theme configuration
  run: |
    # 备份原始配置
    cp _config.yml _config.yml.backup
    # 修改主题配置为npm包名
    sed -i 's/theme: butterfly/theme: hexo-theme-butterfly/' _config.yml
```

#### 方法2：完全使用npm包主题
手动修改`_config.yml`文件：
```yaml
# 将主题配置改为
# theme: butterfly
# 改为使用npm包名
theme: hexo-theme-butterfly
```

#### 方法3：环境变量控制主题路径
在工作流中添加环境变量：
```yaml
- name: Build with theme path
  env:
    HEXO_THEME_PATH: node_modules/hexo-theme-butterfly
  run: |
    hexo clean
    hexo generate
```

#### 方法4：复制主题文件到themes目录
```yaml
- name: Install theme
  run: |
    npm install hexo-theme-butterfly
    cp -r node_modules/hexo-theme-butterfly themes/butterfly
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

### Q4: 构建过程显示"exit code 2"错误？
A: 这是GitHub Actions环境中的构建错误，可能原因：
- Node.js版本不兼容（建议指定Node.js 18.x）
- 依赖包版本冲突
- 主题配置文件格式错误
- 缺少必要的Hexo插件

**解决方法**：
1. 检查工作流中的Node.js版本设置
2. 确保所有依赖包在package.json中正确声明
3. 检查主题配置文件YAML格式
4. 添加详细的错误日志输出步骤

### Q5: 本地构建正常但GitHub Actions失败？
A: 环境差异导致的问题：
- 本地使用了全局安装的Hexo或主题
- GitHub Actions环境中缺少某些依赖
- 文件路径或权限问题

**解决方法**：
1. 确保所有依赖都在package.json中声明
2. 使用`npm ls`检查本地依赖树
3. 在GitHub Actions中添加调试步骤输出环境信息

## 推荐配置

使用方案一的工作流文件，它已经包含了：
- 正确的依赖安装顺序
- 主题显式安装
- 构建和部署自动化
- 错误处理和日志记录

提交`.github/workflows/deploy.yml`文件后，GitHub Actions会自动运行并解决主题找不到的问题。