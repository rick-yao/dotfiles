#!/bin/bash

# --- 配置区 ---
# for macOS
# 在这里定义你需要从钥匙串获取并注入的环境变量。
# 每一行代表一个环境变量，格式必须是:
# <环境变量名> <钥匙串中的服务名> <钥匙串中的账户名>
#
# - 环境变量名: 插件将通过 os.getenv() 读取的名字 (例如 AI_PLATFORM_API_KEY)
# - 服务名: `security` 命令中的 -s 参数
# - 账户名: `security` 命令中的 -a 参数
# security add-generic-password \
# -s 'com.avante-nvim.api' \
# -a 'GEMINI_API_KEY' \
# -w '<你的GEMINI_API_KEY>' \
# -T "$(which nvim)"
#
# for Linux
# add file in below path ,and set chmod 600
# 你可以随意添加、删除或注释掉行。
# -----------------------------------------------------------------------------

SECRETS_FILE_PATH="$HOME/.config/zsh/nvim-secrets.env"

KEYS_TO_FETCH="
  GEMINI_API_KEY com.avante-nvim.api GEMINI_API_KEY

  GEMINI_SUGGEST_API_KEY com.avante-nvim.api GEMINI_SUGGEST_API_KEY
"
# --- 核心逻辑区 ---

echo "正在为 Neovim 准备安全环境..."

case "$(uname -s)" in
  # macOS
  Darwin)
    echo "$KEYS_TO_FETCH_MACOS" | while read -r env_var service account; do
      if [[ -z "$env_var" || "$env_var" == \#* ]]; then continue; fi
      value=$(security find-generic-password -s "$service" -a "$account" -w 2>/dev/null)
      if [[ $? -eq 0 && -n "$value" ]]; then
        export "$env_var"="$value"
      else
        echo "nvim-wrapper: 警告 - 未能从钥匙串找到 '$env_var'。将设置为空值。" >&2
        export "$env_var"=""
      fi
    done
    ;;

  # Linux
  Linux)
    # 检查秘密文件是否存在
    if [[ -f "$SECRETS_FILE_PATH" ]]; then
      # 如果文件存在，就“导入”它。
      # `source` 命令会执行文件中的 `export` 指令，设置环境变量。
      source "$SECRETS_FILE_PATH"
      echo "成功从 $SECRETS_FILE_PATH 加载环境变量。"
    else
      # 如果文件不存在，打印警告。
      echo "nvim-wrapper: 警告 - 秘密文件 '$SECRETS_FILE_PATH' 未找到。环境变量将为空。" >&2
      # （我们无需手动将Key设置为空，因为它们从未被定义过）
    fi
    ;;

  # 其他不支持的系统
  *)
    echo "nvim-wrapper: 警告 - 不支持的操作系统 '$(uname -s)'。" >&2
    ;;
esac

echo "环境设置完毕，正在启动 Neovim..."
echo "-------------------------------------"

# --- 执行区 ---
exec "$(command which nvim)" "$@"
