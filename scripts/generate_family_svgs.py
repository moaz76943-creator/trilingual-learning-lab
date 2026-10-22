import json
import os

# ألوان ناعمة متناسقة (Soft Pastel & Modern Palette)
PALETTES = {
    "group": {"bg": "#E0F2FE", "primary": "#0284C7", "secondary": "#38BDF8"},      # أزرق هادئ
    "male": {"bg": "#EDE9FE", "primary": "#6D28D9", "secondary": "#A78BFA"},       # بنفسجي ناعم
    "female": {"bg": "#FCE7F3", "primary": "#BE185D", "secondary": "#F472B6"},     # وردي هادئ
    "elder": {"bg": "#FEF3C7", "primary": "#B45309", "secondary": "#FBBF24"},      # كهرماني دافئ
    "child": {"bg": "#DCFCE7", "primary": "#15803D", "secondary": "#4ADE80"},      # أخضر لطيف
    "couple": {"bg": "#FFE4E6", "primary": "#E11D48", "secondary": "#FB7185"}      # وردي مائل للاحمرار
}

def create_svg(path, theme, symbol_type):
    p = PALETTES[theme]
    
    # عناصر رسم هندسية خفيفة تمثل المفهوم بأسلوب Minimalist Vector
    symbols = {
        "group": f'''
            <circle cx="36" cy="40" r="14" fill="{p['primary']}" />
            <circle cx="64" cy="40" r="14" fill="{p['secondary']}" />
            <path d="M16 82 C16 66, 30 58, 36 58 C42 58, 56 66, 56 82 Z" fill="{p['primary']}" />
            <path d="M44 82 C44 66, 58 58, 64 58 C70 58, 84 66, 84 82 Z" fill="{p['secondary']}" opacity="0.9" />
        ''',
        "male": f'''
            <circle cx="50" cy="38" r="16" fill="{p['primary']}" />
            <path d="M26 84 C26 66, 36 60, 50 60 C64 60, 74 66, 74 84 Z" fill="{p['primary']}" />
        ''',
        "female": f'''
            <circle cx="50" cy="38" r="16" fill="{p['primary']}" />
            <path d="M24 84 C24 66, 36 58, 50 58 C64 58, 76 66, 76 84 Z" fill="{p['primary']}" />
            <path d="M32 44 C32 44, 50 52, 68 44" stroke="#FFF" stroke-width="3" stroke-linecap="round" fill="none" opacity="0.7"/>
        ''',
        "elder_male": f'''
            <circle cx="50" cy="38" r="16" fill="{p['primary']}" />
            <path d="M38 30 Q50 24 62 30" stroke="#FFF" stroke-width="4" stroke-linecap="round" fill="none" />
            <path d="M26 84 C26 68, 36 62, 50 62 C64 62, 74 68, 74 84 Z" fill="{p['primary']}" />
        ''',
        "elder_female": f'''
            <circle cx="50" cy="38" r="16" fill="{p['primary']}" />
            <circle cx="50" cy="22" r="6" fill="{p['secondary']}" />
            <path d="M24 84 C24 68, 36 60, 50 60 C64 60, 76 68, 76 84 Z" fill="{p['primary']}" />
        ''',
        "child": f'''
            <circle cx="50" cy="42" r="13" fill="{p['primary']}" />
            <path d="M32 84 C32 70, 40 64, 50 64 C60 64, 68 70, 68 84 Z" fill="{p['primary']}" />
        ''',
        "baby": f'''
            <circle cx="50" cy="46" r="12" fill="{p['primary']}" />
            <path d="M36 84 C36 74, 42 70, 50 70 C58 70, 64 74, 64 84 Z" fill="{p['primary']}" />
            <circle cx="50" cy="38" r="3" fill="#FFF" />
        ''',
        "couple": f'''
            <circle cx="38" cy="38" r="13" fill="{p['primary']}" />
            <circle cx="62" cy="38" r="13" fill="{p['secondary']}" />
            <path d="M20 84 C20 70, 30 64, 38 64 C46 64, 54 70, 54 84 Z" fill="{p['primary']}" />
            <path d="M46 84 C46 70, 54 64, 62 64 C70 64, 80 70, 80 84 Z" fill="{p['secondary']}" opacity="0.9" />
        '''
    }

    content = symbols.get(symbol_type, symbols["male"])
    
    svg = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%">
  <rect width="100" height="100" rx="24" fill="{p['bg']}" />
  {content}
</svg>'''
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg.strip())

# خريطة المفاهيم وتصاميمها
MAPPINGS = [
    ("img_fam_family", "group", "group"),
    ("img_fam_father", "male", "male"),
    ("img_fam_mother", "female", "female"),
    ("img_fam_son", "child", "child"),
    ("img_fam_daughter", "child", "child"),
    ("img_fam_brother", "male", "male"),
    ("img_fam_sister", "female", "female"),
    ("img_fam_grandfather", "elder", "elder_male"),
    ("img_fam_grandmother", "elder", "elder_female"),
    ("img_fam_parents", "couple", "couple"),
    ("img_fam_paternal_uncle", "male", "male"),
    ("img_fam_maternal_uncle", "male", "male"),
    ("img_fam_paternal_aunt", "female", "female"),
    ("img_fam_maternal_aunt", "female", "female"),
    ("img_fam_cousin_male", "male", "male"),
    ("img_fam_cousin_female", "female", "female"),
    ("img_fam_nephew", "child", "child"),
    ("img_fam_niece", "child", "child"),
    ("img_fam_husband", "couple", "male"),
    ("img_fam_wife", "couple", "female"),
    ("img_fam_child", "child", "child"),
    ("img_fam_baby", "child", "baby"),
    ("img_fam_grandson", "child", "child"),
    ("img_fam_granddaughter", "child", "child"),
    ("img_fam_relatives", "group", "group")
]

registry = {"version": 1, "assets": {}}

for img_id, theme, sym in MAPPINGS:
    file_name = f"{img_id}.svg"
    rel_path = f"content/assets/svg/{file_name}"
    create_svg(rel_path, theme, sym)
    
    registry["assets"][img_id] = {
        "asset_path": rel_path,
        "format": "svg",
        "ownership": "Project Original",
        "license": "CC0-1.0",
        "size_bytes": os.path.getsize(rel_path)
    }

with open("content/assets/images_registry.json", "w", encoding="utf-8") as f:
    json.dump(registry, f, ensure_ascii=False, indent=2)

print(f"Generated {len(MAPPINGS)} SVG assets and updated images_registry.json successfully.")
