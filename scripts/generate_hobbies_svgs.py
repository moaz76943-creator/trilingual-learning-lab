import json, os

PALETTES = {
    "sports": {"bg": "#FEF2F2", "primary": "#DC2626", "secondary": "#F87171"},     # أحمر رياضة وحماس
    "music": {"bg": "#F5F3FF", "primary": "#7C3AED", "secondary": "#A78BFA"},      # بنفسجي فنون وموسيقى
    "outdoor": {"bg": "#ECFDF5", "primary": "#059669", "secondary": "#34D399"},    # أخضر طبيعة وخلاء
    "game": {"bg": "#EFF6FF", "primary": "#2563EB", "secondary": "#60A5FA"}        # أزرق تقنية وألعاب
}

def create_hobby_svg(path, theme, sym):
    p = PALETTES[theme]
    symbols = {
        "ball": f'<circle cx="50" cy="50" r="28" fill="{p["primary"]}"/><path d="M50 22 L58 40 L78 40 L62 52 L68 70 L50 60 L32 70 L38 52 L22 40 L42 40 Z" fill="#FFF"/>',
        "music": f'<circle cx="36" cy="66" r="10" fill="{p["primary"]}"/><circle cx="64" cy="56" r="10" fill="{p["primary"]}"/><path d="M46 66 V30 L74 20 V56" stroke="{p["primary"]}" stroke-width="5" fill="none"/><line x1="46" y1="36" x2="74" y2="26" stroke="{p["secondary"]}" stroke-width="6"/>',
        "medal": f'<circle cx="50" cy="60" r="18" fill="{p["primary"]}"/><polygon points="34,22 50,44 42,44 26,22" fill="{p["secondary"]}"/><polygon points="66,22 50,44 58,44 74,22" fill="{p["secondary"]}"/><circle cx="50" cy="60" r="10" fill="#FFF"/>',
        "gamepad": f'<rect x="22" y="34" width="56" height="34" rx="10" fill="{p["primary"]}"/><line x1="34" y1="45" x2="34" y2="57" stroke="#FFF" stroke-width="4"/><line x1="28" y1="51" x2="40" y2="51" stroke="#FFF" stroke-width="4"/><circle cx="62" cy="46" r="3" fill="#FFF"/><circle cx="70" cy="54" r="3" fill="#FFF"/>',
        "art": f'<path d="M24 60 C24 35 45 25 60 25 C75 25 80 40 76 60 C72 75 55 80 38 80 C28 80 24 72 24 60 Z" fill="{p["primary"]}"/><circle cx="40" cy="40" r="5" fill="#FFF"/><circle cx="58" cy="38" r="5" fill="{p["secondary"]}"/><circle cx="66" cy="52" r="5" fill="#FBBF24"/>',
        "nature": f'<path d="M26 78 L50 36 L74 78 Z" fill="{p["primary"]}"/><path d="M42 78 L60 48 L78 78 Z" fill="{p["secondary"]}" opacity="0.8"/>'
    }
    content = symbols.get(sym, symbols["ball"])
    svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%"><rect width="100" height="100" rx="24" fill="{p["bg"]}" />{content}</svg>'
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg)

HOB_MAP = [
    ("img_hob_palette", "art", "art"), ("img_hob_medal", "sports", "medal"),
    ("img_hob_football", "sports", "ball"), ("img_hob_swimming", "sports", "nature"),
    ("img_hob_book", "music", "art"), ("img_hob_music", "music", "music"),
    ("img_hob_drawing", "art", "art"), ("img_hob_camera", "game", "gamepad"),
    ("img_hob_cooking", "sports", "art"), ("img_hob_running", "sports", "medal"),
    ("img_hob_cycling", "sports", "medal"), ("img_hob_gamepad", "game", "gamepad"),
    ("img_hob_cinema", "music", "art"), ("img_hob_theatre", "music", "art"),
    ("img_hob_guitar", "music", "music"), ("img_hob_piano", "music", "music"),
    ("img_hob_dance", "music", "art"), ("img_hob_basketball", "sports", "ball"),
    ("img_hob_tennis", "sports", "ball"), ("img_hob_gardening", "outdoor", "nature"),
    ("img_hob_fishing", "outdoor", "nature"), ("img_hob_hiking", "outdoor", "nature"),
    ("img_hob_ball", "sports", "ball"), ("img_hob_club", "sports", "medal"),
    ("img_hob_clock", "game", "medal")
]

with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
    reg = json.load(f)

for img_id, theme, sym in HOB_MAP:
    path = f"content/assets/svg/{img_id}.svg"
    create_hobby_svg(path, theme, sym)
    reg["assets"][img_id] = {
        "asset_path": path,
        "format": "svg",
        "ownership": "Project Original",
        "license": "CC0-1.0",
        "size_bytes": os.path.getsize(path)
    }

with open("content/assets/images_registry.json", "w", encoding="utf-8") as f:
    json.dump(reg, f, ensure_ascii=False, indent=2)

print(f"Generated 25 hobbies SVG assets. Total registry assets: {len(reg['assets'])}")
