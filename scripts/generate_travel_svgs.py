import json, os

PALETTES = {
    "vacation": {"bg": "#E0F2FE", "primary": "#0284C7", "secondary": "#38BDF8"},  # أزرق سياحي
    "hotel": {"bg": "#F0FDFA", "primary": "#0D9488", "secondary": "#2DD4BF"},     # تركوازي فندقي
    "docs": {"bg": "#FEF3C7", "primary": "#D97706", "secondary": "#FBBF24"},      # كهرماني وثائق
    "leisure": {"bg": "#FDF4FF", "primary": "#C026D3", "secondary": "#E879F9"}    # بنفسجي ترفيهي
}

def create_travel_svg(path, theme, sym):
    p = PALETTES[theme]
    symbols = {
        "passport": f'<rect x="28" y="22" width="44" height="56" rx="6" fill="{p["primary"]}"/><circle cx="50" cy="46" r="12" stroke="#FFF" stroke-width="3" fill="none"/><line x1="36" y1="64" x2="64" y2="64" stroke="#FFF" stroke-width="3"/>',
        "suitcase": f'<rect x="24" y="32" width="52" height="46" rx="8" fill="{p["primary"]}"/><path d="M38 32 V24 C38 20 62 20 62 24 V32" stroke="{p["secondary"]}" stroke-width="4" fill="none"/><line x1="38" y1="32" x2="38" y2="78" stroke="{p["secondary"]}" stroke-width="3"/><line x1="62" y1="32" x2="62" y2="78" stroke="{p["secondary"]}" stroke-width="3"/>',
        "hotel": f'<rect x="26" y="24" width="48" height="56" rx="4" fill="{p["primary"]}"/><text x="50" y="46" font-size="20" font-family="sans-serif" font-weight="bold" fill="#FFF" text-anchor="middle">H</text><rect x="42" y="58" width="16" height="22" fill="#FFF"/>',
        "ticket": f'<rect x="20" y="34" width="60" height="32" rx="6" fill="{p["primary"]}" stroke="{p["secondary"]}" stroke-width="3"/><circle cx="20" cy="50" r="4" fill="{p["bg"]}"/><circle cx="80" cy="50" r="4" fill="{p["bg"]}"/>',
        "beach": f'<circle cx="34" cy="34" r="14" fill="#F59E0B"/><path d="M16 68 Q36 58 56 68 T96 68 L96 82 L16 82 Z" fill="{p["primary"]}"/><path d="M46 68 Q66 58 86 68 L86 82 L46 82 Z" fill="{p["secondary"]}" opacity="0.8"/>',
        "camera": f'<rect x="22" y="34" width="56" height="42" rx="8" fill="{p["primary"]}"/><polygon points="36,34 42,26 58,26 64,34" fill="{p["secondary"]}"/><circle cx="50" cy="55" r="14" fill="#FFF"/><circle cx="50" cy="55" r="8" fill="{p["primary"]}"/>',
        "globe": f'<circle cx="50" cy="50" r="26" stroke="{p["primary"]}" stroke-width="5" fill="none"/><ellipse cx="50" cy="50" rx="14" ry="26" stroke="{p["secondary"]}" stroke-width="4" fill="none"/><line x1="24" y1="50" x2="76" y2="50" stroke="{p["primary"]}" stroke-width="4"/>'
    }
    content = symbols.get(sym, symbols["suitcase"])
    svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%"><rect width="100" height="100" rx="24" fill="{p["bg"]}" />{content}</svg>'
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg)

TRAVEL_MAP = [
    ("img_travel_globe", "vacation", "globe"), ("img_travel_palm", "vacation", "beach"),
    ("img_travel_passport", "docs", "passport"), ("img_travel_visa", "docs", "ticket"),
    ("img_travel_luggage", "vacation", "suitcase"), ("img_travel_suitcase", "vacation", "suitcase"),
    ("img_travel_flight", "vacation", "globe"), ("img_travel_boarding", "docs", "ticket"),
    ("img_travel_reception", "hotel", "hotel"), ("img_travel_booking", "hotel", "ticket"),
    ("img_travel_single_room", "hotel", "hotel"), ("img_travel_double_room", "hotel", "hotel"),
    ("img_travel_keycard", "hotel", "ticket"), ("img_travel_tourist", "vacation", "camera"),
    ("img_travel_guide", "vacation", "globe"), ("img_travel_map", "docs", "ticket"),
    ("img_travel_beach", "vacation", "beach"), ("img_travel_island", "vacation", "beach"),
    ("img_travel_border", "docs", "passport"), ("img_travel_exchange", "docs", "ticket"),
    ("img_travel_souvenir", "leisure", "camera"), ("img_travel_camera", "leisure", "camera"),
    ("img_travel_restaurant", "hotel", "hotel"), ("img_travel_bill", "docs", "ticket"),
    ("img_travel_trip", "vacation", "globe")
]

with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
    reg = json.load(f)

for img_id, theme, sym in TRAVEL_MAP:
    path = f"content/assets/svg/{img_id}.svg"
    create_travel_svg(path, theme, sym)
    reg["assets"][img_id] = {
        "asset_path": path,
        "format": "svg",
        "ownership": "Project Original",
        "license": "CC0-1.0",
        "size_bytes": os.path.getsize(path)
    }

with open("content/assets/images_registry.json", "w", encoding="utf-8") as f:
    json.dump(reg, f, ensure_ascii=False, indent=2)

print(f"Generated 25 travel/hotel SVG assets. Total registry assets: {len(reg['assets'])}")
