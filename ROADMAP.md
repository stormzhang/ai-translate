# ROADMAP

## 当前阶段

稳定迭代期：核心功能（翻译 + 语音）已完成，按需扩展新平台适配。

## 已完成

- 2026-08-11 12:16 适配 Kimi Code：install.sh 新增检测与安装（`~/.kimi-code/skills/t|ts/SKILL.md`，调用方式 `/skill:t word`），README / README_EN / CLAUDE.md 同步更新，版本升级至 v1.2.0
- 2026-08-11 12:36 发布 v1.2.1：版本号升级，打 tag 并发布 GitHub Release
- Claude Code、Codex、OpenCode、Cursor、Windsurf 五平台适配（v1.1.0 及之前，具体日期见 git 历史）

## 进行中

无

## 待办

- Windows / Linux 平台语音朗读功能实测验证（README 中标注未经测试）

## 阻塞

无

## 最近验证

- 2026-08-11 12:16 `bash -n install.sh` 语法检查通过；本机执行 `bash install.sh` 成功安装 Kimi Code skill（输出 `[OK] Kimi Code - installed`），装好的 `~/.kimi-code/skills/t/SKILL.md` 与 `ts/SKILL.md` 内容格式检查无误
