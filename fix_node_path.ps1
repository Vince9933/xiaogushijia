# 修复Node.js环境变量脚本

# Node.js安装路径
$nodePath = "C:\Program Files\nodejs"

# 检查路径是否存在
if (Test-Path $nodePath) {
    Write-Host "找到Node.js安装路径: $nodePath"
    
    # 获取当前系统PATH环境变量
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    
    # 检查Node.js路径是否已存在于PATH中
    if (-not $currentPath.Contains($nodePath)) {
        # 添加Node.js路径到PATH
        $newPath = $currentPath + ";$nodePath"
        [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
        Write-Host "已将Node.js路径添加到系统环境变量PATH中"
        
        # 也更新当前会话的PATH
        $env:PATH = $env:PATH + ";$nodePath"
        Write-Host "已更新当前会话的PATH环境变量"
    } else {
        Write-Host "Node.js路径已存在于系统环境变量PATH中"
    }
    
    # 测试node和npm命令
    Write-Host "\n测试Node.js和npm命令:"
    try {
        node -v
        npm -v
        Write-Host "\n✅ Node.js和npm命令正常工作！"
    } catch {
        Write-Host "\n❌ 命令测试失败，请尝试重新打开PowerShell终端"
    }
} else {
    Write-Host "未找到Node.js安装路径: $nodePath"
    Write-Host "请检查Node.js是否正确安装"
}