import json, os

PALETTES = {
    "wechsel": {"bg": "#EFF6FF", "box": "#3B82F6", "ball": "#EF4444"},  # أزرق وأحمر للثنائي
    "dativ": {"bg": "#F0FDF4", "box": "#10B981", "ball": "#047857"},    # درجات الأخضر للداتيف
    "akkusativ": {"bg": "#FFF7ED", "box": "#F97316", "ball": "#C2410C"} # برتقالي للأكوزاتيف
}

def create_prep_svg(path, theme, sym):
    p = PALETTES[theme]
    symbols = {
        "in": f'<rect x="25" y="35" width="50" height="45" rx="6" stroke="{p["box"]}" stroke-width="4" fill="none"/><circle cx="50" cy="57" r="10" fill="{p["ball"]}"/>',
        "auf": f'<rect x="25" y="55" width="50" height="25" rx="4" fill="{p["box"]}"/><circle cx="50" cy="40" r="10" fill="{p["ball"]}"/>',
        "unter": f'<rect x="25" y="30" width="50" height="20" rx="4" fill="{p["box"]}"/><circle cx="50" cy="65" r="10" fill="{p["ball"]}"/>',
        "hinter": f'<circle cx="58" cy="42" r="12" fill="{p["ball"]}"/><rect x="25" y="45" width="45" height="35" rx="4" fill="{p["box"]}"/>',
        "vor": f'<rect x="35" y="35" width="45" height="35" rx="4" fill="{p["box"]}"/><circle cx="35" cy="65" r="12" fill="{p["ball"]}"/>',
        "neben": f'<rect x="20" y="40" width="30" height="35" rx="4" fill="{p["box"]}"/><circle cx="70" cy="57" r="11" fill="{p["ball"]}"/>',
        "zwischen": f'<rect x="16" y="40" width="22" height="35" rx="3" fill="{p["box"]}"/><rect x="62" y="40" width="22" height="35" rx="3" fill="{p["box"]}"/><circle cx="50" cy="57" r="9" fill="{p["ball"]}"/>',
        "ueber": f'<rect x="25" y="60" width="50" height="20" rx="4" fill="{p["box"]}"/><circle cx="50" cy="35" r="10" fill="{p["ball"]}"/>',
        "an": f'<rect x="25" y="25" width="16" height="55" rx="3" fill="{p["box"]}"/><circle cx="52" cy="52" r="11" fill="{p["ball"]}"/>',
        "arrow": f'<circle cx="30" cy="50" r="10" fill="{p["box"]}"/><path d="M48 50 H75 M65 40 L75 50 L65 60" stroke="{p["ball"]}" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>',
        "circle": f'<circle cx="50" cy="50" r="24" stroke="{p["box"]}" stroke-width="6" fill="none"/><circle cx="50" cy="26" r="6" fill="{p["ball"]}"/>'
    }
    content = symbols.get(sym, symbols["in"])
    svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%"><rect width="100" height="100" rx="24" fill="{p["bg"]}" />{content}</svg>'
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg)

PREP_MAP = [
    ("img_prep_in", "wechsel", "in"), ("img_prep_auf", "wechsel", "auf"),
    ("img_prep_unter", "wechsel", "unter"), ("img_prep_hinter", "wechsel", "hinter"),
    ("img_prep_vor", "wechsel", "vor"), ("img_prep_neben", "wechsel", "neben"),
    ("img_prep_zwischen", "wechsel", "zwischen"), ("img_prep_ueber", "wechsel", "ueber"),
    ("img_prep_an", "wechsel", "an"), ("img_prep_mit", "dativ", "arrow"),
    ("img_prep_nach", "dativ", "arrow"), ("img_prep_zu", "dativ", "arrow"),
    ("img_prep_aus", "dativ", "arrow"), ("img_prep_von", "dativ", "arrow"),
    ("img_prep_bei", "dativ", "neben"), ("img_prep_fuer", "akkusativ", "arrow"),
    ("img_prep_ohne", "akkusativ", "neben"), ("img_prep_durch", "akkusativ", "in"),
    ("img_prep_um", "akkusativ", "circle"), ("img_prep_bis", "akkusativ", "arrow")
]

with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
    reg = json.load(f)

for img_id, theme, sym in PREP_MAP:
    path = f"content/assets/svg/{img_id}.svg"
    create_prep_svg(path, theme, sym)
    reg["assets"][img_id] = {
        "asset_path": path,
        "format": "svg",
        "ownership": "Project Original",
        "license": "CC0-1.0",
        "size_bytes": os.path.getsize(path)
    }

with open("content/assets/images_registry.json", "w", encoding="utf-8") as f:
    json.dump(reg, f, ensure_ascii=False, indent=2)

print(f"Generated 20 preposition SVG assets. Total registry assets: {len(reg['assets'])}")
