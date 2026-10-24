import json
import os

print("🚀 [CYCLE 057 - 1,000 SVGs CLUB] بدء بناء قسم السياحة والاستكشاف العالمي (Tourism & Travel - A2)...")

# 1. قائمة الـ 25 مفهومًا لقسم السياحة والسفر الدولي
concepts = [
    {
        "id": "tou_tourismus",
        "category": "tourism_travel",
        "arabic": {"word": "السِّيَاحَةُ / قِطَاعُ السَّفَرِ", "transliteration": "As-Siyahah", "notes": "النشاط الترفيهي والاستكشافي للتنقل بين البلدان"},
        "german": {"article": "der", "word": "Tourismus", "plural": "die Tourismen", "gender": "masculine", "example": "Der nachhaltige Tourismus schützt Natur und lokale Gemeinschaften."},
        "english": {"word": "tourism", "phonetic": "/ˈtʊə.rɪ.zəm/", "example": "Sustainable eco-tourism benefits remote rural communities."},
        "image_id": "img_tou_tourismus"
    },
    {
        "id": "tou_tourist",
        "category": "tourism_travel",
        "arabic": {"word": "السَّائِحُ", "transliteration": "As-Sa'ih", "notes": "المسافر لغرض الاستجمام أو التعرف الثقافي (يتبع N-Deklination)"},
        "german": {"article": "der", "word": "Tourist", "plural": "die Touristen", "gender": "masculine (n-Deklination)", "example": "Der interessierte Tourist fotografiert die historische Kathedrale."},
        "english": {"word": "tourist / traveler (male)", "phonetic": "/ˈtʊə.rɪst/", "example": "The foreign tourist admired the intricate palace architecture."},
        "image_id": "img_tou_tourist"
    },
    {
        "id": "tou_touristin",
        "category": "tourism_travel",
        "arabic": {"word": "السَّائِحَةُ", "transliteration": "As-Sa'ihah", "notes": "المسافرة لغرض الاستجمام والثقافة"},
        "german": {"article": "die", "word": "Touristin", "plural": "die Touristinnen", "gender": "feminine", "example": "Die Touristin erkundete die malerischen Gassen der Altstadt."},
        "english": {"word": "tourist / traveler (female)", "phonetic": "/ˈtʊə.rɪst/", "example": "The solo female tourist documented her trek across Europe."},
        "image_id": "img_tou_touristin"
    },
    {
        "id": "tou_reiseziel",
        "category": "tourism_travel",
        "arabic": {"word": "الوُجْهَةُ السِّيَاحِيَّةُ / المَقْصِدُ", "transliteration": "Al-Wijhah As-Siyahiyyah", "notes": "المكان المختار للسفر إليه"},
        "german": {"article": "das", "word": "Reiseziel", "plural": "die Reiseziele", "gender": "neuter", "example": "Die Alpen sind ein weltweit begehrtes Reiseziel für Wintersportler."},
        "english": {"word": "travel destination", "phonetic": "/ˈtræv.əl ˌdes.tɪˈneɪ.ʃən/", "example": "The coastal island is a top holiday travel destination."},
        "image_id": "img_tou_reiseziel"
    },
    {
        "id": "tou_reiseplan",
        "category": "tourism_travel",
        "arabic": {"word": "خَطُّ سَيْرِ الرِّحْلَةِ / الجَدْوَلُ", "transliteration": "Khatt Sayr Ar-Rihlah", "notes": "برنامج التنقل والمحطات المحددة مسبقًا"},
        "german": {"article": "der", "word": "Reiseplan", "plural": "die Reisepläne", "gender": "masculine", "example": "Wir haben einen abwechslungsreichen Reiseplan für zwei Wochen ausgearbeitet."},
        "english": {"word": "itinerary / travel plan", "phonetic": "/aɪˈtɪn.ər.ər.i/", "example": "Their vacation itinerary includes visits to three historic cities."},
        "image_id": "img_tou_reiseplan"
    },
    {
        "id": "tou_sehenswuerdigkeit",
        "category": "tourism_travel",
        "arabic": {"word": "المَعْلَمُ السِّيَاحِيُّ البَارِزُ", "transliteration": "Al-Ma'lam As-Siyahi", "notes": "الموقع الأثري أو المعماري الجذاب للزوار"},
        "german": {"article": "die", "word": "Sehenswürdigkeit", "plural": "die Sehenswürdigkeiten", "gender": "feminine", "example": "Das Brandenburger Tor ist die bekannteste Sehenswürdigkeit in Berlin."},
        "english": {"word": "tourist attraction / sight", "phonetic": "/əˈtræk.ʃən/", "example": "The ancient amphitheater is a major tourist attraction."},
        "image_id": "img_tou_sehenswuerdigkeit"
    },
    {
        "id": "tou_reisepass",
        "category": "tourism_travel",
        "arabic": {"word": "جَوَازُ السَّفَرِ", "transliteration": "Jawaz As-Safar", "notes": "وثيقة الهوية الدولية الرسمية للسفر بين الدول"},
        "german": {"article": "der", "word": "Reisepass", "plural": "die Reisepässe", "gender": "masculine", "example": "Vergiss nicht zu prüfen, ob dein Reisepass noch gültig ist."},
        "english": {"word": "passport", "phonetic": "/ˈpɑːs.pɔːt/", "example": "Keep your official passport in a secure travel wallet."},
        "image_id": "img_tou_reisepass"
    },
    {
        "id": "tou_visum",
        "category": "tourism_travel",
        "arabic": {"word": "تَأْشِيرَةُ الدُّخُولِ (الفِيزَا)", "transliteration": "Ta'sheerat Ad-Dukhool", "notes": "التصريح الدبلوماسي الرسمي لدخول أراضي الدولة"},
        "german": {"article": "das", "word": "Visum", "plural": "die Visa", "gender": "neuter", "example": "Für die Einreise in manche Länder benötigt man rechtzeitig ein Visum."},
        "english": {"word": "visa", "phonetic": "/ˈviː.zə/", "example": "International applicants must apply for a tourist visa early."},
        "image_id": "img_tou_visum"
    },
    {
        "id": "tou_zoll",
        "category": "tourism_travel",
        "arabic": {"word": "الجَمَارِكُ", "transliteration": "Al-Jamarik", "notes": "الهيئة الحدودية لمراقبة السلع والمسافرين"},
        "german": {"article": "der", "word": "Zoll", "plural": "die Zölle", "gender": "masculine", "example": "Am Flughafen kontrolliert der Zoll das Gepäck auf verbotene Waren."},
        "english": {"word": "customs", "phonetic": "/ˈkʌs.təmz/", "example": "Passengers must declare foreign purchases at airport customs."},
        "image_id": "img_tou_zoll"
    },
    {
        "id": "tou_grenze",
        "category": "tourism_travel",
        "arabic": {"word": "الحُدُودُ الدَّوْلِيَّةُ", "transliteration": "Al-Hudood", "notes": "الخط الفاصل السيادي بين بلدين"},
        "german": {"article": "die", "word": "Grenze", "plural": "die Grenzen", "gender": "feminine", "example": "Innerhalb des Schengen-Raums überquert man Grenzen ohne Passkontrolle."},
        "english": {"word": "border / frontier", "phonetic": "/ˈbɔː.dər/", "example": "Vehicles passed peacefully across the European border crossing."},
        "image_id": "img_tou_grenze"
    },
    {
        "id": "tou_reiseleiter",
        "category": "tourism_travel",
        "arabic": {"word": "المُرْشِدُ السِّيَاحِيُّ", "transliteration": "Al-Murshid As-Siyahi", "notes": "الدليل المصاحب للشرح وتوجيه الأفواج"},
        "german": {"article": "der", "word": "Reiseleiter", "plural": "die Reiseleiter", "gender": "masculine", "example": "Der ortskundige Reiseleiter erklärte uns die Geschichte des Schlosses."},
        "english": {"word": "tour guide", "phonetic": "/ˈtʊə ˌɡaɪd/", "example": "Our licensed tour guide provided fascinating historical context."},
        "image_id": "img_tou_reiseleiter"
    },
    {
        "id": "tou_gepaeck",
        "category": "tourism_travel",
        "arabic": {"word": "أَمْتِعَةُ السَّفَرِ", "transliteration": "Amti'at As-Safar", "notes": "مجموع الحقائب المنقولة مع المسافر (اسم مفرد دائم)"},
        "german": {"article": "das", "word": "Gepäck", "plural": "die Gepäcke", "gender": "neuter", "example": "Geben Sie Ihr schweres Gepäck bitte am Schalter auf."},
        "english": {"word": "luggage / baggage", "phonetic": "/ˈlʌɡ.ɪdʒ/", "example": "Airline passengers are permitted one piece of cabin luggage."},
        "image_id": "img_tou_gepaeck"
    },
    {
        "id": "tou_koffer",
        "category": "tourism_travel",
        "arabic": {"word": "حَقِيبَةُ السَّفَرِ", "transliteration": "Haqeebat As-Safar", "notes": "الصندوق المتنقل ذو العجلات لحمل الملابس"},
        "german": {"article": "der", "word": "Koffer", "plural": "die Koffer", "gender": "masculine", "example": "Er packte seinen robusten Koffer am Vorabend der Abreise."},
        "english": {"word": "suitcase", "phonetic": "/ˈsuːt.keɪs/", "example": "She packed her lightweight suitcase for the weekend getaway."},
        "image_id": "img_tou_koffer"
    },
    {
        "id": "tou_flugticket",
        "category": "tourism_travel",
        "arabic": {"word": "تَذْكِرَةُ الطَّيَرَانِ / بِطَاقَةُ الصُّعُودِ", "transliteration": "Tathkirat At-Tayaran", "notes": "وثيقة حجز مقعد السفر الجوي"},
        "german": {"article": "das", "word": "Flugticket", "plural": "die Flugtickets", "gender": "neuter", "example": "Ich habe mein digitales Flugticket auf dem Smartphone gespeichert."},
        "english": {"word": "flight ticket / boarding pass", "phonetic": "/ˈflaɪt ˌtɪk.ɪt/", "example": "Present your mobile flight ticket at the security gate."},
        "image_id": "img_tou_flugticket"
    },
    {
        "id": "tou_kreuzfahrt",
        "category": "tourism_travel",
        "arabic": {"word": "الرِّحْلَةُ البَحْرِيَّةُ (الكُرُوز)", "transliteration": "Ar-Rihlah Al-Bahriyyah", "notes": "السفر الاستجمامي على متن سفينة سياحية عملاقة"},
        "german": {"article": "die", "word": "Kreuzfahrt", "plural": "die Kreuzfahrten", "gender": "feminine", "example": "Eine entspannte Kreuzfahrt auf dem Mittelmeer ist ein unvergessliches Erlebnis."},
        "english": {"word": "cruise / sea voyage", "phonetic": "/kruːz/", "example": "They embarked on a Mediterranean luxury cruise for ten days."},
        "image_id": "img_tou_kreuzfahrt"
    },
    {
        "id": "tou_insel",
        "category": "tourism_travel",
        "arabic": {"word": "الجَزِيرَةُ", "transliteration": "Al-Jazeerah", "notes": "الأرض اليابسة المحاطة بالماء من جميع الجهات"},
        "german": {"article": "die", "word": "Insel", "plural": "die Inseln", "gender": "feminine", "example": "Rügen ist die flächenmäßig größte deutsche Insel in der Ostsee."},
        "english": {"word": "island", "phonetic": "/ˈaɪ.lənd/", "example": "The tropical island features turquoise lagoons and white sand."},
        "image_id": "img_tou_insel"
    },
    {
        "id": "tou_gebirge",
        "category": "tourism_travel",
        "arabic": {"word": "السِّلْسِلَةُ الجَبَلِيَّةُ", "transliteration": "As-Silsilah Al-Jabaliyyah", "notes": "مجموعة الجبال الشاهقة المترابطة"},
        "german": {"article": "das", "word": "Gebirge", "plural": "die Gebirge", "gender": "neuter", "example": "Das schneebedeckte Gebirge lockt Bergsteiger und Wanderer an."},
        "english": {"word": "mountain range", "phonetic": "/ˈmaʊn.tɪn reɪndʒ/", "example": "The rugged mountain range offers panoramic hiking trails."},
        "image_id": "img_tou_gebirge"
    },
    {
        "id": "tou_wasserfall",
        "category": "tourism_travel",
        "arabic": {"word": "الشَّلَّالُ الطَّبِيعِيُّ", "transliteration": "Ash-Shallal", "notes": "انحدار الماء المتدفق من علٍ بشدة وجمال"},
        "german": {"article": "der", "word": "Wasserfall", "plural": "die Wasserfälle", "gender": "masculine", "example": "Der tosende Wasserfall stürzt über fünfzig Meter in die Tiefe."},
        "english": {"word": "waterfall", "phonetic": "/ˈwɔː.tə.fɔːl/", "example": "The roaring waterfall cascades into a crystal-clear plunge pool."},
        "image_id": "img_tou_wasserfall"
    },
    {
        "id": "tou_resort",
        "category": "tourism_travel",
        "arabic": {"word": "المُنْتَجَعُ السِّيَاحِيُّ", "transliteration": "Al-Muntaja'", "notes": "المجمع الفندقي المتكامل للراحة والترفيه"},
        "german": {"article": "das", "word": "Resort", "plural": "die Resorts", "gender": "neuter", "example": "Das exklusive Strandresort bietet Schwimmbäder und hervorragendes Essen."},
        "english": {"word": "holiday resort", "phonetic": "/rɪˈzɔːt/", "example": "The seaside resort offers wellness spas and watersports."},
        "image_id": "img_tou_resort"
    },
    {
        "id": "tou_souvenir",
        "category": "tourism_travel",
        "arabic": {"word": "التِّذْكَارُ السِّيَاحِيُّ", "transliteration": "At-Tithkar", "notes": "القطعة المقتناة لتذكر زيارة بلد أو معلم"},
        "german": {"article": "das", "word": "Souvenir", "plural": "die Souvenirs", "gender": "neuter", "example": "Als schönes Souvenir brachte sie handbemalte Keramik aus Spanien mit."},
        "english": {"word": "souvenir / keepsake", "phonetic": "/ˌsuː.vənˈɪər/", "example": "He bought handcrafted ceramic plates as holiday souvenirs."},
        "image_id": "img_tou_souvenir"
    },
    {
        "id": "tou_abenteuer",
        "category": "tourism_travel",
        "arabic": {"word": "المُغَامَرَةُ الِاسْتِكْشَافِيَّةُ", "transliteration": "Al-Mughamarah", "notes": "التجربة المثيرة غير المألوفة في الطبيعة"},
        "german": {"article": "das", "word": "Abenteuer", "plural": "die Abenteuer", "gender": "neuter", "example": "Die Wüstensafari war ein unvergessliches und packendes Abenteuer."},
        "english": {"word": "adventure", "phonetic": "/ədˈven.tʃər/", "example": "Exploring the Amazon rainforest was an unforgettable adventure."},
        "image_id": "img_tou_abenteuer"
    },
    {
        "id": "tou_wechselstube",
        "category": "tourism_travel",
        "arabic": {"word": "مَكْتَبُ صِرَافَةِ العُمْلَاتِ", "transliteration": "Maktab As-Sirafah", "notes": "مكان تبديل النقود بين العملات الأجنبية"},
        "german": {"article": "die", "word": "Wechselstube", "plural": "die Wechselstuben", "gender": "feminine", "example": "In der Wechselstube am Bahnhof tauschte er Euro in Schweizer Franken."},
        "english": {"word": "currency exchange bureau", "phonetic": "/ˈkʌr.ən.si ɪksˌtʃeɪndʒ/", "example": "Check conversion fees at the airport currency exchange."},
        "image_id": "img_tou_wechselstube"
    },
    {
        "id": "tou_checkin",
        "category": "tourism_travel",
        "arabic": {"word": "إِجْرَاءَاتُ التَّسْجِيلِ / الوُصُولِ", "transliteration": "At-Tasjeel (Check-in)", "notes": "تأكيد الحضور واستلام بطاقة الغرفة أو الطيران"},
        "german": {"article": "der", "word": "Check-in", "plural": "die Check-ins", "gender": "masculine", "example": "Der Online-Check-in spart am Flughafen wertvolle Zeit."},
        "english": {"word": "check-in", "phonetic": "/ˈtʃek.ɪn/", "example": "Hotel check-in begins at three o'clock in the afternoon."},
        "image_id": "img_tou_checkin"
    },
    {
        "id": "tou_backpacking",
        "category": "tourism_travel",
        "arabic": {"word": "سِيَاحَةُ حَقِيبَةِ الظَّهْرِ", "transliteration": "Siyahat Haqibat Ath-Thahr", "notes": "السفر الاستكشافي الاقتصادي بحقيبة ظهر والتنقل الحر"},
        "german": {"article": "das", "word": "Backpacking", "plural": "die Backpackings", "gender": "neuter", "example": "Beim Backpacking durch Asien lernt man fremde Kulturen intensiv kennen."},
        "english": {"word": "backpacking", "phonetic": "/ˈbæk.pæk.ɪŋ/", "example": "Backpacking across Southeast Asia teaches self-reliance."},
        "image_id": "img_tou_backpacking"
    },
    {
        "id": "tou_weltwunder",
        "category": "tourism_travel",
        "arabic": {"word": "أُعْجُوبَةُ العَالَمِ", "transliteration": "U'joobat Al-'Alam", "notes": "الإنجاز المعماري الاستثنائي الخالد عبر التاريخ"},
        "german": {"article": "das", "word": "Weltwunder", "plural": "die Weltwunder", "gender": "neuter", "example": "Die Felsenstadt Petra in Jordanien gehört zu den neuen sieben Weltwundern."},
        "english": {"word": "wonder of the world", "phonetic": "/ˈwʌn.dər əv ðə wɜːld/", "example": "The ancient city of Petra is celebrated as a wonder of the world."},
        "image_id": "img_tou_weltwunder"
    }
]

# حفظ ملف المفردات الجديد في content/vocabulary/tourism_travel_a2.json
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/tourism_travel_a2.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "tourism_travel",
        "category_name": {
            "ar": "السياحة والاستكشاف العالمي",
            "de": "Tourismus & Kulturelle Entdeckungen",
            "en": "Global Tourism & Travel"
        },
        "level": "A2",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم سياحية واستكشافية في {vocab_path}")

# 2. توليد 25 أيقونة SVG متقنة وخفيفة (<1.5KB) لتكتمل الألفية (1,000 SVGs!)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "tou_tourismus": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0097A7"/><circle cx="50" cy="50" r="28" fill="#FFF"/><polygon points="50,22 55,42 75,42 59,54 65,74 50,62 35,74 41,54 25,42 45,42" fill="#FFA000"/><circle cx="50" cy="50" r="4" fill="#D32F2F"/></svg>',
    "tou_tourist": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="28" r="14" fill="#FFA726"/><path d="M22,82 C22,58 68,58 68,82 Z" fill="#0288D1"/><rect x="58" y="44" width="22" height="18" rx="3" fill="#37474F"/><circle cx="69" cy="53" r="5" fill="#B0BEC5"/><polygon points="32,20 45,10 58,20" fill="#FFB300"/></svg>',
    "tou_touristin": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="28" r="14" fill="#FFCC80"/><path d="M28,18 C38,10 52,10 62,18 C66,32 24,32 28,18 Z" fill="#4E342E"/><path d="M22,82 C22,58 68,58 68,82 Z" fill="#E91E63"/><rect x="58" y="44" width="22" height="18" rx="3" fill="#37474F"/><circle cx="69" cy="53" r="5" fill="#B0BEC5"/></svg>',
    "tou_reiseziel": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#4CAF50"/><circle cx="50" cy="50" r="26" fill="#FFF"/><path d="M50,24 C40,24 32,32 32,42 C32,56 50,76 50,76 C50,76 68,56 68,42 C68,32 60,24 50,24 Z" fill="#E53935"/><circle cx="50" cy="40" r="6" fill="#FFF"/></svg>',
    "tou_reiseplan": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="16" width="60" height="68" rx="5" fill="#FFF" stroke="#455A64" stroke-width="3"/><rect x="28" y="24" width="44" height="8" rx="2" fill="#00BCD4"/><circle cx="34" cy="44" r="4" fill="#FF9800"/><line x1="44" y1="44" x2="68" y2="44" stroke="#78909C" stroke-width="3"/><circle cx="34" cy="58" r="4" fill="#4CAF50"/><line x1="44" y1="58" x2="68" y2="58" stroke="#78909C" stroke-width="3"/><circle cx="34" cy="72" r="4" fill="#E53935"/><line x1="44" y1="72" x2="68" y2="72" stroke="#78909C" stroke-width="3"/></svg>',
    "tou_sehenswuerdigkeit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,15 20,40 80,40" fill="#37474F"/><rect x="25" y="40" width="8" height="38" fill="#B0BEC5"/><rect x="40" y="40" width="8" height="38" fill="#B0BEC5"/><rect x="52" y="40" width="8" height="38" fill="#B0BEC5"/><rect x="67" y="40" width="8" height="38" fill="#B0BEC5"/><rect x="18" y="78" width="64" height="8" fill="#263238"/><circle cx="50" cy="28" r="4" fill="#FFD54F"/><polygon points="75,20 80,30 70,30" fill="#E91E63"/></svg>',
    "tou_reisepass": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="15" width="56" height="70" rx="5" fill="#880E4F"/><circle cx="50" cy="45" r="16" fill="none" stroke="#FFD700" stroke-width="3"/><circle cx="50" cy="45" r="8" fill="#FFD700"/><rect x="32" y="68" width="36" height="6" rx="2" fill="#FFD700"/></svg>',
    "tou_visum": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="24" width="64" height="52" rx="4" fill="#FFF8E1" stroke="#FFA000" stroke-width="3"/><circle cx="35" cy="50" r="12" fill="#E0E0E0"/><rect x="52" y="40" width="22" height="4" fill="#757575"/><rect x="52" y="48" width="18" height="4" fill="#757575"/><polygon points="68,56 75,52 82,56 80,68 66,68" fill="#43A047"/></svg>',
    "tou_zoll": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#283593"/><rect x="25" y="32" width="50" height="36" rx="4" fill="#FFF"/><text x="50" y="55" font-family="sans-serif" font-weight="bold" font-size="16" fill="#283593" text-anchor="middle">ZOLL</text></svg>',
    "tou_grenze": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><line x1="50" y1="15" x2="50" y2="85" stroke="#E53935" stroke-width="6" stroke-dasharray="8,6"/><line x1="25" y1="50" x2="75" y2="50" stroke="#FFB300" stroke-width="5"/><circle cx="25" cy="50" r="6" fill="#1565C0"/><circle cx="75" cy="50" r="6" fill="#2E7D32"/></svg>',
    "tou_reiseleiter": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="30" r="14" fill="#FFA726"/><path d="M26,82 C26,58 74,58 74,82 Z" fill="#00897B"/><polygon points="46,44 54,44 50,60" fill="#FFF"/><line x1="68" y1="40" x2="84" y2="20" stroke="#E65100" stroke-width="4"/><polygon points="84,20 84,32 72,26" fill="#FF9800"/></svg>',
    "tou_gepaeck": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="35" width="38" height="45" rx="5" fill="#1565C0"/><rect x="52" y="45" width="32" height="35" rx="4" fill="#FF8F00"/><path d="M30,35 L30,22 C30,16 48,16 48,22 L48,35" stroke="#1565C0" stroke-width="5" fill="none"/></svg>',
    "tou_koffer": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="32" width="50" height="50" rx="6" fill="#E65100"/><path d="M38,32 L38,18 C38,12 62,12 62,18 L62,32" stroke="#BF360C" stroke-width="6" fill="none"/><circle cx="34" cy="85" r="4" fill="#37474F"/><circle cx="66" cy="85" r="4" fill="#37474F"/><line x1="25" y1="56" x2="75" y2="56" stroke="#FFA726" stroke-width="3"/></svg>',
    "tou_flugticket": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="30" width="64" height="40" rx="5" fill="#00ACC1"/><circle cx="18" cy="50" r="6" fill="#FFF"/><circle cx="82" cy="50" r="6" fill="#FFF"/><line x1="42" y1="30" x2="42" y2="70" stroke="#FFF" stroke-width="2.5" stroke-dasharray="4,4"/><polygon points="56,45 66,35 68,37 62,45 74,47 70,53 58,51 54,58 50,56" fill="#FFF"/></svg>',
    "tou_kreuzfahrt": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M15,65 Q32,58 50,65 Q68,72 85,65 L80,50 L20,50 Z" fill="#FFF" stroke="#1565C0" stroke-width="3"/><rect x="30" y="34" width="35" height="16" fill="#ECEFF1"/><rect x="42" y="24" width="8" height="10" fill="#E53935"/><path d="M10,75 Q30,68 50,75 Q70,82 90,75" stroke="#0288D1" stroke-width="5" fill="none"/></svg>',
    "tou_insel": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M15,75 Q50,65 85,75" stroke="#0288D1" stroke-width="6" fill="none"/><ellipse cx="50" cy="72" rx="30" ry="10" fill="#FFE082"/><path d="M48,70 Q54,45 42,35" stroke="#795548" stroke-width="5" fill="none" stroke-linecap="round"/><circle cx="40" cy="32" r="14" fill="#43A047"/></svg>',
    "tou_gebirge": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="15,80 45,25 75,80" fill="#546E7A"/><polygon points="45,25 35,42 45,38 55,42" fill="#ECEFF1"/><polygon points="50,80 72,40 95,80" fill="#78909C"/><polygon points="72,40 65,52 72,48 80,52" fill="#ECEFF1"/></svg>',
    "tou_wasserfall": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="20" width="30" height="65" fill="#4E342E"/><rect x="55" y="20" width="30" height="65" fill="#4E342E"/><path d="M40,25 L60,25 L58,85 L42,85 Z" fill="#80DEEA"/><line x1="46" y1="25" x2="46" y2="85" stroke="#00BCD4" stroke-width="2"/><line x1="54" y1="25" x2="54" y2="85" stroke="#00BCD4" stroke-width="2"/><ellipse cx="50" cy="85" rx="18" ry="6" fill="#E0F7FA"/></svg>',
    "tou_resort": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FFB74D"/><polygon points="50,22 18,52 82,52" fill="#E65100"/><rect x="25" y="52" width="50" height="28" fill="#FFF8E1"/><rect x="42" y="62" width="16" height="18" fill="#00897B"/><circle cx="76" cy="28" r="8" fill="#FFEB3B"/></svg>',
    "tou_souvenir": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="45" r="28" fill="#E1F5FE" stroke="#0288D1" stroke-width="4"/><polygon points="50,28 54,38 64,38 56,44 59,54 50,48 41,54 44,44 36,38 46,38" fill="#FFD54F"/><rect x="35" y="73" width="30" height="12" rx="3" fill="#5D4037"/></svg>',
    "tou_abenteuer": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#2E7D32"/><circle cx="50" cy="50" r="28" fill="#FFF"/><polygon points="50,26 56,46 50,42 44,46" fill="#D32F2F"/><polygon points="50,74 56,54 50,58 44,54" fill="#37474F"/><circle cx="50" cy="50" r="4" fill="#FFB300"/></svg>',
    "tou_wechselstube": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="38" cy="42" r="18" fill="#FFB300"/><text x="38" y="49" font-family="sans-serif" font-weight="bold" font-size="16" fill="#FFF" text-anchor="middle">€</text><circle cx="64" cy="60" r="18" fill="#2E7D32"/><text x="64" y="67" font-family="sans-serif" font-weight="bold" font-size="16" fill="#FFF" text-anchor="middle">$</text><path d="M50,26 L65,34 L50,42" fill="none" stroke="#E65100" stroke-width="3" stroke-linecap="round"/></svg>',
    "tou_checkin": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#3F51B5"/><path d="M30,52 L44,66 L72,36" fill="none" stroke="#FFF" stroke-width="8" stroke-linecap="round" stroke-linejoin="round"/><circle cx="70" cy="22" r="6" fill="#4CAF50"/></svg>',
    "tou_backpacking": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="30" y="28" width="40" height="52" rx="8" fill="#43A047"/><rect x="36" y="45" width="28" height="24" rx="4" fill="#2E7D32"/><path d="M40,28 L40,16 L60,16 L60,28" stroke="#1B5E20" stroke-width="5" fill="none"/><circle cx="50" cy="56" r="4" fill="#FFEB3B"/></svg>',
    "tou_weltwunder": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,15 88,85 12,85" fill="#FFA000"/><polygon points="50,15 88,85 64,85" fill="#FF8F00"/><polygon points="50,15 12,85 36,85" fill="#FFB300"/><polygon points="50,25 54,34 64,34 56,40 59,49 50,44 41,49 44,40 36,34 46,34" fill="#FFF"/></svg>'
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
            "description": f"Vector illustration for tourism concept: {c['english']['word']}"
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
    
    if "tourism_travel_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/psychology_behavior_a2.json',",
            "'assets/content/vocabulary/psychology_behavior_a2.json',\n    'assets/content/vocabulary/tourism_travel_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط tourism_travel_a2.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "tourism_travel" not in cat_code:
        entry = """    CategoryMeta(
      id: 'tourism_travel',
      titleAr: 'السياحة والاستكشاف العالمي',
      titleDe: 'Tourismus & Weltreisen',
      titleEn: 'Global Tourism & Travel',
      icon: Icons.travel_explore_rounded,
      primaryColor: Color(0xFF0097A7),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم السياحة والاستكشاف في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 32", "TOTAL_VOCAB_CATEGORIES = 33")
    val_code = val_code.replace("TOTAL_CONCEPTS = 805", "TOTAL_CONCEPTS = 830")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 975", "TOTAL_SVG_ASSETS = 1000")
    
    if "tourism_travel_a2.json" not in val_code:
        val_code = val_code.replace(
            "'psychology_behavior_a2.json',",
            "'psychology_behavior_a2.json',\n    'tourism_travel_a2.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (33 فئة، 830 مفهومًا، 1000 أصل متجهي - النادي الألفي!)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 057 Status (Completed - HISTORIC 1,000 SVGs CLUB MILESTONE 🏆)
- **Feature:** Category 33: Global Tourism & Cultural Exploration (`tourism_travel_a2.json`).
- **New Concepts:** 25 trilingual vocabulary items for global destinations, passports, visas, customs, itineraries, and world wonders.
- **New Visuals:** 25 unique lightweight SVG vectors (`tou_*.svg`).
- **HISTORIC MILLENNIUM ASSET LANDMARK (1,000 SVGs Reached!):**
  - 33 Vocabulary Categories.
  - 830 Core Vocabulary Concepts.
  - 35 Base Verbs | 15 Perfekt Forms.
  - 85 Syntax Exercises (Sentence Builder).
  - 24 Prepositions + 10 Temporal Systems.
  - 11 Comprehensive Grammar Engines.
  - 1,000 Total SVG Vector Assets.
- **Integration:** Active in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق إنجاز النادي الألفي في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 057 بنجاح تاريخي!")
