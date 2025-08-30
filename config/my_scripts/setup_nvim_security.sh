#!/bin/zsh

#
# nvim-wrapper: 从 macOS 钥匙串安全地加载环境变量并启动 Neovim
#

# --- 配置区 ---
# 在这里定义你需要从钥匙串获取并注入的环境变量。
# 每一行代表一个环境变量，格式必须是:
# <环境变量名> <钥匙串中的服务名> <钥匙串中的账户名>
#
# - 环境变量名: 插件将通过 os.getenv() 读取的名字 (例如 AI_PLATFORM_API_KEY)
# - 服务名: `security` 命令中的 -s 参数
# - 账户名: `security` 命令中的 -a 参数
# eg:
# security add-generic-password \
# -s 'com.avante-nvim.api' \
# -a 'GEMINI_API_KEY' \
# -w '<你的GEMINI_API_KEY>' \
# -T "$(which nvim)"
#
# 你可以随意添加、删除或注释掉行。
# -----------------------------------------------------------------------------
KEYS_TO_FETCH="
  GEMINI_API_KEY com.avante-nvim.api GEMINI_API_KEY

  GEMINI_SUGGEST_API_KEY com.avante-nvim.api GEMINI_SUGGEST_API_KEY
"

# --- 核心逻辑区 ---

# 定义一个函数，用于根据不同平台从安全存储中获取密钥
# 参数1: service, 参数2: account
get_key_from_secure_storage() {
  local service="$1"
  local account="$2"
  local os_type
  os_type="$(uname -s)"

  case "$os_type" in
    # macOS
    Darwin)
      security find-generic-password -s "$service" -a "$account" -w 2>/dev/null
      ;;
    # Linux
    Linux)
      # 检查 secret-tool 是否已安装
      if ! command -v secret-tool &> /dev/null; then
        # 只在第一次调用时打印错误，避免重复刷屏
        if [[ -z "$SECRET_TOOL_MISSING_ERROR_SHOWN" ]]; then
          echo "nvim-wrapper: 错误 - 'secret-tool' 命令未找到。请安装 'libsecret-tools' (Debian/Ubuntu) 或 'libsecret' (Fedora/RHEL)。" >&2
          # 设置一个标志，防止重复打印此错误
          export SECRET_TOOL_MISSING_ERROR_SHOWN=1
        fi
        return 1 # 返回失败
      fi
      secret-tool lookup service "$service" account "$account"
      ;;
    # 其他不支持的系统
    *)
      if [[ -z "$UNSUPPORTED_OS_ERROR_SHOWN" ]]; then
        echo "nvim-wrapper: 警告 - 不支持的操作系统 '$os_type'，无法从安全存储中获取密钥。" >&2
        export UNSUPPORTED_OS_ERROR_SHOWN=1
      fi
      return 1 # 返回失败
      ;;
  esac
}


echo "正在为 Neovim 准备安全环境..."

# 读取配置区的每一行并处理
echo "$KEYS_TO_FETCH" | while read -r env_var service account; do
  # 跳过空行和注释行
  if [[ -z "$env_var" || "$env_var" == \#* ]]; then continue; fi

  # 调用函数获取秘密值
  value=$(get_key_from_secure_storage "$service" "$account")
  exit_code=$?

  # 检查函数是否成功执行并且返回值不为空
  if [[ $exit_code -eq 0 && -n "$value" ]]; then
    export "$env_var"="$value"
  else
    # 对于找不到的Key，打印警告并设置为空值（保持防御性编程）
    if [[ -z "$SECRET_TOOL_MISSING_ERROR_SHOWN" && -z "$UNSUPPORTED_OS_ERROR_SHOWN" ]]; then
      echo "nvim-wrapper: 警告 - 未能从安全存储中找到 '$env_var'。将设置为空值。" >&2
    fi
    export "$env_var"=""
  fi
done

echo "环境设置完毕，正在启动 Neovim..."
echo "-------------------------------------"

# --- 执行区 ---
# 使用 command which 确保找到的是真实的可执行文件，而不是别名
exec "$(command which nvim)" "$@"
