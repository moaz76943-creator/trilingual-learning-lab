import json, os

PALETTES = {
    "sun": {"bg": "#FEF3C7", "primary": "#D97706", "secondary": "#FBBF24"},
    "nature": {"bg": "#ECFDF5", "primary": "#059669", "secondary": "#34D399"},
    "water": {"bg": "#E0F2FE", "primary": "#0284C7", "secondary": "#38BDF8"},
    "earth": {"bg": "#F5F3FF", "primary": "#7C3AED", "secondary": "#A78BFA"},
    "animal": {"bg": "#FFFBEB", "primary": "#B45309", "secondary": "#F59E0B"}
}

def create_nature_svg(path, theme, sym):
    p = PALETTES[theme]
    symbols = {
        "sun": f'<circle cx="50" cy="50" r="22" fill="{p["primary"]}"/><path d="M50 16 V24 M50 76 V84 M16 50 H24 M76 50 H84" stroke="{p["primary"]}" stroke-width="6" stroke-linecap="round"/>',
        "moon": f'<path d="M60 26 C42 26 32 40 34 56 C36 68 46 76 60 76 C52 70 48 60 50 48 C52 38 60 30 60 26 Z" fill="{p["primary"]}"/>',
        "tree": f'<rect x="46" y="54" width="8" height="30" fill="#78350F"/><circle cx="50" cy="40" r="24" fill="{p["primary"]}"/><circle cx="36" cy="44" r="14" fill="{p["secondary"]}" opacity="0.8"/>',
        "flower": f'<circle cx="50" cy="50" r="10" fill="#F59E0B"/><circle cx="50" cy="32" r="10" fill="{p["primary"]}"/><circle cx="50" cy="68" r="10" fill="{p["primary"]}"/><circle cx="32" cy="50" r="10" fill="{p["primary"]}"/><circle cx="68" cy="50" r="10" fill="{p["primary"]}"/>',
        "mountain": f'<polygon points="46,24 76,76 16,76" fill="{p["primary"]}"/><polygon points="68,44 88,76 48,76" fill="{p["secondary"]}" opacity="0.8"/>',
        "water": f'<path d="M18 50 Q34 38 50 50 T82 50 T18 64 Q34 52 50 64 T82 64" fill="{p["primary"]}"/>',
        "rain": f'<path d="M30 40 C30 30 44 26 52 32 C60 28 72 32 72 42 C76 44 78 50 76 54 C72 58 30 58 26 52 C24 46 28 42 30 40 Z" fill="{p["primary"]}"/><line x1="36" y1="66" x2="32" y2="76" stroke="{p["secondary"]}" stroke-width="4" stroke-linecap="round"/><line x1="52" y1="66" x2="48" y2="76" stroke="{p["secondary"]}" stroke-width="4" stroke-linecap="round"/><line x1="68" y1="66" x2="64" y2="76" stroke="{p["secondary"]}" stroke-width="4" stroke-linecap="round"/>',
        "animal": f'<circle cx="50" cy="48" r="22" fill="{p["primary"]}"/><circle cx="36" cy="30" r="8" fill="{p["primary"]}"/><circle cx="64" cy="30" r="8" fill="{p["primary"]}"/><circle cx="44" cy="44" r="3" fill="#FFF"/><circle cx="56" cy="44" r="3" fill="#FFF"/><ellipse cx="50" cy="54" rx="6" ry="4" fill="{p["secondary"]}"/>',
        "paw": f'<circle cx="50" cy="58" r="14" fill="{p["primary"]}"/><circle cx="34" cy="40" r="6" fill="{p["secondary"]}"/><circle cx="45" cy="32" r="6" fill="{p["secondary"]}"/><circle cx="55" cy="32" r="6" fill="{p["secondary"]}"/><circle cx="66" cy="40" r="6" fill="{p["secondary"]}"/>'
    }
    content = symbols.get(sym, symbols["animal"])
    svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%"><rect width="100" height="100" rx="24" fill="{p["bg"]}" />{content}</svg>'
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg)

NAT_MAP = [
    ("img_nat_sun", "sun", "sun"), ("img_nat_moon", "earth", "moon"),
    ("img_nat_star", "sun", "sun"), ("img_nat_sky", "water", "sun"),
    ("img_nat_tree", "nature", "tree"), ("img_nat_flower", "nature", "flower"),
    ("img_nat_sea", "water", "water"), ("img_nat_river", "water", "water"),
    ("img_nat_mountain", "nature", "mountain"), ("img_nat_rain", "water", "rain"),
    ("img_nat_snow", "water", "rain"), ("img_nat_wind", "water", "water"),
    ("img_nat_weather", "sun", "sun"), ("img_nat_dog", "animal", "animal"),
    ("img_nat_cat", "animal", "animal"), ("img_nat_bird", "nature", "animal"),
    ("img_nat_horse", "animal", "animal"), ("img_nat_cow", "animal", "animal"),
    ("img_nat_sheep", "nature", "animal"), ("img_nat_fish", "water", "water"),
    ("img_nat_lion", "animal", "animal"), ("img_nat_mouse", "animal", "animal"),
    ("img_nat_rabbit", "animal", "animal"), ("img_nat_duck", "water", "animal"),
    ("img_nat_animal", "animal", "paw")
]

with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
    reg = json.load(f)

for img_id, theme, sym in NAT_MAP:
    path = f"content/assets/svg/{img_id}.svg"
    create_nature_svg(path, theme, sym)
    reg["assets"][img_id] = {
        "asset_path": path,
        "format": "svg",
        "ownership": "Project Original",
        "license": "CC0-1.0",
        "size_bytes": os.path.getsize(path)
    }

with open("content/assets/images_registry.json", "w", encoding="utf-8") as f:
    json.dump(reg, f, ensure_ascii=False, indent=2)

print(f"Generated 25 nature/animals SVG assets. Total registry assets: {len(reg['assets'])}")
