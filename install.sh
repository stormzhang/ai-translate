#!/bin/bash

INSTALLED=0

# --- embedded command files ---

read -r -d '' T_MD << 'PROMPT_EOF'
自动识别输入语言。中文翻译为英文，其他任何语言都翻译为中文。

如果输入是英文单个单词，按这个格式输出：
【单词】音标
词性. 中文释义
示例：简短英文例句
翻译：例句的中文翻译

如果输入是中文单个词语，按这个格式输出：
【词语】对应英文单词（音标）
示例：简短英文例句
翻译：例句的中文翻译

如果是短语或句子，直接给出对应语言的翻译即可。

不要多余的解释和废话。

要翻译的内容：$ARGUMENTS
PROMPT_EOF

read -r -d '' TS_MD << 'PROMPT_EOF'
自动识别输入语言。中文翻译为英文，其他任何语言都翻译为中文。

如果输入是英文单个单词，按这个格式输出：
【单词】音标
词性. 中文释义
示例：简短英文例句
翻译：例句的中文翻译

如果输入是中文单个词语，按这个格式输出：
【词语】对应英文单词（音标）
示例：简短英文例句
翻译：例句的中文翻译

如果是短语或句子，直接给出对应语言的翻译即可。

不要多余的解释和废话。

翻译完成后，用 Bash 工具朗读英文原文：
- macOS: `say -v Samantha '$ARGUMENTS'`（必须指定 -v Samantha，默认语音有 bug）
- Windows: `powershell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('$ARGUMENTS')"`
- Linux: `espeak '$ARGUMENTS'`

根据当前系统自动选择对应命令。

要翻译的内容：$ARGUMENTS
PROMPT_EOF

# --- install ---

# Claude Code
if [ -d "$HOME/.claude" ]; then
    mkdir -p "$HOME/.claude/commands"
    echo "$T_MD" > "$HOME/.claude/commands/t.md"
    echo "$TS_MD" > "$HOME/.claude/commands/ts.md"
    echo "[OK] Claude Code - installed"
    INSTALLED=1
fi

# Codex
if [ -d "$HOME/.codex" ]; then
    mkdir -p "$HOME/.codex/prompts"
    echo "$T_MD" > "$HOME/.codex/prompts/t.md"
    echo "$TS_MD" > "$HOME/.codex/prompts/ts.md"
    echo "[OK] Codex - installed"
    INSTALLED=1
fi

if [ $INSTALLED -eq 0 ]; then
    echo "未检测到 Claude Code 或 Codex，请先安装其中一个。"
    exit 1
fi

echo ""
echo "Done! Usage:"
echo "  /t word          translate"
echo "  /ts word         translate + speech"
