import json, os

PALETTES = {
    "body": {"bg": "#F0FDF4", "primary": "#16A34A", "secondary": "#4ADE80"},       # أخضر حيوي
    "medical": {"bg": "#EFF6FF", "primary": "#2563EB", "secondary": "#60A5FA"},    # أزرق طبي
    "alert": {"bg": "#FEF2F2", "primary": "#DC2626", "secondary": "#F87171"},      # أحمر ألم وحمى
    "care": {"bg": "#FAF5FF", "primary": "#9333EA", "secondary": "#C084FC"}        # بنفسجي عناية
}

def create_body_svg(path, theme, sym):
    p = PALETTES[theme]
    symbols = {
        "heart": f'<path d="M50 32 C38 18 18 26 18 44 C18 64 50 82 50 82 C50 82 82 64 82 44 C82 26 62 18 50 32 Z" fill="{p["primary"]}"/>',
        "head": f'<circle cx="50" cy="46" r="24" fill="{p["primary"]}"/><path d="M26 82 C26 66 38 62 50 62 C62 62 74 66 74 82 Z" fill="{p["secondary"]}"/>',
        "eye": f'<path d="M18 50 Q50 24 82 50 Q50 76 18 50 Z" fill="{p["primary"]}"/><circle cx="50" cy="50" r="12" fill="#FFF"/><circle cx="50" cy="50" r="6" fill="{p["secondary"]}"/>',
        "ear": f'<path d="M42 24 C28 24 22 36 22 50 C22 68 34 76 46 76 C54 76 60 70 60 62 C60 54 52 50 44 50" stroke="{p["primary"]}" stroke-width="6" stroke-linecap="round" fill="none"/>',
        "hand": f'<path d="M34 50 V34 C34 30 40 30 40 34 V48 M40 34 V28 C40 24 46 24 46 28 V48 M46 30 V26 C46 22 52 22 52 26 V48 M52 34 V30 C52 26 58 26 58 30 V58 C58 72 48 80 38 80 L30 72 L38 58" stroke="{p["primary"]}" stroke-width="5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>',
        "cross": f'<rect x="42" y="22" width="16" height="56" rx="4" fill="{p["primary"]}"/><rect x="22" y="42" width="56" height="16" rx="4" fill="{p["primary"]}"/>',
        "pill": f'<rect x="26" y="42" width="48" height="20" rx="10" transform="rotate(-30 50 52)" fill="{p["primary"]}"/><circle cx="42" cy="47" r="4" fill="#FFF"/>',
        "thermometer": f'<rect x="44" y="20" width="12" height="46" rx="6" fill="{p["secondary"]}"/><circle cx="50" cy="70" r="14" fill="{p["primary"]}"/><rect x="47" y="32" width="6" height="34" fill="{p["primary"]}"/>',
        "tooth": f'<path d="M34 26 C26 26 24 40 28 54 L32 78 C34 82 40 82 42 78 L46 62 L54 62 L58 78 C60 82 66 82 68 78 L72 54 C76 40 74 26 66 26 C58 26 54 32 50 32 C46 32 42 26 34 26 Z" fill="{p["primary"]}"/>'
    }
    content = symbols.get(sym, symbols["head"])
    svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%"><rect width="100" height="100" rx="24" fill="{p["bg"]}" />{content}</svg>'
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg)

BODY_MAP = [
    ("img_body_body", "body", "head"), ("img_body_head", "body", "head"),
    ("img_body_eye", "body", "eye"), ("img_body_ear", "body", "ear"),
    ("img_body_nose", "body", "head"), ("img_body_mouth", "body", "head"),
    ("img_body_tooth", "body", "tooth"), ("img_body_hand", "body", "hand"),
    ("img_body_finger", "body", "hand"), ("img_body_arm", "body", "hand"),
    ("img_body_foot", "body", "hand"), ("img_body_leg", "body", "hand"),
    ("img_body_stomach", "body", "heart"), ("img_body_back", "body", "head"),
    ("img_body_heart", "alert", "heart"), ("img_body_hair", "care", "head"),
    ("img_body_doctor", "medical", "cross"), ("img_body_hospital", "medical", "cross"),
    ("img_body_medicine", "medical", "pill"), ("img_body_pharmacy", "medical", "cross"),
    ("img_body_health", "body", "heart"), ("img_body_pain", "alert", "heart"),
    ("img_body_fever", "alert", "thermometer"), ("img_body_sick", "alert", "thermometer"),
    ("img_body_healthy", "body", "heart")
]

with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
    reg = json.load(f)

for img_id, theme, sym in BODY_MAP:
    path = f"content/assets/svg/{img_id}.svg"
    create_body_svg(path, theme, sym)
    reg["assets"][img_id] = {
        "asset_path": path,
        "format": "svg",
        "ownership": "Project Original",
        "license": "CC0-1.0",
        "size_bytes": os.path.getsize(path)
    }

with open("content/assets/images_registry.json", "w", encoding="utf-8") as f:
    json.dump(reg, f, ensure_ascii=False, indent=2)

print(f"Generated 25 body SVG assets. Total registry assets: {len(reg['assets'])}")
