import json, os

PALETTES = {
    "meeting": {"bg": "#EFF6FF", "primary": "#2563EB", "secondary": "#60A5FA"},
    "cafe": {"bg": "#FEF3C7", "primary": "#D97706", "secondary": "#FBBF24"},
    "market": {"bg": "#ECFDF5", "primary": "#059669", "secondary": "#34D399"},
    "route": {"bg": "#F5F3FF", "primary": "#7C3AED", "secondary": "#A78BFA"},
    "hotel": {"bg": "#F0FDFA", "primary": "#0D9488", "secondary": "#2DD4BF"}
}

def create_dial_svg(path, theme):
    p = PALETTES[theme]
    svg = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%">
  <rect width="100" height="100" rx="24" fill="{p['bg']}" />
  <rect x="20" y="24" width="45" height="30" rx="8" fill="{p['primary']}" />
  <polygon points="30,54 42,54 26,64" fill="{p['primary']}" />
  <line x1="28" y1="36" x2="52" y2="36" stroke="#FFF" stroke-width="3" stroke-linecap="round"/>
  <line x1="28" y1="44" x2="44" y2="44" stroke="#FFF" stroke-width="3" stroke-linecap="round"/>
  
  <rect x="35" y="46" width="45" height="30" rx="8" fill="{p['secondary']}" opacity="0.95"/>
  <polygon points="70,76 58,76 74,86" fill="{p['secondary']}" opacity="0.95"/>
  <line x1="43" y1="58" x2="67" y2="58" stroke="#FFF" stroke-width="3" stroke-linecap="round"/>
  <line x1="43" y1="66" x2="59" y2="66" stroke="#FFF" stroke-width="3" stroke-linecap="round"/>
</svg>'''
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg.strip())

DIAL_MAP = [
    ("img_dial_meeting", "meeting"),
    ("img_dial_cafe", "cafe"),
    ("img_dial_supermarket", "market"),
    ("img_dial_directions", "route"),
    ("img_dial_hotel", "hotel")
]

with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
    reg = json.load(f)

for img_id, theme in DIAL_MAP:
    path = f"content/assets/svg/{img_id}.svg"
    create_dial_svg(path, theme)
    reg["assets"][img_id] = {
        "asset_path": path,
        "format": "svg",
        "ownership": "Project Original",
        "license": "CC0-1.0",
        "size_bytes": os.path.getsize(path)
    }

with open("content/assets/images_registry.json", "w", encoding="utf-8") as f:
    json.dump(reg, f, ensure_ascii=False, indent=2)

print(f"Generated 5 dialogue SVG assets. Total registry assets: {len(reg['assets'])}")
