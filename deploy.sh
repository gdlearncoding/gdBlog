#!/bin/bash

echo "🚀 开始部署到GitHub Pages..."

hexo clean
hexo generate
hexo deploy

echo ""
echo "✅ 部署完成！"
echo "📱 你的博客现在可以通过以下地址访问："
echo "   https://gaoguodong03.github.io/gdBlog/"

