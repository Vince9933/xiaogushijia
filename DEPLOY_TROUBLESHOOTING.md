# 腾讯云部署故障排除指南

## 部署失败检查清单

### 1. 服务器环境检查
- [ ] 服务器已安装 Node.js 16.x 或更高版本
- [ ] 已安装 npm 或 pnpm
- [ ] 安全组已开放 3000 端口
- [ ] 服务器防火墙已开放 3000 端口
- [ ] 服务器有足够的磁盘空间

### 2. 项目配置检查
- [ ] 使用的是 `npm run build:npm`（Linux 专用脚本）而非 `npm run build`
- [ ] 服务器文件是 `server.cjs`（不是 `server.js`）
- [ ] `package.json` 中的 `start` 命令指向 `node server.cjs`
- [ ] 项目依赖已正确安装

### 3. 构建结果检查
- [ ] `dist/static` 目录已创建
- [ ] `dist/static/index.html` 文件存在
- [ ] `dist/static/assets` 目录包含构建后的资源文件

## 详细故障排除步骤

### 步骤 1: 检查 Node.js 和 npm 版本
```bash
# 在腾讯云服务器上执行
node -v
npm -v
```

**预期结果**：Node.js 版本 ≥ 16.x，npm 版本 ≥ 8.x

### 步骤 2: 检查项目目录结构
```bash
# 进入项目目录
cd /path/to/your/project

# 查看项目文件
ls -la
```

**预期结果**：
- 包含 `package.json`、`server.cjs`、`index.html`、`src` 目录
- 包含 `vite.config.ts`、`tsconfig.json` 等配置文件

### 步骤 3: 清除缓存并重新安装依赖
```bash
# 清除 npm 缓存
npm cache clean --force

# 删除 node_modules 和 package-lock.json
rm -rf node_modules package-lock.json

# 重新安装依赖
npm install
```

### 步骤 4: 执行构建命令并观察输出
```bash
# 使用 Linux 兼容的构建脚本
npm run build:npm
```

**重点关注**：
- 是否有依赖安装错误
- 是否有编译错误
- 构建完成后是否显示 "Build completed successfully"

### 步骤 5: 检查构建结果
```bash
# 检查 dist 目录结构
ls -la dist/
ls -la dist/static/
```

**预期结果**：
- `dist/static` 目录存在
- `dist/static/index.html` 存在
- `dist/static/assets` 目录包含 CSS 和 JavaScript 文件

### 步骤 6: 启动服务器并观察日志
```bash
# 启动服务器
npm start
```

**预期结果**：
- 显示 "Server is running on port 3000"
- 无错误信息

### 步骤 7: 检查端口是否正在监听
```bash
# 检查 3000 端口是否被占用
lsof -i :3000

# 或使用 netstat
netstat -tuln | grep 3000
```

**预期结果**：
- 显示 Node.js 进程正在监听 3000 端口

### 步骤 8: 检查安全组和防火墙
```bash
# 检查防火墙状态（CentOS）
sudo firewall-cmd --list-ports

# 检查防火墙状态（Ubuntu）
sudo ufw status
```

**预期结果**：
- 3000 端口已开放

## 常见错误及解决方案

### 错误 1: `npm: command not found`
**原因**：服务器未安装 Node.js
**解决方法**：
```bash
# CentOS 安装 Node.js 18.x
curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs

# Ubuntu 安装 Node.js 18.x
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs
```

### 错误 2: `Error: Cannot find module 'express'`
**原因**：未安装依赖或依赖安装不完整
**解决方法**：
```bash
# 重新安装所有依赖
rm -rf node_modules package-lock.json
npm install
```

### 错误 3: 构建失败 - 依赖冲突
**原因**：依赖版本不兼容
**解决方法**：
```bash
# 使用 --legacy-peer-deps 选项安装依赖
npm install --legacy-peer-deps
```

### 错误 4: 服务器启动后无法访问
**原因**：端口未开放或防火墙阻止
**解决方法**：
```bash
# CentOS 开放 3000 端口
sudo firewall-cmd --add-port=3000/tcp --permanent
sudo firewall-cmd --reload

# Ubuntu 开放 3000 端口
sudo ufw allow 3000/tcp
sudo ufw reload
```

### 错误 5: 页面刷新后 404
**原因**：客户端路由未正确配置
**解决方法**：
确保 `server.cjs` 包含以下配置（已默认配置）：
```javascript
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'dist', 'static', 'index.html'));
});
```

## 一键诊断脚本

执行以下命令运行诊断脚本：

```bash
#!/bin/bash

echo "=== 腾讯云部署诊断工具 ==="

# 检查 Node.js 和 npm 版本
echo "\n1. Node.js 和 npm 版本："
node -v
npm -v

# 检查项目目录
echo "\n2. 项目目录结构："
ls -la

# 检查依赖
echo "\n3. 检查依赖安装："
if [ -d "node_modules" ]; then
  echo "✓ node_modules 存在"
else
  echo "✗ node_modules 不存在"
fi

# 检查构建目录
echo "\n4. 检查构建结果："
if [ -d "dist/static" ]; then
  echo "✓ dist/static 目录存在"
  ls -la dist/static/
else
  echo "✗ dist/static 目录不存在"
  echo "   建议运行：npm run build:npm"
fi

# 检查服务器文件
echo "\n5. 检查服务器文件："
if [ -f "server.cjs" ]; then
  echo "✓ server.cjs 存在"
else
  echo "✗ server.cjs 不存在"
fi

# 检查端口
echo "\n6. 检查端口监听："
lsof -i :3000 || echo "3000 端口未被占用"

# 检查安全组规则
echo "\n7. 检查防火墙规则："
if command -v firewall-cmd &> /dev/null; then
  sudo firewall-cmd --list-ports
elif command -v ufw &> /dev/null; then
  sudo ufw status
else
  echo "未检测到防火墙管理工具"
fi

echo "\n=== 诊断完成 ==="
```

将上述内容保存为 `diagnose.sh`，然后执行：
```bash
chmod +x diagnose.sh
./diagnose.sh
```

## 直接部署方案

如果以上方法都无法解决问题，可以尝试以下简化的部署方案：

```bash
# 1. 创建一个新的部署目录
mkdir -p /opt/storybook
cd /opt/storybook

# 2. 克隆或上传项目文件
# 可以使用 git clone 或 scp 命令上传文件

# 3. 安装依赖
npm install --legacy-peer-deps

# 4. 构建项目
npm run build:npm

# 5. 使用 PM2 启动服务
npm install -g pm2
pm2 start "node server.cjs" --name storybook
pm2 startup
pm2 save
```

## 联系支持

如果按照以上步骤仍无法解决问题，请提供以下信息，以便进一步分析：

1. 完整的错误日志输出
2. 服务器操作系统类型和版本
3. Node.js 和 npm 版本
4. 执行的具体命令和输出
5. 服务器安全组配置截图

您可以通过腾讯云控制台或工单系统联系腾讯云技术支持，他们可以帮助您检查服务器配置和网络问题。
