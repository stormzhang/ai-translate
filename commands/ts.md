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
