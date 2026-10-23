import json
import os

print("🚀 [CYCLE 030] بدء بناء قسم التقنية والعالم الرقمي (Technology & Digital World)...")

# 1. قائمة الـ 25 مفهومًا لقسم التقنية والعالم الرقمي
concepts = [
    {
        "id": "tech_computer",
        "category": "technology_digital",
        "arabic": {"word": "الحَاسُوبُ / الكُمْبِيُوتَرُ", "transliteration": "Al-Hasoob", "notes": "جهاز معالجة البيانات المكتبي"},
        "german": {"article": "der", "word": "Computer", "plural": "die Computer", "gender": "masculine", "example": "Der Computer im Büro funktioniert sehr schnell."},
        "english": {"word": "computer", "phonetic": "/kəmˈpjuː.tər/", "example": "The desktop computer in the office is powerful."},
        "image_id": "img_tech_computer"
    },
    {
        "id": "tech_laptop",
        "category": "technology_digital",
        "arabic": {"word": "الحَاسُوبُ المَحْمُولُ", "transliteration": "Al-Hasoob Al-Mahmool", "notes": "كمبيوتر شخصي متنقل وخفيف"},
        "german": {"article": "der", "word": "Laptop", "plural": "die Laptops", "gender": "masculine", "example": "Ich nehme meinen Laptop jeden Tag mit zur Universität."},
        "english": {"word": "laptop", "phonetic": "/ˈlæp.tɒp/", "example": "I take my laptop to lectures every day."},
        "image_id": "img_tech_laptop"
    },
    {
        "id": "tech_smartphone",
        "category": "technology_digital",
        "arabic": {"word": "الهَاتِفُ الذَّكِيُّ", "transliteration": "Al-Hatif Ath-Thaki", "notes": "هاتف متعدد الوظائف والاتصال"},
        "german": {"article": "das", "word": "Smartphone", "plural": "die Smartphones", "gender": "neuter", "example": "Mein Smartphone hat eine hochauflösende Kamera."},
        "english": {"word": "smartphone", "phonetic": "/ˈsmɑːt.fəʊn/", "example": "Her smartphone takes amazing high-resolution photos."},
        "image_id": "img_tech_smartphone"
    },
    {
        "id": "tech_tablet",
        "category": "technology_digital",
        "arabic": {"word": "الحَاسُوبُ اللَّوْحِيُّ / التَّابْلِت", "transliteration": "Al-Hasoob Al-Lawhi", "notes": "شاشة لمسية مسطحة تفاعلية"},
        "german": {"article": "das", "word": "Tablet", "plural": "die Tablets", "gender": "neuter", "example": "Auf dem Tablet lese ich abends gerne E-Books."},
        "english": {"word": "tablet", "phonetic": "/ˈtæb.lət/", "example": "He reads digital magazines comfortably on his tablet."},
        "image_id": "img_tech_tablet"
    },
    {
        "id": "tech_keyboard",
        "category": "technology_digital",
        "arabic": {"word": "لَوْحَةُ المَفَاتِيحِ", "transliteration": "Lawhat Al-Mafateeh", "notes": "أداة كتابة الحروف والأوامر"},
        "german": {"article": "die", "word": "Tastatur", "plural": "die Tastaturen", "gender": "feminine", "example": "Die kabellose Tastatur lässt sich angenehm bedienen."},
        "english": {"word": "keyboard", "phonetic": "/ˈkiː.bɔːd/", "example": "The mechanical keyboard has very responsive keys."},
        "image_id": "img_tech_keyboard"
    },
    {
        "id": "tech_mouse",
        "category": "technology_digital",
        "arabic": {"word": "فَأْرَةُ التَّحَكُّمِ", "transliteration": "Fa'rat At-Tahakkum", "notes": "مؤشر التوجيه والنقر بالحاسوب"},
        "german": {"article": "die", "word": "Maus", "plural": "die Mäuse", "gender": "feminine", "example": "Klicke mit der Maus doppelt auf das Symbol."},
        "english": {"word": "computer mouse", "phonetic": "/maʊs/", "example": "Double-click the desktop icon with your mouse."},
        "image_id": "img_tech_mouse"
    },
    {
        "id": "tech_screen",
        "category": "technology_digital",
        "arabic": {"word": "الشَّاشَةُ", "transliteration": "Ash-Shashah", "notes": "شاشة عرض البيانات والصور"},
        "german": {"article": "der", "word": "Bildschirm", "plural": "die Bildschirme", "gender": "masculine", "example": "Der neue Bildschirm zeigt kräftige und klare Farben."},
        "english": {"word": "screen / monitor", "phonetic": "/skriːn/", "example": "The high-definition screen shows vivid colors."},
        "image_id": "img_tech_screen"
    },
    {
        "id": "tech_headphones",
        "category": "technology_digital",
        "arabic": {"word": "سَمَّاعَاتُ الرَّأْسِ", "transliteration": "Samma'at Ar-Ra's", "notes": "سماعات الأذن للاستماع الصوتي"},
        "german": {"article": "die", "word": "Kopfhörer", "plural": "die Kopfhörer", "gender": "masculine", "example": "Im Zug höre ich Musik über meine Kopfhörer."},
        "english": {"word": "headphones", "phonetic": "/ˈhed.fəʊnz/", "example": "I listen to podcasts through my noise-cancelling headphones."},
        "image_id": "img_tech_headphones"
    },
    {
        "id": "tech_internet",
        "category": "technology_digital",
        "arabic": {"word": "الإِنْتَرْنِت / الشَّبَكَةُ الدَّوْلِيَّةُ", "transliteration": "Al-Internet", "notes": "الشبكة العالمية لربط المعلومات"},
        "german": {"article": "das", "word": "Internet", "plural": "die Internets", "gender": "neuter", "example": "Das Internet erleichtert das Lernen neuer Fremdsprachen enorm."},
        "english": {"word": "internet", "phonetic": "/ˈɪn.tə.net/", "example": "The internet makes global communication instantaneous."},
        "image_id": "img_tech_internet"
    },
    {
        "id": "tech_website",
        "category": "technology_digital",
        "arabic": {"word": "المَوْقِعُ الإِلِكْتُرُونِيُّ", "transliteration": "Al-Mawqi' Al-Elektroni", "notes": "صفحة أو منصة على الويب"},
        "german": {"article": "die", "word": "Webseite", "plural": "die Webseiten", "gender": "feminine", "example": "Besuchen Sie unsere informative Webseite für weitere Details."},
        "english": {"word": "website", "phonetic": "/ˈweb.saɪt/", "example": "Check out our official website for comprehensive tutorials."},
        "image_id": "img_tech_website"
    },
    {
        "id": "tech_email",
        "category": "technology_digital",
        "arabic": {"word": "البَرِيدُ الإِلِكْتُرُونِيُّ", "transliteration": "Al-Bareed Al-Elektroni", "notes": "الرسائل الرقمية عبر الشبكة"},
        "german": {"article": "die", "word": "E-Mail", "plural": "die E-Mails", "gender": "feminine", "example": "Ich habe dir gerade eine wichtige E-Mail geschickt."},
        "english": {"word": "email", "phonetic": "/ˈiː.meɪl/", "example": "I just sent you a confirmation email with all details."},
        "image_id": "img_tech_email"
    },
    {
        "id": "tech_password",
        "category": "technology_digital",
        "arabic": {"word": "كَلِمَةُ المُرُورِ / السِّرِّ", "transliteration": "Kalimat Al-Muroor", "notes": "رمز الحماية والتحقق الأمني"},
        "german": {"article": "das", "word": "Passwort", "plural": "die Passwörter", "gender": "neuter", "example": "Wähle immer ein sicheres Passwort mit Zahlen und Sonderzeichen."},
        "english": {"word": "password", "phonetic": "/ˈpɑːs.wɜːd/", "example": "Create a strong password to protect your user account."},
        "image_id": "img_tech_password"
    },
    {
        "id": "tech_app",
        "category": "technology_digital",
        "arabic": {"word": "التَّطْبِيقُ الرَّقْمِيُّ", "transliteration": "At-Tatbeeq", "notes": "برنامج مصغر للهواتف أو الحواسيب"},
        "german": {"article": "die", "word": "App", "plural": "die Apps", "gender": "feminine", "example": "Mit dieser App kann ich jeden Tag Vokabeln üben."},
        "english": {"word": "app / application", "phonetic": "/æp/", "example": "This learning app helps me practice German every morning."},
        "image_id": "img_tech_app"
    },
    {
        "id": "tech_download",
        "category": "technology_digital",
        "arabic": {"word": "التَّنْزِيلُ / التَّحْمِيلُ", "transliteration": "At-Tanzeel", "notes": "نقل البيانات من الخادم إلى الجهاز"},
        "german": {"article": "der", "word": "Download", "plural": "die Downloads", "gender": "masculine", "example": "Der Download der Datei ist in wenigen Sekunden abgeschlossen."},
        "english": {"word": "download", "phonetic": "/ˈdaʊn.ləʊd/", "example": "The document download finished in just a few seconds."},
        "image_id": "img_tech_download"
    },
    {
        "id": "tech_camera",
        "category": "technology_digital",
        "arabic": {"word": "الكَامِيرَا الرَّقْمِيَّةُ", "transliteration": "Al-Kamera", "notes": "أداة التقاط الصور وتسجيل الفيديو"},
        "german": {"article": "die", "word": "Kamera", "plural": "die Kameras", "gender": "feminine", "example": "Schalte bitte deine Kamera für das Online-Meeting ein."},
        "english": {"word": "camera", "phonetic": "/ˈkæm.rə/", "example": "Please turn on your camera during the video conference."},
        "image_id": "img_tech_camera"
    },
    {
        "id": "tech_battery",
        "category": "technology_digital",
        "arabic": {"word": "البَطَّارِيَّةُ", "transliteration": "Al-Battariyyah", "notes": "مصدر الطاقة المتجددة في الأجهزة"},
        "german": {"article": "der", "word": "Akku", "plural": "die Akkus", "gender": "masculine", "example": "Der Akku meines Handys ist fast leer."},
        "english": {"word": "battery", "phonetic": "/ˈbæt.ər.i/", "example": "My phone battery lasts for two full days."},
        "image_id": "img_tech_battery"
    },
    {
        "id": "tech_charger",
        "category": "technology_digital",
        "arabic": {"word": "الشَّاحِنُ / سِلْكُ الشَّحْنِ", "transliteration": "Ash-Shahin", "notes": "كابل تزويد البطارية بالكهرباء"},
        "german": {"article": "das", "word": "Ladekabel", "plural": "die Ladekabel", "gender": "neuter", "example": "Hast du ein passendes Ladekabel für mein Telefon?"},
        "english": {"word": "charger / charging cable", "phonetic": "/ˈtʃɑː.dʒər/", "example": "Do you have a USB-C charging cable I could borrow?"},
        "image_id": "img_tech_charger"
    },
    {
        "id": "tech_printer",
        "category": "technology_digital",
        "arabic": {"word": "الطَّابِعَةُ", "transliteration": "At-Tabi'ah", "notes": "جهاز طباعة النصوص والوثائق"},
        "german": {"article": "der", "word": "Drucker", "plural": "die Drucker", "gender": "masculine", "example": "Der Drucker druckt die Übungsblätter in Farbe."},
        "english": {"word": "printer", "phonetic": "/ˈprɪn.tər/", "example": "The office printer prints double-sided pages quickly."},
        "image_id": "img_tech_printer"
    },
    {
        "id": "tech_wifi",
        "category": "technology_digital",
        "arabic": {"word": "الشَّبَكَةُ اللَّاسِلْكِيَّةُ (الواي فاي)", "transliteration": "Al-Wi-Fi", "notes": "الاتصال اللاسلكي بالإنترنت"},
        "german": {"article": "das", "word": "WLAN", "plural": "die WLANs", "gender": "neuter", "example": "Gibt es hier im Café ein kostenloses WLAN?"},
        "english": {"word": "Wi-Fi / wireless network", "phonetic": "/ˈwaɪ.faɪ/", "example": "Is there free Wi-Fi access available in this coffee shop?"},
        "image_id": "img_tech_wifi"
    },
    {
        "id": "tech_file",
        "category": "technology_digital",
        "arabic": {"word": "المَلَفُّ الرَّقْمِيُّ", "transliteration": "Al-Malaff", "notes": "وحدة حفظ المستندات والبيانات"},
        "german": {"article": "die", "word": "Datei", "plural": "die Dateien", "gender": "feminine", "example": "Ich speichere die fertige Datei auf dem Desktop ab."},
        "english": {"word": "digital file", "phonetic": "/faɪl/", "example": "Make sure you save the document file before closing."},
        "image_id": "img_tech_file"
    },
    {
        "id": "tech_folder",
        "category": "technology_digital",
        "arabic": {"word": "المُجَلَّدُ الرَّقْمِيُّ", "transliteration": "Al-Mujallad", "notes": "حاوية تنظيم الملفات داخل النظام"},
        "german": {"article": "der", "word": "Ordner", "plural": "die Ordner", "gender": "masculine", "example": "Erstelle einen neuen Ordner für deine Deutschkurse."},
        "english": {"word": "folder", "phonetic": "/ˈfəʊl.dər/", "example": "Create a new project folder to keep documents organized."},
        "image_id": "img_tech_folder"
    },
    {
        "id": "tech_message",
        "category": "technology_digital",
        "arabic": {"word": "الرِّسَالَةُ النَّصِّيَّةُ", "transliteration": "Ar-Risalah An-Nassiyyah", "notes": "رسالة سريعة عبر المحادثات الفورية"},
        "german": {"article": "die", "word": "Nachricht", "plural": "die Nachrichten", "gender": "feminine", "example": "Schreib mir eine kurze Nachricht, wenn du ankommst."},
        "english": {"word": "text message", "phonetic": "/ˈmes.ɪdʒ/", "example": "Send me a quick text message when you arrive safely."},
        "image_id": "img_tech_message"
    },
    {
        "id": "tech_link",
        "category": "technology_digital",
        "arabic": {"word": "الرَّابِطُ التَّشَعُّبِيُّ", "transliteration": "Ar-Rabit", "notes": "عنوان URL للانتقال إلى صفحة أخرى"},
        "german": {"article": "der", "word": "Link", "plural": "die Links", "gender": "masculine", "example": "Klicke einfach auf den blauen Link im Text."},
        "english": {"word": "hyperlink / web link", "phonetic": "/lɪŋk/", "example": "Click on the shared link to access the live dashboard."},
        "image_id": "img_tech_link"
    },
    {
        "id": "tech_social_media",
        "category": "technology_digital",
        "arabic": {"word": "وَسَائِلُ التَّوَاصُلِ الِاجْتِمَاعِيِّ", "transliteration": "Wasa'il At-Tawasul", "notes": "شبكات ومنصات التفاعل الجماعي"},
        "german": {"article": "die", "word": "sozialen Medien", "plural": "die sozialen Medien", "gender": "plural", "example": "Viele Menschen nutzen soziale Medien zum Informationsaustausch."},
        "english": {"word": "social media", "phonetic": "/ˌsəʊ.ʃəl ˈmiː.di.ə/", "example": "Social media connects people across continents instantly."},
        "image_id": "img_tech_social_media"
    },
    {
        "id": "tech_video_call",
        "category": "technology_digital",
        "arabic": {"word": "مُكَالَمَةُ الفِيدْيُو", "transliteration": "Mukalamat Al-Video", "notes": "محادثة مرئية ومسموعة عبر الإنترنت"},
        "german": {"article": "der", "word": "Videoanruf", "plural": "die Videoanrufe", "gender": "masculine", "example": "Wir führen morgen einen gemeinsamen Videoanruf durch."},
        "english": {"word": "video call", "phonetic": "/ˈvɪd.i.əʊ ˌkɔːl/", "example": "Let's schedule a video call to discuss the project."},
        "image_id": "img_tech_video_call"
    }
]

# حفظ ملف المفردات الجديد
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/technology_digital_a1.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "technology_digital",
        "category_name": {
            "ar": "التقنية والعالم الرقمي",
            "de": "Technologie & Digitale Welt",
            "en": "Technology & Digital World"
        },
        "level": "A1",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم تقنية جديدة في {vocab_path}")

# 2. توليد 25 أيقونة SVG خفيفة ومتجهية (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "tech_computer": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="15" width="70" height="50" rx="4" fill="#37474F"/><rect x="20" y="20" width="60" height="40" rx="2" fill="#80DEEA"/><polygon points="45,65 55,65 60,82 40,82" fill="#78909C"/><rect x="30" y="82" width="40" height="6" rx="2" fill="#546E7A"/></svg>',
    "tech_laptop": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="22" width="56" height="42" rx="3" fill="#455A64"/><rect x="26" y="26" width="48" height="34" rx="2" fill="#B2EBF2"/><polygon points="10,72 90,72 82,82 18,82" fill="#90A4AE"/><rect x="42" y="73" width="16" height="3" rx="1" fill="#ECEFF1"/></svg>',
    "tech_smartphone": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="30" y="10" width="40" height="80" rx="8" fill="#212121"/><rect x="34" y="18" width="32" height="64" rx="3" fill="#00BCD4"/><circle cx="50" cy="14" r="2" fill="#757575"/><circle cx="50" cy="85" r="3" fill="#BDBDBD"/></svg>',
    "tech_tablet": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="12" width="64" height="76" rx="6" fill="#37474F"/><rect x="23" y="18" width="54" height="64" rx="3" fill="#80CBC4"/><circle cx="50" cy="84" r="2.5" fill="#B0BEC5"/></svg>',
    "tech_keyboard": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="12" y="32" width="76" height="42" rx="4" fill="#546E7A"/><rect x="18" y="38" width="8" height="6" rx="1" fill="#CFD8DC"/><rect x="30" y="38" width="8" height="6" rx="1" fill="#CFD8DC"/><rect x="42" y="38" width="8" height="6" rx="1" fill="#CFD8DC"/><rect x="54" y="38" width="8" height="6" rx="1" fill="#CFD8DC"/><rect x="66" y="38" width="16" height="6" rx="1" fill="#CFD8DC"/><rect x="18" y="48" width="12" height="6" rx="1" fill="#CFD8DC"/><rect x="34" y="48" width="8" height="6" rx="1" fill="#CFD8DC"/><rect x="46" y="48" width="8" height="6" rx="1" fill="#CFD8DC"/><rect x="58" y="48" width="8" height="6" rx="1" fill="#CFD8DC"/><rect x="70" y="48" width="12" height="6" rx="1" fill="#CFD8DC"/><rect x="30" y="58" width="40" height="6" rx="1" fill="#FFB74D"/></svg>',
    "tech_mouse": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="32" y="20" width="36" height="60" rx="18" fill="#ECEFF1" stroke="#455A64" stroke-width="4"/><line x1="50" y1="20" x2="50" y2="48" stroke="#455A64" stroke-width="4"/><rect x="47" y="30" width="6" height="12" rx="3" fill="#0288D1"/></svg>',
    "tech_screen": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="12" y="16" width="76" height="52" rx="4" fill="#263238"/><rect x="18" y="22" width="64" height="40" fill="#29B6F6"/><polygon points="44,68 56,68 62,84 38,84" fill="#607D8B"/><rect x="28" y="84" width="44" height="5" rx="2" fill="#455A64"/></svg>',
    "tech_headphones": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M25,55 A25,25 0 0,1 75,55" stroke="#E91E63" stroke-width="8" fill="none" stroke-linecap="round"/><rect x="18" y="50" width="14" height="24" rx="7" fill="#880E4F"/><rect x="68" y="50" width="14" height="24" rx="7" fill="#880E4F"/></svg>',
    "tech_internet": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0288D1"/><ellipse cx="50" cy="50" rx="18" ry="38" stroke="#FFF" stroke-width="3" fill="none"/><line x1="12" y1="50" x2="88" y2="50" stroke="#FFF" stroke-width="3"/><line x1="22" y1="28" x2="78" y2="28" stroke="#FFF" stroke-width="3"/><line x1="22" y1="72" x2="78" y2="72" stroke="#FFF" stroke-width="3"/></svg>',
    "tech_website": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="12" y="18" width="76" height="64" rx="5" fill="#FFF" stroke="#3F51B5" stroke-width="4"/><rect x="12" y="18" width="76" height="16" fill="#3F51B5"/><circle cx="20" cy="26" r="3" fill="#FF5252"/><circle cx="28" cy="26" r="3" fill="#FFD740"/><circle cx="36" cy="26" r="3" fill="#69F0AE"/><rect x="22" y="44" width="30" height="6" rx="2" fill="#9FA8DA"/><rect x="22" y="56" width="56" height="4" rx="2" fill="#E0E0E0"/><rect x="22" y="66" width="46" height="4" rx="2" fill="#E0E0E0"/></svg>',
    "tech_email": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="24" width="70" height="52" rx="6" fill="#FB8C00"/><polygon points="15,28 50,55 85,28" fill="#FFE082"/><polygon points="15,76 42,48 15,35" fill="#F57C00" opacity="0.3"/><polygon points="85,76 58,48 85,35" fill="#F57C00" opacity="0.3"/></svg>',
    "tech_password": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="24" y="42" width="52" height="44" rx="8" fill="#FFCA28"/><path d="M35,42 L35,28 C35,18 65,18 65,28 L65,42" stroke="#455A64" stroke-width="8" fill="none"/><circle cx="50" cy="62" r="5" fill="#37474F"/><rect x="47" y="64" width="6" height="12" fill="#37474F"/></svg>',
    "tech_app": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="18" width="64" height="64" rx="16" fill="#7C4DFF"/><polygon points="36,40 64,40 50,68" fill="#FFD54F"/><circle cx="50" cy="38" r="6" fill="#FFF"/></svg>',
    "tech_download": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#43A047"/><path d="M50,25 L50,58 M35,45 L50,60 L65,45" stroke="#FFF" stroke-width="7" fill="none" stroke-linecap="round" stroke-linejoin="round"/><line x1="30" y1="74" x2="70" y2="74" stroke="#FFF" stroke-width="7" stroke-linecap="round"/></svg>',
    "tech_camera": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="16" y="28" width="68" height="48" rx="6" fill="#37474F"/><polygon points="32,28 40,18 60,18 68,28" fill="#263238"/><circle cx="50" cy="52" r="16" fill="#B0BEC5"/><circle cx="50" cy="52" r="11" fill="#00BCD4"/><circle cx="72" cy="38" r="4" fill="#FF5252"/></svg>',
    "tech_battery": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="30" width="60" height="40" rx="6" fill="#ECEFF1" stroke="#37474F" stroke-width="5"/><rect x="78" y="42" width="6" height="16" rx="2" fill="#37474F"/><rect x="25" y="36" width="32" height="28" rx="3" fill="#00C853"/><polygon points="42,40 36,50 44,50 38,60 48,48 40,48" fill="#FFF"/></svg>',
    "tech_charger": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="30" y="35" width="40" height="40" rx="5" fill="#546E7A"/><line x1="40" y1="20" x2="40" y2="35" stroke="#90A4AE" stroke-width="5" stroke-linecap="round"/><line x1="60" y1="20" x2="60" y2="35" stroke="#90A4AE" stroke-width="5" stroke-linecap="round"/><path d="M50,75 C50,88 25,85 25,95" stroke="#37474F" stroke-width="5" fill="none" stroke-linecap="round"/></svg>',
    "tech_printer": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="40" width="60" height="34" rx="4" fill="#78909C"/><rect x="28" y="18" width="44" height="26" rx="2" fill="#ECEFF1"/><rect x="28" y="60" width="44" height="26" rx="2" fill="#FFF"/><line x1="34" y1="68" x2="66" y2="68" stroke="#455A64" stroke-width="3"/><line x1="34" y1="76" x2="56" y2="76" stroke="#455A64" stroke-width="3"/><circle cx="70" cy="48" r="3" fill="#69F0AE"/></svg>',
    "tech_wifi": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="78" r="6" fill="#0288D1"/><path d="M36,64 A20,20 0 0,1 64,64" stroke="#0288D1" stroke-width="6" fill="none" stroke-linecap="round"/><path d="M24,50 A36,36 0 0,1 76,50" stroke="#0288D1" stroke-width="6" fill="none" stroke-linecap="round"/><path d="M12,36 A52,52 0 0,1 88,36" stroke="#0288D1" stroke-width="6" fill="none" stroke-linecap="round"/></svg>',
    "tech_file": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="25,15 55,15 75,35 75,85 25,85" fill="#ECEFF1" stroke="#90A4AE" stroke-width="3"/><polygon points="55,15 75,35 55,35" fill="#B0BEC5"/><line x1="35" y1="45" x2="65" y2="45" stroke="#1E88E5" stroke-width="4" stroke-linecap="round"/><line x1="35" y1="58" x2="65" y2="58" stroke="#78909C" stroke-width="3" stroke-linecap="round"/><line x1="35" y1="70" x2="55" y2="70" stroke="#78909C" stroke-width="3" stroke-linecap="round"/></svg>',
    "tech_folder": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M15,30 L38,30 L46,40 L85,40 C88,40 90,42 90,45 L90,75 C90,78 88,80 85,80 L15,80 C12,80 10,78 10,75 L10,35 C10,32 12,30 15,30 Z" fill="#FFA000"/><rect x="10" y="44" width="80" height="36" rx="4" fill="#FFCA28"/></svg>',
    "tech_message": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M15,25 C15,18 25,15 50,15 C75,15 85,18 85,25 L85,60 C85,67 75,70 50,70 L30,85 L32,70 L15,70 C8,70 15,67 15,60 Z" fill="#00E676"/><circle cx="36" cy="45" r="4" fill="#FFF"/><circle cx="50" cy="45" r="4" fill="#FFF"/><circle cx="64" cy="45" r="4" fill="#FFF"/></svg>',
    "tech_link": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M38,58 L28,68 C20,76 8,64 16,56 L30,42 C38,34 50,46 42,54" stroke="#1E88E5" stroke-width="7" fill="none" stroke-linecap="round"/><path d="M62,42 L72,32 C80,24 92,36 84,44 L70,58 C62,66 50,54 58,46" stroke="#1E88E5" stroke-width="7" fill="none" stroke-linecap="round"/><line x1="38" y1="62" x2="62" y2="38" stroke="#1E88E5" stroke-width="7" stroke-linecap="round"/></svg>',
    "tech_social_media": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="28" cy="35" r="14" fill="#E91E63"/><circle cx="72" cy="35" r="14" fill="#00BCD4"/><circle cx="50" cy="72" r="14" fill="#FF9800"/><line x1="38" y1="42" x2="62" y2="42" stroke="#BDBDBD" stroke-width="4"/><line x1="34" y1="46" x2="45" y2="62" stroke="#BDBDBD" stroke-width="4"/><line x1="66" y1="46" x2="55" y2="62" stroke="#BDBDBD" stroke-width="4"/></svg>',
    "tech_video_call": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="25" width="50" height="50" rx="8" fill="#4CAF50"/><polygon points="65,42 85,30 85,70 65,58" fill="#388E3C"/><circle cx="40" cy="45" r="9" fill="#FFF"/><path d="M26,65 C26,56 54,56 54,65 Z" fill="#FFF"/></svg>'
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
            "description": f"Vector illustration for tech concept: {c['english']['word']}"
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
    
    if "technology_digital_a1.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/weather_seasons_a1.json',",
            "'assets/content/vocabulary/weather_seasons_a1.json',\n    'assets/content/vocabulary/technology_digital_a1.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط technology_digital_a1.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "technology_digital" not in cat_code:
        entry = """    CategoryMeta(
      id: 'technology_digital',
      titleAr: 'التقنية والعالم الرقمي',
      titleDe: 'Technologie & Digitale Welt',
      titleEn: 'Technology & Digital World',
      icon: Icons.devices_rounded,
      primaryColor: Color(0xFF5E35B1),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم التقنية والعالم الرقمي في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 17", "TOTAL_VOCAB_CATEGORIES = 18")
    val_code = val_code.replace("TOTAL_CONCEPTS = 430", "TOTAL_CONCEPTS = 455")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 480", "TOTAL_SVG_ASSETS = 505")
    
    if "technology_digital_a1.json" not in val_code:
        val_code = val_code.replace(
            "'weather_seasons_a1.json',",
            "'weather_seasons_a1.json',\n    'technology_digital_a1.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (18 فئة، 455 مفهومًا، 505 أصول متجهية)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 030 Status (Completed)
- **Feature:** Category 18: Technology & Digital World (`technology_digital_a1.json`).
- **New Concepts:** 25 trilingual vocabulary items for devices, internet, and communication.
- **New Visuals:** 25 unique lightweight SVG vectors (`tech_*.svg`).
- **Historic Milestone:** 18 Vocabulary Categories | 455 Core Concepts | 25 Verbs | 25 Sentences | 20 Prepositions | 5 Dialogues | Articles Engine | 505 Total SVG Icons (Passed 500+ landmark).
- **Integration:** Active in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 030 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 030 بنجاح تام!")
