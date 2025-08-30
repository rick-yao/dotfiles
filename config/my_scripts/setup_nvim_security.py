#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
nvim-wrapper: (Python版)
一个跨平台的安全启动器，用于 Neovim。
- 在 macOS 上，从钥匙串 (Keychain) 读取密钥。
- 在 Linux 上，从一个受限权限的环境文件读取密钥。
- 将密钥作为环境变量注入到 Neovim 进程中。
"""

import sys
import os
import subprocess
from pathlib import Path

# --- 配置区 ---

# [Linux 配置]: 定义存储秘密的文件的路径。
SECRETS_FILE_PATH = Path.home() / ".config/secrets.env"

# [统一配置]: 定义需要处理的环境变量。
# 格式: (环境变量名, macOS服务名, macOS账户名)
KEYS_TO_FETCH = [
    ("VERTEX_GEMINI_API_KEY", "com.avante-nvim.api", "VERTEX_GEMINI_API_KEY"),
    (
        "VERTEX_GEMINI_SUGGEST_API_KEY",
        "com.avante-nvim.api",
        "VERTEX_GEMINI_SUGGEST_API_KEY",
    ),
]


def main():
    """主执行函数"""
    print("正在为 Neovim 准备安全环境...")

    # --- 核心逻辑区 ---

    # 检查操作系统
    if sys.platform == "darwin":  # macOS
        for env_var, service, account in KEYS_TO_FETCH:
            try:
                # 构建 security 命令
                command = [
                    "security",
                    "find-generic-password",
                    "-s",
                    service,
                    "-a",
                    account,
                    "-w",
                ]
                # 执行命令，捕获输出，并将错误输出重定向到null
                result = subprocess.run(
                    command,
                    capture_output=True,
                    text=True,
                    check=False,
                    stderr=subprocess.DEVNULL,
                )

                # 如果命令成功且有输出，则设置环境变量
                if result.returncode == 0 and result.stdout:
                    os.environ[env_var] = result.stdout.strip()
                else:
                    os.environ[env_var] = ""
            except Exception:
                os.environ[env_var] = ""

    elif sys.platform.startswith("linux"):  # Linux
        if SECRETS_FILE_PATH.is_file():
            try:
                # 读取并解析 .env 文件
                with open(SECRETS_FILE_PATH, "r", encoding="utf-8") as f:
                    for line in f:
                        line = line.strip()
                        if not line or line.startswith("#"):
                            continue

                        # 解析 'export KEY="VALUE"' 或 'export KEY=VALUE'
                        if line.startswith("export "):
                            line = line[len("export ") :]

                        if "=" in line:
                            key, value = line.split("=", 1)
                            # 去除可能存在的引号
                            if (value.startswith('"') and value.endswith('"')) or (
                                value.startswith("'") and value.endswith("'")
                            ):
                                value = value[1:-1]
                            os.environ[key] = value
            except Exception as e:
                print(f"nvim-wrapper: 警告 - 读取秘密文件时出错: {e}", file=sys.stderr)
        else:
            print(
                f"nvim-wrapper: 警告 - 秘密文件 '{SECRETS_FILE_PATH}' 未找到。",
                file=sys.stderr,
            )

    else:
        print(
            f"nvim-wrapper: 警告 - 不支持的操作系统 '{sys.platform}'。", file=sys.stderr
        )

    # --- 日志记录区 ---
    print("-------------------------------------")
    print("已加载的环境变量:")
    for env_var, _, _ in KEYS_TO_FETCH:
        current_value = os.getenv(env_var)
        if current_value:
            censored_value = f"{current_value[:4]}..."
            print(f"  ✓ {env_var} = {censored_value}")
        else:
            print(f"  ✗ {env_var} = [未设置或为空]")
    print("-------------------------------------")

    # --- 执行区 ---
    print("环境设置完毕，正在启动 Neovim...")
    try:
        # 使用 command which 确保找到的是真实的可执行文件，而不是别名
        nvim_path_result = subprocess.run(
            ["command", "which", "nvim"], capture_output=True, text=True, check=True
        )
        nvim_path = nvim_path_result.stdout.strip()

        # 将要传递给 nvim 的参数列表 (脚本自身的名字 + 后续所有参数)
        args_to_pass = [nvim_path] + sys.argv[1:]

        # 使用 os.execvp 将当前Python进程替换为nvim进程，这是最高效的方式
        os.execvp(nvim_path, args_to_pass)

    except (subprocess.CalledProcessError, FileNotFoundError):
        print("nvim-wrapper: 致命错误 - 未能在 $PATH 中找到 'nvim'。", file=sys.stderr)
        sys.exit(1)
    except OSError as e:
        print(f"nvim-wrapper: 致命错误 - 执行 nvim 失败: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
