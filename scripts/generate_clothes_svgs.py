import json, os

PALETTES = {
    "upper": {"bg": "#EFF6FF", "primary": "#1D4ED8", "secondary": "#60A5FA"},     # أزرق ملابس علوية
    "lower": {"bg": "#F5F3FF", "primary": "#6D28D9", "secondary": "#A78BFA"},     # بنفسجي ملابس سفلية
    "formal": {"bg": "#F8FAFC", "primary": "#0F172A", "secondary": "#475569"},    # رسمي ورمادي
    "casual": {"bg": "#FFF1F2", "primary": "#E11D48", "secondary": "#FB7185"},    # وردي/أحمر كاجوال
    "accessory": {"bg": "#FEF3C7", "primary": "#B45309", "secondary": "#FBBF24"}  # إكسسوارات كهرمانية
}

def create_cloth_svg(path, theme, sym):
    p = PALETTES[theme]
    symbols = {
        "shirt": f'<path d="M34 26 L50 36 L66 26 L80 38 L72 50 L64 44 L64 80 L36 80 L36 44 L28 50 L20 38 Z" fill="{p["primary"]}"/><polygon points="44,26 50,34 56,26" fill="#FFF"/>',
        "pants": f'<path d="M28 24 L72 24 L68 84 L52 84 L50 48 L48 84 L32 84 Z" fill="{p["primary"]}"/><line x1="28" y1="32" x2="72" y2="32" stroke="{p["secondary"]}" stroke-width="3"/>',
        "dress": f'<path d="M38 24 L62 24 L58 46 L76 82 L24 82 L42 46 Z" fill="{p["primary"]}"/><circle cx="50" cy="24" r="8" fill="{p["bg"]}"/>',
        "shoe": f'<path d="M20 62 L40 50 L60 50 L80 62 L80 74 L20 74 Z" fill="{p["primary"]}"/><rect x="20" y="70" width="16" height="10" fill="{p["secondary"]}"/>',
        "hat": f'<path d="M30 46 C30 28 70 28 70 46 L86 52 C86 58 14 58 14 52 Z" fill="{p["primary"]}"/><rect x="30" y="44" width="40" height="4" fill="{p["secondary"]}"/>',
        "glasses": f'<circle cx="34" cy="50" r="14" stroke="{p["primary"]}" stroke-width="5" fill="none"/><circle cx="66" cy="50" r="14" stroke="{p["primary"]}" stroke-width="5" fill="none"/><line x1="48" y1="50" x2="52" y2="50" stroke="{p["primary"]}" stroke-width="5"/>',
        "watch": f'<rect x="44" y="16" width="12" height="68" rx="3" fill="{p["secondary"]}"/><circle cx="50" cy="50" r="18" fill="{p["primary"]}"/><circle cx="50" cy="50" r="14" fill="#FFF"/><line x1="50" y1="50" x2="50" y2="40" stroke="{p["primary"]}" stroke-width="3" stroke-linecap="round"/><line x1="50" y1="50" x2="58" y2="50" stroke="{p["primary"]}" stroke-width="3" stroke-linecap="round"/>',
        "umbrella": f'<path d="M18 52 C18 30 82 30 82 52 Z" fill="{p["primary"]}"/><line x1="50" y1="26" x2="50" y2="76" stroke="{p["secondary"]}" stroke-width="4"/><path d="M50 76 C50 82 42 82 42 76" stroke="{p["secondary"]}" stroke-width="4" fill="none"/>',
        "bag": f'<rect x="24" y="38" width="52" height="44" rx="8" fill="{p["primary"]}"/><path d="M38 38 V26 C38 20 62 20 62 26 V38" stroke="{p["secondary"]}" stroke-width="5" fill="none"/>',
        "accessory": f'<circle cx="50" cy="50" r="22" stroke="{p["primary"]}" stroke-width="8" fill="none"/><circle cx="50" cy="28" r="6" fill="{p["secondary"]}"/>'
    }
    content = symbols.get(sym, symbols["shirt"])
    svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%"><rect width="100" height="100" rx="24" fill="{p["bg"]}" />{content}</svg>'
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg)

CLOTH_MAP = [
    ("img_cloth_shirt", "upper", "shirt"), ("img_cloth_tshirt", "casual", "shirt"),
    ("img_cloth_trousers", "lower", "pants"), ("img_cloth_jacket", "formal", "shirt"),
    ("img_cloth_coat", "formal", "shirt"), ("img_cloth_dress", "casual", "dress"),
    ("img_cloth_skirt", "casual", "dress"), ("img_cloth_shoes", "formal", "shoe"),
    ("img_cloth_boots", "formal", "shoe"), ("img_cloth_socks", "upper", "shoe"),
    ("img_cloth_hat", "accessory", "hat"), ("img_cloth_cap", "casual", "hat"),
    ("img_cloth_scarf", "casual", "hat"), ("img_cloth_gloves", "accessory", "hat"),
    ("img_cloth_belt", "formal", "pants"), ("img_cloth_tie", "formal", "shirt"),
    ("img_cloth_suit", "formal", "shirt"), ("img_cloth_pullover", "upper", "shirt"),
    ("img_cloth_glasses", "formal", "glasses"), ("img_cloth_watch", "accessory", "watch"),
    ("img_cloth_ring", "accessory", "accessory"), ("img_cloth_umbrella", "casual", "umbrella"),
    ("img_cloth_wallet", "formal", "bag"), ("img_cloth_bag", "casual", "bag"),
    ("img_cloth_pajamas", "casual", "shirt")
]

with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
    reg = json.load(f)

for img_id, theme, sym in CLOTH_MAP:
    path = f"content/assets/svg/{img_id}.svg"
    create_cloth_svg(path, theme, sym)
    reg["assets"][img_id] = {
        "asset_path": path,
        "format": "svg",
        "ownership": "Project Original",
        "license": "CC0-1.0",
        "size_bytes": os.path.getsize(path)
    }

with open("content/assets/images_registry.json", "w", encoding="utf-8") as f:
    json.dump(reg, f, ensure_ascii=False, indent=2)

print(f"Generated 25 clothes SVG assets. Total registry assets: {len(reg['assets'])}")
