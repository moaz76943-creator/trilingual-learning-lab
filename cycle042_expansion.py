import json
import os

print("🚀 [CYCLE 042] بدء بناء قسم العلوم والابتكار والفضاء (Science, Innovation & Space - A2)...")

# 1. قائمة الـ 25 مفهومًا لقسم العلوم والفضاء والابتكار
concepts = [
    {
        "id": "sci_wissenschaft",
        "category": "science_space",
        "arabic": {"word": "العِلْمُ / المَعْرِفَةُ المَنْهَجِيَّةُ", "transliteration": "Al-'Ilm", "notes": "البحث المنظم لاكتشاف الحقائق والقوانين"},
        "german": {"article": "die", "word": "Wissenschaft", "plural": "die Wissenschaften", "gender": "feminine", "example": "Die moderne Wissenschaft erforscht die Geheimnisse des Universums."},
        "english": {"word": "science", "phonetic": "/ˈsaɪ.əns/", "example": "Modern science expands human understanding of nature."},
        "image_id": "img_sci_wissenschaft"
    },
    {
        "id": "sci_forscher",
        "category": "science_space",
        "arabic": {"word": "العَالِمُ / البَاحِثُ العِلْمِيُّ", "transliteration": "Al-'Alim / Al-Bahith", "notes": "المختص بالاستقصاء والتجريب العلمي"},
        "german": {"article": "der", "word": "Forscher", "plural": "die Forscher", "gender": "masculine", "example": "Der engagierte Forscher machte eine bahnbrechende Entdeckung."},
        "english": {"word": "scientist / researcher", "phonetic": "/ˈsaɪən.tɪst/", "example": "The leading researcher published his findings in a peer-reviewed journal."},
        "image_id": "img_sci_forscher"
    },
    {
        "id": "sci_forschung",
        "category": "science_space",
        "arabic": {"word": "البَحْثُ العِلْمِيُّ", "transliteration": "Al-Bahth Al-'Ilmi", "notes": "الاستقصاء التجريبي والنظري للظواهر"},
        "german": {"article": "die", "word": "Forschung", "plural": "die Forschungen", "gender": "feminine", "example": "Internationale Forschung beschleunigt die medizinische Entwicklung."},
        "english": {"word": "research", "phonetic": "/rɪˈsɜːtʃ/", "example": "Scientific research drives technological breakthroughs worldwide."},
        "image_id": "img_sci_forschung"
    },
    {
        "id": "sci_labor",
        "category": "science_space",
        "arabic": {"word": "المُخْتَبَرُ / المَعْمَلُ", "transliteration": "Al-Mukhtabar", "notes": "المكان المجهز لإجراء الفحوص والتجارب"},
        "german": {"article": "das", "word": "Labor", "plural": "die Labore", "gender": "neuter", "example": "Im chemischen Labor gelten strenge Sicherheitsvorschriften."},
        "english": {"word": "laboratory / lab", "phonetic": "/ləˈbɒr.ə.tər.i/", "example": "Rigorous testing takes place inside the clean chemistry laboratory."},
        "image_id": "img_sci_labor"
    },
    {
        "id": "sci_experiment",
        "category": "science_space",
        "arabic": {"word": "التَّجْرِبَةُ العِلْمِيَّةُ", "transliteration": "At-Tajribah", "notes": "الاختبار العملي لإثبات فرضية علمية"},
        "german": {"article": "das", "word": "Experiment", "plural": "die Experimente", "gender": "neuter", "example": "Das physikalische Experiment bestätigte die theoretische Annahme."},
        "english": {"word": "experiment", "phonetic": "/ɪkˈsper.ɪ.mənt/", "example": "The physics experiment verified the theoretical hypothesis."},
        "image_id": "img_sci_experiment"
    },
    {
        "id": "sci_entdeckung",
        "category": "science_space",
        "arabic": {"word": "الِاكْتِشَافُ العِلْمِيُّ", "transliteration": "Al-Iktishaf", "notes": "العثور على شيء كان موجودًا ومجهولًا"},
        "german": {"article": "die", "word": "Entdeckung", "plural": "die Entdeckungen", "gender": "feminine", "example": "Die Entdeckung des Penicillins rettete Millionen von Menschenleben."},
        "english": {"word": "discovery", "phonetic": "/dɪˈskʌv.ər.i/", "example": "The discovery of antibiotics revolutionized modern medicine."},
        "image_id": "img_sci_entdeckung"
    },
    {
        "id": "sci_erfindung",
        "category": "science_space",
        "arabic": {"word": "الِاخْتِرَاعُ", "transliteration": "Al-Ikhtira'", "notes": "ابتكار أداة أو جهاز جديد لم يكن موجودًا"},
        "german": {"article": "die", "word": "Erfindung", "plural": "die Erfindungen", "gender": "feminine", "example": "Das Rad gilt als eine der ältesten und wichtigsten Erfindungen."},
        "english": {"word": "invention", "phonetic": "/ɪnˈven.ʃən/", "example": "The invention of the printing press transformed human history."},
        "image_id": "img_sci_erfindung"
    },
    {
        "id": "sci_innovation",
        "category": "science_space",
        "arabic": {"word": "الِابْتِكَارُ / التَّطْوِيرُ الإِبْدَاعِيُّ", "transliteration": "Al-Ibtikar", "notes": "تطبيق أفكار إبداعية لتحسين الحياة والإنتاج"},
        "german": {"article": "die", "word": "Innovation", "plural": "die Innovationen", "gender": "feminine", "example": "Digitale Innovationen verändern unseren Alltag grundlegend."},
        "english": {"word": "innovation", "phonetic": "/ˌɪn.əˈveɪ.ʃən/", "example": "Technological innovation fuels economic and social progress."},
        "image_id": "img_sci_innovation"
    },
    {
        "id": "sci_technologie",
        "category": "science_space",
        "arabic": {"word": "التِّكْنُولُوجْيَا / التَّقْنِيَّةُ", "transliteration": "At-Tiknolojya", "notes": "التطبيقات العملية للعلوم في الصناعة والحياة"},
        "german": {"article": "die", "word": "Technologie", "plural": "die Technologien", "gender": "feminine", "example": "Moderne Technologie erleichtert die globale Kommunikation."},
        "english": {"word": "technology", "phonetic": "/tekˈnɒl.ə.dʒi/", "example": "Advanced communications technology connects remote parts of the globe."},
        "image_id": "img_sci_technologie"
    },
    {
        "id": "sci_mikroskop",
        "category": "science_space",
        "arabic": {"word": "المِجْهَرُ / المِيكْرُوسْكُوب", "transliteration": "Al-Mijhar", "notes": "جهاز تكبير الأجسام الدقيقة جدًا كالبكتيريا والخلايا"},
        "german": {"article": "das", "word": "Mikroskop", "plural": "die Mikroskope", "gender": "neuter", "example": "Unter dem Mikroskop kann man lebende Zellen beobachten."},
        "english": {"word": "microscope", "phonetic": "/ˈmaɪ.krə.skəʊp/", "example": "Biologists examine cellular structures using an electron microscope."},
        "image_id": "img_sci_mikroskop"
    },
    {
        "id": "sci_teleskop",
        "category": "science_space",
        "arabic": {"word": "المِرْقَبُ / التِّلِيسْكُوب", "transliteration": "Al-Mirqab", "notes": "أداة رصد الأجرام والنجوم والمجرات البعيدة"},
        "german": {"article": "das", "word": "Teleskop", "plural": "die Teleskope", "gender": "neuter", "example": "Mit einem leistungsstarken Teleskop sieht man ferne Planeten."},
        "english": {"word": "telescope", "phonetic": "/ˈtel.ɪ.skəʊp/", "example": "Astronomers peer at distant galaxies through space telescopes."},
        "image_id": "img_sci_teleskop"
    },
    {
        "id": "sci_weltraum",
        "category": "science_space",
        "arabic": {"word": "الفَضَاءُ الخَارِجِيُّ", "transliteration": "Al-Fada'", "notes": "الفراغ الشاسع الواقع خارج الغلاف الجوي للأرض"},
        "german": {"article": "der", "word": "Weltraum", "plural": "die Welträume", "gender": "masculine", "example": "Die Erforschung des Weltraums fasziniert die Menschheit seit jeher."},
        "english": {"word": "outer space / cosmos", "phonetic": "/ˌaʊ.tə ˈspeɪs/", "example": "Exploring outer space pushes the boundaries of human knowledge."},
        "image_id": "img_sci_weltraum"
    },
    {
        "id": "sci_universum",
        "category": "science_space",
        "arabic": {"word": "الكَوْنُ الشَّامِلُ", "transliteration": "Al-Kawn", "notes": "الوجود الكلي المتسع بما فيه من مادة وطاقة وزمان"},
        "german": {"article": "das", "word": "Universum", "plural": "die Universen", "gender": "neuter", "example": "Das unendliche Universum dehnt sich kontinuierlich aus."},
        "english": {"word": "universe", "phonetic": "/ˈjuː.nɪ.vɜːs/", "example": "The observable universe contains billions of evolving galaxies."},
        "image_id": "img_sci_universum"
    },
    {
        "id": "sci_galaxie",
        "category": "science_space",
        "arabic": {"word": "المَجَرَّةُ", "transliteration": "Al-Majarrah", "notes": "نظام هائل من النجوم والغازات والغبار الفلكي"},
        "german": {"article": "die", "word": "Galaxie", "plural": "die Galaxien", "gender": "feminine", "example": "Unsere Sonne gehört zur Galaxie der Milchstraße."},
        "english": {"word": "galaxy", "phonetic": "/ˈɡæl.ək.si/", "example": "Our solar system resides inside the spiral Milky Way galaxy."},
        "image_id": "img_sci_galaxie"
    },
    {
        "id": "sci_stern",
        "category": "science_space",
        "arabic": {"word": "النَّجْمُ المُنِيرُ", "transliteration": "An-Najm", "notes": "جرم سماوي كروي مضيء بذاته من الغاز الملتهب"},
        "german": {"article": "der", "word": "Stern", "plural": "die Sterne", "gender": "masculine", "example": "In einer klaren Nacht funkeln unzählige Sterne am Himmel."},
        "english": {"word": "star", "phonetic": "/stɑːr/", "example": "Countless luminous stars twinkle in a clear desert night."},
        "image_id": "img_sci_stern"
    },
    {
        "id": "sci_planet",
        "category": "science_space",
        "arabic": {"word": "الكَوْكَبُ الفَلَكِيُّ", "transliteration": "Al-Kawkab", "notes": "جرم سماوي يدور حول نجم كالشمس"},
        "german": {"article": "der", "word": "Planet", "plural": "die Planeten", "gender": "masculine (n-Deklination)", "example": "Die Erde ist der dritte Planet in unserem Sonnensystem."},
        "english": {"word": "planet", "phonetic": "/ˈplæn.ɪt/", "example": "Earth is the third planet orbiting our sun in the solar system."},
        "image_id": "img_sci_planet"
    },
    {
        "id": "sci_mond",
        "category": "science_space",
        "arabic": {"word": "القَمَرُ", "transliteration": "Al-Qamar", "notes": "التابع الطبيعي للأرض أو الكواكب"},
        "german": {"article": "der", "word": "Mond", "plural": "die Monde", "gender": "masculine", "example": "Im Jahr 1969 betraten Astronauten zum ersten Mal den Mond."},
        "english": {"word": "moon", "phonetic": "/muːn/", "example": "Astronauts landed on the lunar surface of the moon in 1969."},
        "image_id": "img_sci_mond"
    },
    {
        "id": "sci_satellit",
        "category": "science_space",
        "arabic": {"word": "القَمَرُ الصِّنَاعِيُّ", "transliteration": "Al-Qamar As-Sina'i", "notes": "جهاز مداري يدور حول الأرض للاتصالات والمراقبة"},
        "german": {"article": "der", "word": "Satellit", "plural": "die Satelliten", "gender": "masculine (n-Deklination)", "example": "Der Satellit überträgt Fernsehsignale und Wetterdaten zur Erde."},
        "english": {"word": "satellite", "phonetic": "/ˈsæt.əl.aɪt/", "example": "Communication satellites orbit Earth to transmit navigation data."},
        "image_id": "img_sci_satellit"
    },
    {
        "id": "sci_rakete",
        "category": "science_space",
        "arabic": {"word": "الصَّارُوخُ الفَضَائِيُّ", "transliteration": "As-Sarookh", "notes": "مركبة دفع لنقل الحمولات ورواد الفضاء"},
        "german": {"article": "die", "word": "Rakete", "plural": "die Raketen", "gender": "feminine", "example": "Die schwere Rakete startete erfolgreich zur Internationalen Raumstation."},
        "english": {"word": "space rocket", "phonetic": "/ˈrɒk.ɪt/", "example": "The rocket launched smoothly into orbital trajectory."},
        "image_id": "img_sci_rakete"
    },
    {
        "id": "sci_astronaut",
        "category": "science_space",
        "arabic": {"word": "رَائِدُ الفَضَاءِ", "transliteration": "Ra'id Al-Fada'", "notes": "الشخص المدرب للسفر والملاحة في الفضاء"},
        "german": {"article": "der", "word": "Astronaut", "plural": "die Astronauten", "gender": "masculine (n-Deklination)", "example": "Der deutsche Astronaut führte wissenschaftliche Experimente im All durch."},
        "english": {"word": "astronaut", "phonetic": "/ˈæs.trə.nɔːt/", "example": "The astronaut performed critical repairs during the spacewalk."},
        "image_id": "img_sci_astronaut"
    },
    {
        "id": "sci_schwerkraft",
        "category": "science_space",
        "arabic": {"word": "الجَاذِبِيَّةُ الأَرْضِيَّةُ", "transliteration": "Al-Jathibiyyah", "notes": "قوة الجذب المادي بين الأجسام والكتل"},
        "german": {"article": "die", "word": "Schwerkraft", "plural": "die Schwerkraft", "gender": "feminine", "example": "Im Weltall herrscht Schwerelosigkeit, weil die Schwerkraft kaum spürbar ist."},
        "english": {"word": "gravity", "phonetic": "/ˈɡræv.ə.ti/", "example": "Planetary gravity keeps the atmospheric gases anchored to Earth."},
        "image_id": "img_sci_schwerkraft"
    },
    {
        "id": "sci_ki",
        "category": "science_space",
        "arabic": {"word": "الذَّكَاءُ الِاصْطِنَاعِيُّ", "transliteration": "Ath-Thaka' Al-Istina'i", "notes": "قدرة الآلات والبرامج على محاكاة القدرات الذهنية"},
        "german": {"article": "die", "word": "künstliche Intelligenz", "plural": "die künstlichen Intelligenzen", "gender": "feminine", "example": "Künstliche Intelligenz hilft bei der schnellen Analyse großer Datenmengen."},
        "english": {"word": "artificial intelligence (AI)", "phonetic": "/ˌɑː.tɪˈfɪʃ.əl ɪnˈtel.ɪ.dʒəns/", "example": "Artificial intelligence automates complex data analysis routines."},
        "image_id": "img_sci_ki"
    },
    {
        "id": "sci_roboter",
        "category": "science_space",
        "arabic": {"word": "الإِنْسَانُ الآلِيُّ / الرُّوبُوت", "transliteration": "Ar-Robot", "notes": "آلة ذاتية الحركة لتنفيذ مهام محددة بدقة"},
        "german": {"article": "der", "word": "Roboter", "plural": "die Roboter", "gender": "masculine", "example": "In der modernen Automobilfabrik montieren Roboter die Bauteile."},
        "english": {"word": "robot", "phonetic": "/ˈrəʊ.bɒt/", "example": "Autonomous robots perform delicate manufacturing procedures."},
        "image_id": "img_sci_roboter"
    },
    {
        "id": "sci_daten",
        "category": "science_space",
        "arabic": {"word": "البَيَانَاتُ وَالمَعْلُومَاتُ", "transliteration": "Al-Bayanat", "notes": "الحقائق والأرقام المسجلة للمعالجة الرقمية"},
        "german": {"article": "die", "word": "Daten", "plural": "die Daten", "gender": "plural", "example": "Sichere Verschlüsselung schützt sensible Daten vor unbefugtem Zugriff."},
        "english": {"word": "data", "phonetic": "/ˈdeɪ.tə/", "example": "Data privacy protocols ensure confidential user protection."},
        "image_id": "img_sci_daten"
    },
    {
        "id": "sci_zukunft",
        "category": "science_space",
        "arabic": {"word": "المُسْتَقْبَلُ", "transliteration": "Al-Mustaqbal", "notes": "الزمن القادم وما يحمله من آفاق وتقدم"},
        "german": {"article": "die", "word": "Zukunft", "plural": "die Zukünfte", "gender": "feminine", "example": "Bildung und Forschung gestalten die Zukunft einer Gesellschaft."},
        "english": {"word": "future", "phonetic": "/ˈfjuː.tʃər/", "example": "Investing in scientific research secures a prosperous future."},
        "image_id": "img_sci_zukunft"
    }
]

# حفظ ملف المفردات الجديد في content/vocabulary/science_space_a2.json
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/science_space_a2.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "science_space",
        "category_name": {
            "ar": "العلوم والابتكار والفضاء",
            "de": "Wissenschaft, Innovation & Weltraum",
            "en": "Science, Innovation & Space"
        },
        "level": "A2",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم علمية وفلكية في {vocab_path}")

# 2. توليد 25 أيقونة SVG خفيفة ومتجهية (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "sci_wissenschaft": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#4A148C"/><circle cx="50" cy="50" r="28" fill="#7B1FA2"/><ellipse cx="50" cy="50" rx="35" ry="12" stroke="#FFD54F" stroke-width="2.5" fill="none" transform="rotate(30 50 50)"/><ellipse cx="50" cy="50" rx="35" ry="12" stroke="#00E5FF" stroke-width="2.5" fill="none" transform="rotate(-30 50 50)"/><circle cx="50" cy="50" r="7" fill="#FFF"/></svg>',
    "sci_forscher": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="28" r="14" fill="#FFA726"/><path d="M26,80 C26,56 74,56 74,80 Z" fill="#ECEFF1"/><polygon points="46,42 54,42 50,60" fill="#00BCD4"/><rect x="65" y="45" width="10" height="24" rx="2" fill="#80DEEA"/><circle cx="70" cy="65" r="7" fill="#00ACC1"/></svg>',
    "sci_forschung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="20" width="56" height="66" rx="4" fill="#FFF" stroke="#455A64" stroke-width="3"/><circle cx="45" cy="45" r="14" fill="none" stroke="#E91E63" stroke-width="5"/><line x1="55" y1="55" x2="72" y2="72" stroke="#E91E63" stroke-width="6" stroke-linecap="round"/><line x1="30" y1="30" x2="60" y2="30" stroke="#78909C" stroke-width="3"/></svg>',
    "sci_labor": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M42,20 L58,20 L58,40 L75,70 C78,76 74,82 66,82 L34,82 C26,82 22,76 25,70 L42,40 Z" fill="#80DEEA" stroke="#00838F" stroke-width="4"/><path d="M30,68 L70,68 L66,82 L34,82 Z" fill="#00BCD4"/><circle cx="45" cy="74" r="3" fill="#FFF"/><circle cx="55" cy="62" r="2.5" fill="#FFF"/><circle cx="48" cy="52" r="2" fill="#FFF"/></svg>',
    "sci_experiment": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00897B"/><path d="M44,25 L56,25 L56,45 L68,68 C72,74 68,80 60,80 L40,80 C32,80 28,74 32,68 L44,45 Z" fill="#FFEB3B"/><circle cx="50" cy="65" r="4" fill="#E65100"/><circle cx="44" cy="72" r="3" fill="#E65100"/><circle cx="56" cy="74" r="2.5" fill="#E65100"/></svg>',
    "sci_entdeckung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="44" cy="44" r="24" fill="#E1F5FE" stroke="#0288D1" stroke-width="6"/><line x1="62" y1="62" x2="84" y2="84" stroke="#5D4037" stroke-width="8" stroke-linecap="round"/><polygon points="44,28 47,36 56,36 49,42 51,50 44,45 37,50 39,42 32,36 41,36" fill="#FFD54F"/></svg>',
    "sci_erfindung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="40" r="24" fill="#FFEB3B"/><path d="M40,62 L60,62 L56,76 L44,76 Z" fill="#78909C"/><line x1="50" y1="10" x2="50" y2="2" stroke="#FFA000" stroke-width="4" stroke-linecap="round"/><line x1="20" y1="20" x2="12" y2="12" stroke="#FFA000" stroke-width="4" stroke-linecap="round"/><line x1="80" y1="20" x2="88" y2="12" stroke="#FFA000" stroke-width="4" stroke-linecap="round"/><path d="M44,42 Q50,30 56,42" stroke="#F57F17" stroke-width="3" fill="none"/></svg>',
    "sci_innovation": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1565C0"/><polygon points="50,18 56,36 75,36 60,48 65,66 50,55 35,66 40,48 25,36 44,36" fill="#FFD54F"/><circle cx="50" cy="44" r="8" fill="#FFF"/></svg>',
    "sci_technologie": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="25" width="50" height="50" rx="8" fill="#37474F"/><rect x="35" y="35" width="30" height="30" rx="4" fill="#00E5FF"/><circle cx="50" cy="50" r="6" fill="#FFF"/><line x1="50" y1="12" x2="50" y2="25" stroke="#78909C" stroke-width="4"/><line x1="50" y1="75" x2="50" y2="88" stroke="#78909C" stroke-width="4"/><line x1="12" y1="50" x2="25" y2="50" stroke="#78909C" stroke-width="4"/><line x1="75" y1="50" x2="88" y2="50" stroke="#78909C" stroke-width="4"/></svg>',
    "sci_mikroskop": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M60,25 L45,45 L52,50 L67,30 Z" fill="#455A64"/><path d="M65,45 C65,65 45,75 35,70 L35,80 L75,80 L75,70 C75,55 70,45 65,45 Z" fill="#90A4AE"/><rect x="25" y="80" width="55" height="8" rx="2" fill="#37474F"/><circle cx="45" cy="55" r="4" fill="#FFCA28"/></svg>',
    "sci_teleskop": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="30,45 78,20 84,30 36,55" fill="#1565C0"/><polygon points="20,48 32,42 34,54 22,60" fill="#0D47A1"/><line x1="50" y1="42" x2="30" y2="85" stroke="#455A64" stroke-width="4"/><line x1="50" y1="42" x2="70" y2="85" stroke="#455A64" stroke-width="4"/><line x1="50" y1="42" x2="50" y2="85" stroke="#455A64" stroke-width="3"/><circle cx="85" cy="20" r="6" fill="#FFD54F"/></svg>',
    "sci_weltraum": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="10" y="10" width="80" height="80" rx="12" fill="#0D1B2A"/><circle cx="30" cy="30" r="2" fill="#FFF"/><circle cx="75" cy="25" r="1.5" fill="#FFF"/><circle cx="20" cy="70" r="2.5" fill="#FFF"/><circle cx="65" cy="75" r="1.5" fill="#FFF"/><circle cx="50" cy="50" r="16" fill="#E65100"/><ellipse cx="50" cy="50" rx="26" ry="6" stroke="#FFE082" stroke-width="3" fill="none" transform="rotate(-20 50 50)"/></svg>',
    "sci_universum": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1A237E"/><path d="M50,20 Q65,40 50,50 Q35,60 50,80" stroke="#E040FB" stroke-width="4" fill="none"/><path d="M20,50 Q40,35 50,50 Q60,65 80,50" stroke="#00E5FF" stroke-width="4" fill="none"/><circle cx="50" cy="50" r="6" fill="#FFF"/></svg>',
    "sci_galaxie": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0A0E27"/><path d="M50,50 Q75,35 70,18" stroke="#D500F9" stroke-width="4" fill="none" stroke-linecap="round"/><path d="M50,50 Q25,65 30,82" stroke="#D500F9" stroke-width="4" fill="none" stroke-linecap="round"/><path d="M50,50 Q65,75 82,70" stroke="#00B0FF" stroke-width="4" fill="none" stroke-linecap="round"/><path d="M50,50 Q35,25 18,30" stroke="#00B0FF" stroke-width="4" fill="none" stroke-linecap="round"/><circle cx="50" cy="50" r="8" fill="#FFF"/></svg>',
    "sci_stern": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#212121"/><polygon points="50,15 59,38 84,38 64,52 71,76 50,62 29,76 36,52 16,38 41,38" fill="#FFD54F"/><circle cx="50" cy="48" r="8" fill="#FFF"/></svg>',
    "sci_planet": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0277BD"/><path d="M25,35 Q40,25 55,30 Q65,45 45,60 Q30,65 25,35 Z" fill="#558B2F"/><path d="M55,55 Q70,50 80,65 Q75,80 60,78 Z" fill="#558B2F"/><ellipse cx="50" cy="50" rx="36" ry="12" fill="#FFF" opacity="0.15"/></svg>',
    "sci_mond": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1A237E"/><circle cx="50" cy="50" r="28" fill="#CFD8DC"/><circle cx="42" cy="42" r="5" fill="#B0BEC5"/><circle cx="58" cy="55" r="6" fill="#B0BEC5"/><circle cx="48" cy="64" r="3.5" fill="#B0BEC5"/></svg>',
    "sci_satellit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="42" y="42" width="16" height="16" rx="2" fill="#FFA000"/><rect x="15" y="45" width="22" height="10" fill="#1565C0"/><rect x="63" y="45" width="22" height="10" fill="#1565C0"/><line x1="37" y1="50" x2="42" y2="50" stroke="#37474F" stroke-width="3"/><line x1="58" y1="50" x2="63" y2="50" stroke="#37474F" stroke-width="3"/><circle cx="50" cy="34" r="3" fill="#E53935"/><line x1="50" y1="34" x2="50" y2="42" stroke="#37474F" stroke-width="2"/></svg>',
    "sci_rakete": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M50,15 C40,30 35,55 35,68 L65,68 C65,55 60,30 50,15 Z" fill="#ECEFF1"/><polygon points="35,55 20,72 35,68" fill="#D32F2F"/><polygon points="65,55 80,72 65,68" fill="#D32F2F"/><circle cx="50" cy="42" r="7" fill="#00BCD4"/><polygon points="42,68 58,68 50,88" fill="#FF9800"/></svg>',
    "sci_astronaut": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="30" y="20" width="40" height="40" rx="14" fill="#ECEFF1" stroke="#37474F" stroke-width="4"/><rect x="36" y="28" width="28" height="20" rx="8" fill="#FFD54F"/><path d="M25,82 C25,60 75,60 75,82 Z" fill="#ECEFF1"/><circle cx="50" cy="72" r="5" fill="#0288D1"/></svg>',
    "sci_schwerkraft": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="30" r="14" fill="#E91E63"/><path d="M50,48 L50,82 M40,72 L50,82 L60,72" stroke="#212121" stroke-width="6" fill="none" stroke-linecap="round" stroke-linejoin="round"/><line x1="25" y1="88" x2="75" y2="88" stroke="#37474F" stroke-width="6" stroke-linecap="round"/></svg>',
    "sci_ki": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="25" width="50" height="50" rx="12" fill="#00BCD4"/><circle cx="40" cy="45" r="5" fill="#FFF"/><circle cx="60" cy="45" r="5" fill="#FFF"/><path d="M40,62 Q50,70 60,62" stroke="#FFF" stroke-width="4" fill="none" stroke-linecap="round"/><circle cx="50" cy="18" r="4" fill="#FFD54F"/><line x1="50" y1="18" x2="50" y2="25" stroke="#00BCD4" stroke-width="3"/></svg>',
    "sci_roboter": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="30" y="28" width="40" height="34" rx="6" fill="#78909C"/><rect x="38" y="38" width="8" height="8" rx="2" fill="#FFD54F"/><rect x="54" y="38" width="8" height="8" rx="2" fill="#FFD54F"/><rect x="42" y="52" width="16" height="4" fill="#37474F"/><line x1="50" y1="18" x2="50" y2="28" stroke="#78909C" stroke-width="4"/><circle cx="50" cy="16" r="4" fill="#E53935"/><rect x="26" y="66" width="48" height="22" rx="4" fill="#546E7A"/></svg>',
    "sci_daten": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><ellipse cx="50" cy="28" rx="28" ry="10" fill="#1565C0"/><path d="M22,28 L22,50 C22,55 35,60 50,60 C65,60 78,55 78,50 L78,28" fill="#1E88E5"/><ellipse cx="50" cy="50" rx="28" ry="10" fill="#1565C0"/><path d="M22,50 L22,72 C22,77 35,82 50,82 C65,82 78,77 78,72 L78,50" fill="#1E88E5"/><ellipse cx="50" cy="72" rx="28" ry="10" fill="#1565C0"/></svg>',
    "sci_zukunft": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#311B92"/><polygon points="50,20 60,42 84,45 66,60 72,82 50,70 28,82 34,60 16,45 40,42" fill="#00E5FF"/><circle cx="50" cy="52" r="10" fill="#FFD54F"/></svg>'
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
            "description": f"Vector illustration for science and space concept: {c['english']['word']}"
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
    
    if "science_space_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/business_workplace_a2.json',",
            "'assets/content/vocabulary/business_workplace_a2.json',\n    'assets/content/vocabulary/science_space_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط science_space_a2.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "science_space" not in cat_code:
        entry = """    CategoryMeta(
      id: 'science_space',
      titleAr: 'العلوم والابتكار والفضاء',
      titleDe: 'Wissenschaft & Raumfahrt',
      titleEn: 'Science & Space',
      icon: Icons.rocket_launch_rounded,
      primaryColor: Color(0xFF4A148C),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم العلوم والفضاء في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 24", "TOTAL_VOCAB_CATEGORIES = 25")
    val_code = val_code.replace("TOTAL_CONCEPTS = 605", "TOTAL_CONCEPTS = 630")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 705", "TOTAL_SVG_ASSETS = 730")
    
    if "science_space_a2.json" not in val_code:
        val_code = val_code.replace(
            "'business_workplace_a2.json',",
            "'business_workplace_a2.json',\n    'science_space_a2.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (25 فئة، 630 مفهومًا، 730 أصلًا متجهيًا)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 042 Status (Completed - Level A2 Science & Space Category)
- **Feature:** Category 25: Science, Innovation & Space (`science_space_a2.json`).
- **New Concepts:** 25 trilingual vocabulary items for research, astronomy, artificial intelligence, spaceflight, and innovation.
- **New Visuals:** 25 unique lightweight SVG vectors (`sci_*.svg`).
- **Milestone Reached:** 25 Vocabulary Categories | 630 Core Concepts | 35 Base Verbs | 15 Perfekt Forms | 50 Syntax Exercises | 24 Prepositions | 5 Dialogues | Articles, Genitiv, Relativsätze & Konjunktiv II Engines | 730 Total SVG Icons.
- **Integration:** Active in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 042 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 042 بنجاح تام!")
