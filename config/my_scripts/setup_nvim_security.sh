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

# --- 核心逻辑区 (通常无需修改) ---

echo "正在为 Neovim 准备安全环境..."

# 读取配置区的每一行并处理
echo "$KEYS_TO_FETCH" | while read -r env_var service account; do
  # 跳过空行和以'#'开头的注释行
  if [[ -z "$env_var" || "$env_var" == \#* ]]; then
    continue
  fi

  # 从钥匙串获取秘密值，并将任何错误输出重定向到/dev/null
  value=$(security find-generic-password -s "$service" -a "$account" -w 2>/dev/null)

  # 检查命令是否成功执行并且返回值不为空
  if [[ $? -eq 0 && -n "$value" ]]; then
    # 如果成功找到，则导出为环境变量
    export "$env_var"="$value"
    echo "  -> 成功注入 $env_var"
  else
    # --- 这是修改的关键部分 ---
    # 如果找不到Key (命令失败或值为空)

    # 1. 打印清晰的警告信息到标准错误输出
    echo "  -> 警告: 未能从钥匙串找到 '$env_var'。该环境变量将设置为空值。" >&2

    # 2. 将环境变量的值显式设置为空字符串
    export "$env_var"=""
  fi
done

echo "环境设置完毕，正在启动 Neovim..."
echo "-------------------------------------"

# 执行真正的 nvim 命令，并将所有命令行参数原封不动地传递给它
exec "$(command which nvim)" "$@"
