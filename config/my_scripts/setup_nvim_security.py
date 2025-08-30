#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
一个使用 1Password CLI (`op`) 的跨平台安全启动器。
- 直接在脚本内部定义所需密钥的引用 (URI)。
- 无需外部 .env 文件。
- 在 macOS, Linux, Windows 上行为一致。
"""

import sys
import os
import subprocess

# --- 配置区 ---
# 将环境变量名直接映射到其在 1Password 中的秘密引用 (URI)。
# 这是您唯一需要修改的地方。
# 格式: "环境变量名": "op://<保管库>/<项目标题>/<字段标签>"
SECRETS_TO_FETCH = {
    "VERTEX_GEMINI_API_KEY": "op://Private/Nvim API Keys/VERTEX_GEMINI_API_KEY",
    "VERTEX_GEMINI_SUGGEST_API_KEY": "op://Private/Nvim API Keys/VERTEX_GEMINI_SUGGEST_API_KEY",
    # 如果未来需要更多Key，在这里像字典一样添加新行即可
    # "ANOTHER_KEY": "op://Vault/Item/Field",
}


def main():
    """主执行函数"""
    print("正在通过 1Password 为 Neovim 准备安全环境...")

    # --- 核心逻辑区 (跨平台通用) ---
    # 检查 'op' 命令是否存在
    try:
        subprocess.run(["command", "-v", "op"], check=True, capture_output=True)
    except (subprocess.CalledProcessError, FileNotFoundError):
        print(
            "nvim-wrapper: 致命错误 - 'op' 命令未找到。请先安装 1Password CLI。",
            file=sys.stderr,
        )
        # 即使 op 不存在，也应该尝试启动 nvim，保持防御性
        exec_nvim()

    # 遍历配置字典，获取每一个秘密
    for env_var, op_uri in SECRETS_TO_FETCH.items():
        try:
            # 使用 op read 读取秘密，--no-newline 避免输出多余的换行符
            command = ["op", "read", "--no-newline", op_uri]
            result = subprocess.run(
                command, capture_output=True, text=True, check=False
            )

            if result.returncode == 0 and result.stdout:
                os.environ[env_var] = result.stdout
            else:
                os.environ[env_var] = ""
                if result.stderr:
                    print(
                        f"nvim-wrapper: 警告 - 无法获取 '{env_var}': {result.stderr.strip()}",
                        file=sys.stderr,
                    )
        except Exception as e:
            print(
                f"nvim-wrapper: 警告 - 执行 op 命令时出现意外错误 ({env_var}): {e}",
                file=sys.stderr,
            )
            os.environ[env_var] = ""

    # --- 日志记录区 ---
    print("-------------------------------------")
    print("已加载的环境变量:")
    for env_var in SECRETS_TO_FETCH:
        current_value = os.getenv(env_var)
        if current_value:
            censored_value = f"{current_value[:4]}..."
            print(f"  ✓ {env_var} = {censored_value}")
        else:
            print(f"  ✗ {env_var} = [未设置或为空]")
    print("-------------------------------------")

    # --- 执行区 ---
    exec_nvim()


def exec_nvim():
    """查找并执行nvim"""
    print("环境设置完毕，正在启动 Neovim...")
    try:
        nvim_path_result = subprocess.run(
            ["command", "which", "nvim"], capture_output=True, text=True, check=True
        )
        nvim_path = nvim_path_result.stdout.strip()
        args_to_pass = [nvim_path] + sys.argv[1:]
        os.execvp(nvim_path, args_to_pass)
    except (subprocess.CalledProcessError, FileNotFoundError):
        print("nvim-wrapper: 致命错误 - 未能在 $PATH 中找到 'nvim'。", file=sys.stderr)
        sys.exit(1)
    except OSError as e:
        print(f"nvim-wrapper: 致命错误 - 执行 nvim 失败: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
