import json, os

PALETTES = {
    "vehicle": {"bg": "#E0F2FE", "primary": "#0369A1", "secondary": "#38BDF8"},   # أزرق مركبات
    "urban": {"bg": "#F8FAFC", "primary": "#334155", "secondary": "#64748B"},     # رمادي مباني وشوارع
    "traffic": {"bg": "#FEF3C7", "primary": "#D97706", "secondary": "#FBBF24"},   # إشارات ومحطات
    "green": {"bg": "#ECFDF5", "primary": "#059669", "secondary": "#34D399"}      # متنزهات ومكتبات
}

def create_city_svg(path, theme, sym):
    p = PALETTES[theme]
    symbols = {
        "car": f'<rect x="20" y="44" width="60" height="24" rx="6" fill="{p["primary"]}"/><path d="M28 44 L36 30 L64 30 L72 44 Z" fill="{p["secondary"]}"/><circle cx="32" cy="68" r="8" fill="#1E293B"/><circle cx="68" cy="68" r="8" fill="#1E293B"/>',
        "bus": f'<rect x="22" y="24" width="56" height="46" rx="8" fill="{p["primary"]}"/><rect x="28" y="30" width="18" height="16" rx="3" fill="#FFF"/><rect x="54" y="30" width="18" height="16" rx="3" fill="#FFF"/><circle cx="34" cy="70" r="6" fill="#1E293B"/><circle cx="66" cy="70" r="6" fill="#1E293B"/>',
        "train": f'<rect x="26" y="22" width="48" height="52" rx="12" fill="{p["primary"]}"/><rect x="32" y="30" width="36" height="20" rx="4" fill="#FFF"/><circle cx="36" cy="62" r="4" fill="{p["secondary"]}"/><circle cx="64" cy="62" r="4" fill="{p["secondary"]}"/>',
        "plane": f'<path d="M50 18 L56 38 L84 52 L84 60 L56 54 L56 72 L66 80 L66 84 L50 80 L34 84 L34 80 L44 72 L44 54 L16 60 L16 52 L44 38 Z" fill="{p["primary"]}"/>',
        "building": f'<rect x="24" y="24" width="52" height="56" rx="4" fill="{p["primary"]}"/><rect x="32" y="32" width="10" height="12" fill="#FFF"/><rect x="58" y="32" width="10" height="12" fill="#FFF"/><rect x="32" y="52" width="10" height="12" fill="#FFF"/><rect x="58" y="52" width="10" height="12" fill="#FFF"/>',
        "signal": f'<rect x="38" y="20" width="24" height="60" rx="8" fill="#1E293B"/><circle cx="50" cy="32" r="6" fill="#EF4444"/><circle cx="50" cy="50" r="6" fill="#F59E0B"/><circle cx="50" cy="68" r="6" fill="#10B981"/>',
        "ticket": f'<rect x="20" y="34" width="60" height="32" rx="6" fill="{p["primary"]}" stroke="{p["secondary"]}" stroke-width="3"/><line x1="40" y1="34" x2="40" y2="66" stroke="#FFF" stroke-dasharray="4"/>'
    }
    content = symbols.get(sym, symbols["building"])
    svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%"><rect width="100" height="100" rx="24" fill="{p["bg"]}" />{content}</svg>'
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg)

CITY_MAP = [
    ("img_city_city", "urban", "building"), ("img_city_street", "urban", "car"),
    ("img_city_car", "vehicle", "car"), ("img_city_bus", "vehicle", "bus"),
    ("img_city_train", "vehicle", "train"), ("img_city_subway", "vehicle", "train"),
    ("img_city_bicycle", "vehicle", "car"), ("img_city_airplane", "vehicle", "plane"),
    ("img_city_airport", "vehicle", "plane"), ("img_city_station", "traffic", "train"),
    ("img_city_ticket", "traffic", "ticket"), ("img_city_taxi", "traffic", "car"),
    ("img_city_hotel", "urban", "building"), ("img_city_bank", "urban", "building"),
    ("img_city_post_office", "traffic", "building"), ("img_city_market", "traffic", "building"),
    ("img_city_supermarket", "traffic", "building"), ("img_city_park", "green", "building"),
    ("img_city_bridge", "urban", "car"), ("img_city_traffic_light", "traffic", "signal"),
    ("img_city_crossroad", "urban", "car"), ("img_city_parking", "traffic", "car"),
    ("img_city_museum", "green", "building"), ("img_city_school", "green", "building"),
    ("img_city_library", "green", "building")
]

with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
    reg = json.load(f)

for img_id, theme, sym in CITY_MAP:
    path = f"content/assets/svg/{img_id}.svg"
    create_city_svg(path, theme, sym)
    reg["assets"][img_id] = {
        "asset_path": path,
        "format": "svg",
        "ownership": "Project Original",
        "license": "CC0-1.0",
        "size_bytes": os.path.getsize(path)
    }

with open("content/assets/images_registry.json", "w", encoding="utf-8") as f:
    json.dump(reg, f, ensure_ascii=False, indent=2)

print(f"Generated 25 city/transport SVG assets. Total registry assets: {len(reg['assets'])}")
