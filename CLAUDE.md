# ai-translate

AI 编程工具的翻译插件，通过自定义命令实现终端内翻译。

## 项目结构

```
install.sh          # 一键安装脚本（核心，内嵌所有 prompt 内容）
prompts/           # prompt 源文件（开发参考，不参与安装）
  t.md              # 纯翻译
  ts.md             # 翻译 + 语音
assets/             # README 资源
  demo.png          # 终端截图
README.md           # 中文默认文档
README_EN.md        # 英文文档
README_CN.md        # 中文文档兼容入口
```

## 支持工具

| 工具 | 安装路径 | 调用方式 |
|------|---------|---------|
| Claude Code | `~/.claude/skills/t/SKILL.md` | `/t word` |
| Codex | `~/.codex/skills/t/SKILL.md` | `$t word` |
| OpenCode | `~/.config/opencode/commands/` | `Ctrl+K → user:t` |
| Cursor | `~/.cursor/commands/` | `/t word` |
| Windsurf | `~/.codeium/windsurf/global_workflows/` | `/t word` |

## 开发约定

- prompt 内容以 `install.sh` 内嵌的 heredoc 为准，`prompts/` 目录仅做参考
- 修改 prompt 后需同步更新 `install.sh` 中对应的 heredoc
- Claude Code 使用 skills 格式（带 `context: fork` 省 token），Codex/Windsurf 需要 YAML frontmatter，在 install.sh 中通过变量拼接生成
- 版本号在 `install.sh` 顶部的 `VERSION` 变量管理

## 验证方式

```bash
bash -n install.sh        # 语法检查
bash install.sh           # 本地安装测试
```
