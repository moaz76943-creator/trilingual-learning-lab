import json, os

PALETTES = {
    "drink": {"bg": "#E0F2FE", "primary": "#0284C7", "secondary": "#38BDF8"},     # أزرق سوائل
    "warm": {"bg": "#FEF3C7", "primary": "#B45309", "secondary": "#FBBF24"},      # كهرماني وخبز
    "fresh": {"bg": "#DCFCE7", "primary": "#15803D", "secondary": "#4ADE80"},     # أخضر خضار
    "fruit": {"bg": "#FEE2E2", "primary": "#DC2626", "secondary": "#F87171"},     # أحمر فواكه
    "dairy": {"bg": "#EDE9FE", "primary": "#6D28D9", "secondary": "#C4B5FD"}      # بنفسجي ألبان
}

def create_food_svg(path, theme, sym):
    p = PALETTES[theme]
    symbols = {
        "drink": f'<path d="M34 30 L66 30 L60 76 C59 80 55 84 50 84 C45 84 41 80 40 76 Z" fill="{p["primary"]}"/><path d="M38 44 Q50 48 62 44 L59 74 Q50 80 41 74 Z" fill="{p["secondary"]}" opacity="0.8"/>',
        "cup": f'<path d="M28 36 L72 36 L66 74 C65 78 61 82 56 82 L44 82 C39 82 35 78 34 74 Z" fill="{p["primary"]}"/><path d="M72 44 C78 44 82 50 82 56 C82 62 76 66 70 66" stroke="{p["primary"]}" stroke-width="5" fill="none"/>',
        "bread": f'<path d="M24 60 C24 40 40 32 50 32 C60 32 76 40 76 60 C76 72 70 76 50 76 C30 76 24 72 24 60 Z" fill="{p["primary"]}"/><line x1="38" y1="46" x2="44" y2="58" stroke="#FFF" stroke-width="3" stroke-linecap="round"/><line x1="56" y1="46" x2="62" y2="58" stroke="#FFF" stroke-width="3" stroke-linecap="round"/>',
        "apple": f'<circle cx="50" cy="56" r="24" fill="{p["primary"]}"/><path d="M50 32 Q54 22 62 20 Q58 30 50 32 Z" fill="#15803D"/>',
        "egg": f'<path d="M50 24 C38 24 30 42 30 58 C30 72 39 80 50 80 C61 80 70 72 70 58 C70 42 62 24 50 24 Z" fill="{p["primary"]}"/><circle cx="50" cy="58" r="10" fill="{p["secondary"]}"/>',
        "meat": f'<rect x="28" y="38" width="44" height="34" rx="10" fill="{p["primary"]}"/><circle cx="42" cy="55" r="5" fill="#FFF"/><circle cx="58" cy="55" r="5" fill="#FFF"/>',
        "fish": f'<path d="M22 50 C36 34 64 34 78 50 C64 66 36 66 22 50 Z" fill="{p["primary"]}"/><polygon points="76,50 88,38 88,62" fill="{p["primary"]}"/><circle cx="34" cy="48" r="3" fill="#FFF"/>',
        "plate": f'<ellipse cx="50" cy="55" rx="36" ry="22" fill="{p["secondary"]}"/><ellipse cx="50" cy="55" rx="26" ry="15" fill="{p["primary"]}"/>',
        "fruit_round": f'<circle cx="50" cy="54" r="24" fill="{p["primary"]}"/><circle cx="50" cy="54" r="16" fill="{p["secondary"]}" opacity="0.9"/>',
        "veg": f'<path d="M50 24 C36 40 38 66 50 78 C62 66 64 40 50 24 Z" fill="{p["primary"]}"/><path d="M46 22 L40 14 M50 20 L50 12 M54 22 L60 14" stroke="#15803D" stroke-width="3" stroke-linecap="round"/>'
    }
    content = symbols.get(sym, symbols["plate"])
    svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%"><rect width="100" height="100" rx="24" fill="{p["bg"]}" />{content}</svg>'
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg)

FOOD_MAP = [
    ("img_food_water", "drink", "drink"), ("img_food_bread", "warm", "bread"),
    ("img_food_milk", "dairy", "drink"), ("img_food_apple", "fruit", "apple"),
    ("img_food_tea", "warm", "cup"), ("img_food_coffee", "warm", "cup"),
    ("img_food_egg", "warm", "egg"), ("img_food_cheese", "warm", "plate"),
    ("img_food_meat", "fruit", "meat"), ("img_food_chicken", "warm", "meat"),
    ("img_food_fish", "drink", "fish"), ("img_food_rice", "warm", "plate"),
    ("img_food_soup", "warm", "cup"), ("img_food_salad", "fresh", "plate"),
    ("img_food_banana", "warm", "apple"), ("img_food_orange", "fruit", "fruit_round"),
    ("img_food_vegetables", "fresh", "veg"), ("img_food_sugar", "warm", "plate"),
    ("img_food_salt", "drink", "plate"), ("img_food_butter", "warm", "plate"),
    ("img_food_honey", "warm", "cup"), ("img_food_potato", "warm", "fruit_round"),
    ("img_food_tomato", "fruit", "fruit_round"), ("img_food_carrot", "fruit", "veg"),
    ("img_food_juice", "fruit", "drink")
]

with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
    reg = json.load(f)

for img_id, theme, sym in FOOD_MAP:
    path = f"content/assets/svg/{img_id}.svg"
    create_food_svg(path, theme, sym)
    reg["assets"][img_id] = {
        "asset_path": path,
        "format": "svg",
        "ownership": "Project Original",
        "license": "CC0-1.0",
        "size_bytes": os.path.getsize(path)
    }

with open("content/assets/images_registry.json", "w", encoding="utf-8") as f:
    json.dump(reg, f, ensure_ascii=False, indent=2)

print(f"Generated 25 food SVG assets and updated registry. Total assets: {len(reg['assets'])}")
