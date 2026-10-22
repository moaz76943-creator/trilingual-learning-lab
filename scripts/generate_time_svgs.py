import json, os

PALETTES = {
    "day": {"bg": "#EFF6FF", "primary": "#2563EB", "secondary": "#60A5FA"},       # أزرق أيقونات النهار
    "sun": {"bg": "#FEF3C7", "primary": "#D97706", "secondary": "#FBBF24"},       # شمس وصباح وظهر
    "night": {"bg": "#0F172A", "primary": "#6366F1", "secondary": "#C7D2FE"},     # ليل وظلام ونجوم
    "calendar": {"bg": "#ECFDF5", "primary": "#059669", "secondary": "#34D399"}   # تقويم وعطلة
}

def create_time_svg(path, theme, sym, text_label=""):
    p = PALETTES[theme]
    symbols = {
        "clock": f'<circle cx="50" cy="50" r="32" stroke="{p["primary"]}" stroke-width="6" fill="#FFF"/><line x1="50" y1="50" x2="50" y2="30" stroke="{p["primary"]}" stroke-width="5" stroke-linecap="round"/><line x1="50" y1="50" x2="66" y2="50" stroke="{p["primary"]}" stroke-width="4" stroke-linecap="round"/><circle cx="50" cy="50" r="4" fill="{p["secondary"]}"/>',
        "calendar": f'<rect x="22" y="26" width="56" height="52" rx="10" fill="{p["primary"]}"/><rect x="22" y="26" width="56" height="18" fill="{p["secondary"]}"/><circle cx="34" cy="20" r="3" fill="#FFF"/><circle cx="66" cy="20" r="3" fill="#FFF"/><text x="50" y="66" font-size="20" font-family="sans-serif" font-weight="bold" fill="#FFF" text-anchor="middle">{text_label or "7"}</text>',
        "sun": f'<circle cx="50" cy="50" r="18" fill="{p["primary"]}"/><path d="M50 18 V26 M50 74 V82 M18 50 H26 M74 50 H82 M28 28 L34 34 M66 66 L72 72 M28 72 L34 66 M66 34 L72 28" stroke="{p["primary"]}" stroke-width="5" stroke-linecap="round"/>',
        "moon": f'<path d="M60 26 C42 26 32 40 34 56 C36 68 46 76 60 76 C52 70 48 60 50 48 C52 38 60 30 60 26 Z" fill="{p["secondary"]}"/><circle cx="66" cy="38" r="3" fill="#FFF"/><circle cx="74" cy="54" r="2" fill="#FFF"/>',
        "hourglass": f'<path d="M30 26 H70 L54 48 L70 74 H30 L46 48 Z" fill="{p["primary"]}" stroke="{p["secondary"]}" stroke-width="4" stroke-linejoin="round"/>'
    }
    content = symbols.get(sym, symbols["clock"])
    svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%"><rect width="100" height="100" rx="24" fill="{p["bg"]}" />{content}</svg>'
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg)

TIME_MAP = [
    ("img_time_monday", "calendar", "calendar", "Mo"),
    ("img_time_tuesday", "calendar", "calendar", "Di"),
    ("img_time_wednesday", "calendar", "calendar", "Mi"),
    ("img_time_thursday", "calendar", "calendar", "Do"),
    ("img_time_friday", "calendar", "calendar", "Fr"),
    ("img_time_saturday", "calendar", "calendar", "Sa"),
    ("img_time_sunday", "calendar", "calendar", "So"),
    ("img_time_day", "sun", "sun", ""),
    ("img_time_week", "calendar", "calendar", "7D"),
    ("img_time_month", "calendar", "calendar", "30D"),
    ("img_time_year", "calendar", "calendar", "365"),
    ("img_time_today", "sun", "clock", ""),
    ("img_time_tomorrow", "day", "clock", ""),
    ("img_time_yesterday", "day", "hourglass", ""),
    ("img_time_morning", "sun", "sun", ""),
    ("img_time_noon", "sun", "sun", ""),
    ("img_time_afternoon", "sun", "sun", ""),
    ("img_time_evening", "night", "moon", ""),
    ("img_time_night", "night", "moon", ""),
    ("img_time_hour", "day", "clock", ""),
    ("img_time_minute", "day", "clock", ""),
    ("img_time_second", "day", "clock", ""),
    ("img_time_clock", "day", "clock", ""),
    ("img_time_weekend", "calendar", "calendar", "W-E"),
    ("img_time_calendar", "calendar", "calendar", "CAL")
]

with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
    reg = json.load(f)

for img_id, theme, sym, txt in TIME_MAP:
    path = f"content/assets/svg/{img_id}.svg"
    create_time_svg(path, theme, sym, txt)
    reg["assets"][img_id] = {
        "asset_path": path,
        "format": "svg",
        "ownership": "Project Original",
        "license": "CC0-1.0",
        "size_bytes": os.path.getsize(path)
    }

with open("content/assets/images_registry.json", "w", encoding="utf-8") as f:
    json.dump(reg, f, ensure_ascii=False, indent=2)

print(f"Generated 25 time/calendar SVG assets. Total registry assets: {len(reg['assets'])}")
