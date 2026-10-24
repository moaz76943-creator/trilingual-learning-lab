import json
import os

print("🚀 [CYCLE 047] بدء بناء محرك المصدر المقترن بـ zu (A2 Infinitiv mit zu Engine)...")

# 1. إعداد بيانات محرك Infinitiv mit zu
infinitive_data = {
    "engine_name": "infinitive_with_zu_engine",
    "level": "A2",
    "title": {
        "ar": "محرك صيغة المصدر المقترن بـ zu (Infinitiv mit zu)",
        "de": "Infinitivkonstruktionen mit zu im Deutschen",
        "en": "German Infinitive with 'zu' Engine"
    },
    "grammar_rules": {
        "structure": "Hauptsatz, + (Ergänzungen) + zu + Infinitiv (am Satzende)",
        "separable_verbs_rule": "مع الأفعال المنفصلة (Trennbare Verben)، تنحشر zu بين البادئة وجذر الفعل في كلمة واحدة: Präfix + zu + Stamm + en (z.B. einzukaufen, aufzustehen, mitzubringen).",
        "verbs_without_zu": [
            "Modalverben (können, müssen, wollen, dürfen, sollen, möchten)",
            "Bewegungsverben (gehen, fahren)",
            "Wahrnehmungsverben (sehen, hören)",
            "Sonderverben (bleiben, lassen)"
        ],
        "trigger_categories": [
            {"category": "Nomen + haben", "examples": ["Lust haben", "Zeit haben", "Angst haben", "den Plan haben", "die Absicht haben"]},
            {"category": "Es ist + Adjektiv", "examples": ["Es ist wichtig", "Es ist schön", "Es ist gesund", "Es ist schwierig", "Es ist verboten"]},
            {"category": "Spezielle Verben", "examples": ["vorhaben", "versuchen", "planen", "vergessen", "anfangen", "aufhören", "versprechen", "hoffen"]}
        ]
    },
    "templates": [
        {
            "id": "zu_kino",
            "trigger_type": "Nomen + haben (Lust)",
            "german": "Ich habe heute große Lust, mit dir ins Kino zu gehen.",
            "arabic": "لَدَيَّ رَغْبَةٌ كَبِيرَةٌ اليَوْمَ فِي الذَّهَابِ مَعَكَ إِلَى السِّينَمَا.",
            "english": "I really feel like going to the cinema with you today.",
            "image_id": "img_zu_kino"
        },
        {
            "id": "zu_vokabeln",
            "trigger_type": "Es ist + Adjektiv (wichtig)",
            "german": "Es ist sehr wichtig, täglich neue deutsche Vokabeln zu wiederholen.",
            "arabic": "مِنَ المُهِمِّ جِدًّا تِكْرَارُ المُفْرَدَاتِ الأَلْمَانِيَّةِ الجَدِيدَةِ يَوْمِيًّا.",
            "english": "It is very important to review new German vocabulary every day.",
            "image_id": "img_zu_vokabeln"
        },
        {
            "id": "zu_reise",
            "trigger_type": "Verb (vorhaben)",
            "german": "Wir haben vor, im kommenden Sommer nach Deutschland zu reisen.",
            "arabic": "نَنْوِي السَّفَرَ إِلَى أَلْمَانْيَا فِي فَصْلِ الصَّيْفِ القَادِمِ.",
            "english": "We intend to travel to Germany next summer.",
            "image_id": "img_zu_reise"
        },
        {
            "id": "zu_brot",
            "trigger_type": "Verb + Trennbar (vergessen + einkaufen)",
            "german": "Er hat leider vergessen, frisches Brot für das Abendessen einzukaufen.",
            "arabic": "لِلأَسَفِ، نَسِيَ هُوَ أَنْ يَشْتَرِيَ خُبْزًا طَازَجًا لِوَجْبَةِ العَشَاءِ.",
            "english": "Unfortunately, he forgot to buy fresh bread for dinner.",
            "image_id": "img_zu_brot"
        },
        {
            "id": "zu_wecker",
            "trigger_type": "Es ist + Adjektiv + Trennbar (schwer + aufstehen)",
            "german": "Es ist im Winter schwer für mich, frühmorgens im Dunkeln aufzustehen.",
            "arabic": "مِنَ الصَّعْبِ عَلَيَّ فِي الشِّتَاءِ الِاسْتَيْقَاظُ بَاكِرًا فِي الظَّلَامِ.",
            "english": "It is hard for me to get up early in the dark during winter.",
            "image_id": "img_zu_wecker"
        },
        {
            "id": "zu_wasser",
            "trigger_type": "Es ist + Adjektiv (gesund)",
            "german": "Es ist sehr gesund, jeden Tag mindestens zwei Liter Wasser zu trinken.",
            "arabic": "مِنَ الصِّحِّيِّ جِدًّا شُرْبُ لِتْرَيْنِ مِنَ المَاءِ عَلَى الأَقَلِّ يَوْمِيًّا.",
            "english": "It is very healthy to drink at least two liters of water every day.",
            "image_id": "img_zu_wasser"
        },
        {
            "id": "zu_flughafen",
            "trigger_type": "Nomen + haben + Trennbar (Zeit + abholen)",
            "german": "Hast du morgen Zeit, mich pünktlich vom Flughafen abzuholen?",
            "arabic": "هَلْ لَدَيْكَ وَقْتٌ غَدًا لِتَسْتَقْبِلَنِي فِي المَوْعِدِ مِنَ المَطَارِ؟",
            "english": "Do you have time tomorrow to pick me up on time from the airport?",
            "image_id": "img_zu_flughafen"
        },
        {
            "id": "zu_verstehen",
            "trigger_type": "Verb (versuchen)",
            "german": "Ich versuche geduldig, diese anspruchsvolle Grammatikregel zu verstehen.",
            "arabic": "أُحَاوِلُ بِصَبْرٍ أَنْ أَفْهَمَ هَذِهِ القَاعِدَةَ النَّحْوِيَّةَ الدَّقِيقَةَ.",
            "english": "I am patiently trying to understand this challenging grammar rule.",
            "image_id": "img_zu_verstehen"
        },
        {
            "id": "zu_gruendung",
            "trigger_type": "Verb (planen)",
            "german": "Sie plant entschlossen, bald ihr eigenes innovatives Unternehmen zu gründen.",
            "arabic": "تُخَطِّطُ بِعَزِيمَةٍ لِتَأْسِيسِ شَرِكَتِهَا الابْتِكَارِيَّةِ الخَاصَّةِ قَرِيبًا.",
            "english": "She is determinedly planning to establish her own innovative company soon.",
            "image_id": "img_zu_gruendung"
        },
        {
            "id": "zu_verbot",
            "trigger_type": "Es ist + Adjektiv (verboten)",
            "german": "Es ist gesetzlich streng verboten, in diesem öffentlichen Gebäude zu rauchen.",
            "arabic": "مَمْنُوعٌ قَانُونًا مَنْعًا بَاتًّا التَّدْخِينُ دَاخِلَ هَذَا المَبْنَى العَامِّ.",
            "english": "It is strictly legally forbidden to smoke in this public building.",
            "image_id": "img_zu_verbot"
        }
    ]
}

# حفظ الملف في content/grammar/infinitive_zu_a2.json
os.makedirs("content/grammar", exist_ok=True)
zu_file = "content/grammar/infinitive_zu_a2.json"
with open(zu_file, "w", encoding="utf-8") as f:
    json.dump(infinitive_data, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ محرك المصدر المقترن بـ zu في {zu_file}")

# 2. توليد 10 أيقونات SVG متجهية خفيفة (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "zu_kino": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="24" width="64" height="52" rx="6" fill="#D32F2F"/><polygon points="42,38 66,50 42,62" fill="#FFF"/><rect x="24" y="16" width="10" height="8" fill="#212121"/><rect x="45" y="16" width="10" height="8" fill="#212121"/><rect x="66" y="16" width="10" height="8" fill="#212121"/></svg>',
    "zu_vokabeln": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="18" width="56" height="64" rx="4" fill="#1565C0"/><rect x="28" y="26" width="44" height="48" rx="2" fill="#FFF"/><text x="50" y="46" font-family="sans-serif" font-weight="bold" font-size="14" fill="#C2185B" text-anchor="middle">A - Z</text><line x1="36" y1="56" x2="64" y2="56" stroke="#455A64" stroke-width="2.5"/><line x1="36" y1="64" x2="56" y2="64" stroke="#455A64" stroke-width="2.5"/></svg>',
    "zu_reise": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00897B"/><polygon points="50,22 62,45 88,52 65,58 68,78 50,68 32,78 35,58 12,52 38,45" fill="#FFD54F"/></svg>',
    "zu_brot": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><ellipse cx="50" cy="52" rx="34" ry="20" fill="#8D6E63"/><line x1="32" y1="45" x2="40" y2="58" stroke="#5D4037" stroke-width="3" stroke-linecap="round"/><line x1="46" y1="42" x2="54" y2="60" stroke="#5D4037" stroke-width="3" stroke-linecap="round"/><line x1="60" y1="45" x2="68" y2="58" stroke="#5D4037" stroke-width="3" stroke-linecap="round"/></svg>',
    "zu_wecker": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="54" r="30" fill="#E53935"/><circle cx="50" cy="54" r="22" fill="#FFF"/><line x1="50" y1="54" x2="50" y2="40" stroke="#212121" stroke-width="3.5" stroke-linecap="round"/><line x1="50" y1="54" x2="62" y2="54" stroke="#212121" stroke-width="3" stroke-linecap="round"/><circle cx="50" cy="54" r="3" fill="#E53935"/><polygon points="26,20 38,30 28,34" fill="#D32F2F"/><polygon points="74,20 62,30 72,34" fill="#D32F2F"/></svg>',
    "zu_wasser": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0288D1"/><path d="M50,22 C50,22 30,46 30,62 C30,74 39,82 50,82 C61,82 70,74 70,62 C70,46 50,22 50,22 Z" fill="#E1F5FE"/><circle cx="44" cy="58" r="4" fill="#0288D1"/></svg>',
    "zu_flughafen": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1565C0"/><polygon points="50,20 56,42 84,52 56,58 56,74 65,80 50,78 35,80 44,74 44,58 16,52 44,42" fill="#FFF"/></svg>',
    "zu_verstehen": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#5E35B1"/><circle cx="50" cy="42" r="18" fill="#FFEB3B"/><path d="M42,60 L58,60 L55,70 L45,70 Z" fill="#B0BEC5"/><line x1="50" y1="18" x2="50" y2="10" stroke="#FFA000" stroke-width="3" stroke-linecap="round"/></svg>',
    "zu_gruendung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#2E7D32"/><path d="M30,55 L45,35 L60,45 L75,25" stroke="#FFF" stroke-width="6" fill="none" stroke-linecap="round" stroke-linejoin="round"/><polygon points="75,25 65,25 75,35" fill="#FFF"/><circle cx="50" cy="70" r="6" fill="#FFD54F"/></svg>',
    "zu_verbot": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="36" fill="none" stroke="#D32F2F" stroke-width="8"/><line x1="26" y1="26" x2="74" y2="74" stroke="#D32F2F" stroke-width="8" stroke-linecap="round"/></svg>'
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
            "description": f"Vector illustration for infinitive with zu: {k}"
        })
        new_added += 1

with open(reg_path, "w", encoding="utf-8") as f:
    json.dump(registry, f, ensure_ascii=False, indent=2)

print(f"✅ تم تحديث سجل الأصول: إجمالي الأصول المسجلة الآن = {len(registry['assets'])} (أضيف {new_added})")

# 4. إضافة 5 تمارين بناء جمل تفاعلية جديدة لصيغة zu (إجمالي 65 جملة)
sentences_file = "content/grammar/sentences_a1.json"
sent_data = {"sentences": []}
if os.path.exists(sentences_file):
    with open(sentences_file, "r", encoding="utf-8") as f:
        sent_data = json.load(f)

new_sentences = [
    {
        "id": "sent_zu_01",
        "level": "A2",
        "topic": "Infinitiv mit zu (Nomen + haben)",
        "german": "Ich habe keine Zeit, heute zu kochen.",
        "arabic": "لَيْسَ لَدَيَّ وَقْتٌ لِلطَّبْخِ اليَوْمَ.",
        "english": "I have no time to cook today.",
        "tokens_de": ["Ich", "habe", "keine", "Zeit,", "heute", "zu", "kochen."],
        "grammar_rule": "التعبير keine Zeit haben يستدعي جملة مصدرية تنتهي بـ zu kochen."
    },
    {
        "id": "sent_zu_02",
        "level": "A2",
        "topic": "Infinitiv mit zu (Es ist + Adjektiv + trennbar)",
        "german": "Es ist schön, dich wiederzusehen.",
        "arabic": "مِنَ الجَمِيلِ رُؤْيَتُكَ مُجَدَّدًا.",
        "english": "It is wonderful to see you again.",
        "tokens_de": ["Es", "ist", "schön,", "dich", "wiederzusehen."],
        "grammar_rule": "الفعل المنفصل wiedersehen يدخل أداة zu في وسطه: wieder-zu-sehen في كلمة واحدة."
    },
    {
        "id": "sent_zu_03",
        "level": "A2",
        "topic": "Infinitiv mit zu (Verb + trennbar: einkaufen)",
        "german": "Vergiss nicht, frische Milch einzukaufen.",
        "arabic": "لَا تَنْسَ أَنْ تَشْتَرِيَ حَلِيبًا طَازَجًا.",
        "english": "Do not forget to buy fresh milk.",
        "tokens_de": ["Vergiss", "nicht,", "frische", "Milch", "einzukaufen."],
        "grammar_rule": "الفعل vergessen يستدعي المصدر بـ zu، ومع الفعل المنفصل einkaufen تصبح einzukaufen."
    },
    {
        "id": "sent_zu_04",
        "level": "A2",
        "topic": "Infinitiv mit zu (Verb: versuchen)",
        "german": "Ich versuche, morgen ganz pünktlich zu kommen.",
        "arabic": "أُحَاوِلُ أَنْ آتِيَ غَدًا فِي المَوْعِدِ تَمَامًا.",
        "english": "I am trying to arrive very punctually tomorrow.",
        "tokens_de": ["Ich", "versuche,", "morgen", "ganz", "pünktlich", "zu", "kommen."],
        "grammar_rule": "الفعل versuchen يطلب zu مع المصدر komen في نهاية العبارة."
    },
    {
        "id": "sent_zu_05",
        "level": "A2",
        "topic": "Infinitiv mit zu (Spass machen)",
        "german": "Es macht großen Spaß, Deutsch zu lernen.",
        "arabic": "مِنَ المُمْتِعِ كَثِيرًا تَعَلُّمُ اللُّغَةِ الأَلْمَانِيَّةِ.",
        "english": "It is great fun to learn German.",
        "tokens_de": ["Es", "macht", "großen", "Spaß,", "Deutsch", "zu", "lernen."],
        "grammar_rule": "التعبير Spaß machen يستوجب صياغة المصدر بـ zu lernen في ختام الجملة."
    }
]

existing_sent_ids = {s["id"] for s in sent_data.get("sentences", [])}
for s in new_sentences:
    if s["id"] not in existing_sent_ids:
        sent_data["sentences"].append(s)

with open(sentences_file, "w", encoding="utf-8") as f:
    json.dump(sent_data, f, ensure_ascii=False, indent=2)

print(f"✅ تم تحديث بنك الجمل التفاعلية: إجمالي الجمل الآن = {len(sent_data['sentences'])} (المستهدف: 65)")

# 5. تحديث ContentRepository في Dart
content_repo_path = "lib/repositories/content_repository.dart"
if os.path.exists(content_repo_path):
    with open(content_repo_path, "r", encoding="utf-8") as f:
        repo_code = f.read()
    
    if "infinitive_zu_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/grammar/conjunctions_a2.json',",
            "'assets/content/grammar/conjunctions_a2.json',\n    'assets/content/grammar/infinitive_zu_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط infinitive_zu_a2.json في lib/repositories/content_repository.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_SENTENCES = 60", "TOTAL_SENTENCES = 65")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 800", "TOTAL_SVG_ASSETS = 810")
    
    if "infinitive_zu_a2.json" not in val_code:
        insertion = """
    # فحص محرك المصدر المقترن بـ zu (A2 Infinitiv mit zu)
    zu_path = os.path.join(base_dir, 'content', 'grammar', 'infinitive_zu_a2.json')
    assert os.path.exists(zu_path), f"Missing Infinitive with zu file: {zu_path}"
    with open(zu_path, 'r', encoding='utf-8') as f:
        zu_file_data = json.load(f)
    assert len(zu_file_data.get('templates', [])) == 10, "Expected 10 Infinitive with zu templates"
    assert 'grammar_rules' in zu_file_data, "Missing grammar_rules in Infinitive with zu file"
"""
        val_code = val_code.replace("print('All assertions OK!')", insertion + "\n    print('All assertions OK!')")
    
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (65 جملة، 810 أصول متجهية، محرك Infinitiv mit zu بـ 10 قوالب)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 047 Status (Completed - A2 Infinitiv mit zu Engine Milestone)
- **Feature:** A2 Infinitive with zu Engine (`content/grammar/infinitive_zu_a2.json`).
- **Grammar Engine:** Comprehensive rules for Infinitivkonstruktionen (separable verb merging - einzukaufen, triggers: Nomen+haben, Es ist+Adjektiv, Spezielle Verben, and verbs without zu).
- **Sentence Builder:** Expanded to 65 interactive syntactic exercises (5 new infinitive with zu exercises).
- **New Visuals:** 10 unique SVG vector assets (`zu_*.svg`).
- **Total Milestone:** 27 Categories (680 Concepts) | 35 Base Verbs | 15 Perfekt Forms | 65 Syntax Exercises | 24 Prepositions | 5 Dialogues | Articles, Genitiv, Relativsätze, Konjunktiv II, Passiv, Conjunctions & Infinitiv mit zu Engines | 810 Total SVG Icons.
- **Integration:** Active in ContentRepository, SentenceBuilderScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 047 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 047 بنجاح تام!")
