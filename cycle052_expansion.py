import json
import os

print("🚀 [CYCLE 052] بدء بناء قسم التاريخ والحضارات القديمة والآثار (History & Civilizations - A2)...")

# 1. قائمة الـ 25 مفهومًا لقسم التاريخ والحضارات القديمة
concepts = [
    {
        "id": "his_zivilisation",
        "category": "history_civilizations",
        "arabic": {"word": "الحَضَارَةُ الإِنْسَانِيَّةُ", "transliteration": "Al-Hadarah", "notes": "الرقي الفكري والعمراني والاجتماعي للشعوب"},
        "german": {"article": "die", "word": "Zivilisation", "plural": "die Zivilisationen", "gender": "feminine", "example": "Alte Zivilisationen hinterließen beeindruckende Monumente und Schriften."},
        "english": {"word": "civilization", "phonetic": "/ˌsɪv.əl.aɪˈzeɪ.ʃən/", "example": "Ancient civilizations built advanced irrigation and writing systems."},
        "image_id": "img_his_zivilisation"
    },
    {
        "id": "his_archaeologie",
        "category": "history_civilizations",
        "arabic": {"word": "عِلْمُ الآثَارِ", "transliteration": "Ilm Al-Aathar", "notes": "دراسة مخلفات الحضارات الإنسانية الماضية"},
        "german": {"article": "die", "word": "Archäologie", "plural": "die Archäologien", "gender": "feminine", "example": "Die moderne Archäologie nutzt Satellitenbilder zur Ortung antiker Stätten."},
        "english": {"word": "archaeology", "phonetic": "/ˌɑː.kiˈɒl.ə.dʒi/", "example": "Modern archaeology relies on satellite imagery to unearth buried ruins."},
        "image_id": "img_his_archaeologie"
    },
    {
        "id": "his_denkmal",
        "category": "history_civilizations",
        "arabic": {"word": "الأَثَرُ التَّارِيخِيُّ / النَّصْبُ التَّذْكَارِيُّ", "transliteration": "Al-Athar At-Tareekhi", "notes": "المبنى أو النصب المحفوظ تخليدًا لحدث تاريخي"},
        "german": {"article": "das", "word": "Denkmal", "plural": "die Denkmäler", "gender": "neuter", "example": "Dieses historische Denkmal erinnert an den Friedensvertrag von 1648."},
        "english": {"word": "historical monument", "phonetic": "/ˈmɒn.jə.mənt/", "example": "This stone monument commemorates the ancient peace treaty."},
        "image_id": "img_his_denkmal"
    },
    {
        "id": "his_pyramide",
        "category": "history_civilizations",
        "arabic": {"word": "الهَرَمُ الأَثَرِيُّ", "transliteration": "Al-Haram", "notes": "البناء الهندسي الحجري الشهير في الحضارات القديمة"},
        "german": {"article": "die", "word": "Pyramide", "plural": "die Pyramiden", "gender": "feminine", "example": "Die Pyramiden von Gizeh gehören zu den sieben Weltwundern der Antike."},
        "english": {"word": "pyramid", "phonetic": "/ˈpɪr.ə.mɪd/", "example": "The great stone pyramids showcase remarkable architectural precision."},
        "image_id": "img_his_pyramide"
    },
    {
        "id": "his_ruinen",
        "category": "history_civilizations",
        "arabic": {"word": "الأَطْلَالُ / الآثَارُ القَدِيمَةُ", "transliteration": "Al-Atlal", "notes": "بقايا المباني والمدن الغابرة"},
        "german": {"article": "die", "word": "Ruinen", "plural": "die Ruinen", "gender": "plural", "example": "Wir wanderten durch die eindrucksvollen römischen Ruinen in Jordanien."},
        "english": {"word": "ancient ruins", "phonetic": "/ˈruː.ɪnz/", "example": "Tourists explored the majestic Greco-Roman ruins under the sunset."},
        "image_id": "img_his_ruinen"
    },
    {
        "id": "his_reich",
        "category": "history_civilizations",
        "arabic": {"word": "الإِمْبِرَاطُورِيَّةُ / المَمْلَكَةُ العَظِيمَةُ", "transliteration": "Al-Imbratooriyyah", "notes": "دولة مترامية الأطراف تضم شعوبًا متعددة"},
        "german": {"article": "das", "word": "Reich", "plural": "die Reiche", "gender": "neuter", "example": "Das Römische Reich erstreckte sich über drei Kontinente."},
        "english": {"word": "empire", "phonetic": "/ˈem.paɪər/", "example": "The historic empire connected trade networks across three continents."},
        "image_id": "img_his_reich"
    },
    {
        "id": "his_jahrhundert",
        "category": "history_civilizations",
        "arabic": {"word": "القَرْنُ (مِئَةُ عَامٍ)", "transliteration": "Al-Qarn", "notes": "الفترة الزمنية البالغة مئة سنة"},
        "german": {"article": "das", "word": "Jahrhundert", "plural": "die Jahrhunderte", "gender": "neuter", "example": "Im fünfzehnten Jahrhundert veränderte der Buchdruck die Welt."},
        "english": {"word": "century", "phonetic": "/ˈsen.tʃər.i/", "example": "The invention of printing transformed learning in the fifteenth century."},
        "image_id": "img_his_jahrhundert"
    },
    {
        "id": "his_epoche",
        "category": "history_civilizations",
        "arabic": {"word": "العَصْرُ / الحِقْبَةُ التَّارِيخِيَّةُ", "transliteration": "Al-'Asr / Al-Hiqbah", "notes": "مرحلة تاريخية مميزة بخصائص معينة"},
        "german": {"article": "die", "word": "Epoche", "plural": "die Epochen", "gender": "feminine", "example": "Die Renaissance war eine blühende Epoche der Kunst und Philosophie."},
        "english": {"word": "era / epoch", "phonetic": "/ˈɪə.rə/", "example": "The Renaissance marked a transformative cultural era in science and arts."},
        "image_id": "img_his_epoche"
    },
    {
        "id": "his_koenig",
        "category": "history_civilizations",
        "arabic": {"word": "المَلِكُ", "transliteration": "Al-Malik", "notes": "الحاكم في النظام الملكي"},
        "german": {"article": "der", "word": "König", "plural": "die Könige", "gender": "masculine", "example": "Der weise König förderte Wissenschaft, Handel und Bildung."},
        "english": {"word": "king", "phonetic": "/kɪŋ/", "example": "The medieval king established peaceful treaties with neighboring realms."},
        "image_id": "img_his_koenig"
    },
    {
        "id": "his_koenigin",
        "category": "history_civilizations",
        "arabic": {"word": "المَلِكَةُ", "transliteration": "Al-Malikah", "notes": "الحاكمة أو قرينة الملك"},
        "german": {"article": "die", "word": "Königin", "plural": "die Königinnen", "gender": "feminine", "example": "Die Königin herrschte mit diplomatischem Geschick und Weitsicht."},
        "english": {"word": "queen", "phonetic": "/kwiːn/", "example": "The legendary queen ruled the ancient empire with renowned wisdom."},
        "image_id": "img_his_koenigin"
    },
    {
        "id": "his_ritter",
        "category": "history_civilizations",
        "arabic": {"word": "الفَارِسُ النَّبِيلُ", "transliteration": "Al-Faris", "notes": "المحارب الممتطي جوادًا والمتسلح بالدرع في العصور الوسطى"},
        "german": {"article": "der", "word": "Ritter", "plural": "die Ritter", "gender": "masculine", "example": "Der tapfere Ritter verteidigte die Burg gegen feindliche Angreifer."},
        "english": {"word": "knight", "phonetic": "/naɪt/", "example": "The armored knight pledged loyalty to protect his realm with honor."},
        "image_id": "img_his_ritter"
    },
    {
        "id": "his_burg",
        "category": "history_civilizations",
        "arabic": {"word": "القَلْعَةُ الحَصِينَةُ / الحِصْنُ", "transliteration": "Al-Qal'ah", "notes": "البناء الحصين على المرتفعات للدفاع والسكن"},
        "german": {"article": "die", "word": "Burg", "plural": "die Burgen", "gender": "feminine", "example": "Auf dem steilen Felsen thront eine mittelalterliche Burg."},
        "english": {"word": "castle / fortress", "phonetic": "/ˈkɑː.səl/", "example": "The stone fortress stands perched high atop the rugged mountain cliff."},
        "image_id": "img_his_burg"
    },
    {
        "id": "his_tempel",
        "category": "history_civilizations",
        "arabic": {"word": "المَعْبَدُ القَدِيمُ", "transliteration": "Al-Ma'bad", "notes": "دار العبادة والطقوس في الحضارات القديمة"},
        "german": {"article": "der", "word": "Tempel", "plural": "die Tempel", "gender": "masculine", "example": "Die mächtigen Säulen des antiken Tempels ragen in den blauen Himmel."},
        "english": {"word": "ancient temple", "phonetic": "/ˈtem.pəl/", "example": "Carved marble columns support the portico of the ancient temple."},
        "image_id": "img_his_tempel"
    },
    {
        "id": "his_grabmal",
        "category": "history_civilizations",
        "arabic": {"word": "المَقْبَرَةُ الأَثَرِيَّةُ / الضَّرِيحُ", "transliteration": "Al-Madfan / Ad-Dareeha", "notes": "النصب أو الغرفة المدفنية المزخرفة للملوك القدماء"},
        "german": {"article": "das", "word": "Grabmal", "plural": "die Grabmäler", "gender": "neuter", "example": "Das weltberühmte Grabmal des Tutanchamun enthielt kostbare Schätze."},
        "english": {"word": "tomb / mausoleum", "phonetic": "/tuːm/", "example": "Archaeologists uncovered pristine gold treasures within the royal tomb."},
        "image_id": "img_his_grabmal"
    },
    {
        "id": "his_hieroglyphen",
        "category": "history_civilizations",
        "arabic": {"word": "الهِيرُوغْلِيفِيَّةُ / الرُّمُوزُ المَنْقُوشَةُ", "transliteration": "Al-Heeroghleefiyyah", "notes": "الكتابة التصويرية القديمة في مصر وحضارات الشرق"},
        "german": {"article": "die", "word": "Hieroglyphen", "plural": "die Hieroglyphen", "gender": "plural", "example": "Mit dem Stein von Rosette gelang die Entzifferung der ägyptischen Hieroglyphen."},
        "english": {"word": "hieroglyphs", "phonetic": "/ˈhaɪə.rə.ɡlɪfs/", "example": "Scholars deciphered historical inscriptions recorded in ancient hieroglyphs."},
        "image_id": "img_his_hieroglyphen"
    },
    {
        "id": "his_papyrus",
        "category": "history_civilizations",
        "arabic": {"word": "وَرَقُ البَرْدِيِّ", "transliteration": "Waraq Al-Bardi", "notes": "مادة الكتابة الأولى المستخرجة من نبات البردي"},
        "german": {"article": "der", "word": "Papyrus", "plural": "die Papyri", "gender": "masculine", "example": "Uralte medizinische Rezepte wurden auf Papyrusrollen überliefert."},
        "english": {"word": "papyrus", "phonetic": "/pəˈpaɪ.rəs/", "example": "Ancient administrative records were written on durable papyrus scrolls."},
        "image_id": "img_his_papyrus"
    },
    {
        "id": "his_muenze",
        "category": "history_civilizations",
        "arabic": {"word": "العُمْلَةُ الأَثَرِيَّةُ المَسْكُوكَةُ", "transliteration": "Al-'Umlah Al-Athariyyah", "notes": "القطع النقدية المعدنية المسكوكة في العصور الغابرة"},
        "german": {"article": "die", "word": "Münze", "plural": "die Münzen", "gender": "feminine", "example": "Der Schatzsucher fand eine gut erhaltene römische Goldmünze."},
        "english": {"word": "ancient coin", "phonetic": "/kɔɪn/", "example": "The museum collection exhibits rare engraved Roman silver coins."},
        "image_id": "img_his_muenze"
    },
    {
        "id": "his_schwert",
        "category": "history_civilizations",
        "arabic": {"word": "السَّيْفُ", "transliteration": "As-Sayf", "notes": "السلاح المعدني ذو النصل القاطع المستخدم تاريخيًا"},
        "german": {"article": "das", "word": "Schwert", "plural": "die Schwerter", "gender": "neuter", "example": "Das geschmiedete Schwert trug kunstvolle heidnische Ornamente."},
        "english": {"word": "sword", "phonetic": "/sɔːd/", "example": "The forged steel sword was discovered inside a ceremonial royal tomb."},
        "image_id": "img_his_schwert"
    },
    {
        "id": "his_schild",
        "category": "history_civilizations",
        "arabic": {"word": "الدِّرْعُ / التُّرْسُ", "transliteration": "Ad-Dir' / At-Turs", "notes": "أداة الوقاية والحماية أثناء المبارزة والحروب القديمة"},
        "german": {"article": "der", "word": "Schild", "plural": "die Schilde", "gender": "masculine", "example": "Der bronzene Schild schützte den Krieger vor Speeren und Pfeilen."},
        "english": {"word": "shield", "phonetic": "/ʃiːld/", "example": "Warriors carried painted wooden shields into battlefield formations."},
        "image_id": "img_his_schild"
    },
    {
        "id": "his_legende",
        "category": "history_civilizations",
        "arabic": {"word": "الأُسْطُورَةُ / الحِكَايَةُ الشَّعْبِيَّةُ", "transliteration": "Al-Ustoorah", "notes": "الرواية التراثية المتناقلة الممزوجة بالخيال"},
        "german": {"article": "die", "word": "Legende", "plural": "die Legenden", "gender": "feminine", "example": "Zahlreiche Legenden ranken sich um den sagenumwobenen König Artus."},
        "english": {"word": "legend / myth", "phonetic": "/ˈledʒ.ənd/", "example": "Epic folk legends preserve cultural memory and ancestral values."},
        "image_id": "img_his_legende"
    },
    {
        "id": "his_kulturerbe",
        "category": "history_civilizations",
        "arabic": {"word": "التُّرَاثُ الثَّقَافِيُّ العَالَمِيُّ", "transliteration": "At-Turath Ath-Thaqafi", "notes": "الموروث الحضاري والمعماري المصنف للحماية الدولية"},
        "german": {"article": "das", "word": "Kulturerbe", "plural": "die Kulturerbe", "gender": "neuter", "example": "Die Felsenstadt Petra gehört zum geschützten UNESCO-Weltkulturerbe."},
        "english": {"word": "cultural heritage", "phonetic": "/ˈkʌl.tʃər.əl ˈher.ɪ.tɪdʒ/", "example": "UNESCO designated the ancient carved city as world cultural heritage."},
        "image_id": "img_his_kulturerbe"
    },
    {
        "id": "his_ausgrabung",
        "category": "history_civilizations",
        "arabic": {"word": "التَّنْقِيبُ الأَثَرِيُّ / الحَفْرِيَّةُ", "transliteration": "At-Tanqeeb", "notes": "الحفر المنهجي لاستخراج الآثار من باطن الأرض"},
        "german": {"article": "die", "word": "Ausgrabung", "plural": "die Ausgrabungen", "gender": "feminine", "example": "Bei den Ausgrabungen legten Archäologen ein antikes Theater frei."},
        "english": {"word": "archaeological excavation", "phonetic": "/ˌek.skəˈveɪ.ʃən/", "example": "Recent excavations in the valley uncovered an amphitheater."},
        "image_id": "img_his_ausgrabung"
    },
    {
        "id": "his_manuskript",
        "category": "history_civilizations",
        "arabic": {"word": "المَخْطُوطَةُ الأَثَرِيَّةُ", "transliteration": "Al-Makhtootah", "notes": "الوثيقة أو الكتاب المدون بخط اليد قبل الطباعة"},
        "german": {"article": "das", "word": "Manuskript", "plural": "die Manuskripte", "gender": "neuter", "example": "Das handgeschriebene Manuskript wird in der Universitätsbibliothek aufbewahrt."},
        "english": {"word": "ancient manuscript", "phonetic": "/ˈmæn.jə.skrɪpt/", "example": "Scholars conserved the illuminated manuscript under controlled climate."},
        "image_id": "img_his_manuskript"
    },
    {
        "id": "his_chronik",
        "category": "history_civilizations",
        "arabic": {"word": "السِّجِلُّ التَّارِيخِيُّ / الحَوْلِيَّةُ", "transliteration": "As-Sijill At-Tareekhi", "notes": "تدوين الوقائع التاريخية وفق تسلسلها الزمني"},
        "german": {"article": "die", "word": "Chronik", "plural": "die Chroniken", "gender": "feminine", "example": "Die Chronik der Stadt dokumentiert alle Ereignisse seit dem Mittelalter."},
        "english": {"word": "historical chronicle", "phonetic": "/ˈkrɒn.ɪ.kəl/", "example": "Monastic chronicles record weather anomalies and royal accessions."},
        "image_id": "img_his_chronik"
    },
    {
        "id": "his_dynastie",
        "category": "history_civilizations",
        "arabic": {"word": "السُّلَالَةُ الحَاكِمَةُ", "transliteration": "As-Sulalah Al-Hakamah", "notes": "سلسلة الحكام المتوارثين للحكم من نفس العائلة"},
        "german": {"article": "die", "word": "Dynastie", "plural": "die Dynastien", "gender": "feminine", "example": "Diese einflussreiche Dynastie prägte die Architektur über mehrere Generationen."},
        "english": {"word": "ruling dynasty", "phonetic": "/ˈdɪn.ə.sti/", "example": "The imperial dynasty oversaw monumental infrastructure projects."},
        "image_id": "img_his_dynastie"
    }
]

# حفظ ملف المفردات الجديد في content/vocabulary/history_civilizations_a2.json
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/history_civilizations_a2.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "history_civilizations",
        "category_name": {
            "ar": "التاريخ والحضارات القديمة",
            "de": "Geschichte & Zivilisationen",
            "en": "History & Civilizations"
        },
        "level": "A2",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم تاريخية وحضارية في {vocab_path}")

# 2. توليد 25 أيقونة SVG خفيفة ومتجهية (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "his_zivilisation": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#795548"/><polygon points="50,20 25,45 75,45" fill="#FFD54F"/><rect x="30" y="45" width="8" height="28" fill="#FFF"/><rect x="46" y="45" width="8" height="28" fill="#FFF"/><rect x="62" y="45" width="8" height="28" fill="#FFF"/><rect x="20" y="73" width="60" height="6" fill="#D7CCC8"/></svg>',
    "his_archaeologie": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#8D6E63"/><polygon points="35,65 65,35 72,42 42,72" fill="#D7CCC8"/><polygon points="25,75 35,65 42,72" fill="#5D4037"/><circle cx="68" cy="32" r="14" fill="#FFCA28"/><path d="M62,32 L66,36 L74,28" stroke="#3E2723" stroke-width="2.5" fill="none"/></svg>',
    "his_denkmal": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="75" width="50" height="15" fill="#4E342E"/><polygon points="40,75 46,25 54,25 60,75" fill="#BCAAA4"/><polygon points="46,25 50,15 54,25" fill="#FFD54F"/><rect x="35" y="70" width="30" height="5" fill="#8D6E63"/></svg>',
    "his_pyramide": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,18 15,80 85,80" fill="#FFA000"/><polygon points="50,18 85,80 62,80" fill="#FF8F00"/><polygon points="50,18 15,80 38,80" fill="#FFB300"/><circle cx="75" cy="25" r="8" fill="#F57F17"/></svg>',
    "his_ruinen": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="35" width="10" height="45" fill="#A1887F"/><rect x="45" y="50" width="10" height="30" fill="#A1887F"/><rect x="70" y="25" width="10" height="55" fill="#A1887F"/><polygon points="16,35 34,35 25,25" fill="#8D6E63"/><polygon points="66,25 84,25 75,15" fill="#8D6E63"/><line x1="10" y1="80" x2="90" y2="80" stroke="#5D4037" stroke-width="4"/></svg>',
    "his_reich": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#C2185B"/><polygon points="50,22 55,35 68,35 58,44 62,57 50,49 38,57 42,44 32,35 45,35" fill="#FFD54F"/><circle cx="50" cy="46" r="6" fill="#FFF"/><path d="M25,75 Q50,65 75,75" stroke="#FFD54F" stroke-width="5" fill="none"/></svg>',
    "his_jahrhundert": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#3E2723"/><circle cx="50" cy="50" r="28" fill="#FFF8E1"/><text x="50" y="58" font-family="serif" font-weight="bold" font-size="24" fill="#3E2723" text-anchor="middle">100</text></svg>',
    "his_epoche": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#5D4037"/><line x1="20" y1="50" x2="80" y2="50" stroke="#FFD54F" stroke-width="5" stroke-linecap="round"/><circle cx="30" cy="50" r="6" fill="#FFF"/><circle cx="50" cy="50" r="6" fill="#FFF"/><circle cx="70" cy="50" r="6" fill="#FFF"/></svg>',
    "his_koenig": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="35" r="14" fill="#FFA726"/><path d="M26,82 C26,58 74,58 74,82 Z" fill="#B71C1C"/><polygon points="36,25 40,32 50,22 60,32 64,25 64,35 36,35" fill="#FFD700"/><circle cx="50" cy="22" r="2" fill="#E53935"/></svg>',
    "his_koenigin": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="35" r="14" fill="#FFCC80"/><path d="M30,22 C42,14 58,14 70,22 C72,36 28,36 30,22 Z" fill="#4E342E"/><path d="M26,82 C26,58 74,58 74,82 Z" fill="#880E4F"/><polygon points="38,20 44,28 50,18 56,28 62,20 62,30 38,30" fill="#FFD700"/></svg>',
    "his_ritter": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="36" y="20" width="28" height="32" rx="6" fill="#90A4AE"/><line x1="42" y1="36" x2="58" y2="36" stroke="#263238" stroke-width="4"/><path d="M30,82 C30,55 70,55 70,82 Z" fill="#607D8B"/><line x1="68" y1="20" x2="82" y2="80" stroke="#FFD54F" stroke-width="4"/></svg>',
    "his_burg": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="40" width="56" height="40" fill="#78909C"/><rect x="20" y="28" width="16" height="52" fill="#546E7A"/><rect x="64" y="28" width="16" height="52" fill="#546E7A"/><polygon points="28,15 20,28 36,28" fill="#C62828"/><polygon points="72,15 64,28 80,28" fill="#C62828"/><rect x="44" y="60" width="12" height="20" rx="6" fill="#263238"/></svg>',
    "his_tempel": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,16 16,36 84,36" fill="#8D6E63"/><rect x="24" y="36" width="8" height="42" fill="#D7CCC8"/><rect x="40" y="36" width="8" height="42" fill="#D7CCC8"/><rect x="52" y="36" width="8" height="42" fill="#D7CCC8"/><rect x="68" y="36" width="8" height="42" fill="#D7CCC8"/><rect x="14" y="78" width="72" height="8" fill="#5D4037"/></svg>',
    "his_grabmal": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="45" width="50" height="35" rx="4" fill="#6D4C41"/><polygon points="20,45 50,22 80,45" fill="#5D4037"/><rect x="44" y="58" width="12" height="22" rx="2" fill="#3E2723"/><circle cx="50" cy="36" r="4" fill="#FFD54F"/></svg>',
    "his_hieroglyphen": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="15" width="60" height="70" rx="6" fill="#FFE082" stroke="#FF8F00" stroke-width="4"/><circle cx="36" cy="32" r="5" fill="#E65100"/><path d="M50,26 L64,36 M64,26 L50,36" stroke="#E65100" stroke-width="3"/><ellipse cx="50" cy="50" rx="14" ry="6" fill="none" stroke="#E65100" stroke-width="3"/><polygon points="40,65 60,65 50,75" fill="#E65100"/></svg>',
    "his_papyrus": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="26" y="20" width="48" height="60" rx="4" fill="#FFF9C4" stroke="#F57F17" stroke-width="3"/><ellipse cx="50" cy="20" rx="24" ry="6" fill="#FFF59D"/><ellipse cx="50" cy="80" rx="24" ry="6" fill="#FFF59D"/><line x1="36" y1="36" x2="64" y2="36" stroke="#795548" stroke-width="2.5"/><line x1="36" y1="46" x2="64" y2="46" stroke="#795548" stroke-width="2.5"/><line x1="36" y1="56" x2="64" y2="56" stroke="#795548" stroke-width="2.5"/><line x1="36" y1="66" x2="54" y2="66" stroke="#795548" stroke-width="2.5"/></svg>',
    "his_muenze": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FFA000"/><circle cx="50" cy="50" r="32" fill="#FFB300"/><circle cx="50" cy="50" r="24" fill="none" stroke="#FFE082" stroke-width="3" stroke-dasharray="6,4"/><polygon points="50,32 55,44 68,44 58,52 62,65 50,57 38,65 42,52 32,44 45,44" fill="#FFD54F"/></svg>',
    "his_schwert": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,12 55,22 55,68 50,72 45,68 45,22" fill="#CFD8DC"/><line x1="50" y1="12" x2="50" y2="70" stroke="#90A4AE" stroke-width="2"/><rect x="34" y="68" width="32" height="6" rx="2" fill="#D7CCC8"/><rect x="47" y="74" width="6" height="14" fill="#5D4037"/><circle cx="50" cy="90" r="4" fill="#FFD54F"/></svg>',
    "his_schild": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M50,15 L80,28 C80,65 50,85 50,85 C50,85 20,65 20,28 Z" fill="#8E24AA"/><path d="M50,22 L72,32 C72,60 50,76 50,76 C50,76 28,60 28,32 Z" fill="#BA68C8"/><polygon points="50,35 55,45 66,45 57,52 60,62 50,56 40,62 43,52 34,45 45,45" fill="#FFD54F"/></svg>',
    "his_legende": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#311B92"/><path d="M30,35 Q50,22 70,35 Q60,55 75,70 Q50,60 25,70 Q40,55 30,35 Z" fill="#FFD54F"/><circle cx="50" cy="46" r="6" fill="#FFF"/></svg>',
    "his_kulturerbe": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1565C0"/><polygon points="50,22 22,40 78,40" fill="#FFD54F"/><rect x="28" y="40" width="6" height="28" fill="#FFF"/><rect x="42" y="40" width="6" height="28" fill="#FFF"/><rect x="52" y="40" width="6" height="28" fill="#FFF"/><rect x="66" y="40" width="6" height="28" fill="#FFF"/><rect x="20" y="68" width="60" height="8" fill="#FFF"/><circle cx="50" cy="50" r="34" fill="none" stroke="#90CAF9" stroke-width="2.5" stroke-dasharray="6,4"/></svg>',
    "his_ausgrabung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="10,85 90,85 75,55 25,55" fill="#8D6E63"/><polygon points="35,62 65,32 72,39 42,69" fill="#BCAAA4"/><polygon points="26,71 35,62 42,69" fill="#4E342E"/><circle cx="50" cy="74" r="5" fill="#FFD54F"/></svg>',
    "his_manuskript": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="18" width="56" height="66" rx="4" fill="#FFF8E1" stroke="#8D6E63" stroke-width="3"/><text x="32" y="38" font-family="serif" font-weight="bold" font-size="20" fill="#C62828">A</text><line x1="48" y1="32" x2="68" y2="32" stroke="#5D4037" stroke-width="2.5"/><line x1="48" y1="40" x2="68" y2="40" stroke="#5D4037" stroke-width="2.5"/><line x1="32" y1="50" x2="68" y2="50" stroke="#8D6E63" stroke-width="2.5"/><line x1="32" y1="60" x2="68" y2="60" stroke="#8D6E63" stroke-width="2.5"/><line x1="32" y1="70" x2="56" y2="70" stroke="#8D6E63" stroke-width="2.5"/></svg>',
    "his_chronik": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="15" width="60" height="70" rx="5" fill="#4E342E"/><rect x="25" y="20" width="50" height="60" fill="#FFF8E1"/><line x1="32" y1="30" x2="68" y2="30" stroke="#3E2723" stroke-width="3"/><line x1="32" y1="42" x2="68" y2="42" stroke="#8D6E63" stroke-width="2.5"/><line x1="32" y1="52" x2="68" y2="52" stroke="#8D6E63" stroke-width="2.5"/><line x1="32" y1="62" x2="60" y2="62" stroke="#8D6E63" stroke-width="2.5"/><circle cx="50" cy="72" r="3" fill="#C62828"/></svg>',
    "his_dynastie": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#512DA8"/><polygon points="32,32 38,42 50,30 62,42 68,32 68,48 32,48" fill="#FFD54F"/><line x1="50" y1="52" x2="50" y2="68" stroke="#FFF" stroke-width="4" stroke-linecap="round"/><circle cx="35" cy="75" r="7" fill="#FFB74D"/><circle cx="65" cy="75" r="7" fill="#FFB74D"/><line x1="50" y1="68" x2="35" y2="75" stroke="#FFF" stroke-width="3"/><line x1="50" y1="68" x2="65" y2="75" stroke="#FFF" stroke-width="3"/></svg>'
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
            "description": f"Vector illustration for history concept: {c['english']['word']}"
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
    
    if "history_civilizations_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/economy_finance_a2.json',",
            "'assets/content/vocabulary/economy_finance_a2.json',\n    'assets/content/vocabulary/history_civilizations_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط history_civilizations_a2.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "history_civilizations" not in cat_code:
        entry = """    CategoryMeta(
      id: 'history_civilizations',
      titleAr: 'التاريخ والحضارات القديمة',
      titleDe: 'Geschichte & Zivilisationen',
      titleEn: 'History & Civilizations',
      icon: Icons.account_balance_rounded,
      primaryColor: Color(0xFF795548),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم التاريخ والحضارات في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 29", "TOTAL_VOCAB_CATEGORIES = 30")
    val_code = val_code.replace("TOTAL_CONCEPTS = 730", "TOTAL_CONCEPTS = 755")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 880", "TOTAL_SVG_ASSETS = 905")
    
    if "history_civilizations_a2.json" not in val_code:
        val_code = val_code.replace(
            "'economy_finance_a2.json',",
            "'economy_finance_a2.json',\n    'history_civilizations_a2.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (30 فئة، 755 مفهومًا، 905 أصول متجهية)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 052 Status (Completed - Level A2 History & Civilizations Category)
- **Feature:** Category 30: History, Civilizations & Archaeology (`history_civilizations_a2.json`).
- **New Concepts:** 25 trilingual vocabulary items for empires, pyramids, excavations, ancient artifacts, dynasties, and monuments.
- **New Visuals:** 25 unique lightweight SVG vectors (`his_*.svg`).
- **DOUBLE HISTORIC LANDMARK REACHED:**
  - 30 Vocabulary Categories.
  - 755 Core Vocabulary Concepts (Crossed 750+ word barrier).
  - 35 Base Verbs | 15 Perfekt Forms.
  - 75 Syntax Exercises (Sentence Builder).
  - 24 Prepositions | 5 Dialogues.
  - 9 Comprehensive Grammar Engines.
  - 905 Total SVG Vector Icons (Passed 900+ asset milestone).
- **Integration:** Active in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 052 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 052 بنجاح تام!")
