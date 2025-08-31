#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
nvim-wrapper: (Python版 - 混合策略)
一个跨平台的安全启动器，会根据当前操作系统选择不同的策略：
- 在 macOS 上: 使用 1Password CLI (`op`) 读取密钥。
- 在 Linux 上: 从一个受限权限的环文件 (`secrets.env`) 读取密钥。
"""

import sys
import os
import subprocess
from pathlib import Path

# --- 配置区 ---

# [macOS 配置]: 将环境变量名映射到其在 1Password 中的秘密引用 (URI)。
# 这也是整个脚本所关心的环境变量的总列表。
SECRETS_FOR_MACOS = {
    "VERTEX_GEMINI_API_KEY": "op://Private/Nvim API Keys/VERTEX_GEMINI_API_KEY",
    "VERTEX_GEMINI_SUGGEST_API_KEY": "op://Private/Nvim API Keys/VERTEX_GEMINI_SUGGEST_API_KEY",
}

# [Linux 配置]: 定义存储秘密的文件的路径。
SECRETS_FILE_LINUX = Path.home() / ".config/zsh/nvim-secrets.env"


def main():
    """主执行函数"""
    print("正在为 Neovim 准备安全环境...")

    # --- 核心逻辑区 (根据平台选择策略) ---

    if sys.platform == "darwin":  # 这是 macOS
        print("检测到 macOS，使用 1Password CLI 策略...")
        try:
            # 检查 'op' 命令是否存在
            subprocess.run(["command", "-v", "op"], check=True, capture_output=True)

            # 遍历配置字典，从 1Password 获取每一个秘密
            for env_var, op_uri in SECRETS_FOR_MACOS.items():
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

        except (subprocess.CalledProcessError, FileNotFoundError):
            print(
                "nvim-wrapper: 致命错误 - 'op' 命令未找到。请先安装 1Password CLI。",
                file=sys.stderr,
            )
            # 即使 op 不存在，也应该尝试启动 nvim
            exec_nvim()

    elif sys.platform.startswith("linux"):  # 这是 Linux
        print(f"检测到 Linux，使用文件策略 ({SECRETS_FILE_LINUX})...")
        if SECRETS_FILE_LINUX.is_file():
            try:
                # 读取并解析 .env 文件
                with open(SECRETS_FILE_LINUX, "r", encoding="utf-8") as f:
                    for line in f:
                        line = line.strip()
                        if not line or line.startswith("#"):
                            continue
                        if line.startswith("export "):
                            line = line[len("export ") :]
                        if "=" in line:
                            key, value = line.split("=", 1)
                            if (value.startswith('"') and value.endswith('"')) or (
                                value.startswith("'") and value.endswith("'")
                            ):
                                value = value[1:-1]
                            os.environ[key] = value
            except Exception as e:
                print(f"nvim-wrapper: 警告 - 读取秘密文件时出错: {e}", file=sys.stderr)
        else:
            print(
                f"nvim-wrapper: 警告 - 秘密文件 '{SECRETS_FILE_LINUX}' 未找到。",
                file=sys.stderr,
            )

    else:
        print(
            f"nvim-wrapper: 警告 - 不支持的操作系统 '{sys.platform}'。", file=sys.stderr
        )

    # --- 日志记录区 ---
    print("-------------------------------------")
    print("已加载的环境变量:")
    for env_var in SECRETS_FOR_MACOS.keys():  # 使用 macOS 配置作为总列表
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
        if sys.platform == "darwin":  # 这是 macOS
            nvim_path_result = subprocess.run(
                ["command", "which", "nvim"], capture_output=True, text=True, check=True
            )
        else:
            nvim_path_result = subprocess.run(
                ["which", "nvim"], capture_output=True, text=True, check=True
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
