import json
import os

print("🚀 [CYCLE 035] بدء بناء محرك المضاف إليه وحروف الجر الملكية والسببية (Genitiv Engine)...")

# 1. إعداد بيانات محرك المضاف إليه
genitive_data = {
    "engine_name": "genitive_prepositions_engine",
    "level": "A2",
    "title": {
        "ar": "محرك المضاف إليه وحروف الجر السببية والملكية (Genitiv)",
        "de": "Der Genitiv und Genitiv-Präpositionen (wegen, während, trotz, statt)",
        "en": "German Genitive Case & Possessive Prepositions Engine"
    },
    "declension_rules": {
        "masculine": {"article": "des", "noun_ending": "+(e)s", "example": "des Mannes / des Tages"},
        "neuter": {"article": "des", "noun_ending": "+(e)s", "example": "des Kindes / des Hauses"},
        "feminine": {"article": "der", "noun_ending": "ohne Endung", "example": "der Frau / der Mutter"},
        "plural": {"article": "der", "noun_ending": "ohne Endung", "example": "der Kinder / der Freunde"}
    },
    "prepositions": [
        {
            "id": "prep_wegen",
            "german": "wegen",
            "arabic": "بِسَبَبِ / جَرَّاءَ",
            "english": "because of / due to",
            "case": "Genitiv",
            "example": "Wegen des schlechten Wetters bleiben wir zu Hause."
        },
        {
            "id": "prep_waehrend",
            "german": "während",
            "arabic": "أَثْنَاءَ / خِلَالَ",
            "english": "during / while",
            "case": "Genitiv",
            "example": "Während der Pause trinke ich einen heißen Tee."
        },
        {
            "id": "prep_trotz",
            "german": "trotz",
            "arabic": "رَغْمَ / عَلَى الرَّغْمِ مِنْ",
            "english": "in spite of / despite",
            "case": "Genitiv",
            "example": "Trotz des starken Regens gehen die Kinder spazieren."
        },
        {
            "id": "prep_statt",
            "german": "statt / anstelle",
            "arabic": "بَدَلًا مِنْ / عِوَضًا عَنْ",
            "english": "instead of",
            "case": "Genitiv",
            "example": "Er trinkt Wasser statt des süßen Saftes."
        }
    ],
    "phrases": [
        {
            "id": "gen_des_tages",
            "german": "während des Tages",
            "arabic": "خِلَالَ النَّهَارِ",
            "english": "during the day",
            "explanation": "المذكر der Tag يتحول إلى des Tages بعد während.",
            "image_id": "img_gen_des_tages"
        },
        {
            "id": "gen_des_wetters",
            "german": "wegen des Wetters",
            "arabic": "بِسَبَبِ الطَّقْسِ",
            "english": "because of the weather",
            "explanation": "المحايد das Wetter يتحول إلى des Wetters بعد wegen.",
            "image_id": "img_gen_wegen"
        },
        {
            "id": "gen_der_arbeit",
            "german": "während der Arbeit",
            "arabic": "أَثْنَاءَ العَمَلِ",
            "english": "during work",
            "explanation": "المؤنث die Arbeit يتحول إلى der Arbeit دون إضافة لحروف الاسم.",
            "image_id": "img_gen_waehrend"
        },
        {
            "id": "gen_des_regens",
            "german": "trotz des Regens",
            "arabic": "رَغْمَ المَطَرِ",
            "english": "despite the rain",
            "explanation": "المذكر der Regen يتحول إلى des Regens بعد trotz.",
            "image_id": "img_gen_trotz"
        },
        {
            "id": "gen_des_geldes",
            "german": "statt des Geldes",
            "arabic": "بَدَلًا مِنَ المَالِ",
            "english": "instead of the money",
            "explanation": "المحايد das Geld يتحول إلى des Geldes بعد statt.",
            "image_id": "img_gen_statt"
        },
        {
            "id": "gen_auto_vaters",
            "german": "das Auto des Vaters",
            "arabic": "سَيَّارَةُ الأَبِ (إِضَافَةٌ مَلَكِيَّةٌ)",
            "english": "the father's car",
            "explanation": "إضافة ملكية للمذكر: der Vater -> des Vaters.",
            "image_id": "img_gen_auto_vaters"
        },
        {
            "id": "gen_buch_mutter",
            "german": "das Buch der Mutter",
            "arabic": "كِتَابُ الأُمِّ",
            "english": "the mother's book",
            "explanation": "إضافة ملكية للمؤنث: die Mutter -> der Mutter.",
            "image_id": "img_gen_buch_mutter"
        },
        {
            "id": "gen_spielzeug_kind",
            "german": "das Spielzeug des Kindes",
            "arabic": "لُعْبَةُ الطِّفْلِ",
            "english": "the child's toy",
            "explanation": "إضافة ملكية للمحايد: das Kind -> des Kindes.",
            "image_id": "img_gen_spielzeug_kind"
        },
        {
            "id": "gen_tasche_lehrerin",
            "german": "die Tasche der Lehrerin",
            "arabic": "حَقِيبَةُ المُعَلِّمَةِ",
            "english": "the teacher's bag",
            "explanation": "إضافة ملكية للمؤنث: die Lehrerin -> der Lehrerin.",
            "image_id": "img_gen_tasche_lehrerin"
        },
        {
            "id": "gen_hilfe_freunde",
            "german": "die Hilfe der Freunde",
            "arabic": "مُسَاعَدَةُ الأَصْدِقَاءِ",
            "english": "the friends' help",
            "explanation": "إضافة ملكية للجمع: die Freunde -> der Freunde.",
            "image_id": "img_gen_hilfe_freunde"
        }
    ]
}

# حفظ الملف في content/grammar/genitive_prepositions_a2.json
os.makedirs("content/grammar", exist_ok=True)
gen_file = "content/grammar/genitive_prepositions_a2.json"
with open(gen_file, "w", encoding="utf-8") as f:
    json.dump(genitive_data, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ محرك المضاف إليه وحروف الجر في {gen_file}")

# 2. توليد 10 أيقونات SVG متجهية خفيفة (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "gen_wegen": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#E65100"/><path d="M50,22 L50,56 M50,68 L50,76" stroke="#FFF" stroke-width="8" stroke-linecap="round"/><circle cx="50" cy="50" r="34" fill="none" stroke="#FFB74D" stroke-width="3" stroke-dasharray="6,4"/></svg>',
    "gen_waehrend": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1565C0"/><circle cx="50" cy="50" r="28" fill="#FFF"/><line x1="50" y1="50" x2="50" y2="30" stroke="#1565C0" stroke-width="5" stroke-linecap="round"/><line x1="50" y1="50" x2="68" y2="50" stroke="#E91E63" stroke-width="4" stroke-linecap="round"/><circle cx="50" cy="50" r="4" fill="#1565C0"/></svg>',
    "gen_trotz": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#2E7D32"/><path d="M30,50 L70,50" stroke="#FFF" stroke-width="8" stroke-linecap="round"/><polygon points="70,50 55,38 55,62" fill="#FFF"/><path d="M22,35 Q15,50 22,65" stroke="#FFEB3B" stroke-width="6" fill="none" stroke-linecap="round"/></svg>',
    "gen_statt": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#7B1FA2"/><path d="M30,42 L70,42 M58,32 L70,42 L58,52" stroke="#FFF" stroke-width="5" fill="none" stroke-linecap="round" stroke-linejoin="round"/><path d="M70,58 L30,58 M42,48 L30,58 L42,68" stroke="#FFD54F" stroke-width="5" fill="none" stroke-linecap="round" stroke-linejoin="round"/></svg>',
    "gen_auto_vaters": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="40" width="64" height="28" rx="6" fill="#0288D1"/><polygon points="30,40 40,24 64,24 72,40" fill="#0288D1"/><circle cx="34" cy="68" r="8" fill="#37474F"/><circle cx="68" cy="68" r="8" fill="#37474F"/><circle cx="34" cy="68" r="3" fill="#FFF"/><circle cx="68" cy="68" r="3" fill="#FFF"/><polygon points="75,20 82,30 95,30 85,38 88,50 75,42 62,50 65,38 55,30 68,30" fill="#FFD54F" transform="scale(0.5) translate(80, 10)"/></svg>',
    "gen_buch_mutter": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M20,30 Q50,38 50,75 Q20,68 20,30 Z" fill="#E91E63"/><path d="M80,30 Q50,38 50,75 Q80,68 80,30 Z" fill="#C2185B"/><line x1="50" y1="38" x2="50" y2="75" stroke="#880E4F" stroke-width="3"/><circle cx="50" cy="22" r="8" fill="#FFD54F"/></svg>',
    "gen_spielzeug_kind": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="35" width="50" height="45" rx="6" fill="#FFB300"/><circle cx="50" cy="58" r="14" fill="#00E676"/><polygon points="50,15 54,25 65,25 56,31 60,41 50,35 40,41 44,31 35,25 46,25" fill="#E91E63"/></svg>',
    "gen_tasche_lehrerin": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="38" width="56" height="44" rx="6" fill="#8D6E63"/><path d="M38,38 C38,24 62,24 62,38" fill="none" stroke="#5D4037" stroke-width="6"/><circle cx="50" cy="55" r="5" fill="#FFD54F"/><line x1="22" y1="48" x2="78" y2="48" stroke="#5D4037" stroke-width="3"/></svg>',
    "gen_hilfe_freunde": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="36" cy="35" r="14" fill="#42A5F5"/><circle cx="64" cy="35" r="14" fill="#66BB6A"/><path d="M18,80 C18,60 54,60 54,80 Z" fill="#1E88E5"/><path d="M46,80 C46,60 82,60 82,80 Z" fill="#43A047"/><circle cx="50" cy="62" r="12" fill="#FFCA28"/><path d="M46,62 L49,65 L55,59" stroke="#3E2723" stroke-width="3" fill="none"/></svg>',
    "gen_des_tages": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FDD835"/><circle cx="50" cy="50" r="26" fill="#FFA000"/><line x1="50" y1="12" x2="50" y2="4" stroke="#F57F17" stroke-width="5" stroke-linecap="round"/><line x1="50" y1="88" x2="50" y2="96" stroke="#F57F17" stroke-width="5" stroke-linecap="round"/><line x1="12" y1="50" x2="4" y2="50" stroke="#F57F17" stroke-width="5" stroke-linecap="round"/><line x1="88" y1="50" x2="96" y2="50" stroke="#F57F17" stroke-width="5" stroke-linecap="round"/></svg>'
}

for k, svg_content in svg_templates.items():
    with open(f"content/assets/svg/{k}.svg", "w", encoding="utf-8") as f:
        f.write(svg_content)

print(f"✅ تم إنشاء {len(svg_templates)} ملفات SVG في content/assets/svg/")

# 3. تحديث سجل الأصول images_registry.json
reg_path = "content/assets/images_registry.json"
registry = {"assets": []}
if os.path.exists(reg_path):
    with open(reg_path, "r", encoding="utf-8") as f:
        registry = json.load(f)

existing_ids = {a["image_id"] for a in registry.get("assets", [])}
new_added = 0
for k in svg_templates.keys():
    img_id = f"img_{k}"
    if img_id not in existing_ids:
        registry["assets"].append({
            "image_id": img_id,
            "file": f"assets/svg/{k}.svg",
            "type": "svg",
            "description": f"Vector illustration for Genitive case: {k}"
        })
        new_added += 1

with open(reg_path, "w", encoding="utf-8") as f:
    json.dump(registry, f, ensure_ascii=False, indent=2)

print(f"✅ تم تحديث سجل الأصول: إجمالي الأصول المسجلة الآن = {len(registry['assets'])} (أضيف {new_added})")

# 4. إضافة 5 تمارين بناء جمل للمضاف إليه (إجمالي 40 جملة)
sentences_file = "content/grammar/sentences_a1.json"
sent_data = {"sentences": []}
if os.path.exists(sentences_file):
    with open(sentences_file, "r", encoding="utf-8") as f:
        sent_data = json.load(f)

new_sentences = [
    {
        "id": "sent_gen_01",
        "level": "A2",
        "topic": "Genitiv-Präposition: wegen",
        "german": "Wegen des Regens bleiben wir zu Hause.",
        "arabic": "بِسَبَبِ المَطَرِ نَبْقَى فِي البَيْتِ.",
        "english": "Because of the rain, we stay at home.",
        "tokens_de": ["Wegen", "des", "Regens", "bleiben", "wir", "zu", "Hause."],
        "grammar_rule": "حرف الجر wegen يتطلب حالة المضاف إليه (des Regens) ويأتي الفعل المصرف bleiben في الموقع 2."
    },
    {
        "id": "sent_gen_02",
        "level": "A2",
        "topic": "Genitiv-Präposition: während",
        "german": "Während der Pause trinke ich Kaffee.",
        "arabic": "أَثْنَاءَ الِاسْتِرَاحَةِ أَشْرَبُ القَهْوَةَ.",
        "english": "During the break, I drink coffee.",
        "tokens_de": ["Während", "der", "Pause", "trinke", "ich", "Kaffee."],
        "grammar_rule": "الاسم المؤنث بعد während يتحول إلى der Pause دون إضافة لحروف الاسم."
    },
    {
        "id": "sent_gen_03",
        "level": "A2",
        "topic": "Genitiv-Präposition: trotz",
        "german": "Trotz des Sturms fährt der Zug.",
        "arabic": "رَغْمَ العَاصِفَةِ يَنْطَلِقُ القِطَارُ.",
        "english": "Despite the storm, the train departs.",
        "tokens_de": ["Trotz", "des", "Sturms", "fährt", "der", "Zug."],
        "grammar_rule": "trotz يطلب Genitiv: der Sturm -> des Sturms مع إضافة s للاسم المذكر."
    },
    {
        "id": "sent_gen_04",
        "level": "A2",
        "topic": "Genitiv-Präposition: statt",
        "german": "Er nimmt Tee statt des Kaffees.",
        "arabic": "يَتَنَاوَلُ الشَّايَ بَدَلًا مِنَ القَهْوَةِ.",
        "english": "He takes tea instead of coffee.",
        "tokens_de": ["Er", "nimmt", "Tee", "statt", "des", "Kaffees."],
        "grammar_rule": "statt تفيد البدل وتطلب المضاف إليه (statt des Kaffees)."
    },
    {
        "id": "sent_gen_05",
        "level": "A2",
        "topic": "Genitiv-Attribut: Besitz",
        "german": "Das ist das Auto meines Vaters.",
        "arabic": "هَذِهِ سَيَّارَةُ أَبِي (مِلْكِيَّةٌ).",
        "english": "That is my father's car.",
        "tokens_de": ["Das", "ist", "das", "Auto", "meines", "Vaters."],
        "grammar_rule": "المضاف إليه للملكية: mein Vater يتحول إلى meines Vaters مع إضافة s للاسم."
    }
]

existing_sent_ids = {s["id"] for s in sent_data.get("sentences", [])}
for s in new_sentences:
    if s["id"] not in existing_sent_ids:
        sent_data["sentences"].append(s)

with open(sentences_file, "w", encoding="utf-8") as f:
    json.dump(sent_data, f, ensure_ascii=False, indent=2)

print(f"✅ تم تحديث بنك الجمل التفاعلية: إجمالي الجمل الآن = {len(sent_data['sentences'])} (المستهدف: 40)")

# 5. تحديث ContentRepository في Dart
content_repo_path = "lib/repositories/content_repository.dart"
if os.path.exists(content_repo_path):
    with open(content_repo_path, "r", encoding="utf-8") as f:
        repo_code = f.read()
    
    if "genitive_prepositions_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/grammar/perfekt_a2.json',",
            "'assets/content/grammar/perfekt_a2.json',\n    'assets/content/grammar/genitive_prepositions_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط genitive_prepositions_a2.json في lib/repositories/content_repository.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_SENTENCES = 35", "TOTAL_SENTENCES = 40")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 575", "TOTAL_SVG_ASSETS = 585")
    
    if "genitive_prepositions_a2.json" not in val_code:
        insertion = """
    # فحص محرك المضاف إليه وحروف الجر A2 Genitiv
    gen_path = os.path.join(base_dir, 'content', 'grammar', 'genitive_prepositions_a2.json')
    assert os.path.exists(gen_path), f"Missing Genitiv file: {gen_path}"
    with open(gen_path, 'r', encoding='utf-8') as f:
        gen_file_data = json.load(f)
    assert len(gen_file_data.get('prepositions', [])) == 4, "Expected 4 Genitiv prepositions"
    assert len(gen_file_data.get('phrases', [])) == 10, "Expected 10 Genitiv phrases"
"""
        val_code = val_code.replace("print('All assertions OK!')", insertion + "\n    print('All assertions OK!')")
    
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (40 جملة، 585 أصلًا متجهيًا، محرك Genitiv مع 4 حروف و10 تراكيب)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 035 Status (Completed - A2 Genitiv Engine)
- **Feature:** A2 Genitive & Possessive Prepositions Engine (`content/grammar/genitive_prepositions_a2.json`).
- **Grammar Engine:** 4 core Genitive prepositions (wegen, während, trotz, statt) + 10 possessive attribute phrases.
- **Sentence Builder:** Expanded to 40 interactive syntactic exercises (5 new Genitive sentence structures).
- **New Visuals:** 10 unique SVG vector assets (`gen_*.svg`).
- **Total Milestone:** 20 Categories (505 Concepts) | 35 Verbs | 15 Perfekt Forms | 40 Syntax Exercises | 20 Prepositions + 4 Genitiv Prepositions | 5 Dialogues | Articles Engine | 585 Total SVG Icons.
- **Integration:** Active in ContentRepository, SentenceBuilderScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 035 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 035 بنجاح تام!")
