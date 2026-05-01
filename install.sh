#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
COMMANDS_DIR="$SCRIPT_DIR/commands"
INSTALLED=0

# Claude Code
CLAUDE_DIR="$HOME/.claude/commands"
if [ -d "$HOME/.claude" ]; then
    mkdir -p "$CLAUDE_DIR"
    cp "$COMMANDS_DIR/t.md" "$CLAUDE_DIR/t.md"
    cp "$COMMANDS_DIR/ts.md" "$CLAUDE_DIR/ts.md"
    echo "[OK] Claude Code - installed to $CLAUDE_DIR"
    INSTALLED=1
fi

# Codex
CODEX_DIR="$HOME/.codex/prompts"
if [ -d "$HOME/.codex" ]; then
    mkdir -p "$CODEX_DIR"
    cp "$COMMANDS_DIR/t.md" "$CODEX_DIR/t.md"
    cp "$COMMANDS_DIR/ts.md" "$CODEX_DIR/ts.md"
    echo "[OK] Codex - installed to $CODEX_DIR"
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
