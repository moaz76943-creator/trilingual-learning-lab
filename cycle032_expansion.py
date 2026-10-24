import json
import os

print("🚀 [CYCLE 032] بدء بناء قسم الاحتفالات والحياة الاجتماعية وإغلاق مرحلة A1...")

# 1. قائمة الـ 25 مفهومًا لقسم الاحتفالات والمناسبات الاجتماعية
concepts = [
    {
        "id": "cel_celebration",
        "category": "celebrations_social",
        "arabic": {"word": "الِاحْتِفَالُ / المِهْرَجَانُ", "transliteration": "Al-Ihtifal", "notes": "مناسبة بهيجة تجمع الأهل والأصدقاء"},
        "german": {"article": "das", "word": "Fest", "plural": "die Feste", "gender": "neuter", "example": "Das jährliche Sommerfest der Nachbarschaft war wunderbar."},
        "english": {"word": "celebration / festival", "phonetic": "/ˌsel.əˈbreɪ.ʃən/", "example": "The annual community celebration was vibrant and joyful."},
        "image_id": "img_cel_celebration"
    },
    {
        "id": "cel_birthday",
        "category": "celebrations_social",
        "arabic": {"word": "عِيدُ المِيلَادِ", "transliteration": "Eed Al-Meelad", "notes": "يوم ذكرى مولد الشخص"},
        "german": {"article": "der", "word": "Geburtstag", "plural": "die Geburtstage", "gender": "masculine", "example": "Ich lade dich herzlich zu meinem Geburtstag ein."},
        "english": {"word": "birthday", "phonetic": "/ˈbɜːθ.deɪ/", "example": "We are organizing a surprise birthday party for Sarah."},
        "image_id": "img_cel_birthday"
    },
    {
        "id": "cel_gift",
        "category": "celebrations_social",
        "arabic": {"word": "الهَدِيَّةُ", "transliteration": "Al-Hadiyyah", "notes": "عطية تعبيرية عن الود والتقدير"},
        "german": {"article": "das", "word": "Geschenk", "plural": "die Geschenke", "gender": "neuter", "example": "Vielen Dank für dieses wunderschöne Geschenk!"},
        "english": {"word": "gift / present", "phonetic": "/ɡɪft/", "example": "Thank you so much for this thoughtful birthday gift!"},
        "image_id": "img_cel_gift"
    },
    {
        "id": "cel_invitation",
        "category": "celebrations_social",
        "arabic": {"word": "الدَّعْوَةُ", "transliteration": "Ad-Da'wah", "notes": "طلب الحضور إلى مناسبة معينة"},
        "german": {"article": "die", "word": "Einladung", "plural": "die Einladungen", "gender": "feminine", "example": "Ich habe gestern die offizielle Einladung erhalten."},
        "english": {"word": "invitation", "phonetic": "/ˌɪn.vɪˈteɪ.ʃən/", "example": "Have you sent out the wedding invitations yet?"},
        "image_id": "img_cel_invitation"
    },
    {
        "id": "cel_guest",
        "category": "celebrations_social",
        "arabic": {"word": "الضَّيْفُ", "transliteration": "Ad-Dayf", "notes": "النازل عند غيره مستضافًا"},
        "german": {"article": "der", "word": "Gast", "plural": "die Gäste", "gender": "masculine", "example": "Heute Abend erwarten wir liebe Gäste zum Abendessen."},
        "english": {"word": "guest", "phonetic": "/ɡest/", "example": "Our dinner guests arrived promptly at seven."},
        "image_id": "img_cel_guest"
    },
    {
        "id": "cel_party",
        "category": "celebrations_social",
        "arabic": {"word": "الحَفْلَةُ", "transliteration": "Al-Haflah", "notes": "تجمع ترفيهي واجتماعي مسلٍّ"},
        "german": {"article": "die", "word": "Party", "plural": "die Partys", "gender": "feminine", "example": "Die Musik auf der Party war großartig."},
        "english": {"word": "party", "phonetic": "/ˈpɑː.ti/", "example": "They threw a lively farewell party for their colleague."},
        "image_id": "img_cel_party"
    },
    {
        "id": "cel_holiday",
        "category": "celebrations_social",
        "arabic": {"word": "العُطْلَةُ الرَّسْمِيَّةُ / العِيدُ", "transliteration": "Al-'Utlah Ar-Rasmiyyah", "notes": "يوم إجازة وطني أو ديني معتمد"},
        "german": {"article": "der", "word": "Feiertag", "plural": "die Feiertage", "gender": "masculine", "example": "Morgen ist ein gesetzlicher Feiertag, alle Geschäfte haben geschlossen."},
        "english": {"word": "public holiday", "phonetic": "/ˈhɒl.ə.deɪ/", "example": "Tomorrow is a national public holiday across the country."},
        "image_id": "img_cel_holiday"
    },
    {
        "id": "cel_wedding",
        "category": "celebrations_social",
        "arabic": {"word": "حَفْلُ الزِّفَافِ / العُرْسُ", "transliteration": "Hafl Az-Zifaf", "notes": "احتفال عقد القران والزواج"},
        "german": {"article": "die", "word": "Hochzeit", "plural": "die Hochzeiten", "gender": "feminine", "example": "Die Hochzeit fand in einem romantischen Schlossgarten statt."},
        "english": {"word": "wedding", "phonetic": "/ˈwed.ɪŋ/", "example": "The outdoor wedding ceremony was breathtaking."},
        "image_id": "img_cel_wedding"
    },
    {
        "id": "cel_congratulation",
        "category": "celebrations_social",
        "arabic": {"word": "التَّهْنِئَةُ / التَّبْرِيكُ", "transliteration": "At-Tahni'ah", "notes": "التعبير عن الفرح بإنجاز أو مناسبة سعيدة"},
        "german": {"article": "der", "word": "Glückwunsch", "plural": "die Glückwünsche", "gender": "masculine", "example": "Herzlichen Glückwunsch zur bestandenen Deutschprüfung!"},
        "english": {"word": "congratulation", "phonetic": "/kənˌɡrætʃ.əˈleɪ.ʃən/", "example": "Warm congratulations on passing your exam with top marks!"},
        "image_id": "img_cel_congratulation"
    },
    {
        "id": "cel_greeting",
        "category": "celebrations_social",
        "arabic": {"word": "التَّحِيَّةُ / السَّلَامُ", "transliteration": "At-Tahiyyah", "notes": "بادرة اللقاء والسلام الودي"},
        "german": {"article": "der", "word": "Gruß", "plural": "die Grüße", "gender": "masculine", "example": "Schöne Grüße an deine ganze Familie!"},
        "english": {"word": "greeting", "phonetic": "/ˈɡriː.tɪŋ/", "example": "Send my warmest personal greetings to your family."},
        "image_id": "img_cel_greeting"
    },
    {
        "id": "cel_flower",
        "category": "celebrations_social",
        "arabic": {"word": "الزَّهْرَةُ / الوَرْدَةُ", "transliteration": "Az-Zahrah", "notes": "نبات عطري يهدى في المناسبات"},
        "german": {"article": "die", "word": "Blume", "plural": "die Blumen", "gender": "feminine", "example": "Er brachte ihr einen bunten Blumenstrauß mit."},
        "english": {"word": "flower", "phonetic": "/flaʊər/", "example": "She arranged fresh spring flowers in a glass vase."},
        "image_id": "img_cel_flower"
    },
    {
        "id": "cel_candle",
        "category": "celebrations_social",
        "arabic": {"word": "الشَّمْعَةُ", "transliteration": "Ash-Sham'ah", "notes": "عمود من الشمع يضاء في الحفلات والأعياد"},
        "german": {"article": "die", "word": "Kerze", "plural": "die Kerzen", "gender": "feminine", "example": "Puste alle Kerzen auf dem Geburtstagskuchen aus!"},
        "english": {"word": "candle", "phonetic": "/ˈkæn.dəl/", "example": "Make a silent wish before blowing out the birthday candles."},
        "image_id": "img_cel_candle"
    },
    {
        "id": "cel_cake",
        "category": "celebrations_social",
        "arabic": {"word": "كَعْكَةُ الحَفْلِ / الطَّوْرْطَةُ", "transliteration": "Ka'kat Al-Hafl", "notes": "حلوى المناسبات المخبوزة والمزينة"},
        "german": {"article": "die", "word": "Torte", "plural": "die Torten", "gender": "feminine", "example": "Die Schokoladentorte schmeckte köstlich."},
        "english": {"word": "celebration cake / tart", "phonetic": "/keɪk/", "example": "The baker decorated the festive cake beautifully."},
        "image_id": "img_cel_cake"
    },
    {
        "id": "cel_balloon",
        "category": "celebrations_social",
        "arabic": {"word": "البَالُونُ / النُّفَّاخَةُ", "transliteration": "Al-Baloon", "notes": "كيس مطاطي ملون يملأ بالهواء للزينة"},
        "german": {"article": "der", "word": "Luftballon", "plural": "die Luftballons", "gender": "masculine", "example": "Bunte Luftballons schmücken den gesamten Festsaal."},
        "english": {"word": "balloon", "phonetic": "/bəˈluːn/", "example": "Bright red and gold balloons decorated the courtyard."},
        "image_id": "img_cel_balloon"
    },
    {
        "id": "cel_toast",
        "category": "celebrations_social",
        "arabic": {"word": "نَخْبُ التَّهْنِئَةِ (فِي صِحَّتِكُمْ)", "transliteration": "Nakhb At-Tahni'ah", "notes": "عبارة التمني بالصحة والتوفيق في الجمع"},
        "german": {"article": "der", "word": "Trinkspruch", "plural": "die Trinksprüche", "gender": "masculine", "example": "Der Gastgeber hielt einen herzlichen Trinkspruch auf das Brautpaar."},
        "english": {"word": "toast (cheers)", "phonetic": "/təʊst/", "example": "The host proposed an emotional toast to the newlyweds."},
        "image_id": "img_cel_toast"
    },
    {
        "id": "cel_friendship",
        "category": "celebrations_social",
        "arabic": {"word": "الصَّدَاقَةُ", "transliteration": "As-Sadaqah", "notes": "رابطة الإخاء والمودة الصادقة بين الأفراد"},
        "german": {"article": "die", "word": "Freundschaft", "plural": "die Freundschaften", "gender": "feminine", "example": "Eine wahre Freundschaft hält ein Leben lang."},
        "english": {"word": "friendship", "phonetic": "/ˈfrend.ʃɪp/", "example": "Lifelong friendship is one of life's greatest treasures."},
        "image_id": "img_cel_friendship"
    },
    {
        "id": "cel_meeting",
        "category": "celebrations_social",
        "arabic": {"word": "اللِّقَاءُ / المَوْعِدُ", "transliteration": "Al-Liqa'", "notes": "اجتماع شخصين أو أكثر في مكان محدد"},
        "german": {"article": "das", "word": "Treffen", "plural": "die Treffen", "gender": "neuter", "example": "Unser Treffen im Stadtcafé war sehr angenehm."},
        "english": {"word": "gathering / meeting", "phonetic": "/ˈmiː.tɪŋ/", "example": "Our casual coffee meeting was truly refreshing."},
        "image_id": "img_cel_meeting"
    },
    {
        "id": "cel_visit",
        "category": "celebrations_social",
        "arabic": {"word": "الزِّيَارَةُ", "transliteration": "Az-Ziyarah", "notes": "الذهاب إلى الأقارب أو الأصدقاء للتواصل"},
        "german": {"article": "der", "word": "Besuch", "plural": "die Besuche", "gender": "masculine", "example": "Am Wochenende freuen wir uns auf den Besuch der Großeltern."},
        "english": {"word": "visit", "phonetic": "/ˈvɪz.ɪt/", "example": "We always look forward to my grandparents' weekend visit."},
        "image_id": "img_cel_visit"
    },
    {
        "id": "cel_tradition",
        "category": "celebrations_social",
        "arabic": {"word": "التَّقْلِيدُ / العَادَةُ العَرِيقَةُ", "transliteration": "At-Taqleed", "notes": "الموروث الثقافي والاجتماعي المتوارث عبر الأجيال"},
        "german": {"article": "die", "word": "Tradition", "plural": "die Traditionen", "gender": "feminine", "example": "In jedem Land gibt es einzigartige festliche Traditionen."},
        "english": {"word": "tradition / custom", "phonetic": "/trəˈdɪʃ.ən/", "example": "Every culture cherishes distinct holiday traditions."},
        "image_id": "img_cel_tradition"
    },
    {
        "id": "cel_new_year",
        "category": "celebrations_social",
        "arabic": {"word": "رَأْسُ السَّنَةِ الجَدِيدَةِ", "transliteration": "Ra's As-Sanah", "notes": "مستهل العام التقويمي الجديد"},
        "german": {"article": "das", "word": "Neujahr", "plural": "die Neujahre", "gender": "neuter", "example": "Ich wünsche dir ein frohes und gesundes neues Jahr!"},
        "english": {"word": "New Year", "phonetic": "/ˌnjuː ˈjɪər/", "example": "Wishing you peace, happiness, and prosperity in the New Year!"},
        "image_id": "img_cel_new_year"
    },
    {
        "id": "cel_eid_festival",
        "category": "celebrations_social",
        "arabic": {"word": "العِيدُ الدِّينِيُّ / المِهْرَجَانُ", "transliteration": "Al-'Eed Ad-Deeni", "notes": "أيام الفرح والشعائر الدينية كالفطر والأضحى"},
        "german": {"article": "das", "word": "Fest", "plural": "die Feste", "gender": "neuter", "example": "Eid ist ein wunderschönes Familienfest des Teilens und der Freude."},
        "english": {"word": "Eid / festive holiday", "phonetic": "/iːd/", "example": "Eid is a blessed occasion celebrated with loved ones."},
        "image_id": "img_cel_eid_festival"
    },
    {
        "id": "cel_surprise",
        "category": "celebrations_social",
        "arabic": {"word": "المُفَاجَأَةُ", "transliteration": "Al-Mufaja'ah", "notes": "أمر سار غير متوقع يبهج النفس"},
        "german": {"article": "die", "word": "Überraschung", "plural": "die Überraschungen", "gender": "feminine", "example": "Die gelungene Überraschung hat ihr ein Lächeln ins Gesicht gezaubert."},
        "english": {"word": "surprise", "phonetic": "/səˈpraɪz/", "example": "The unexpected surprise brought tears of joy to her eyes."},
        "image_id": "img_cel_surprise"
    },
    {
        "id": "cel_decoration",
        "category": "celebrations_social",
        "arabic": {"word": "الزِّينَةُ / الدِّيكُورُ الِاحْتِفَالِيُّ", "transliteration": "Az-Zeenah", "notes": "المظاهر الجمالية لتجهيز مكان الفرح"},
        "german": {"article": "die", "word": "Dekoration", "plural": "die Dekorationen", "gender": "feminine", "example": "Die glitzernde Dekoration verwandelte den Raum in einen Festsaal."},
        "english": {"word": "decoration", "phonetic": "/ˌdek.əˈreɪ.ʃən/", "example": "The festive decorations created a cheerful ambience."},
        "image_id": "img_cel_decoration"
    },
    {
        "id": "cel_cheers",
        "category": "celebrations_social",
        "arabic": {"word": "فِي صِحَّتِكُمْ / هَنِيئًا", "transliteration": "Hanee'an / Fee Sihhatikum", "notes": "عبارة المباركة والشرب المشترك"},
        "german": {"article": "", "word": "Prost! / Zum Wohl!", "plural": "", "gender": "interjection", "example": "Prost und auf eine erfolgreiche gemeinsame Zukunft!"},
        "english": {"word": "cheers!", "phonetic": "/tʃɪəz/", "example": "Cheers to good health, true friends, and happiness!"},
        "image_id": "img_cel_cheers"
    },
    {
        "id": "cel_farewell",
        "category": "celebrations_social",
        "arabic": {"word": "الوَدَاعُ / حَفْلُ التَّوْدِيعِ", "transliteration": "Al-Wada'", "notes": "لحظة الافتراق وتمني السلامة واللقاء مجددًا"},
        "german": {"article": "der", "word": "Abschied", "plural": "die Abschiede", "gender": "masculine", "example": "Der Abschied von den Kollegen fiel ihm nicht leicht."},
        "english": {"word": "farewell / goodbye", "phonetic": "/feəˈwel/", "example": "They bid a warm farewell and promised to stay in touch."},
        "image_id": "img_cel_farewell"
    }
]

# حفظ ملف المفردات الجديد
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/celebrations_social_a1.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "celebrations_social",
        "category_name": {
            "ar": "المناسبات والاحتفالات والحياة الاجتماعية",
            "de": "Feste & Soziales Leben",
            "en": "Celebrations & Social Life"
        },
        "level": "A1",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم اجتماعية جديدة في {vocab_path}")

# 2. توليد 25 أيقونة SVG متقنة وخفيفة (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "cel_celebration": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,15 55,35 75,35 58,48 64,68 50,55 36,68 42,48 25,35 45,35" fill="#FFB300"/><circle cx="25" cy="25" r="4" fill="#E91E63"/><circle cx="75" cy="25" r="4" fill="#00BCD4"/><circle cx="85" cy="65" r="5" fill="#4CAF50"/><circle cx="15" cy="65" r="5" fill="#9C27B0"/><line x1="50" y1="65" x2="50" y2="90" stroke="#FF9800" stroke-width="4"/></svg>',
    "cel_birthday": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,12 25,75 75,75" fill="#E91E63"/><ellipse cx="50" cy="75" rx="25" ry="6" fill="#C2185B"/><circle cx="50" cy="12" r="5" fill="#FFEB3B"/><circle cx="38" cy="45" r="4" fill="#00E676"/><circle cx="55" cy="35" r="3.5" fill="#FFEB3B"/><circle cx="52" cy="58" r="4.5" fill="#00BCD4"/></svg>',
    "cel_gift": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="38" width="56" height="46" rx="4" fill="#E53935"/><rect x="18" y="28" width="64" height="14" rx="3" fill="#D32F2F"/><rect x="44" y="28" width="12" height="56" fill="#FFD54F"/><circle cx="42" cy="20" r="8" fill="none" stroke="#FFD54F" stroke-width="4"/><circle cx="58" cy="20" r="8" fill="none" stroke="#FFD54F" stroke-width="4"/></svg>',
    "cel_invitation": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="16" y="22" width="68" height="56" rx="4" fill="#FFF8E1" stroke="#FFA000" stroke-width="3"/><polygon points="16,22 50,50 84,22" fill="#FFE082"/><circle cx="50" cy="50" r="8" fill="#E91E63"/><path d="M46,50 L49,53 L55,47" stroke="#FFF" stroke-width="2" fill="none"/></svg>',
    "cel_guest": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="30" r="14" fill="#FFA726"/><path d="M28,78 C28,55 72,55 72,78 Z" fill="#1E88E5"/><path d="M68,48 L82,38" stroke="#FFA726" stroke-width="4" stroke-linecap="round"/><circle cx="84" cy="36" r="3" fill="#FFA726"/></svg>',
    "cel_party": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="30,80 50,20 70,80" fill="#7C4DFF"/><ellipse cx="50" cy="80" rx="20" ry="5" fill="#651FFF"/><circle cx="50" cy="18" r="4" fill="#FF5252"/><path d="M20,30 Q30,40 25,50" stroke="#FFD740" stroke-width="3" fill="none"/><path d="M75,30 Q85,40 80,50" stroke="#69F0AE" stroke-width="3" fill="none"/></svg>',
    "cel_holiday": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="20" width="64" height="65" rx="6" fill="#FFF" stroke="#E53935" stroke-width="4"/><rect x="18" y="20" width="64" height="18" fill="#E53935"/><circle cx="32" cy="15" r="3" fill="#B71C1C"/><circle cx="68" cy="15" r="3" fill="#B71C1C"/><polygon points="50,48 53,58 63,58 55,64 58,74 50,68 42,74 45,64 37,58 47,58" fill="#FFC107"/></svg>',
    "cel_wedding": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="40" cy="50" r="22" fill="none" stroke="#FFD700" stroke-width="6"/><circle cx="60" cy="50" r="22" fill="none" stroke="#FFD700" stroke-width="6"/><polygon points="40,22 45,30 35,30" fill="#00E5FF"/><polygon points="60,22 65,30 55,30" fill="#00E5FF"/></svg>',
    "cel_congratulation": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FF9800"/><path d="M30,52 L44,66 L72,36" fill="none" stroke="#FFF" stroke-width="8" stroke-linecap="round"/><polygon points="20,25 25,35 15,35" fill="#FFF"/><polygon points="80,25 85,35 75,35" fill="#FFF"/></svg>',
    "cel_greeting": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M35,65 C25,50 35,30 50,30 C65,30 75,50 65,65" fill="#FFB74D"/><path d="M50,30 L50,15 M40,32 L30,20 M60,32 L70,20" stroke="#FFA726" stroke-width="4" stroke-linecap="round"/><circle cx="43" cy="45" r="3" fill="#212121"/><circle cx="57" cy="45" r="3" fill="#212121"/><path d="M44,55 Q50,60 56,55" stroke="#212121" stroke-width="3" fill="none"/></svg>',
    "cel_flower": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="35" r="10" fill="#FFCA28"/><circle cx="50" cy="18" r="9" fill="#E91E63"/><circle cx="65" cy="27" r="9" fill="#E91E63"/><circle cx="65" cy="45" r="9" fill="#E91E63"/><circle cx="50" cy="52" r="9" fill="#E91E63"/><circle cx="35" cy="45" r="9" fill="#E91E63"/><circle cx="35" cy="27" r="9" fill="#E91E63"/><line x1="50" y1="55" x2="50" y2="90" stroke="#4CAF50" stroke-width="5" stroke-linecap="round"/><path d="M50,70 Q68,60 65,75 Q50,75 50,70 Z" fill="#81C784"/></svg>',
    "cel_candle": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="40" y="45" width="20" height="42" rx="3" fill="#AB47BC"/><line x1="50" y1="45" x2="50" y2="35" stroke="#424242" stroke-width="3"/><path d="M50,15 C45,25 42,30 50,35 C58,30 55,25 50,15 Z" fill="#FF9800"/><path d="M50,22 C48,27 46,29 50,33 C54,29 52,27 50,22 Z" fill="#FFEB3B"/></svg>',
    "cel_cake": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="55" width="64" height="30" rx="4" fill="#8D6E63"/><rect x="25" y="38" width="50" height="20" rx="3" fill="#D7CCC8"/><path d="M18,55 Q26,62 34,55 Q42,62 50,55 Q58,62 66,55 Q74,62 82,55" fill="#F48FB1"/><rect x="47" y="24" width="6" height="15" fill="#FFCA28"/><path d="M50,14 C48,18 46,20 50,24 C54,20 52,18 50,14 Z" fill="#FF5722"/></svg>',
    "cel_balloon": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><ellipse cx="50" cy="40" rx="26" ry="32" fill="#00BCD4"/><polygon points="50,72 46,78 54,78" fill="#0097A7"/><path d="M50,78 Q45,86 52,92" stroke="#757575" stroke-width="2.5" fill="none"/><ellipse cx="40" cy="28" rx="5" ry="10" fill="#E0F7FA" opacity="0.6"/></svg>',
    "cel_toast": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="35,30 25,55 45,55" fill="#FFE082"/><line x1="35" y1="55" x2="35" y2="78" stroke="#FFA000" stroke-width="4"/><rect x="25" y="78" width="20" height="4" fill="#FFA000"/><polygon points="65,30 55,55 75,55" fill="#FFE082"/><line x1="65" y1="55" x2="65" y2="78" stroke="#FFA000" stroke-width="4"/><rect x="55" y="78" width="20" height="4" fill="#FFA000"/><circle cx="50" cy="35" r="3" fill="#FFB300"/></svg>',
    "cel_friendship": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="36" cy="35" r="14" fill="#42A5F5"/><circle cx="64" cy="35" r="14" fill="#66BB6A"/><path d="M18,80 C18,60 54,60 54,80 Z" fill="#1E88E5"/><path d="M46,80 C46,60 82,60 82,80 Z" fill="#43A047"/><path d="M50,48 Q55,42 60,48 Q50,60 50,48 Z" fill="#E91E63"/></svg>',
    "cel_meeting": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="20" fill="#795548"/><circle cx="50" cy="18" r="9" fill="#FFA726"/><circle cx="50" cy="82" r="9" fill="#FFA726"/><circle cx="18" cy="50" r="9" fill="#FFA726"/><circle cx="82" cy="50" r="9" fill="#FFA726"/></svg>',
    "cel_visit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,15 15,45 85,45" fill="#5D4037"/><rect x="25" y="45" width="50" height="40" fill="#FFF8E1"/><rect x="42" y="55" width="16" height="30" fill="#8D6E63"/><circle cx="54" cy="72" r="2" fill="#FFD54F"/><circle cx="75" cy="65" r="6" fill="#4CAF50"/></svg>',
    "cel_tradition": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#880E4F"/><polygon points="50,20 58,38 78,40 64,54 68,74 50,64 32,74 36,54 22,40 42,38" fill="#FFD54F"/><circle cx="50" cy="48" r="8" fill="#FFF"/></svg>',
    "cel_new_year": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="10" y="10" width="80" height="80" rx="10" fill="#1A237E"/><circle cx="50" cy="50" r="4" fill="#FFF"/><line x1="50" y1="50" x2="50" y2="20" stroke="#FFD700" stroke-width="4" stroke-linecap="round"/><line x1="50" y1="50" x2="72" y2="35" stroke="#FF5252" stroke-width="3" stroke-linecap="round"/><line x1="50" y1="50" x2="28" y2="65" stroke="#69F0AE" stroke-width="3" stroke-linecap="round"/><line x1="50" y1="50" x2="68" y2="70" stroke="#40C4FF" stroke-width="3" stroke-linecap="round"/></svg>',
    "cel_eid_festival": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#004D40"/><path d="M55,22 C40,22 30,34 30,50 C30,66 40,78 55,78 C42,75 36,65 36,50 C36,35 44,25 55,22 Z" fill="#FFD54F"/><polygon points="62,42 65,49 72,50 67,55 68,62 62,58 56,62 57,55 52,50 59,49" fill="#FFD54F"/></svg>',
    "cel_surprise": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="48" width="50" height="38" rx="4" fill="#512DA8"/><rect x="20" y="38" width="60" height="12" rx="3" fill="#7E57C2"/><polygon points="50,15 54,28 66,24 58,34 70,40 56,42 50,30 44,42 30,40 42,34 34,24 46,28" fill="#FFEB3B"/></svg>',
    "cel_decoration": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M10,25 Q50,45 90,25" stroke="#757575" stroke-width="3" fill="none"/><polygon points="20,28 30,55 12,50" fill="#E91E63"/><polygon points="40,34 50,62 34,58" fill="#FFEB3B"/><polygon points="60,34 70,62 54,58" fill="#00E676"/><polygon points="80,28 88,52 70,55" fill="#2979FF"/></svg>',
    "cel_cheers": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#F57C00"/><path d="M35,38 L30,55 L45,55 Z" fill="#FFF"/><path d="M65,38 L55,55 L70,55 Z" fill="#FFF"/><circle cx="50" cy="45" r="4" fill="#FFEB3B"/><line x1="50" y1="32" x2="50" y2="25" stroke="#FFEB3B" stroke-width="3" stroke-linecap="round"/></svg>',
    "cel_farewell": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#37474F"/><path d="M30,58 C30,45 42,35 55,35 C65,35 72,42 70,52 L68,68 C62,75 42,75 35,68 Z" fill="#FFA726"/><path d="M55,35 L55,20 M63,38 L72,25 M47,38 L38,25" stroke="#FFA726" stroke-width="4" stroke-linecap="round"/></svg>'
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
            "description": f"Vector illustration for celebration concept: {c['english']['word']}"
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
    
    if "celebrations_social_a1.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/culture_media_a1.json',",
            "'assets/content/vocabulary/culture_media_a1.json',\n    'assets/content/vocabulary/celebrations_social_a1.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط celebrations_social_a1.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "celebrations_social" not in cat_code:
        entry = """    CategoryMeta(
      id: 'celebrations_social',
      titleAr: 'المناسبات والاحتفالات والحياة الاجتماعية',
      titleDe: 'Feste & Soziales Leben',
      titleEn: 'Celebrations & Social Life',
      icon: Icons.celebration_rounded,
      primaryColor: Color(0xFFF57C00),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم الاحتفالات في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 19", "TOTAL_VOCAB_CATEGORIES = 20")
    val_code = val_code.replace("TOTAL_CONCEPTS = 480", "TOTAL_CONCEPTS = 505")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 530", "TOTAL_SVG_ASSETS = 555")
    
    if "celebrations_social_a1.json" not in val_code:
        val_code = val_code.replace(
            "'culture_media_a1.json',",
            "'culture_media_a1.json',\n    'celebrations_social_a1.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (20 فئة، 505 مفاهيم، 555 أصلًا متجهيًا)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 032 Status (Completed - A1 Milestone Concluded)
- **Feature:** Category 20: Celebrations & Social Life (`celebrations_social_a1.json`).
- **New Concepts:** 25 trilingual vocabulary items for holidays, social events, weddings, and greetings.
- **New Visuals:** 25 unique lightweight SVG vectors (`cel_*.svg`).
- **MAJOR LANDMARK - A1 LEVEL COMPLETE:**
  - 20 Vocabulary Categories.
  - 505 Core Vocabulary Concepts (crossed half-thousand words).
  - 25 Verbs with full 3-language present tense conjugations.
  - 25 Sentence Builder exercises with Satzklammer structures.
  - 20 Prepositions with Wechselpräpositionen Dativ/Akkusativ rules.
  - 5 Situational Dialogues (Tap-to-Reveal).
  - A1 Articles Engine (der/ein/kein across 4 German cases).
  - 555 Total Original Lightweight SVG Vector Assets.
- **Integration:** Active in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق ختام مرحلة A1 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 032 بنجاح تاريخي!")
