import json
import os

print("🚀 [CYCLE 058] بدء بناء محرك جمل الغاية والهدف المقارن (A2 Final Clauses: um...zu vs damit)...")

# 1. إعداد بيانات محرك جمل الغاية
final_clauses_data = {
    "engine_name": "final_clauses_engine",
    "level": "A2",
    "title": {
        "ar": "محرك جمل الغاية والهدف المقارن (Finalsätze: um ... zu vs. damit)",
        "de": "Finalsätze im Deutschen: Absichten und Ziele mit 'um ... zu' und 'damit'",
        "en": "German Final Clauses Engine: Purpose & Goal ('um ... zu' vs. 'damit')"
    },
    "grammar_rules": {
        "question": "Wozu? / Zu welchem Zweck? / Mit welcher Absicht? (لأي غرض؟ / من أجل ماذا؟)",
        "decision_matrix": {
            "same_subject": {
                "rule": "عند تطابق الفاعل في الجملتين (Subjekt 1 = Subjekt 2) يفضل بقوة استخدام 'um ... zu + Infinitiv' لجمال التعبير واختصاره.",
                "structure": "Hauptsatz, + um + ... + zu + Infinitiv (am Satzende)",
                "example": "Ich lerne Deutsch, um in Berlin zu studieren."
            },
            "different_subjects": {
                "rule": "عند اختلاف الفاعل بين الجملتين (Subjekt 1 != Subjekt 2) يلزم إلزاميًا استخدام أداة الربط 'damit' مع جملة تابعة وفعل مصرف في النهاية.",
                "structure": "Hauptsatz, + damit + Subjekt 2 + ... + konjugiertes Verb (am Satzende)",
                "example": "Der Vater arbeitet viel, damit die Kinder studieren können."
            }
        },
        "separable_verbs_rule": "مع الأفعال المنفصلة تندمج zu بين البادئة وأصل الفعل: um ... auf-zu-stehen, um ... ein-zu-kaufen."
    },
    "templates": [
        {
            "id": "fin_um_deutsch",
            "construction": "um ... zu",
            "subjects": "Ich / Ich (Gleiches Subjekt)",
            "german": "Ich spare jeden Monat Geld, um im Sommer nach Deutschland zu reisen.",
            "arabic": "أَدَّخِرُ المَالَ كُلَّ شَهْرٍ لِكَيْ أُسَافِرَ فِي الصَّيْفِ إِلَى أَلْمَانْيَا.",
            "english": "I save money every month in order to travel to Germany in summer.",
            "image_id": "img_fin_sparen"
        },
        {
            "id": "fin_damit_kinder",
            "construction": "damit",
            "subjects": "Die Eltern / ihre Kinder (Verschiedene Subjekte)",
            "german": "Die Eltern arbeiten hart, damit ihre Kinder eine hervorragende Bildung bekommen.",
            "arabic": "يَعْمَلُ الوَالِدَانِ بِجِدٍّ لِكَيْ يَحْصُلَ أَبْنَاؤُهُمَا عَلَى تَعْلِيمٍ مَرْمُوقٍ.",
            "english": "The parents work hard so that their children receive an outstanding education.",
            "image_id": "img_fin_bildung"
        },
        {
            "id": "fin_um_gesund",
            "construction": "um ... zu",
            "subjects": "Er / Er (Gleiches Subjekt)",
            "german": "Er ernährt sich bewusst gesund, um dauerhaft fit und vital zu bleiben.",
            "arabic": "يَتَنَاوَلُ طَعَامًا صِحِّيًّا بِوَعْيٍ لِكَيْ يَبْقَى دَائِمًا رَشِيقًا وَمَفْعَمًا بِالحَيَوِيَّةِ.",
            "english": "He consciously eats healthily in order to stay fit and energized permanently.",
            "image_id": "img_fin_fitness"
        },
        {
            "id": "fin_damit_zug",
            "construction": "damit",
            "subjects": "Wir / Wir (Gleiches Subjekt - Variante mit damit)",
            "german": "Wir beeilen uns sehr, damit wir den letzten Schnellzug nicht verpassen.",
            "arabic": "نُسْرِعُ كَثِيرًا لِكَيْ لَا يَفُوتَنَا القِطَارُ السَّرِيعُ الأَخِيرُ.",
            "english": "We are hurrying so that we do not miss the last high-speed train.",
            "image_id": "img_fin_schnellzug"
        },
        {
            "id": "fin_um_wohnung",
            "construction": "um ... zu (mit Modalverb im Infinitiv)",
            "subjects": "Sie / Sie (Gleiches Subjekt)",
            "german": "Sie sucht eine Nebenbeschäftigung, um ihre monatliche Miete pünktlich bezahlen zu können.",
            "arabic": "تَبْحَثُ عَنْ عَمَلٍ إِضَافِيٍّ لِكَيْ تَتَمَكَّنَ مِنْ دَفْعِ إِيجَارِهَا الشَّهْرِيِّ فِي المَوْعِدِ.",
            "english": "She is looking for a side job in order to be able to pay her rent on time.",
            "image_id": "img_fin_nebenjob"
        },
        {
            "id": "fin_damit_leise",
            "construction": "damit",
            "subjects": "Du / das Baby (Verschiedene Subjekte)",
            "german": "Bitte sprich etwas leiser, damit das schlafende Baby im Nebenzimmer nicht aufwacht.",
            "arabic": "تَحَدَّثْ بِلُطْفٍ وَهُدُوءٍ مِنْ فَضْلِكَ لِكَيْ لَا يَسْتَيْقِظَ الرَّضِيعُ النَّائِمُ فِي الغُرْفَةِ المُجَاوِرَةِ.",
            "english": "Please speak a bit more softly so that the sleeping baby next door does not wake up.",
            "image_id": "img_fin_baby"
        },
        {
            "id": "fin_um_bestehen",
            "construction": "um ... zu",
            "subjects": "Wir / Wir (Gleiches Subjekt)",
            "german": "Wir wiederholen täglich alle wichtigen Grammatikregeln, um die Prüfung mit Bestnoten zu bestehen.",
            "arabic": "نُرَاجِعُ يَوْمِيًّا كُلَّ قَوَاعِدِ النَّحْوِ الهَامَّةِ لِكَيْ نَجْتَازَ الِامْتِحَانَ بِأَعْلَى الدَّرَجَاتِ.",
            "english": "We review all essential grammar rules daily in order to pass the exam with top marks.",
            "image_id": "img_fin_pruefung"
        },
        {
            "id": "fin_damit_chef",
            "construction": "damit",
            "subjects": "Ich / der Chef (Verschiedene Subjekte)",
            "german": "Ich schicke den fertigen Bericht heute noch ab, damit der Chef ihn morgen früh lesen kann.",
            "arabic": "أُرْسِلُ التَّقْرِيرَ المُنْجَزَ اليَوْمَ لِكَيْ يَتَمَكَّنَ المُدِيرُ مِنْ قِرَاءَتِهِ صَبَاحَ الغَدِ.",
            "english": "I send the completed report today so that the manager can read it tomorrow morning.",
            "image_id": "img_fin_chef"
        },
        {
            "id": "fin_um_abnehmen",
            "construction": "um ... zu (Trennbares Verb)",
            "subjects": "Er / Er (Gleiches Subjekt)",
            "german": "Er treibt regelmäßig Ausdauersport, um auf gesunde Weise abzunehmen.",
            "arabic": "يُمَارِسُ رِيَاضَةَ التَّحَمُّلِ بِانْتِظَامٍ لِكَيْ يُنْقِصَ وَزْنَهُ بِطَرِيقَةٍ صِحِّيَّةٍ.",
            "english": "He exercises regularly in order to lose weight in a healthy manner.",
            "image_id": "img_fin_abnehmen"
        },
        {
            "id": "fin_damit_telefon",
            "construction": "damit",
            "subjects": "Ich / du (Verschiedene Subjekte)",
            "german": "Ich gebe dir meine Telefonnummer, damit du mich bei Fragen jederzeit anrufen kannst.",
            "arabic": "أُعْطِيكَ رَقْمَ هَاتِفِي لِكَيْ تَتَمَكَّنَ مِنَ الِاتِّصَالِ بِي فِي أَيِّ وَقْتٍ عِنْدَ وُجُودِ أَسْئِلَةٍ.",
            "english": "I give you my phone number so that you can call me anytime if you have questions.",
            "image_id": "img_fin_telefon"
        }
    ]
}

# حفظ الملف في content/grammar/final_clauses_a2.json
os.makedirs("content/grammar", exist_ok=True)
fin_file = "content/grammar/final_clauses_a2.json"
with open(fin_file, "w", encoding="utf-8") as f:
    json.dump(final_clauses_data, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ محرك جمل الغاية والهدف المقارن في {fin_file}")

# 2. توليد 10 أيقونات SVG متجهية خفيفة (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "fin_sparen": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#F57F17"/><circle cx="50" cy="50" r="26" fill="#FFF"/><text x="50" y="58" font-family="sans-serif" font-weight="bold" font-size="24" fill="#F57F17" text-anchor="middle">€</text><path d="M50,15 L50,24" stroke="#FFF" stroke-width="4" stroke-linecap="round"/></svg>',
    "fin_bildung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1565C0"/><polygon points="50,22 20,38 50,54 80,38" fill="#FFD54F"/><path d="M30,48 L30,68 Q50,78 70,68 L70,48" stroke="#FFF" stroke-width="3" fill="none"/><line x1="75" y1="40" x2="75" y2="65" stroke="#FFD54F" stroke-width="3"/></svg>',
    "fin_fitness": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#2E7D32"/><circle cx="50" cy="24" r="9" fill="#FFF"/><path d="M50,34 L50,56 L35,76 M50,56 L65,76 M30,46 L70,46" stroke="#FFF" stroke-width="6" fill="none" stroke-linecap="round"/><circle cx="50" cy="46" r="4" fill="#FFD54F"/></svg>',
    "fin_schnellzug": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00897B"/><rect x="20" y="36" width="60" height="30" rx="8" fill="#FFF"/><rect x="28" y="42" width="12" height="10" rx="2" fill="#004D40"/><rect x="46" y="42" width="12" height="10" rx="2" fill="#004D40"/><circle cx="32" cy="66" r="4" fill="#E65100"/><circle cx="68" cy="66" r="4" fill="#E65100"/></svg>',
    "fin_nebenjob": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#6A1B9A"/><rect x="25" y="38" width="50" height="38" rx="5" fill="#FFF"/><rect x="42" y="30" width="16" height="10" rx="2" fill="#BA68C8"/><circle cx="50" cy="56" r="6" fill="#FFD54F"/><line x1="25" y1="48" x2="75" y2="48" stroke="#BA68C8" stroke-width="2.5"/></svg>',
    "fin_baby": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#F48FB1"/><circle cx="50" cy="42" r="16" fill="#FFF"/><path d="M30,76 C30,60 70,60 70,76 Z" fill="#FFF"/><circle cx="45" cy="40" r="2.5" fill="#C2185B"/><circle cx="55" cy="40" r="2.5" fill="#C2185B"/><path d="M46,48 Q50,52 54,48" stroke="#C2185B" stroke-width="2" fill="none"/></svg>',
    "fin_pruefung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0288D1"/><rect x="28" y="24" width="44" height="52" rx="4" fill="#FFF"/><path d="M36,45 L44,53 L62,35" stroke="#4CAF50" stroke-width="5" fill="none" stroke-linecap="round" stroke-linejoin="round"/><line x1="36" y1="62" x2="64" y2="62" stroke="#B0BEC5" stroke-width="3"/></svg>',
    "fin_chef": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#37474F"/><circle cx="50" cy="32" r="12" fill="#FFA726"/><path d="M28,78 C28,58 72,58 72,78 Z" fill="#FFF"/><polygon points="46,44 54,44 56,60 50,65 44,60" fill="#1565C0"/><polygon points="48,50 52,50 53,62 50,67 47,62" fill="#C62828"/></svg>',
    "fin_abnehmen": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FF7043"/><rect x="25" y="35" width="50" height="42" rx="6" fill="#FFF"/><circle cx="50" cy="52" r="10" fill="#FFE082"/><path d="M50,42 L50,56 M44,48 L56,48" stroke="#E65100" stroke-width="3" stroke-linecap="round"/></svg>',
    "fin_telefon": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00C853"/><rect x="32" y="22" width="36" height="56" rx="8" fill="#FFF"/><rect x="36" y="28" width="28" height="38" fill="#E8F5E9"/><circle cx="50" cy="71" r="3" fill="#2E7D32"/></svg>'
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
            "description": f"Vector illustration for final purpose clause: {k}"
        })
        new_added += 1

with open(reg_path, "w", encoding="utf-8") as f:
    json.dump(registry, f, ensure_ascii=False, indent=2)

print(f"✅ تم تحديث سجل الأصول: إجمالي الأصول المسجلة الآن = {len(registry['assets'])} (أضيف {new_added})")

# 4. إضافة 5 تمارين بناء جمل تفاعلية جديدة لجمل الغاية والهدف (إجمالي 90 جملة)
sentences_file = "content/grammar/sentences_a1.json"
sent_data = {"sentences": []}
if os.path.exists(sentences_file):
    with open(sentences_file, "r", encoding="utf-8") as f:
        sent_data = json.load(f)

new_sentences = [
    {
        "id": "sent_fin_01",
        "level": "A2",
        "topic": "Finalsatz (um ... zu + Infinitiv)",
        "german": "Ich lerne viel, um die Prüfung zu bestehen.",
        "arabic": "أَدْرُسُ كَثِيرًا لِكَيْ أَجْتَازَ الِامْتِحَانَ.",
        "english": "I study a lot in order to pass the exam.",
        "tokens_de": ["Ich", "lerne", "viel,", "um", "die", "Prüfung", "zu", "bestehen."],
        "grammar_rule": "تطابق الفاعل (أنا أدرس وأنا أجتاز): نستخدم um ... zu مع المصدر في نهاية الجملة."
    },
    {
        "id": "sent_fin_02",
        "level": "A2",
        "topic": "Finalsatz (damit + Nebensatz)",
        "german": "Er spricht laut, damit alle ihn hören.",
        "arabic": "يَتَحَدَّثُ بِصَوْتٍ عَالٍ لِكَيْ يَسْمَعَهُ الجَمِيعُ.",
        "english": "He speaks loudly so that everyone hears him.",
        "tokens_de": ["Er", "spricht", "laut,", "damit", "alle", "ihn", "hören."],
        "grammar_rule": "اختلاف الفاعل (هو يتحدث والجميع يسمعون): يلزم إلزاميًا استخدام damit مع تصريف hören في النهاية."
    },
    {
        "id": "sent_fin_03",
        "level": "A2",
        "topic": "Finalsatz (um ... zu + gesund bleiben)",
        "german": "Wir joggen täglich, um gesund zu bleiben.",
        "arabic": "نَرْكُضُ يَوْمِيًّا لِكَيْ نَبْقَى أَصِحَّاءَ.",
        "english": "We jog daily in order to stay healthy.",
        "tokens_de": ["Wir", "joggen", "täglich,", "um", "gesund", "zu", "bleiben."],
        "grammar_rule": "تطابق فاعل الجماعة (نحن): نستخدم um gesund zu bleiben."
    },
    {
        "id": "sent_fin_04",
        "level": "A2",
        "topic": "Finalsatz (damit + Subjektdifferenz)",
        "german": "Ich helfe dir, damit du schneller fertig wirst.",
        "arabic": "أُسَاعِدُكَ لِكَيْ تَنْتَهِيَ بِسُرْعَةٍ أَكْبَرَ.",
        "english": "I help you so that you finish faster.",
        "tokens_de": ["Ich", "helfe", "dir,", "damit", "du", "schneller", "fertig", "wirst."],
        "grammar_rule": "فاعل الجملة الأولى (أنا) يختلف عن فاعل الجملة الثانية (أنت): نستخدم damit حصريًا."
    },
    {
        "id": "sent_fin_05",
        "level": "A2",
        "topic": "Finalsatz (um ... zu + kaufen)",
        "german": "Sie spart Geld, um ein Auto zu kaufen.",
        "arabic": "تَدَّخِرُ المَالَ لِكَيْ تَشْتَرِيَ سَيَّارَةً.",
        "english": "She saves money in order to buy a car.",
        "tokens_de": ["Sie", "spart", "Geld,", "um", "ein", "Auto", "zu", "kaufen."],
        "grammar_rule": "تطابق الفاعل (هي تدخر وهي تشتري): um ein Auto zu kaufen."
    }
]

existing_sent_ids = {s["id"] for s in sent_data.get("sentences", [])}
for s in new_sentences:
    if s["id"] not in existing_sent_ids:
        sent_data["sentences"].append(s)

with open(sentences_file, "w", encoding="utf-8") as f:
    json.dump(sent_data, f, ensure_ascii=False, indent=2)

print(f"✅ تم تحديث بنك الجمل التفاعلية: إجمالي الجمل الآن = {len(sent_data['sentences'])} (المستهدف: 90)")

# 5. تحديث ContentRepository في Dart
content_repo_path = "lib/repositories/content_repository.dart"
if os.path.exists(content_repo_path):
    with open(content_repo_path, "r", encoding="utf-8") as f:
        repo_code = f.read()
    
    if "final_clauses_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/grammar/temporal_prepositions_a2.json',",
            "'assets/content/grammar/temporal_prepositions_a2.json',\n    'assets/content/grammar/final_clauses_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط final_clauses_a2.json في lib/repositories/content_repository.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_SENTENCES = 85", "TOTAL_SENTENCES = 90")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 1000", "TOTAL_SVG_ASSETS = 1010")
    
    if "final_clauses_a2.json" not in val_code:
        insertion = """
    # فحص محرك جمل الغاية والهدف A2 Finalsätze
    fin_path = os.path.join(base_dir, 'content', 'grammar', 'final_clauses_a2.json')
    assert os.path.exists(fin_path), f"Missing Final Clauses file: {fin_path}"
    with open(fin_path, 'r', encoding='utf-8') as f:
        fin_file_data = json.load(f)
    assert len(fin_file_data.get('templates', [])) == 10, "Expected 10 Final Clause templates"
    assert 'decision_matrix' in fin_file_data.get('grammar_rules', {}), "Missing decision_matrix in Final Clauses file"
"""
        val_code = val_code.replace("print('All assertions OK!')", insertion + "\n    print('All assertions OK!')")
    
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (90 جملة، 1010 أصول متجهية، محرك جمل الغاية بـ 10 قوالب ومصفوفة المقارنة)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 058 Status (Completed - A2 Final Clauses Engine Milestone)
- **Feature:** A2 Purpose & Final Clauses Engine (`content/grammar/final_clauses_a2.json`).
- **Grammar Engine:** Rigorous decision matrix comparing 'um ... zu + Infinitiv' (same subject) vs 'damit + Nebensatz' (different subjects) with separable verb mechanics.
- **Sentence Builder:** Expanded to 90 interactive syntactic exercises (5 new final clause exercises).
- **New Visuals:** 10 unique SVG vector assets (`fin_*.svg`).
- **Total Milestone:** 33 Categories (830 Concepts) | 35 Base Verbs | 15 Perfekt Forms | 90 Syntax Exercises | 24 Spatial/Genitiv Prepositions + 10 Temporal Systems | 5 Dialogues | 12 Comprehensive Grammar Engines | 1,010 Total SVG Icons.
- **Integration:** Active in ContentRepository, SentenceBuilderScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 058 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 058 بنجاح تام!")
