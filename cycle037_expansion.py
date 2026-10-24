import json
import os

print("🚀 [CYCLE 037] بدء بناء قسم الصحة النفسية واللياقة البدنية (Wellness & Fitness - A2)...")

# 1. قائمة الـ 25 مفهومًا لقسم الصحة النفسية واللياقة
concepts = [
    {
        "id": "wel_wohlbefinden",
        "category": "wellness_fitness",
        "arabic": {"word": "العَافِيَةُ / العِنَايَةُ بِالصِّحَّةِ", "transliteration": "Al-'Aafiyah", "notes": "حالة السلامة الجسدية والنفسية الشاملة"},
        "german": {"article": "das", "word": "Wohlbefinden", "plural": "die Wohlbefinden", "gender": "neuter", "example": "Regelmäßige Bewegung steigert das persönliche Wohlbefinden."},
        "english": {"word": "well-being / wellness", "phonetic": "/ˌwelˈbiː.ɪŋ/", "example": "Regular gentle exercise enhances physical and emotional well-being."},
        "image_id": "img_wel_wohlbefinden"
    },
    {
        "id": "wel_psychische_gesundheit",
        "category": "wellness_fitness",
        "arabic": {"word": "الصِّحَّةُ النَّفْسِيَّةُ", "transliteration": "As-Sihhah An-Nafsiyyah", "notes": "التوازن والاستقرار النفسي والعاطفي"},
        "german": {"article": "die", "word": "psychische Gesundheit", "plural": "die psychischen Gesundheiten", "gender": "feminine", "example": "Psychische Gesundheit ist genauso wichtig wie körperliche Fitness."},
        "english": {"word": "mental health", "phonetic": "/ˌmen.təl ˈhelθ/", "example": "Prioritizing mental health leads to a more balanced life."},
        "image_id": "img_wel_psychische_gesundheit"
    },
    {
        "id": "wel_fitness",
        "category": "wellness_fitness",
        "arabic": {"word": "اللِّيَاقَةُ البَدَنِيَّةُ", "transliteration": "Al-Liyaqah Al-Badaniyyah", "notes": "مستوى القدرة والتحمل الجسدي"},
        "german": {"article": "die", "word": "Fitness", "plural": "die Fitness", "gender": "feminine", "example": "Mit täglichem Training verbessert er seine allgemeine Fitness."},
        "english": {"word": "fitness", "phonetic": "/ˈfɪt.nəs/", "example": "Consistent cardio training builds overall physical fitness."},
        "image_id": "img_wel_fitness"
    },
    {
        "id": "wel_meditation",
        "category": "wellness_fitness",
        "arabic": {"word": "التَّأَمُّلُ", "transliteration": "At-Ta'ammul", "notes": "تمرين التركيز الذهني وتصفية الذهن"},
        "german": {"article": "die", "word": "Meditation", "plural": "die Meditationen", "gender": "feminine", "example": "Zehn Minuten Meditation am Morgen bringen innere Ruhe."},
        "english": {"word": "meditation", "phonetic": "/ˌmed.ɪˈteɪ.ʃən/", "example": "Daily morning meditation clears mental clutter effectively."},
        "image_id": "img_wel_meditation"
    },
    {
        "id": "wel_stress",
        "category": "wellness_fitness",
        "arabic": {"word": "الضَّغْطُ النَّفْسِيُّ / الإِجْهَادُ", "transliteration": "Ad-Daqt An-Nafsi", "notes": "التوتر الناتج عن الأعباء المتراكمة"},
        "german": {"article": "der", "word": "Stress", "plural": "die Stresse", "gender": "masculine", "example": "Tiefes Durchatmen hilft effektiv beim Abbau von Stress."},
        "english": {"word": "stress", "phonetic": "/stres/", "example": "Deep conscious breathing relieves daily workplace stress."},
        "image_id": "img_wel_stress"
    },
    {
        "id": "wel_entspannung",
        "category": "wellness_fitness",
        "arabic": {"word": "الِاسْتِرْخَاءُ / الرَّاحَةُ", "transliteration": "Al-Istirkha'", "notes": "التحرر من التوتر العضلي والعصبي"},
        "german": {"article": "die", "word": "Entspannung", "plural": "die Entspannungen", "gender": "feminine", "example": "Ein warmes Bad sorgt für tiefe Entspannung nach der Arbeit."},
        "english": {"word": "relaxation", "phonetic": "/ˌriː.lækˈseɪ.ʃən/", "example": "Listening to calm acoustics promotes muscle relaxation."},
        "image_id": "img_wel_entspannung"
    },
    {
        "id": "wel_fitnessstudio",
        "category": "wellness_fitness",
        "arabic": {"word": "صَالَةُ الأَلْعَابِ الرِّيَاضِيَّةِ", "transliteration": "Salat Al-Al'ab", "notes": "مكان مجهز بأجهزة تقوية العضلات واللياقة"},
        "german": {"article": "das", "word": "Fitnessstudio", "plural": "die Fitnessstudios", "gender": "neuter", "example": "Er trainiert dreimal pro Woche im modernen Fitnessstudio."},
        "english": {"word": "gym / fitness center", "phonetic": "/dʒɪm/", "example": "She works out at the community gym three times a week."},
        "image_id": "img_wel_fitnessstudio"
    },
    {
        "id": "wel_uebung",
        "category": "wellness_fitness",
        "arabic": {"word": "التَّمْرِينُ البَدَنِيُّ", "transliteration": "At-Tamreen Al-Badani", "notes": "حركة رياضية مكررة لتقوية الجسد"},
        "german": {"article": "die", "word": "Übung", "plural": "die Übungen", "gender": "feminine", "example": "Diese Dehnübung ist besonders gut für den Rücken."},
        "english": {"word": "exercise / workout", "phonetic": "/ˈek.sə.saɪz/", "example": "This stretching exercise relieves lower back stiffness."},
        "image_id": "img_wel_uebung"
    },
    {
        "id": "wel_atmung",
        "category": "wellness_fitness",
        "arabic": {"word": "التَّنَفُّسُ العَمِيقُ", "transliteration": "At-Tanaffus", "notes": "عملية الشهيق والزفير الهادفة لتهدئة النبض"},
        "german": {"article": "die", "word": "Atmung", "plural": "die Atmungen", "gender": "feminine", "example": "Achte während des Trainings auf eine gleichmäßige Atmung."},
        "english": {"word": "breathing / respiration", "phonetic": "/ˈbriː.ðɪŋ/", "example": "Controlled breathing lowers heart rate during tension."},
        "image_id": "img_wel_atmung"
    },
    {
        "id": "wel_yoga",
        "category": "wellness_fitness",
        "arabic": {"word": "اليُوغَا", "transliteration": "Al-Yoga", "notes": "رياضة روحية وجسدية تعزز المرونة والتركيز"},
        "german": {"article": "das", "word": "Yoga", "plural": "die Yogas", "gender": "neuter", "example": "Yoga fördert sowohl körperliche Beweglichkeit als auch mentale Ruhe."},
        "english": {"word": "yoga", "phonetic": "/ˈjəʊ.ɡə/", "example": "Practicing yoga improves posture, flexibility, and focus."},
        "image_id": "img_wel_yoga"
    },
    {
        "id": "wel_joggen",
        "category": "wellness_fitness",
        "arabic": {"word": "الجَرْيُ / الرَّكْضُ الخَفِيفُ", "transliteration": "Al-Jary", "notes": "رياضة الركض في الهواء الطلق"},
        "german": {"article": "das", "word": "Joggen", "plural": "die Joggen", "gender": "neuter", "example": "Frühmorgens gehe ich gerne eine halbe Stunde im Park joggen."},
        "english": {"word": "jogging / running", "phonetic": "/ˈdʒɒɡ.ɪŋ/", "example": "Morning jogging through green parks boosts cardiovascular stamina."},
        "image_id": "img_wel_joggen"
    },
    {
        "id": "wel_muskel",
        "category": "wellness_fitness",
        "arabic": {"word": "العَضَلَةُ", "transliteration": "Al-'Adalah", "notes": "النسيج العضلي المسؤول عن حركة الجسم وقوته"},
        "german": {"article": "der", "word": "Muskel", "plural": "die Muskeln", "gender": "masculine", "example": "Krafttraining baut starke Muskeln auf und schützt die Gelenke."},
        "english": {"word": "muscle", "phonetic": "/ˈmʌs.əl/", "example": "Resistance training builds lean muscle and strengthens joints."},
        "image_id": "img_wel_muskel"
    },
    {
        "id": "wel_herzschlag",
        "category": "wellness_fitness",
        "arabic": {"word": "نَبْضُ القَلْبِ", "transliteration": "Nabd Al-Qalb", "notes": "دقات القلب المعبرة عن الجهد والراحة"},
        "german": {"article": "der", "word": "Herzschlag", "plural": "die Herzschläge", "gender": "masculine", "example": "Beim Ausdauertraining erhöht sich der Herzschlag spürbar."},
        "english": {"word": "heartbeat / pulse", "phonetic": "/ˈhɑːt.biːt/", "example": "Aerobic workouts gradually increase your resting heartbeat efficiency."},
        "image_id": "img_wel_herzschlag"
    },
    {
        "id": "wel_ernaehrung",
        "category": "wellness_fitness",
        "arabic": {"word": "التَّغْذِيَةُ السَّلِيمَةُ", "transliteration": "At-Taghthiyah As-Saleemah", "notes": "تناول الأطعمة الغنية بالمعادن والفيتامينات"},
        "german": {"article": "die", "word": "Ernährung", "plural": "die Ernährungen", "gender": "feminine", "example": "Eine ausgewogene Ernährung liefert Energie für den ganzen Tag."},
        "english": {"word": "nutrition / diet", "phonetic": "/njuːˈtrɪʃ.ən/", "example": "Balanced daily nutrition provides sustained vitality and energy."},
        "image_id": "img_wel_ernaehrung"
    },
    {
        "id": "wel_vitamin",
        "category": "wellness_fitness",
        "arabic": {"word": "الفِيتَامِينُ", "transliteration": "Al-Vitamin", "notes": "المركب الغذائي الضروري للمناعة والنمو"},
        "german": {"article": "das", "word": "Vitamin", "plural": "die Vitamine", "gender": "neuter", "example": "Frisches Obst und Gemüse enthalten wertvolle Vitamine."},
        "english": {"word": "vitamin", "phonetic": "/ˈvɪt.ə.mɪn/", "example": "Citrus fruits are packed with immune-boosting vitamin C."},
        "image_id": "img_wel_vitamin"
    },
    {
        "id": "wel_schlaf",
        "category": "wellness_fitness",
        "arabic": {"word": "جَوْدَةُ النَّوْمِ / النَّوْمُ العَمِيقُ", "transliteration": "Jawdat An-Nawm", "notes": "الراحة الليلية الكافية لترميم الخلايا"},
        "german": {"article": "der", "word": "Schlaf", "plural": "die Schlafe", "gender": "masculine", "example": "Acht Stunden erholsamer Schlaf sind unverzichtbar für die Regeneration."},
        "english": {"word": "sleep quality / rest", "phonetic": "/sliːp/", "example": "Uninterrupted deep sleep is crucial for cellular repair."},
        "image_id": "img_wel_schlaf"
    },
    {
        "id": "wel_energie",
        "category": "wellness_fitness",
        "arabic": {"word": "مُسْتَوَى الطَّاقَةِ وَالنَّشَاطِ", "transliteration": "Mustawa At-Taqah", "notes": "الحيوية والقدرة على العمل دون إعياء"},
        "german": {"article": "die", "word": "Energie", "plural": "die Energien", "gender": "feminine", "example": "Nach einem gesunden Frühstück habe ich viel Energie."},
        "english": {"word": "energy level / vitality", "phonetic": "/ˈen.ə.dʒi/", "example": "A wholesome protein breakfast sustains high energy levels."},
        "image_id": "img_wel_energie"
    },
    {
        "id": "wel_gleichgewicht",
        "category": "wellness_fitness",
        "arabic": {"word": "التَّوَازُنُ البَدَنِيُّ وَالنَّفْسِيُّ", "transliteration": "At-Tawazun", "notes": "حالة الاستقرار بين الجهد والراحة"},
        "german": {"article": "das", "word": "Gleichgewicht", "plural": "die Gleichgewichte", "gender": "neuter", "example": "Finde das richtige Gleichgewicht zwischen Arbeit und Erholung."},
        "english": {"word": "balance / equilibrium", "phonetic": "/ˈbæl.əns/", "example": "Striking a healthy work-life balance prevents burnout."},
        "image_id": "img_wel_gleichgewicht"
    },
    {
        "id": "wel_erschoepfung",
        "category": "wellness_fitness",
        "arabic": {"word": "الإِرْهَاقُ الشَّدِيدُ / التَّعَبُ", "transliteration": "Al-Irhaq", "notes": "نفاد طاقة الجسم والحاجة الماسة للراحة"},
        "german": {"article": "die", "word": "Erschöpfung", "plural": "die Erschöpfungen", "gender": "feminine", "example": "Chronische Erschöpfung ist ein deutliches Warnsignal des Körpers."},
        "english": {"word": "exhaustion / fatigue", "phonetic": "/ɪɡˈzɔːs.tʃən/", "example": "Chronic physical exhaustion indicates a serious need for rest."},
        "image_id": "img_wel_erschoepfung"
    },
    {
        "id": "wel_laune",
        "category": "wellness_fitness",
        "arabic": {"word": "المِزَاجُ / الحَالَةُ النَّفْسِيَّةُ", "transliteration": "Al-Mizaj", "notes": "المشاعر السائدة للشخص خلال اليوم"},
        "german": {"article": "die", "word": "Laune", "plural": "die Launen", "gender": "feminine", "example": "Sonniges Wetter sorgt meist für gute Laune."},
        "english": {"word": "mood / spirits", "phonetic": "/muːd/", "example": "A brisk morning stroll instantly lifts your mood."},
        "image_id": "img_wel_laune"
    },
    {
        "id": "wel_motivation",
        "category": "wellness_fitness",
        "arabic": {"word": "الحَافِزُ / الدَّافِعِيَّةُ", "transliteration": "Al-Hafiz", "notes": "الرغبة الداخلية الدافعة لإنجاز الأهداف"},
        "german": {"article": "die", "word": "Motivation", "plural": "die Motivationen", "gender": "feminine", "example": "Gemeinsames Lernen steigert die Motivation beim Sprachenlernen."},
        "english": {"word": "motivation", "phonetic": "/ˌməʊ.tɪˈveɪ.ʃən/", "example": "Shared community goals foster long-term learning motivation."},
        "image_id": "img_wel_motivation"
    },
    {
        "id": "wel_ruhe",
        "category": "wellness_fitness",
        "arabic": {"word": "الهُدُوءُ / الطُّمَأْنِينَةُ", "transliteration": "Al-Hodoo'", "notes": "سكون النفس وغياب الضجيج والاضطراب"},
        "german": {"article": "die", "word": "Ruhe", "plural": "die Ruhen", "gender": "feminine", "example": "In der Ruhe liegt die Kraft für neue Herausforderungen."},
        "english": {"word": "calmness / tranquility", "phonetic": "/ˈkɑːm.nəs/", "example": "Inner calmness allows for rational decision-making."},
        "image_id": "img_wel_ruhe"
    },
    {
        "id": "wel_dehnen",
        "category": "wellness_fitness",
        "arabic": {"word": "تَمْدِيدُ العَضَلَاتِ / الإِطَالَةُ", "transliteration": "Tamdeed Al-'Adalat", "notes": "تليين العضلات قبل التمارين وبعدها"},
        "german": {"article": "das", "word": "Dehnen", "plural": "die Dehnen", "gender": "neuter", "example": "Sanftes Dehnen nach dem Laufen verhindert Muskelkater."},
        "english": {"word": "stretching", "phonetic": "/ˈstretʃ.ɪŋ/", "example": "Post-workout stretching maintains muscle elasticity and flexibility."},
        "image_id": "img_wel_dehnen"
    },
    {
        "id": "wel_hydratation",
        "category": "wellness_fitness",
        "arabic": {"word": "شُرْبُ المَاءِ الكَافِي / التَّرْطِيبُ", "transliteration": "Shurb Al-Ma'", "notes": "تزويد الجسم بالسوائل اللازمة لوظائفه الحيوية"},
        "german": {"article": "die", "word": "Flüssigkeitszufuhr", "plural": "die Flüssigkeitszufuhren", "gender": "feminine", "example": "Ausreichende Flüssigkeitszufuhr hält den Kreislauf stabil."},
        "english": {"word": "hydration", "phonetic": "/haɪˈdreɪ.ʃən/", "example": "Proper hydration keeps energy levels steady throughout the day."},
        "image_id": "img_wel_hydratation"
    },
    {
        "id": "wel_lebensstil",
        "category": "wellness_fitness",
        "arabic": {"word": "نَمَطُ الحَيَاةِ الصِّحِّيُّ", "transliteration": "Namat Al-Hayah As-Sihhi", "notes": "منظومة العادات اليومية الإيجابية"},
        "german": {"article": "der", "word": "Lebensstil", "plural": "die Lebensstile", "gender": "masculine", "example": "Ein gesunder Lebensstil beugt vielen Krankheiten vor."},
        "english": {"word": "healthy lifestyle", "phonetic": "/ˈlaɪf.staɪl/", "example": "Adopting an active healthy lifestyle enriches longevity."},
        "image_id": "img_wel_lebensstil"
    }
]

# حفظ ملف المفردات الجديد في content/vocabulary/wellness_fitness_a2.json
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/wellness_fitness_a2.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "wellness_fitness",
        "category_name": {
            "ar": "الصحة النفسية واللياقة البدنية",
            "de": "Fitness & Wohlbefinden",
            "en": "Wellness & Fitness"
        },
        "level": "A2",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم عافية ولياقة في {vocab_path}")

# 2. توليد 25 أيقونة SVG خفيفة ومتجهية (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "wel_wohlbefinden": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00897B"/><path d="M50,68 C35,55 25,44 25,34 C25,25 32,20 40,20 C46,20 50,25 50,25 C50,25 54,20 60,20 C68,20 75,25 75,34 C75,44 65,55 50,68 Z" fill="#FF5252"/><circle cx="50" cy="40" r="6" fill="#FFF"/></svg>',
    "wel_psychische_gesundheit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#5C6BC0"/><path d="M35,45 Q35,30 50,30 Q65,30 65,45 Q65,60 55,65 L55,72 L45,72 L45,65 Q35,60 35,45 Z" fill="#FFF"/><polygon points="50,22 53,28 60,28 55,33 57,40 50,35 43,40 45,33 40,28 47,28" fill="#FFD54F"/></svg>',
    "wel_fitness": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="44" width="70" height="12" rx="4" fill="#78909C"/><rect x="18" y="32" width="12" height="36" rx="4" fill="#E53935"/><rect x="10" y="36" width="8" height="28" rx="3" fill="#D32F2F"/><rect x="70" y="32" width="12" height="36" rx="4" fill="#E53935"/><rect x="82" y="36" width="8" height="28" rx="3" fill="#D32F2F"/><circle cx="50" cy="50" r="6" fill="#FFD54F"/></svg>',
    "wel_meditation": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="25" r="10" fill="#FFA726"/><path d="M50,38 C35,38 30,55 30,70 L70,70 C70,55 65,38 50,38 Z" fill="#26A69A"/><path d="M22,72 C22,65 35,62 50,68 C65,62 78,65 78,72 Z" fill="#00897B"/><circle cx="50" cy="48" r="4" fill="#FFF"/></svg>',
    "wel_stress": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#E53935"/><circle cx="38" cy="42" r="4" fill="#FFF"/><circle cx="62" cy="42" r="4" fill="#FFF"/><path d="M35,68 Q50,52 65,68" stroke="#FFF" stroke-width="5" fill="none" stroke-linecap="round"/><polygon points="46,12 56,12 48,25 58,25 42,42 46,30 38,30" fill="#FFEB3B"/></svg>',
    "wel_entspannung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#81D4FA"/><path d="M25,55 Q50,40 75,55" stroke="#0288D1" stroke-width="6" fill="none" stroke-linecap="round"/><circle cx="50" cy="35" r="10" fill="#FFA726"/><path d="M30,68 Q50,78 70,68" stroke="#0288D1" stroke-width="4" fill="none" stroke-linecap="round"/></svg>',
    "wel_fitnessstudio": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="25" width="64" height="55" rx="6" fill="#37474F"/><rect x="25" y="45" width="50" height="8" rx="2" fill="#B0BEC5"/><rect x="28" y="35" width="8" height="28" rx="2" fill="#FF7043"/><rect x="64" y="35" width="8" height="28" rx="2" fill="#FF7043"/><polygon points="50,15 20,28 80,28" fill="#263238"/></svg>',
    "wel_uebung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="22" r="10" fill="#FFA726"/><path d="M50,34 L50,58 L32,78 M50,58 L68,78 M25,48 L75,48" stroke="#1E88E5" stroke-width="6" fill="none" stroke-linecap="round"/><circle cx="50" cy="50" r="36" fill="none" stroke="#64B5F6" stroke-width="2.5" stroke-dasharray="6,4"/></svg>',
    "wel_atmung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#E0F2F1"/><path d="M30,60 C30,42 42,32 50,42 C58,32 70,42 70,60 C70,72 58,78 50,78 C42,78 30,72 30,60 Z" fill="#26A69A"/><path d="M50,22 L50,38 M44,30 L50,38 L56,30" stroke="#00796B" stroke-width="4" fill="none" stroke-linecap="round"/></svg>',
    "wel_yoga": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="22" r="8" fill="#FFB74D"/><path d="M50,32 L50,55 L30,65 L22,58 M50,55 L70,65 L78,58 M32,44 L68,44" stroke="#8E24AA" stroke-width="5" fill="none" stroke-linecap="round"/><circle cx="50" cy="44" r="3" fill="#BA68C8"/></svg>',
    "wel_joggen": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="58" cy="22" r="9" fill="#FFA726"/><path d="M48,34 L42,52 L24,62 M42,52 L56,70 L72,66 M32,44 L52,40 L64,48" stroke="#D84315" stroke-width="6" fill="none" stroke-linecap="round"/><line x1="15" y1="84" x2="85" y2="84" stroke="#BDBDBD" stroke-width="4" stroke-linecap="round"/></svg>',
    "wel_muskel": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FF7043"/><path d="M30,60 C25,45 35,32 50,35 C60,25 75,30 75,50 C75,70 55,75 35,75 Z" fill="#FFF"/><path d="M38,60 Q50,48 62,56" stroke="#D84315" stroke-width="4" fill="none"/></svg>',
    "wel_herzschlag": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#C62828"/><path d="M20,50 L35,50 L42,32 L50,68 L58,40 L65,50 L80,50" stroke="#FFF" stroke-width="5" fill="none" stroke-linecap="round" stroke-linejoin="round"/></svg>',
    "wel_ernaehrung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#43A047"/><circle cx="50" cy="50" r="26" fill="#FFF"/><path d="M42,38 C42,28 58,28 58,38 L58,62 L42,62 Z" fill="#81C784"/><line x1="50" y1="30" x2="50" y2="65" stroke="#2E7D32" stroke-width="3"/></svg>',
    "wel_vitamin": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FFA000"/><polygon points="35,30 65,30 75,50 65,70 35,70 25,50" fill="#FFF"/><text x="50" y="58" font-family="sans-serif" font-weight="bold" font-size="22" fill="#E65100" text-anchor="middle">VIT</text></svg>',
    "wel_schlaf": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1A237E"/><path d="M58,25 C42,25 32,38 32,54 C32,70 42,80 58,80 C48,74 44,62 44,54 C44,42 50,32 58,25 Z" fill="#FFD54F"/><circle cx="68" cy="35" r="3" fill="#FFF"/><circle cx="72" cy="55" r="2.5" fill="#FFF"/></svg>',
    "wel_energie": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FFB300"/><polygon points="52,18 32,50 48,50 42,82 68,44 52,44" fill="#D84315"/><polygon points="51,24 38,48 48,48 44,72 62,46 51,46" fill="#FFF"/></svg>',
    "wel_gleichgewicht": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,45 35,75 65,75" fill="#5D4037"/><line x1="20" y1="45" x2="80" y2="45" stroke="#3E2723" stroke-width="5" stroke-linecap="round"/><circle cx="28" cy="35" r="10" fill="#42A5F5"/><circle cx="72" cy="35" r="10" fill="#66BB6A"/><circle cx="50" cy="45" r="4" fill="#FFD54F"/></svg>',
    "wel_erschoepfung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#78909C"/><line x1="32" y1="42" x2="44" y2="42" stroke="#FFF" stroke-width="4" stroke-linecap="round"/><line x1="56" y1="42" x2="68" y2="42" stroke="#FFF" stroke-width="4" stroke-linecap="round"/><path d="M38,65 Q50,55 62,65" stroke="#FFF" stroke-width="4" fill="none" stroke-linecap="round"/><circle cx="68" cy="28" r="4" fill="#90CAF9"/></svg>',
    "wel_laune": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FFD54F"/><circle cx="38" cy="42" r="5" fill="#3E2723"/><circle cx="62" cy="42" r="5" fill="#3E2723"/><path d="M35,60 Q50,75 65,60" stroke="#3E2723" stroke-width="5" fill="none" stroke-linecap="round"/></svg>',
    "wel_motivation": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00C853"/><polygon points="50,20 58,38 78,40 64,54 68,74 50,64 32,74 36,54 22,40 42,38" fill="#FFD54F"/><circle cx="50" cy="48" r="8" fill="#FFF"/></svg>',
    "wel_ruhe": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#80CBC4"/><circle cx="50" cy="50" r="28" fill="#B2DFDB"/><circle cx="50" cy="50" r="16" fill="#E0F2F1"/><circle cx="50" cy="50" r="6" fill="#004D40"/></svg>',
    "wel_dehnen": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="22" r="9" fill="#FFA726"/><path d="M45,32 L45,62 L25,72 M45,62 L65,72 M22,35 L45,45 L70,30" stroke="#6A1B9A" stroke-width="5" fill="none" stroke-linecap="round"/><path d="M20,80 Q50,75 80,80" stroke="#BDBDBD" stroke-width="3" fill="none"/></svg>',
    "wel_hydratation": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0288D1"/><path d="M50,22 C50,22 30,46 30,62 C30,74 39,82 50,82 C61,82 70,74 70,62 C70,46 50,22 50,22 Z" fill="#E1F5FE"/><circle cx="44" cy="58" r="4" fill="#0288D1"/></svg>',
    "wel_lebensstil": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#43A047"/><path d="M30,55 C30,35 50,25 70,30 C70,50 60,70 40,70 Z" fill="#FFF"/><polygon points="48,35 56,45 46,55 54,65" stroke="#2E7D32" stroke-width="3" fill="none"/></svg>'
}

# كتابة ملفات الـ SVG الفردية
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
            "description": f"Vector illustration for wellness concept: {c['english']['word']}"
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
    
    if "wellness_fitness_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/environment_green_a2.json',",
            "'assets/content/vocabulary/environment_green_a2.json',\n    'assets/content/vocabulary/wellness_fitness_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط wellness_fitness_a2.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "wellness_fitness" not in cat_code:
        entry = """    CategoryMeta(
      id: 'wellness_fitness',
      titleAr: 'الصحة النفسية واللياقة',
      titleDe: 'Fitness & Wohlbefinden',
      titleEn: 'Wellness & Fitness',
      icon: Icons.self_improvement_rounded,
      primaryColor: Color(0xFF00897B),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم الصحة النفسية واللياقة في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 21", "TOTAL_VOCAB_CATEGORIES = 22")
    val_code = val_code.replace("TOTAL_CONCEPTS = 530", "TOTAL_CONCEPTS = 555")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 610", "TOTAL_SVG_ASSETS = 635")
    
    if "wellness_fitness_a2.json" not in val_code:
        val_code = val_code.replace(
            "'environment_green_a2.json',",
            "'environment_green_a2.json',\n    'wellness_fitness_a2.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (22 فئة، 555 مفهومًا، 635 أصلًا متجهيًا)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 037 Status (Completed - Level A2 Wellness Category)
- **Feature:** Category 22: Health, Mental Wellness & Fitness (`wellness_fitness_a2.json`).
- **New Concepts:** 25 trilingual vocabulary items for mental health, meditation, workout, nutrition, and well-being.
- **New Visuals:** 25 unique lightweight SVG vectors (`wel_*.svg`).
- **Milestone Reached:** 22 Vocabulary Categories | 555 Core Concepts | 35 Base Verbs | 15 Perfekt Forms | 40 Syntax Exercises | 24 Prepositions | 5 Dialogues | Articles & Genitiv Engines | 635 Total SVG Icons.
- **Integration:** Active in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 037 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 037 بنجاح تام!")
