# Develop Branch 安裝設定完成

## ✅ 已完成的修改

### 1. install.sh 腳本修改
- ✅ 下載 URL 改為指向 `develop` branch
- ✅ 解壓縮目錄名稱更新為 `claude-code-spec-workflow-develop`
- ✅ 測試語法和下載 URL 正常

### 2. 策略選擇：Always Latest
- 📦 使用者將獲得最新的開發版本
- 🚀 開發完成後立即可用
- 🔄 無需等待 merge 到 main branch

## 🎯 新的使用方式

使用者現在可以用這個命令安裝：

```bash
curl -fsSL https://raw.githubusercontent.com/ksin751119/claude-code-spec-workflow/develop/install.sh | bash
```

## 📋 接下來的步驟

### 1. 推送到 develop branch
```bash
git add install.sh INSTALL_SETUP.md DEVELOP_BRANCH_SETUP.md
git commit -m "Modify install.sh to use develop branch for Always Latest strategy

- Change download URL to point to develop branch
- Update extraction directory name
- Users now get latest development version immediately
- No need to wait for releases or main branch merges"

git push origin develop
```

### 2. 更新專案文檔
在你的 README.md 中加入新的安裝方式：

```markdown
## 🚀 Quick Installation

Install the latest development version with one command:

\`\`\`bash
curl -fsSL https://raw.githubusercontent.com/ksin751119/claude-code-spec-workflow/develop/install.sh | bash
\`\`\`

### What this does:
- Downloads the latest code from develop branch
- Automatically installs dependencies and builds the project
- Sets up Claude Code commands in your project
- No global npm installation required!
```

### 3. 測試完整流程
在一個測試專案中執行：
```bash
curl -fsSL https://raw.githubusercontent.com/ksin751119/claude-code-spec-workflow/develop/install.sh | bash
```

## 🔄 工作流程簡化

### 開發流程
1. 在 `develop` branch 開發新功能
2. 推送到 GitHub
3. 使用者立即可以用新的安裝命令獲得最新版本

### 無需的步驟
- ❌ 不需要 merge 到 main
- ❌ 不需要創建 release
- ❌ 不需要更新版本號
- ❌ 不需要 npm 發布

## 🎉 完成！

現在你的 install.sh 已經設定為從 develop branch 安裝，使用者將總是獲得最新的開發版本！