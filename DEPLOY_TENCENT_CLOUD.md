# 腾讯云部署指南

本指南将帮助您将项目部署到腾讯云服务器上。

## 环境准备

### 1. 本地环境
- 安装 Node.js (建议版本 16.x 或更高)
- 安装 pnpm 或 npm

### 2. 腾讯云服务器
- 购买并创建一台腾讯云 CVM 实例
- 确保服务器已安装 Node.js (建议版本 16.x 或更高)
- 配置安全组，开放 3000 端口（或您想要使用的端口）

## 项目配置说明

### 1. 构建脚本
项目配置了跨平台的构建脚本：

```json
"scripts": {
  "build": "rd /s /q dist 2>nul || true && pnpm build:client && copy package.json dist && echo. > dist/build.flag",
  "build:npm": "rm -rf dist || true && npm run build:client && cp package.json dist/ && touch dist/build.flag"
}
```

- `build`：Windows 平台专用脚本
- `build:npm`：Linux/Mac 平台专用脚本（腾讯云服务器使用此脚本）

### 2. 服务器配置
已添加 `server.cjs` 文件（注意扩展名为 `.cjs`），使用 Express 框架提供静态文件服务和客户端路由支持。

### 3. 启动脚本
添加了适合腾讯云的启动脚本：

```json
"scripts": {
  "start": "node server.cjs",
  "deploy:tencent": "npm run build:npm && npm start"
}
```

## 部署步骤

### 方法一：腾讯云网页控制台部署（推荐新手）

#### 1. 创建腾讯云 CVM 实例

1. **登录腾讯云控制台**：
   - 访问 [腾讯云官网](https://cloud.tencent.com/)
   - 点击右上角 "登录"，使用您的账号登录

2. **创建 CVM 实例**：
   - 在控制台左侧导航栏，选择 "云服务器 CVM"
   - 点击 "新建实例"
   - **计费模式**：选择 "包年包月" 或 "按量计费"
   - **地域**：选择靠近您目标用户的地域
   - **可用区**：选择 "随机分配"
   - **实例规格**：
     - 对于小型应用，选择 "标准型 S5" 系列，1核2G 或 2核4G 即可
   - **镜像**：
     - 选择 "公共镜像"
     - 操作系统选择 "CentOS 7.6 64位" 或 "Ubuntu Server 20.04 LTS 64位"
   - **存储**：
     - 系统盘：默认配置即可（50GB 云硬盘）
   - **网络与安全组**：
     - 选择您的 VPC 和子网
     - **安全组**：点击 "新建安全组"，配置如下规则：
       - 入站规则：添加 "TCP" 协议，端口 "3000"，来源 "0.0.0.0/0"
       - 入站规则：添加 "TCP" 协议，端口 "22"，来源 "0.0.0.0/0"（用于 SSH 连接）
   - **登录方式**：
     - 选择 "设置密码"，设置您的登录密码
   - **实例名称**：输入您想要的实例名称
   - **购买数量**：1
   - 点击 "立即购买"，完成支付

3. **等待实例创建完成**：
   - 返回 CVM 实例列表，等待实例状态变为 "运行中"

#### 2. 安装 Node.js 环境

1. **登录实例**：
   - 在 CVM 实例列表中，找到您创建的实例，点击右侧的 "登录"
   - 选择 "登录方式" 为 "腾讯云网页控制台登录"
   - 输入您设置的密码，点击 "登录"

2. **安装 Node.js**（以 CentOS 为例）：
   ```bash
   # 更新系统
   yum update -y
   
   # 安装 Node.js 18.x
   curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
   yum install -y nodejs
   
   # 验证安装
   node -v
   npm -v
   ```

   **如果是 Ubuntu 系统**：
   ```bash
   # 更新系统
   apt update -y
   apt upgrade -y
   
   # 安装 Node.js 18.x
   curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
   apt install -y nodejs
   
   # 验证安装
   node -v
   npm -v
   ```

#### 3. 上传项目文件

1. **在网页控制台上传文件**：
   - 登录到 CVM 实例的网页控制台
   - 点击顶部的 "文件"
   - 点击 "上传文件"
   - 选择本地项目根目录下的以下文件：
     - `package.json`
     - `server.js`
     - `vite.config.ts`
     - `tsconfig.json`
     - `tailwind.config.js`
     - `postcss.config.js`
     - `index.html`
     - 以及整个 `src` 目录（如果网页控制台不支持直接上传目录，可以先压缩为 ZIP 文件，上传后解压）

2. **如果上传了 ZIP 文件**，需要解压：
   ```bash
   # 安装 unzip
   yum install -y unzip  # CentOS
   # 或
   apt install -y unzip  # Ubuntu
   
   # 解压文件
   unzip your-project.zip
   ```

#### 4. 构建和启动项目

1. **进入项目目录**：
   ```bash
   cd /path/to/your/project
   ```

2. **安装依赖**：
   ```bash
   npm install
   ```

3. **构建项目**：
   ```bash
   npm run build:npm
   ```

4. **启动服务器**：
   ```bash
   npm start
   ```

5. **验证部署成功**：
   - 在浏览器中访问：`http://您的服务器公网IP:3000`
   - 如果能看到项目页面，说明部署成功

### 方法二：手动部署（使用 FTP/SCP）

1. **本地构建项目**
   ```bash
   # 使用 pnpm
   pnpm install
   pnpm run build
   
   # 或使用 npm
   npm install
   npm run build:npm
   ```

2. **上传构建文件到服务器**
   使用 FTP 或 SCP 工具将 `dist` 目录和 `server.js` 文件上传到腾讯云服务器。

3. **在服务器上启动服务**
   ```bash
   # 进入项目目录
   cd /path/to/your/project
   
   # 安装依赖
   npm install --production
   
   # 启动服务器
   npm start
   ```

### 方法二：使用 Git 自动部署

1. **在服务器上安装 Git**
   ```bash
   sudo apt-get update
   sudo apt-get install git
   ```

2. **克隆项目到服务器**
   ```bash
   git clone <your-repository-url>
   cd <your-project-directory>
   ```

3. **安装依赖并构建**
   ```bash
   npm install
   npm run build:npm
   ```

4. **启动服务**
   ```bash
   npm start
   ```

### 方法三：使用 PM2 管理进程

为了确保服务持续运行，建议使用 PM2 管理进程。

1. **在服务器上安装 PM2**
   ```bash
   npm install -g pm2
   ```

2. **使用 PM2 启动服务**
   ```bash
   pm2 start server.js --name "your-app-name"
   ```

3. **设置 PM2 开机自启**
   ```bash
   pm2 startup
   pm2 save
   ```

## 配置 Nginx（可选）

如果需要使用域名访问，可以配置 Nginx 作为反向代理。

1. **安装 Nginx**
   ```bash
   sudo apt-get install nginx
   ```

2. **配置 Nginx**
   ```bash
   sudo nano /etc/nginx/sites-available/your-domain.conf
   ```

3. **添加以下配置**
   ```nginx
   server {
       listen 80;
       server_name your-domain.com;

       location / {
           proxy_pass http://localhost:3000;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }
   }
   ```

4. **启用配置**
   ```bash
   sudo ln -s /etc/nginx/sites-available/your-domain.conf /etc/nginx/sites-enabled/
   sudo nginx -t
   sudo systemctl restart nginx
   ```

## 常见问题解决

### 1. 构建失败

#### 错误：`rm: command not found` 或 `cp: command not found`
**原因**：使用了错误的构建脚本，Windows 脚本在 Linux 服务器上不兼容
**解决方法**：确保使用 `npm run build:npm` 而不是 `npm run build`

#### 错误：`ERR_MODULE_NOT_FOUND` 或 `SyntaxError: Cannot use import statement outside a module`
**原因**：Node.js 模块类型冲突（项目使用 ES Modules 但服务器文件使用 CommonJS）
**解决方法**：服务器文件已命名为 `server.cjs`（使用 CommonJS 语法），确保启动命令正确

#### 错误：构建过程中依赖安装失败
**原因**：网络问题或依赖版本冲突
**解决方法**：
```bash
# 清除 npm 缓存
npm cache clean --force

# 删除 node_modules 重新安装
rm -rf node_modules package-lock.json
npm install
```

### 2. 服务器启动失败

#### 错误：`Error: Cannot find module 'express'`
**原因**：没有安装生产依赖
**解决方法**：
```bash
npm install --production
```

#### 错误：端口被占用
**原因**：3000 端口已被其他进程占用
**解决方法**：
```bash
# 查看占用端口的进程
lsof -i :3000

# 终止占用端口的进程
kill -9 <PID>
```

### 3. 页面无法访问

#### 错误：连接超时
**原因**：
- 安全组未开放 3000 端口
- 服务器防火墙未开放端口
- 服务器未启动

**解决方法**：
1. 在腾讯云控制台配置安全组，开放 3000 端口
2. 检查服务器防火墙设置：
   ```bash
   # CentOS 7+
   firewall-cmd --add-port=3000/tcp --permanent
   firewall-cmd --reload
   
   # Ubuntu
   ufw allow 3000/tcp
   ```
3. 确保服务器正在运行：`npm start`

#### 错误：404 Not Found
**原因**：
- 构建文件路径错误
- 客户端路由配置问题

**解决方法**：
- 检查 `dist/static` 目录是否存在
- 确保 `server.cjs` 中的静态文件路径正确

### 4. 页面刷新后 404
**原因**：客户端路由（如 React Router）需要服务器支持
**解决方法**：确保 `server.cjs` 中包含以下配置（已配置）：
```javascript
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'dist', 'static', 'index.html'));
});
```

## 最佳实践

1. **使用 PM2 管理进程**：确保应用在服务器重启后自动启动
   ```bash
   npm install -g pm2
   pm2 start "npm start" --name "story-book"
   pm2 startup
   pm2 save
   ```

2. **配置 Nginx 反向代理**：提高性能和安全性
   ```nginx
   server {
     listen 80;
     server_name your-domain.com;
     
     location / {
       proxy_pass http://localhost:3000;
       proxy_http_version 1.1;
       proxy_set_header Upgrade $http_upgrade;
       proxy_set_header Connection 'upgrade';
       proxy_set_header Host $host;
       proxy_cache_bypass $http_upgrade;
     }
   }
   ```

3. **定期备份**：项目文件和数据
4. **监控服务器**：资源使用情况
5. **及时更新依赖**：修复安全漏洞
6. **使用环境变量**：配置端口和敏感信息
7. **启用 HTTPS**：在腾讯云控制台申请 SSL 证书并配置

## 联系方式

如果在部署过程中遇到问题，请随时联系技术支持。
