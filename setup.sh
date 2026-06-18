#!/bin/bash
# LobeChat 公益站 — 新机快速部署脚本
# 用法: curl -fsSL https://你的地址/setup.sh | bash

set -e

echo "===== LobeChat 公益站部署脚本 ====="

# 1. 检查 Docker
if ! command -v docker &> /dev/null; then
    echo ">>> 安装 Docker..."
    curl -fsSL https://get.docker.com | bash
fi

# 2. 检查 Docker Compose
if ! docker compose version &> /dev/null; then
    echo ">>> 安装 Docker Compose..."
    apt update && apt install -y docker-compose-plugin
fi

# 3. 下载项目
echo ">>> 下载项目文件..."
git clone https://github.com/你的用户名/lobechat-public-station.git
cd lobechat-public-station

# 4. 配置
if [ ! -f .env ]; then
    cp .env.example .env
    echo "⚠️  请编辑 .env 文件填入你的 API Key"
    echo "   nano .env"
fi

# 5. 启动
echo ">>> 启动服务..."
docker compose up -d

echo ""
echo "===== 部署完成 ====="
echo "LobeChat 页面:   http://$(curl -s ifconfig.me):80"
echo "New-API 后台:    http://$(curl -s ifconfig.me):80/admin"
echo "后台账号:       root / 123456（登录后请改密码）"
echo ""
echo "⚠️  如需 HTTPS，启动 Cloudflare Tunnel:"
echo "   cloudflared tunnel --url http://localhost:80"
