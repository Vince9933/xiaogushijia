# Vercel免费部署详细步骤

## 📌 重要前提
- 项目已通过测试：`npm run build` 构建成功 ✅
- 需要两个账号：GitHub和Vercel（均免费）

## 📝 步骤1：创建GitHub仓库

### 1.1 注册GitHub账号
- 访问：https://github.com/
- 点击"Sign up"注册
- 使用邮箱验证并创建密码

### 1.2 创建新仓库
1. 登录后，点击右上角的"+" → "New repository"
2. **仓库信息**：
   - Repository name：输入仓库名（如：`story-platform`）
   - Description：可写可不写
   - Visibility：选择 `Public`（免费版只能创建公开仓库）
3. 点击"Create repository"

## 📝 步骤2：上传项目文件到GitHub

### 2.1 下载GitHub Desktop（推荐）
- 访问：https://desktop.github.com/
- 下载并安装
- 启动后登录GitHub账号

### 2.2 克隆仓库到本地
1. 在GitHub Desktop中，点击"Add" → "Clone repository"
2. 选择您刚创建的仓库 → 点击"Clone"
3. 选择本地保存路径（如：`C:\Users\您的用户名\Documents\GitHub\story-platform`）

### 2.3 上传项目文件
1. 打开克隆的仓库文件夹
2. 复制以下文件/文件夹到该目录：
   - `package.json`、`package-lock.json`
   - `vite.config.ts`、`tsconfig.json`
   - `tailwind.config.js`、`postcss.config.js`
   - `index.html`
   - `src` 文件夹（整个文件夹）
   - `public` 文件夹（如果有）
   - `FREE_DEPLOYMENT_GUIDE.md`（可选）

### 2.4 提交并推送
1. 回到GitHub Desktop
2. 左侧会显示所有修改过的文件
3. 在底部输入：
   - Summary：`Initial commit`
   - Description：`First commit`
4. 点击"Commit to main"
5. 点击"Push origin"（将本地文件推送到GitHub服务器）

## 📝 步骤3：部署到Vercel

### 3.1 注册Vercel账号
- 访问：https://vercel.com/
- 点击"Sign Up" → 选择"Continue with GitHub"
- 授权Vercel访问您的GitHub账号

### 3.2 创建新项目
1. 登录后，点击"New Project"
2. 选择"Import Git Repository"
3. 在"Import from Git Repository"页面，找到并选择您的仓库
4. 点击"Import"

### 3.3 配置项目
在"Configure Project"页面：
- **Framework Preset**：选择 `Vite`
- **Build Command**：保持默认（`npm run build`）
- **Output Directory**：`dist/static`
- **Install Command**：保持默认（`npm install`）
- **Root Directory**：保持默认
- **Environment Variables**：无需设置

### 3.4 部署项目
- 点击"Deploy"
- 等待部署进度条完成（约1-2分钟）

## 📝 步骤4：访问您的网站

### 4.1 部署完成
- 部署成功后，页面会显示"Congratulations! Your project has been deployed."
- 页面底部会显示您的**免费域名**（如：`story-platform.vercel.app`）

### 4.2 访问网站
- 复制该域名到浏览器地址栏
- 按下回车，即可访问您的网站！

## 📝 步骤5：后续更新（可选）

### 5.1 修改代码
- 在本地修改项目文件

### 5.2 重新部署
1. 使用GitHub Desktop提交修改
2. 点击"Push origin"
3. Vercel会**自动**重新构建和部署您的网站
4. 等待几分钟后，刷新网站即可看到更新

## 💡 常见问题解答

### Q1：上传文件时GitHub Desktop显示"没有修改"？
A：确保所有文件都复制到了**仓库文件夹**中，而不是其他地方。

### Q2：Vercel部署失败怎么办？
A：检查构建日志，常见问题：
- Output Directory设置错误（必须是`dist/static`）
- Framework Preset选错（必须是`Vite`）

### Q3：可以绑定自己的域名吗？
A：可以，但需要购买域名（约10-20元/年），Vercel支持免费绑定。

### Q4：免费版有什么限制？
A：
- 每月100GB带宽
- 每月1000次构建
- 适合个人和小型项目完全足够

## 📋 总结

1. ✅ 创建GitHub仓库
2. ✅ 上传项目文件
3. ✅ 导入到Vercel
4. ✅ 一键部署
5. ✅ 获得免费域名

**总耗时**：约15分钟
**费用**：¥0（完全免费）
**难度**：简单（无需命令行）

---

**提示**：如果您遇到任何问题，请查看`FREE_DEPLOYMENT_GUIDE.md`或在GitHub/Vercel官方文档中查找帮助。