# GitHub 上傳和發布指示

## 📝 已完成的工作

✅ 創建了 `install.sh` 一鍵安裝腳本
✅ 腳本包含完整的錯誤處理和友好的用戶介面
✅ 測試了所有依賴和建構流程
✅ 腳本語法檢查通過

## 🚀 需要手動完成的 GitHub 操作

### 1. 推送 install.sh 到 GitHub

```bash
# 在專案根目錄執行
git add install.sh
git commit -m "Add install.sh one-click installer script

- Provides curl | bash installation method
- Replaces npm global install approach
- Includes comprehensive error handling
- Supports Node.js version checking
- Downloads, builds, and installs automatically"

git push origin main
```

### 2. 創建 GitHub Release

1. **前往 GitHub Repository**
   - 訪問：https://github.com/ksin751119/claude-code-spec-workflow

2. **創建新 Release**
   - 點擊右側的 "Releases"
   - 點擊 "Create a new release"

3. **填寫 Release 資訊**
   ```
   Tag version: v1.5.10 (或適當的版本號)
   Release title: v1.5.10 - One-Click Installer

   Description:
   ## 🎉 One-Click Installation Available!

   Now you can install Claude Code Spec Workflow with a single command:

   ```bash
   curl -fsSL https://github.com/ksin751119/claude-code-spec-workflow/releases/latest/download/install.sh | bash
   ```

   ### New Features
   - ✨ One-click installation script
   - 🔍 Automatic prerequisite checking
   - 🎨 Beautiful colored output
   - 🛡️ Comprehensive error handling
   - 📦 Direct from source installation

   ### What's Changed
   - Added `install.sh` for simplified installation
   - No longer requires global npm installation
   - Downloads and builds from source automatically

   ### Installation Methods

   **Method 1: One-Click Install (Recommended)**
   ```bash
   curl -fsSL https://github.com/ksin751119/claude-code-spec-workflow/releases/latest/download/install.sh | bash
   ```

   **Method 2: Traditional NPM Install**
   ```bash
   npm i -g @pimzino/claude-code-spec-workflow
   claude-code-spec-workflow
   ```

   ### Requirements
   - Node.js 16.0.0 or higher
   - npm
   ```

4. **上傳 install.sh 作為 Release Asset**
   - 在 "Attach binaries..." 區域
   - 拖拽或選擇 `install.sh` 檔案
   - 確保檔案名稱是 `install.sh`

5. **發布 Release**
   - 點擊 "Publish release"

## 🎯 使用者安裝方式

使用者可以使用以下命令安裝最新開發版本：

```bash
# 從 develop branch 安裝最新版本 (推薦)
curl -fsSL https://raw.githubusercontent.com/ksin751119/claude-code-spec-workflow/develop/install.sh | bash
```

**策略說明**：
- ✅ **Always Latest**: 使用者總是獲得最新的開發版本
- 🚀 **即時更新**: 開發完成後立即可用，無需等待 release
- 🔧 **持續整合**: 支援敏捷開發流程

## 📋 安裝腳本功能

✅ **環境檢查**
- Node.js 版本檢查 (>= 16.0.0)
- npm 可用性檢查
- curl/wget 可用性檢查

✅ **專案目錄檢查**
- 檢查是否在有效的專案目錄
- 提供警告和確認提示

✅ **自動化安裝**
- 下載最新版本源碼
- 安裝依賴 (`npm install`)
- 編譯專案 (`npm run build`)
- 執行安裝到用戶專案 (`node dist/cli.js setup`)

✅ **錯誤處理**
- 自動清理臨時檔案
- 詳細的錯誤訊息
- 友好的用戶介面

✅ **用戶友好**
- 彩色輸出
- 進度指示
- 安裝後的使用指導

## 🔧 故障排除

如果安裝失敗，使用者可以：

1. **檢查 Node.js 版本**
   ```bash
   node --version  # 應該 >= 16.0.0
   ```

2. **手動安裝**
   ```bash
   git clone https://github.com/ksin751119/claude-code-spec-workflow.git
   cd claude-code-spec-workflow
   npm install
   npm run build
   node dist/cli.js setup
   ```

3. **使用傳統 npm 方式**
   ```bash
   npm i -g @pimzino/claude-code-spec-workflow
   claude-code-spec-workflow
   ```

## 📈 預期結果

完成後，使用者將能夠：
- 使用一行命令完成安裝
- 避免全域安裝 npm 套件
- 獲得最新的源碼版本
- 享受友好的安裝體驗