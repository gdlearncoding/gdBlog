
echo "🧹 开始清理 Hexo 缓存..."

hexo clean && hexo g && hexo s

echo "🌐 如果服务器正在运行，请访问: http://localhost:4000"
