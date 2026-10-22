import json, os

COLOR_DEFS = {
    "img_col_red": ("#EF4444", "#DC2626"),
    "img_col_blue": ("#3B82F6", "#2563EB"),
    "img_col_green": ("#22C55E", "#16A34A"),
    "img_col_yellow": ("#EAB308", "#CA8A04"),
    "img_col_black": ("#1E293B", "#0F172A"),
    "img_col_white": ("#F8FAFC", "#CBD5E1"),
    "img_col_orange": ("#F97316", "#EA580C"),
    "img_col_brown": ("#854D0E", "#713F12"),
    "img_col_grey": ("#94A3B8", "#64748B"),
    "img_col_purple": ("#A855F7", "#9333EA"),
    "img_col_pink": ("#EC4899", "#DB2777"),
}

def create_color_svg(path, hex_val, hex_border):
    svg = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%">
  <rect width="100" height="100" rx="24" fill="{hex_val}" stroke="{hex_border}" stroke-width="4"/>
  <circle cx="50" cy="50" r="22" fill="#FFFFFF" opacity="0.25"/>
</svg>'''
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg.strip())

def create_number_svg(path, label):
    svg = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%">
  <rect width="100" height="100" rx="24" fill="#FEF3C7" stroke="#F59E0B" stroke-width="3"/>
  <text x="50" y="62" font-size="{32 if len(label) > 2 else 40}" font-family="sans-serif" font-weight="bold" fill="#B45309" text-anchor="middle">{label}</text>
</svg>'''
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg.strip())

with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
    reg = json.load(f)

for img_id, (c1, c2) in COLOR_DEFS.items():
    p = f"content/assets/svg/{img_id}.svg"
    create_color_svg(p, c1, c2)
    reg["assets"][img_id] = {"asset_path": p, "format": "svg", "ownership": "Project Original", "license": "CC0-1.0", "size_bytes": os.path.getsize(p)}

create_color_svg("content/assets/svg/img_col_palette.svg", "#6366F1", "#4F46E5")
reg["assets"]["img_col_palette"] = {"asset_path": "content/assets/svg/img_col_palette.svg", "format": "svg", "ownership": "Project Original", "license": "CC0-1.0", "size_bytes": os.path.getsize("content/assets/svg/img_col_palette.svg")}

NUM_MAP = [
    ("img_num_0", "0"), ("img_num_1", "1"), ("img_num_2", "2"), ("img_num_3", "3"),
    ("img_num_4", "4"), ("img_num_5", "5"), ("img_num_6", "6"), ("img_num_7", "7"),
    ("img_num_8", "8"), ("img_num_9", "9"), ("img_num_10", "10"), ("img_num_11", "11"),
    ("img_num_12", "12"), ("img_num_20", "20"), ("img_num_30", "30"), ("img_num_50", "50"),
    ("img_num_100", "100"), ("img_num_digits", "#")
]

for img_id, label in NUM_MAP:
    p = f"content/assets/svg/{img_id}.svg"
    create_number_svg(p, label)
    reg["assets"][img_id] = {"asset_path": p, "format": "svg", "ownership": "Project Original", "license": "CC0-1.0", "size_bytes": os.path.getsize(p)}

with open("content/assets/images_registry.json", "w", encoding="utf-8") as f:
    json.dump(reg, f, ensure_ascii=False, indent=2)

print(f"Generated 30 colors/numbers SVGs. Total registry assets: {len(reg['assets'])}")
