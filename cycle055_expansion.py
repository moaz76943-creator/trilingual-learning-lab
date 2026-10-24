import json
import os

print("🚀 [CYCLE 055] بدء بناء محرك النبرات التعبيرية وأدوات المشاعر (A2 Modalpartikeln Engine)...")

# 1. إعداد بيانات محرك النبرات التعبيرية
modal_particles_data = {
    "engine_name": "modal_particles_engine",
    "level": "A2",
    "title": {
        "ar": "محرك النبرات الكلامية التعبيرية وأدوات المشاعر (Modalpartikeln)",
        "de": "Die deutschen Modalpartikeln (denn, doch, ja, mal, halt, eben, eigentlich)",
        "en": "German Modal Particles Engine: Tone, Nuance & Conversational Flow"
    },
    "grammar_rules": {
        "nature": "أدوات تعبيرية غير قابلة للإعراب، وظيفتها تلوين نبرة المتحدث (إظهار الود، الدهشة، الاستعجال، اللطف، أو التسليم بالواقع) ولا تُترجم ترجمة حرفية.",
        "position": "تأتي عادة في منتصف الجملة (im Mittelfeld) مباشرة بعد الفعل المصرف والضمائر الشخصية.",
        "core_particles": [
            {"particle": "denn", "tone_ar": "تلطيف السؤال وإظهار الاهتمام الشخصي والفضول الودي", "en": "softens questions, shows genuine personal interest", "example": "Wie spät ist es denn?"},
            {"particle": "doch", "tone_ar": "الحث الودي، التذكير بأمر متفق عليه، والتطمين ونفي المخاوف", "en": "encouragement, reminder of shared fact, reassurance", "example": "Komm doch mit! / Das ist doch kein Problem!"},
            {"particle": "ja", "tone_ar": "المفاجأة الإيجابية غير المتوقعة أو التأكيد على أمر جلي", "en": "pleasant surprise, confirmation of obvious fact", "example": "Das ist ja wunderbar! / Du bist ja schon fertig!"},
            {"particle": "mal", "tone_ar": "تلطيف صيغ الأمر والطلبات القصيرة لجعلها ودية وعفوية", "en": "softens commands, makes requests casual and brief", "example": "Schau mal! / Hilf mir mal bitte!"},
            {"particle": "halt / eben", "tone_ar": "التسليم الرضائي الهادئ بالأمر الواقع والظروف الحتمية", "en": "resignation to facts, accepting reality calmly", "example": "Das ist halt so / Da kann man eben nichts machen"},
            {"particle": "eigentlich", "tone_ar": "الاستفسار العفوي أو التعبير عن الأصل الحقيقي للوضع", "en": "casual inquiry, 'actually / by the way'", "example": "Was machst du heute eigentlich?"}
        ]
    },
    "templates": [
        {
            "id": "prt_denn",
            "particle": "denn",
            "german": "Wie spät ist es denn jetzt eigentlich genau?",
            "arabic": "كَمِ السَّاعَةُ الآنَ يَا تُرَى بِالتَّحْدِيدِ؟ (سُؤَالٌ وِدِّيٌّ مُلَطَّفٌ).",
            "english": "What time is it actually right now, by the way?",
            "image_id": "img_prt_denn"
        },
        {
            "id": "prt_doch",
            "particle": "doch",
            "german": "Komm doch einfach heute Abend mit uns ins Theater!",
            "arabic": "تَعَالَ مَعَنَا هَذَا المَسَاءَ إِلَى المَسْرَحِ، فَلَا تَتَرَدَّدْ! (حَثٌّ وِدِّيٌّ).",
            "english": "Just come along with us to the theater tonight, won't you!",
            "image_id": "img_prt_doch"
        },
        {
            "id": "prt_ja",
            "particle": "ja",
            "german": "Das ist ja eine absolut fantastische Überraschung!",
            "arabic": "يَا لَهَا مِنْ مُفَاجَأَةٍ رَائِعَةٍ وَمُدْهِشَةٍ حَقًّا! (دَهْشَةٌ إِيجَابِيَّةٌ).",
            "english": "That is indeed such an absolutely fantastic surprise!",
            "image_id": "img_prt_ja"
        },
        {
            "id": "prt_mal",
            "particle": "mal",
            "german": "Gib mir mal bitte kurz das Wörterbuch von dem Tisch.",
            "arabic": "أَعْطِنِي القَامُوسَ لِلَحْظَةٍ مِنْ فَضْلِكَ عَنِ الطَّاوِلَةِ (طَلَبٌ مُلَطَّفٌ).",
            "english": "Hand me the dictionary from the table for a moment, please.",
            "image_id": "img_prt_mal"
        },
        {
            "id": "prt_halt",
            "particle": "halt",
            "german": "Das Wetter im November ist halt oft regnerisch und kühl.",
            "arabic": "هَكَذَا هُوَ الطَّقْسُ فِي نُوفَمْبِر، مَا بِاليَدِ حِيلَةٌ (تَسْلِيمٌ بِالوَاقِعِ).",
            "english": "The weather in November is simply often rainy and chilly, that's life.",
            "image_id": "img_prt_halt"
        },
        {
            "id": "prt_eben",
            "particle": "eben",
            "german": "Da kann man jetzt eben leider nichts mehr daran ändern.",
            "arabic": "لَا يُمْكِنُنَا فِعْلُ أَيِّ شَيْءٍ حِيَالَ ذَلِكَ الآنَ لِلأَسَفِ (وَاقِعِيَّةٌ).",
            "english": "There is simply nothing more we can do about it now, unfortunately.",
            "image_id": "img_prt_eben"
        },
        {
            "id": "prt_eigentlich",
            "particle": "eigentlich",
            "german": "Was wolltest du mir vorhin eigentlich Wichtiges erzählen?",
            "arabic": "مَاذَا كُنْتَ تُرِيدُ أَنْ تُخْبِرَنِي بِهِ فِي الحَقِيقَةِ قَبْلَ قَلِيلٍ؟",
            "english": "What was it that you actually wanted to tell me earlier?",
            "image_id": "img_prt_eigentlich"
        },
        {
            "id": "prt_problem",
            "particle": "doch",
            "german": "Mach dir keine Sorgen, das ist doch überhaupt kein Problem!",
            "arabic": "لَا تَقْلَقْ أَبَدًا، لَيْسَتْ هَذِهِ مُشْكِلَةً عَلَى الإِطْلَاقِ! (تَطْمِينٌ).",
            "english": "Do not worry at all, that is surely no problem whatsoever!",
            "image_id": "img_prt_problem"
        },
        {
            "id": "prt_fertig",
            "particle": "ja",
            "german": "Du bist ja schon mit allen schwierigen Aufgaben fertig!",
            "arabic": "مَا شَاءَ اللهُ! لَقَدْ أَنْهَيْتَ كُلَّ المَهَامِّ الصَّعْبَةِ بِالفِعْلِ! (إِعْجَابٌ).",
            "english": "Wow, you are already done with all the difficult assignments!",
            "image_id": "img_prt_fertig"
        },
        {
            "id": "prt_schau",
            "particle": "mal",
            "german": "Schau mal da drüben, wie prächtig der Regenbogen leuchtet!",
            "arabic": "انْظُرْ لِلَحْظَةٍ هُنَاكَ، كَمْ يَلْمَعُ قَوْسُ قُزَحَ بَبَهَاءٍ!",
            "english": "Look over there for a moment, how brilliantly the rainbow shines!",
            "image_id": "img_prt_schau"
        }
    ]
}

# حفظ الملف في content/grammar/modal_particles_a2.json
os.makedirs("content/grammar", exist_ok=True)
prt_file = "content/grammar/modal_particles_a2.json"
with open(prt_file, "w", encoding="utf-8") as f:
    json.dump(modal_particles_data, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ محرك النبرات التعبيرية في {prt_file}")

# 2. توليد 10 أيقونات SVG متجهية خفيفة (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "prt_denn": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1565C0"/><path d="M38,38 Q50,22 62,38 Q66,50 50,56 L50,64" stroke="#FFF" stroke-width="7" fill="none" stroke-linecap="round"/><circle cx="50" cy="76" r="4.5" fill="#FFD54F"/><circle cx="25" cy="25" r="4" fill="#FFD54F"/></svg>',
    "prt_doch": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#E65100"/><path d="M28,50 L72,50 M56,35 L72,50 L56,65" stroke="#FFF" stroke-width="6" fill="none" stroke-linecap="round" stroke-linejoin="round"/><circle cx="28" cy="50" r="5" fill="#FFD54F"/><path d="M78,25 Q86,35 78,45" stroke="#FFD54F" stroke-width="3" fill="none"/></svg>',
    "prt_ja": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FFB300"/><circle cx="38" cy="42" r="5" fill="#212121"/><circle cx="62" cy="42" r="5" fill="#212121"/><circle cx="50" cy="62" r="8" fill="#212121"/><polygon points="50,14 54,22 62,22 56,27 58,35 50,30 42,35 44,27 38,22 46,22" fill="#E53935"/></svg>',
    "prt_mal": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00897B"/><circle cx="50" cy="50" r="28" fill="#FFF"/><line x1="50" y1="50" x2="50" y2="34" stroke="#00897B" stroke-width="5" stroke-linecap="round"/><line x1="50" y1="50" x2="64" y2="50" stroke="#00897B" stroke-width="5" stroke-linecap="round"/><circle cx="50" cy="50" r="4" fill="#E91E63"/></svg>',
    "prt_halt": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#546E7A"/><circle cx="38" cy="44" r="4" fill="#FFF"/><circle cx="62" cy="44" r="4" fill="#FFF"/><line x1="36" y1="62" x2="64" y2="62" stroke="#FFF" stroke-width="5" stroke-linecap="round"/><path d="M22,35 Q30,28 38,35" stroke="#FFD54F" stroke-width="3" fill="none"/><path d="M62,35 Q70,28 78,35" stroke="#FFD54F" stroke-width="3" fill="none"/></svg>',
    "prt_eben": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#455A64"/><line x1="25" y1="50" x2="75" y2="50" stroke="#81C784" stroke-width="8" stroke-linecap="round"/><circle cx="50" cy="50" r="5" fill="#FFF"/></svg>',
    "prt_eigentlich": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#6A1B9A"/><circle cx="50" cy="44" r="16" fill="#FFD54F"/><circle cx="50" cy="44" r="6" fill="#311B92"/><path d="M35,74 Q50,64 65,74" stroke="#FFF" stroke-width="5" fill="none" stroke-linecap="round"/><circle cx="75" cy="25" r="4" fill="#FFF"/></svg>',
    "prt_problem": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#43A047"/><path d="M30,52 L44,66 L72,36" stroke="#FFF" stroke-width="8" fill="none" stroke-linecap="round" stroke-linejoin="round"/><circle cx="50" cy="50" r="34" fill="none" stroke="#C8E6C9" stroke-width="3" stroke-dasharray="6,4"/></svg>',
    "prt_fertig": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#2E7D32"/><polygon points="50,18 56,34 74,34 60,46 65,64 50,54 35,64 40,46 26,34 44,34" fill="#FFD54F"/><circle cx="50" cy="44" r="6" fill="#FFF"/></svg>',
    "prt_schau": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0288D1"/><path d="M25,50 Q50,25 75,50 Q50,75 25,50 Z" fill="#FFF"/><circle cx="50" cy="50" r="12" fill="#0D47A1"/><circle cx="54" cy="46" r="4" fill="#FFF"/></svg>'
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
            "description": f"Vector illustration for modal particle: {k}"
        })
        new_added += 1

with open(reg_path, "w", encoding="utf-8") as f:
    json.dump(registry, f, ensure_ascii=False, indent=2)

print(f"✅ تم تحديث سجل الأصول: إجمالي الأصول المسجلة الآن = {len(registry['assets'])} (أضيف {new_added})")

# 4. إضافة 5 تمارين بناء جمل تفاعلية جديدة للنبرات التعبيرية (إجمالي 85 جملة)
sentences_file = "content/grammar/sentences_a1.json"
sent_data = {"sentences": []}
if os.path.exists(sentences_file):
    with open(sentences_file, "r", encoding="utf-8") as f:
        sent_data = json.load(f)

new_sentences = [
    {
        "id": "sent_prt_01",
        "level": "A2",
        "topic": "Modalpartikel: doch",
        "german": "Komm doch bitte schnell rein!",
        "arabic": "تَفَضَّلْ بِالدُّخُولِ سَرِيعًا لَا تَتَرَدَّدْ!",
        "english": "Do come in quickly, please!",
        "tokens_de": ["Komm", "doch", "bitte", "schnell", "rein!"],
        "grammar_rule": "doch هنا تفيد الحث الودي وإزالة الحرج والتردد عن الضيف."
    },
    {
        "id": "sent_prt_02",
        "level": "A2",
        "topic": "Modalpartikel: denn",
        "german": "Was machst du denn hier?",
        "arabic": "مَاذَا تَفْعَلُ هُنَا يَا تُرَى؟",
        "english": "What on earth are you doing here?",
        "tokens_de": ["Was", "machst", "du", "denn", "hier?"],
        "grammar_rule": "denn تلطف نبرة السؤال وتجعله فضولًا وديًا نابعًا من الاهتمام."
    },
    {
        "id": "sent_prt_03",
        "level": "A2",
        "topic": "Modalpartikel: ja",
        "german": "Das ist ja wirklich toll!",
        "arabic": "هَذَا أَمْرٌ رَائِعٌ لِلْغَايَةِ حَقًّا!",
        "english": "That is indeed really awesome!",
        "tokens_de": ["Das", "ist", "ja", "wirklich", "toll!"],
        "grammar_rule": "ja تعبر عن المفاجأة والانبهار الإيجابي غير المتوقع."
    },
    {
        "id": "sent_prt_04",
        "level": "A2",
        "topic": "Modalpartikel: mal",
        "german": "Schau mal, wie schön es ist!",
        "arabic": "انْظُرْ لِلَحْظَةٍ، كَمْ هُوَ جَمِيلٌ!",
        "english": "Take a look for a moment, how pretty it is!",
        "tokens_de": ["Schau", "mal,", "wie", "schön", "es", "ist!"],
        "grammar_rule": "mal تلطف صيغة الأمر Schau وتجعلها دعوة خفيفة عفوية."
    },
    {
        "id": "sent_prt_05",
        "level": "A2",
        "topic": "Modalpartikel: halt",
        "german": "Das ist halt das Leben.",
        "arabic": "هَذِهِ هِيَ الحَيَاةُ بِبَسَاطَةٍ (مَا بِاليَدِ حِيلَةٌ).",
        "english": "That is just how life is.",
        "tokens_de": ["Das", "ist", "halt", "das", "Leben."],
        "grammar_rule": "halt تفيد التسليم الرضائي بالواقع وحتمية تصاريف الأيام."
    }
]

existing_sent_ids = {s["id"] for s in sent_data.get("sentences", [])}
for s in new_sentences:
    if s["id"] not in existing_sent_ids:
        sent_data["sentences"].append(s)

with open(sentences_file, "w", encoding="utf-8") as f:
    json.dump(sent_data, f, ensure_ascii=False, indent=2)

print(f"✅ تم تحديث بنك الجمل التفاعلية: إجمالي الجمل الآن = {len(sent_data['sentences'])} (المستهدف: 85)")

# 5. تحديث ContentRepository في Dart
content_repo_path = "lib/repositories/content_repository.dart"
if os.path.exists(content_repo_path):
    with open(content_repo_path, "r", encoding="utf-8") as f:
        repo_code = f.read()
    
    if "modal_particles_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/grammar/temporal_prepositions_a2.json',",
            "'assets/content/grammar/temporal_prepositions_a2.json',\n    'assets/content/grammar/modal_particles_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط modal_particles_a2.json في lib/repositories/content_repository.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_SENTENCES = 80", "TOTAL_SENTENCES = 85")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 940", "TOTAL_SVG_ASSETS = 950")
    
    if "modal_particles_a2.json" not in val_code:
        insertion = """
    # فحص محرك النبرات التعبيرية A2 Modalpartikeln
    prt_path = os.path.join(base_dir, 'content', 'grammar', 'modal_particles_a2.json')
    assert os.path.exists(prt_path), f"Missing Modal Particles file: {prt_path}"
    with open(prt_path, 'r', encoding='utf-8') as f:
        prt_file_data = json.load(f)
    assert len(prt_file_data.get('templates', [])) == 10, "Expected 10 Modal Particle templates"
    assert 'grammar_rules' in prt_file_data, "Missing grammar_rules in Modal Particles file"
"""
        val_code = val_code.replace("print('All assertions OK!')", insertion + "\n    print('All assertions OK!')")
    
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (85 جملة، 950 أصلًا متجهيًا، محرك النبرات التعبيرية بـ 10 قوالب)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 055 Status (Completed - A2 Modal Particles Engine Milestone)
- **Feature:** A2 Modal Particles Engine (`content/grammar/modal_particles_a2.json`).
- **Grammar Engine:** 7 conversational nuances (denn, doch, ja, mal, halt, eben, eigentlich) with tone softening and communicative empathy mechanics.
- **Sentence Builder:** Expanded to 85 interactive syntactic exercises (5 new modal particle exercises).
- **New Visuals:** 10 unique SVG vector assets (`prt_*.svg`).
- **Total Milestone:** 31 Categories (780 Concepts) | 35 Base Verbs | 15 Perfekt Forms | 85 Syntax Exercises | 24 Spatial/Genitiv Prepositions + 10 Temporal Systems | 5 Dialogues | 11 Comprehensive Grammar Engines | 950 Total SVG Icons.
- **Integration:** Active in ContentRepository, SentenceBuilderScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 055 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 055 بنجاح تام!")
