import json, os

PALETTES = {
    "office": {"bg": "#EFF6FF", "primary": "#1D4ED8", "secondary": "#60A5FA"},     # أزرق عمل ومكاتب
    "study": {"bg": "#F5F3FF", "primary": "#7C3AED", "secondary": "#A78BFA"},      # بنفسجي دراسة وكتب
    "pro": {"bg": "#F8FAFC", "primary": "#334155", "secondary": "#64748B"},        # رمادي رسمي للمهن
    "accent": {"bg": "#FEF3C7", "primary": "#D97706", "secondary": "#FBBF24"}      # كهرماني شهادات ومكافآت
}

def create_work_svg(path, theme, sym):
    p = PALETTES[theme]
    symbols = {
        "briefcase": f'<rect x="22" y="34" width="56" height="42" rx="6" fill="{p["primary"]}"/><path d="M38 34 V24 C38 20 62 20 62 24 V34" stroke="{p["secondary"]}" stroke-width="5" fill="none"/><line x1="22" y1="52" x2="78" y2="52" stroke="#FFF" stroke-width="3"/><circle cx="50" cy="52" r="4" fill="#FFF"/>',
        "person": f'<circle cx="50" cy="36" r="16" fill="{p["primary"]}"/><path d="M26 80 C26 62 36 56 50 56 C64 56 74 62 74 80 Z" fill="{p["primary"]}"/><polygon points="46,56 50,66 54,56" fill="#FFF"/>',
        "person_f": f'<circle cx="50" cy="36" r="16" fill="{p["primary"]}"/><path d="M24 80 C24 62 36 54 50 54 C64 54 76 62 76 80 Z" fill="{p["secondary"]}"/><path d="M30 42 Q50 50 70 42" stroke="#FFF" stroke-width="3" fill="none"/>',
        "book": f'<path d="M50 36 C40 28 22 28 22 72 C40 68 50 74 50 74 C50 74 60 68 78 72 C78 28 60 28 50 36 Z" fill="{p["primary"]}"/><line x1="50" y1="36" x2="50" y2="74" stroke="#FFF" stroke-width="3"/>',
        "pen": f'<path d="M30 70 L70 30 L60 20 L20 60 L18 72 Z" fill="{p["primary"]}"/><line x1="16" y1="84" x2="84" y2="84" stroke="{p["secondary"]}" stroke-width="4"/>',
        "computer": f'<rect x="22" y="24" width="56" height="40" rx="4" fill="{p["primary"]}"/><rect x="26" y="28" width="48" height="32" fill="#FFF"/><polygon points="44,64 56,64 62,76 38,76" fill="{p["secondary"]}"/><rect x="32" y="76" width="36" height="4" rx="2" fill="{p["primary"]}"/>',
        "badge": f'<circle cx="50" cy="44" r="20" fill="{p["primary"]}"/><polygon points="42,60 36,84 50,76 64,84 58,60" fill="{p["secondary"]}"/><circle cx="50" cy="44" r="10" fill="#FFF"/>',
        "chat": f'<rect x="22" y="26" width="56" height="40" rx="8" fill="{p["primary"]}"/><polygon points="34,66 48,66 30,78" fill="{p["primary"]}"/><text x="50" y="52" font-size="24" font-family="sans-serif" font-weight="bold" fill="#FFF" text-anchor="middle">?</text>'
    }
    content = symbols.get(sym, symbols["briefcase"])
    svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="100%"><rect width="100" height="100" rx="24" fill="{p["bg"]}" />{content}</svg>'
    with open(path, "w", encoding="utf-8") as f:
        f.write(svg)

WORK_MAP = [
    ("img_work_briefcase", "office", "briefcase"), ("img_work_badge", "accent", "badge"),
    ("img_work_office", "office", "computer"), ("img_work_teacher_m", "pro", "person"),
    ("img_work_teacher_f", "pro", "person_f"), ("img_work_doctor_m", "pro", "person"),
    ("img_work_doctor_f", "pro", "person_f"), ("img_work_engineer_m", "pro", "person"),
    ("img_work_engineer_f", "pro", "person_f"), ("img_work_student_m", "study", "person"),
    ("img_work_student_f", "study", "person_f"), ("img_work_university", "study", "briefcase"),
    ("img_work_book", "study", "book"), ("img_work_pen", "study", "pen"),
    ("img_work_notebook", "study", "book"), ("img_work_computer", "office", "computer"),
    ("img_work_boss", "pro", "person"), ("img_work_colleague", "office", "person"),
    ("img_work_meeting", "office", "briefcase"), ("img_work_salary", "accent", "badge"),
    ("img_work_break", "accent", "badge"), ("img_work_question", "study", "chat"),
    ("img_work_answer", "study", "chat"), ("img_work_language", "study", "book"),
    ("img_work_lesson", "study", "book")
]

with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
    reg = json.load(f)

for img_id, theme, sym in WORK_MAP:
    path = f"content/assets/svg/{img_id}.svg"
    create_work_svg(path, theme, sym)
    reg["assets"][img_id] = {
        "asset_path": path,
        "format": "svg",
        "ownership": "Project Original",
        "license": "CC0-1.0",
        "size_bytes": os.path.getsize(path)
    }

with open("content/assets/images_registry.json", "w", encoding="utf-8") as f:
    json.dump(reg, f, ensure_ascii=False, indent=2)

print(f"Generated 25 work/study SVG assets. Total registry assets: {len(reg['assets'])}")
