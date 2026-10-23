import json
import os

print("🚀 [CYCLE 027] بدء بناء قسم الصفات والخصائص (Qualities & Adjectives)...")

# 1. قائمة الـ 25 مفهومًا وصفيًا للقسم 16
concepts = [
    {
        "id": "adj_fast",
        "category": "qualities_adjectives",
        "arabic": {"word": "سَرِيعٌ", "transliteration": "Saree'", "notes": "صفة تدل على السرعة العالية في الحركة أو الإنجاز"},
        "german": {"article": "", "word": "schnell", "plural": "", "gender": "adjective", "example": "Der moderne Zug fährt sehr schnell."},
        "english": {"word": "fast / quick", "phonetic": "/fɑːst/", "example": "The express train is very fast."},
        "image_id": "img_adj_fast"
    },
    {
        "id": "adj_slow",
        "category": "qualities_adjectives",
        "arabic": {"word": "بَطِيءٌ", "transliteration": "Batee'", "notes": "ضد سريع، قليل السرعة"},
        "german": {"article": "", "word": "langsam", "plural": "", "gender": "adjective", "example": "Die Schildkröte bewegt sich sehr langsam."},
        "english": {"word": "slow", "phonetic": "/sləʊ/", "example": "The turtle moves at a very slow pace."},
        "image_id": "img_adj_slow"
    },
    {
        "id": "adj_easy",
        "category": "qualities_adjectives",
        "arabic": {"word": "سَهْلٌ / بَسِيطٌ", "transliteration": "Sahl", "notes": "غير معقد وميسور الفهم"},
        "german": {"article": "", "word": "einfach / leicht", "plural": "", "gender": "adjective", "example": "Diese Grammatikübung ist wirklich einfach."},
        "english": {"word": "easy / simple", "phonetic": "/ˈiː.zi/", "example": "This vocabulary exercise is quite easy."},
        "image_id": "img_adj_easy"
    },
    {
        "id": "adj_difficult",
        "category": "qualities_adjectives",
        "arabic": {"word": "صَعْبٌ / مُعَقَّدٌ", "transliteration": "Sa'b", "notes": "يتطلب جهدًا وتركيزًا كبيرين"},
        "german": {"article": "", "word": "schwierig / schwer", "plural": "", "gender": "adjective", "example": "Die Deutschprüfung war ziemlich schwierig."},
        "english": {"word": "difficult / hard", "phonetic": "/ˈdɪf.ɪ.kəlt/", "example": "The final test was somewhat difficult."},
        "image_id": "img_adj_difficult"
    },
    {
        "id": "adj_heavy",
        "category": "qualities_adjectives",
        "arabic": {"word": "ثَقِيلُ الوَزْنِ", "transliteration": "Thaqeel", "notes": "كبير الوزن وصعب الحمل"},
        "german": {"article": "", "word": "schwer", "plural": "", "gender": "adjective", "example": "Dieser Reisekoffer ist viel zu schwer."},
        "english": {"word": "heavy", "phonetic": "/ˈhev.i/", "example": "This suitcase is too heavy to carry alone."},
        "image_id": "img_adj_heavy"
    },
    {
        "id": "adj_light_weight",
        "category": "qualities_adjectives",
        "arabic": {"word": "خَفِيفُ الوَزْنِ", "transliteration": "Khafeef", "notes": "ضد ثقيل، يسير الحمل"},
        "german": {"article": "", "word": "leicht", "plural": "", "gender": "adjective", "example": "Die Feder ist unglaublich leicht."},
        "english": {"word": "light (weight)", "phonetic": "/laɪt/", "example": "A bird's feather is extremely light."},
        "image_id": "img_adj_light_weight"
    },
    {
        "id": "adj_clean",
        "category": "qualities_adjectives",
        "arabic": {"word": "نَظِيفٌ / طَاهِرٌ", "transliteration": "Natheef", "notes": "خالٍ من الأوساخ والشوائب"},
        "german": {"article": "", "word": "sauber", "plural": "", "gender": "adjective", "example": "Die Hotelzimmer sind immer blitzsauber."},
        "english": {"word": "clean", "phonetic": "/kliːn/", "example": "The hotel rooms are spotlessly clean."},
        "image_id": "img_adj_clean"
    },
    {
        "id": "adj_dirty",
        "category": "qualities_adjectives",
        "arabic": {"word": "مُتَّسِخٌ / غَيْرُ نَظِيفٍ", "transliteration": "Muttasikh", "notes": "يحتاج إلى غسيل وتنظيف"},
        "german": {"article": "", "word": "schmutzig", "plural": "", "gender": "adjective", "example": "Nach dem Spiel waren seine Schuhe schmutzig."},
        "english": {"word": "dirty", "phonetic": "/ˈdɜː.ti/", "example": "His shoes were dirty after playing outside."},
        "image_id": "img_adj_dirty"
    },
    {
        "id": "adj_expensive",
        "category": "qualities_adjectives",
        "arabic": {"word": "غَالٍ / ثَمِينٌ", "transliteration": "Ghalin", "notes": "مرتفع الثمن والقيمة المادية"},
        "german": {"article": "", "word": "teuer", "plural": "", "gender": "adjective", "example": "Dieses Designer-Kleid ist sehr teuer."},
        "english": {"word": "expensive", "phonetic": "/ɪkˈspen.sɪv/", "example": "That designer jacket is quite expensive."},
        "image_id": "img_adj_expensive"
    },
    {
        "id": "adj_cheap",
        "category": "qualities_adjectives",
        "arabic": {"word": "رَخِيصٌ / زَهِيدُ الثَّمَنِ", "transliteration": "Rakhees", "notes": "منخفض السعر والتكلفة"},
        "german": {"article": "", "word": "billig / günstig", "plural": "", "gender": "adjective", "example": "Auf dem Markt gibt es günstiges Obst."},
        "english": {"word": "cheap / affordable", "phonetic": "/tʃiːp/", "example": "Fresh fruit is very affordable at the local market."},
        "image_id": "img_adj_cheap"
    },
    {
        "id": "adj_strong",
        "category": "qualities_adjectives",
        "arabic": {"word": "قَوِيٌّ / شَدِيدُ البَأْسِ", "transliteration": "Qawiyy", "notes": "يمتلك طاقة وقدرة جسدية أو معنوية"},
        "german": {"article": "", "word": "stark", "plural": "", "gender": "adjective", "example": "Der Athlet ist außerordentlich stark."},
        "english": {"word": "strong", "phonetic": "/strɒŋ/", "example": "The weightlifter is exceptionally strong."},
        "image_id": "img_adj_strong"
    },
    {
        "id": "adj_weak",
        "category": "qualities_adjectives",
        "arabic": {"word": "ضَعِيفٌ / هَزِيلٌ", "transliteration": "Da'eef", "notes": "قليل القوة أو العزم"},
        "german": {"article": "", "word": "schwach", "plural": "", "gender": "adjective", "example": "Nach der Grippe fühlte er sich noch schwach."},
        "english": {"word": "weak", "phonetic": "/wiːk/", "example": "He still felt somewhat weak after the fever."},
        "image_id": "img_adj_weak"
    },
    {
        "id": "adj_quiet",
        "category": "qualities_adjectives",
        "arabic": {"word": "هَادِئٌ / سَاكِنٌ", "transliteration": "Hadi'", "notes": "خالٍ من الضجيج والاضطراب"},
        "german": {"article": "", "word": "ruhig / leise", "plural": "", "gender": "adjective", "example": "Im Lesesaal ist es wunderbar ruhig."},
        "english": {"word": "quiet / peaceful", "phonetic": "/ˈkwaɪ.ət/", "example": "The library reading room is very quiet."},
        "image_id": "img_adj_quiet"
    },
    {
        "id": "adj_loud",
        "category": "qualities_adjectives",
        "arabic": {"word": "صَاخِبٌ / عَالِي الصَّوْتِ", "transliteration": "Sakhib", "notes": "يحدث جلبة وضوضاء شديدة"},
        "german": {"article": "", "word": "laut", "plural": "", "gender": "adjective", "example": "Die Musik auf dem Konzert war extrem laut."},
        "english": {"word": "loud / noisy", "phonetic": "/laʊd/", "example": "The music at the open-air festival was very loud."},
        "image_id": "img_adj_loud"
    },
    {
        "id": "adj_early",
        "category": "qualities_adjectives",
        "arabic": {"word": "مُبَكِّرٌ / فِي الصَّبَاحِ الأَوَّلِ", "transliteration": "Mubakkir", "notes": "قبل الوقت المعتاد أو في أوله"},
        "german": {"article": "", "word": "früh", "plural": "", "gender": "adjective", "example": "Wir stehen jeden Tag sehr früh auf."},
        "english": {"word": "early", "phonetic": "/ˈɜː.li/", "example": "They wake up very early every weekday morning."},
        "image_id": "img_adj_early"
    },
    {
        "id": "adj_late",
        "category": "qualities_adjectives",
        "arabic": {"word": "مُتَأَخِّرٌ", "transliteration": "Muta'akh-khir", "notes": "بعد الوقت المحدد أو في الليل"},
        "german": {"article": "", "word": "spät", "plural": "", "gender": "adjective", "example": "Es ist schon spät, wir sollten schlafen gehen."},
        "english": {"word": "late", "phonetic": "/leɪt/", "example": "It is getting late, we should head home."},
        "image_id": "img_adj_late"
    },
    {
        "id": "adj_near",
        "category": "qualities_adjectives",
        "arabic": {"word": "قَرِيبٌ / غَيْرُ بَعِيدٍ", "transliteration": "Qareeb", "notes": "قريب في المسافة أو المكان"},
        "german": {"article": "", "word": "nah", "plural": "", "gender": "adjective", "example": "Die U-Bahn-Station ist ganz nah am Hotel."},
        "english": {"word": "near / close", "phonetic": "/nɪər/", "example": "The subway station is quite near our apartment."},
        "image_id": "img_adj_near"
    },
    {
        "id": "adj_far",
        "category": "qualities_adjectives",
        "arabic": {"word": "بَعِيدٌ / شَاسِعُ المَسَافَةِ", "transliteration": "Ba'eed", "notes": "يفصل بينه وبين المكان مسافة طويلة"},
        "german": {"article": "", "word": "weit / fern", "plural": "", "gender": "adjective", "example": "Der Flughafen liegt ziemlich weit von der Stadt entfernt."},
        "english": {"word": "far / distant", "phonetic": "/fɑːr/", "example": "The international airport is rather far from here."},
        "image_id": "img_adj_far"
    },
    {
        "id": "adj_bright",
        "category": "qualities_adjectives",
        "arabic": {"word": "سَاطِعٌ / مُضِيءٌ", "transliteration": "Sati'", "notes": "وافر الضوء والنور"},
        "german": {"article": "", "word": "hell", "plural": "", "gender": "adjective", "example": "Die Sonne scheint hell am blauen Himmel."},
        "english": {"word": "bright / light", "phonetic": "/braɪt/", "example": "The morning sun shines bright in the sky."},
        "image_id": "img_adj_bright"
    },
    {
        "id": "adj_dark",
        "category": "qualities_adjectives",
        "arabic": {"word": "مُظْلِمٌ / عَاتِمٌ", "transliteration": "Muthlim", "notes": "شديد السواد أو قليل الضوء"},
        "german": {"article": "", "word": "dunkel", "plural": "", "gender": "adjective", "example": "Im dichten Wald ist es nachts stockdunkel."},
        "english": {"word": "dark", "phonetic": "/dɑːk/", "example": "It gets pitch dark outside after twilight."},
        "image_id": "img_adj_dark"
    },
    {
        "id": "adj_sweet",
        "category": "qualities_adjectives",
        "arabic": {"word": "حُلْوُ المَذَاقِ", "transliteration": "Hulw", "notes": "طعمه كالسكر أو العسل"},
        "german": {"article": "", "word": "süß", "plural": "", "gender": "adjective", "example": "Die reifen Erdbeeren schmecken wunderbar süß."},
        "english": {"word": "sweet", "phonetic": "/swiːt/", "example": "These ripe strawberries taste delicious and sweet."},
        "image_id": "img_adj_sweet"
    },
    {
        "id": "adj_sour",
        "category": "qualities_adjectives",
        "arabic": {"word": "حَامِضُ الطَّعْمِ", "transliteration": "Hamid", "notes": "طعمه كالليمون أو الخل"},
        "german": {"article": "", "word": "sauer", "plural": "", "gender": "adjective", "example": "Frische Zitronen sind sehr sauer."},
        "english": {"word": "sour", "phonetic": "/saʊər/", "example": "Unsweetened lemon juice is extremely sour."},
        "image_id": "img_adj_sour"
    },
    {
        "id": "adj_safe",
        "category": "qualities_adjectives",
        "arabic": {"word": "آمِنٌ / سَلِيمٌ", "transliteration": "Aamin", "notes": "مطمئن لا خطر فيه"},
        "german": {"article": "", "word": "sicher", "plural": "", "gender": "adjective", "example": "Diese ruhige Nachbarschaft ist absolut sicher."},
        "english": {"word": "safe / secure", "phonetic": "/seɪf/", "example": "This residential area is remarkably safe."},
        "image_id": "img_adj_safe"
    },
    {
        "id": "adj_dangerous",
        "category": "qualities_adjectives",
        "arabic": {"word": "خَطِيرٌ / ذُو خَطَرٍ", "transliteration": "Khateer", "notes": "ينطوي على مجازفة وأذى محتمل"},
        "german": {"article": "", "word": "gefährlich", "plural": "", "gender": "adjective", "example": "Klettern ohne Seil ist lebensgefährlich."},
        "english": {"word": "dangerous", "phonetic": "/ˈdeɪn.dʒər.əs/", "example": "Climbing without safety equipment is very dangerous."},
        "image_id": "img_adj_dangerous"
    },
    {
        "id": "adj_important",
        "category": "qualities_adjectives",
        "arabic": {"word": "مُهِمٌّ / ضَرُورِيٌّ", "transliteration": "Muhimm", "notes": "ذو شأن وقيمة بالغة"},
        "german": {"article": "", "word": "wichtig", "plural": "", "gender": "adjective", "example": "Pünktlichkeit ist im Berufsleben sehr wichtig."},
        "english": {"word": "important", "phonetic": "/ɪmˈpɔː.tənt/", "example": "Punctuality is crucial and important in business."},
        "image_id": "img_adj_important"
    }
]

# حفظ ملف المفردات الجديد
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/qualities_adjectives_a1.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "qualities_adjectives",
        "category_name": {
            "ar": "الصفات والخصائص",
            "de": "Eigenschaften & Adjektive",
            "en": "Qualities & Adjectives"
        },
        "level": "A1",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم صفات في {vocab_path}")

# 2. توليد 25 أيقونة SVG متجهية متميزة وخفيفة (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "adj_fast": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M15,65 L55,20 L45,48 L85,48 L35,85 L45,58 Z" fill="#FF9800"/><path d="M10,40 L30,40 M15,50 L35,50 M10,60 L25,60" stroke="#FF5722" stroke-width="4" stroke-linecap="round"/></svg>',
    "adj_slow": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="50" r="28" fill="#8D6E63"/><path d="M45,50 Q45,35 60,35 Q60,50 45,50 Z" fill="#5D4037"/><path d="M68,58 C78,58 85,50 82,42 C80,36 74,40 70,45" fill="none" stroke="#8D6E63" stroke-width="8" stroke-linecap="round"/><circle cx="80" cy="40" r="2.5" fill="#3E2723"/><line x1="20" y1="78" x2="80" y2="78" stroke="#BDBDBD" stroke-width="4" stroke-linecap="round"/></svg>',
    "adj_easy": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="40" fill="#4CAF50"/><path d="M30,52 L44,66 L72,36" fill="none" stroke="#FFF" stroke-width="8" stroke-linecap="round"/><circle cx="70" cy="25" r="4" fill="#FFEB3B"/></svg>',
    "adj_difficult": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="20" width="60" height="60" fill="#455A64" rx="4"/><path d="M28,30 L72,30 L72,50 L40,50 L40,70 L60,70" fill="none" stroke="#ECEFF1" stroke-width="6" stroke-linecap="round"/><circle cx="68" cy="70" r="5" fill="#F44336"/></svg>',
    "adj_heavy": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="30,35 70,35 85,75 15,75" fill="#37474F"/><circle cx="50" cy="25" r="10" fill="none" stroke="#37474F" stroke-width="5"/><text x="50" y="65" font-family="sans-serif" font-weight="bold" font-size="20" fill="#CFD8DC" text-anchor="middle">50kg</text></svg>',
    "adj_light_weight": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M25,80 C25,50 40,30 75,20 C65,45 55,65 25,80 Z" fill="#81D4FA"/><line x1="25" y1="80" x2="70" y2="25" stroke="#0288D1" stroke-width="3"/></svg>',
    "adj_clean": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="55" r="30" fill="#E1F5FE" stroke="#03A9F4" stroke-width="4"/><polygon points="75,25 78,35 88,38 78,41 75,51 72,41 62,38 72,35" fill="#FFD54F"/><polygon points="30,20 32,26 38,28 32,30 30,36 28,30 22,28 28,26" fill="#FFD54F"/></svg>',
    "adj_dirty": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M30,35 Q45,20 60,32 Q80,25 75,50 Q85,75 60,70 Q45,85 30,70 Q15,65 20,48 Z" fill="#6D4C41"/><circle cx="35" cy="45" r="4" fill="#4E342E"/><circle cx="55" cy="55" r="5" fill="#4E342E"/><circle cx="65" cy="40" r="3" fill="#4E342E"/></svg>',
    "adj_expensive": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="30,30 70,30 85,50 50,85 15,50" fill="#00BCD4"/><polygon points="30,30 50,50 70,30" fill="#4DD0E1"/><polygon points="15,50 50,85 50,50" fill="#0097A7"/><polygon points="85,50 50,85 50,50" fill="#26C6DA"/><polygon points="15,50 30,30 50,50" fill="#80DEEA"/></svg>',
    "adj_cheap": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="20,50 45,25 80,25 80,60 55,85" fill="#4CAF50"/><circle cx="68" cy="37" r="5" fill="#FFF"/><text x="45" y="65" font-family="sans-serif" font-weight="bold" font-size="20" fill="#FFF" transform="rotate(-45 45 65)">%</text></svg>',
    "adj_strong": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M25,60 C20,40 35,25 50,30 C60,20 75,25 75,45 C75,65 55,75 35,75 Z" fill="#FFA726"/><path d="M35,60 Q50,45 65,55" fill="none" stroke="#E65100" stroke-width="4"/></svg>',
    "adj_weak": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M50,85 Q50,55 35,45 Q20,35 25,25" fill="none" stroke="#8D6E63" stroke-width="5" stroke-linecap="round"/><ellipse cx="22" cy="25" rx="8" ry="4" fill="#A5D6A7" transform="rotate(-30 22 25)"/><circle cx="50" cy="85" r="10" fill="#6D4C41"/></svg>',
    "adj_quiet": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="30,40 45,40 60,25 60,75 45,60 30,60" fill="#546E7A"/><line x1="68" y1="35" x2="88" y2="65" stroke="#F44336" stroke-width="5" stroke-linecap="round"/><line x1="88" y1="35" x2="68" y2="65" stroke="#F44336" stroke-width="5" stroke-linecap="round"/></svg>',
    "adj_loud": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="20,40 38,40 55,25 55,75 38,60 20,60" fill="#E53935"/><path d="M65,38 Q75,50 65,62" fill="none" stroke="#FF9800" stroke-width="5" stroke-linecap="round"/><path d="M75,28 Q92,50 75,72" fill="none" stroke="#FF9800" stroke-width="5" stroke-linecap="round"/></svg>',
    "adj_early": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><line x1="10" y1="65" x2="90" y2="65" stroke="#78909C" stroke-width="4"/><circle cx="50" cy="65" r="24" fill="#FFB300"/><line x1="50" y1="30" x2="50" y2="20" stroke="#FF9800" stroke-width="4" stroke-linecap="round"/><line x1="30" y1="40" x2="22" y2="32" stroke="#FF9800" stroke-width="4" stroke-linecap="round"/><line x1="70" y1="40" x2="78" y2="32" stroke="#FF9800" stroke-width="4" stroke-linecap="round"/></svg>',
    "adj_late": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="10" y="10" width="80" height="80" fill="#1A237E" rx="12"/><path d="M60,25 C40,25 25,40 25,60 C25,72 32,82 42,87 C38,80 35,70 35,60 C35,42 48,28 65,26 C63,25 61,25 60,25 Z" fill="#FFF59D"/><circle cx="70" cy="45" r="3" fill="#FFF"/><circle cx="60" cy="70" r="2" fill="#FFF"/><circle cx="78" cy="65" r="2.5" fill="#FFF"/></svg>',
    "adj_near": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="38" cy="50" r="16" fill="#1E88E5"/><circle cx="62" cy="50" r="16" fill="#E91E63"/><line x1="42" y1="50" x2="58" y2="50" stroke="#FFF" stroke-width="4"/></svg>',
    "adj_far": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="20" cy="50" r="12" fill="#1E88E5"/><circle cx="80" cy="50" r="12" fill="#E91E63"/><line x1="32" y1="50" x2="68" y2="50" stroke="#9E9E9E" stroke-width="4" stroke-dasharray="6,4"/></svg>',
    "adj_bright": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="45" r="22" fill="#FFEB3B"/><path d="M40,65 L60,65 L56,78 L44,78 Z" fill="#9E9E9E"/><line x1="50" y1="12" x2="50" y2="2" stroke="#FFC107" stroke-width="4" stroke-linecap="round"/><line x1="22" y1="22" x2="14" y2="14" stroke="#FFC107" stroke-width="4" stroke-linecap="round"/><line x1="78" y1="22" x2="86" y2="14" stroke="#FFC107" stroke-width="4" stroke-linecap="round"/><line x1="15" y1="45" x2="5" y2="45" stroke="#FFC107" stroke-width="4" stroke-linecap="round"/><line x1="85" y1="45" x2="95" y2="45" stroke="#FFC107" stroke-width="4" stroke-linecap="round"/></svg>',
    "adj_dark": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="40" fill="#212121"/><path d="M62,30 C45,30 35,45 35,60 C35,68 40,75 48,78 C42,72 40,64 40,56 C40,42 50,32 64,31 Z" fill="#E0E0E0"/></svg>',
    "adj_sweet": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="22" fill="#E91E63"/><polygon points="28,50 12,35 12,65" fill="#F48FB1"/><polygon points="72,50 88,35 88,65" fill="#F48FB1"/><circle cx="45" cy="45" r="5" fill="#FFF" opacity="0.6"/></svg>',
    "adj_sour": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M15,50 C15,25 35,15 65,25 C85,35 85,65 65,75 C35,85 15,75 15,50 Z" fill="#FFEB3B"/><path d="M30,50 Q50,30 65,40" stroke="#FBC02D" stroke-width="4" fill="none"/></svg>',
    "adj_safe": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M50,15 L80,25 C80,60 50,85 50,85 C50,85 20,60 20,25 Z" fill="#43A047"/><path d="M35,48 L45,58 L65,38" fill="none" stroke="#FFF" stroke-width="8" stroke-linecap="round"/></svg>',
    "adj_dangerous": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,15 90,85 10,85" fill="#FFC107"/><line x1="50" y1="38" x2="50" y2="60" stroke="#212121" stroke-width="8" stroke-linecap="round"/><circle cx="50" cy="74" r="5" fill="#212121"/></svg>',
    "adj_important": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#E53935"/><polygon points="50,22 58,38 76,40 62,54 66,72 50,62 34,72 38,54 24,40 42,38" fill="#FFF"/></svg>'
}

# كتابة ملفات الـ SVG الفردية
for c in concepts:
    c_id = c["id"]
    svg_content = svg_templates[c_id]
    svg_file = f"content/assets/svg/{c_id}.svg"
    with open(svg_file, "w", encoding="utf-8") as f:
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
            "description": f"Vector illustration for quality: {c['english']['word']}"
        })
        new_added += 1

with open(reg_path, "w", encoding="utf-8") as f:
    json.dump(registry, f, ensure_ascii=False, indent=2)

print(f"✅ تم تحديث سجل الأصول: إجمالي الأصول المسجلة = {len(registry['assets'])} (أضيف {new_added})")

# 4. تحديث ContentRepository في Dart
content_repo_path = "lib/repositories/content_repository.dart"
if os.path.exists(content_repo_path):
    with open(content_repo_path, "r", encoding="utf-8") as f:
        repo_code = f.read()
    
    if "qualities_adjectives_a1.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/education_school_a1.json',",
            "'assets/content/vocabulary/education_school_a1.json',\n    'assets/content/vocabulary/qualities_adjectives_a1.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط qualities_adjectives_a1.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "qualities_adjectives" not in cat_code:
        entry = """    CategoryMeta(
      id: 'qualities_adjectives',
      titleAr: 'الصفات والخصائص',
      titleDe: 'Eigenschaften & Adjektive',
      titleEn: 'Qualities & Adjectives',
      icon: Icons.auto_awesome,
      primaryColor: Color(0xFF00897B),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم الصفات والخصائص في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 15", "TOTAL_VOCAB_CATEGORIES = 16")
    val_code = val_code.replace("TOTAL_CONCEPTS = 380", "TOTAL_CONCEPTS = 405")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 420", "TOTAL_SVG_ASSETS = 445")
    
    if "qualities_adjectives_a1.json" not in val_code:
        val_code = val_code.replace(
            "'education_school_a1.json',",
            "'education_school_a1.json',\n    'qualities_adjectives_a1.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (16 فئة، 405 مفاهيم، 445 SVG)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 027 Status (Completed)
- **Feature:** Category 16: Qualities & Adjectives (`qualities_adjectives_a1.json`).
- **New Concepts:** 25 trilingual essential adjectives & antonyms.
- **New Visuals:** 25 unique lightweight SVG vectors (`adj_*.svg`).
- **Milestone Reached:** 16 Vocabulary Categories | 405 Core Concepts (Crossed 400+ threshold) | 445 Total SVG Icons.
- **Integrated:** Activated in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 027 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 027 بنجاح تام!")
