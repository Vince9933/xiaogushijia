# GitHub上传文件的多种方法

## 方法1：通过GitHub网站直接上传（适合少量文件）

### 步骤1：登录GitHub并进入仓库
1. 打开GitHub网站：https://github.com/
2. 登录您的账号
3. 进入您要上传文件的仓库（或创建新仓库）

### 步骤2：上传文件
1. 点击仓库页面上方的 **Add file** 按钮
2. 选择 **Upload files** 选项
3. 拖拽本地文件/文件夹到浏览器窗口，或点击 **choose your files** 选择文件
4. 上传完成后，在页面底部填写：
   - **Commit message**：输入提交信息（如"添加项目文件"）
   - **Description**：可选，添加详细描述
5. 点击 **Commit changes** 完成上传

## 方法2：使用GitHub Desktop（推荐给新手，图形界面）

### 步骤1：下载并安装GitHub Desktop
1. 访问：https://desktop.github.com/
2. 下载Windows版本并安装
3. 启动后使用GitHub账号登录

### 步骤2：克隆仓库到本地
1. 在GitHub Desktop中，点击 **File** → **Clone repository**
2. 选择 **GitHub.com** 标签页
3. 选择您的仓库 → 点击 **Clone**
4. 选择本地保存路径（如：`C:\Users\您的用户名\Documents\GitHub\仓库名`）

### 步骤3：上传项目文件
1. 打开克隆的仓库文件夹
2. 将您的项目文件复制到该文件夹（如：`package.json`、`src`文件夹等）
3. 返回GitHub Desktop，左侧会显示所有添加的文件

### 步骤4：提交并推送
1. 在底部输入：
   - **Summary**：提交信息（如"Initial commit"）
   - **Description**：可选，添加详细描述
2. 点击 **Commit to main**
3. 点击 **Push origin** 将文件推送到GitHub服务器

## 方法3：使用Git命令行（适合熟悉命令行的用户）

### 步骤1：安装Git
1. 访问：https://git-scm.com/download/win
2. 下载并安装Git for Windows
3. 打开Git Bash（安装后在开始菜单搜索）

### 步骤2：配置Git
```bash
git config --global user.name "您的GitHub用户名"
git config --global user.email "您的GitHub邮箱"
```

### 步骤3：克隆仓库
```bash
git clone https://github.com/您的用户名/您的仓库名.git
cd 您的仓库名
```

### 步骤4：添加文件并提交
```bash
# 将项目文件复制到当前文件夹后执行
git add .  # 添加所有文件
git commit -m "Initial commit"  # 提交文件
```

### 步骤5：推送到GitHub
```bash
git push origin main
```

## 上传项目文件的注意事项

### 1. 需要上传的核心文件（针对React+Vite项目）
- 配置文件：`package.json`、`vite.config.ts`、`tsconfig.json`
- 构建配置：`tailwind.config.js`、`postcss.config.js`
- 源码文件：`src`文件夹、`index.html`
- 其他：`.gitignore`（避免上传不必要的文件）

### 2. 不要上传的文件
- `node_modules`文件夹（依赖包，体积大）
- `dist`文件夹（构建产物，可自动生成）
- IDE配置文件（如`.vscode`、`.idea`）
- 系统文件（如`Thumbs.db`）

### 3. 常见问题解决

#### Q：上传失败提示权限不足？
A：确保您是仓库的所有者或有写入权限，检查GitHub账号是否正确登录。

#### Q：文件太大上传超时？
A：使用Git LFS（大文件存储）或分批次上传，避免单个文件超过100MB。

#### Q：GitHub Desktop显示"没有修改"？
A：确保文件复制到了正确的仓库文件夹，而不是其他位置。

## 上传完成后的下一步

上传文件到GitHub后，您可以继续部署项目：
1. 部署到Vercel：https://vercel.com/
2. 部署到Netlify：https://www.netlify.com/
3. 部署到GitHub Pages：https://pages.github.com/

根据之前的指南，推荐使用Vercel进行一键部署，获得免费域名！