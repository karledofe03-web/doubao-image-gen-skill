---
name: doubao-image-gen
description: 使用火山引擎豆包 Seedream 5.0 API 进行 AI 图像生成。支持文生图、图生图，国内网络直接可用，效果精美。
homepage: https://www.volcengine.com/docs/82379/1520757
metadata:
  {
    "openclaw":
      {
        "emoji": "🎨",
        "requires": { "bins": ["curl", "jq"], "env": ["DOUBAO_API_KEY"] },
        "primaryEnv": "DOUBAO_API_KEY",
      },
  }
---

# 豆包图像生成 (Doubao Image Generation)

使用火山引擎豆包 Seedream 5.0 API 进行 AI 图像生成，国内网络直接可用，生成效果精美。

## 功能特点

- **文生图**: 根据文字描述生成高质量图像
- **图生图**: 基于参考图进行编辑或风格转换（Seedream 5.0 支持）
- **多种尺寸**: 支持 1024x1024, 1280x720, 720x1280, 1920x1080 等
- **国内服务**: 字节跳动火山引擎，速度快，无需代理
- **精美效果**: 使用 Seedream 5.0 模型，画质细腻，色彩饱满

## 使用方法

### 文生图

```bash
{baseDir}/scripts/doubao-generate.sh \
  --prompt "一只可爱的猫咪趴在窗台上晒太阳" \
  --output ~/images/cat.png
```

### 指定尺寸

```bash
{baseDir}/scripts/doubao-generate.sh \
  --prompt "山水画，水墨风格" \
  --width 1280 \
  --height 720 \
  --output ~/images/landscape.png
```

### 图生图（编辑/风格转换）

```bash
{baseDir}/scripts/doubao-generate.sh \
  --prompt "将图片转换为油画风格" \
  --input ~/images/original.png \
  --output ~/images/oil_painting.png
```

## API Key 获取

1. 访问 [火山引擎控制台](https://console.volcengine.com/)
2. 注册/登录账号
3. 进入「机器学习平台」→「火山方舟」
4. 开通「图像生成」模型服务
5. 创建 API Key
6. 在 OpenClaw 配置文件中添加:
   ```json
   "skills": {
     "doubao-image-gen": {
       "enabled": true,
       "env": {
         "DOUBAO_API_KEY": "your-api-key-here"
       }
     }
   }
   ```

## 模型信息

- **模型**: `doubao-seedream-5-0-260128`
- **能力**: 文生图、图生图
- **输出格式**: JPEG/PNG
- **最大分辨率**: 支持 4K 输出

## 依赖

- `curl`: 用于 HTTP 请求
- `jq`: 用于 JSON 解析

macOS 安装:
```bash
brew install curl jq
```

Linux 安装:
```bash
apt-get install curl jq
```

## 示例提示词

### 卡通风格
```
可爱手绘涂鸦风格（Doodle Art Style）的信息图，手账本/子弹日记质感，
米色复古纸张背景，暖色调。Q版卡通人物，软萌图标，手绘感线条
```

### 写实风格
```
写实风格的产品摄影，专业灯光，白色背景，8K高清，细节丰富
```

### 艺术风格
```
中国水墨画风格，山水画，意境深远，留白，淡雅色调
```

## 注意事项

- 生成的图片会保存到指定路径
- 脚本会输出 `MEDIA:` 标记供 OpenClaw 自动识别
- 支持中文提示词，描述越详细效果越好
- API 按调用次数计费，请合理使用

## 许可证

MIT License - 自由使用和分享

## 作者

由 OpenClaw 社区创建
