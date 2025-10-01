#!/bin/bash

# 自动Git推送脚本
# 每天自动检查更改并推送到远程仓库

# 配置区域
BLOG_DIR="/Users/ggd/Blog/gdBlog"  # 博客目录路径
LOG_FILE="${BLOG_DIR}/auto_git_push.log"  # 日志文件路径
GIT_USER="$(git config user.name)"  # 获取Git用户名
GIT_EMAIL="$(git config user.email)"  # 获取Git邮箱
COMMIT_MESSAGE="Auto commit: $(date '+%Y-%m-%d %H:%M:%S')"  # 自动提交消息

# 确保目录存在
if [ ! -d "${BLOG_DIR}" ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 错误: 博客目录 ${BLOG_DIR} 不存在" >> "${LOG_FILE}"
    exit 1
fi

# 导航到博客目录
cd "${BLOG_DIR}"

# 记录开始时间
echo "[$(date '+%Y-%m-%d %H:%M:%S')] 开始自动Git推送任务" >> "${LOG_FILE}"

# 确保Git配置正确
if [ -z "${GIT_USER}" ] || [ -z "${GIT_EMAIL}" ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 警告: Git用户名或邮箱未配置" >> "${LOG_FILE}"
    # 如果未配置，使用默认值
    git config user.name "Auto Committer" 2>/dev/null
    git config user.email "auto-committer@example.com" 2>/dev/null
fi

# 检查是否有未提交的更改
git status --porcelain | grep -q .
HAS_CHANGES=$?

if [ ${HAS_CHANGES} -eq 0 ]; then
    # 有未提交的更改
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 发现未提交的更改，开始提交..." >> "${LOG_FILE}"
    
    # 拉取最新更改，避免冲突
    # 使用--ff-only参数确保只有在可以快进合并时才会成功
    git pull --ff-only origin master 2>> "${LOG_FILE}"
    if [ $? -ne 0 ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] 错误: Git pull失败，请手动解决冲突" >> "${LOG_FILE}"
        exit 1
    fi
    
    # 添加所有更改
    git add . 2>> "${LOG_FILE}"
    if [ $? -ne 0 ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] 错误: Git add失败" >> "${LOG_FILE}"
        exit 1
    fi
    
    # 提交更改
    git commit -m "${COMMIT_MESSAGE}" 2>> "${LOG_FILE}"
    if [ $? -ne 0 ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] 错误: Git commit失败" >> "${LOG_FILE}"
        exit 1
    fi
    
    # 推送到远程仓库
    git push origin master 2>> "${LOG_FILE}"
    if [ $? -eq 0 ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] 成功: Git push完成" >> "${LOG_FILE}"
    else
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] 错误: Git push失败" >> "${LOG_FILE}"
        exit 1
    fi
else
    # 没有未提交的更改
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 没有发现未提交的更改，无需推送" >> "${LOG_FILE}"
fi

# 记录结束时间
echo "[$(date '+%Y-%m-%d %H:%M:%S')] 自动Git推送任务完成" >> "${LOG_FILE}"
echo "----------------------------------------" >> "${LOG_FILE}"

# 保持日志文件大小合理（可选）
if [ -f "${LOG_FILE}" ]; then
    # 只保留最近300行日志
    tail -n 300 "${LOG_FILE}" > "${LOG_FILE}.tmp"
    mv "${LOG_FILE}.tmp" "${LOG_FILE}"
fiexit 0