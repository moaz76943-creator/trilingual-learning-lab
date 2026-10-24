import json
import os

print("🚀 [CYCLE 036] بدء بناء قسم البيئة وإعادة التدوير (Environment & Green Life - A2)...")

# 1. قائمة الـ 25 مفهومًا لقسم البيئة والطبيعة الخضراء
concepts = [
    {
        "id": "env_umwelt",
        "category": "environment_green",
        "arabic": {"word": "البِيئَةُ / المُحِيطُ الطَّبِيعِيُّ", "transliteration": "Al-Bee'ah", "notes": "المحيط الحيوي الذي تعيش فيه الكائنات"},
        "german": {"article": "die", "word": "Umwelt", "plural": "die Umwelten", "gender": "feminine", "example": "Wir müssen unsere Umwelt für die Zukunft schützen."},
        "english": {"word": "environment", "phonetic": "/ɪnˈvaɪ.rən.mənt/", "example": "Protecting our natural environment is a global responsibility."},
        "image_id": "img_env_umwelt"
    },
    {
        "id": "env_naturschutz",
        "category": "environment_green",
        "arabic": {"word": "حِمَايَةُ الطَّبِيعَةِ", "transliteration": "Himayat At-Tabee'ah", "notes": "صيانة الموارد الطبيعية والحياة البرية"},
        "german": {"article": "der", "word": "Naturschutz", "plural": "die Naturschutze", "gender": "masculine", "example": "Der Naturschutz engagiert sich für den Erhalt seltener Tierarten."},
        "english": {"word": "nature conservation", "phonetic": "/ˈneɪ.tʃər ˌkɒn.səˈveɪ.ʃən/", "example": "Nature conservation projects safeguard biodiversity."},
        "image_id": "img_env_naturschutz"
    },
    {
        "id": "env_klimawandel",
        "category": "environment_green",
        "arabic": {"word": "تَغَيُّرُ المُنَاخِ", "transliteration": "Taghayyur Al-Munakh", "notes": "التحول طويل الأجل في درجات الحرارة والطقس"},
        "german": {"article": "der", "word": "Klimawandel", "plural": "die Klimawandel", "gender": "masculine", "example": "Der weltweite Klimawandel verursacht extreme Wetterereignisse."},
        "english": {"word": "climate change", "phonetic": "/ˈklaɪ.mət ˌtʃeɪndʒ/", "example": "Global climate change demands urgent sustainable solutions."},
        "image_id": "img_env_klimawandel"
    },
    {
        "id": "env_verschmutzung",
        "category": "environment_green",
        "arabic": {"word": "التَّلَوُّثُ البِيئِيُّ", "transliteration": "At-Talawwuth Al-Bee'i", "notes": "إدخال المواد الضارة إلى الهواء أو الماء أو التربة"},
        "german": {"article": "die", "word": "Umweltverschmutzung", "plural": "die Umweltverschmutzungen", "gender": "feminine", "example": "Plastikmüll im Meer führt zu schwerer Umweltverschmutzung."},
        "english": {"word": "environmental pollution", "phonetic": "/pəˈluː.ʃən/", "example": "Air and water pollution pose major threats to public health."},
        "image_id": "img_env_verschmutzung"
    },
    {
        "id": "env_muell",
        "category": "environment_green",
        "arabic": {"word": "النِّفَايَاتُ / القُمَامَةُ", "transliteration": "An-Nifayat", "notes": "المخلفات المنزلية والصناعية"},
        "german": {"article": "der", "word": "Müll", "plural": "die Mülle", "gender": "masculine", "example": "Bitte wirf deinen Müll immer in die richtige Tonne."},
        "english": {"word": "garbage / waste", "phonetic": "/ˈɡɑː.bɪdʒ/", "example": "Please dispose of domestic waste responsibly."},
        "image_id": "img_env_muell"
    },
    {
        "id": "env_recycling",
        "category": "environment_green",
        "arabic": {"word": "إِعَادَةُ التَّدْوِيرِ", "transliteration": "I'adat At-Tadweer", "notes": "تحويل المخلفات إلى مواد ومنتجات جديدة"},
        "german": {"article": "das", "word": "Recycling", "plural": "die Recyclings", "gender": "neuter", "example": "Effektives Recycling spart wertvolle Rohstoffe und Energie."},
        "english": {"word": "recycling", "phonetic": "/ˌriːˈsaɪ.klɪŋ/", "example": "Recycling paper and glass conserves vital natural resources."},
        "image_id": "img_env_recycling"
    },
    {
        "id": "env_muelltrennung",
        "category": "environment_green",
        "arabic": {"word": "فَرْزُ النِّفَايَاتِ", "transliteration": "Farz An-Nifayat", "notes": "فصل المخلفات حسب نوعها لتسهيل تدويرها"},
        "german": {"article": "die", "word": "Mülltrennung", "plural": "die Mülltrennungen", "gender": "feminine", "example": "In Deutschland ist eine gründliche Mülltrennung sehr wichtig."},
        "english": {"word": "waste separation", "phonetic": "/weɪst ˌsep.ərˈeɪ.ʃən/", "example": "Careful waste separation makes municipal recycling efficient."},
        "image_id": "img_env_muelltrennung"
    },
    {
        "id": "env_plastik",
        "category": "environment_green",
        "arabic": {"word": "البِلَاسْتِيكُ / اللَّدَائِنُ", "transliteration": "Al-Blastik", "notes": "المادة الاصطناعية بطيئة التحلل"},
        "german": {"article": "das", "word": "Plastik", "plural": "die Plastike", "gender": "neuter", "example": "Wir sollten den Konsum von Einweg-Plastik reduzieren."},
        "english": {"word": "plastic", "phonetic": "/ˈplæs.tɪk/", "example": "Reducing single-use plastic prevents marine pollution."},
        "image_id": "img_env_plastik"
    },
    {
        "id": "env_altglas",
        "category": "environment_green",
        "arabic": {"word": "حَاوِيَةُ الزُّجَاجِ المُسْتَعْمَلِ", "transliteration": "Hawiyat Az-Zujaj", "notes": "حاوية مخصصة لجمع الزجاج الفارغ للتدوير"},
        "german": {"article": "der", "word": "Altglascontainer", "plural": "die Altglascontainer", "gender": "masculine", "example": "Grüne und weiße Flaschen kommen in getrennte Altglascontainer."},
        "english": {"word": "bottle bank / glass container", "phonetic": "/ˈbɒt.əl bæŋk/", "example": "Drop empty glass bottles into the designated bottle bank."},
        "image_id": "img_env_altglas"
    },
    {
        "id": "env_altpapier",
        "category": "environment_green",
        "arabic": {"word": "نِفَايَاتُ الوَرَقِ", "transliteration": "Nifayat Al-Waraq", "notes": "الورق والكرتون القديم المخصص للتدوير"},
        "german": {"article": "das", "word": "Altpapier", "plural": "die Altpapiere", "gender": "neuter", "example": "Zeitungen und Pappkartons gehören in die blaue Tonne für Altpapier."},
        "english": {"word": "waste paper", "phonetic": "/weɪst ˈpeɪ.pər/", "example": "Recycle old cardboard and newspapers in the paper bin."},
        "image_id": "img_env_altpapier"
    },
    {
        "id": "env_solarenergie",
        "category": "environment_green",
        "arabic": {"word": "الطَّاقَةُ الشَّمْسِيَّةُ", "transliteration": "At-Taqah Ash-Shamsiyyah", "notes": "الكهرباء المولدة من أشعة الشمس"},
        "german": {"article": "die", "word": "Solarenergie", "plural": "die Solarenergien", "gender": "feminine", "example": "Viele Hausbesitzer installieren Solaranlagen zur Stromerzeugung."},
        "english": {"word": "solar energy", "phonetic": "/ˈsəʊ.lər ˈen.ə.dʒi/", "example": "Solar energy provides clean and renewable electricity."},
        "image_id": "img_env_solarenergie"
    },
    {
        "id": "env_windenergie",
        "category": "environment_green",
        "arabic": {"word": "طَاقَةُ الرِّيَاحِ", "transliteration": "Taqat Ar-Riyah", "notes": "توليد الكهرباء عبر توربينات الرياح"},
        "german": {"article": "die", "word": "Windenergie", "plural": "die Windenergien", "gender": "feminine", "example": "Große Windräder auf den Feldern erzeugen saubere Windenergie."},
        "english": {"word": "wind power / energy", "phonetic": "/wɪnd ˈen.ə.dʒi/", "example": "Modern wind turbines harness kinetic wind power efficiently."},
        "image_id": "img_env_windenergie"
    },
    {
        "id": "env_erneuerbar",
        "category": "environment_green",
        "arabic": {"word": "الطَّاقَةُ المُتَجَدِّدَةُ", "transliteration": "At-Taqah Al-Mutajaddidah", "notes": "الطاقة المستمدة من مصادر طبيعية لا تنضب"},
        "german": {"article": "die", "word": "erneuerbare Energie", "plural": "die erneuerbaren Energien", "gender": "feminine", "example": "Die Zukunft gehört den erneuerbaren Energien."},
        "english": {"word": "renewable energy", "phonetic": "/rɪˈnjuː.ə.bəl ˈen.ə.dʒi/", "example": "Transitioning to renewable energy mitigates carbon emissions."},
        "image_id": "img_env_erneuerbar"
    },
    {
        "id": "env_bio_lebensmittel",
        "category": "environment_green",
        "arabic": {"word": "الأَغْذِيَةُ العُضْوِيَّةُ", "transliteration": "Al-Aghthiyah Al-'Udwiyyah", "notes": "أطعمة مزروعة بدون مبيدات كيميائية"},
        "german": {"article": "die", "word": "Bio-Lebensmittel", "plural": "die Bio-Lebensmittel", "gender": "plural", "example": "Ich kaufe Bio-Äpfel und Gemüse direkt beim Bio-Bauern."},
        "english": {"word": "organic food", "phonetic": "/ɔːˈɡæn.ɪk fuːd/", "example": "Organic food is cultivated without synthetic pesticides."},
        "image_id": "img_env_bio_lebensmittel"
    },
    {
        "id": "env_wald",
        "category": "environment_green",
        "arabic": {"word": "الغَابَةُ", "transliteration": "Al-Ghabah", "notes": "رئة الأرض والمساحة الشجرية الكثيفة"},
        "german": {"article": "der", "word": "Wald", "plural": "die Wälder", "gender": "masculine", "example": "Ein Spaziergang durch den grünen Wald ist erholsam."},
        "english": {"word": "forest", "phonetic": "/ˈfɒr.ɪst/", "example": "Temperate forests absorb vast amounts of carbon dioxide."},
        "image_id": "img_env_wald"
    },
    {
        "id": "env_baum",
        "category": "environment_green",
        "arabic": {"word": "الشَّجَرَةُ", "transliteration": "Ash-Shajarah", "notes": "النبات الخشبي المعمر منتج الأكسجين"},
        "german": {"article": "der", "word": "Baum", "plural": "die Bäume", "gender": "masculine", "example": "Die Schüler haben im Schulgarten einen neuen Baum gepflanzt."},
        "english": {"word": "tree", "phonetic": "/triː/", "example": "Planting a native tree helps restore local wildlife habitats."},
        "image_id": "img_env_baum"
    },
    {
        "id": "env_ozean",
        "category": "environment_green",
        "arabic": {"word": "المُحِيطُ المَائِيُّ", "transliteration": "Al-Muheet", "notes": "المسطح المائي المالح الشاسع"},
        "german": {"article": "der", "word": "Ozean", "plural": "die Ozeane", "gender": "masculine", "example": "Die Ozeane regulieren das gesamte Weltklima."},
        "english": {"word": "ocean", "phonetic": "/ˈəʊ.ʃən/", "example": "Healthy oceans are vital for climate balance and marine life."},
        "image_id": "img_env_ozean"
    },
    {
        "id": "env_saubere_luft",
        "category": "environment_green",
        "arabic": {"word": "الهَوَاءُ النَّقِيُّ", "transliteration": "Al-Hawa' An-Naqiyy", "notes": "هواء خالٍ من الدخان والانبعاثات الضارة"},
        "german": {"article": "die", "word": "saubere Luft", "plural": "die sauberen Lüfte", "gender": "feminine", "example": "In den Bergen genießt man herrlich saubere Luft."},
        "english": {"word": "clean air", "phonetic": "/kliːn eər/", "example": "Every citizen has the right to breathe clean air."},
        "image_id": "img_env_saubere_luft"
    },
    {
        "id": "env_trinkwasser",
        "category": "environment_green",
        "arabic": {"word": "مِيَاهُ الشُّرْبِ العَذْبَةُ", "transliteration": "Miyah Ash-Shurb", "notes": "الماء الصالح للاستهلاك الآدمي"},
        "german": {"article": "das", "word": "Trinkwasser", "plural": "die Trinkwasser", "gender": "neuter", "example": "Sauberes Trinkwasser ist ein kostbares Gut auf der Welt."},
        "english": {"word": "drinking water", "phonetic": "/ˈdrɪŋ.kɪŋ ˌwɔː.tər/", "example": "Access to clean drinking water is essential for human life."},
        "image_id": "img_env_trinkwasser"
    },
    {
        "id": "env_energiesparen",
        "category": "environment_green",
        "arabic": {"word": "تَوْفِيرُ الطَّاقَةِ / التَّرْشِيدُ", "transliteration": "Tawfeer At-Taqah", "notes": "الحد من استهلاك الكهرباء والوقود"},
        "german": {"article": "das", "word": "Energiesparen", "plural": "die Energiesparen", "gender": "neuter", "example": "LED-Lampen helfen beim täglichen Energiesparen im Haushalt."},
        "english": {"word": "energy saving", "phonetic": "/ˈen.ə.dʒi ˈseɪ.vɪŋ/", "example": "Smart energy saving lowers utility bills and emissions."},
        "image_id": "img_env_energiesparen"
    },
    {
        "id": "env_nachhaltigkeit",
        "category": "environment_green",
        "arabic": {"word": "الِاسْتِدَامَةُ", "transliteration": "Al-Istidamah", "notes": "تلبية احتياجات الحاضر دون الإضرار بالأجيال القادمة"},
        "german": {"article": "die", "word": "Nachhaltigkeit", "plural": "die Nachhaltigkeiten", "gender": "feminine", "example": "Nachhaltigkeit steht im Mittelpunkt moderner Architektur."},
        "english": {"word": "sustainability", "phonetic": "/səˌsteɪ.nəˈbɪl.ə.ti/", "example": "Long-term environmental sustainability requires collective action."},
        "image_id": "img_env_nachhaltigkeit"
    },
    {
        "id": "env_radweg",
        "category": "environment_green",
        "arabic": {"word": "مَسَارُ الدَّرَّاجَاتِ الهَوَائِيَّةِ", "transliteration": "Masar Ad-Darrajat", "notes": "طريق مخصص لراكبي الدراجات للحد من انبعاثات السيارات"},
        "german": {"article": "der", "word": "Radweg", "plural": "die Radwege", "gender": "masculine", "example": "Der neue breite Radweg verbindet den Bahnhof mit dem Stadtzentrum."},
        "english": {"word": "cycle lane / bicycle path", "phonetic": "/ˈbaɪ.sɪ.kəl pɑːθ/", "example": "Commuting via the protected bicycle path is fast and green."},
        "image_id": "img_env_radweg"
    },
    {
        "id": "env_umweltfreundlich",
        "category": "environment_green",
        "arabic": {"word": "صَدِيقٌ لِلْبِيئَةِ", "transliteration": "Sadeeq Lil-Bee'ah", "notes": "لا يسبب ضررًا للطبيعة والمناخ"},
        "german": {"article": "", "word": "umweltfreundlich", "plural": "", "gender": "adjective", "example": "Zugfahren ist eine umweltfreundliche Alternative zum Flugzeug."},
        "english": {"word": "eco-friendly / green", "phonetic": "/ˌiː.kəʊˈfrend.li/", "example": "Public transit is an eco-friendly commuting option."},
        "image_id": "img_env_umweltfreundlich"
    },
    {
        "id": "env_schuetzen",
        "category": "environment_green",
        "arabic": {"word": "يَحْمِي / يُحَافِظُ عَلَى", "transliteration": "Yahmee", "notes": "يقي الطبيعة من الأذى والتدمير"},
        "german": {"article": "", "word": "schützen", "plural": "", "gender": "verb", "example": "Gemeinsam können wir unseren blauen Planeten schützen."},
        "english": {"word": "to protect / conserve", "phonetic": "/prəˈtekt/", "example": "Together we can protect our fragile ecosystems."},
        "image_id": "img_env_schuetzen"
    },
    {
        "id": "env_planet",
        "category": "environment_green",
        "arabic": {"word": "كَوْكَبُ الأَرْضِ / كَوْكَبُنَا", "transliteration": "Kawkab Al-Ard", "notes": "الموطن المشترك لجميع الكائنات الحية"},
        "german": {"article": "der", "word": "Planet", "plural": "die Planeten", "gender": "masculine (n-Deklination)", "example": "Es gibt keinen zweiten Planeten; wir haben nur diese eine Erde."},
        "english": {"word": "planet Earth", "phonetic": "/ˈplæn.ɪt/", "example": "There is no planet B; caring for Earth is paramount."},
        "image_id": "img_env_planet"
    }
]

# حفظ ملف المفردات الجديد في content/vocabulary/environment_green_a2.json
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/environment_green_a2.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "environment_green",
        "category_name": {
            "ar": "البيئة وإعادة التدوير والحياة الخضراء",
            "de": "Umwelt & Grünes Leben",
            "en": "Environment & Green Life"
        },
        "level": "A2",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم بيئية جديدة في {vocab_path}")

# 2. توليد 25 أيقونة SVG متقنة وخفيفة (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "env_umwelt": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#4CAF50"/><circle cx="50" cy="50" r="28" fill="#81C784"/><path d="M42,25 Q58,35 50,55 Q35,70 50,75 Q68,60 58,40 Z" fill="#2E7D32"/></svg>',
    "env_naturschutz": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M50,15 L80,30 C80,65 50,85 50,85 C50,85 20,65 20,30 Z" fill="#2E7D32"/><path d="M50,35 C42,45 42,65 50,72 C58,65 58,45 50,35 Z" fill="#81C784"/><line x1="50" y1="40" x2="50" y2="70" stroke="#1B5E20" stroke-width="2.5"/></svg>',
    "env_klimawandel": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0288D1"/><path d="M50,12 A38,38 0 0,1 50,88 Z" fill="#E65100"/><rect x="44" y="25" width="12" height="42" rx="6" fill="#FFF" stroke="#212121" stroke-width="3"/><circle cx="50" cy="68" r="10" fill="#E53935"/></svg>',
    "env_verschmutzung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="45" width="20" height="40" fill="#546E7A"/><rect x="55" y="35" width="20" height="50" fill="#546E7A"/><circle cx="35" cy="32" r="12" fill="#B0BEC5" opacity="0.7"/><circle cx="45" cy="22" r="14" fill="#90A4AE" opacity="0.6"/><circle cx="65" cy="25" r="14" fill="#B0BEC5" opacity="0.7"/></svg>',
    "env_muell": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="35" width="50" height="50" rx="4" fill="#78909C"/><rect x="20" y="26" width="60" height="10" rx="3" fill="#455A64"/><rect x="42" y="18" width="16" height="8" rx="2" fill="#455A64"/><line x1="38" y1="45" x2="38" y2="75" stroke="#37474F" stroke-width="3"/><line x1="50" y1="45" x2="50" y2="75" stroke="#37474F" stroke-width="3"/><line x1="62" y1="45" x2="62" y2="75" stroke="#37474F" stroke-width="3"/></svg>',
    "env_recycling": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M42,22 L58,22 L65,34 L56,34" fill="none" stroke="#2E7D32" stroke-width="6" stroke-linecap="round"/><polygon points="40,22 48,15 48,29" fill="#2E7D32"/><path d="M72,42 L80,56 L72,68 L68,60" fill="none" stroke="#2E7D32" stroke-width="6" stroke-linecap="round"/><polygon points="76,40 84,46 72,52" fill="#2E7D32"/><path d="M38,72 L22,72 L18,58 L24,64" fill="none" stroke="#2E7D32" stroke-width="6" stroke-linecap="round"/><polygon points="40,72 32,65 32,79" fill="#2E7D32"/></svg>',
    "env_muelltrennung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="14" y="35" width="20" height="48" rx="3" fill="#1E88E5"/><rect x="40" y="35" width="20" height="48" rx="3" fill="#FDD835"/><rect x="66" y="35" width="20" height="48" rx="3" fill="#43A047"/><rect x="12" y="28" width="24" height="8" rx="2" fill="#0D47A1"/><rect x="38" y="28" width="24" height="8" rx="2" fill="#F57F17"/><rect x="64" y="28" width="24" height="8" rx="2" fill="#1B5E20"/></svg>',
    "env_plastik": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="36" y="35" width="28" height="50" rx="8" fill="#80DEEA"/><rect x="42" y="20" width="16" height="15" fill="#4DD0E1"/><rect x="40" y="16" width="20" height="5" fill="#00ACC1"/><line x1="36" y1="50" x2="64" y2="50" stroke="#00BCD4" stroke-width="3"/><line x1="36" y1="65" x2="64" y2="65" stroke="#00BCD4" stroke-width="3"/></svg>',
    "env_altglas": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="30" width="56" height="55" rx="8" fill="#388E3C"/><circle cx="50" cy="50" r="12" fill="#FFF"/><polygon points="30,30 50,15 70,30" fill="#2E7D32"/><rect x="46" y="70" width="8" height="15" fill="#1B5E20"/></svg>',
    "env_altpapier": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="20" width="56" height="65" rx="3" fill="#1976D2"/><rect x="28" y="28" width="44" height="48" rx="2" fill="#E3F2FD"/><line x1="35" y1="40" x2="65" y2="40" stroke="#1565C0" stroke-width="3.5"/><line x1="35" y1="52" x2="65" y2="52" stroke="#1565C0" stroke-width="3.5"/><line x1="35" y1="64" x2="55" y2="64" stroke="#1565C0" stroke-width="3.5"/></svg>',
    "env_solarenergie": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="28" cy="28" r="14" fill="#FFA000"/><polygon points="30,55 80,45 88,85 38,90" fill="#1565C0"/><line x1="55" y1="50" x2="63" y2="88" stroke="#FFF" stroke-width="2.5"/><line x1="34" y1="72" x2="84" y2="65" stroke="#FFF" stroke-width="2.5"/></svg>',
    "env_windenergie": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><line x1="50" y1="50" x2="50" y2="88" stroke="#78909C" stroke-width="5" stroke-linecap="round"/><circle cx="50" cy="50" r="6" fill="#455A64"/><path d="M50,50 C50,30 40,20 50,14 C60,20 50,30 50,50 Z" fill="#00BCD4"/><path d="M50,50 C35,58 24,52 20,62 C26,70 36,60 50,50 Z" fill="#00BCD4"/><path d="M50,50 C65,58 76,52 80,62 C74,70 64,60 50,50 Z" fill="#00BCD4"/></svg>',
    "env_erneuerbar": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#43A047"/><circle cx="50" cy="50" r="25" fill="#FFF"/><polygon points="46,30 58,45 50,45 54,68 42,50 50,50" fill="#FDD835"/></svg>',
    "env_bio_lebensmittel": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#7CB342"/><path d="M30,55 C30,35 50,25 70,30 C70,50 60,70 40,70 C30,70 30,65 30,55 Z" fill="#FFF"/><line x1="30" y1="55" x2="68" y2="32" stroke="#558B2F" stroke-width="3"/></svg>',
    "env_wald": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="35,30 20,60 50,60" fill="#2E7D32"/><polygon points="65,22 45,58 85,58" fill="#388E3C"/><rect x="32" y="60" width="6" height="20" fill="#5D4037"/><rect x="62" y="58" width="6" height="22" fill="#5D4037"/><line x1="10" y1="80" x2="90" y2="80" stroke="#8D6E63" stroke-width="4" stroke-linecap="round"/></svg>',
    "env_baum": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="44" y="55" width="12" height="32" fill="#6D4C41" rx="2"/><circle cx="50" cy="38" r="26" fill="#4CAF50"/><circle cx="36" cy="42" r="18" fill="#388E3C"/><circle cx="64" cy="42" r="18" fill="#388E3C"/><circle cx="50" cy="26" r="18" fill="#66BB6A"/></svg>',
    "env_ozean": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#01579B"/><path d="M15,48 Q32,38 50,48 Q68,58 85,48 L85,88 L15,88 Z" fill="#0288D1"/><path d="M15,62 Q32,52 50,62 Q68,72 85,62 L85,88 L15,88 Z" fill="#29B6F6"/></svg>',
    "env_saubere_luft": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#E1F5FE"/><path d="M20,38 L65,38 C75,38 78,28 70,22 C65,16 55,24 60,32" fill="none" stroke="#03A9F4" stroke-width="5" stroke-linecap="round"/><path d="M15,52 L75,52 C85,52 88,42 80,35 C74,30 65,36 70,45" fill="none" stroke="#03A9F4" stroke-width="5" stroke-linecap="round"/><path d="M25,66 L60,66 C70,66 75,76 65,82 C58,86 50,78 55,70" fill="none" stroke="#03A9F4" stroke-width="5" stroke-linecap="round"/></svg>',
    "env_trinkwasser": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M50,18 C50,18 25,48 25,65 C25,78 36,88 50,88 C64,88 75,78 75,65 C75,48 50,18 50,18 Z" fill="#00BCD4"/><ellipse cx="42" cy="62" rx="6" ry="12" fill="#E0F7FA" opacity="0.6"/></svg>',
    "env_energiesparen": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="42" r="24" fill="#FFEB3B"/><path d="M40,64 L60,64 L56,76 L44,76 Z" fill="#78909C"/><polygon points="48,26 56,38 48,38 52,56 42,44 48,44" fill="#E65100"/><circle cx="50" cy="42" r="32" fill="none" stroke="#4CAF50" stroke-width="4" stroke-dasharray="8,6"/></svg>',
    "env_nachhaltigkeit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1B5E20"/><path d="M30,50 A20,20 0 0,1 70,50 A20,20 0 0,1 30,50" fill="none" stroke="#A5D6A7" stroke-width="6"/><circle cx="50" cy="50" r="6" fill="#FFD54F"/></svg>',
    "env_radweg": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="15" width="70" height="70" rx="10" fill="#1565C0"/><circle cx="35" cy="62" r="12" fill="none" stroke="#FFF" stroke-width="4"/><circle cx="65" cy="62" r="12" fill="none" stroke="#FFF" stroke-width="4"/><polygon points="35,62 50,62 58,45 42,45" fill="none" stroke="#FFF" stroke-width="3"/><circle cx="42" cy="38" r="3" fill="#FFF"/></svg>',
    "env_umweltfreundlich": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#43A047"/><path d="M35,60 C30,40 45,25 65,30 C65,50 55,70 35,60 Z" fill="#FFF"/><path d="M35,60 L62,35" stroke="#2E7D32" stroke-width="3"/></svg>',
    "env_schuetzen": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M25,70 C25,55 40,45 50,55 C60,45 75,55 75,70" fill="none" stroke="#2E7D32" stroke-width="6" stroke-linecap="round"/><circle cx="50" cy="35" r="14" fill="#81C784"/></svg>',
    "env_planet": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0288D1"/><path d="M28,35 Q40,25 55,30 Q65,45 45,60 Q30,65 28,35 Z" fill="#4CAF50"/><path d="M58,55 Q72,50 82,65 Q75,80 60,78 Z" fill="#4CAF50"/></svg>'
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
            "description": f"Vector illustration for environment concept: {c['english']['word']}"
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
    
    if "environment_green_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/celebrations_social_a1.json',",
            "'assets/content/vocabulary/celebrations_social_a1.json',\n    'assets/content/vocabulary/environment_green_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط environment_green_a2.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "environment_green" not in cat_code:
        entry = """    CategoryMeta(
      id: 'environment_green',
      titleAr: 'البيئة والطبيعة الخضراء',
      titleDe: 'Umwelt & Grünes Leben',
      titleEn: 'Environment & Green Life',
      icon: Icons.eco_rounded,
      primaryColor: Color(0xFF2E7D32),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم البيئة في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 20", "TOTAL_VOCAB_CATEGORIES = 21")
    val_code = val_code.replace("TOTAL_CONCEPTS = 505", "TOTAL_CONCEPTS = 530")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 585", "TOTAL_SVG_ASSETS = 610")
    
    if "environment_green_a2.json" not in val_code:
        val_code = val_code.replace(
            "'celebrations_social_a1.json',",
            "'celebrations_social_a1.json',\n    'environment_green_a2.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (21 فئة، 530 مفهومًا، 610 أصول متجهية)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 036 Status (Completed - Level A2 Vocabulary Kickoff)
- **Feature:** Category 21: Environment & Green Life (`environment_green_a2.json`).
- **New Concepts:** 25 trilingual vocabulary items for sustainability, climate change, renewable energy, and recycling.
- **New Visuals:** 25 unique lightweight SVG vectors (`env_*.svg`).
- **Milestone Reached:** 21 Vocabulary Categories | 530 Core Concepts | 35 Verbs | 15 Perfekt Forms | 40 Syntax Exercises | 24 Prepositions (Wechsel + Genitiv) | 5 Dialogues | Articles Engine | 610 Total SVG Icons (Passed 600+ threshold).
- **Integration:** Active in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 036 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 036 بنجاح تام!")
