import json, os

PALETTES = {
    "money": {"bg": "#FEF3C7", "primary": "#D97706", "secondary": "#FBBF24"},      # ذهبي نقود
    "store": {"bg": "#EFF6FF", "primary": "#2563EB", "secondary": "#60A5FA"},      # أزرق متاجر
    "sale": {"bg": "#FEF2F2", "primary": "#DC2626", "secondary": "#F87171"},       # أحمر تخفيضات
    "card": {"bg": "#F0FDF4", "primary": "#059669", "secondary": "#34D399"}        # أخضر بطاقات
}

def create_shop_svg(path, theme, sym):
    p = PALETTES[theme]
    symbols = {
        "cart": f'<circle cx="36" cy="74" r="6" fill="{p["primary"]}"/><circle cx="68" cy="74" r="6" fill="{p["primary"]}"/><path d="M20 26 H28 L40 60 H72 L82 34 H32" stroke="{p["primary"]}" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" fill="none"/>',
        "coin": f'<circle cx="50" cy="50" r="28" fill="{p["primary"]}" stroke="{p["secondary"]}" stroke-width="4"/><text x="50" y="62" font-size="30" font-family="sans-serif" font-weight="bold" fill="#FFF" text-anchor="middle">€</text>',
        "card": f'<rect x="20" y="32" width="60" height="38" rx="6" fill="{p["primary"]}"/><line x1="20" y1="42" x2="80" y2="42" stroke="#1E293B" stroke-width="6"/><rect x="28" y="56" width="14" height="6" rx="2" fill="#FFF"/>',
        "tag": f'<path d="M30 26 L56 26 L76 46 L50 72 L24 46 Z" fill="{p["primary"]}"/><circle cx="40" cy="36" r="4" fill="#FFF"/>',
        "bag": f'<rect x="26" y="36" width="48" height="46" rx="6" fill="{p["primary"]}"/><path d="M38 36 V24 C38 18 62 18 62 24 V36" stroke="{p["secondary"]}" stroke-width="5" fill="none"/>',
        "store": f'<polygon points="18,36 82,36 74,22 26,22" fill="{p["primary"]}"/><rect x="24" y="36" width="52" height="44" fill="{p["secondary"]}"/><rect x="42" y="54" width="16" height="26" fill="#FFF"/>'
    }
    content = symbols.get(sym, symbols["cart"])
    svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%"><rect width="100" height="100" rx="24" fill="{p["bg"]}" />{content}</svg>'
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg)

SHOP_MAP = [
    ("img_shop_bag", "store", "bag"), ("img_shop_cash", "money", "coin"),
    ("img_shop_price_tag", "sale", "tag"), ("img_shop_expensive", "sale", "tag"),
    ("img_shop_cheap", "card", "tag"), ("img_shop_card", "card", "card"),
    ("img_shop_receipt", "store", "tag"), ("img_shop_discount", "sale", "tag"),
    ("img_shop_cashier", "store", "card"), ("img_shop_cart", "store", "cart"),
    ("img_shop_basket", "store", "cart"), ("img_shop_store", "store", "store"),
    ("img_shop_bakery", "money", "store"), ("img_shop_butcher", "sale", "store"),
    ("img_shop_customer", "card", "bag"), ("img_shop_seller", "store", "card"),
    ("img_shop_size", "card", "tag"), ("img_shop_fitting", "store", "store"),
    ("img_shop_coin", "money", "coin")
]

with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
    reg = json.load(f)

for img_id, theme, sym in SHOP_MAP:
    path = f"content/assets/svg/{img_id}.svg"
    create_shop_svg(path, theme, sym)
    reg["assets"][img_id] = {
        "asset_path": path,
        "format": "svg",
        "ownership": "Project Original",
        "license": "CC0-1.0",
        "size_bytes": os.path.getsize(path)
    }

with open("content/assets/images_registry.json", "w", encoding="utf-8") as f:
    json.dump(reg, f, ensure_ascii=False, indent=2)

print(f"Generated shopping SVG assets. Total registry assets: {len(reg['assets'])}")
