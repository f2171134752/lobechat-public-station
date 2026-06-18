# LobeChat API 公益站

基于 LobeChat + New-API 构建的 AI 公益聊天站，一键 Docker 部署。

## 功能

- 🎨 **AI 聊天网页** — 用户打开浏览器就能对话，无需安装任何软件
- 🔄 **多模型支持** — 统一调用 DeepSeek、Qwen、GLM 等多种模型
- 👥 **多用户管理** — 注册、额度、令牌管理
- 📊 **用量统计** — 数据看板，随时查看各模型消耗
- 🔒 **HTTPS** — Ngrok / Cloudflare Tunnel 免费配置
- 📦 **一行部署** — Docker Compose 一键启动

## 技术栈

```
用户 → Nginx (:80) → LobeChat (:3210) → New-API (:3000) → 上游 AI 模型
```

| 组件 | 技术 | 作用 |
|------|------|------|
| 网页前端 | LobeChat | AI 对话界面，用户直接使用 |
| API 网关 | New-API | 多模型统一管理、用户系统、额度控制 |
| 反向代理 | Nginx | 统一入口，分发请求 |
| HTTPS 隧道 | Ngrok | 免费 TLS 加密，免域名 |

## 快速部署

### 前提

- 一台 VPS（1 核 1G 即可，系统 Debian/Ubuntu）
- 已安装 Docker 和 Docker Compose

### 一键部署

```bash
# 1. 下载项目
git clone https://github.com/你的用户名/lobechat-public-station.git
cd lobechat-public-station

# 2. 配置环境变量
cp .env.example .env
nano .env     # 填入你的 API Key

# 3. 启动
docker compose up -d

# 4. 查看状态
docker compose ps
```

### 配置上游渠道

部署完成后，访问 `http://你的VPS_IP:3000` 登录 New-API 后台：

- 默认账号：`root`
- 默认密码：`123456`
- **登录后第一件事改密码**

然后在「渠道」中添加你的上游 API Key（硅基流动、DeepSeek、智谱等）。

### 配置 HTTPS

#### 方式一：Ngrok（免费，无需域名）

```bash
ngrok http 80
```

得到 `https://xxxxx.ngrok-free.app`，用户通过此地址访问。

#### 方式二：Cloudflare Tunnel（更稳定）

```bash
cloudflared tunnel --url http://localhost:80
```

## 项目结构

```
lobechat-public-station/
├── docker-compose.yml     # 一键部署
├── nginx.conf             # Nginx 反向代理配置
├── .env.example           # 环境变量模板
└── README.md              # 项目说明（本文件）
```

## 推荐上游（免费额度）

| 平台 | 免费额度 | 注册地址 |
|------|---------|---------|
| 硅基流动 | 14 元代金券 | https://cloud.siliconflow.cn |
| 智谱 AI | GLM-4-Flash 永久免费 | https://open.bigmodel.cn |
| DeepSeek | 500 万 token | https://platform.deepseek.com |

## 常见问题

**Q：需要什么配置的服务器？**
A：1 核 1G 即可运行，建议 2 核 2G 以上以支持多用户。

**Q：用户如何使用？**
A：用户打开你的域名，注册账号后创建令牌，把 API 地址和 Key 填入任何支持 OpenAI 格式的客户端（ChatBox、Cherry Studio 等）。

**Q：如何升级 New-API？**
```bash
docker compose pull
docker compose up -d
```

## 许可证

MIT
