import json
import os

print("🚀 [CYCLE 031] بدء بناء قسم الثقافة والإعلام والفنون (Culture, Media & Arts)...")

# 1. قائمة الـ 25 مفهومًا لقسم الثقافة والإعلام والفنون
concepts = [
    {
        "id": "cul_museum",
        "category": "culture_media",
        "arabic": {"word": "المَتْحَفُ", "transliteration": "Al-Mathaf", "notes": "دار حفظ وعرض الآثار والفنون التاريخية"},
        "german": {"article": "das", "word": "Museum", "plural": "die Museen", "gender": "neuter", "example": "Wir besuchen am Samstag das historische Museum."},
        "english": {"word": "museum", "phonetic": "/mjuːˈziː.əm/", "example": "We plan to visit the historical museum this Saturday."},
        "image_id": "img_cul_museum"
    },
    {
        "id": "cul_theater",
        "category": "culture_media",
        "arabic": {"word": "المَسْرَحُ", "transliteration": "Al-Masrah", "notes": "مكان عرض المسرحيات والفنون الأدائية"},
        "german": {"article": "das", "word": "Theater", "plural": "die Theater", "gender": "neuter", "example": "Heute Abend schauen wir ein Drama im Theater an."},
        "english": {"word": "theater", "phonetic": "/ˈθɪə.tər/", "example": "We are watching a classic drama at the theater tonight."},
        "image_id": "img_cul_theater"
    },
    {
        "id": "cul_cinema",
        "category": "culture_media",
        "arabic": {"word": "السِّينَمَا / دَارُ العَرْضِ", "transliteration": "As-Cinema", "notes": "دار عرض الأفلام السينمائية"},
        "german": {"article": "das", "word": "Kino", "plural": "die Kinos", "gender": "neuter", "example": "Gehen wir am Wochenende zusammen ins Kino?"},
        "english": {"word": "cinema / movie theater", "phonetic": "/ˈsɪn.ə.mɑː/", "example": "Shall we go to the cinema together this weekend?"},
        "image_id": "img_cul_cinema"
    },
    {
        "id": "cul_concert",
        "category": "culture_media",
        "arabic": {"word": "الحَفْلُ المُوسِيقِيُّ", "transliteration": "Al-Hafl Al-Moseeqi", "notes": "عرض موسيقي حي بحضور الجمهور"},
        "german": {"article": "das", "word": "Konzert", "plural": "die Konzerte", "gender": "neuter", "example": "Das klassische Konzert im Park war wunderschön."},
        "english": {"word": "concert", "phonetic": "/ˈkɒn.sət/", "example": "The open-air orchestra concert was fantastic."},
        "image_id": "img_cul_concert"
    },
    {
        "id": "cul_music",
        "category": "culture_media",
        "arabic": {"word": "المُوسِيقَى", "transliteration": "Al-Moseeqa", "notes": "فن تأليف الأنغام والألحان"},
        "german": {"article": "die", "word": "Musik", "plural": "die Musiken", "gender": "feminine", "example": "Ich höre beim Lernen gerne ruhige Musik."},
        "english": {"word": "music", "phonetic": "/ˈmjuː.zɪk/", "example": "I love listening to relaxing acoustic music while reading."},
        "image_id": "img_cul_music"
    },
    {
        "id": "cul_art",
        "category": "culture_media",
        "arabic": {"word": "الفَنُّ", "transliteration": "Al-Fann", "notes": "التعبير الجمالي والإبداعي الإنساني"},
        "german": {"article": "die", "word": "Kunst", "plural": "die Künste", "gender": "feminine", "example": "Moderne Kunst regt viele interessante Diskussionen an."},
        "english": {"word": "art", "phonetic": "/ɑːt/", "example": "Modern art often sparks captivating conversations."},
        "image_id": "img_cul_art"
    },
    {
        "id": "cul_painting",
        "category": "culture_media",
        "arabic": {"word": "اللَّوْحَةُ الفَنِّيَّةُ", "transliteration": "Al-Lawhah Al-Fanniyyah", "notes": "رسمة تشكيلية بالألوان"},
        "german": {"article": "das", "word": "Gemälde", "plural": "die Gemälde", "gender": "neuter", "example": "Dieses berühmte Gemälde hängt in der Galerie."},
        "english": {"word": "painting", "phonetic": "/ˈpeɪn.tɪŋ/", "example": "This famous oil painting hangs in the national gallery."},
        "image_id": "img_cul_painting"
    },
    {
        "id": "cul_statue",
        "category": "culture_media",
        "arabic": {"word": "التِّمْثَالُ المَنْحُوتُ", "transliteration": "At-Timthal", "notes": "مجسم منحوت من الحجر أو البرونز"},
        "german": {"article": "die", "word": "Statue", "plural": "die Statuen", "gender": "feminine", "example": "Auf dem Marktplatz steht eine historische Statue."},
        "english": {"word": "statue / sculpture", "phonetic": "/ˈstætʃ.uː/", "example": "A bronze statue stands in the center of the town square."},
        "image_id": "img_cul_statue"
    },
    {
        "id": "cul_newspaper",
        "category": "culture_media",
        "arabic": {"word": "الجَرِيدَةُ / الصَّحِيفَةُ", "transliteration": "Al-Jareedah", "notes": "مطبوعة ورقية إخبارية يومية أو أسبوعية"},
        "german": {"article": "die", "word": "Zeitung", "plural": "die Zeitungen", "gender": "feminine", "example": "Mein Vater liest morgens beim Frühstück die Zeitung."},
        "english": {"word": "newspaper", "phonetic": "/ˈnjuːzˌpeɪ.pər/", "example": "My father reads the morning newspaper over breakfast."},
        "image_id": "img_cul_newspaper"
    },
    {
        "id": "cul_magazine",
        "category": "culture_media",
        "arabic": {"word": "المَجَلَّةُ الدَّوْرِيَّةُ", "transliteration": "Al-Majallah", "notes": "مطبوعة ثقافية أو ترفيهية دورية"},
        "german": {"article": "die", "word": "Zeitschrift", "plural": "die Zeitschriften", "gender": "feminine", "example": "Ich kaufe monatlich eine wissenschaftliche Zeitschrift."},
        "english": {"word": "magazine / journal", "phonetic": "/ˌmæɡ.əˈziːn/", "example": "She subscribes to a monthly cultural magazine."},
        "image_id": "img_cul_magazine"
    },
    {
        "id": "cul_television",
        "category": "culture_media",
        "arabic": {"word": "التِّلْفَازُ", "transliteration": "At-Tilfaz", "notes": "جهاز بث البرامج التلفزيونية"},
        "german": {"article": "der", "word": "Fernseher", "plural": "die Fernseher", "gender": "masculine", "example": "Wir haben einen großen Fernseher im Wohnzimmer."},
        "english": {"word": "television / TV", "phonetic": "/ˈtel.ɪ.vɪʒ.ən/", "example": "They have a smart television set in the living room."},
        "image_id": "img_cul_television"
    },
    {
        "id": "cul_radio",
        "category": "culture_media",
        "arabic": {"word": "المِذْيَاعُ / الرَّادْيُو", "transliteration": "Al-Mithya'", "notes": "جهاز استقبال البث الإذاعي الصوتي"},
        "german": {"article": "das", "word": "Radio", "plural": "die Radios", "gender": "neuter", "example": "Im Auto höre ich immer die Nachrichten im Radio."},
        "english": {"word": "radio", "phonetic": "/ˈreɪ.di.əʊ/", "example": "I tune into the local radio station while driving."},
        "image_id": "img_cul_radio"
    },
    {
        "id": "cul_news",
        "category": "culture_media",
        "arabic": {"word": "الأَخْبَارُ / الأَنْبَاءُ", "transliteration": "Al-Akhbar", "notes": "موجز الأحداث الجارية محليًا وعالميًا"},
        "german": {"article": "die", "word": "Nachrichten", "plural": "die Nachrichten", "gender": "plural", "example": "Um zwanzig Uhr beginnen die täglichen Fernsehnachrichten."},
        "english": {"word": "news", "phonetic": "/njuːz/", "example": "The evening news broadcast starts promptly at eight."},
        "image_id": "img_cul_news"
    },
    {
        "id": "cul_movie",
        "category": "culture_media",
        "arabic": {"word": "الفِيلْمُ السِّينَمَائِيُّ", "transliteration": "Al-Film", "notes": "عمل سينمائي مصور وقصة درامية"},
        "german": {"article": "der", "word": "Film", "plural": "die Filme", "gender": "masculine", "example": "Der neue Dokumentarfilm war äußerst spannend."},
        "english": {"word": "movie / film", "phonetic": "/muː.vi/", "example": "The newly released documentary film was inspiring."},
        "image_id": "img_cul_movie"
    },
    {
        "id": "cul_actor",
        "category": "culture_media",
        "arabic": {"word": "المُمَثِّلُ", "transliteration": "Al-Mumath-thil", "notes": "المؤدي المذكر للأدوار المسرحية أو السينمائية"},
        "german": {"article": "der", "word": "Schauspieler", "plural": "die Schauspieler", "gender": "masculine", "example": "Der talentierte Schauspieler spielte seine Rolle brillant."},
        "english": {"word": "actor", "phonetic": "/ˈæk.tər/", "example": "The talented actor portrayed his role convincingly."},
        "image_id": "img_cul_actor"
    },
    {
        "id": "cul_actress",
        "category": "culture_media",
        "arabic": {"word": "المُمَثِّلَةُ", "transliteration": "Al-Mumath-thilah", "notes": "المؤدية المؤنثة للأدوار المسرحية أو السينمائية"},
        "german": {"article": "die", "word": "Schauspielerin", "plural": "die Schauspielerinnen", "gender": "feminine", "example": "Die bekannte Schauspielerin gewann einen renommierten Preis."},
        "english": {"word": "actress", "phonetic": "/ˈæk.trəs/", "example": "The renowned actress won an international film award."},
        "image_id": "img_cul_actress"
    },
    {
        "id": "cul_author",
        "category": "culture_media",
        "arabic": {"word": "الكَاتِبُ / المُؤَلِّفُ", "transliteration": "Al-Katib", "notes": "مبدع النصوص والروايات الأدبية"},
        "german": {"article": "der", "word": "Autor", "plural": "die Autoren", "gender": "masculine", "example": "Der deutsche Autor stellte seinen neuen Roman vor."},
        "english": {"word": "author / writer", "phonetic": "/ˈɔː.θər/", "example": "The prominent author presented his latest novel."},
        "image_id": "img_cul_author"
    },
    {
        "id": "cul_song",
        "category": "culture_media",
        "arabic": {"word": "الأُغْنِيَةُ", "transliteration": "Al-Ughniyah", "notes": "قطعة موسيقية مصحوبة بالغناء"},
        "german": {"article": "das", "word": "Lied", "plural": "die Lieder", "gender": "neuter", "example": "Die Kinder singen fröhlich ein bekanntes Volkslied."},
        "english": {"word": "song", "phonetic": "/sɒŋ/", "example": "The choir sang a delightful traditional song."},
        "image_id": "img_cul_song"
    },
    {
        "id": "cul_instrument",
        "category": "culture_media",
        "arabic": {"word": "الآلَةُ المُوسِيقِيَّةُ", "transliteration": "Al-Alah Al-Moseeqiyyah", "notes": "أداة عزف الإيقاع والأنغام"},
        "german": {"article": "das", "word": "Musikinstrument", "plural": "die Musikinstrumente", "gender": "neuter", "example": "Er lernt schon seit zwei Jahren ein Musikinstrument."},
        "english": {"word": "musical instrument", "phonetic": "/ˈmjuː.zɪ.kəl ˈɪn.strə.mənt/", "example": "Learning a musical instrument enhances concentration."},
        "image_id": "img_cul_instrument"
    },
    {
        "id": "cul_guitar",
        "category": "culture_media",
        "arabic": {"word": "القِيثَارَةُ / الغِيتَارُ", "transliteration": "Al-Qeetharah", "notes": "آلة وترية شعبية للعزف"},
        "german": {"article": "die", "word": "Gitarre", "plural": "die Gitarren", "gender": "feminine", "example": "Sie spielt abends gerne spanische Lieder auf der Gitarre."},
        "english": {"word": "guitar", "phonetic": "/ɡɪˈtɑːr/", "example": "He learned to play acoustic guitar during his youth."},
        "image_id": "img_cul_guitar"
    },
    {
        "id": "cul_piano",
        "category": "culture_media",
        "arabic": {"word": "البِيَانُو", "transliteration": "Al-Piano", "notes": "آلة موسيقية وترية ذات مفاتيح بيضاء وسوداء"},
        "german": {"article": "das", "word": "Klavier", "plural": "die Klaviere", "gender": "neuter", "example": "Mein Bruder übt täglich eine Stunde am Klavier."},
        "english": {"word": "piano", "phonetic": "/piˈæn.əʊ/", "example": "She plays classical sonatas gracefully on the piano."},
        "image_id": "img_cul_piano"
    },
    {
        "id": "cul_exhibition",
        "category": "culture_media",
        "arabic": {"word": "المَعْرِضُ الفَنِّيُّ", "transliteration": "Al-Ma'rid Al-Fanni", "notes": "فعالية استعراض الإنتاج الإبداعي"},
        "german": {"article": "die", "word": "Ausstellung", "plural": "die Ausstellungen", "gender": "feminine", "example": "Die Fotoausstellung in der Galerie ist bis Sonntag geöffnet."},
        "english": {"word": "art exhibition", "phonetic": "/ˌek.sɪˈbɪʃ.ən/", "example": "The modern photography exhibition runs until Sunday."},
        "image_id": "img_cul_exhibition"
    },
    {
        "id": "cul_ticket",
        "category": "culture_media",
        "arabic": {"word": "تَذْكِرَةُ الدُّخُولِ", "transliteration": "Tathkirat Ad-Dukhool", "notes": "بطاقة تصريح الحضور للفعاليات"},
        "german": {"article": "die", "word": "Eintrittskarte", "plural": "die Eintrittskarten", "gender": "feminine", "example": "Ich habe zwei Eintrittskarten für das Theater reserviert."},
        "english": {"word": "admission ticket", "phonetic": "/ədˈmɪʃ.ən ˌtɪk.ɪt/", "example": "Please show your admission ticket at the main entrance."},
        "image_id": "img_cul_ticket"
    },
    {
        "id": "cul_culture",
        "category": "culture_media",
        "arabic": {"word": "الثَّقَافَةُ", "transliteration": "Ath-Thaqafah", "notes": "العادات والتقاليد والمعارف المشتركة للشعوب"},
        "german": {"article": "die", "word": "Kultur", "plural": "die Kulturen", "gender": "feminine", "example": "Das Erlernen einer Sprache öffnet Türen zu einer neuen Kultur."},
        "english": {"word": "culture", "phonetic": "/ˈkʌl.tʃər/", "example": "Learning a new language opens the door to another rich culture."},
        "image_id": "img_cul_culture"
    },
    {
        "id": "cul_history",
        "category": "culture_media",
        "arabic": {"word": "التَّارِيخُ", "transliteration": "At-Tareekh", "notes": "سجل الأحداث والماضي الإنساني"},
        "german": {"article": "die", "word": "Geschichte", "plural": "die Geschichten", "gender": "feminine", "example": "Die alte Stadt hat eine faszinierende und reiche Geschichte."},
        "english": {"word": "history", "phonetic": "/ˈhɪs.tər.i/", "example": "The ancient cathedral is steeped in centuries of history."},
        "image_id": "img_cul_history"
    }
]

# حفظ ملف المفردات الجديد
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/culture_media_a1.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "culture_media",
        "category_name": {
            "ar": "الثقافة والإعلام والفنون",
            "de": "Kultur, Medien & Kunst",
            "en": "Culture, Media & Arts"
        },
        "level": "A1",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم ثقافية وإعلامية في {vocab_path}")

# 2. توليد 25 أيقونة SVG خفيفة ومتجهية (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "cul_museum": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,15 15,35 85,35" fill="#455A64"/><rect x="22" y="35" width="8" height="45" fill="#90A4AE"/><rect x="40" y="35" width="8" height="45" fill="#90A4AE"/><rect x="58" y="35" width="8" height="45" fill="#90A4AE"/><rect x="74" y="35" width="8" height="45" fill="#90A4AE"/><rect x="15" y="80" width="70" height="10" fill="#37474F"/><circle cx="50" cy="27" r="4" fill="#FFD54F"/></svg>',
    "cul_theater": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="36" cy="45" r="22" fill="#E91E63"/><circle cx="64" cy="45" r="22" fill="#9C27B0"/><circle cx="30" cy="40" r="3" fill="#FFF"/><circle cx="42" cy="40" r="3" fill="#FFF"/><path d="M30,54 Q36,62 42,54" stroke="#FFF" stroke-width="3" fill="none"/><circle cx="58" cy="40" r="3" fill="#FFF"/><circle cx="70" cy="40" r="3" fill="#FFF"/><path d="M58,58 Q64,50 70,58" stroke="#FFF" stroke-width="3" fill="none"/></svg>',
    "cul_cinema": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="25" width="60" height="50" rx="6" fill="#D32F2F"/><polygon points="42,38 66,50 42,62" fill="#FFF"/><rect x="24" y="16" width="12" height="9" fill="#212121"/><rect x="44" y="16" width="12" height="9" fill="#212121"/><rect x="64" y="16" width="12" height="9" fill="#212121"/></svg>',
    "cul_concert": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="35" r="16" fill="#FFA000"/><polygon points="20,90 35,45 65,45 80,90" fill="#3949AB"/><circle cx="35" cy="85" r="8" fill="#5C6BC0"/><circle cx="50" cy="85" r="8" fill="#5C6BC0"/><circle cx="65" cy="85" r="8" fill="#5C6BC0"/><polygon points="50,10 53,20 63,22 55,29 57,39 50,33 43,39 45,29 37,22 47,20" fill="#FFD54F"/></svg>',
    "cul_music": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="35" cy="70" r="12" fill="#7B1FA2"/><circle cx="70" cy="60" r="12" fill="#7B1FA2"/><rect x="42" y="25" width="6" height="45" fill="#7B1FA2"/><rect x="77" y="15" width="6" height="45" fill="#7B1FA2"/><polygon points="42,25 83,15 83,27 42,37" fill="#BA68C8"/></svg>',
    "cul_art": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M25,50 C25,25 60,15 75,30 C85,40 85,60 70,75 C60,85 45,85 35,78 C30,72 25,65 25,50 Z" fill="#FFB74D"/><circle cx="45" cy="35" r="5" fill="#E53935"/><circle cx="62" cy="38" r="5" fill="#1E88E5"/><circle cx="70" cy="54" r="5" fill="#43A047"/><circle cx="42" cy="68" r="6" fill="#3E2723"/></svg>',
    "cul_painting": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="15" width="70" height="70" rx="4" fill="#8D6E63" stroke="#5D4037" stroke-width="4"/><rect x="22" y="22" width="56" height="56" fill="#81D4FA"/><polygon points="22,65 42,42 58,58 78,35 78,78 22,78" fill="#4CAF50"/><circle cx="36" cy="34" r="6" fill="#FDD835"/></svg>',
    "cul_statue": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="30" y="75" width="40" height="16" rx="2" fill="#78909C"/><rect x="36" y="65" width="28" height="10" fill="#90A4AE"/><circle cx="50" cy="28" r="10" fill="#CFD8DC"/><path d="M42,40 C42,36 58,36 58,40 L55,65 L45,65 Z" fill="#B0BEC5"/></svg>',
    "cul_newspaper": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="18" width="64" height="68" rx="3" fill="#ECEFF1" stroke="#90A4AE" stroke-width="3"/><rect x="25" y="26" width="50" height="8" rx="1" fill="#37474F"/><rect x="25" y="40" width="22" height="22" fill="#B0BEC5"/><line x1="52" y1="42" x2="75" y2="42" stroke="#455A64" stroke-width="3"/><line x1="52" y1="50" x2="75" y2="50" stroke="#455A64" stroke-width="3"/><line x1="52" y1="58" x2="75" y2="58" stroke="#455A64" stroke-width="3"/><line x1="25" y1="70" x2="75" y2="70" stroke="#78909C" stroke-width="2.5"/><line x1="25" y1="76" x2="65" y2="76" stroke="#78909C" stroke-width="2.5"/></svg>',
    "cul_magazine": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="24" y="15" width="56" height="70" rx="3" fill="#E91E63"/><rect x="30" y="22" width="44" height="10" fill="#FFF" rx="1"/><rect x="30" y="38" width="44" height="34" fill="#F8BBD0" rx="2"/><circle cx="52" cy="52" r="10" fill="#C2185B"/></svg>',
    "cul_television": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="25" width="70" height="52" rx="6" fill="#37474F"/><rect x="20" y="30" width="60" height="42" fill="#00BCD4"/><line x1="38" y1="12" x2="48" y2="25" stroke="#78909C" stroke-width="4"/><line x1="62" y1="12" x2="52" y2="25" stroke="#78909C" stroke-width="4"/><rect x="35" y="77" width="30" height="8" rx="2" fill="#455A64"/></svg>',
    "cul_radio": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="30" width="70" height="48" rx="6" fill="#795548"/><circle cx="40" cy="54" r="16" fill="#D7CCC8"/><circle cx="40" cy="54" r="6" fill="#5D4037"/><circle cx="70" cy="46" r="6" fill="#FFA000"/><circle cx="70" cy="62" r="6" fill="#FFA000"/><line x1="25" y1="30" x2="25" y2="14" stroke="#4E342E" stroke-width="4" stroke-linecap="round"/></svg>',
    "cul_news": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="20" width="70" height="60" rx="5" fill="#1565C0"/><text x="50" y="58" font-family="sans-serif" font-weight="bold" font-size="20" fill="#FFF" text-anchor="middle">NEWS</text><circle cx="28" cy="32" r="4" fill="#FF5252"/></svg>',
    "cul_movie": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="25" width="64" height="50" rx="4" fill="#212121"/><line x1="18" y1="36" x2="82" y2="36" stroke="#FFF" stroke-width="2"/><line x1="18" y1="64" x2="82" y2="64" stroke="#FFF" stroke-width="2"/><rect x="22" y="28" width="8" height="6" fill="#FFF"/><rect x="36" y="28" width="8" height="6" fill="#FFF"/><rect x="50" y="28" width="8" height="6" fill="#FFF"/><rect x="64" y="28" width="8" height="6" fill="#FFF"/><polygon points="44,42 60,50 44,58" fill="#FFC107"/></svg>',
    "cul_actor": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="32" r="15" fill="#FFA726"/><path d="M28,82 C28,58 72,58 72,82 Z" fill="#263238"/><polygon points="45,46 55,46 52,56 48,56" fill="#FF7043"/><polygon points="50,10 54,20 65,20 57,26 60,36 50,30 40,36 43,26 35,20 46,20" fill="#FFD54F"/></svg>',
    "cul_actress": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="32" r="14" fill="#FFCC80"/><path d="M32,22 C42,12 58,12 68,22 C72,38 28,38 32,22 Z" fill="#5D4037"/><path d="M28,82 C28,58 72,58 72,82 Z" fill="#D81B60"/><circle cx="50" cy="18" r="4" fill="#FFD54F"/></svg>',
    "cul_author": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="20" width="56" height="68" rx="4" fill="#FFF8E1" stroke="#8D6E63" stroke-width="3"/><line x1="30" y1="35" x2="65" y2="35" stroke="#6D4C41" stroke-width="3"/><line x1="30" y1="46" x2="70" y2="46" stroke="#8D6E63" stroke-width="2.5"/><line x1="30" y1="56" x2="60" y2="56" stroke="#8D6E63" stroke-width="2.5"/><path d="M62,65 L82,20 L86,24 L68,70 Z" fill="#0288D1"/></svg>',
    "cul_song": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FF4081"/><circle cx="40" cy="65" r="10" fill="#FFF"/><rect x="46" y="30" width="5" height="35" fill="#FFF"/><polygon points="46,30 68,22 68,34 46,42" fill="#FFF"/><circle cx="68" cy="55" r="7" fill="#FFF"/></svg>',
    "cul_instrument": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FFA000"/><path d="M25,75 L45,45 L55,55 L35,85 Z" fill="#5D4037"/><circle cx="35" cy="75" r="14" fill="#8D6E63"/><circle cx="35" cy="75" r="5" fill="#3E2723"/><line x1="45" y1="45" x2="78" y2="18" stroke="#D7CCC8" stroke-width="4"/></svg>',
    "cul_guitar": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="35" cy="65" r="20" fill="#E65100"/><circle cx="52" cy="48" r="13" fill="#E65100"/><circle cx="43" cy="56" r="6" fill="#3E2723"/><line x1="58" y1="42" x2="84" y2="16" stroke="#8D6E63" stroke-width="6"/><rect x="80" y="12" width="10" height="8" rx="2" fill="#5D4037"/></svg>',
    "cul_piano": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="25" width="70" height="50" rx="4" fill="#212121"/><rect x="18" y="45" width="64" height="26" fill="#FFF"/><line x1="26" y1="45" x2="26" y2="71" stroke="#212121" stroke-width="1.5"/><line x1="34" y1="45" x2="34" y2="71" stroke="#212121" stroke-width="1.5"/><line x1="42" y1="45" x2="42" y2="71" stroke="#212121" stroke-width="1.5"/><line x1="50" y1="45" x2="50" y2="71" stroke="#212121" stroke-width="1.5"/><line x1="58" y1="45" x2="58" y2="71" stroke="#212121" stroke-width="1.5"/><line x1="66" y1="45" x2="66" y2="71" stroke="#212121" stroke-width="1.5"/><line x1="74" y1="45" x2="74" y2="71" stroke="#212121" stroke-width="1.5"/><rect x="23" y="45" width="6" height="15" fill="#212121"/><rect x="31" y="45" width="6" height="15" fill="#212121"/><rect x="47" y="45" width="6" height="15" fill="#212121"/><rect x="55" y="45" width="6" height="15" fill="#212121"/><rect x="63" y="45" width="6" height="15" fill="#212121"/></svg>',
    "cul_exhibition": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><line x1="50" y1="15" x2="30" y2="75" stroke="#795548" stroke-width="5" stroke-linecap="round"/><line x1="50" y1="15" x2="70" y2="75" stroke="#795548" stroke-width="5" stroke-linecap="round"/><line x1="50" y1="15" x2="50" y2="80" stroke="#795548" stroke-width="4"/><rect x="25" y="30" width="50" height="35" rx="3" fill="#FFF" stroke="#4E342E" stroke-width="3"/><circle cx="45" cy="45" r="6" fill="#E91E63"/><polygon points="35,60 50,48 65,60" fill="#4CAF50"/></svg>',
    "cul_ticket": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="32" width="64" height="36" rx="4" fill="#FFB300"/><circle cx="18" cy="50" r="7" fill="#FFF"/><circle cx="82" cy="50" r="7" fill="#FFF"/><line x1="42" y1="36" x2="42" y2="64" stroke="#FFF" stroke-width="3" stroke-dasharray="4,4"/><circle cx="58" cy="50" r="6" fill="#D84315"/></svg>',
    "cul_culture": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#6A1B9A"/><ellipse cx="50" cy="50" rx="16" ry="38" stroke="#E1BEE7" stroke-width="2.5" fill="none"/><line x1="12" y1="50" x2="88" y2="50" stroke="#E1BEE7" stroke-width="2.5"/><polygon points="50,22 55,35 68,35 58,44 62,57 50,49 38,57 42,44 32,35 45,35" fill="#FFD54F"/></svg>',
    "cul_history": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#5D4037"/><circle cx="50" cy="50" r="30" fill="#FFF8E1"/><line x1="50" y1="50" x2="50" y2="30" stroke="#5D4037" stroke-width="4" stroke-linecap="round"/><line x1="50" y1="50" x2="65" y2="50" stroke="#5D4037" stroke-width="4" stroke-linecap="round"/><circle cx="50" cy="50" r="4" fill="#5D4037"/><line x1="50" y1="20" x2="50" y2="25" stroke="#8D6E63" stroke-width="3"/><line x1="80" y1="50" x2="75" y2="50" stroke="#8D6E63" stroke-width="3"/><line x1="50" y1="80" x2="50" y2="75" stroke="#8D6E63" stroke-width="3"/><line x1="20" y1="50" x2="25" y2="50" stroke="#8D6E63" stroke-width="3"/></svg>'
}

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
            "description": f"Vector illustration for culture concept: {c['english']['word']}"
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
    
    if "culture_media_a1.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/technology_digital_a1.json',",
            "'assets/content/vocabulary/technology_digital_a1.json',\n    'assets/content/vocabulary/culture_media_a1.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط culture_media_a1.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "culture_media" not in cat_code:
        entry = """    CategoryMeta(
      id: 'culture_media',
      titleAr: 'الثقافة والإعلام والفنون',
      titleDe: 'Kultur, Medien & Kunst',
      titleEn: 'Culture, Media & Arts',
      icon: Icons.palette_rounded,
      primaryColor: Color(0xFFAD1457),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم الثقافة والإعلام والفنون في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 18", "TOTAL_VOCAB_CATEGORIES = 19")
    val_code = val_code.replace("TOTAL_CONCEPTS = 455", "TOTAL_CONCEPTS = 480")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 505", "TOTAL_SVG_ASSETS = 530")
    
    if "culture_media_a1.json" not in val_code:
        val_code = val_code.replace(
            "'technology_digital_a1.json',",
            "'technology_digital_a1.json',\n    'culture_media_a1.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (19 فئة، 480 مفهومًا، 530 أصلًا متجهيًا)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 031 Status (Completed)
- **Feature:** Category 19: Culture, Media & Arts (`culture_media_a1.json`).
- **New Concepts:** 25 trilingual vocabulary items for arts, music instruments, literature, and news media.
- **New Visuals:** 25 unique lightweight SVG vectors (`cul_*.svg`).
- **Milestone Reached:** 19 Vocabulary Categories | 480 Core Concepts | 25 Verbs | 25 Sentences | 20 Prepositions | 5 Dialogues | Articles Engine | 530 Total SVG Icons.
- **Integration:** Active in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 031 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 031 بنجاح تام!")
