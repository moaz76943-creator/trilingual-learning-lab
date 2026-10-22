import json, os

PALETTES = {
    "happy": {"bg": "#FEF3C7", "primary": "#D97706", "secondary": "#FBBF24"},
    "calm": {"bg": "#EFF6FF", "primary": "#2563EB", "secondary": "#60A5FA"},
    "alert": {"bg": "#FEF2F2", "primary": "#DC2626", "secondary": "#F87171"},
    "good": {"bg": "#ECFDF5", "primary": "#059669", "secondary": "#34D399"},
    "neutral": {"bg": "#F8FAFC", "primary": "#475569", "secondary": "#94A3B8"}
}

def create_feel_svg(path, theme, sym):
    p = PALETTES[theme]
    symbols = {
        "smile": f'<circle cx="50" cy="50" r="26" fill="{p["primary"]}"/><circle cx="40" cy="44" r="3" fill="#FFF"/><circle cx="60" cy="44" r="3" fill="#FFF"/><path d="M38 56 Q50 68 62 56" stroke="#FFF" stroke-width="4" stroke-linecap="round" fill="none"/>',
        "sad": f'<circle cx="50" cy="50" r="26" fill="{p["primary"]}"/><circle cx="40" cy="46" r="3" fill="#FFF"/><circle cx="60" cy="46" r="3" fill="#FFF"/><path d="M38 62 Q50 52 62 62" stroke="#FFF" stroke-width="4" stroke-linecap="round" fill="none"/>',
        "angry": f'<circle cx="50" cy="50" r="26" fill="{p["primary"]}"/><line x1="34" y1="40" x2="44" y2="44" stroke="#FFF" stroke-width="3"/><line x1="66" y1="40" x2="56" y2="44" stroke="#FFF" stroke-width="3"/><circle cx="40" cy="48" r="3" fill="#FFF"/><circle cx="60" cy="48" r="3" fill="#FFF"/><line x1="38" y1="60" x2="62" y2="60" stroke="#FFF" stroke-width="3"/>',
        "big": f'<rect x="22" y="22" width="56" height="56" rx="8" fill="{p["primary"]}"/><rect x="34" y="34" width="32" height="32" rx="4" fill="#FFF"/>',
        "small": f'<rect x="36" y="36" width="28" height="28" rx="6" fill="{p["primary"]}"/><circle cx="50" cy="50" r="5" fill="#FFF"/>',
        "good": f'<circle cx="50" cy="50" r="26" fill="{p["primary"]}"/><path d="M36 50 L46 60 L64 40" stroke="#FFF" stroke-width="5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>',
        "bad": f'<circle cx="50" cy="50" r="26" fill="{p["primary"]}"/><line x1="38" y1="38" x2="62" y2="62" stroke="#FFF" stroke-width="5" stroke-linecap="round"/><line x1="62" y1="38" x2="38" y2="62" stroke="#FFF" stroke-width="5" stroke-linecap="round"/>',
        "heart": f'<path d="M50 32 C40 20 22 26 22 44 C22 64 50 80 50 80 C50 80 78 64 78 44 C78 26 60 20 50 32 Z" fill="{p["primary"]}"/>'
    }
    content = symbols.get(sym, symbols["smile"])
    svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%"><rect width="100" height="100" rx="24" fill="{p["bg"]}" />{content}</svg>'
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg)

FEEL_MAP = [
    ("img_feel_happy", "happy", "smile"), ("img_feel_sad", "calm", "sad"),
    ("img_feel_big", "good", "big"), ("img_feel_small", "neutral", "small"),
    ("img_feel_good", "good", "good"), ("img_feel_bad", "alert", "bad"),
    ("img_feel_hot", "alert", "smile"), ("img_feel_cold", "calm", "smile"),
    ("img_feel_fast", "happy", "big"), ("img_feel_slow", "neutral", "small"),
    ("img_feel_tired", "calm", "sad"), ("img_feel_active", "good", "smile"),
    ("img_feel_new", "good", "good"), ("img_feel_old", "neutral", "small"),
    ("img_feel_beautiful", "happy", "heart"), ("img_feel_ugly", "neutral", "sad"),
    ("img_feel_easy", "good", "good"), ("img_feel_difficult", "alert", "bad"),
    ("img_feel_rich", "happy", "big"), ("img_feel_poor", "neutral", "small"),
    ("img_feel_hungry", "happy", "smile"), ("img_feel_thirsty", "calm", "smile"),
    ("img_feel_friendly", "good", "smile"), ("img_feel_angry", "alert", "angry"),
    ("img_feel_heart", "alert", "heart")
]

with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
    reg = json.load(f)

for img_id, theme, sym in FEEL_MAP:
    path = f"content/assets/svg/{img_id}.svg"
    create_feel_svg(path, theme, sym)
    reg["assets"][img_id] = {
        "asset_path": path,
        "format": "svg",
        "ownership": "Project Original",
        "license": "CC0-1.0",
        "size_bytes": os.path.getsize(path)
    }

with open("content/assets/images_registry.json", "w", encoding="utf-8") as f:
    json.dump(reg, f, ensure_ascii=False, indent=2)

print(f"Generated 25 feelings/adjectives SVG assets. Total registry assets: {len(reg['assets'])}")
