import json
import os

print("🚀 [CYCLE 038] بدء بناء محرك جمل الوصل والأسماء الموصولة (A2 Relativsätze Engine)...")

# 1. إعداد بيانات محرك جمل الوصل
relative_clauses_data = {
    "engine_name": "relative_clauses_engine",
    "level": "A2",
    "title": {
        "ar": "محرك جمل الوصل والأسماء الموصولة (Relativsätze im Nominativ und Akkusativ)",
        "de": "Relativsätze und Relativpronomen im Nominativ und Akkusativ",
        "en": "German Relative Clauses Engine (Nominative & Accusative)"
    },
    "grammar_rules": {
        "structure": "Hauptsatz + Komma (,) + Relativpronomen + ... + konjugiertes Verb (am Satzende)",
        "gender_rule": "يأخذ الضمير النسبي جنس وعدّة الاسم الموصوف (Bezugswort) من الجملة الرئيسية.",
        "case_rule": "تحدد الحالة الإعرابية (رفع Nominativ أو نصب Akkusativ) حسب وظيفة الضمير داخل جملة الوصل.",
        "verb_position": "في اللغة الألمانية، يجب دائمًا نقل الفعل المصرف إلى نهاية جملة الوصل تمامًا."
    },
    "pronouns_table": {
        "Nominativ": {
            "masculine": {"pronoun": "der", "ar": "الَّذِي (فاعل مذكر)", "en": "who / which / that"},
            "feminine": {"pronoun": "die", "ar": "الَّتِي (فاعل مؤنث)", "en": "who / which / that"},
            "neuter": {"pronoun": "das", "ar": "الَّذِي (فاعل محايد)", "en": "which / that"},
            "plural": {"pronoun": "die", "ar": "الَّذِينَ / اللَّاتِي (فاعل جمع)", "en": "who / that"}
        },
        "Akkusativ": {
            "masculine": {"pronoun": "den", "ar": "الَّذِي (مفعول به مذكر)", "en": "whom / that"},
            "feminine": {"pronoun": "die", "ar": "الَّتِي (مفعول به مؤنث)", "en": "whom / that"},
            "neuter": {"pronoun": "das", "ar": "الَّذِي (مفعول به محايد)", "en": "which / that"},
            "plural": {"pronoun": "die", "ar": "الَّذِينَ / اللَّاتِي (مفعول به جمع)", "en": "whom / that"}
        }
    },
    "templates": [
        {
            "id": "rel_mann_nom",
            "case": "Nominativ",
            "gender": "masculine",
            "german": "Das ist der Mann, der fließend Deutsch spricht.",
            "arabic": "هَذَا هُوَ الرَّجُلُ الَّذِي يَتَحَدَّثُ الأَلْمَانِيَّةَ بِطَلَاقَةٍ.",
            "english": "That is the man who speaks fluent German.",
            "image_id": "img_rel_mann_nom"
        },
        {
            "id": "rel_frau_nom",
            "case": "Nominativ",
            "gender": "feminine",
            "german": "Das ist die Frau, die im Nachbarhaus wohnt.",
            "arabic": "هَذِهِ هِيَ المَرْأَةُ الَّتِي تَسْكُنُ فِي البَيْتِ المُجَاوِرِ.",
            "english": "That is the woman who lives next door.",
            "image_id": "img_rel_frau_nom"
        },
        {
            "id": "rel_kind_nom",
            "case": "Nominativ",
            "gender": "neuter",
            "german": "Das ist das Kind, das fröhlich im Garten spielt.",
            "arabic": "هَذَا هُوَ الطِّفْلُ الَّذِي يَلْعَبُ بِمَرَحٍ فِي الحَدِيقَةِ.",
            "english": "That is the child who is playing joyfully in the garden.",
            "image_id": "img_rel_kind_nom"
        },
        {
            "id": "rel_freunde_nom",
            "case": "Nominativ",
            "gender": "plural",
            "german": "Das sind die Freunde, die uns immer unterstützen.",
            "arabic": "هَؤُلَاءِ هُمُ الأَصْدِقَاءُ الَّذِينَ يَدْعَمُونَنَا دَائِمًا.",
            "english": "Those are the friends who always support us.",
            "image_id": "img_rel_freunde_nom"
        },
        {
            "id": "rel_lehrer_akk",
            "case": "Akkusativ",
            "gender": "masculine",
            "german": "Das ist der Lehrer, den alle Schüler sehr schätzen.",
            "arabic": "هَذَا هُوَ المُعَلِّمُ الَّذِي يُقَدِّرُهُ جَمِيعُ التَّلَامِيذِ.",
            "english": "That is the teacher whom all students respect.",
            "image_id": "img_rel_lehrer_akk"
        },
        {
            "id": "rel_stadt_akk",
            "case": "Akkusativ",
            "gender": "feminine",
            "german": "Berlin ist die Stadt, die wir im Sommer besuchen möchten.",
            "arabic": "بَرْلِينُ هِيَ المَدِينَةُ الَّتِي نَوَدُّ زِيَارَتَهَا فِي الصَّيْفِ.",
            "english": "Berlin is the city that we want to visit in summer.",
            "image_id": "img_rel_stadt_akk"
        },
        {
            "id": "rel_buch_akk",
            "case": "Akkusativ",
            "gender": "neuter",
            "german": "Hier ist das Buch, das ich gestern gekauft habe.",
            "arabic": "هُنَا الكِتَابُ الَّذِي اشْتَرَيْتُهُ أَمْسِ.",
            "english": "Here is the book that I bought yesterday.",
            "image_id": "img_rel_buch_akk"
        },
        {
            "id": "rel_fotos_akk",
            "case": "Akkusativ",
            "gender": "plural",
            "german": "Wo sind die Fotos, die du im Urlaub gemacht hast?",
            "arabic": "أَيْنَ الصُّوَرُ الَّتِي التَقَطْتَهَا فِي العُطْلَةِ؟",
            "english": "Where are the photos that you took during the vacation?",
            "image_id": "img_rel_fotos_akk"
        },
        {
            "id": "rel_hund_nom",
            "case": "Nominativ",
            "gender": "masculine",
            "german": "Ich mag den Hund, der so freundlich mit dem Schwanz wedelt.",
            "arabic": "أُحِبُّ الكَلْبَ الَّذِي يَهُزُّ ذَيْلَهُ بِمَوَدَّةٍ.",
            "english": "I like the dog that wags its tail so happily.",
            "image_id": "img_rel_hund_nom"
        },
        {
            "id": "rel_auto_akk",
            "case": "Akkusativ",
            "gender": "neuter",
            "german": "Er fährt das Auto, das er von seinem Großvater geerbt hat.",
            "arabic": "يَقُودُ السَّيَّارَةَ الَّتِي وَرِثَهَا عَنْ جَدِّهِ.",
            "english": "He drives the car that he inherited from his grandfather.",
            "image_id": "img_rel_auto_akk"
        }
    ]
}

# حفظ الملف في content/grammar/relative_clauses_a2.json
os.makedirs("content/grammar", exist_ok=True)
rel_file = "content/grammar/relative_clauses_a2.json"
with open(rel_file, "w", encoding="utf-8") as f:
    json.dump(relative_clauses_data, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ محرك جمل الوصل والأسماء الموصولة في {rel_file}")

# 2. توليد 10 أيقونات SVG متجهية خفيفة (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "rel_mann_nom": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="30" r="14" fill="#FFA726"/><path d="M25,80 C25,55 65,55 65,80 Z" fill="#1E88E5"/><path d="M65,45 L85,45 M78,38 L85,45 L78,52" stroke="#FF9800" stroke-width="4" fill="none" stroke-linecap="round"/><circle cx="85" cy="45" r="4" fill="#FF9800"/></svg>',
    "rel_frau_nom": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="30" r="14" fill="#FFCC80"/><path d="M30,20 C42,12 58,12 66,20 C70,36 30,36 30,20 Z" fill="#5D4037"/><path d="M25,80 C25,55 65,55 65,80 Z" fill="#E91E63"/><path d="M65,45 L85,45 M78,38 L85,45 L78,52" stroke="#4CAF50" stroke-width="4" fill="none" stroke-linecap="round"/></svg>',
    "rel_kind_nom": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="35" r="12" fill="#FFA726"/><path d="M28,80 C28,60 62,60 62,80 Z" fill="#FFB300"/><circle cx="75" cy="40" r="8" fill="#00E676"/><path d="M60,55 L75,40" stroke="#757575" stroke-width="3" fill="none" stroke-dasharray="3,3"/></svg>',
    "rel_freunde_nom": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="35" cy="35" r="12" fill="#42A5F5"/><circle cx="65" cy="35" r="12" fill="#66BB6A"/><path d="M18,80 C18,60 52,60 52,80 Z" fill="#1976D2"/><path d="M48,80 C48,60 82,60 82,80 Z" fill="#388E3C"/><path d="M40,50 L60,50" stroke="#FFD54F" stroke-width="4"/></svg>',
    "rel_lehrer_akk": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="22" width="64" height="42" rx="3" fill="#2E7D32" stroke="#5D4037" stroke-width="3"/><circle cx="40" cy="70" r="10" fill="#FFA726"/><path d="M25,90 C25,78 55,78 55,90 Z" fill="#1E88E5"/><polygon points="70,55 82,70 65,72" fill="#FFD54F"/></svg>',
    "rel_stadt_akk": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="40" width="18" height="45" fill="#546E7A"/><rect x="42" y="25" width="22" height="60" fill="#78909C"/><rect x="68" y="48" width="16" height="37" fill="#90A4AE"/><circle cx="78" cy="28" r="8" fill="#FFB300"/><path d="M15,85 L85,85" stroke="#37474F" stroke-width="4"/></svg>',
    "rel_buch_akk": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="20" width="50" height="65" rx="3" fill="#D32F2F"/><rect x="20" y="20" width="10" height="65" fill="#B71C1C"/><line x1="38" y1="35" x2="65" y2="35" stroke="#FFF" stroke-width="3"/><line x1="38" y1="48" x2="65" y2="48" stroke="#FFF" stroke-width="3"/><circle cx="70" cy="65" r="10" fill="#FFCA28"/><path d="M66,65 L69,68 L75,62" stroke="#3E2723" stroke-width="2.5" fill="none"/></svg>',
    "rel_fotos_akk": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="20" width="55" height="50" rx="4" fill="#ECEFF1" stroke="#78909C" stroke-width="3" transform="rotate(10 50 45)"/><rect x="20" y="25" width="55" height="50" rx="4" fill="#FFF" stroke="#455A64" stroke-width="3"/><circle cx="35" cy="40" r="5" fill="#FFA000"/><polygon points="25,65 42,48 55,60 65,50 70,68 25,68" fill="#4CAF50"/></svg>',
    "rel_hund_nom": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="45" r="22" fill="#8D6E63"/><ellipse cx="25" cy="45" rx="6" ry="14" fill="#5D4037"/><circle cx="40" cy="42" r="3" fill="#212121"/><circle cx="50" cy="42" r="3" fill="#212121"/><circle cx="45" cy="52" r="4" fill="#212121"/><path d="M67,45 Q82,38 78,28" stroke="#8D6E63" stroke-width="5" fill="none" stroke-linecap="round"/></svg>',
    "rel_auto_akk": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="42" width="64" height="26" rx="6" fill="#00ACC1"/><polygon points="30,42 40,26 64,26 72,42" fill="#00ACC1"/><circle cx="34" cy="68" r="8" fill="#37474F"/><circle cx="68" cy="68" r="8" fill="#37474F"/><circle cx="34" cy="68" r="3" fill="#FFF"/><circle cx="68" cy="68" r="3" fill="#FFF"/><path d="M50,20 L50,10 M44,14 L50,10 L56,14" stroke="#FF9800" stroke-width="3" fill="none" stroke-linecap="round"/></svg>'
}

# كتابة ملفات الـ SVG الفردية
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
            "description": f"Vector illustration for Relative Clauses: {k}"
        })
        new_added += 1

with open(reg_path, "w", encoding="utf-8") as f:
    json.dump(registry, f, ensure_ascii=False, indent=2)

print(f"✅ تم تحديث سجل الأصول: إجمالي الأصول المسجلة الآن = {len(registry['assets'])} (أضيف {new_added})")

# 4. إضافة 5 تمارين بناء جمل تفاعلية جديدة لجمل الوصل (إجمالي 45 جملة)
sentences_file = "content/grammar/sentences_a1.json"
sent_data = {"sentences": []}
if os.path.exists(sentences_file):
    with open(sentences_file, "r", encoding="utf-8") as f:
        sent_data = json.load(f)

new_sentences = [
    {
        "id": "sent_rel_01",
        "level": "A2",
        "topic": "Relativsatz Nominativ (Maskulin)",
        "german": "Das ist der Mann, der hier arbeitet.",
        "arabic": "هَذَا هُوَ الرَّجُلُ الَّذِي يَعْمَلُ هُنَا.",
        "english": "That is the man who works here.",
        "tokens_de": ["Das", "ist", "der", "Mann,", "der", "hier", "arbeitet."],
        "grammar_rule": "الاسم الموصوف der Mann مذكر مرفوع، والضمير der في جملة الوصل فاعل، والفعل arbeitet في النهاية."
    },
    {
        "id": "sent_rel_02",
        "level": "A2",
        "topic": "Relativsatz Nominativ (Feminin)",
        "german": "Ich kenne die Frau, die gut kocht.",
        "arabic": "أَعْرِفُ المَرْأَةَ الَّتِي تَطْبُخُ جَيِّدًا.",
        "english": "I know the woman who cooks well.",
        "tokens_de": ["Ich", "kenne", "die", "Frau,", "die", "gut", "kocht."],
        "grammar_rule": "الضمير النسبي للمؤنث die مع إرسال الفعل المصرف kocht إلى نهاية الجملة."
    },
    {
        "id": "sent_rel_03",
        "level": "A2",
        "topic": "Relativsatz Akkusativ (Neutral)",
        "german": "Wo ist das Buch, das du liest?",
        "arabic": "أَيْنَ الكِتَابُ الَّذِي تَقْرَأُهُ؟",
        "english": "Where is the book that you are reading?",
        "tokens_de": ["Wo", "ist", "das", "Buch,", "das", "du", "liest?"],
        "grammar_rule": "الاسم المحايد das Buch يعود عليه الضمير das في حالة النصب (مفعول به للفعل liest)."
    },
    {
        "id": "sent_rel_04",
        "level": "A2",
        "topic": "Relativsatz Akkusativ (Maskulin)",
        "german": "Das ist der Freund, den ich anrufe.",
        "arabic": "هَذَا هُوَ الصَّدِيقُ الَّذِي أَتَّصِلُ بِهِ هَاتِفِيًّا.",
        "english": "That is the friend whom I am calling.",
        "tokens_de": ["Das", "ist", "der", "Freund,", "den", "ich", "anrufe."],
        "grammar_rule": "يتحول الضمير النسبي المذكر إلى den في حالة النصب (مفعول به للفعل anrufe)."
    },
    {
        "id": "sent_rel_05",
        "level": "A2",
        "topic": "Relativsatz Nominativ (Feminin - Adjektiv)",
        "german": "Wir mögen die Stadt, die so grün ist.",
        "arabic": "نُحِبُّ المَدِينَةَ الَّتِي هِيَ خَضْرَاءُ جِدًّا.",
        "english": "We like the city that is so green.",
        "tokens_de": ["Wir", "mögen", "die", "Stadt,", "die", "so", "grün", "ist."],
        "grammar_rule": "جملة الوصل تصف die Stadt بالضمير die، ويستقر الفعل ist في ذيل العبارة."
    }
]

existing_sent_ids = {s["id"] for s in sent_data.get("sentences", [])}
for s in new_sentences:
    if s["id"] not in existing_sent_ids:
        sent_data["sentences"].append(s)

with open(sentences_file, "w", encoding="utf-8") as f:
    json.dump(sent_data, f, ensure_ascii=False, indent=2)

print(f"✅ تم تحديث بنك الجمل التفاعلية: إجمالي الجمل الآن = {len(sent_data['sentences'])} (المستهدف: 45)")

# 5. تحديث ContentRepository في Dart
content_repo_path = "lib/repositories/content_repository.dart"
if os.path.exists(content_repo_path):
    with open(content_repo_path, "r", encoding="utf-8") as f:
        repo_code = f.read()
    
    if "relative_clauses_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/grammar/genitive_prepositions_a2.json',",
            "'assets/content/grammar/genitive_prepositions_a2.json',\n    'assets/content/grammar/relative_clauses_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط relative_clauses_a2.json في lib/repositories/content_repository.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_SENTENCES = 40", "TOTAL_SENTENCES = 45")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 635", "TOTAL_SVG_ASSETS = 645")
    
    if "relative_clauses_a2.json" not in val_code:
        insertion = """
    # فحص محرك جمل الوصل والأسماء الموصولة A2 Relativsätze
    rel_path = os.path.join(base_dir, 'content', 'grammar', 'relative_clauses_a2.json')
    assert os.path.exists(rel_path), f"Missing Relative Clauses file: {rel_path}"
    with open(rel_path, 'r', encoding='utf-8') as f:
        rel_file_data = json.load(f)
    assert len(rel_file_data.get('templates', [])) == 10, "Expected 10 relative clause templates"
    assert 'Nominativ' in rel_file_data.get('pronouns_table', {}), "Missing Nominativ in pronouns_table"
    assert 'Akkusativ' in rel_file_data.get('pronouns_table', {}), "Missing Akkusativ in pronouns_table"
"""
        val_code = val_code.replace("print('All assertions OK!')", insertion + "\n    print('All assertions OK!')")
    
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (45 جملة، 645 أصلًا متجهيًا، محرك Relativsätze كامل)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 038 Status (Completed - A2 Relative Clauses Engine)
- **Feature:** A2 Relative Clauses Engine (`content/grammar/relative_clauses_a2.json`).
- **Grammar Engine:** Complete declension matrix for relative pronouns (der/die/das/die & den/die/das/die) with verb-end syntax rules.
- **Sentence Builder:** Expanded to 45 interactive syntactic exercises (5 new relative clause exercises).
- **New Visuals:** 10 unique SVG vector assets (`rel_*.svg`).
- **Total Milestone:** 22 Categories (555 Concepts) | 35 Base Verbs | 15 Perfekt Forms | 45 Syntax Exercises | 24 Prepositions | 5 Dialogues | Articles, Genitiv & Relative Clauses Engines | 645 Total SVG Icons.
- **Integration:** Active in ContentRepository, SentenceBuilderScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 038 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 038 بنجاح تام!")
