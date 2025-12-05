# 极简部署方案（无需Git/GitHub Desktop）

如果您遇到GitHub Desktop的问题（如Commit按钮无法点击），这很可能是因为**系统未安装Git**。以下是一个完全不需要Git的极简部署方案：

## 📌 方案：直接使用Netlify拖拽部署

### 步骤1：构建项目
1. 打开命令提示符（CMD）
2. 进入项目目录：`cd 您的项目路径`
3. 运行构建命令：`npm run build`
4. 构建成功后，会生成一个 `dist/static` 文件夹

### 步骤2：部署到Netlify
1. 访问：https://app.netlify.com/drop
2. **拖拽**项目根目录下的 `dist/static` 文件夹到浏览器窗口
3. 等待部署完成（约1-2分钟）

### 步骤3：访问网站
- 部署完成后，Netlify会提供一个免费域名
- 直接访问该域名即可

## 📌 为什么选择这个方案？
- ✅ **无需Git/GitHub Desktop**：避免复杂的版本控制设置
- ✅ **无需账号**：初始部署可以不用注册账号
- ✅ **一键完成**：只需拖拽文件夹即可
- ✅ **完全免费**：与其他方案一样提供免费域名和服务

## 📌 如果需要更新网站怎么办？
1. 重新运行 `npm run build` 构建项目
2. 再次访问 https://app.netlify.com/drop
3. 拖拽新生成的 `dist/static` 文件夹即可覆盖更新

## 📌 注意事项
- 确保您拖拽的是 `dist/static` 文件夹，而不是整个 `dist` 文件夹
- 如果需要自定义域名或持续部署功能，建议注册Netlify账号
- 免费版提供足够的流量（100GB/月）和带宽

## 📌 替代方案：使用Vercel CLI部署

如果您熟悉命令行，也可以使用Vercel CLI进行部署：

1. 安装Vercel CLI：`npm install -g vercel`
2. 进入项目目录：`cd 您的项目路径`
3. 运行部署命令：`vercel`
4. 按照提示完成配置（非常简单）

## 📌 解决Git安装问题（如果您想继续使用GitHub）

如果您仍然想使用GitHub Desktop，需要先安装Git：

1. 下载Git：https://git-scm.com/download/win
2. 安装Git：
   - 保持默认设置即可
   - 注意：在"Adjusting your PATH environment"步骤中，选择"Git from the command line and also from 3rd-party software"
3. 重新启动GitHub Desktop
4. 此时Commit按钮应该可以正常点击了

---

这个极简方案适合初学者，避免了复杂的Git配置，让您可以快速部署网站！