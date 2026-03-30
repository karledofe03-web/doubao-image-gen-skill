#!/bin/bash
#
# 豆包图像生成脚本
# 使用火山引擎豆包API
#

set -e

# 配置
API_KEY="${DOUBAO_API_KEY:-}"
API_URL="https://ark.cn-beijing.volces.com/api/v3/images/generations"

# 默认参数
PROMPT=""
OUTPUT_PATH=""
WIDTH=1024
HEIGHT=1024

# 显示帮助
usage() {
    echo "豆包图像生成工具"
    echo ""
    echo "用法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  -p, --prompt <文本>     图像描述提示词 (必填)"
    echo "  -o, --output <路径>     输出文件路径 (必填)"
    echo "  -W, --width <像素>      图片宽度 (默认: 1024)"
    echo "  -H, --height <像素>     图片高度 (默认: 1024)"
    echo "  -h, --help              显示帮助"
    echo ""
    echo "示例:"
    echo "  $0 -p \"一只可爱的猫咪\" -o /Users/appleai/openclaw-guides/images/cat.png"
    echo "  $0 -p \"山水画\" -W 1280 -H 720 -o /Users/appleai/openclaw-guides/images/landscape.png"
    exit 1
}

# 检查依赖
check_deps() {
    if ! command -v curl &> /dev/null; then
        echo "错误: 需要安装 curl"
        exit 1
    fi
    
    if ! command -v jq &> /dev/null; then
        echo "错误: 需要安装 jq"
        echo "macOS: brew install jq"
        exit 1
    fi
}

# 检查 API Key
check_api_key() {
    if [ -z "$API_KEY" ]; then
        echo "错误: 未设置 DOUBAO_API_KEY 环境变量"
        echo "请在 ~/.openclaw/openclaw.json 中配置"
        exit 1
    fi
}

# 解析参数
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -p|--prompt)
                PROMPT="$2"
                shift 2
                ;;
            -o|--output)
                OUTPUT_PATH="$2"
                shift 2
                ;;
            -W|--width)
                WIDTH="$2"
                shift 2
                ;;
            -H|--height)
                HEIGHT="$2"
                shift 2
                ;;
            -h|--help)
                usage
                ;;
            *)
                echo "错误: 未知选项 $1"
                usage
                ;;
        esac
    done
}

# 验证参数
validate_args() {
    if [ -z "$PROMPT" ]; then
        echo "错误: 请提供提示词 (-p)"
        usage
    fi
    
    if [ -z "$OUTPUT_PATH" ]; then
        echo "错误: 请提供输出路径 (-o)"
        usage
    fi
    
    # 确保输出目录存在
    mkdir -p "$(dirname "$OUTPUT_PATH")"
}

# 生成图片
generate_image() {
    echo "豆包图像生成"
    echo "提示词: $PROMPT"
    echo "尺寸: ${WIDTH}x${HEIGHT}"
    echo "输出路径: $OUTPUT_PATH"
    echo ""
    echo "正在生成图片..."
    
    # 构建请求 - 使用 doubao-seedream-5-0-260128 模型
    local request_body=$(cat <<EOF
{
    "model": "doubao-seedream-5-0-260128",
    "prompt": "$PROMPT",
    "width": $WIDTH,
    "height": $HEIGHT
}
EOF
)
    
    # 调用API
    local response=$(curl -s -X POST "$API_URL" \
        -H "Authorization: Bearer $API_KEY" \
        -H "Content-Type: application/json" \
        -d "$request_body")
    
    # 检查错误
    if echo "$response" | jq -e '.error' > /dev/null 2>&1; then
        local error_msg=$(echo "$response" | jq -r '.error.message // .error')
        echo "API 错误: $error_msg"
        exit 1
    fi
    
    # 提取图片URL
    local image_url=$(echo "$response" | jq -r '.data[0].url // empty')
    
    if [ -z "$image_url" ]; then
        echo "错误: 无法获取图片 URL"
        echo "完整响应: $response"
        exit 1
    fi
    
    echo "图片URL: $image_url"
    echo "正在下载图片..."
    
    # 下载图片
    curl -s -L --http1.1 -o "$OUTPUT_PATH" "$image_url"
    
    if [ -f "$OUTPUT_PATH" ]; then
        local file_size=$(stat -f%z "$OUTPUT_PATH" 2>/dev/null || stat -c%s "$OUTPUT_PATH" 2>/dev/null || echo "未知")
        echo "图片已保存: $OUTPUT_PATH (大小: $file_size 字节)"
        echo "MEDIA: $OUTPUT_PATH"
    else
        echo "错误: 下载失败"
        exit 1
    fi
}

# 主函数
main() {
    check_deps
    parse_args "$@"
    validate_args
    check_api_key
    generate_image
}

main "$@"
