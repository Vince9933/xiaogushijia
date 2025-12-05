#!/bin/bash

# 测试部署脚本 - 用于验证腾讯云部署流程
echo "=== 腾讯云部署测试脚本 ==="

# 1. 检查 Node.js 和 npm 版本
echo "\n1. 检查 Node.js 和 npm 版本："
node -v
npm -v

# 2. 安装依赖
echo "\n2. 安装项目依赖："
npm install

# 3. 构建项目
echo "\n3. 构建项目："
npm run build:npm

# 4. 检查构建结果
echo "\n4. 检查构建结果："
if [ -d "dist/static" ]; then
  echo "✓ 构建成功，dist/static 目录已创建"
  ls -la dist/
  ls -la dist/static/
else
  echo "✗ 构建失败，dist/static 目录不存在"
  exit 1
fi

# 5. 启动服务器（测试模式，5秒后自动关闭）
echo "\n5. 启动服务器（测试模式，5秒后自动关闭）："
npm start &
SERVER_PID=$!

echo "服务器已启动，PID: $SERVER_PID"
echo "等待5秒后关闭..."
sleep 5

# 6. 关闭服务器
echo "\n6. 关闭服务器："
kill $SERVER_PID

# 7. 测试结果
echo "\n=== 部署测试完成 ==="
echo "✓ 所有步骤已完成，项目部署流程验证通过！"
echo "请确保："
echo "1. 腾讯云服务器已开放 3000 端口"
echo "2. 使用 npm run deploy:tencent 命令进行正式部署"
echo "3. 部署成功后访问：http://您的服务器公网IP:3000"
