import json
import os

print("🚀 [CYCLE 059] بدء بناء قسم الدبلوماسية والسلام الإنساني (Diplomacy & Peace - A2)...")

# 1. قائمة الـ 25 مفهومًا لقسم الدبلوماسية والسلام الدولي
concepts = [
    {
        "id": "dip_diplomatie",
        "category": "diplomacy_peace",
        "arabic": {"word": "الدِّبْلُومَاسِيَّةُ / العَلَاقَاتُ الدَّوْلِيَّةُ", "transliteration": "Ad-Diblomasiyyah", "notes": "فن إدارة المفاوضات والعلاقات السياسية بين الدول سلميًا"},
        "german": {"article": "die", "word": "Diplomatie", "plural": "die Diplomatien", "gender": "feminine", "example": "Kluge Diplomatie verhindert kriegerische Auseinandersetzungen."},
        "english": {"word": "diplomacy", "phonetic": "/dɪˈpləʊ.mə.si/", "example": "Skilled diplomacy resolves international disputes peacefully."},
        "image_id": "img_dip_diplomatie"
    },
    {
        "id": "dip_diplomat",
        "category": "diplomacy_peace",
        "arabic": {"word": "الدِّبْلُومَاسِيُّ", "transliteration": "Ad-Diblomasi", "notes": "الممثل الرسمي المعتمد لدولته في الخارج (يتبع N-Deklination)"},
        "german": {"article": "der", "word": "Diplomat", "plural": "die Diplomaten", "gender": "masculine (n-Deklination)", "example": "Der erfahrene Diplomat handelte den humanitären Waffenstillstand aus."},
        "english": {"word": "diplomat", "phonetic": "/ˈdɪp.lə.mæt/", "example": "The seasoned diplomat negotiated the bilateral ceasefire accord."},
        "image_id": "img_dip_diplomat"
    },
    {
        "id": "dip_botschaft",
        "category": "diplomacy_peace",
        "arabic": {"word": "السَّفَارَةُ", "transliteration": "As-Safarah", "notes": "المقر الدبلوماسي الرسمي لتمثيل الدولة في بلد أجنبي"},
        "german": {"article": "die", "word": "Botschaft", "plural": "die Botschaften", "gender": "feminine", "example": "Die deutsche Botschaft hilft Bürgern in konsularischen Angelegenheiten."},
        "english": {"word": "embassy", "phonetic": "/ˈem.bə.si/", "example": "Citizens can request consular assistance at the embassy."},
        "image_id": "img_dip_botschaft"
    },
    {
        "id": "dip_botschafter",
        "category": "diplomacy_peace",
        "arabic": {"word": "السَّفِيرُ", "transliteration": "As-Safeer", "notes": "الممثل الدبلوماسي الأرفع رتبة لدولته لدى دولة أخرى"},
        "german": {"article": "der", "word": "Botschafter", "plural": "die Botschafter", "gender": "masculine", "example": "Der Botschafter überreichte dem Staatsoberhaupt sein Beglaubigungsschreiben."},
        "english": {"word": "ambassador", "phonetic": "/æmˈbæs.ə.dər/", "example": "The new ambassador presented his formal diplomatic credentials."},
        "image_id": "img_dip_botschafter"
    },
    {
        "id": "dip_gipfel",
        "category": "diplomacy_peace",
        "arabic": {"word": "القِمَّةُ الدَّوْلِيَّةُ / مُؤْتَمَرُ القِمَّةِ", "transliteration": "Al-Qimmah", "notes": "اجتماع رفيع المستوى يضم قادة ورؤساء الدول"},
        "german": {"article": "der", "word": "Gipfel", "plural": "die Gipfel", "gender": "masculine", "example": "Auf dem internationalen Klimagipfel verhandelten die Regierungschefs neue Ziele."},
        "english": {"word": "summit / international summit", "phonetic": "/ˈsʌm.ɪt/", "example": "World leaders gathered for the annual international peace summit."},
        "image_id": "img_dip_gipfel"
    },
    {
        "id": "dip_konflikt",
        "category": "diplomacy_peace",
        "arabic": {"word": "النِّزَاعُ / الصِّرَاعُ", "transliteration": "An-Niza'", "notes": "الخلاف السياسي أو العسكري القائم بين الأطراف"},
        "german": {"article": "der", "word": "Konflikt", "plural": "die Konflikte", "gender": "masculine", "example": "Ein friedlicher Dialog ist der nachhaltigste Weg zur Beilegung des Konflikts."},
        "english": {"word": "conflict", "phonetic": "/ˈkɒn.flɪkt/", "example": "Peaceful dialogue remains vital to settling regional conflicts."},
        "image_id": "img_dip_konflikt"
    },
    {
        "id": "dip_verhandlung",
        "category": "diplomacy_peace",
        "arabic": {"word": "المُفَاوَضَاتُ السِّلْمِيَّةُ", "transliteration": "Al-Mufawadat As-Silmiyyah", "notes": "جلسات الحوار للتوصل إلى تسوية للنزاع"},
        "german": {"article": "die", "word": "Friedensverhandlungen", "plural": "die Friedensverhandlungen", "gender": "plural", "example": "Die diplomatischen Friedensverhandlungen machten deutliche Fortschritte."},
        "english": {"word": "peace negotiations", "phonetic": "/piːs nɪˌɡəʊ.ʃiˈeɪ.ʃənz/", "example": "Both delegations resumed constructive peace negotiations."},
        "image_id": "img_dip_verhandlung"
    },
    {
        "id": "dip_friedensvertrag",
        "category": "diplomacy_peace",
        "arabic": {"word": "مُعَاهَدَةُ السَّلَامِ", "transliteration": "Mu'ahadat As-Salam", "notes": "الاتفاق الرسمي الملزم لإنهاء النزاع وإرساء السلام"},
        "german": {"article": "der", "word": "Friedensvertrag", "plural": "die Friedensverträge", "gender": "masculine", "example": "Die Unterzeichnung des Friedensvertrags beendete den jahrelangen Krieg."},
        "english": {"word": "peace treaty", "phonetic": "/piːs ˈtriː.ti/", "example": "Signing the historic peace treaty brought security to the region."},
        "image_id": "img_dip_friedensvertrag"
    },
    {
        "id": "dip_waffenstillstand",
        "category": "diplomacy_peace",
        "arabic": {"word": "وَقْفُ إِطْلَاقِ النَّارِ / الهُدْنَةُ", "transliteration": "Waqf Itlaq An-Nar", "notes": "التعليق الفوري للعمليات القتالية والعسكرية"},
        "german": {"article": "der", "word": "Waffenstillstand", "plural": "die Waffenstillstände", "gender": "masculine", "example": "Beide Konfliktparteien einigten sich auf einen humanitären Waffenstillstand."},
        "english": {"word": "ceasefire / truce", "phonetic": "/ˈsiːs.faɪər/", "example": "Both conflicting parties agreed to an immediate humanitarian ceasefire."},
        "image_id": "img_dip_waffenstillstand"
    },
    {
        "id": "dip_sicherheitsrat",
        "category": "diplomacy_peace",
        "arabic": {"word": "مَجْلِسُ الأَمْنِ الدَّوْلِيُّ", "transliteration": "Majlis Al-Amn Ad-Dawli", "notes": "الهيئة الأممية المسؤولة عن صون السلم والأمن الدوليين"},
        "german": {"article": "der", "word": "Sicherheitsrat", "plural": "die Sicherheitsräte", "gender": "masculine", "example": "Der UN-Sicherheitsrat verabschiedete einstimmig eine neue Resolution."},
        "english": {"word": "Security Council", "phonetic": "/sɪˈkjʊə.rə.ti ˌkaʊn.səl/", "example": "The United Nations Security Council passed a binding resolution."},
        "image_id": "img_dip_sicherheitsrat"
    },
    {
        "id": "dip_un",
        "category": "diplomacy_peace",
        "arabic": {"word": "الأُمَمُ المُتَّحِدَةُ", "transliteration": "Al-Umam Al-Muttahidah", "notes": "المنظمة الدولية العالمية الداعية للسلام والتعاون"},
        "german": {"article": "die", "word": "Vereinten Nationen", "plural": "die Vereinten Nationen", "gender": "plural", "example": "Die Vereinten Nationen setzen sich weltweit für Frieden und Menschenrechte ein."},
        "english": {"word": "United Nations (UN)", "phonetic": "/jʊˌnaɪ.tɪd ˈneɪ.ʃənz/", "example": "The United Nations coordinates international humanitarian missions."},
        "image_id": "img_dip_un"
    },
    {
        "id": "dip_hilfe",
        "category": "diplomacy_peace",
        "arabic": {"word": "المُسَاعَدَاتُ الإِنْسَانِيَّةُ", "transliteration": "Al-Musa'adat Al-Insaniyyah", "notes": "الإمدادات الإغاثية للمتضررين من الكوارث والحروب"},
        "german": {"article": "die", "word": "humanitäre Hilfe", "plural": "die humanitären Hilfen", "gender": "feminine", "example": "Internationale Hilfskonvois lieferten Nahrung und Medikamente."},
        "english": {"word": "humanitarian aid", "phonetic": "/hjuːˌmæn.ɪˈteə.ri.ən eɪd/", "example": "Humanitarian aid supplies were distributed to displaced families."},
        "image_id": "img_dip_hilfe"
    },
    {
        "id": "dip_fluechtling",
        "category": "diplomacy_peace",
        "arabic": {"word": "اللَّاجِئُ", "transliteration": "Al-Laji'", "notes": "الشخص المجبر على مغادرة وطنه بسبب النزاعات والاضطهاد"},
        "german": {"article": "der", "word": "Flüchtling", "plural": "die Flüchtlinge", "gender": "masculine", "example": "Hilfsorganisationen versorgen schutzbedürftige Flüchtlinge mit warmen Decken."},
        "english": {"word": "refugee", "phonetic": "/ˌref.jʊˈdʒiː/", "example": "International agencies ensure safe shelter for incoming refugees."},
        "image_id": "img_dip_fluechtling"
    },
    {
        "id": "dip_asyl",
        "category": "diplomacy_peace",
        "arabic": {"word": "اللُّجُوءُ الإِنْسَانِيُّ / المَلَاذُ", "transliteration": "Al-Lujoo'", "notes": "الحماية القانونية الممنوحة للأشخاص المضطهدين"},
        "german": {"article": "das", "word": "Asyl", "plural": "die Asyle", "gender": "neuter", "example": "Das Recht auf politisches Asyl ist im Grundgesetz verankert."},
        "english": {"word": "asylum / sanctuary", "phonetic": "/əˈsaɪ.ləm/", "example": "Persecuted individuals have a legal right to seek political asylum."},
        "image_id": "img_dip_asyl"
    },
    {
        "id": "dip_versoehnung",
        "category": "diplomacy_peace",
        "arabic": {"word": "المُصَالَحَةُ وَالوِفَاقُ", "transliteration": "Al-Musalahah", "notes": "تجاوز الأحقاد التاريخية وإعادة بناء الروابط الودية"},
        "german": {"article": "die", "word": "Versöhnung", "plural": "die Versöhnungen", "gender": "feminine", "example": "Wahrhaftige Versöhnung erfordert Mut zur Vergebung und gemeinsamen Zukunft."},
        "english": {"word": "reconciliation", "phonetic": "/ˌrek.ənˌsɪl.iˈeɪ.ʃən/", "example": "Reconciliation commissions paved the path toward lasting harmony."},
        "image_id": "img_dip_versoehnung"
    },
    {
        "id": "dip_kompromiss",
        "category": "diplomacy_peace",
        "arabic": {"word": "الحَلُّ الوَسَطُ / التَّسْوِيَةُ", "transliteration": "Al-Hall Al-Wasat", "notes": "الاتفاق الذي يقدم فيه كل طرف تنازلات للوصول للوفاق"},
        "german": {"article": "der", "word": "Kompromiss", "plural": "die Kompromisse", "gender": "masculine", "example": "Ein tragfähiger Kompromiss berücksichtigt die berechtigten Interessen beider Seiten."},
        "english": {"word": "compromise", "phonetic": "/ˈkɒm.prə.maɪz/", "example": "Finding a mutually acceptable compromise enabled the accord."},
        "image_id": "img_dip_kompromiss"
    },
    {
        "id": "dip_buendnis",
        "category": "diplomacy_peace",
        "arabic": {"word": "التَّحَالُفُ الدَّوْلِيُّ", "transliteration": "At-Tahaluf", "notes": "المعاهدة المشتركة للدفاع أو التعاون بين دول ذات سيادة"},
        "german": {"article": "das", "word": "Bündnis", "plural": "die Bündnisse", "gender": "neuter", "example": "Das internationale Bündnis engagiert sich für globale Stabilität."},
        "english": {"word": "international alliance", "phonetic": "/əˈlaɪ.əns/", "example": "The diplomatic alliance bolstered security and economic stability."},
        "image_id": "img_dip_buendnis"
    },
    {
        "id": "dip_vermittlung",
        "category": "diplomacy_peace",
        "arabic": {"word": "الوَسَاطَةُ لِحَلِّ الخِلَافَاتِ", "transliteration": "Al-Wasatah", "notes": "تدخل طرف ثالث محايد لتقريب وجهات النظر"},
        "german": {"article": "die", "word": "Vermittlung", "plural": "die Vermittlungen", "gender": "feminine", "example": "Dank der neutralen Vermittlung der Schweiz trafen sich die Delegationen."},
        "english": {"word": "mediation / arbitration", "phonetic": "/ˌmiː.diˈeɪ.ʃən/", "example": "Third-party mediation brought the conflicting parties back to talks."},
        "image_id": "img_dip_vermittlung"
    },
    {
        "id": "dip_neutralitaet",
        "category": "diplomacy_peace",
        "arabic": {"word": "الحِيَادُ الإِيجَابِيُّ", "transliteration": "Al-Hiyad", "notes": "عدم الانحياز لأي من الأطراف المتحاربة في النزاعات"},
        "german": {"article": "die", "word": "Neutralität", "plural": "die Neutralitäten", "gender": "feminine", "example": "Die verfassungsmäßige Neutralität ermöglichte erfolgreiche Friedensgespräche."},
        "english": {"word": "neutrality", "phonetic": "/njuːˈtræl.ə.ti/", "example": "Strict political neutrality allows a nation to host impartial peace talks."},
        "image_id": "img_dip_neutralitaet"
    },
    {
        "id": "dip_solidaritaet",
        "category": "diplomacy_peace",
        "arabic": {"word": "التَّكَافُلُ وَالتَّضَامُنُ الدَّوْلِيُّ", "transliteration": "At-Tadamun Ad-Dawli", "notes": "وقوف الشعوب والدول معًا في مواجهة الشدائد والكوارث"},
        "german": {"article": "die", "word": "internationale Solidarität", "plural": "die internationalen Solidaritäten", "gender": "feminine", "example": "Globale Krisen erfordern grenzüberschreitende internationale Solidarität."},
        "english": {"word": "international solidarity", "phonetic": "/ˌsɒl.ɪˈdær.ə.ti/", "example": "Widespread international solidarity brought humanitarian aid quickly."},
        "image_id": "img_dip_solidaritaet"
    },
    {
        "id": "dip_abruestung",
        "category": "diplomacy_peace",
        "arabic": {"word": "نَزْعُ السِّلَاحِ", "transliteration": "Naz' As-Silah", "notes": "تقليص أو إزالة الترسانات العسكرية والأسلحة الفتاكة"},
        "german": {"article": "die", "word": "Abrüstung", "plural": "die Abrüstungen", "gender": "feminine", "example": "Verhandlungen über nukleare Abrüstung verringern die weltweite Kriegsgefahr."},
        "english": {"word": "disarmament", "phonetic": "/dɪˈsɑː.mə.mənt/", "example": "Multilateral nuclear disarmament treaties protect future generations."},
        "image_id": "img_dip_abruestung"
    },
    {
        "id": "dip_souveraenitaet",
        "category": "diplomacy_peace",
        "arabic": {"word": "السِّيَادَةُ الوَطَنِيَّةُ", "transliteration": "As-Siyadah", "notes": "استقلال الدولة التام وسلطتها العليا على أراضيها وشعبها"},
        "german": {"article": "die", "word": "Souveränität", "plural": "die Souveränitäten", "gender": "feminine", "example": "Die territoriale Souveränität aller Staaten ist völkerrechtlich unantastbar."},
        "english": {"word": "sovereignty", "phonetic": "/ˈsɒv.rɪn.ti/", "example": "International law affirms the sovereign equality of all independent nations."},
        "image_id": "img_dip_souveraenitaet"
    },
    {
        "id": "dip_dialog",
        "category": "diplomacy_peace",
        "arabic": {"word": "الحِوَارُ الدَّوْلِيُّ", "transliteration": "Al-Hiwar Ad-Dawli", "notes": "التواصل الحضاري والسياسي المستمر بين الحكومات والشعوب"},
        "german": {"article": "der", "word": "Dialog", "plural": "die Dialoge", "gender": "masculine", "example": "Der konstruktive Dialog zwischen den Kulturen baut Vorurteile ab."},
        "english": {"word": "intergovernmental dialogue", "phonetic": "/ˈdaɪ.ə.lɒɡ/", "example": "Constructive cross-cultural dialogue dispels long-standing prejudices."},
        "image_id": "img_dip_dialog"
    },
    {
        "id": "dip_resolution",
        "category": "diplomacy_peace",
        "arabic": {"word": "القَرَارُ الأُمَمِيُّ", "transliteration": "Al-Qarar Al-Umami", "notes": "البيان أو التوصية الرسمية الصادرة عن الهيئات الدولية"},
        "german": {"article": "die", "word": "Resolution", "plural": "die Resolutionen", "gender": "feminine", "example": "Die Generalversammlung verabschiedete eine Resolution zum Schutz der Zivilbevölkerung."},
        "english": {"word": "international resolution", "phonetic": "/ˌrez.əˈluː.ʃən/", "example": "The General Assembly approved a binding protection resolution."},
        "image_id": "img_dip_resolution"
    },
    {
        "id": "dip_weltfrieden",
        "category": "diplomacy_peace",
        "arabic": {"word": "السَّلَامُ العَالَمِيُّ", "transliteration": "As-Salam Al-'Alami", "notes": "الغاية الإنسانية الكبرى بسيادة الأمن والعدالة والوئام على كوكب الأرض"},
        "german": {"article": "der", "word": "Weltfrieden", "plural": "die Weltfrieden", "gender": "masculine", "example": "Der dauerhafte Weltfrieden bleibt das höchste Ziel der vereinten Menschheit."},
        "english": {"word": "world peace", "phonetic": "/wɜːld piːs/", "example": "Achieving lasting world peace is humanity's highest collective aspiration."},
        "image_id": "img_dip_weltfrieden"
    }
]

# حفظ ملف المفردات الجديد في content/vocabulary/diplomacy_peace_a2.json
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/diplomacy_peace_a2.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "diplomacy_peace",
        "category_name": {
            "ar": "الدبلوماسية والسلام الإنساني",
            "de": "Diplomatie & Frieden",
            "en": "Diplomacy & Global Peace"
        },
        "level": "A2",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم دبلوماسية ودولية في {vocab_path}")

# 2. توليد 25 أيقونة SVG خفيفة ومتجهية (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "dip_diplomatie": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00695C"/><path d="M28,52 C35,42 45,46 50,54 C55,46 65,42 72,52" stroke="#FFF" stroke-width="6" fill="none" stroke-linecap="round"/><circle cx="50" cy="34" r="8" fill="#FFD54F"/></svg>',
    "dip_diplomat": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="28" r="14" fill="#FFA726"/><path d="M26,82 C26,58 74,58 74,82 Z" fill="#263238"/><polygon points="46,44 54,44 58,62 50,68 42,62" fill="#FFF"/><polygon points="48,50 52,50 53,64 50,69 47,64" fill="#1565C0"/><rect x="68" y="58" width="16" height="20" rx="2" fill="#D7CCC8"/></svg>',
    "dip_botschaft": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,15 15,36 85,36" fill="#37474F"/><rect x="22" y="36" width="8" height="42" fill="#B0BEC5"/><rect x="40" y="36" width="8" height="42" fill="#B0BEC5"/><rect x="52" y="36" width="8" height="42" fill="#B0BEC5"/><rect x="70" y="36" width="8" height="42" fill="#B0BEC5"/><rect x="15" y="78" width="70" height="8" fill="#263238"/><line x1="50" y1="6" x2="50" y2="15" stroke="#FFD54F" stroke-width="2"/><polygon points="50,6 62,9 50,12" fill="#E53935"/></svg>',
    "dip_botschafter": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="30" r="14" fill="#FFCC80"/><path d="M26,82 C26,58 74,58 74,82 Z" fill="#004D40"/><polygon points="46,44 54,44 56,60 50,66 44,60" fill="#FFF"/><polygon points="72,25 76,34 85,34 78,40 80,48 72,43 64,48 66,40 59,34 68,34" fill="#FFD54F"/></svg>',
    "dip_gipfel": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1565C0"/><ellipse cx="50" cy="56" rx="28" ry="14" fill="#0D47A1"/><circle cx="50" cy="32" r="6" fill="#FFD54F"/><circle cx="28" cy="48" r="6" fill="#FFD54F"/><circle cx="72" cy="48" r="6" fill="#FFD54F"/><circle cx="38" cy="70" r="6" fill="#FFD54F"/><circle cx="62" cy="70" r="6" fill="#FFD54F"/></svg>',
    "dip_konflikt": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#37474F"/><line x1="25" y1="50" x2="45" y2="50" stroke="#FF5252" stroke-width="6" stroke-linecap="round"/><line x1="75" y1="50" x2="55" y2="50" stroke="#00E5FF" stroke-width="6" stroke-linecap="round"/><polygon points="50,35 56,48 44,48" fill="#FFD54F"/><polygon points="50,65 56,52 44,52" fill="#FFD54F"/></svg>',
    "dip_verhandlung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="45" width="60" height="30" rx="4" fill="#5D4037"/><circle cx="35" cy="32" r="10" fill="#FFA726"/><circle cx="65" cy="32" r="10" fill="#FFCC80"/><path d="M42,56 L58,56" stroke="#FFD54F" stroke-width="4" stroke-linecap="round"/></svg>',
    "dip_friedensvertrag": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="16" width="56" height="68" rx="4" fill="#FFF8E1" stroke="#4E342E" stroke-width="3"/><line x1="32" y1="30" x2="68" y2="30" stroke="#3E2723" stroke-width="4"/><line x1="32" y1="42" x2="68" y2="42" stroke="#8D6E63" stroke-width="2.5"/><line x1="32" y1="52" x2="68" y2="52" stroke="#8D6E63" stroke-width="2.5"/><circle cx="68" cy="70" r="7" fill="#C2185B"/><path d="M32,68 Q45,60 55,68" stroke="#1565C0" stroke-width="3" fill="none"/></svg>',
    "dip_waffenstillstand": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#43A047"/><path d="M35,28 L35,72 M35,28 L72,42 L35,56" fill="#FFF" stroke="#FFF" stroke-width="3" stroke-linejoin="round"/></svg>',
    "dip_sicherheitsrat": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0D47A1"/><path d="M25,65 A30,30 0 0,1 75,65" stroke="#FFF" stroke-width="6" fill="none" stroke-linecap="round"/><circle cx="50" cy="65" r="8" fill="#FFD54F"/><circle cx="30" cy="45" r="5" fill="#80D8FF"/><circle cx="70" cy="45" r="5" fill="#80D8FF"/><circle cx="50" cy="30" r="5" fill="#80D8FF"/></svg>',
    "dip_un": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0288D1"/><circle cx="50" cy="50" r="26" fill="none" stroke="#FFF" stroke-width="2.5"/><circle cx="50" cy="50" r="16" fill="none" stroke="#FFF" stroke-width="2"/><line x1="12" y1="50" x2="88" y2="50" stroke="#FFF" stroke-width="2"/><line x1="50" y1="12" x2="50" y2="88" stroke="#FFF" stroke-width="2"/><path d="M30,75 C25,60 30,35 45,25" stroke="#81D4FA" stroke-width="3" fill="none"/><path d="M70,75 C75,60 70,35 55,25" stroke="#81D4FA" stroke-width="3" fill="none"/></svg>',
    "dip_hilfe": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#E53935"/><rect x="42" y="24" width="16" height="52" rx="3" fill="#FFF"/><rect x="24" y="42" width="52" height="16" rx="3" fill="#FFF"/></svg>',
    "dip_fluechtling": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="30" r="14" fill="#FFA726"/><path d="M26,82 C26,58 74,58 74,82 Z" fill="#78909C"/><rect x="22" y="65" width="18" height="20" rx="3" fill="#8D6E63"/><polygon points="75,20 85,28 75,36" fill="#4CAF50"/></svg>',
    "dip_asyl": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#2E7D32"/><polygon points="50,18 20,44 80,44" fill="#FFF"/><rect x="28" y="44" width="44" height="34" fill="#FFF"/><rect x="44" y="55" width="12" height="23" fill="#2E7D32"/><circle cx="50" cy="34" r="4" fill="#FFD54F"/></svg>',
    "dip_versoehnung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#5C6BC0"/><circle cx="36" cy="40" r="12" fill="#FFCC80"/><circle cx="64" cy="40" r="12" fill="#FFA726"/><path d="M24,78 C24,60 50,60 50,78 Z" fill="#3949AB"/><path d="M50,78 C50,60 76,60 76,78 Z" fill="#1A237E"/><circle cx="50" cy="50" r="8" fill="#00E676"/><path d="M46,50 L49,53 L55,47" stroke="#FFF" stroke-width="2" fill="none"/></svg>',
    "dip_kompromiss": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FF8F00"/><line x1="22" y1="50" x2="78" y2="50" stroke="#FFF" stroke-width="5" stroke-linecap="round"/><circle cx="50" cy="50" r="14" fill="#FFF"/><circle cx="50" cy="50" r="6" fill="#E65100"/></svg>',
    "dip_buendnis": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="35" cy="45" r="22" fill="none" stroke="#1565C0" stroke-width="6"/><circle cx="65" cy="45" r="22" fill="none" stroke="#00897B" stroke-width="6"/><circle cx="50" cy="65" r="20" fill="none" stroke="#FFB300" stroke-width="6"/></svg>',
    "dip_vermittlung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#455A64"/><circle cx="25" cy="50" r="10" fill="#E53935"/><circle cx="75" cy="50" r="10" fill="#1E88E5"/><circle cx="50" cy="35" r="12" fill="#4CAF50"/><line x1="25" y1="50" x2="50" y2="35" stroke="#FFF" stroke-width="3"/><line x1="75" y1="50" x2="50" y2="35" stroke="#FFF" stroke-width="3"/></svg>',
    "dip_neutralitaet": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#90A4AE"/><line x1="24" y1="45" x2="76" y2="45" stroke="#FFF" stroke-width="5" stroke-linecap="round"/><line x1="50" y1="28" x2="50" y2="76" stroke="#FFF" stroke-width="5" stroke-linecap="round"/><path d="M24,45 L16,62 Q24,66 32,62 Z" fill="#FFF"/><path d="M76,45 L68,62 Q76,66 84,62 Z" fill="#FFF"/></svg>',
    "dip_solidaritaet": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#D81B60"/><circle cx="32" cy="40" r="9" fill="#FFF"/><circle cx="50" cy="32" r="9" fill="#FFF"/><circle cx="68" cy="40" r="9" fill="#FFF"/><path d="M20,72 C20,58 80,58 80,72 Z" fill="#FFF"/><circle cx="50" cy="52" r="5" fill="#FFD54F"/></svg>',
    "dip_abruestung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#3E2723"/><line x1="28" y1="72" x2="72" y2="28" stroke="#D32F2F" stroke-width="7" stroke-linecap="round"/><polygon points="28,28 72,72 65,79 21,35" fill="#90A4AE"/><line x1="72" y1="28" x2="28" y2="72" stroke="#FFF" stroke-width="5" stroke-linecap="round"/></svg>',
    "dip_souveraenitaet": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1A237E"/><polygon points="50,18 78,32 78,65 50,82 22,65 22,32" fill="#283593"/><polygon points="50,28 55,40 68,40 58,48 62,60 50,52 38,60 42,48 32,40 45,40" fill="#FFD700"/></svg>',
    "dip_dialog": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00897B"/><path d="M25,32 C25,25 35,20 45,20 C55,20 62,25 62,32 L62,48 C62,55 55,58 45,58 L35,68 L37,58 L25,58 Z" fill="#FFF"/><path d="M75,44 C75,38 68,34 58,34 L56,34 L56,58 C56,64 50,68 40,68 L38,68 L48,80 L48,72 C62,72 75,68 75,60 Z" fill="#FFD54F"/></svg>',
    "dip_resolution": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="16" width="56" height="68" rx="4" fill="#FFF" stroke="#1565C0" stroke-width="3"/><line x1="32" y1="28" x2="68" y2="28" stroke="#0D47A1" stroke-width="4"/><line x1="32" y1="40" x2="68" y2="40" stroke="#78909C" stroke-width="2.5"/><line x1="32" y1="50" x2="68" y2="50" stroke="#78909C" stroke-width="2.5"/><circle cx="66" cy="68" r="8" fill="#43A047"/><path d="M62,68 L65,71 L71,65" stroke="#FFF" stroke-width="2" fill="none"/></svg>',
    "dip_weltfrieden": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0288D1"/><path d="M30,55 C35,40 55,30 70,35 C70,55 55,70 30,55 Z" fill="#FFF"/><circle cx="65" cy="38" r="3" fill="#0288D1"/><polygon points="70,38 78,35 74,42" fill="#FFA000"/><path d="M78,35 Q86,28 90,32" stroke="#4CAF50" stroke-width="2.5" fill="none"/></svg>'
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
            "description": f"Vector illustration for diplomacy concept: {c['english']['word']}"
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
    
    if "diplomacy_peace_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/tourism_travel_a2.json',",
            "'assets/content/vocabulary/tourism_travel_a2.json',\n    'assets/content/vocabulary/diplomacy_peace_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط diplomacy_peace_a2.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "diplomacy_peace" not in cat_code:
        entry = """    CategoryMeta(
      id: 'diplomacy_peace',
      titleAr: 'الدبلوماسية والسلام الإنساني',
      titleDe: 'Diplomatie & Frieden',
      titleEn: 'Diplomacy & Global Peace',
      icon: Icons.volunteer_activism_rounded,
      primaryColor: Color(0xFF00695C),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم الدبلوماسية والسلام في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 33", "TOTAL_VOCAB_CATEGORIES = 34")
    val_code = val_code.replace("TOTAL_CONCEPTS = 830", "TOTAL_CONCEPTS = 855")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 1010", "TOTAL_SVG_ASSETS = 1035")
    
    if "diplomacy_peace_a2.json" not in val_code:
        val_code = val_code.replace(
            "'tourism_travel_a2.json',",
            "'tourism_travel_a2.json',\n    'diplomacy_peace_a2.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (34 فئة، 855 مفهومًا، 1,035 أصلًا متجهيًا)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 059 Status (Completed - Level A2 Diplomacy & Peace Category)
- **Feature:** Category 34: Global Diplomacy, Conflicts & Peace (`diplomacy_peace_a2.json`).
- **New Concepts:** 25 trilingual vocabulary items for embassies, ambassadors, summits, ceasefires, asylum, humanitarian aid, and world peace.
- **New Visuals:** 25 unique lightweight SVG vectors (`dip_*.svg`).
- **HISTORIC MILESTONE REACHED:**
  - 34 Vocabulary Categories.
  - 855 Core Vocabulary Concepts (Crossed 850+ words).
  - 35 Base Verbs | 15 Perfekt Forms.
  - 90 Syntax Exercises (Sentence Builder).
  - 24 Prepositions + 10 Temporal Systems.
  - 12 Comprehensive Grammar Engines.
  - 1,035 Total SVG Vector Icons.
- **Integration:** Active in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 059 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 059 بنجاح تام!")
