# 豆包生图技能-龙虾 🦞 (Doubao Image Generation Skill)

[![OpenClaw](https://img.shields.io/badge/OpenClaw-Skill-blue)](https://openclaw.ai)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

> 🎨 一个强大的 OpenClaw 图像生成技能，使用火山引擎豆包 Seedream 5.0 API

使用火山引擎豆包 Seedream 5.0 API 进行 AI 图像生成的 OpenClaw 技能。

## ✨ 特点

- 🎨 **高质量图像生成** - 使用豆包 Seedream 5.0 模型，效果精美
- 🇨🇳 **国内服务** - 字节跳动火山引擎，无需代理，速度快
- 📝 **中文支持** - 完美支持中文提示词
- 🖼️ **文生图 + 图生图** - 支持生成和编辑图片
- 📐 **多种尺寸** - 支持多种分辨率输出

## 🚀 快速开始

### 方式一：一键安装（推荐）

复制下面这行命令，粘贴到终端运行：

```bash
curl -fsSL https://raw.githubusercontent.com/karledofe03-web/doubao-image-gen-skill/main/install.sh | bash
```

### 方式二：手动安装

将本技能文件夹复制到你的 OpenClaw 技能目录：

```bash
cp -r doubao-image-gen ~/.agents/
```

### 2. 配置 API Key

在 `~/.openclaw/openclaw.json` 中添加配置：

```json
{
  "skills": {
    "doubao-image-gen": {
      "enabled": true,
      "env": {
        "DOUBAO_API_KEY": "your-api-key-here"
      }
    }
  }
}
```

### 3. 获取 API Key

1. 访问 [火山引擎控制台](https://console.volcengine.com/)
2. 进入「机器学习平台」→「火山方舟」
3. 开通「图像生成」服务
4. 创建 API Key

### 4. 使用

```bash
# 文生图
~/.agents/doubao-image-gen/scripts/doubao-generate.sh \
  --prompt "一只可爱的猫咪" \
  --output ~/images/cat.png

# 指定尺寸
~/.agents/doubao-image-gen/scripts/doubao-generate.sh \
  --prompt "山水画" \
  --width 1280 \
  --height 720 \
  --output ~/images/landscape.png
```

## 📖 使用示例

### 卡通涂鸦风格
```bash
~/.agents/doubao-image-gen/scripts/doubao-generate.sh \
  --prompt "可爱手绘涂鸦风格（Doodle Art Style）的信息图，手账本质感，米色复古纸张背景，暖色调。Q版卡通人物，软萌图标，手绘感线条" \
  --output ~/images/doodle.png
```

### 写实风格
```bash
~/.agents/doubao-image-gen/scripts/doubao-generate.sh \
  --prompt "写实风格的产品摄影，专业灯光，白色背景，8K高清" \
  --output ~/images/product.png
```

## 💰 费用说明

### 新用户免费额度
火山方舟为新用户提供**免费推理试用额度**：
- ✅ 注册即可获得一定额度的免费调用次数
- ✅ 每个模型通常赠送 **50万 tokens** 的免费额度
- ✅ 新用户还有 **15元代金券**（约等于 375万 tokens）

### 图像生成价格
豆包图像生成的价格非常实惠：
- 💵 价格比行业低 **99%**
- 💵 约 **0.0008 元/千 tokens**（以豆包 pro-32k 为例）
- 💵 生成一张 1024x1024 图片通常只需 **几分钱**

### 计费说明
- 使用免费额度期间，控制台余额可能不会立即减少
- 免费额度用完后，按实际调用量计费
- 可在火山方舟控制台「费用中心」→「账单」查看使用情况

## 🔧 依赖

- `curl` - HTTP 请求
- `jq` - JSON 解析

macOS:
```bash
brew install curl jq
```

Ubuntu/Debian:
```bash
apt-get install curl jq
```

## 📄 许可证

MIT License

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📋 环境信息

> ⚠️ **注意**：本技能在以下环境中开发和测试，随着大模型和 OpenClaw 版本更新，可能需要相应调整。

### 技能生成信息
- **生成日期**: 2026-03-30
- **作者**: karledofe03-web
- **技能版本**: 1.0.0

### OpenClaw 环境
- **OpenClaw 版本**: 2026.3.28
- **操作系统**: macOS 26.4 (Darwin 25.4.0 arm64)
- **Node.js 版本**: v25.6.1
- **Shell**: zsh

### 大模型环境
- **豆包模型**: `doubao-seedream-5-0-260128`

### 依赖
- `curl` - HTTP 请求工具
- `jq` - JSON 解析工具（推荐）

### 兼容性
- ✅ 支持 macOS、Linux
- ✅ 支持 OpenClaw 2026.3.x 及以上版本
- ⚠️ 未来 OpenClaw 或豆包 API 更新时，可能需要更新技能

---

## 🙏 致谢

- [火山引擎](https://www.volcengine.com/) - 提供豆包大模型服务
- [OpenClaw](https://openclaw.ai) - AI 助手框架
