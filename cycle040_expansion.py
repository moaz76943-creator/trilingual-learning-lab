import json
import os

print("🚀 [CYCLE 040] بدء بناء محرك صيغة الرجاء والطلب المهذب (A2 Konjunktiv II Engine)...")

# 1. إعداد بيانات محرك Konjunktiv II
konjunktiv_data = {
    "engine_name": "konjunktiv_ii_engine",
    "level": "A2",
    "title": {
        "ar": "محرك صيغة الرجاء والطلب المهذب والأمنيات (Konjunktiv II)",
        "de": "Der Konjunktiv II: Höflichkeit, Wünsche und Ratschläge",
        "en": "German Subjunctive II Engine: Politeness, Wishes & Advice"
    },
    "grammar_rules": {
        "usage_pillars": [
            {"topic": "Höfliche Bitte / Frage", "ar": "الطلب المهذب والاستئذان اللبق", "example": "Könnten Sie mir bitte helfen? / Würden Sie bitte die Tür schließen?"},
            {"topic": "Wünsche und Träume", "ar": "الأمنيات والرغبات غير المحققة", "example": "Ich wäre gern im Urlaub. / Ich hätte gern mehr Freizeit."},
            {"topic": "Ratschläge und Empfehlungen", "ar": "إسداء النصائح والمقترحات الودية", "example": "Du solltest mehr schlafen. / Du müsstest zum Arzt gehen."},
            {"topic": "Irreale Bedingungen", "ar": "الجمل الشرطية الافتراضية (لو... لـ...)", "example": "Wenn ich reich wäre, würde ich um die Welt reisen."}
        ],
        "formation_rule": "يصاغ Konjunktiv II بإضافة الـ Umlaut إلى جذر الماضي البسيط (Präteritum) مع نهايات المضارع، أو باستخدام الصيغة الأكثر شيوعًا: würde + Infinitiv am Satzende."
    },
    "verbs_table": {
        "sein (wäre)": {
            "ich": "wäre", "du": "wärst", "er/sie/es": "wäre",
            "wir": "wären", "ihr": "wärt", "sie/Sie": "wären",
            "ar": "لو كُنْتُ / كُنْتُ لِأَكُونَ", "en": "would be / were"
        },
        "haben (hätte)": {
            "ich": "hätte", "du": "hättest", "er/sie/es": "hätte",
            "wir": "hätten", "ihr": "hättet", "sie/Sie": "hätten",
            "ar": "لو امْتَلَكْتُ / لَكَانَ لَدَيَّ", "en": "would have / had"
        },
        "werden (würde + Infinitiv)": {
            "ich": "würde", "du": "würdest", "er/sie/es": "würde",
            "wir": "würden", "ihr": "würdet", "sie/Sie": "würden",
            "ar": "كُنْتُ لِأَفْعَلَ (لِصِيَاغَةِ الأَفْعَالِ الأُخْرَى)", "en": "would do"
        },
        "können (könnte)": {
            "ich": "könnte", "du": "könntest", "er/sie/es": "könnte",
            "wir": "könnten", "ihr": "könntet", "sie/Sie": "könnten",
            "ar": "هَلْ يُمْكِنُكَ / لَاسْتَطَعْتُ", "en": "could / would be able to"
        },
        "sollen (sollte)": {
            "ich": "sollte", "du": "solltest", "er/sie/es": "sollte",
            "wir": "sollten", "ihr": "solltet", "sie/Sie": "sollten",
            "ar": "يَنْبَغِي عَلَيْكَ / يَجْدُرُ بِكَ", "en": "should / ought to"
        },
        "müssen (müsste)": {
            "ich": "müsste", "du": "müsstest", "er/sie/es": "müsste",
            "wir": "müssten", "ihr": "müsstet", "sie/Sie": "müssten",
            "ar": "كَانَ يَلْزَمُ أَنْ / يَتَوَجَّبُ", "en": "would have to"
        }
    },
    "templates": [
        {
            "id": "k2_waere",
            "category": "Wunsch",
            "german": "Ich wäre jetzt so gern im Urlaub am Meer.",
            "arabic": "أَوَدُّ كَثِيرًا لَوْ كُنْتُ الآنَ فِي عُطْلَةٍ عَلَى شَاطِئِ البَحْرِ.",
            "english": "I wish I were on vacation by the sea right now.",
            "image_id": "img_k2_waere"
        },
        {
            "id": "k2_haette",
            "category": "Höfliche Bestellung",
            "german": "Ich hätte gern eine Tasse frischen Pfefferminztee.",
            "arabic": "أَوَدُّ لَوْ أَحْصُلُ عَلَى كُوبٍ مِنْ شَايِ النَّعْنَاعِ الطَّازَجِ (طَلَبٌ مُهَذَّبٌ).",
            "english": "I would like to have a fresh cup of peppermint tea.",
            "image_id": "img_k2_haette"
        },
        {
            "id": "k2_wuerde",
            "category": "Interesse",
            "german": "Ich würde gern eine neue Fremdsprache lernen.",
            "arabic": "أَوَدُّ كَثِيرًا لَوْ أَتَعَلَّمُ لُغَةً أَجْنَبِيَّةً جَدِيدَةً.",
            "english": "I would love to learn a new foreign language.",
            "image_id": "img_k2_wuerde"
        },
        {
            "id": "k2_koennte",
            "category": "Höfliche Frage",
            "german": "Könnten Sie mir bitte den Weg zum Bahnhof erklären?",
            "arabic": "هَلْ يُمْكِنُكَ مِنْ فَضْلِكَ أَنْ تَشْرَحَ لِي الطَّرِيقَ إِلَى مَحَطَّةِ القِطَارِ؟",
            "english": "Could you please explain the way to the train station to me?",
            "image_id": "img_k2_koennte"
        },
        {
            "id": "k2_sollte",
            "category": "Ratschlag",
            "german": "Du solltest dich nach dem langen Arbeitstag etwas ausruhen.",
            "arabic": "يَنْبَغِي عَلَيْكَ أَنْ تَنَالَ قِسْطًا مِنَ الرَّاحَةِ بَعْدَ يَوْمِ العَمَلِ الطَّوِيلِ.",
            "english": "You should get some rest after the long workday.",
            "image_id": "img_k2_sollte"
        },
        {
            "id": "k2_muesste",
            "category": "Notwendigkeit",
            "german": "Er müsste eigentlich heute für seine Prüfung lernen.",
            "arabic": "كَانَ يَلْزَمُ أَنْ يَدْرُسَ هُوَ فِي الحَقِيقَةِ اليَوْمَ لِامْتِحَانِهِ.",
            "english": "He really ought to be studying for his exam today.",
            "image_id": "img_k2_muesste"
        },
        {
            "id": "k2_fenster",
            "category": "Höfliche Bitte",
            "german": "Würdest du bitte das Fenster kurz öffnen?",
            "arabic": "هَلْ تَتَفَضَّلُ بِفَتْحِ النَّافِذَةِ قَلِيلًا مِنْ فَضْلِكَ؟",
            "english": "Would you please open the window for a moment?",
            "image_id": "img_k2_fenster"
        },
        {
            "id": "k2_wenn_zeit",
            "category": "Irreale Bedingung",
            "german": "Wenn ich mehr Freizeit hätte, würde ich dich öfter besuchen.",
            "arabic": "لَوْ كَانَ لَدَيَّ مَزِيدٌ مِنَ الفَرَاغِ، لَزُرْتُكَ كَثِيرًا.",
            "english": "If I had more free time, I would visit you more often.",
            "image_id": "img_k2_wenn_zeit"
        },
        {
            "id": "k2_wenn_reich",
            "category": "Irreale Bedingung",
            "german": "Wenn wir reich wären, würden wir bedürftigen Menschen helfen.",
            "arabic": "لَوْ كُنَّا أَثْرِيَاءَ، لَسَاعَدْنَا كُلَّ الم Needful.",
            "english": "If we were rich, we would help people in need.",
            "image_id": "img_k2_wenn_reich"
        },
        {
            "id": "k2_treffen",
            "category": "Höfliche Absprache",
            "german": "Könnten wir den Termin auf morgen verschieben?",
            "arabic": "هَلْ يُمْكِنُنَا تَأْجِيلُ المَوْعِدِ إِلَى الغَدِ؟",
            "english": "Could we possibly reschedule the appointment to tomorrow?",
            "image_id": "img_k2_treffen"
        }
    ]
}

# حفظ الملف في content/grammar/konjunktiv_ii_a2.json
os.makedirs("content/grammar", exist_ok=True)
k2_file = "content/grammar/konjunktiv_ii_a2.json"
with open(k2_file, "w", encoding="utf-8") as f:
    json.dump(konjunktiv_data, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ محرك صيغة الرجاء والطلب المهذب في {k2_file}")

# 2. توليد 10 أيقونات SVG متجهية خفيفة (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "k2_waere": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00ACC1"/><circle cx="50" cy="38" r="14" fill="#FFCA28"/><path d="M20,75 Q50,60 80,75" stroke="#FFF" stroke-width="6" fill="none" stroke-linecap="round"/><path d="M50,15 C40,25 35,30 50,30" stroke="#FFF" stroke-width="3" fill="none"/></svg>',
    "k2_haette": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#5E35B1"/><rect x="30" y="40" width="40" height="32" rx="6" fill="#FFF"/><path d="M70,48 C78,48 78,64 70,64" fill="none" stroke="#FFF" stroke-width="5" stroke-linecap="round"/><path d="M42,32 Q46,22 42,16 M52,32 Q56,22 52,16" stroke="#FFD54F" stroke-width="3" fill="none" stroke-linecap="round"/></svg>',
    "k2_wuerde": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#43A047"/><path d="M30,55 L45,35 L60,45 L75,25" stroke="#FFF" stroke-width="6" fill="none" stroke-linecap="round" stroke-linejoin="round"/><polygon points="75,25 65,25 75,35" fill="#FFF"/><polygon points="50,68 53,75 60,75 55,80 57,87 50,83 43,87 45,80 40,75 47,75" fill="#FFD54F"/></svg>',
    "k2_koennte": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1E88E5"/><path d="M35,45 Q50,30 65,45 Q70,55 58,60 L58,66" stroke="#FFF" stroke-width="7" fill="none" stroke-linecap="round"/><circle cx="58" cy="76" r="4.5" fill="#FFF"/><polygon points="25,48 30,53 35,43" fill="#FFD54F"/></svg>',
    "k2_sollte": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FB8C00"/><rect x="46" y="24" width="8" height="32" rx="3" fill="#FFF"/><circle cx="50" cy="68" r="5" fill="#FFF"/><circle cx="50" cy="50" r="34" fill="none" stroke="#FFF" stroke-width="3" stroke-dasharray="6,4"/></svg>',
    "k2_muesste": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#E53935"/><circle cx="50" cy="50" r="28" fill="#FFF"/><line x1="50" y1="50" x2="50" y2="32" stroke="#E53935" stroke-width="5" stroke-linecap="round"/><line x1="50" y1="50" x2="65" y2="50" stroke="#E53935" stroke-width="4" stroke-linecap="round"/><circle cx="50" cy="50" r="4" fill="#E53935"/></svg>',
    "k2_fenster": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="20" width="60" height="60" rx="4" fill="#ECEFF1" stroke="#455A64" stroke-width="4"/><line x1="50" y1="20" x2="50" y2="80" stroke="#455A64" stroke-width="4"/><line x1="20" y1="50" x2="80" y2="50" stroke="#455A64" stroke-width="4"/><path d="M50,50 L75,35" stroke="#00BCD4" stroke-width="4" fill="none" stroke-linecap="round"/></svg>',
    "k2_wenn_zeit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="50" r="25" fill="#37474F"/><line x1="45" y1="50" x2="45" y2="35" stroke="#FFD54F" stroke-width="3"/><line x1="45" y1="50" x2="58" y2="50" stroke="#FFD54F" stroke-width="3"/><path d="M60,40 Q75,30 85,45 Q75,60 60,50" stroke="#4CAF50" stroke-width="4" fill="none" stroke-linecap="round"/></svg>',
    "k2_wenn_reich": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FFB300"/><circle cx="50" cy="50" r="28" fill="#FFA000"/><text x="50" y="60" font-family="sans-serif" font-weight="bold" font-size="28" fill="#FFF" text-anchor="middle">€</text><polygon points="75,25 78,32 85,32 80,36 82,43 75,39 68,43 70,36 65,32 72,32" fill="#FFF"/></svg>',
    "k2_treffen": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="36" cy="38" r="14" fill="#42A5F5"/><circle cx="64" cy="38" r="14" fill="#66BB6A"/><path d="M18,80 C18,62 54,62 54,80 Z" fill="#1976D2"/><path d="M46,80 C46,62 82,62 82,80 Z" fill="#388E3C"/><path d="M40,55 L60,55 M55,48 L62,55 L55,62" stroke="#FFD54F" stroke-width="4" fill="none" stroke-linecap="round"/></svg>'
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
            "description": f"Vector illustration for Konjunktiv II: {k}"
        })
        new_added += 1

with open(reg_path, "w", encoding="utf-8") as f:
    json.dump(registry, f, ensure_ascii=False, indent=2)

print(f"✅ تم تحديث سجل الأصول: إجمالي الأصول المسجلة الآن = {len(registry['assets'])} (أضيف {new_added})")

# 4. إضافة 5 تمارين بناء جمل تفاعلية جديدة لصيغة Konjunktiv II (إجمالي 50 جملة - نصف مئة تمرين)
sentences_file = "content/grammar/sentences_a1.json"
sent_data = {"sentences": []}
if os.path.exists(sentences_file):
    with open(sentences_file, "r", encoding="utf-8") as f:
        sent_data = json.load(f)

new_sentences = [
    {
        "id": "sent_k2_01",
        "level": "A2",
        "topic": "Konjunktiv II: Höfliche Bitte (könnten)",
        "german": "Könnten Sie mir bitte helfen?",
        "arabic": "هَلْ يُمْكِنُكَ أَنْ تُسَاعِدَنِي مِنْ فَضْلِكَ؟",
        "english": "Could you please help me?",
        "tokens_de": ["Könnten", "Sie", "mir", "bitte", "helfen?"],
        "grammar_rule": "يبدأ الطلب المهذب بفعل Könnten، ويستقر المصدر helfen في نهاية الجملة."
    },
    {
        "id": "sent_k2_02",
        "level": "A2",
        "topic": "Konjunktiv II: Wunsch / Bestellung (hätte)",
        "german": "Ich hätte gern einen Kaffee.",
        "arabic": "أَوَدُّ لَوْ أَحْصُلُ عَلَى فِنْجَانِ قَهْوَةٍ مِنْ فَضْلِكَ.",
        "english": "I would like to have a coffee.",
        "tokens_de": ["Ich", "hätte", "gern", "einen", "Kaffee."],
        "grammar_rule": "hätte gern هي صيغة الطلب المهذب الأكثر أناقة وشيوعًا في المطاعم والمقاهي."
    },
    {
        "id": "sent_k2_03",
        "level": "A2",
        "topic": "Konjunktiv II: Wunsch (wäre)",
        "german": "Ich wäre jetzt gern am Meer.",
        "arabic": "أَوَدُّ لَوْ كُنْتُ الآنَ عَلَى شَاطِئِ البَحْرِ.",
        "english": "I wish I were by the sea right now.",
        "tokens_de": ["Ich", "wäre", "jetzt", "gern", "am", "Meer."],
        "grammar_rule": "الفعل wäre يعبر عن رغبة أو أمنية غير محققة في اللحظة الراهنة."
    },
    {
        "id": "sent_k2_04",
        "level": "A2",
        "topic": "Konjunktiv II: Höfliche Aufforderung (würdest)",
        "german": "Würdest du bitte leise sein?",
        "arabic": "هَلْ تَتَفَضَّلُ بِأَنْ تَكُونَ هَادِئًا مِنْ فَضْلِكَ؟",
        "english": "Would you please be quiet?",
        "tokens_de": ["Würdest", "du", "bitte", "leise", "sein?"],
        "grammar_rule": "صيغة würde + Infinitiv (sein) تُستخدم لطلب الهدوء بأقصى درجات اللباقة والتهذيب."
    },
    {
        "id": "sent_k2_05",
        "level": "A2",
        "topic": "Konjunktiv II: Ratschlag (solltest)",
        "german": "Du solltest zum Arzt gehen.",
        "arabic": "يَنْبَغِي عَلَيْكَ الذَّهَابُ إِلَى الطَّبِيبِ (نَصِيحَةٌ وِدِّيَّةٌ).",
        "english": "You should definitely go to the doctor.",
        "tokens_de": ["Du", "solltest", "zum", "Arzt", "gehen."],
        "grammar_rule": "solltest تفيد تقديم النصيحة الودية الرقيقة مقارنة بـ musst الإلزامية."
    }
]

existing_sent_ids = {s["id"] for s in sent_data.get("sentences", [])}
for s in new_sentences:
    if s["id"] not in existing_sent_ids:
        sent_data["sentences"].append(s)

with open(sentences_file, "w", encoding="utf-8") as f:
    json.dump(sent_data, f, ensure_ascii=False, indent=2)

print(f"✅ تم تحديث بنك الجمل التفاعلية: إجمالي الجمل الآن = {len(sent_data['sentences'])} (المستهدف: 50)")

# 5. تحديث ContentRepository في Dart
content_repo_path = "lib/repositories/content_repository.dart"
if os.path.exists(content_repo_path):
    with open(content_repo_path, "r", encoding="utf-8") as f:
        repo_code = f.read()
    
    if "konjunktiv_ii_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/grammar/relative_clauses_a2.json',",
            "'assets/content/grammar/relative_clauses_a2.json',\n    'assets/content/grammar/konjunktiv_ii_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط konjunktiv_ii_a2.json في lib/repositories/content_repository.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_SENTENCES = 45", "TOTAL_SENTENCES = 50")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 670", "TOTAL_SVG_ASSETS = 680")
    
    if "konjunktiv_ii_a2.json" not in val_code:
        insertion = """
    # فحص محرك صيغة الرجاء والطلب المهذب A2 Konjunktiv II
    k2_path = os.path.join(base_dir, 'content', 'grammar', 'konjunktiv_ii_a2.json')
    assert os.path.exists(k2_path), f"Missing Konjunktiv II file: {k2_path}"
    with open(k2_path, 'r', encoding='utf-8') as f:
        k2_file_data = json.load(f)
    assert len(k2_file_data.get('templates', [])) == 10, "Expected 10 Konjunktiv II templates"
    assert len(k2_file_data.get('verbs_table', {})) == 6, "Expected 6 Konjunktiv II verbs"
"""
        val_code = val_code.replace("print('All assertions OK!')", insertion + "\n    print('All assertions OK!')")
    
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (50 جملة، 680 أصلًا متجهيًا، محرك Konjunktiv II كامل بـ 6 أفعال و10 قوالب)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 040 Status (Completed - A2 Konjunktiv II Engine Milestone)
- **Feature:** A2 Konjunktiv II Engine (`content/grammar/konjunktiv_ii_a2.json`).
- **Grammar Engine:** 6 core verbs conjugated in subjunctive II (wäre, hätte, würde, könnte, sollte, müsste) with politeness and hypothetical condition rules.
- **Sentence Builder:** Expanded to 50 interactive syntactic exercises (Crossed half-hundred sentence milestone).
- **New Visuals:** 10 unique SVG vector assets (`k2_*.svg`).
- **Total Milestone:** 23 Categories (580 Concepts) | 35 Base Verbs | 15 Perfekt Forms | 50 Syntax Exercises | 24 Prepositions | 5 Dialogues | Articles, Genitiv, Relativsätze & Konjunktiv II Engines | 680 Total SVG Icons.
- **Integration:** Active in ContentRepository, SentenceBuilderScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 040 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 040 بنجاح تام!")
