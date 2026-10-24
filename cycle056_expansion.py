import json
import os

print("🚀 [CYCLE 056] بدء بناء قسم علم النفس والسلوك الإنساني (Psychology & Behavior - A2)...")

# 1. قائمة الـ 25 مفهومًا لقسم علم النفس والسلوك الإنساني
concepts = [
    {
        "id": "psy_psychologie",
        "category": "psychology_behavior",
        "arabic": {"word": "عِلْمُ النَّفْسِ", "transliteration": "Ilm An-Nafs", "notes": "دراسة العمليات العقلية والسلوك البشري"},
        "german": {"article": "die", "word": "Psychologie", "plural": "die Psychologien", "gender": "feminine", "example": "Die angewandte Psychologie hilft Menschen, Krisen zu bewältigen."},
        "english": {"word": "psychology", "phonetic": "/saɪˈkɒl.ə.dʒi/", "example": "Modern psychology investigates cognitive processes and emotional well-being."},
        "image_id": "img_psy_psychologie"
    },
    {
        "id": "psy_verhalten",
        "category": "psychology_behavior",
        "arabic": {"word": "السُّلُوكُ / التَّصَرُّفُ", "transliteration": "As-Sulook", "notes": "مجموع الأفعال والاستجابات الصادرة عن الفرد"},
        "german": {"article": "das", "word": "Verhalten", "plural": "die Verhalten", "gender": "neuter", "example": "Positives soziales Verhalten stärkt das Miteinander in der Gruppe."},
        "english": {"word": "behavior / conduct", "phonetic": "/bɪˈheɪ.vjər/", "example": "Prosocial behavior promotes mutual trust within the community."},
        "image_id": "img_psy_verhalten"
    },
    {
        "id": "psy_gewohnheit",
        "category": "psychology_behavior",
        "arabic": {"word": "العَادَةُ اليَوْمِيَّةُ", "transliteration": "Al-'Adah", "notes": "النمط السلوكي المكتسب المتكرر تلقائيًا"},
        "german": {"article": "die", "word": "Gewohnheit", "plural": "die Gewohnheiten", "gender": "feminine", "example": "Gute Gewohnheiten am Morgen erleichtern einen erfolgreichen Tag."},
        "english": {"word": "habit / routine", "phonetic": "/ˈhæb.ɪt/", "example": "Building healthy daily habits requires consistent patience."},
        "image_id": "img_psy_gewohnheit"
    },
    {
        "id": "psy_persoenlichkeit",
        "category": "psychology_behavior",
        "arabic": {"word": "الشَّخْصِيَّةُ", "transliteration": "Ash-Shakhsiyyah", "notes": "مجموع السمات النفسية والفكرية المميزة للفرد"},
        "german": {"article": "die", "word": "Persönlichkeit", "plural": "die Persönlichkeiten", "gender": "feminine", "example": "Jeder Mensch besitzt eine einzigartige und vielschichtige Persönlichkeit."},
        "english": {"word": "personality", "phonetic": "/ˌpɜː.sənˈæl.ə.ti/", "example": "Childhood experiences profoundly shape an individual's adult personality."},
        "image_id": "img_psy_persoenlichkeit"
    },
    {
        "id": "psy_charakter",
        "category": "psychology_behavior",
        "arabic": {"word": "الطَّبْعُ / المِزَاجُ الخُلُقِيُّ", "transliteration": "At-Tab' / Al-Khuluq", "notes": "البنية الأخلاقية والوجدانية الأصيلة للإنسان"},
        "german": {"article": "der", "word": "Charakter", "plural": "die Charaktere", "gender": "masculine", "example": "Ein ehrlicher und standhafter Charakter zeigt sich in schwierigen Zeiten."},
        "english": {"word": "character / temperament", "phonetic": "/ˈkær.ək.tər/", "example": "True moral character reveals itself during challenging moments."},
        "image_id": "img_psy_charakter"
    },
    {
        "id": "psy_emotion",
        "category": "psychology_behavior",
        "arabic": {"word": "العَاطِفَةُ / الانْفِعَالُ النَّفْسِيُّ", "transliteration": "Al-'Aatifah", "notes": "الحالة الوجدانية كالفرح أو الحزن أو الغضب"},
        "german": {"article": "die", "word": "Emotion", "plural": "die Emotionen", "gender": "feminine", "example": "Musik vermag starke Emotionen im Menschen hervorzurufen."},
        "english": {"word": "emotion / feeling", "phonetic": "/ɪˈməʊ.ʃən/", "example": "Emotional intelligence involves recognizing and regulating intense feelings."},
        "image_id": "img_psy_emotion"
    },
    {
        "id": "psy_angst",
        "category": "psychology_behavior",
        "arabic": {"word": "الخَوْفُ / القَلَقُ", "transliteration": "Al-Khawf", "notes": "الشعور الفطري بالحذر تجاه الخطر"},
        "german": {"article": "die", "word": "Angst", "plural": "die Ängste", "gender": "feminine", "example": "Mut bedeutet nicht, keine Angst zu haben, sondern sie zu überwinden."},
        "english": {"word": "fear / anxiety", "phonetic": "/fɪər/", "example": "Courage is not the absence of fear, but the triumph over it."},
        "image_id": "img_psy_angst"
    },
    {
        "id": "psy_mut",
        "category": "psychology_behavior",
        "arabic": {"word": "الشَّجَاعَةُ / الإِقْدَامُ", "transliteration": "Ash-Shaja'ah", "notes": "القدرة النفسية على مواجهة التحديات والصعاب"},
        "german": {"article": "der", "word": "Mut", "plural": "die Mute", "gender": "masculine", "example": "Es erfordert Mut, eine neue Sprache im Ausland zu sprechen."},
        "english": {"word": "courage / bravery", "phonetic": "/ˈkʌr.ɪdʒ/", "example": "Taking the first step into the unknown requires genuine courage."},
        "image_id": "img_psy_mut"
    },
    {
        "id": "psy_selbstvertrauen",
        "category": "psychology_behavior",
        "arabic": {"word": "الثِّقَةُ بِالنَّفْسِ", "transliteration": "Ath-Thiqah Bin-Nafs", "notes": "الإيمان الداخلي بقدرة الذات على النجاح والإنجاز"},
        "german": {"article": "das", "word": "Selbstvertrauen", "plural": "die Selbstvertrauen", "gender": "neuter", "example": "Kleine tägliche Erfolge stärken das Selbstvertrauen nachhaltig."},
        "english": {"word": "self-confidence", "phonetic": "/ˌselfˈkɒn.fɪ.dəns/", "example": "Celebrating incremental achievements builds lasting self-confidence."},
        "image_id": "img_psy_selbstvertrauen"
    },
    {
        "id": "psy_empathie",
        "category": "psychology_behavior",
        "arabic": {"word": "التَّعَاطُفُ الوِجْدَانِيُّ", "transliteration": "At-Ta'atuf", "notes": "القدرة على وضع النفس موضع الآخر ومشاركتهم مشاعرهم"},
        "german": {"article": "die", "word": "Empathie", "plural": "die Empathien", "gender": "feminine", "example": "Empathie ist der Schlüssel zu harmonischen menschlichen Beziehungen."},
        "english": {"word": "empathy / compassion", "phonetic": "/ˈem.pə.θi/", "example": "Active listening and heartfelt empathy bridge cultural divides."},
        "image_id": "img_psy_empathie"
    },
    {
        "id": "psy_geduld",
        "category": "psychology_behavior",
        "arabic": {"word": "الصَّبْرُ / الأَنَاةُ", "transliteration": "As-Sabr", "notes": "التحمل الهادئ والانتظار دون تذمر أو يأس"},
        "german": {"article": "die", "word": "Geduld", "plural": "die Gedulden", "gender": "feminine", "example": "Beim Erlernen einer Fremdsprache braucht man Geduld und Ausdauer."},
        "english": {"word": "patience", "phonetic": "/ˈpeɪ.ʃəns/", "example": "Mastering any complex skill requires discipline and persistent patience."},
        "image_id": "img_psy_geduld"
    },
    {
        "id": "psy_neugier",
        "category": "psychology_behavior",
        "arabic": {"word": "الفُضُولُ المَعْرِفِيُّ / الشَّغَفُ", "transliteration": "Al-Fudool", "notes": "الرغبة الفطرية في الاستكشاف والتعلم"},
        "german": {"article": "die", "word": "Neugier", "plural": "die Neugier", "gender": "feminine", "example": "Kindliche Neugier treibt den menschlichen Erkenntnisdrang an."},
        "english": {"word": "curiosity / inquisitiveness", "phonetic": "/ˌnjʊə.riˈɒs.ə.ti/", "example": "Intellectual curiosity inspires scientific breakthroughs and artistic wonder."},
        "image_id": "img_psy_neugier"
    },
    {
        "id": "psy_disziplin",
        "category": "psychology_behavior",
        "arabic": {"word": "الِانْضِبَاطُ الذَّاتِيُّ", "transliteration": "Al-Indibat", "notes": "الالتزام الواعي بتنفيذ الواجبات وتطوير النفس"},
        "german": {"article": "die", "word": "Disziplin", "plural": "die Disziplinen", "gender": "feminine", "example": "Eiserne Disziplin führt oft sicherer zum Erfolg als reines Talent."},
        "english": {"word": "self-discipline", "phonetic": "/ˈdɪs.ə.plɪn/", "example": "Consistent self-discipline turns ambitious aspirations into reality."},
        "image_id": "img_psy_disziplin"
    },
    {
        "id": "psy_intuition",
        "category": "psychology_behavior",
        "arabic": {"word": "الحَدْسُ / البَدِيهَةُ", "transliteration": "Al-Hads", "notes": "الإدراك الفوري المباشر دون تفكير استدلالي طويل"},
        "german": {"article": "die", "word": "Intuition", "plural": "die Intuitionen", "gender": "feminine", "example": "Oft hilft uns die innere Intuition, die richtige Entscheidung zu treffen."},
        "english": {"word": "intuition / gut feeling", "phonetic": "/ˌɪn.tʃuːˈɪʃ.ən/", "example": "Trusting your trained intuition often guides sound decisions."},
        "image_id": "img_psy_intuition"
    },
    {
        "id": "psy_gedaechtnis",
        "category": "psychology_behavior",
        "arabic": {"word": "الذَّاكِرَةُ", "transliteration": "Ath-Thakirah", "notes": "ملكة تخزين المعلومات واسترجاعها في الوقت المناسب"},
        "german": {"article": "das", "word": "Gedächtnis", "plural": "die Gedächtnisse", "gender": "neuter", "example": "Spaced Repetition trainiert das Langzeitgedächtnis optimal."},
        "english": {"word": "memory", "phonetic": "/ˈmem.ər.i/", "example": "Spaced repetition algorithms strengthen long-term memory recall."},
        "image_id": "img_psy_gedaechtnis"
    },
    {
        "id": "psy_wahrnehmung",
        "category": "psychology_behavior",
        "arabic": {"word": "الإِدْرَاكُ الحِسِّيُّ", "transliteration": "Al-Idrak", "notes": "استقبال وتفسير المعلومات الواردة من الحواس"},
        "german": {"article": "die", "word": "Wahrnehmung", "plural": "die Wahrnehmungen", "gender": "feminine", "example": "Unsere subjektive Wahrnehmung wird von Gefühlen und Erfahrungen geprägt."},
        "english": {"word": "perception", "phonetic": "/pəˈsep.ʃən/", "example": "Sensory perception is deeply influenced by cultural context."},
        "image_id": "img_psy_wahrnehmung"
    },
    {
        "id": "psy_unterbewusstsein",
        "category": "psychology_behavior",
        "arabic": {"word": "العَقْلُ اللَّاوَاعِي (البَاطِنُ)", "transliteration": "Al-'Aql Al-Batin", "notes": "مخزن الذكريات والمشاعر غير الواعية المؤثرة على السلوك"},
        "german": {"article": "das", "word": "Unterbewusstsein", "plural": "die Unterbewusstsein", "gender": "neuter", "example": "Das Unterbewusstsein verarbeitet im Schlaf die Erlebnisse des Tages."},
        "english": {"word": "subconscious mind", "phonetic": "/ˌsʌbˈkɒn.ʃəs/", "example": "The subconscious mind integrates learned speech patterns while sleeping."},
        "image_id": "img_psy_unterbewusstsein"
    },
    {
        "id": "psy_entscheidung",
        "category": "psychology_behavior",
        "arabic": {"word": "القَرَارُ", "transliteration": "Al-Qarar", "notes": "الاختيار الحاسم بين عدة بدائل"},
        "german": {"article": "die", "word": "Entscheidung", "plural": "die Entscheidungen", "gender": "feminine", "example": "Er traf eine wohlüberlegte Entscheidung für seine berufliche Zukunft."},
        "english": {"word": "decision", "phonetic": "/dɪˈsɪʒ.ən/", "example": "Making a well-considered decision requires balancing reason and intuition."},
        "image_id": "img_psy_entscheidung"
    },
    {
        "id": "psy_reaktion",
        "category": "psychology_behavior",
        "arabic": {"word": "رَدَّةُ الفِعْلِ / الِاسْتِجَابَةُ", "transliteration": "Raddat Al-Fi'l", "notes": "التصرف التلقائي الناتج عن مؤثر خارجي"},
        "german": {"article": "die", "word": "Reaktion", "plural": "die Reaktionen", "gender": "feminine", "example": "Seine ruhige Reaktion deeskalierte den drohenden Streit sofort."},
        "english": {"word": "reaction / response", "phonetic": "/riˈæk.ʃən/", "example": "A measured response prevents minor conflicts from escalating."},
        "image_id": "img_psy_reaktion"
    },
    {
        "id": "psy_frustration",
        "category": "psychology_behavior",
        "arabic": {"word": "الإِحْبَاطُ / خَيْبَةُ الأَمَلِ", "transliteration": "Al-Ihbat", "notes": "الشعور بالعجز عند تعذر تحقيق الهدف"},
        "german": {"article": "die", "word": "Frustration", "plural": "die Frustrationen", "gender": "feminine", "example": "Rückschläge gehören zum Lernen dazu und dürfen nicht zu Frustration führen."},
        "english": {"word": "frustration", "phonetic": "/frʌsˈtreɪ.ʃən/", "example": "Overcoming initial learning frustration builds true expertise."},
        "image_id": "img_psy_frustration"
    },
    {
        "id": "psy_resilienz",
        "category": "psychology_behavior",
        "arabic": {"word": "الصُّمُودُ النَّفْسِيُّ / المُرُونَةُ", "transliteration": "As-Sumood An-Nafsi", "notes": "القدرة النفسية على التعافي السريع من الأزمات والضغوط"},
        "german": {"article": "die", "word": "Resilienz", "plural": "die Resilienzen", "gender": "feminine", "example": "Psychische Resilienz hilft uns, gestärkt aus Lebenskrisen hervorzugehen."},
        "english": {"word": "resilience / fortitude", "phonetic": "/rɪˈzɪl.jəns/", "example": "Emotional resilience allows people to bounce back from adversity."},
        "image_id": "img_psy_resilienz"
    },
    {
        "id": "psy_hoffnung",
        "category": "psychology_behavior",
        "arabic": {"word": "الأَمَلُ وَالرَّجَاءُ", "transliteration": "Al-Amal", "notes": "التطلع الإيجابي للغد وتوقع الخير"},
        "german": {"article": "die", "word": "Hoffnung", "plural": "die Hoffnungen", "gender": "feminine", "example": "Die Hoffnung gibt uns Kraft in dunklen Momenten."},
        "english": {"word": "hope / optimism", "phonetic": "/həʊp/", "example": "Unwavering hope illuminates the path toward personal renewal."},
        "image_id": "img_psy_hoffnung"
    },
    {
        "id": "psy_dankbarkeit",
        "category": "psychology_behavior",
        "arabic": {"word": "الِامْتِنَانُ وَالشُّكْرُ", "transliteration": "Al-Imtinan", "notes": "الاعتراف بجميل النعم والفضل والرضا القلبي"},
        "german": {"article": "die", "word": "Dankbarkeit", "plural": "die Dankbarkeiten", "gender": "feminine", "example": "Tägliche Dankbarkeit fördert nachweislich die seelische Gesundheit."},
        "english": {"word": "gratitude / thankfulness", "phonetic": "/ˈɡræt.ɪ.tʃuːd/", "example": "Practicing daily gratitude cultivates enduring inner contentment."},
        "image_id": "img_psy_dankbarkeit"
    },
    {
        "id": "psy_selbstbeherrschung",
        "category": "psychology_behavior",
        "arabic": {"word": "ضَبْطُ النَّفْسِ / التَّحَكُّمُ الذَّاتِيُّ", "transliteration": "Dabt An-Nafs", "notes": "القدرة على كبح الانفعالات والشهوات بعقلانية"},
        "german": {"article": "die", "word": "Selbstbeherrschung", "plural": "die Selbstbeherrschungen", "gender": "feminine", "example": "In hitzigen Diskussionen ist eiserne Selbstbeherrschung Gold wert."},
        "english": {"word": "self-control / restraint", "phonetic": "/ˌself.kənˈtrəʊl/", "example": "Exhibiting self-control during disputes preserves vital friendships."},
        "image_id": "img_psy_selbstbeherrschung"
    },
    {
        "id": "psy_identitaet",
        "category": "psychology_behavior",
        "arabic": {"word": "الهُوِيَّةُ الذَّاتِيَّةُ", "transliteration": "Al-Huwiyyah", "notes": "إدراك الفرد لخصائصه وقيمه وانتمائه"},
        "german": {"article": "die", "word": "Identität", "plural": "die Identitäten", "gender": "feminine", "example": "Sprache und Kultur bilden das Fundament unserer Identität."},
        "english": {"word": "identity", "phonetic": "/aɪˈden.tɪ.ti/", "example": "Language and culture form the bedrock of personal identity."},
        "image_id": "img_psy_identitaet"
    }
]

# حفظ ملف المفردات الجديد في content/vocabulary/psychology_behavior_a2.json
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/psychology_behavior_a2.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "psychology_behavior",
        "category_name": {
            "ar": "علم النفس والسلوك الإنساني",
            "de": "Psychologie, Verhalten & Gewohnheiten",
            "en": "Psychology, Behavior & Daily Habits"
        },
        "level": "A2",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم نفسية وسلوكية في {vocab_path}")

# 2. توليد 25 أيقونة SVG متقنة وخفيفة (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "psy_psychologie": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#673AB7"/><path d="M50,22 C36,22 30,32 30,46 C30,58 38,65 42,70 L42,78 L58,78 L58,70 C62,65 70,58 70,46 C70,32 64,22 50,22 Z" fill="#FFF"/><circle cx="50" cy="46" r="8" fill="#FFD54F"/><polygon points="50,14 53,20 60,20 55,25 57,32 50,28 43,32 45,25 40,20 47,20" fill="#FFC107"/></svg>',
    "psy_verhalten": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1565C0"/><circle cx="50" cy="30" r="12" fill="#FFA726"/><path d="M30,75 L30,55 L50,45 L70,55 L70,75" stroke="#FFF" stroke-width="7" fill="none" stroke-linecap="round"/><circle cx="50" cy="52" r="5" fill="#FFD54F"/></svg>',
    "psy_gewohnheit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00897B"/><path d="M50,22 A28,28 0 1,1 22,50" stroke="#FFF" stroke-width="6" fill="none" stroke-linecap="round"/><polygon points="22,38 22,54 36,46" fill="#FFF"/><circle cx="50" cy="50" r="6" fill="#FFD54F"/></svg>',
    "psy_persoenlichkeit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#5E35B1"/><circle cx="38" cy="40" r="16" fill="#8E24AA"/><circle cx="62" cy="40" r="16" fill="#BA68C8" opacity="0.85"/><circle cx="50" cy="40" r="8" fill="#FFD54F"/><path d="M26,78 C26,62 74,62 74,78 Z" fill="#FFF"/></svg>',
    "psy_charakter": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,15 80,30 80,68 50,85 20,68 20,30" fill="#3E2723"/><polygon points="50,22 72,34 72,64 50,78 28,64 28,34" fill="#8D6E63"/><polygon points="50,35 55,48 68,48 58,56 62,68 50,60 38,68 42,56 32,48 45,48" fill="#FFD54F"/></svg>',
    "psy_emotion": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#E91E63"/><path d="M50,68 C35,55 25,44 25,34 C25,25 32,20 40,20 C46,20 50,25 50,25 C50,25 54,20 60,20 C68,20 75,25 75,34 C75,44 65,55 50,68 Z" fill="#FFF"/><circle cx="50" cy="40" r="6" fill="#FFB300"/></svg>',
    "psy_angst": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#37474F"/><circle cx="38" cy="42" r="5" fill="#FFF"/><circle cx="62" cy="42" r="5" fill="#FFF"/><circle cx="38" cy="42" r="2.5" fill="#212121"/><circle cx="62" cy="42" r="2.5" fill="#212121"/><path d="M38,66 Q50,54 62,66" stroke="#FFF" stroke-width="5" fill="none" stroke-linecap="round"/><circle cx="68" cy="28" r="4" fill="#42A5F5"/></svg>',
    "psy_mut": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#C62828"/><polygon points="50,18 78,32 78,65 50,82 22,65 22,32" fill="#E53935"/><polygon points="50,30 55,42 68,42 58,50 62,62 50,54 38,62 42,50 32,42 45,42" fill="#FFD54F"/></svg>',
    "psy_selbstvertrauen": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0288D1"/><circle cx="50" cy="30" r="12" fill="#FFF"/><path d="M25,75 L40,50 L60,50 L75,75" stroke="#FFF" stroke-width="7" fill="none" stroke-linecap="round"/><circle cx="50" cy="52" r="6" fill="#FFD54F"/></svg>',
    "psy_empathie": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00897B"/><path d="M36,55 C26,45 20,38 20,30 C20,22 26,18 32,18 C37,18 40,22 40,22 C40,22 43,18 48,18 C54,18 60,22 60,30 C60,38 54,45 44,55 Z" fill="#E91E63"/><path d="M64,75 C54,65 48,58 48,50 C48,42 54,38 60,38 C65,38 68,42 68,42 C68,42 71,38 76,38 C82,38 88,42 88,50 C88,58 82,65 72,75 Z" fill="#FF4081"/></svg>',
    "psy_geduld": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#4E342E"/><polygon points="32,25 68,25 50,50" fill="#FFE082"/><polygon points="50,50 68,75 32,75" fill="#FFB300"/><line x1="28" y1="25" x2="72" y2="25" stroke="#D7CCC8" stroke-width="4"/><line x1="28" y1="75" x2="72" y2="75" stroke="#D7CCC8" stroke-width="4"/></svg>',
    "psy_neugier": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#F57C00"/><circle cx="50" cy="50" r="16" fill="#FFF"/><circle cx="50" cy="50" r="8" fill="#212121"/><path d="M22,50 Q50,22 78,50 Q50,78 22,50 Z" stroke="#FFF" stroke-width="5" fill="none"/></svg>',
    "psy_disziplin": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1A237E"/><rect x="30" y="24" width="40" height="52" rx="4" fill="#FFF"/><line x1="38" y1="36" x2="62" y2="36" stroke="#1A237E" stroke-width="4" stroke-linecap="round"/><line x1="38" y1="48" x2="62" y2="48" stroke="#1A237E" stroke-width="4" stroke-linecap="round"/><line x1="38" y1="60" x2="54" y2="60" stroke="#1A237E" stroke-width="4" stroke-linecap="round"/><circle cx="70" cy="65" r="8" fill="#00C853"/></svg>',
    "psy_intuition": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00ACC1"/><circle cx="50" cy="40" r="16" fill="#FFEB3B"/><line x1="50" y1="18" x2="50" y2="10" stroke="#FFA000" stroke-width="4" stroke-linecap="round"/><line x1="28" y1="28" x2="22" y2="22" stroke="#FFA000" stroke-width="4" stroke-linecap="round"/><line x1="72" y1="28" x2="78" y2="22" stroke="#FFA000" stroke-width="4" stroke-linecap="round"/><circle cx="50" cy="66" r="6" fill="#FFF"/></svg>',
    "psy_gedaechtnis": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#7B1FA2"/><path d="M35,62 C30,48 40,32 50,32 C60,32 70,48 65,62 Z" fill="#E1BEE7"/><circle cx="45" cy="45" r="4" fill="#6A1B9A"/><circle cx="55" cy="45" r="4" fill="#6A1B9A"/><circle cx="50" cy="55" r="4" fill="#6A1B9A"/><line x1="45" y1="45" x2="55" y2="45" stroke="#6A1B9A" stroke-width="2"/><line x1="45" y1="45" x2="50" y2="55" stroke="#6A1B9A" stroke-width="2"/><line x1="55" y1="45" x2="50" y2="55" stroke="#6A1B9A" stroke-width="2"/></svg>',
    "psy_wahrnehmung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#2E7D32"/><circle cx="50" cy="50" r="28" fill="#A5D6A7"/><circle cx="50" cy="50" r="16" fill="#1B5E20"/><circle cx="50" cy="50" r="7" fill="#FFF"/></svg>',
    "psy_unterbewusstsein": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0D47A1"/><path d="M15,48 L85,48" stroke="#00E5FF" stroke-width="4"/><polygon points="40,25 60,25 50,48" fill="#90CAF9"/><polygon points="30,48 70,48 50,82" fill="#1E88E5"/></svg>',
    "psy_entscheidung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#455A64"/><line x1="50" y1="80" x2="50" y2="50" stroke="#FFF" stroke-width="6" stroke-linecap="round"/><line x1="50" y1="50" x2="28" y2="28" stroke="#4CAF50" stroke-width="6" stroke-linecap="round"/><line x1="50" y1="50" x2="72" y2="28" stroke="#FF5722" stroke-width="6" stroke-linecap="round"/><polygon points="28,28 28,40 40,28" fill="#4CAF50"/><polygon points="72,28 72,40 60,28" fill="#FF5722"/></svg>',
    "psy_reaktion": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#E65100"/><polygon points="50,18 62,38 48,38 56,62 38,44 48,44" fill="#FFEB3B"/><circle cx="50" cy="50" r="32" fill="none" stroke="#FFF" stroke-width="3" stroke-dasharray="6,4"/></svg>',
    "psy_frustration": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#D32F2F"/><line x1="32" y1="40" x2="44" y2="40" stroke="#FFF" stroke-width="4" stroke-linecap="round"/><line x1="56" y1="40" x2="68" y2="40" stroke="#FFF" stroke-width="4" stroke-linecap="round"/><path d="M35,66 Q50,54 65,66" stroke="#FFF" stroke-width="5" fill="none" stroke-linecap="round"/></svg>',
    "psy_resilienz": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00897B"/><path d="M28,68 C28,45 42,32 50,32 C58,32 72,45 72,68" stroke="#FFF" stroke-width="6" fill="none" stroke-linecap="round"/><polygon points="50,18 55,28 66,28 58,35 61,45 50,39 39,45 42,35 34,28 45,28" fill="#FFD54F"/></svg>',
    "psy_hoffnung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#2E7D32"/><circle cx="50" cy="35" r="14" fill="#FFD54F"/><line x1="18" y1="75" x2="82" y2="75" stroke="#81C784" stroke-width="5" stroke-linecap="round"/><path d="M50,75 L50,49" stroke="#81C784" stroke-width="5" stroke-linecap="round"/><path d="M50,60 Q65,50 62,65" stroke="#81C784" stroke-width="4" fill="none"/></svg>',
    "psy_dankbarkeit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FF8F00"/><path d="M35,65 L48,45 L52,45 L65,65" stroke="#FFF" stroke-width="6" fill="none" stroke-linecap="round"/><circle cx="50" cy="30" r="8" fill="#FFF"/><circle cx="50" cy="50" r="5" fill="#D84315"/></svg>',
    "psy_selbstbeherrschung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#303F9F"/><circle cx="50" cy="50" r="24" fill="#5C6BC0"/><rect x="44" y="32" width="12" height="36" rx="4" fill="#FFF"/><circle cx="50" cy="50" r="3" fill="#E91E63"/></svg>',
    "psy_identitaet": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#512DA8"/><rect x="25" y="24" width="50" height="52" rx="6" fill="#FFF"/><circle cx="50" cy="42" r="10" fill="#FFA000"/><path d="M35,66 C35,56 65,56 65,66 Z" fill="#3949AB"/></svg>'
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
            "description": f"Vector illustration for psychology concept: {c['english']['word']}"
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
    
    if "psychology_behavior_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/literature_idioms_a2.json',",
            "'assets/content/vocabulary/literature_idioms_a2.json',\n    'assets/content/vocabulary/psychology_behavior_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط psychology_behavior_a2.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "psychology_behavior" not in cat_code:
        entry = """    CategoryMeta(
      id: 'psychology_behavior',
      titleAr: 'علم النفس والسلوك الإنساني',
      titleDe: 'Psychologie & Verhalten',
      titleEn: 'Psychology & Behavior',
      icon: Icons.psychology_rounded,
      primaryColor: Color(0xFF673AB7),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم علم النفس والسلوك في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 31", "TOTAL_VOCAB_CATEGORIES = 32")
    val_code = val_code.replace("TOTAL_CONCEPTS = 780", "TOTAL_CONCEPTS = 805")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 950", "TOTAL_SVG_ASSETS = 975")
    
    if "psychology_behavior_a2.json" not in val_code:
        val_code = val_code.replace(
            "'literature_idioms_a2.json',",
            "'literature_idioms_a2.json',\n    'psychology_behavior_a2.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (32 فئة، 805 مفاهيم، 975 أصلًا متجهيًا)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 056 Status (Completed - Level A2 Psychology & Behavior Category)
- **Feature:** Category 32: Psychology, Human Behavior & Daily Habits (`psychology_behavior_a2.json`).
- **New Concepts:** 25 trilingual vocabulary items for personality, emotional intelligence, courage, empathy, memory, resilience, and habits.
- **New Visuals:** 25 unique lightweight SVG vectors (`psy_*.svg`).
- **MAJOR MILESTONE REACHED:**
  - 32 Vocabulary Categories.
  - 805 Core Vocabulary Concepts (Crossed 800+ words landmark).
  - 35 Base Verbs | 15 Perfekt Forms.
  - 85 Syntax Exercises (Sentence Builder).
  - 24 Prepositions | 5 Dialogues.
  - 11 Comprehensive Grammar Engines.
  - 975 Total SVG Vector Icons (Just 25 away from 1,000 SVGs!).
- **Integration:** Active in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 056 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 056 بنجاح تام!")
