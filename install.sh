#!/bin/bash

VERSION="1.0.0"
INSTALLED=0

# --- embedded command files ---

read -r -d '' T_MD << 'PROMPT_EOF'
AI 翻译（支持中英双向及多语言）@author: stormzhang

自动识别输入语言。中文翻译为英文，其他任何语言都翻译为中文。

如果输入是英文单个单词，按这个格式输出：
**【单词】** `音标`
词性. 中文释义（如果有多个常用词性或含义，分行列出，最多 5 个）
*示例：简短英文例句*（只需 1 个，挑最常用的含义）
翻译：例句的中文翻译

如果输入是中文单个词语，按这个格式输出：
**【词语】** 对应英文单词 `音标`
*示例：简短英文例句*
翻译：例句的中文翻译

如果是短语或句子，直接给出对应语言的翻译即可。

不要多余的解释和废话。

如果输入的词恰好是当前 AI 编程工具的命令或概念，翻译完成后额外补充：
{当前工具名}内部命令：说明这个词在当前工具中的含义和用法，简短即可。只说当前工具，不要列举其他工具。

要翻译的内容：$ARGUMENTS
PROMPT_EOF

read -r -d '' TS_MD << 'PROMPT_EOF'
AI 翻译 + 语音朗读（支持中英双向及多语言）@author: stormzhang

自动识别输入语言。中文翻译为英文，其他任何语言都翻译为中文。

如果输入是英文单个单词，按这个格式输出：
**【单词】** `音标`
词性. 中文释义（如果有多个常用词性或含义，分行列出，最多 5 个）
*示例：简短英文例句*（只需 1 个，挑最常用的含义）
翻译：例句的中文翻译

如果输入是中文单个词语，按这个格式输出：
**【词语】** 对应英文单词 `音标`
*示例：简短英文例句*
翻译：例句的中文翻译

如果是短语或句子，直接给出对应语言的翻译即可。

不要多余的解释和废话。

如果输入的词恰好是当前 AI 编程工具的命令或概念，翻译完成后额外补充：
{当前工具名}内部命令：说明这个词在当前工具中的含义和用法，简短即可。只说当前工具，不要列举其他工具。

翻译完成后，用 Bash 工具朗读英文原文：
- macOS: `say -v Samantha '$ARGUMENTS'`（必须指定 -v Samantha，默认语音有 bug）
- Windows: `powershell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('$ARGUMENTS')"`
- Linux: `espeak '$ARGUMENTS'`

根据当前系统自动选择对应命令。

要翻译的内容：$ARGUMENTS
PROMPT_EOF

# --- codex skills format ---

CODEX_T_SKILL="---
name: t
description: AI 翻译（支持中英双向及多语言）
---

$T_MD"

CODEX_TS_SKILL="---
name: ts
description: AI 翻译 + 语音朗读（支持中英双向及多语言）
---

$TS_MD"

# --- install ---

install_commands() {
    local name=$1 dir=$2
    mkdir -p "$dir"
    if [ -f "$dir/t.md" ]; then
        printf "$name 已安装翻译工具，是否覆盖更新？(y/N) "
        read -r answer < /dev/tty
        if [ "$answer" != "y" ] && [ "$answer" != "Y" ]; then
            echo "[SKIP] $name - skipped"
            INSTALLED=1
            return
        fi
        echo "$T_MD" > "$dir/t.md"
        echo "$TS_MD" > "$dir/ts.md"
        echo "[OK] $name - updated"
    else
        echo "$T_MD" > "$dir/t.md"
        echo "$TS_MD" > "$dir/ts.md"
        echo "[OK] $name - installed"
    fi
    INSTALLED=1
}

install_codex() {
    local t_dir="$HOME/.codex/skills/t"
    local ts_dir="$HOME/.codex/skills/ts"
    mkdir -p "$t_dir" "$ts_dir"
    if [ -f "$t_dir/SKILL.md" ]; then
        printf "Codex 已安装翻译工具，是否覆盖更新？(y/N) "
        read -r answer < /dev/tty
        if [ "$answer" != "y" ] && [ "$answer" != "Y" ]; then
            echo "[SKIP] Codex - skipped"
            INSTALLED=1
            return
        fi
        echo "$CODEX_T_SKILL" > "$t_dir/SKILL.md"
        echo "$CODEX_TS_SKILL" > "$ts_dir/SKILL.md"
        echo "[OK] Codex - updated"
    else
        echo "$CODEX_T_SKILL" > "$t_dir/SKILL.md"
        echo "$CODEX_TS_SKILL" > "$ts_dir/SKILL.md"
        echo "[OK] Codex - installed"
    fi
    rm -f "$HOME/.codex/prompts/t.md" "$HOME/.codex/prompts/ts.md" 2>/dev/null
    INSTALLED=1
}

# Claude Code
if [ -d "$HOME/.claude" ]; then
    install_commands "Claude Code" "$HOME/.claude/commands"
fi

# Codex
if [ -d "$HOME/.codex" ]; then
    install_codex
fi

# OpenCode
OPENCODE_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opencode/commands"
if [ -d "${XDG_CONFIG_HOME:-$HOME/.config}/opencode" ] || [ -d "$HOME/.opencode" ]; then
    [ -d "$HOME/.opencode" ] && OPENCODE_DIR="$HOME/.opencode/commands"
    install_commands "OpenCode" "$OPENCODE_DIR"
fi

# Cursor
if [ -d "$HOME/.cursor" ]; then
    install_commands "Cursor" "$HOME/.cursor/commands"
fi

if [ $INSTALLED -eq 0 ]; then
    echo "未检测到支持的 AI 编程工具，请先安装以下任一工具："
    echo ""
    echo "  Claude Code  https://claude.ai/code"
    echo "  Codex        https://github.com/openai/codex"
    echo "  OpenCode     https://github.com/opencode-ai/opencode"
    echo "  Cursor       https://cursor.com"
    echo ""
    echo "安装完成后重新运行此脚本即可。"
    exit 1
fi

echo ""
echo "Done! v${VERSION} installed"
echo ""
echo "Usage:"
echo "  /t word          translate"
echo "  /ts word         translate + speech"
echo "  (Codex: \$t word / \$ts word)"
