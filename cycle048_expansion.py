import json
import os

print("🚀 [CYCLE 048] بدء بناء قسم العمارة والتخطيط الحضري والسكن المعاصر (Architecture & Housing - A2)...")

# 1. قائمة الـ 25 مفهومًا لقسم العمارة والسكن
concepts = [
    {
        "id": "arc_architektur",
        "category": "architecture_housing",
        "arabic": {"word": "العِمَارَةُ / الفَنُّ المِعْمَارِيُّ", "transliteration": "Al-'Imarah", "notes": "علم وفن تصميم وتشييد المباني"},
        "german": {"article": "die", "word": "Architektur", "plural": "die Architekturen", "gender": "feminine", "example": "Die historische Architektur dieser Altstadt zieht viele Touristen an."},
        "english": {"word": "architecture", "phonetic": "/ˈɑː.kɪ.tek.tʃər/", "example": "Modern architecture balances aesthetic beauty with environmental sustainability."},
        "image_id": "img_arc_architektur"
    },
    {
        "id": "arc_architekt",
        "category": "architecture_housing",
        "arabic": {"word": "المُهَنْدِسُ المِعْمَارِيُّ", "transliteration": "Al-Muhandis Al-Mi'mari", "notes": "المصمم المخطط للمنشآت (يتبع N-Deklination)"},
        "german": {"article": "der", "word": "Architekt", "plural": "die Architekten", "gender": "masculine (n-Deklination)", "example": "Der renommierte Architekt entwarf ein energieeffizientes Wohngebäude."},
        "english": {"word": "architect", "phonetic": "/ˈɑː.kɪ.tekt/", "example": "The award-winning architect designed an innovative civic complex."},
        "image_id": "img_arc_architekt"
    },
    {
        "id": "arc_wolkenkratzer",
        "category": "architecture_housing",
        "arabic": {"word": "نَاطِحَةُ السَّحَابِ", "transliteration": "Natihat As-Sahab", "notes": "المبنى الشاهق الارتفاع متعدد الطوابق"},
        "german": {"article": "der", "word": "Wolkenkratzer", "plural": "die Wolkenkratzer", "gender": "masculine", "example": "In der Frankfurter Skyline stehen beeindruckende Wolkenkratzer."},
        "english": {"word": "skyscraper", "phonetic": "/ˈskaɪˌskreɪ.pər/", "example": "The iconic glass skyscraper towers over the bustling metropolis."},
        "image_id": "img_arc_wolkenkratzer"
    },
    {
        "id": "arc_balkon",
        "category": "architecture_housing",
        "arabic": {"word": "الشُّرْفَةُ", "transliteration": "Ash-Shurfah", "notes": "المساحة المفتوحة البارزة من واجهة المبنى"},
        "german": {"article": "der", "word": "Balkon", "plural": "die Balkone", "gender": "masculine", "example": "Im Sommer frühstücken wir gerne sonntags auf dem Balkon."},
        "english": {"word": "balcony", "phonetic": "/ˈbæl.kə.ni/", "example": "They planted colorful geraniums along their sunny balcony railing."},
        "image_id": "img_arc_balkon"
    },
    {
        "id": "arc_terrasse",
        "category": "architecture_housing",
        "arabic": {"word": "الشُّرْفَةُ الوَاسِعَةُ / التِّرَاس", "transliteration": "At-Teras", "notes": "المساحة الخارجية المبلطة للاستجمام"},
        "german": {"article": "die", "word": "Terrasse", "plural": "die Terrassen", "gender": "feminine", "example": "Die Wohnung im Erdgeschoss hat eine wunderschöne grüne Terrasse."},
        "english": {"word": "terrace / patio", "phonetic": "/ˈter.əs/", "example": "We enjoyed our afternoon tea outdoors on the rooftop terrace."},
        "image_id": "img_arc_terrasse"
    },
    {
        "id": "arc_aufzug",
        "category": "architecture_housing",
        "arabic": {"word": "المِصْعَدُ", "transliteration": "Al-Mis'ad", "notes": "كابينة النقل الرأسي بين الأدوار"},
        "german": {"article": "der", "word": "Aufzug", "plural": "die Aufzüge", "gender": "masculine", "example": "Nehmen Sie den Aufzug in den vierten Stock."},
        "english": {"word": "elevator / lift", "phonetic": "/ˈel.ɪ.veɪ.tər/", "example": "Take the modern elevator directly to the penthouse suite."},
        "image_id": "img_arc_aufzug"
    },
    {
        "id": "arc_treppe",
        "category": "architecture_housing",
        "arabic": {"word": "السُّلَّمُ / الدَّرَجُ", "transliteration": "As-Sullam / Ad-Daraj", "notes": "درجات الصعود والهبوط في المباني"},
        "german": {"article": "die", "word": "Treppe", "plural": "die Treppen", "gender": "feminine", "example": "Aus Fitnessgründen nehme ich lieber die Treppe statt des Aufzugs."},
        "english": {"word": "stairs / staircase", "phonetic": "/steəz/", "example": "Taking the stairs instead of the elevator provides healthy exercise."},
        "image_id": "img_arc_treppe"
    },
    {
        "id": "arc_keller",
        "category": "architecture_housing",
        "arabic": {"word": "القَبْوُ / الطَّابَقُ السُّفْلِيُّ", "transliteration": "Al-Qabw", "notes": "المساحة التخزينية تحت مستوى الأرض"},
        "german": {"article": "der", "word": "Keller", "plural": "die Keller", "gender": "masculine", "example": "Wir lagern unsere Fahrräder und Werkzeuge sicher im Keller."},
        "english": {"word": "basement / cellar", "phonetic": "/ˈbeɪs.mənt/", "example": "We store vintage preserves and winter gear in the dry basement."},
        "image_id": "img_arc_keller"
    },
    {
        "id": "arc_dachgeschoss",
        "category": "architecture_housing",
        "arabic": {"word": "العِلِّيَّةُ / طَابَقُ السَّقْفِ", "transliteration": "Al-'Illiyyah", "notes": "الشقة السكنية الواقعة مباشرة تحت سقف المبنى"},
        "german": {"article": "das", "word": "Dachgeschoss", "plural": "die Dachgeschosse", "gender": "neuter", "example": "Die helle Dachgeschosswohnung bietet einen fantastischen Blick über die Stadt."},
        "english": {"word": "attic / top-floor apartment", "phonetic": "/ˈæt.ɪk/", "example": "The cozy attic flat has exposed wooden ceiling beams."},
        "image_id": "img_arc_dachgeschoss"
    },
    {
        "id": "arc_heizung",
        "category": "architecture_housing",
        "arabic": {"word": "التَّدْفِئَةُ المَرْكَزِيَّةُ", "transliteration": "At-Tadfi'ah", "notes": "نظام تدفئة الغرف والمباني شتاءً"},
        "german": {"article": "die", "word": "Heizung", "plural": "die Heizungen", "gender": "feminine", "example": "Im kalten Winter drehen wir die Heizung auf die mittlere Stufe."},
        "english": {"word": "central heating", "phonetic": "/ˈhiː.tɪŋ/", "example": "The smart central heating system regulates room temperature automatically."},
        "image_id": "img_arc_heizung"
    },
    {
        "id": "arc_klimaanlage",
        "category": "architecture_housing",
        "arabic": {"word": "مُكَيِّفُ الهَوَاءِ", "transliteration": "Mukayyif Al-Hawa'", "notes": "نظام تبريد وتلطيف الهواء صيفًا"},
        "german": {"article": "die", "word": "Klimaanlage", "plural": "die Klimaanlagen", "gender": "feminine", "example": "An heißen Sommertagen sorgt die Klimaanlage für angenehme Kühle."},
        "english": {"word": "air conditioning", "phonetic": "/ˈeə kənˌdɪʃ.ən.ɪŋ/", "example": "The office air conditioning maintains a comfortable environment in July."},
        "image_id": "img_arc_klimaanlage"
    },
    {
        "id": "arc_miete",
        "category": "architecture_housing",
        "arabic": {"word": "الإِيجَارُ الشَّهْرِيُّ", "transliteration": "Al-Iejar", "notes": "المبلغ المالي الدوري المدفوع مقابل السكن"},
        "german": {"article": "die", "word": "Miete", "plural": "die Mieten", "gender": "feminine", "example": "Die monatliche Warmmiete überweisen wir immer zum Monatsersten."},
        "english": {"word": "rent", "phonetic": "/rent/", "example": "Monthly apartment rent is payable on the first day of each month."},
        "image_id": "img_arc_miete"
    },
    {
        "id": "arc_vermieter",
        "category": "architecture_housing",
        "arabic": {"word": "صَاحِبُ العَقَارِ / المُؤَجِّرُ", "transliteration": "Al-Mu'ajjir", "notes": "مالك العقار الذي يؤجره للغير"},
        "german": {"article": "der", "word": "Vermieter", "plural": "die Vermieter", "gender": "masculine", "example": "Der Vermieter kümmert sich zügig um Reparaturen im Haus."},
        "english": {"word": "landlord", "phonetic": "/ˈlænd.lɔːd/", "example": "The responsive landlord arranged for immediate plumbing repairs."},
        "image_id": "img_arc_vermieter"
    },
    {
        "id": "arc_mieter",
        "category": "architecture_housing",
        "arabic": {"word": "المُسْتَأْجِرُ", "transliteration": "Al-Musta'jir", "notes": "الشخص المنتفع بالعين المؤجرة"},
        "german": {"article": "der", "word": "Mieter", "plural": "die Mieter", "gender": "masculine", "example": "Die neuen Mieter sind sehr freundlich und rücksichtsvoll."},
        "english": {"word": "tenant", "phonetic": "/ˈten.ənt/", "example": "The prospective tenant submitted all necessary income verifications."},
        "image_id": "img_arc_mieter"
    },
    {
        "id": "arc_kaution",
        "category": "architecture_housing",
        "arabic": {"word": "مَبْلَغُ التَّأْمِينِ (الكَفَالَةُ)", "transliteration": "Al-Kaution", "notes": "المبلغ الضامن لسلامة العقار المودع عند التأجير"},
        "german": {"article": "die", "word": "Kaution", "plural": "die Kautionen", "gender": "feminine", "example": "Beim Einzug hinterlegt man meist drei Monatskaltmieten als Kaution."},
        "english": {"word": "security deposit", "phonetic": "/sɪˈkjʊə.rə.ti dɪˌpɒz.ɪt/", "example": "Tenants typically pay a refundable security deposit before move-in."},
        "image_id": "img_arc_kaution"
    },
    {
        "id": "arc_nachbarschaft",
        "category": "architecture_housing",
        "arabic": {"word": "الحَيُّ السَّكَنِيُّ / الجِوَارُ", "transliteration": "Al-Hayy As-Sakani", "notes": "المحيط السكني ومجتمع الجيران"},
        "german": {"article": "die", "word": "Nachbarschaft", "plural": "die Nachbarschaften", "gender": "feminine", "example": "In unserer ruhigen Nachbarschaft hilft man sich gerne gegenseitig."},
        "english": {"word": "neighborhood", "phonetic": "/ˈneɪ.bə.hʊd/", "example": "Our family friendly neighborhood features parks and quiet streets."},
        "image_id": "img_arc_nachbarschaft"
    },
    {
        "id": "arc_oeffentliche_verkehrsmittel",
        "category": "architecture_housing",
        "arabic": {"word": "وَسَائِلُ النَّقْلِ العَامِّ", "transliteration": "Wasa'il An-Naql Al-'Aamm", "notes": "المواصلات الحضرية كالمترو والترام والحافلات"},
        "german": {"article": "die", "word": "öffentlichen Verkehrsmittel", "plural": "die öffentlichen Verkehrsmittel", "gender": "plural", "example": "Die Wohnung ist optimal an die öffentlichen Verkehrsmittel angebunden."},
        "english": {"word": "public transit / transport", "phonetic": "/ˈpʌb.lɪk ˈtræn.zɪt/", "example": "The urban flat is well connected to rapid public transit networks."},
        "image_id": "img_arc_oeffentliche_verkehrsmittel"
    },
    {
        "id": "arc_vorort",
        "category": "architecture_housing",
        "arabic": {"word": "الضَّاحِيَةُ السَّكَنِيَّةُ", "transliteration": "Ad-Dahiyah", "notes": "المنطقة السكنية الهادئة خارج مركز المدينة"},
        "german": {"article": "der", "word": "Vorort", "plural": "die Vororte", "gender": "masculine", "example": "Viele Familien mit Kindern ziehen in einen ruhigen Vorort."},
        "english": {"word": "suburb", "phonetic": "/ˈsʌb.ɜːb/", "example": "Living in a peaceful suburb offers a calm escape from city crowds."},
        "image_id": "img_arc_vorort"
    },
    {
        "id": "arc_stadtplatz",
        "category": "architecture_housing",
        "arabic": {"word": "المَيْدَانُ / السَّاحَةُ العَامَّةُ", "transliteration": "Al-Maydan", "notes": "الساحة المركزية المفتوحة للقاء والتنزه"},
        "german": {"article": "der", "word": "Stadtplatz", "plural": "die Stadtplätze", "gender": "masculine", "example": "Auf dem historischen Stadtplatz findet samstags der Wochenmarkt statt."},
        "english": {"word": "city square / plaza", "phonetic": "/ˈsɪt.i skweər/", "example": "Local farmers gather on the pedestrian city square every weekend."},
        "image_id": "img_arc_stadtplatz"
    },
    {
        "id": "arc_smart_home",
        "category": "architecture_housing",
        "arabic": {"word": "المَنْزِلُ الذَّكِيُّ", "transliteration": "Al-Manzil Ath-Thaki", "notes": "المنزل المتصل بتقنيات التحكم الآلي بالطاقة والأمان"},
        "german": {"article": "das", "word": "Smart Home", "plural": "die Smart Homes", "gender": "neuter", "example": "Im Smart Home lassen sich Beleuchtung und Heizung per App steuern."},
        "english": {"word": "smart home", "phonetic": "/ˈsmɑːt həʊm/", "example": "A connected smart home optimizes electricity and automated security."},
        "image_id": "img_arc_smart_home"
    },
    {
        "id": "arc_renovierung",
        "category": "architecture_housing",
        "arabic": {"word": "التَّرْمِيمُ / التَّجْدِيدُ", "transliteration": "At-Tarmeem", "notes": "إصلاح وتحديث المباني القديمة وتحسين كفاءتها"},
        "german": {"article": "die", "word": "Renovierung", "plural": "die Renovierungen", "gender": "feminine", "example": "Nach der Renovierung erstrahlt das alte Stadthaus in neuem Glanz."},
        "english": {"word": "renovation / refurbishment", "phonetic": "/ˌren.əˈveɪ.ʃən/", "example": "Comprehensive eco-renovation significantly upgraded the insulation."},
        "image_id": "img_arc_renovierung"
    },
    {
        "id": "arc_gebaeude",
        "category": "architecture_housing",
        "arabic": {"word": "المَبْنَى / العِمَارَةُ", "transliteration": "Al-Mabna", "notes": "الهيكل الإنشائي المخصص للسكن أو العمل"},
        "german": {"article": "das", "word": "Gebäude", "plural": "die Gebäude", "gender": "neuter", "example": "Das historische Gebäude steht unter Denkmalschutz."},
        "english": {"word": "building / structure", "phonetic": "/ˈbɪl.dɪŋ/", "example": "The municipal civic building received heritage conservation status."},
        "image_id": "img_arc_gebaeude"
    },
    {
        "id": "arc_fassade",
        "category": "architecture_housing",
        "arabic": {"word": "وَاجِهَةُ المَبْنَى", "transliteration": "Wajahat Al-Mabna", "notes": "المظهر الخارجي الأمامي للمبنى"},
        "german": {"article": "die", "word": "Fassade", "plural": "die Fassaden", "gender": "feminine", "example": "Die Fassade wurde mit moderner Wärmedämmung neu verkleidet."},
        "english": {"word": "facade / exterior", "phonetic": "/fəˈsɑːd/", "example": "The building facade incorporates solar panels and vertical gardens."},
        "image_id": "img_arc_fassade"
    },
    {
        "id": "arc_beton",
        "category": "architecture_housing",
        "arabic": {"word": "الخَرَسَانَةُ / الإِسْمَنْتُ المُسَلَّحُ", "transliteration": "Al-Kharasanah", "notes": "مادة البناء المكونة من الإسمنت والركام والماء"},
        "german": {"article": "der", "word": "Beton", "plural": "die Betone", "gender": "masculine", "example": "Moderner Recycling-Beton reduziert den ökologischen Fußabdruck beim Bau."},
        "english": {"word": "concrete", "phonetic": "/ˈkɒŋ.kriːt/", "example": "Reinforced concrete provides structural resilience to high-rises."},
        "image_id": "img_arc_beton"
    },
    {
        "id": "arc_stadtplanung",
        "category": "architecture_housing",
        "arabic": {"word": "التَّخْطِيطُ الحَضَرِيُّ", "transliteration": "At-Takhteet Al-Hadari", "notes": "تنظيم المساحات والمباني وشبكات الطرق وتوزيع الخدمات"},
        "german": {"article": "die", "word": "Stadtplanung", "plural": "die Stadtplanungen", "gender": "feminine", "example": "Nachhaltige Stadtplanung schafft grüne Zonen und kurze Wege."},
        "english": {"word": "urban planning", "phonetic": "/ˌɜː.bən ˈplæn.ɪŋ/", "example": "Thoughtful urban planning promotes walkable and sustainable cities."},
        "image_id": "img_arc_stadtplanung"
    }
]

# حفظ ملف المفردات الجديد في content/vocabulary/architecture_housing_a2.json
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/architecture_housing_a2.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "architecture_housing",
        "category_name": {
            "ar": "العمارة والتخطيط الحضري والسكن المعاصر",
            "de": "Architektur, Stadt & Wohnen",
            "en": "Architecture, Urban Spaces & Modern Housing"
        },
        "level": "A2",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم معمارية وسكنية في {vocab_path}")

# 2. توليد 25 أيقونة SVG خفيفة ومتجهية (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "arc_architektur": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,15 20,40 80,40" fill="#455A64"/><rect x="25" y="40" width="8" height="38" fill="#78909C"/><rect x="40" y="40" width="8" height="38" fill="#78909C"/><rect x="52" y="40" width="8" height="38" fill="#78909C"/><rect x="67" y="40" width="8" height="38" fill="#78909C"/><rect x="18" y="78" width="64" height="8" fill="#37474F"/><circle cx="50" cy="30" r="4" fill="#FFD54F"/></svg>',
    "arc_architekt": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="28" r="14" fill="#FFA726"/><path d="M22,82 C22,58 68,58 68,82 Z" fill="#37474F"/><rect x="65" y="35" width="22" height="38" rx="2" fill="#FFE082"/><line x1="68" y1="42" x2="84" y2="42" stroke="#E65100" stroke-width="2"/><line x1="68" y1="52" x2="84" y2="52" stroke="#E65100" stroke-width="2"/></svg>',
    "arc_wolkenkratzer": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="30" y="15" width="40" height="75" fill="#1565C0"/><rect x="36" y="24" width="6" height="8" fill="#BBDEFB"/><rect x="47" y="24" width="6" height="8" fill="#BBDEFB"/><rect x="58" y="24" width="6" height="8" fill="#BBDEFB"/><rect x="36" y="38" width="6" height="8" fill="#BBDEFB"/><rect x="47" y="38" width="6" height="8" fill="#BBDEFB"/><rect x="58" y="38" width="6" height="8" fill="#BBDEFB"/><rect x="36" y="52" width="6" height="8" fill="#BBDEFB"/><rect x="47" y="52" width="6" height="8" fill="#BBDEFB"/><rect x="58" y="52" width="6" height="8" fill="#BBDEFB"/><line x1="50" y1="5" x2="50" y2="15" stroke="#FFD54F" stroke-width="3"/></svg>',
    "arc_balkon": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="15" width="64" height="70" fill="#ECEFF1" stroke="#455A64" stroke-width="3"/><rect x="35" y="25" width="30" height="35" fill="#90CAF9"/><rect x="25" y="58" width="50" height="22" fill="#546E7A"/><line x1="35" y1="58" x2="35" y2="80" stroke="#FFF" stroke-width="2.5"/><line x1="45" y1="58" x2="45" y2="80" stroke="#FFF" stroke-width="2.5"/><line x1="55" y1="58" x2="55" y2="80" stroke="#FFF" stroke-width="2.5"/><line x1="65" y1="58" x2="65" y2="80" stroke="#FFF" stroke-width="2.5"/></svg>',
    "arc_terrasse": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="55" width="70" height="32" rx="4" fill="#A1887F"/><line x1="15" y1="65" x2="85" y2="65" stroke="#6D4C41" stroke-width="2"/><line x1="15" y1="75" x2="85" y2="75" stroke="#6D4C41" stroke-width="2"/><circle cx="70" cy="30" r="12" fill="#FFCA28"/><path d="M25,55 C25,38 55,38 55,55" fill="#E53935"/></svg>',
    "arc_aufzug": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="15" width="56" height="70" rx="4" fill="#37474F"/><rect x="28" y="22" width="44" height="56" fill="#B0BEC5"/><line x1="50" y1="22" x2="50" y2="78" stroke="#37474F" stroke-width="3"/><polygon points="42,12 50,4 58,12" fill="#4CAF50"/><polygon points="42,88 50,96 58,88" fill="#F44336"/></svg>',
    "arc_treppe": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="15,80 15,65 30,65 30,50 45,50 45,35 60,35 60,20 85,20 85,80" fill="#78909C"/><line x1="15" y1="80" x2="85" y2="80" stroke="#37474F" stroke-width="4"/></svg>',
    "arc_keller": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="20" width="64" height="65" rx="4" fill="#424242"/><rect x="28" y="30" width="44" height="20" rx="2" fill="#757575"/><line x1="28" y1="40" x2="72" y2="40" stroke="#212121" stroke-width="2"/><circle cx="50" cy="70" r="8" fill="#FFA000"/><line x1="50" y1="50" x2="50" y2="62" stroke="#BDBDBD" stroke-width="3"/></svg>',
    "arc_dachgeschoss": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,15 15,55 85,55" fill="#D32F2F"/><rect x="25" y="55" width="50" height="30" fill="#ECEFF1"/><rect x="42" y="32" width="16" height="18" rx="2" fill="#81D4FA"/><line x1="50" y1="32" x2="50" y2="50" stroke="#455A64" stroke-width="2"/></svg>',
    "arc_heizung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="30" width="64" height="45" rx="4" fill="#ECEFF1" stroke="#546E7A" stroke-width="3"/><line x1="28" y1="35" x2="28" y2="70" stroke="#90A4AE" stroke-width="4" stroke-linecap="round"/><line x1="38" y1="35" x2="38" y2="70" stroke="#90A4AE" stroke-width="4" stroke-linecap="round"/><line x1="48" y1="35" x2="48" y2="70" stroke="#90A4AE" stroke-width="4" stroke-linecap="round"/><line x1="58" y1="35" x2="58" y2="70" stroke="#90A4AE" stroke-width="4" stroke-linecap="round"/><line x1="68" y1="35" x2="68" y2="70" stroke="#90A4AE" stroke-width="4" stroke-linecap="round"/><circle cx="78" cy="38" r="4" fill="#E53935"/></svg>',
    "arc_klimaanlage": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="28" width="70" height="30" rx="4" fill="#FFF" stroke="#455A64" stroke-width="3"/><line x1="22" y1="46" x2="78" y2="46" stroke="#B0BEC5" stroke-width="2"/><line x1="22" y1="52" x2="78" y2="52" stroke="#B0BEC5" stroke-width="2"/><path d="M30,62 Q35,74 40,62 Q45,74 50,62" stroke="#00BCD4" stroke-width="3" fill="none"/><path d="M50,62 Q55,74 60,62 Q65,74 70,62" stroke="#00BCD4" stroke-width="3" fill="none"/><circle cx="76" cy="36" r="2.5" fill="#4CAF50"/></svg>',
    "arc_miete": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#2E7D32"/><circle cx="50" cy="50" r="26" fill="#FFF"/><text x="50" y="58" font-family="sans-serif" font-weight="bold" font-size="24" fill="#2E7D32" text-anchor="middle">€</text><polygon points="70,18 78,26 84,20" fill="#FFD54F"/></svg>',
    "arc_vermieter": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="30" r="14" fill="#FFA726"/><path d="M22,82 C22,58 68,58 68,82 Z" fill="#1565C0"/><polygon points="72,42 80,48 88,42" fill="#FFA000"/><circle cx="80" cy="52" r="6" fill="#FFD54F"/><line x1="80" y1="58" x2="80" y2="74" stroke="#FFA000" stroke-width="4"/><line x1="80" y1="68" x2="86" y2="68" stroke="#FFA000" stroke-width="3"/></svg>',
    "arc_mieter": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="30" r="14" fill="#FFCC80"/><path d="M22,82 C22,58 68,58 68,82 Z" fill="#43A047"/><rect x="65" y="45" width="20" height="28" rx="2" fill="#FFE082"/><polygon points="65,45 75,35 85,45" fill="#C62828"/></svg>',
    "arc_kaution": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="32" width="56" height="42" rx="4" fill="#37474F"/><circle cx="50" cy="53" r="10" fill="#FFCA28"/><path d="M35,32 L35,22 C35,14 65,14 65,22 L65,32" stroke="#37474F" stroke-width="6" fill="none"/></svg>',
    "arc_nachbarschaft": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="32,25 15,45 49,45" fill="#E53935"/><rect x="20" y="45" width="24" height="35" fill="#ECEFF1"/><polygon points="68,25 51,45 85,45" fill="#1E88E5"/><rect x="56" y="45" width="24" height="35" fill="#ECEFF1"/><line x1="10" y1="80" x2="90" y2="80" stroke="#795548" stroke-width="4"/></svg>',
    "arc_oeffentliche_verkehrsmittel": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="24" width="60" height="48" rx="8" fill="#FDD835"/><rect x="26" y="32" width="48" height="18" rx="2" fill="#37474F"/><circle cx="34" cy="62" r="5" fill="#212121"/><circle cx="66" cy="62" r="5" fill="#212121"/><line x1="15" y1="80" x2="85" y2="80" stroke="#757575" stroke-width="4"/></svg>',
    "arc_vorort": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#C8E6C9"/><polygon points="40,35 25,50 55,50" fill="#388E3C"/><rect x="30" y="50" width="20" height="22" fill="#FFF"/><circle cx="68" cy="50" r="10" fill="#4CAF50"/><rect x="66" y="60" width="4" height="12" fill="#5D4037"/></svg>',
    "arc_stadtplatz": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,15 85,85 15,85" fill="#B0BEC5"/><circle cx="50" cy="55" r="14" fill="#0288D1"/><circle cx="50" cy="55" r="6" fill="#FFF"/><line x1="15" y1="85" x2="85" y2="85" stroke="#455A64" stroke-width="4"/></svg>',
    "arc_smart_home": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,16 18,44 82,44" fill="#00BCD4"/><rect x="26" y="44" width="48" height="38" fill="#ECEFF1"/><path d="M42,65 A12,12 0 0,1 58,65" stroke="#0097A7" stroke-width="3" fill="none"/><circle cx="50" cy="68" r="2.5" fill="#0097A7"/><circle cx="50" cy="52" r="5" fill="#FFC107"/></svg>',
    "arc_renovierung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="32" width="50" height="48" rx="4" fill="#78909C"/><polygon points="25,32 50,15 75,32" fill="#455A64"/><rect x="42" y="52" width="16" height="28" fill="#FFF"/><polygon points="68,22 82,34 72,40" fill="#FFA000"/><line x1="72" y1="40" x2="58" y2="52" stroke="#5D4037" stroke-width="5" stroke-linecap="round"/></svg>',
    "arc_gebaeude": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="22" width="56" height="65" rx="3" fill="#607D8B"/><rect x="30" y="32" width="10" height="12" fill="#CFD8DC"/><rect x="45" y="32" width="10" height="12" fill="#CFD8DC"/><rect x="60" y="32" width="10" height="12" fill="#CFD8DC"/><rect x="30" y="52" width="10" height="12" fill="#CFD8DC"/><rect x="45" y="52" width="10" height="12" fill="#CFD8DC"/><rect x="60" y="52" width="10" height="12" fill="#CFD8DC"/><rect x="43" y="70" width="14" height="17" fill="#37474F"/></svg>',
    "arc_fassade": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="18" width="64" height="68" fill="#FFF8E1" stroke="#8D6E63" stroke-width="3"/><rect x="28" y="28" width="16" height="22" rx="2" fill="#81D4FA"/><rect x="56" y="28" width="16" height="22" rx="2" fill="#81D4FA"/><rect x="40" y="60" width="20" height="26" fill="#6D4C41"/><circle cx="56" cy="74" r="2" fill="#FFD54F"/></svg>',
    "arc_beton": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="30" width="60" height="45" rx="4" fill="#9E9E9E" stroke="#616161" stroke-width="4"/><circle cx="35" cy="45" r="4" fill="#757575"/><circle cx="55" cy="42" r="5" fill="#757575"/><circle cx="65" cy="58" r="4" fill="#757575"/><circle cx="42" cy="60" r="3.5" fill="#757575"/></svg>',
    "arc_stadtplanung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00897B"/><rect x="28" y="28" width="18" height="18" rx="2" fill="#FFF"/><rect x="54" y="28" width="18" height="18" rx="2" fill="#FFF"/><rect x="28" y="54" width="18" height="18" rx="2" fill="#FFF"/><rect x="54" y="54" width="18" height="18" rx="2" fill="#FFD54F"/><line x1="12" y1="50" x2="88" y2="50" stroke="#80CBC4" stroke-width="3"/><line x1="50" y1="12" x2="50" y2="88" stroke="#80CBC4" stroke-width="3"/></svg>'
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
            "description": f"Vector illustration for architecture concept: {c['english']['word']}"
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
    
    if "architecture_housing_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/media_journalism_a2.json',",
            "'assets/content/vocabulary/media_journalism_a2.json',\n    'assets/content/vocabulary/architecture_housing_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط architecture_housing_a2.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "architecture_housing" not in cat_code:
        entry = """    CategoryMeta(
      id: 'architecture_housing',
      titleAr: 'العمارة والسكن المعاصر',
      titleDe: 'Architektur & Wohnen',
      titleEn: 'Architecture & Housing',
      icon: Icons.apartment_rounded,
      primaryColor: Color(0xFF455A64),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم العمارة والسكن في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 27", "TOTAL_VOCAB_CATEGORIES = 28")
    val_code = val_code.replace("TOTAL_CONCEPTS = 680", "TOTAL_CONCEPTS = 705")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 810", "TOTAL_SVG_ASSETS = 835")
    
    if "architecture_housing_a2.json" not in val_code:
        val_code = val_code.replace(
            "'media_journalism_a2.json',",
            "'media_journalism_a2.json',\n    'architecture_housing_a2.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (28 فئة، 705 مفاهيم، 835 أصلًا متجهيًا)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 048 Status (Completed - Level A2 Architecture & Housing Category)
- **Feature:** Category 28: Architecture, Urban Spaces & Modern Housing (`architecture_housing_a2.json`).
- **New Concepts:** 25 trilingual vocabulary items for skyscrapers, residential buildings, rent, landlord, tenant, smart home, and urban planning.
- **New Visuals:** 25 unique lightweight SVG vectors (`arc_*.svg`).
- **LANDMARK BARRIER BROKEN (700+ Words Milestone):**
  - 28 Vocabulary Categories.
  - 705 Core Vocabulary Concepts.
  - 35 Base Verbs | 15 Perfekt Forms.
  - 65 Syntax Exercises (Sentence Builder).
  - 24 Prepositions | 5 Dialogues.
  - Articles, Genitiv, Relativsätze, Konjunktiv II, Passiv, Conjunctions & Infinitiv mit zu Engines.
  - 835 Total SVG Vector Icons.
- **Integration:** Active in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 048 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 048 بنجاح تام!")
