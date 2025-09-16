#!/bin/bash
# install.sh - Claude Code Spec Workflow 一鍵安裝腳本
# 使用方式: curl -fsSL https://github.com/ksin751119/claude-code-spec-workflow/releases/latest/download/install.sh | bash

set -e

# 顏色輸出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# 顯示標題
echo ""
echo -e "${CYAN}${BOLD}Claude Code Spec Workflow Installer${NC}"
echo -e "${YELLOW}Automated spec-driven development with intelligent task execution${NC}"
echo ""

# 檢查 Node.js
echo -e "${BLUE}🔍 Checking prerequisites...${NC}"
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Error: Node.js is required but not installed.${NC}"
    echo ""
    echo "Please install Node.js first:"
    echo "  - Visit: https://nodejs.org/"
    echo "  - Or use a package manager:"
    echo "    - macOS: brew install node"
    echo "    - Ubuntu/Debian: sudo apt install nodejs npm"
    echo "    - Windows: choco install nodejs"
    exit 1
fi

# 檢查 npm
if ! command -v npm &> /dev/null; then
    echo -e "${RED}❌ Error: npm is required but not installed.${NC}"
    exit 1
fi

# 顯示 Node.js 版本
NODE_VERSION=$(node --version)
NPM_VERSION=$(npm --version)
echo -e "${GREEN}✓ Node.js ${NODE_VERSION} found${NC}"
echo -e "${GREEN}✓ npm ${NPM_VERSION} found${NC}"

# 檢查 Node.js 版本 (需要 >= 16.0.0)
NODE_MAJOR_VERSION=$(node --version | sed 's/v//' | cut -d. -f1)
if [ "$NODE_MAJOR_VERSION" -lt 16 ]; then
    echo -e "${RED}❌ Error: Node.js version 16.0.0 or higher is required.${NC}"
    echo "Current version: $NODE_VERSION"
    exit 1
fi

# 檢查是否在專案目錄
echo ""
echo -e "${BLUE}📂 Checking current directory...${NC}"
CURRENT_DIR=$(pwd)
echo "Installing in: $CURRENT_DIR"

if [ ! -f "package.json" ] && [ ! -d ".git" ]; then
    echo -e "${YELLOW}⚠️  Warning: This doesn't appear to be a project directory.${NC}"
    echo "No package.json or .git directory found."
    echo ""
    echo "Are you sure you want to install Claude Code Spec Workflow here? (y/N)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
fi

# 創建臨時目錄
echo ""
echo -e "${BLUE}📦 Downloading claude-code-spec-workflow...${NC}"
TEMP_DIR=$(mktemp -d)
PROJECT_DIR="$PWD"

# 錯誤處理 - 清理臨時目錄
cleanup() {
    echo ""
    echo -e "${YELLOW}🧹 Cleaning up temporary files...${NC}"
    rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

# 下載最新版本
cd "$TEMP_DIR"
echo "Downloading from GitHub..."

if command -v curl &> /dev/null; then
    if ! curl -L "https://github.com/ksin751119/claude-code-spec-workflow/archive/develop.zip" -o develop.zip; then
        echo -e "${RED}❌ Failed to download from GitHub${NC}"
        exit 1
    fi
elif command -v wget &> /dev/null; then
    if ! wget "https://github.com/ksin751119/claude-code-spec-workflow/archive/develop.zip" -O develop.zip; then
        echo -e "${RED}❌ Failed to download from GitHub${NC}"
        exit 1
    fi
else
    echo -e "${RED}❌ Error: Neither curl nor wget is available${NC}"
    echo "Please install curl or wget first."
    exit 1
fi

# 解壓縮
echo "Extracting files..."
if ! unzip -q develop.zip; then
    echo -e "${RED}❌ Failed to extract downloaded file${NC}"
    exit 1
fi

cd claude-code-spec-workflow-develop

# 安裝依賴
echo ""
echo -e "${BLUE}📚 Installing dependencies...${NC}"
if ! npm install --silent --no-audit --no-fund; then
    echo -e "${RED}❌ Failed to install dependencies${NC}"
    exit 1
fi

# 編譯專案
echo ""
echo -e "${BLUE}🔨 Building project...${NC}"
if ! npm run build --silent; then
    echo -e "${RED}❌ Failed to build project${NC}"
    exit 1
fi

# 檢查 CLI 檔案是否存在
if [ ! -f "dist/cli.js" ]; then
    echo -e "${RED}❌ Build failed: dist/cli.js not found${NC}"
    exit 1
fi

# 執行安裝到使用者的專案目錄
echo ""
echo -e "${BLUE}⚙️  Setting up Claude Code Spec Workflow in your project...${NC}"
if ! node dist/cli.js setup --project "$PROJECT_DIR" --yes; then
    echo -e "${RED}❌ Failed to setup spec workflow${NC}"
    exit 1
fi

# 回到專案目錄
cd "$PROJECT_DIR"

# 顯示成功訊息
echo ""
echo -e "${GREEN}${BOLD}🎉 Claude Code Spec Workflow installed successfully!${NC}"
echo ""

# 檢查是否有現有的規格
if [ -d ".claude/specs" ]; then
    SPEC_COUNT=$(find .claude/specs -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l)
    if [ "$SPEC_COUNT" -gt 0 ]; then
        echo -e "${CYAN}📋 Found $SPEC_COUNT existing spec(s) in your project${NC}"
    fi
fi

echo -e "${YELLOW}${BOLD}Next steps:${NC}"
echo ""
echo -e "${BOLD}1. Start Claude Code:${NC}"
echo -e "   ${BLUE}claude${NC}"
echo ""
echo -e "${BOLD}2. Create a new feature specification:${NC}"
echo -e "   ${BLUE}/spec-create feature-name \"description\"${NC}"
echo ""
echo -e "${BOLD}3. Or create a bug fix workflow:${NC}"
echo -e "   ${BLUE}/bug-create bug-name \"description\"${NC}"
echo ""
echo -e "${BOLD}4. Check status anytime:${NC}"
echo -e "   ${BLUE}/spec-status${NC} or ${BLUE}/bug-status${NC}"
echo ""

# 顯示重要提醒
echo -e "${YELLOW}${BOLD}⚠️  Important:${NC}"
echo -e "If you had Claude Code running, you may need to restart it for new commands to be visible."
echo ""

# 顯示幫助資源
echo -e "${CYAN}📚 Resources:${NC}"
echo -e "• Documentation: ${BLUE}https://github.com/ksin751119/claude-code-spec-workflow${NC}"
echo -e "• Issues: ${BLUE}https://github.com/ksin751119/claude-code-spec-workflow/issues${NC}"
echo ""
echo -e "${GREEN}Happy coding with Claude Code Spec Workflow! 🚀${NC}"
echo ""