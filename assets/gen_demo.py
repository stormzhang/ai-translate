from PIL import Image, ImageDraw, ImageFont

# --- Config ---
WIDTH = 780
BG = "#1a1b26"
TITLE_BG = "#24283b"
DOT_RED = "#f7768e"
DOT_YELLOW = "#e0af68"
DOT_GREEN = "#9ece6a"
WHITE = "#c0caf5"
GREEN = "#9ece6a"
CYAN = "#7dcfff"
YELLOW = "#e0af68"
GRAY = "#565f89"
MAGENTA = "#bb9af7"
BOLD_WHITE = "#ffffff"

FONT_SIZE = 14
LINE_HEIGHT = 22
TITLE_HEIGHT = 36
PAD_X = 22
PAD_Y = 14
DOT_R = 6
DOT_Y_POS = TITLE_HEIGHT // 2
DOT_START_X = 18
DOT_GAP = 22
CORNER_R = 10

FONT_PATH = "/System/Library/Fonts/Menlo.ttc"
CJK_FONT_PATH = "/System/Library/Fonts/STHeiti Medium.ttc"

font = ImageFont.truetype(FONT_PATH, FONT_SIZE)
cjk_font = ImageFont.truetype(CJK_FONT_PATH, FONT_SIZE)

def get_font(char):
    if ord(char) > 0x2E80:
        return cjk_font
    return font

def draw_styled_text(draw, x, y, text, color):
    cx = x
    for ch in text:
        f = get_font(ch)
        draw.text((cx, y), ch, fill=color, font=f)
        bbox = f.getbbox(ch)
        cx += bbox[2] - bbox[0]

def text_width(text):
    w = 0
    for ch in text:
        f = get_font(ch)
        bbox = f.getbbox(ch)
        w += bbox[2] - bbox[0]
    return w

# --- Content: (text, color, extra_top_margin) ---
lines = [
    # Example 1 - English word
    ("> /t ephemeral", GREEN, 0),
    ("", None, 0),
    ("【ephemeral】 /ɪˈfemərəl/", "HEADER", 0),
    ("adj. 短暂的，转瞬即逝的", WHITE, 0),
    ("示例：The beauty of cherry blossoms is ephemeral.", YELLOW, 0),
    ("翻译：樱花之美转瞬即逝。", WHITE, 0),
    # separator
    ("SEP", None, 10),
    # Example 2 - Sentence
    ("> /t See what the GitHub community is most excited about today.", GREEN, 10),
    ("", None, 0),
    ("看看今天 GitHub 社区最热门的是什么。", WHITE, 0),
    # separator
    ("SEP", None, 10),
    # Example 3 - AI tool command recognition
    ("> /t hook", GREEN, 10),
    ("", None, 0),
    ("【hook】 /hʊk/", "HEADER", 0),
    ("1. n. 钩子，挂钩", WHITE, 0),
    ("2. v. 钩住，挂住", WHITE, 0),
    ("示例：Hang your coat on the hook behind the door.", YELLOW, 0),
    ("翻译：把你的外套挂在门后的钩子上。", WHITE, 0),
    ("", None, 0),
    ("Claude Code 内部命令：hook 是在特定事件自动执行的", MAGENTA, 0),
    ("shell 脚本，通过 settings.json 配置。", MAGENTA, 0),
]

# Calculate height
total_h = TITLE_HEIGHT + PAD_Y
for text, color, margin in lines:
    total_h += margin
    total_h += LINE_HEIGHT if text != "SEP" else 1
total_h += PAD_Y
HEIGHT = total_h

# --- Draw ---
img = Image.new("RGBA", (WIDTH, HEIGHT), (0, 0, 0, 0))
draw = ImageDraw.Draw(img)

# Background
draw.rounded_rectangle(
    [(0, 0), (WIDTH - 1, HEIGHT - 1)],
    radius=CORNER_R, fill=BG, outline="#414868", width=1
)

# Title bar
draw.rounded_rectangle(
    [(0, 0), (WIDTH - 1, TITLE_HEIGHT)],
    radius=CORNER_R, fill=TITLE_BG
)
draw.rectangle(
    [(0, TITLE_HEIGHT - CORNER_R), (WIDTH - 1, TITLE_HEIGHT)],
    fill=TITLE_BG
)
draw.line([(0, TITLE_HEIGHT), (WIDTH - 1, TITLE_HEIGHT)], fill="#414868", width=1)

# Traffic lights
for i, c in enumerate([DOT_RED, DOT_YELLOW, DOT_GREEN]):
    cx = DOT_START_X + i * DOT_GAP
    draw.ellipse(
        [(cx - DOT_R, DOT_Y_POS - DOT_R), (cx + DOT_R, DOT_Y_POS + DOT_R)],
        fill=c
    )

# Title
title = "ai-translate"
tw = text_width(title)
draw.text(((WIDTH - tw) // 2, DOT_Y_POS - FONT_SIZE // 2), title, fill=GRAY, font=font)

# Content
y = TITLE_HEIGHT + PAD_Y
for text, color, margin in lines:
    y += margin

    if text == "SEP":
        draw.line([(PAD_X, y), (WIDTH - PAD_X, y)], fill="#2f3549", width=1)
        y += 1
        continue

    if not text:
        y += LINE_HEIGHT
        continue

    if color == "HEADER":
        bracket_end = text.index("】") + 1
        word_part = text[:bracket_end]
        rest = text[bracket_end:]
        draw_styled_text(draw, PAD_X, y, word_part, BOLD_WHITE)
        w = text_width(word_part)
        draw_styled_text(draw, PAD_X + w, y, rest, CYAN)
        y += LINE_HEIGHT
        continue

    draw_styled_text(draw, PAD_X, y, text, color)
    y += LINE_HEIGHT

# Save
out = "/Users/stormzhang/project/translate/assets/demo.png"
img.save(out, "PNG")
print(f"Saved: {WIDTH}x{HEIGHT}")
