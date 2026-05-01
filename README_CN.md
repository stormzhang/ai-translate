# ai-translate

[English](README.md)

AI 编程工具的翻译插件，一行命令安装，支持多语言翻译和语音朗读。

---

## 功能特性

- **多语言翻译** — 自动识别输入语言，中文翻英文，其他语言翻中文
- **多义词** — 多个常用含义分行展示，最多 5 个
- **语音朗读** — 翻译后自动朗读原文（macOS / Windows / Linux）
- **AI 工具识别** — 识别当前 AI 工具的命令并补充用法说明
- **Markdown 排版** — 加粗、斜体、代码样式，终端阅读更清晰
- **多工具支持** — Claude Code、Codex、OpenCode、Cursor

## 安装

### 一行命令安装

```bash
curl -fsSL https://raw.githubusercontent.com/stormzhang/ai-translate/master/install.sh | bash
```

### 或者 clone 安装

```bash
git clone https://github.com/stormzhang/ai-translate.git
cd ai-translate
./install.sh
```

安装脚本会自动检测已安装的 AI 工具：

```
[OK] Claude Code - installed
[OK] Codex - installed

Done! v1.0.0 installed

Usage:
  /t word          translate
  /ts word         translate + speech
```

## 使用方法

### `/t` — 纯翻译

#### 翻译单词

```
> /t ephemeral

【ephemeral】 /ɪˈfemərəl/
adj. 短暂的，转瞬即逝的
示例：The beauty of cherry blossoms is ephemeral.
翻译：樱花之美转瞬即逝。
```

#### 多义词

```
> /t run

【run】 /rʌn/
1. v. 跑，奔跑
2. v. 运行，执行（程序、命令）
3. v. 经营，管理
4. v. 运转，运行（机器）
5. n. 奔跑；一段时间
示例：The program runs smoothly on my machine.
翻译：这个程序在我的机器上运行流畅。
```

#### 中文翻译为英文

```
> /t 短暂的

【短暂的】 ephemeral /ɪˈfemərəl/
示例：Fame is ephemeral, but knowledge lasts forever.
翻译：名声转瞬即逝，但知识永存。
```

#### 翻译句子

```
> /t See what the GitHub community is most excited about today.

看看今天 GitHub 社区最热门的是什么。
```

#### AI 工具命令识别

```
> /t hook

【hook】 /hʊk/
1. n. 钩子，挂钩
2. v. 钩住，挂住
示例：Hang your coat on the hook behind the door.
翻译：把你的外套挂在门后的钩子上。

Claude Code 内部命令：hook 是在特定事件（如工具调用前后）自动执行的
shell 脚本，通过 settings.json 配置，用于自动化工作流。
```

### `/ts` — 翻译 + 语音朗读

功能同 `/t`，翻译完成后自动朗读英文原文。

```
> /ts deprecated

【deprecated】 /ˈdeprəkeɪtɪd/
adj. 已弃用的，不推荐使用的
示例：This API method is deprecated and will be removed in v3.
翻译：这个 API 方法已弃用，将在 v3 中移除。

🔊 Playing audio...
```

各平台语音引擎：

| 平台 | 引擎 |
|------|------|
| macOS | `say -v Samantha` |
| Windows | PowerShell `SpeechSynthesizer` |
| Linux | `espeak` |

> 注：Windows 和 Linux 平台的语音功能未经测试，欢迎反馈。

## 支持工具

| 工具 | 安装路径 | 调用方式 |
|------|---------|---------|
| Claude Code（CLI / 桌面版 / Web） | `~/.claude/commands/` | `/t word` |
| Codex | `~/.codex/prompts/` | `/prompts:t word` |
| OpenCode | `~/.config/opencode/commands/` | `Ctrl+K` → `user:t` |
| Cursor | `~/.cursor/commands/` | `/t word` |

## 更新

再次运行安装命令即可。检测到已安装时会询问是否覆盖：

```
Claude Code 已安装翻译工具，是否覆盖更新？(y/N) y
[OK] Claude Code - updated
```

## 卸载

手动删除命令文件：

```bash
# Claude Code
rm ~/.claude/commands/t.md ~/.claude/commands/ts.md

# Codex
rm ~/.codex/prompts/t.md ~/.codex/prompts/ts.md

# OpenCode
rm ~/.config/opencode/commands/t.md ~/.config/opencode/commands/ts.md

# Cursor
rm ~/.cursor/commands/t.md ~/.cursor/commands/ts.md
```

## License

[MIT](LICENSE)

## Author

**stormzhang** — [@stormzhang](https://github.com/stormzhang)
