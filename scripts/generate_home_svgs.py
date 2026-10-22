import json, os

PALETTES = {
    "structure": {"bg": "#F1F5F9", "primary": "#334155", "secondary": "#64748B"}, # ألوان معمارية رمادية
    "comfort": {"bg": "#FDF4FF", "primary": "#A21CAF", "secondary": "#E879F9"},   # بنفسجي أثاث وراحة
    "nature": {"bg": "#ECFDF5", "primary": "#047857", "secondary": "#34D399"},    # أخضر حدائق
    "warm": {"bg": "#FFFBEB", "primary": "#B45309", "secondary": "#FBBF24"}       # كهرماني دافئ
}

def create_home_svg(path, theme, sym):
    p = PALETTES[theme]
    symbols = {
        "house": f'<polygon points="50,18 82,46 18,46" fill="{p["primary"]}"/><rect x="26" y="46" width="48" height="36" fill="{p["secondary"]}"/><rect x="42" y="58" width="16" height="24" fill="#FFF"/>',
        "door": f'<rect x="28" y="20" width="44" height="64" rx="4" fill="{p["primary"]}"/><circle cx="64" cy="52" r="4" fill="{p["secondary"]}"/>',
        "window": f'<rect x="24" y="24" width="52" height="52" rx="6" fill="{p["primary"]}"/><rect x="30" y="30" width="18" height="18" fill="#FFF"/><rect x="52" y="30" width="18" height="18" fill="#FFF"/><rect x="30" y="52" width="18" height="18" fill="#FFF"/><rect x="52" y="52" width="18" height="18" fill="#FFF"/>',
        "table": f'<rect x="18" y="40" width="64" height="10" rx="3" fill="{p["primary"]}"/><rect x="26" y="50" width="8" height="32" fill="{p["secondary"]}"/><rect x="66" y="50" width="8" height="32" fill="{p["secondary"]}"/>',
        "chair": f'<rect x="30" y="22" width="8" height="60" fill="{p["primary"]}"/><rect x="30" y="52" width="34" height="8" rx="2" fill="{p["primary"]}"/><rect x="56" y="52" width="8" height="30" fill="{p["secondary"]}"/>',
        "bed": f'<rect x="20" y="52" width="60" height="20" rx="4" fill="{p["primary"]}"/><rect x="16" y="42" width="10" height="38" fill="{p["secondary"]}"/><rect x="74" y="50" width="10" height="30" fill="{p["secondary"]}"/><rect x="28" y="44" width="18" height="8" rx="3" fill="#FFF"/>',
        "lamp": f'<polygon points="32,46 68,46 60,26 40,26" fill="{p["primary"]}"/><rect x="47" y="46" width="6" height="30" fill="{p["secondary"]}"/><rect x="36" y="76" width="28" height="6" rx="2" fill="{p["primary"]}"/>',
        "key": f'<circle cx="38" cy="42" r="14" stroke="{p["primary"]}" stroke-width="6" fill="none"/><rect x="48" y="39" width="30" height="6" fill="{p["primary"]}"/><rect x="68" y="45" width="6" height="8" fill="{p["primary"]}"/>',
        "stairs": f'<path d="M22 78 L38 78 L38 62 L54 62 L54 46 L70 46 L70 30 L80 30" stroke="{p["primary"]}" stroke-width="8" stroke-linecap="round" stroke-linejoin="round" fill="none"/>',
        "mirror": f'<ellipse cx="50" cy="50" rx="24" ry="32" fill="{p["secondary"]}" stroke="{p["primary"]}" stroke-width="6"/><ellipse cx="50" cy="50" rx="16" ry="24" fill="#FFF" opacity="0.6"/>'
    }
    content = symbols.get(sym, symbols["house"])
    svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%"><rect width="100" height="100" rx="24" fill="{p["bg"]}" />{content}</svg>'
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg)

HOME_MAP = [
    ("img_home_house", "structure", "house"), ("img_home_apartment", "structure", "house"),
    ("img_home_room", "comfort", "window"), ("img_home_door", "structure", "door"),
    ("img_home_window", "structure", "window"), ("img_home_table", "warm", "table"),
    ("img_home_chair", "warm", "chair"), ("img_home_bed", "comfort", "bed"),
    ("img_home_kitchen", "warm", "table"), ("img_home_bathroom", "structure", "window"),
    ("img_home_living_room", "comfort", "chair"), ("img_home_bedroom", "comfort", "bed"),
    ("img_home_sofa", "comfort", "chair"), ("img_home_lamp", "warm", "lamp"),
    ("img_home_wardrobe", "structure", "door"), ("img_home_fridge", "structure", "door"),
    ("img_home_balcony", "nature", "window"), ("img_home_key", "warm", "key"),
    ("img_home_wall", "structure", "window"), ("img_home_floor", "warm", "table"),
    ("img_home_roof", "structure", "house"), ("img_home_garden", "nature", "house"),
    ("img_home_stairs", "structure", "stairs"), ("img_home_mirror", "comfort", "mirror"),
    ("img_home_carpet", "warm", "table")
]

with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
    reg = json.load(f)

for img_id, theme, sym in HOME_MAP:
    path = f"content/assets/svg/{img_id}.svg"
    create_home_svg(path, theme, sym)
    reg["assets"][img_id] = {
        "asset_path": path,
        "format": "svg",
        "ownership": "Project Original",
        "license": "CC0-1.0",
        "size_bytes": os.path.getsize(path)
    }

with open("content/assets/images_registry.json", "w", encoding="utf-8") as f:
    json.dump(reg, f, ensure_ascii=False, indent=2)

print(f"Generated 25 home SVG assets. Total registry assets: {len(reg['assets'])}")
