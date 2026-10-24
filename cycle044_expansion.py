import json
import os

print("🚀 [CYCLE 044] بدء بناء قسم الفلسفة والمنطق والتفكير النقدي (Philosophy & Logic - A2)...")

# 1. قائمة الـ 25 مفهومًا لقسم الفلسفة والمنطق
concepts = [
    {
        "id": "phi_philosophie",
        "category": "philosophy_logic",
        "arabic": {"word": "الفَلْسَفَةُ / حُبُّ الحِكْمَةِ", "transliteration": "Al-Falsafah", "notes": "البحث في الأسئلة الجوهرية للوجود والمعرفة والأخلاق"},
        "german": {"article": "die", "word": "Philosophie", "plural": "die Philosophien", "gender": "feminine", "example": "Die antike Philosophie sucht nach den Ursprüngen des Seins."},
        "english": {"word": "philosophy", "phonetic": "/fɪˈlɒs.ə.fi/", "example": "Classical philosophy examines the fundamental nature of reality."},
        "image_id": "img_phi_philosophie"
    },
    {
        "id": "phi_logik",
        "category": "philosophy_logic",
        "arabic": {"word": "المَنْطِقُ", "transliteration": "Al-Mantiq", "notes": "قواعد التفكير السليم والاستدلال الصحيح"},
        "german": {"article": "die", "word": "Logik", "plural": "die Logiken", "gender": "feminine", "example": "Die strenge Logik verhindert fehlerhafte Schlussfolgerungen."},
        "english": {"word": "logic", "phonetic": "/ˈlɒdʒ.ɪk/", "example": "Sound formal logic ensures valid deductions and reasoning."},
        "image_id": "img_phi_logik"
    },
    {
        "id": "phi_gedanke",
        "category": "philosophy_logic",
        "arabic": {"word": "الفِكْرَةُ / الخَاطِرَةُ", "transliteration": "Al-Fikrah", "notes": "النتاج الذهني الواعي (اسم مذكر شاذ يتبع N-Deklination مع s في الإضافة)"},
        "german": {"article": "der", "word": "Gedanke", "plural": "die Gedanken", "gender": "masculine (des Gedankens)", "example": "Ein tiefer Gedanke inspirierte die gesamte Forschungsgruppe."},
        "english": {"word": "thought / idea", "phonetic": "/θɔːt/", "example": "A profound philosophical thought reshaped his worldview."},
        "image_id": "img_phi_gedanke"
    },
    {
        "id": "phi_vernunft",
        "category": "philosophy_logic",
        "arabic": {"word": "العَقْلُ / الرُّشْدُ", "transliteration": "Al-'Aql", "notes": "ملكة الإدراك والتمييز الرشيد بين الصواب والخطأ"},
        "german": {"article": "die", "word": "Vernunft", "plural": "die Vernünfte", "gender": "feminine", "example": "Die Vernunft leitet den Menschen zu besonnenem Handeln."},
        "english": {"word": "reason / rationality", "phonetic": "/ˈriː.zən/", "example": "Human reason guides objective judgment in complex dilemmas."},
        "image_id": "img_phi_vernunft"
    },
    {
        "id": "phi_wahrheit",
        "category": "philosophy_logic",
        "arabic": {"word": "الحَقِيقَةُ", "transliteration": "Al-Haqeeqah", "notes": "المطابقة التامة للواقع والصدق المعرفي"},
        "german": {"article": "die", "word": "Wahrheit", "plural": "die Wahrheiten", "gender": "feminine", "example": "Wissenschaftler und Philosophen streben unermüdlich nach der Wahrheit."},
        "english": {"word": "truth", "phonetic": "/truːθ/", "example": "Honest intellectual inquiry relentlessly pursues objective truth."},
        "image_id": "img_phi_wahrheit"
    },
    {
        "id": "phi_realitaet",
        "category": "philosophy_logic",
        "arabic": {"word": "الوَاقِعُ / الحَقِيقَةُ العَيْنِيَّةُ", "transliteration": "Al-Waqi'", "notes": "ما هو موجود بالفعل ومتحقق خارج الذهن"},
        "german": {"article": "die", "word": "Realität", "plural": "die Realitäten", "gender": "feminine", "example": "Manchmal weicht die subjektive Wahrnehmung von der objektiven Realität ab."},
        "english": {"word": "reality", "phonetic": "/riˈæl.ə.ti/", "example": "Critical thinking helps distinguish illusion from concrete reality."},
        "image_id": "img_phi_realitaet"
    },
    {
        "id": "phi_erkenntnis",
        "category": "philosophy_logic",
        "arabic": {"word": "المَعْرِفَةُ / الإِدْرَاكُ", "transliteration": "Al-Ma'rifah", "notes": "الوصول إلى الفهم العميق للحقائق"},
        "german": {"article": "die", "word": "Erkenntnis", "plural": "die Erkenntnisse", "gender": "feminine", "example": "Neue wissenschaftliche Erkenntnisse erweitern unseren Horizont."},
        "english": {"word": "knowledge / insight", "phonetic": "/ˈnɒl.ɪdʒ/", "example": "Philosophical insight illuminates the complexities of human nature."},
        "image_id": "img_phi_erkenntnis"
    },
    {
        "id": "phi_weisheit",
        "category": "philosophy_logic",
        "arabic": {"word": "الحِكْمَةُ", "transliteration": "Al-Hikmah", "notes": "وضع الأمور في مواضعها وحسن التصرف بالمعرفة"},
        "german": {"article": "die", "word": "Weisheit", "plural": "die Weisheiten", "gender": "feminine", "example": "Weisheit wächst durch Lebenserfahrung und ständige Reflexion."},
        "english": {"word": "wisdom", "phonetic": "/ˈwɪz.dəm/", "example": "True wisdom combines extensive experience with ethical restraint."},
        "image_id": "img_phi_weisheit"
    },
    {
        "id": "phi_argument",
        "category": "philosophy_logic",
        "arabic": {"word": "الحُجَّةُ / البُرْهَانُ", "transliteration": "Al-Hujjah", "notes": "الدليل المنطقي الداعم للرأي أو النظرية"},
        "german": {"article": "das", "word": "Argument", "plural": "die Argumente", "gender": "neuter", "example": "Er untermauerte seine These mit einem stichhaltigen Argument."},
        "english": {"word": "argument", "phonetic": "/ˈɑːɡ.jə.mənt/", "example": "She presented a compelling and well-grounded argument."},
        "image_id": "img_phi_argument"
    },
    {
        "id": "phi_beweis",
        "category": "philosophy_logic",
        "arabic": {"word": "الدَّلِيلُ / الإِثْبَاتُ", "transliteration": "Ad-Daleel", "notes": "البرهان القاطع الذي ينفي الشك"},
        "german": {"article": "der", "word": "Beweis", "plural": "die Beweise", "gender": "masculine", "example": "Für diese mathematische Behauptung gibt es einen exakten Beweis."},
        "english": {"word": "proof / evidence", "phonetic": "/pruːf/", "example": "Empirical evidence is mandatory to substantiate the scientific claim."},
        "image_id": "img_phi_beweis"
    },
    {
        "id": "phi_zweifel",
        "category": "philosophy_logic",
        "arabic": {"word": "الشَّكُّ المَنْهَجِيُّ", "transliteration": "Ash-Shakk", "notes": "التردد في الحكم لإعادة الفحص والتدقيق"},
        "german": {"article": "der", "word": "Zweifel", "plural": "die Zweifel", "gender": "masculine", "example": "Methodischer Zweifel ist der erste Schritt zu gesicherter Erkenntnis."},
        "english": {"word": "doubt / skepticism", "phonetic": "/daʊt/", "example": "Methodological doubt prevents accepting dogmas unquestioned."},
        "image_id": "img_phi_zweifel"
    },
    {
        "id": "phi_gewissheit",
        "category": "philosophy_logic",
        "arabic": {"word": "اليَقِينُ / الجَزْمُ", "transliteration": "Al-Yaqeen", "notes": "الاطمئنان القاطع لصحة الأمر دون شك"},
        "german": {"article": "die", "word": "Gewissheit", "plural": "die Gewissheiten", "gender": "feminine", "example": "Nach gründlicher Prüfung erlangte der Forscher absolute Gewissheit."},
        "english": {"word": "certainty / conviction", "phonetic": "/ˈsɜː.tən.ti/", "example": "Logical deduction brings intellectual certainty to the mind."},
        "image_id": "img_phi_gewissheit"
    },
    {
        "id": "phi_ethik",
        "category": "philosophy_logic",
        "arabic": {"word": "الأَخْلَاقِيَّاتُ / عِلْمُ الأَخْلَاقِ", "transliteration": "Al-Akhlaqiyyat", "notes": "فلسفة المبادئ والقيم الحاكمة للسلوك الإنساني"},
        "german": {"article": "die", "word": "Ethik", "plural": "die Ethiken", "gender": "feminine", "example": "Medizinische Ethik regelt den verantwortungsvollen Umgang mit Patienten."},
        "english": {"word": "ethics / moral philosophy", "phonetic": "/ˈeθ.ɪks/", "example": "Applied ethics guides responsible decision-making in technology."},
        "image_id": "img_phi_ethik"
    },
    {
        "id": "phi_wert",
        "category": "philosophy_logic",
        "arabic": {"word": "القِيمَةُ الإِنْسَانِيَّةُ", "transliteration": "Al-Qeemah", "notes": "المبدأ السامي الذي يوجه التقدير والعمل"},
        "german": {"article": "der", "word": "Wert", "plural": "die Werte", "gender": "masculine", "example": "Toleranz und Gerechtigkeit sind grundlegende demokratische Werte."},
        "english": {"word": "moral value / principle", "phonetic": "/ˈvæl.juː/", "example": "Integrity is a fundamental human value in civil discourse."},
        "image_id": "img_phi_wert"
    },
    {
        "id": "phi_sinn",
        "category": "philosophy_logic",
        "arabic": {"word": "المَعْنَى / المَغْزَى", "transliteration": "Al-Ma'na", "notes": "الغاية والهدف الوجودي من الحياة والعمل"},
        "german": {"article": "der", "word": "Sinn", "plural": "die Sinne", "gender": "masculine", "example": "Viele Denker fragen nach dem tieferen Sinn des Lebens."},
        "english": {"word": "meaning / purpose", "phonetic": "/ˈmiː.nɪŋ/", "example": "Searching for meaning and purpose drives creative human pursuits."},
        "image_id": "img_phi_sinn"
    },
    {
        "id": "phi_existenz",
        "category": "philosophy_logic",
        "arabic": {"word": "الوُجُودُ / الكَيْنُونَةُ", "transliteration": "Al-Wujood", "notes": "حالة التحقق والحضور في الكون"},
        "german": {"article": "die", "word": "Existenz", "plural": "die Existenzen", "gender": "feminine", "example": "Die Existenzphilosophie betont die menschliche Freiheit und Verantwortung."},
        "english": {"word": "existence / being", "phonetic": "/ɪɡˈzɪs.təns/", "example": "Existential philosophy ponders freedom, choice, and authentic being."},
        "image_id": "img_phi_existenz"
    },
    {
        "id": "phi_bewusstsein",
        "category": "philosophy_logic",
        "arabic": {"word": "الوَعْيُ / الإِدْرَاكُ الذَّاتِيُّ", "transliteration": "Al-Wa'y", "notes": "إدراك الكائن لذاته ومحيطه ومشاعره"},
        "german": {"article": "das", "word": "Bewusstsein", "plural": "die Bewusstsein", "gender": "neuter", "example": "Das menschliche Bewusstsein ist ein faszinierendes Forschungsfeld."},
        "english": {"word": "consciousness / awareness", "phonetic": "/ˈkɒn.ʃəs.nəs/", "example": "Self-reflective consciousness distinguishes sentient human thought."},
        "image_id": "img_phi_bewusstsein"
    },
    {
        "id": "phi_meinung",
        "category": "philosophy_logic",
        "arabic": {"word": "الرَّأْيُ / وِجْهَةُ النَّظَرِ", "transliteration": "Ar-Ra'y", "notes": "التقدير الذاتي غير القائم بالضرورة على يقين قطعي"},
        "german": {"article": "die", "word": "Meinung", "plural": "die Meinungen", "gender": "feminine", "example": "Jeder Mensch hat das Recht auf seine eigene freie Meinung."},
        "english": {"word": "opinion / standpoint", "phonetic": "/əˈpɪn.jən/", "example": "Respecting differing personal opinions enriches constructive debate."},
        "image_id": "img_phi_meinung"
    },
    {
        "id": "phi_perspektive",
        "category": "philosophy_logic",
        "arabic": {"word": "المَنْظُورُ / زَاوِيَةُ الرُّؤْيَةِ", "transliteration": "Al-Manthoor", "notes": "الزاوية التي يُنظر من خلالها إلى القضايا"},
        "german": {"article": "die", "word": "Perspektive", "plural": "die Perspektiven", "gender": "feminine", "example": "Ein Wechsel der Perspektive hilft oft, Probleme besser zu verstehen."},
        "english": {"word": "perspective / viewpoint", "phonetic": "/pəˈspek.tɪv/", "example": "Looking at issues from a broader perspective fosters empathy."},
        "image_id": "img_phi_perspektive"
    },
    {
        "id": "phi_prinzip",
        "category": "philosophy_logic",
        "arabic": {"word": "المَبْدَأُ / القَاعِدَةُ الأَسَاسِيَّةُ", "transliteration": "Al-Mabda'", "notes": "القانون الجوهري الحاكم للتصرف والتفكير"},
        "german": {"article": "das", "word": "Prinzip", "plural": "die Prinzipien", "gender": "neuter", "example": "Er bleibt seinen ethischen Prinzipien auch in schweren Zeiten treu."},
        "english": {"word": "principle / maxim", "phonetic": "/ˈprɪn.sə.pəl/", "example": "Acting according to universal moral principles ensures fairness."},
        "image_id": "img_phi_prinzip"
    },
    {
        "id": "phi_schlussfolgerung",
        "category": "philosophy_logic",
        "arabic": {"word": "الِاسْتِنْتَاجُ / الخُلَاصَةُ المَنْطِقِيَّةُ", "transliteration": "Al-Istintaj", "notes": "النتيجة المشتقة منطقيًا من مقدمات صحيحة"},
        "german": {"article": "die", "word": "Schlussfolgerung", "plural": "die Schlussfolgerungen", "gender": "feminine", "example": "Die logische Schlussfolgerung ergab sich aus den vorgelegten Fakten."},
        "english": {"word": "deduction / conclusion", "phonetic": "/dɪˈdʌk.ʃən/", "example": "His conclusion followed logically from valid empirical premises."},
        "image_id": "img_phi_schlussfolgerung"
    },
    {
        "id": "phi_widerspruch",
        "category": "philosophy_logic",
        "arabic": {"word": "التَّنَاقُضُ / التَّعَارُضُ", "transliteration": "At-Tanaqud", "notes": "اجتماع النقيضين الذي يبطله المنطق السليم"},
        "german": {"article": "der", "word": "Widerspruch", "plural": "die Widersprüche", "gender": "masculine", "example": "Seine zweite Aussage stand im klaren Widerspruch zur ersten."},
        "english": {"word": "contradiction / paradox", "phonetic": "/ˌkɒn.trəˈdɪk.ʃən/", "example": "A logical contradiction renders an argumentative premise invalid."},
        "image_id": "img_phi_widerspruch"
    },
    {
        "id": "phi_dialog",
        "category": "philosophy_logic",
        "arabic": {"word": "الحِوَارُ الفِكْرِيُّ", "transliteration": "Al-Hiwar", "notes": "تبادل الآراء البنّاء للوصول إلى الحقيقة (كحوارات سقراط)"},
        "german": {"article": "der", "word": "Dialog", "plural": "die Dialoge", "gender": "masculine", "example": "Platons philosophische Dialoge behandeln Gerechtigkeit und Tugend."},
        "english": {"word": "dialogue / discourse", "phonetic": "/ˈdaɪ.ə.lɒɡ/", "example": "Socratic dialogue examines fundamental assumptions through questions."},
        "image_id": "img_phi_dialog"
    },
    {
        "id": "phi_frage",
        "category": "philosophy_logic",
        "arabic": {"word": "التَّسَاؤُلُ الجَوْهَرِيُّ", "transliteration": "At-Tasa'ul", "notes": "طرح الاستفهام الوجودي المحرك للتفكير والبحث"},
        "german": {"article": "die", "word": "Frage", "plural": "die Fragen", "gender": "feminine", "example": "Kants vier berühmte Fragen definieren die Aufgaben der Philosophie."},
        "english": {"word": "fundamental question", "phonetic": "/ˈkwes.tʃən/", "example": "Philosophical questions challenge unexamined everyday conventions."},
        "image_id": "img_phi_frage"
    },
    {
        "id": "phi_kritisches_denken",
        "category": "philosophy_logic",
        "arabic": {"word": "التَّفْكِيرُ النَّقْدِيُّ", "transliteration": "At-Tafkeer An-Naqdi", "notes": "فحص الأدلة وتقييم الحجج بحياد وتجرد"},
        "german": {"article": "das", "word": "kritische Denken", "plural": "die kritischen Denken", "gender": "neuter", "example": "Kritisches Denken schützt vor Fehlinformationen und Manipulation."},
        "english": {"word": "critical thinking", "phonetic": "/ˈkrɪt.ɪ.kəl ˈθɪŋ.kɪŋ/", "example": "Cultivating critical thinking strengthens intellectual independence."},
        "image_id": "img_phi_kritisches_denken"
    }
]

# حفظ ملف المفردات الجديد في content/vocabulary/philosophy_logic_a2.json
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/philosophy_logic_a2.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "philosophy_logic",
        "category_name": {
            "ar": "الفلسفة والمنطق والتفكير النقدي",
            "de": "Philosophie, Logik & Kritisches Denken",
            "en": "Philosophy, Logic & Critical Thinking"
        },
        "level": "A2",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم فلسفية ومنطقية في {vocab_path}")

# 2. توليد 25 أيقونة SVG خفيفة ومتجهية (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "phi_philosophie": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#6A1B9A"/><circle cx="50" cy="50" r="28" fill="#8E24AA"/><circle cx="50" cy="50" r="8" fill="#FFD54F"/><line x1="50" y1="22" x2="50" y2="42" stroke="#FFF" stroke-width="4"/><line x1="50" y1="58" x2="50" y2="78" stroke="#FFF" stroke-width="4"/><line x1="22" y1="50" x2="42" y2="50" stroke="#FFF" stroke-width="4"/><line x1="58" y1="50" x2="78" y2="50" stroke="#FFF" stroke-width="4"/></svg>',
    "phi_logik": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="20" width="60" height="60" rx="8" fill="#1565C0"/><path d="M30,50 L70,50 M50,30 L50,70" stroke="#FFF" stroke-width="5" stroke-linecap="round"/><circle cx="35" cy="35" r="5" fill="#FFD54F"/><circle cx="65" cy="65" r="5" fill="#FFD54F"/><circle cx="35" cy="65" r="5" fill="#4CAF50"/><circle cx="65" cy="35" r="5" fill="#4CAF50"/></svg>',
    "phi_gedanke": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FDD835"/><circle cx="35" cy="45" r="14" fill="#FFF"/><circle cx="65" cy="45" r="14" fill="#FFF"/><circle cx="50" cy="35" r="18" fill="#FFF"/><circle cx="50" cy="55" r="14" fill="#FFF"/><circle cx="35" cy="74" r="5" fill="#FFF"/><circle cx="28" cy="84" r="3" fill="#FFF"/></svg>',
    "phi_vernunft": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00897B"/><path d="M35,62 C30,48 40,32 50,32 C60,32 70,48 65,62 Z" fill="#FFF"/><polygon points="50,18 53,24 60,24 55,29 57,36 50,32 43,36 45,29 40,24 47,24" fill="#FFD54F"/></svg>',
    "phi_wahrheit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0288D1"/><polygon points="50,18 78,32 78,65 50,82 22,65 22,32" fill="#E1F5FE"/><circle cx="50" cy="50" r="14" fill="#FFCA28"/></svg>',
    "phi_realitaet": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#37474F"/><rect x="28" y="28" width="44" height="44" rx="4" fill="#81C784"/><line x1="28" y1="28" x2="72" y2="72" stroke="#2E7D32" stroke-width="4"/><circle cx="50" cy="50" r="6" fill="#FFF"/></svg>',
    "phi_erkenntnis": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FFA000"/><path d="M25,50 Q50,25 75,50 Q50,75 25,50 Z" fill="#FFF"/><circle cx="50" cy="50" r="12" fill="#1565C0"/><circle cx="50" cy="50" r="5" fill="#FFF"/></svg>',
    "phi_weisheit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#4E342E"/><circle cx="38" cy="42" r="10" fill="#FFF"/><circle cx="62" cy="42" r="10" fill="#FFF"/><circle cx="38" cy="42" r="4" fill="#212121"/><circle cx="62" cy="42" r="4" fill="#212121"/><polygon points="50,48 45,56 55,56" fill="#FFB300"/><path d="M25,65 Q50,80 75,65" stroke="#D7CCC8" stroke-width="5" fill="none"/></svg>',
    "phi_argument": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1E88E5"/><rect x="30" y="25" width="40" height="50" rx="4" fill="#FFF"/><line x1="38" y1="38" x2="62" y2="38" stroke="#1565C0" stroke-width="4"/><line x1="38" y1="50" x2="62" y2="50" stroke="#1565C0" stroke-width="4"/><polygon points="70,55 82,65 70,75" fill="#FFD54F"/></svg>',
    "phi_beweis": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#2E7D32"/><path d="M30,52 L44,66 L72,36" fill="none" stroke="#FFF" stroke-width="8" stroke-linecap="round"/><circle cx="72" cy="25" r="4" fill="#FFD54F"/></svg>',
    "phi_zweifel": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#546E7A"/><circle cx="50" cy="50" r="28" fill="#78909C"/><text x="50" y="68" font-family="sans-serif" font-weight="bold" font-size="50" fill="#FFF" text-anchor="middle">?</text></svg>',
    "phi_gewissheit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00C853"/><circle cx="50" cy="50" r="28" fill="#B9F6CA"/><circle cx="50" cy="50" r="14" fill="#00C853"/><circle cx="50" cy="50" r="6" fill="#FFF"/></svg>',
    "phi_ethik": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#C2185B"/><line x1="25" y1="42" x2="75" y2="42" stroke="#FFF" stroke-width="4"/><line x1="50" y1="25" x2="50" y2="75" stroke="#FFF" stroke-width="4"/><path d="M25,42 L18,60 Q25,64 32,60 Z" fill="#FFD54F"/><path d="M75,42 L68,60 Q75,64 82,60 Z" fill="#FFD54F"/></svg>',
    "phi_wert": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FF6F00"/><polygon points="50,20 58,38 78,40 64,54 68,74 50,64 32,74 36,54 22,40 42,38" fill="#FFD54F"/><circle cx="50" cy="48" r="8" fill="#FFF"/></svg>',
    "phi_sinn": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00838F"/><circle cx="50" cy="50" r="24" fill="#00ACC1"/><polygon points="50,28 58,45 50,42 42,45" fill="#FFD54F"/><polygon points="50,72 58,55 50,58 42,55" fill="#FFD54F"/></svg>',
    "phi_existenz": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#283593"/><circle cx="50" cy="50" r="28" fill="#3949AB"/><circle cx="50" cy="50" r="18" fill="#5C6BC0"/><circle cx="50" cy="50" r="8" fill="#FFEB3B"/></svg>',
    "phi_bewusstsein": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#7B1FA2"/><path d="M35,62 C30,48 40,32 50,32 C60,32 70,48 65,62 Z" fill="#E1BEE7"/><circle cx="50" cy="45" r="8" fill="#FFD54F"/><line x1="50" y1="20" x2="50" y2="12" stroke="#FFD54F" stroke-width="4"/></svg>',
    "phi_meinung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#F57C00"/><path d="M25,32 C25,25 35,20 50,20 C65,20 75,25 75,32 L75,55 C75,62 65,65 50,65 L35,78 L38,65 L25,65 Z" fill="#FFF"/><circle cx="40" cy="44" r="4" fill="#E65100"/><circle cx="50" cy="44" r="4" fill="#E65100"/><circle cx="60" cy="44" r="4" fill="#E65100"/></svg>',
    "phi_perspektive": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="15,85 50,15 85,85" fill="#37474F"/><line x1="50" y1="15" x2="50" y2="85" stroke="#FFF" stroke-width="3" stroke-dasharray="6,4"/><circle cx="50" cy="45" r="8" fill="#FFD54F"/></svg>',
    "phi_prinzip": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="20" width="64" height="60" rx="6" fill="#455A64"/><rect x="26" y="28" width="48" height="12" rx="2" fill="#81C784"/><rect x="26" y="46" width="48" height="8" rx="2" fill="#B0BEC5"/><rect x="26" y="58" width="48" height="8" rx="2" fill="#B0BEC5"/><circle cx="50" cy="34" r="3" fill="#FFF"/></svg>',
    "phi_schlussfolgerung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1565C0"/><path d="M25,50 L65,50 M55,38 L68,50 L55,62" stroke="#FFF" stroke-width="6" fill="none" stroke-linecap="round" stroke-linejoin="round"/><circle cx="78" cy="50" r="5" fill="#FFD54F"/></svg>',
    "phi_widerspruch": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#D32F2F"/><line x1="30" y1="30" x2="70" y2="70" stroke="#FFF" stroke-width="8" stroke-linecap="round"/><line x1="70" y1="30" x2="30" y2="70" stroke="#FFF" stroke-width="8" stroke-linecap="round"/></svg>',
    "phi_dialog": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M18,30 C18,24 26,20 40,20 C54,20 62,24 62,30 L62,48 C62,54 54,56 40,56 L28,68 L30,56 L18,56 Z" fill="#1976D2"/><path d="M82,45 C82,39 74,35 60,35 L58,35 C58,37 58,40 58,42 L58,56 C58,62 50,65 40,65 L38,65 L48,78 L48,72 C62,72 70,70 70,64 L82,64 Z" fill="#FFB300"/></svg>',
    "phi_frage": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#512DA8"/><path d="M35,38 Q50,20 65,38 Q70,52 52,58 L52,66" stroke="#FFF" stroke-width="7" fill="none" stroke-linecap="round"/><circle cx="52" cy="78" r="4.5" fill="#FFD54F"/></svg>',
    "phi_kritisches_denken": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#303F9F"/><path d="M32,60 C28,45 38,32 50,32 C62,32 72,45 68,60 Z" fill="#E8EAF6"/><circle cx="68" cy="35" r="14" fill="#00E5FF"/><path d="M63,35 L67,39 L74,31" stroke="#004D40" stroke-width="3" fill="none"/></svg>'
}

# كتابة ملفات الـ SVG
for c in concepts:
    c_id = c["id"]
    svg_content = svg_templates[c_id]
    with open(f"content/assets/svg/{c_id}.svg", "w", encoding="utf-8") as f:
        f.write(svg_content)

print(f"✅ تم إنشاء {len(concepts)} ملفات SVG في content/assets/svg/")

# 3. تحديث سجل الأصول images_registry.json
reg_path = "content/assets/images_registry.json"
registry = {"assets": []}
if os.path.exists(reg_path):
    with open(reg_path, "r", encoding="utf-8") as f:
        registry = json.load(f)

existing_ids = {a["image_id"] for a in registry.get("assets", [])}
new_added = 0
for c in concepts:
    img_id = c["image_id"]
    if img_id not in existing_ids:
        registry["assets"].append({
            "image_id": img_id,
            "file": f"assets/svg/{c['id']}.svg",
            "type": "svg",
            "description": f"Vector illustration for philosophy concept: {c['english']['word']}"
        })
        new_added += 1

with open(reg_path, "w", encoding="utf-8") as f:
    json.dump(registry, f, ensure_ascii=False, indent=2)

print(f"✅ تم تحديث سجل الأصول: إجمالي الأصول المسجلة الآن = {len(registry['assets'])} (أضيف {new_added})")

# 4. تحديث ContentRepository في Dart
content_repo_path = "lib/repositories/content_repository.dart"
if os.path.exists(content_repo_path):
    with open(content_repo_path, "r", encoding="utf-8") as f:
        repo_code = f.read()
    
    if "philosophy_logic_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/science_space_a2.json',",
            "'assets/content/vocabulary/science_space_a2.json',\n    'assets/content/vocabulary/philosophy_logic_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط philosophy_logic_a2.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "philosophy_logic" not in cat_code:
        entry = """    CategoryMeta(
      id: 'philosophy_logic',
      titleAr: 'الفلسفة والمنطق والتفكير',
      titleDe: 'Philosophie & Kritisches Denken',
      titleEn: 'Philosophy & Logic',
      icon: Icons.psychology_alt_rounded,
      primaryColor: Color(0xFF6A1B9A),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم الفلسفة والمنطق في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 25", "TOTAL_VOCAB_CATEGORIES = 26")
    val_code = val_code.replace("TOTAL_CONCEPTS = 630", "TOTAL_CONCEPTS = 655")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 740", "TOTAL_SVG_ASSETS = 765")
    
    if "philosophy_logic_a2.json" not in val_code:
        val_code = val_code.replace(
            "'science_space_a2.json',",
            "'science_space_a2.json',\n    'philosophy_logic_a2.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (26 فئة، 655 مفهومًا، 765 أصلًا متجهيًا)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 044 Status (Completed - Level A2 Philosophy & Logic Category)
- **Feature:** Category 26: Philosophy, Logic & Critical Thinking (`philosophy_logic_a2.json`).
- **New Concepts:** 25 trilingual vocabulary items for truth, argument, reason, ethics, consciousness, and deduction.
- **New Visuals:** 25 unique lightweight SVG vectors (`phi_*.svg`).
- **Milestone Reached:** 26 Vocabulary Categories | 655 Core Concepts | 35 Base Verbs | 15 Perfekt Forms | 55 Syntax Exercises | 24 Prepositions | 5 Dialogues | Articles, Genitiv, Relativsätze, Konjunktiv II & Passiv Engines | 765 Total SVG Icons.
- **Integration:** Active in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 044 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 044 بنجاح تام!")
