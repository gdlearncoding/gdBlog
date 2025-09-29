#!/bin/bash

echo "🚀 开始部署到GitHub Pages..."

# 1. 清理并重新生成静态文件
echo "📦 生成静态文件..."
hexo clean
hexo generate

# 2. 部署到GitHub Pages
echo "🌐 部署到GitHub Pages..."
hexo deploy

echo ""
echo "✅ 部署完成！"
echo "📱 你的博客现在可以通过以下地址访问："
echo "   https://gaoguodong03.github.io/gdBlog/"
echo ""
echo "💡 注意："
echo "   - GitHub Pages可能需要几分钟才能生效"
echo "   - 确保GitHub仓库中已启用GitHub Pages"
echo "   - 设置路径为 master 分支"
