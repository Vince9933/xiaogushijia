# 通用部署故障排除指南

## 🚨 第一步：收集错误信息

请先收集以下信息，以便更准确地定位问题：
1. 使用的**部署平台**（Vercel/Netlify/GitHub Pages/腾讯云等）
2. 完整的**错误日志**或截图
3. 执行的**具体命令**和输出
4. 尝试部署的**具体步骤**

## 📋 各平台常见错误及解决方案

### 1. Vercel 部署错误

#### 错误类型：构建失败 - Output Directory 错误
**错误信息**：`Error: Output directory 'dist/static' does not exist`
**解决方案**：
- 检查 `vite.config.ts` 中 `outDir` 配置是否正确
- 确保使用 `npm run build` 命令（而非 `build:client`）

#### 错误类型：路由刷新 404
**解决方案**：
- 确保使用 React Router 的 `createBrowserRouter` 或 `BrowserRouter`
- 在 Vercel 控制台的项目设置中，添加 `redirects` 配置：
  ```json
  {
    "redirects": [
      { "source": "/(.*)", "destination": "/", "permanent": false }
    ]
  }
  ```

### 2. Netlify 部署错误

#### 错误类型：构建命令失败
**错误信息**：`Build failed due to a user error`
**解决方案**：
- 检查构建命令是否正确（应为 `npm run build`）
- 检查发布目录是否为 `dist/static`
- 在 Netlify 控制台中添加构建环境变量：`NODE_VERSION=18.x`

#### 错误类型：页面空白
**解决方案**：
- 检查 `index.html` 中 `base href` 是否正确
- 确保构建产物路径正确

### 3. GitHub Pages 部署错误

#### 错误类型：404 Not Found
**解决方案**：
- 修改 `vite.config.ts` 中的 `base` 配置为 `/仓库名称/`
- 确保 `gh-pages` 包已正确安装
- 使用 `npm run deploy:github` 命令部署

#### 错误类型：资源加载失败
**解决方案**：
- 检查所有静态资源路径是否使用相对路径
- 确保 `base` 配置正确

### 4. 腾讯云部署错误

#### 错误类型：端口访问失败
**解决方案**：
- 检查安全组是否开放 3000 端口
- 检查服务器防火墙是否开放 3000 端口
- 确保使用 `npm start` 命令启动服务

#### 错误类型：依赖安装失败
**解决方案**：
- 使用 `npm install --legacy-peer-deps` 安装依赖
- 检查 Node.js 版本是否 ≥ 16.x

## 🛠️ 通用排查步骤

### 步骤 1：本地构建测试
```bash
# 清除旧的构建产物
rd /s /q dist 2>nul

# 执行构建命令
npm run build

# 检查构建产物
ls -la dist/static/
```

**预期结果**：
- `dist/static/index.html` 文件存在
- `dist/static/assets` 目录包含 CSS 和 JS 文件

### 步骤 2：检查项目配置

#### 检查 package.json
- 确保 `scripts` 中的构建命令正确
- 检查 `dependencies` 是否包含所有必要依赖

#### 检查 vite.config.ts
- `base` 配置是否正确（仅 GitHub Pages 需要）
- `outDir` 是否设置为 `dist/static`

### 步骤 3：验证依赖安装
```bash
# 清除缓存
npm cache clean --force

# 删除旧依赖
rd /s /q node_modules 2>nul
rd /s /q package-lock.json 2>nul

# 重新安装
npm install
```

### 步骤 4：检查代码质量
```bash
# 检查 TypeScript 错误
npx tsc --noEmit
```

## 🔧 特定错误解决方案

### 错误：Module not found
**原因**：缺少依赖或路径错误
**解决方案**：
- 安装缺失的依赖：`npm install 缺失的包名`
- 检查导入路径是否正确

### 错误：SyntaxError: Cannot use import statement outside a module
**原因**：Node.js 模块类型配置错误
**解决方案**：
- 确保 `package.json` 中 `type` 字段为 `module`
- 对于 CommonJS 文件，使用 `.cjs` 扩展名

### 错误：Failed to load module script
**原因**：构建产物路径错误
**解决方案**：
- 检查 `index.html` 中资源引用路径
- 确保 `vite.config.ts` 中的 `base` 配置正确

## 📞 获取帮助

如果以上方法都无法解决问题，请提供以下信息：
1. 完整的错误日志
2. 部署平台名称
3. Node.js 和 npm 版本
4. 执行的具体命令

我将根据您提供的信息，为您提供更具体的解决方案！