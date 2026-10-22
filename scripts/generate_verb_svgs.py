import json, os

PALETTES = {
    "action": {"bg": "#EFF6FF", "primary": "#2563EB", "secondary": "#60A5FA"},     # أزرق حركي
    "mind": {"bg": "#F5F3FF", "primary": "#7C3AED", "secondary": "#A78BFA"},       # بنفسجي معرفي
    "vital": {"bg": "#ECFDF5", "primary": "#059669", "secondary": "#34D399"},      # أخضر حيوي
    "state": {"bg": "#FFFBEB", "primary": "#D97706", "secondary": "#FBBF24"}       # كهرماني حالة
}

def create_verb_svg(path, theme, sym):
    p = PALETTES[theme]
    symbols = {
        "be": f'<circle cx="50" cy="50" r="28" stroke="{p["primary"]}" stroke-width="6" fill="none"/><circle cx="50" cy="50" r="14" fill="{p["secondary"]}"/>',
        "have": f'<rect x="28" y="32" width="44" height="42" rx="10" fill="{p["primary"]}"/><path d="M40 32 V24 C40 18 60 18 60 24 V32" stroke="{p["secondary"]}" stroke-width="4" fill="none"/>',
        "eat": f'<circle cx="50" cy="50" r="26" fill="{p["secondary"]}"/><path d="M50 24 L50 76 M24 50 L76 50" stroke="#FFF" stroke-width="4"/>',
        "drink": f'<path d="M34 26 L66 26 L60 76 C59 80 55 84 50 84 C45 84 41 80 40 76 Z" fill="{p["primary"]}"/>',
        "go": f'<circle cx="44" cy="30" r="10" fill="{p["primary"]}"/><path d="M36 50 L52 46 L64 68 M44 56 L30 76" stroke="{p["primary"]}" stroke-width="5" stroke-linecap="round"/>',
        "come": f'<path d="M24 50 L64 50 M50 36 L66 50 L50 64" stroke="{p["primary"]}" stroke-width="7" stroke-linecap="round" stroke-linejoin="round"/>',
        "speak": f'<rect x="22" y="28" width="56" height="38" rx="12" fill="{p["primary"]}"/><polygon points="34,66 46,66 30,78" fill="{p["primary"]}"/><line x1="32" y1="42" x2="64" y2="42" stroke="#FFF" stroke-width="4" stroke-linecap="round"/><line x1="32" y1="52" x2="52" y2="52" stroke="#FFF" stroke-width="4" stroke-linecap="round"/>',
        "learn": f'<path d="M50 24 L20 40 L50 56 L80 40 Z" fill="{p["primary"]}"/><path d="M30 46 V64 C30 72 70 72 70 64 V46" stroke="{p["secondary"]}" stroke-width="4" fill="none"/>',
        "sleep": f'<path d="M60 28 C42 28 32 44 34 60 C36 72 46 80 60 80 C52 74 48 64 50 52 C52 40 60 32 60 28 Z" fill="{p["primary"]}"/><text x="64" y="38" font-size="16" font-family="sans-serif" font-weight="bold" fill="{p["secondary"]}">Z</text>',
        "see": f'<path d="M18 50 C30 32 70 32 82 50 C70 68 30 68 18 50 Z" fill="{p["primary"]}"/><circle cx="50" cy="50" r="12" fill="#FFF"/><circle cx="50" cy="50" r="6" fill="{p["secondary"]}"/>',
        "hear": f'<path d="M46 24 C32 24 24 36 24 50 C24 66 34 76 46 76 C54 76 60 70 60 62 C60 54 52 50 44 50" stroke="{p["primary"]}" stroke-width="6" stroke-linecap="round" fill="none"/>',
        "write": f'<path d="M30 70 L70 30 L60 20 L20 60 L18 72 Z" fill="{p["primary"]}"/><line x1="16" y1="84" x2="84" y2="84" stroke="{p["secondary"]}" stroke-width="4"/>',
        "read": f'<path d="M50 36 C38 28 20 28 20 72 C38 68 50 74 50 74 C50 74 62 68 80 72 C80 28 62 28 50 36 Z" fill="{p["primary"]}"/><line x1="50" y1="36" x2="50" y2="74" stroke="#FFF" stroke-width="3"/>',
        "make": f'<rect x="32" y="32" width="36" height="36" rx="8" fill="{p["primary"]}"/><polygon points="50,20 62,32 38,32" fill="{p["secondary"]}"/><circle cx="50" cy="50" r="6" fill="#FFF"/>',
        "live": f'<polygon points="50,22 80,48 20,48" fill="{p["primary"]}"/><rect x="28" y="48" width="44" height="32" fill="{p["secondary"]}"/><rect x="44" y="60" width="12" height="20" fill="#FFF"/>'
    }
    content = symbols.get(sym, symbols["be"])
    svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%"><rect width="100" height="100" rx="24" fill="{p["bg"]}" />{content}</svg>'
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg)

VERB_MAP = [
    ("img_verb_be", "state", "be"), ("img_verb_have", "state", "have"),
    ("img_verb_eat", "vital", "eat"), ("img_verb_drink", "vital", "drink"),
    ("img_verb_go", "action", "go"), ("img_verb_come", "action", "come"),
    ("img_verb_speak", "mind", "speak"), ("img_verb_learn", "mind", "learn"),
    ("img_verb_sleep", "vital", "sleep"), ("img_verb_see", "mind", "see"),
    ("img_verb_hear", "mind", "hear"), ("img_verb_write", "action", "write"),
    ("img_verb_read", "mind", "read"), ("img_verb_make", "action", "make"),
    ("img_verb_live", "state", "live")
]

with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
    reg = json.load(f)

for img_id, theme, sym in VERB_MAP:
    path = f"content/assets/svg/{img_id}.svg"
    create_verb_svg(path, theme, sym)
    reg["assets"][img_id] = {
        "asset_path": path,
        "format": "svg",
        "ownership": "Project Original",
        "license": "CC0-1.0",
        "size_bytes": os.path.getsize(path)
    }

with open("content/assets/images_registry.json", "w", encoding="utf-8") as f:
    json.dump(reg, f, ensure_ascii=False, indent=2)

print(f"Generated 15 verb SVG assets. Total registry assets: {len(reg['assets'])}")
