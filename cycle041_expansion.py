import json
import os

print("🚀 [CYCLE 041] بدء بناء قسم الأعمال والشركات والمراسلات المهنية (Business & Workplace - A2)...")

# 1. قائمة الـ 25 مفهومًا لقسم الأعمال والشركات
concepts = [
    {
        "id": "biz_unternehmen",
        "category": "business_workplace",
        "arabic": {"word": "الشَّرِكَةُ / المُؤَسَّسَةُ", "transliteration": "Ash-Sharikah", "notes": "الكيان التجاري أو الاقتصادي"},
        "german": {"article": "das", "word": "Unternehmen", "plural": "die Unternehmen", "gender": "neuter", "example": "Das internationale Unternehmen beschäftigt über tausend Mitarbeiter."},
        "english": {"word": "company / enterprise", "phonetic": "/ˈkʌm.pə.ni/", "example": "The tech enterprise expanded into new global markets."},
        "image_id": "img_biz_unternehmen"
    },
    {
        "id": "biz_buero",
        "category": "business_workplace",
        "arabic": {"word": "المَكْتَبُ / مَقَرُّ العَمَلِ", "transliteration": "Al-Maktab", "notes": "مكان ممارسة الأعمال الإدارية"},
        "german": {"article": "das", "word": "Büro", "plural": "die Büros", "gender": "neuter", "example": "Ich arbeite montags und mittwochs im modernen Büro."},
        "english": {"word": "office", "phonetic": "/ˈɒf.ɪs/", "example": "Our open-plan office is located in the financial district."},
        "image_id": "img_biz_buero"
    },
    {
        "id": "biz_besprechung",
        "category": "business_workplace",
        "arabic": {"word": "الِاجْتِمَاعُ المِهْنِيُّ", "transliteration": "Al-Ijtima'", "notes": "جلسة تشاور وتنسيق بين فرق العمل"},
        "german": {"article": "die", "word": "Besprechung", "plural": "die Besprechungen", "gender": "feminine", "example": "Die wichtige Teambesprechung beginnt um zehn Uhr im Konferenzraum."},
        "english": {"word": "meeting / briefing", "phonetic": "/ˈmiː.tɪŋ/", "example": "We scheduled an urgent strategy meeting with stakeholders."},
        "image_id": "img_biz_besprechung"
    },
    {
        "id": "biz_kollege",
        "category": "business_workplace",
        "arabic": {"word": "الزَّمِيلُ فِي العَمَلِ", "transliteration": "Az-Zameel", "notes": "الموظف الزميل في نفس المؤسسة"},
        "german": {"article": "der", "word": "Kollege", "plural": "die Kollegen", "gender": "masculine (n-Deklination)", "example": "Mein erfahrener Kollege half mir bei der Einarbeitung."},
        "english": {"word": "colleague / coworker (male)", "phonetic": "/ˈkɒl.iːɡ/", "example": "My senior colleague offered insightful professional guidance."},
        "image_id": "img_biz_kollege"
    },
    {
        "id": "biz_kollegin",
        "category": "business_workplace",
        "arabic": {"word": "الزَّمِيلَةُ فِي العَمَلِ", "transliteration": "Az-Zameelah", "notes": "الموظفة الزميلة في المؤسسة"},
        "german": {"article": "die", "word": "Kollegin", "plural": "die Kolleginnen", "gender": "feminine", "example": "Die freundliche Kollegin leitet das neue IT-Projekt."},
        "english": {"word": "colleague / coworker (female)", "phonetic": "/ˈkɒl.iːɡ/", "example": "Our new colleague manages international client relations."},
        "image_id": "img_biz_kollegin"
    },
    {
        "id": "biz_manager",
        "category": "business_workplace",
        "arabic": {"word": "المُدِيرُ / المَسْؤُولُ التَّنْفِيذِيُّ", "transliteration": "Al-Mudeer", "notes": "المسؤول عن توجيه الأقسام وإدارتها"},
        "german": {"article": "der", "word": "Manager", "plural": "die Manager", "gender": "masculine", "example": "Der Manager präsentierte die Quartalszahlen dem Vorstand."},
        "english": {"word": "manager / executive", "phonetic": "/ˈmæn.ɪ.dʒər/", "example": "The executive manager introduced the quarterly performance goals."},
        "image_id": "img_biz_manager"
    },
    {
        "id": "biz_kunde",
        "category": "business_workplace",
        "arabic": {"word": "العَمِيلُ / الزَّبُونُ", "transliteration": "Al-'Ameel", "notes": "الشخص أو الجهة المستفيدة من الخدمات"},
        "german": {"article": "der", "word": "Kunde", "plural": "die Kunden", "gender": "masculine (n-Deklination)", "example": "Kundenzufriedenheit steht bei uns an erster Stelle."},
        "english": {"word": "client / customer", "phonetic": "/ˈklaɪ.ənt/", "example": "Building lasting client relationships is essential for success."},
        "image_id": "img_biz_kunde"
    },
    {
        "id": "biz_vertrag",
        "category": "business_workplace",
        "arabic": {"word": "عَقْدُ العَمَلِ", "transliteration": "Aqd Al-'Amal", "notes": "الاتفاق القانوني المحدد للحقوق والواجبات"},
        "german": {"article": "der", "word": "Arbeitsvertrag", "plural": "die Arbeitsverträge", "gender": "masculine", "example": "Er hat gestern seinen unbefristeten Arbeitsvertrag unterschrieben."},
        "english": {"word": "employment contract", "phonetic": "/ˈkɒn.trækt/", "example": "She signed a permanent employment contract with the firm."},
        "image_id": "img_biz_vertrag"
    },
    {
        "id": "biz_gehalt",
        "category": "business_workplace",
        "arabic": {"word": "الرَّاتِبُ الشَّهْرِيُّ", "transliteration": "Ar-Ratib", "notes": "المقابل المالي الدوري للعمل"},
        "german": {"article": "das", "word": "Gehalt", "plural": "die Gehälter", "gender": "neuter", "example": "Das Gehalt wird am Monatsende pünktlich überwiesen."},
        "english": {"word": "salary / compensation", "phonetic": "/ˈsæl.ər.i/", "example": "Employees receive competitive monthly salaries and bonuses."},
        "image_id": "img_biz_gehalt"
    },
    {
        "id": "biz_vorstellungsgespraech",
        "category": "business_workplace",
        "arabic": {"word": "مُقَابَلَةُ التَّوْظِيفِ", "transliteration": "Muqabalat At-Tawtheef", "notes": "المحادثة التقييمية لاختيار الموظف المناسب"},
        "german": {"article": "das", "word": "Vorstellungsgespräch", "plural": "die Vorstellungsgespräche", "gender": "neuter", "example": "Sie hat morgen ein wichtiges Vorstellungsgespräch in Frankfurt."},
        "english": {"word": "job interview", "phonetic": "/dʒɒb ˈɪn.tə.vjuː/", "example": "He prepared thoroughly for his technical job interview."},
        "image_id": "img_biz_vorstellungsgespraech"
    },
    {
        "id": "biz_lebenslauf",
        "category": "business_workplace",
        "arabic": {"word": "السِّيرَةُ الذَّاتِيَّةُ", "transliteration": "As-Seerah Ath-Thatiyyah", "notes": "ملخص الخبرات الأكاديمية والمهنية"},
        "german": {"article": "der", "word": "Lebenslauf", "plural": "die Lebensläufe", "gender": "masculine", "example": "Ein lückenloser tabellarischer Lebenslauf gehört zur Bewerbung."},
        "english": {"word": "resume / CV", "phonetic": "/ˈrez.juː.meɪ/", "example": "Keep your professional resume concise and updated."},
        "image_id": "img_biz_lebenslauf"
    },
    {
        "id": "biz_bewerbung",
        "category": "business_workplace",
        "arabic": {"word": "طَلَبُ التَّقَدُّمِ لِوَظِيفَةٍ", "transliteration": "Talab At-Taqaddum", "notes": "الملف التقديمي لشغل شاغر وظيفي"},
        "german": {"article": "die", "word": "Bewerbung", "plural": "die Bewerbungen", "gender": "feminine", "example": "Ich habe meine Bewerbung heute per E-Mail abgeschickt."},
        "english": {"word": "job application", "phonetic": "/ˌæp.lɪˈkeɪ.ʃən/", "example": "Submit your job application through the online career portal."},
        "image_id": "img_biz_bewerbung"
    },
    {
        "id": "biz_projekt",
        "category": "business_workplace",
        "arabic": {"word": "المَشْرُوعُ", "transliteration": "Al-Mashroo'", "notes": "الخطة ذات الأهداف والجدول الزمني المحدد"},
        "german": {"article": "das", "word": "Projekt", "plural": "die Projekte", "gender": "neuter", "example": "Wir arbeiten gemeinsam an einem zukunftsweisenden Softwareprojekt."},
        "english": {"word": "project", "phonetic": "/ˈprɒdʒ.ekt/", "example": "The development team delivered the software project ahead of time."},
        "image_id": "img_biz_projekt"
    },
    {
        "id": "biz_praesentation",
        "category": "business_workplace",
        "arabic": {"word": "العَرْضُ التَّقْدِيمِيُّ", "transliteration": "Al-'Ard At-Taqdeemi", "notes": "استعراض الأفكار والبيانات بصريًا"},
        "german": {"article": "die", "word": "Präsentation", "plural": "die Präsentationen", "gender": "feminine", "example": "Seine überzeugende Präsentation begeisterte die Kunden."},
        "english": {"word": "presentation", "phonetic": "/ˌprez.ənˈteɪ.ʃən/", "example": "She delivered an engaging slide presentation on innovation."},
        "image_id": "img_biz_praesentation"
    },
    {
        "id": "biz_verhandlung",
        "category": "business_workplace",
        "arabic": {"word": "التَّفَاوُضُ / المُفَاوَضَاتُ", "transliteration": "At-Tafawud", "notes": "الحوار الهادف للتوصل إلى اتفاق مرضي"},
        "german": {"article": "die", "word": "Verhandlung", "plural": "die Verhandlungen", "gender": "feminine", "example": "Die Verhandlungen führten zu einem fairen Kompromiss."},
        "english": {"word": "negotiation", "phonetic": "/nəˌɡəʊ.ʃiˈeɪ.ʃən/", "example": "Constructive contract negotiations finalized the partnership."},
        "image_id": "img_biz_verhandlung"
    },
    {
        "id": "biz_frist",
        "category": "business_workplace",
        "arabic": {"word": "المَوْعِدُ النِّهَائِيُّ / الأَجَلُ", "transliteration": "Al-Maw'id An-Niha'i", "notes": "آخر مهلة لتسليم الأعمال أو المهام"},
        "german": {"article": "die", "word": "Frist", "plural": "die Fristen", "gender": "feminine", "example": "Wir müssen die Frist bis Freitag unbedingt einhalten."},
        "english": {"word": "deadline", "phonetic": "/ˈded.laɪn/", "example": "The project deadline must be met without compromise."},
        "image_id": "img_biz_frist"
    },
    {
        "id": "biz_abteilung",
        "category": "business_workplace",
        "arabic": {"word": "القِسْمُ الإِدَارِيُّ", "transliteration": "Al-Qism Al-Idari", "notes": "فرع متخصص داخل المؤسسة كالمالية أو التسويق"},
        "german": {"article": "die", "word": "Abteilung", "plural": "die Abteilungen", "gender": "feminine", "example": "Die Marketing-Abteilung plant eine neue Werbekampagne."},
        "english": {"word": "department / division", "phonetic": "/dɪˈpɑːt.mənt/", "example": "The marketing department launched a creative campaign."},
        "image_id": "img_biz_abteilung"
    },
    {
        "id": "biz_teamarbeit",
        "category": "business_workplace",
        "arabic": {"word": "العَمَلُ الجَمَاعِيُّ", "transliteration": "Al-'Amal Al-Jama'i", "notes": "تكاتف الفريق لتحقيق هدف مشترك"},
        "german": {"article": "die", "word": "Teamarbeit", "plural": "die Teamarbeiten", "gender": "feminine", "example": "Erfolgreiche Teamarbeit basiert auf Vertrauen und offener Kommunikation."},
        "english": {"word": "teamwork / collaboration", "phonetic": "/ˈtiːm.wɜːk/", "example": "Close cross-functional teamwork drives organizational innovation."},
        "image_id": "img_biz_teamarbeit"
    },
    {
        "id": "biz_rechnung",
        "category": "business_workplace",
        "arabic": {"word": "الفَاتُورَةُ", "transliteration": "Al-Fatoorah", "notes": "المستند المالي المطالب بقيمة الخدمات أو البضائع"},
        "german": {"article": "die", "word": "Rechnung", "plural": "die Rechnungen", "gender": "feminine", "example": "Bitte begleichen Sie die beiliegende Rechnung innerhalb von zwei Wochen."},
        "english": {"word": "invoice / bill", "phonetic": "/ˈɪn.vɔɪs/", "example": "The accounting team issued the official tax invoice."},
        "image_id": "img_biz_rechnung"
    },
    {
        "id": "biz_angebot",
        "category": "business_workplace",
        "arabic": {"word": "العَرْضُ التِّجَارِيُّ", "transliteration": "Al-'Ard At-Tijari", "notes": "مقترح تقديم خدمة أو بيع سلعة بشروط معينة"},
        "german": {"article": "das", "word": "Angebot", "plural": "die Angebote", "gender": "neuter", "example": "Wir haben dem Kunden ein sehr günstiges Angebot unterbreitet."},
        "english": {"word": "business proposal / offer", "phonetic": "/ˈɒf.ər/", "example": "We submitted a comprehensive proposal to the prospective client."},
        "image_id": "img_biz_angebot"
    },
    {
        "id": "biz_ueberstunden",
        "category": "business_workplace",
        "arabic": {"word": "السَّاعَاتُ الإِضَافِيَّةُ", "transliteration": "As-Sa'at Al-Idafiyyah", "notes": "وقت العمل الزائد عن الساعات المقررة"},
        "german": {"article": "die", "word": "Überstunden", "plural": "die Überstunden", "gender": "plural", "example": "Wegen des engen Zeitplans musste das Team Überstunden machen."},
        "english": {"word": "overtime hours", "phonetic": "/ˈəʊ.və.taɪm/", "example": "Staff were compensated fairly for working overtime hours."},
        "image_id": "img_biz_ueberstunden"
    },
    {
        "id": "biz_erfolg",
        "category": "business_workplace",
        "arabic": {"word": "النَّجَاحُ المِهْنِيُّ", "transliteration": "An-Najah Al-Mihni", "notes": "تحقيق الإنجازات والنتائج المرجوة"},
        "german": {"article": "der", "word": "Erfolg", "plural": "die Erfolge", "gender": "masculine", "example": "Harte Arbeit und Ausdauer führten schließlich zum großen Erfolg."},
        "english": {"word": "professional success", "phonetic": "/səkˈses/", "example": "Dedication and continuous learning ensure professional success."},
        "image_id": "img_biz_erfolg"
    },
    {
        "id": "biz_karriere",
        "category": "business_workplace",
        "arabic": {"word": "المَسَارُ المِهْنِيُّ / المِهْنَةُ", "transliteration": "Al-Masar Al-Mihni", "notes": "التطور والترقي في السلم الوظيفي"},
        "german": {"article": "die", "word": "Karriere", "plural": "die Karrieren", "gender": "feminine", "example": "Sie verfolgt eine zielstrebige Karriere im Finanzsektor."},
        "english": {"word": "career", "phonetic": "/kəˈrɪər/", "example": "He built an illustrious career in software architecture."},
        "image_id": "img_biz_karriere"
    },
    {
        "id": "biz_qualifikation",
        "category": "business_workplace",
        "arabic": {"word": "المُؤَهِّلُ المِهْنِيُّ", "transliteration": "Al-Mu'ahhil", "notes": "الشهادات والمهارات المتخصصة لشغل وظيفة"},
        "german": {"article": "die", "word": "Qualifikation", "plural": "die Qualifikationen", "gender": "feminine", "example": "Ihre fundierten Sprachkenntnisse sind eine hervorragende Qualifikation."},
        "english": {"word": "qualification / credential", "phonetic": "/ˌkwɒl.ɪ.fɪˈkeɪ.ʃən/", "example": "Multilingual proficiency is an outstanding professional qualification."},
        "image_id": "img_biz_qualifikation"
    },
    {
        "id": "biz_dienstreise",
        "category": "business_workplace",
        "arabic": {"word": "رِحْلَةُ العَمَلِ / مَهَمَّةُ العَمَلِ", "transliteration": "Rihlat Al-'Amal", "notes": "السفر الرسمي لإنجاز مهام لصالح المؤسسة"},
        "german": {"article": "die", "word": "Dienstreise", "plural": "die Dienstreisen", "gender": "feminine", "example": "Nächste Woche fliegt der Ingenieur auf Dienstreise nach Tokio."},
        "english": {"word": "business trip", "phonetic": "/ˈbɪz.nɪs ˌtrɪp/", "example": "The lead engineer embarked on an international business trip."},
        "image_id": "img_biz_dienstreise"
    }
]

# حفظ ملف المفردات الجديد في content/vocabulary/business_workplace_a2.json
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/business_workplace_a2.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "business_workplace",
        "category_name": {
            "ar": "الأعمال والمراسلات المهنية",
            "de": "Wirtschaft, Beruf & Kommunikation",
            "en": "Business & Workplace"
        },
        "level": "A2",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم مهنية في {vocab_path}")

# 2. توليد 25 أيقونة SVG متقنة وخفيفة (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "biz_unternehmen": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="25" width="35" height="60" fill="#1565C0"/><rect x="55" y="40" width="25" height="45" fill="#1976D2"/><rect x="26" y="32" width="6" height="8" fill="#BBDEFB"/><rect x="36" y="32" width="6" height="8" fill="#BBDEFB"/><rect x="46" y="32" width="6" height="8" fill="#BBDEFB"/><rect x="26" y="46" width="6" height="8" fill="#BBDEFB"/><rect x="36" y="46" width="6" height="8" fill="#BBDEFB"/><rect x="46" y="46" width="6" height="8" fill="#BBDEFB"/><rect x="62" y="48" width="5" height="7" fill="#BBDEFB"/><rect x="71" y="48" width="5" height="7" fill="#BBDEFB"/><rect x="32" y="70" width="10" height="15" fill="#FFF"/></svg>',
    "biz_buero": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="50" width="70" height="10" rx="2" fill="#795548"/><rect x="22" y="60" width="8" height="28" fill="#5D4037"/><rect x="70" y="60" width="8" height="28" fill="#5D4037"/><rect x="35" y="30" width="30" height="20" rx="2" fill="#42A5F5"/><polygon points="45,50 55,50 58,54 42,54" fill="#1E88E5"/><rect x="68" y="32" width="6" height="18" fill="#FFB300"/></svg>',
    "biz_besprechung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><ellipse cx="50" cy="55" rx="35" ry="18" fill="#546E7A"/><circle cx="50" cy="28" r="8" fill="#FFA726"/><circle cx="20" cy="50" r="8" fill="#FFA726"/><circle cx="80" cy="50" r="8" fill="#FFA726"/><circle cx="35" cy="78" r="8" fill="#FFA726"/><circle cx="65" cy="78" r="8" fill="#FFA726"/><rect x="40" y="50" width="20" height="10" rx="2" fill="#FFF"/></svg>',
    "biz_kollege": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="30" r="14" fill="#FFA726"/><path d="M26,82 C26,58 74,58 74,82 Z" fill="#1565C0"/><polygon points="46,44 54,44 56,62 50,68 44,62" fill="#FFF"/><polygon points="48,50 52,50 53,64 50,69 47,64" fill="#C62828"/></svg>',
    "biz_kollegin": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="30" r="14" fill="#FFCC80"/><path d="M32,20 C42,12 58,12 68,22 C72,38 28,38 32,20 Z" fill="#4E342E"/><path d="M26,82 C26,58 74,58 74,82 Z" fill="#00897B"/><polygon points="46,44 54,44 52,56 48,56" fill="#FFF"/></svg>',
    "biz_manager": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="28" r="14" fill="#FFA726"/><path d="M24,80 C24,55 76,55 76,80 Z" fill="#263238"/><polygon points="45,42 55,42 58,62 50,70 42,62" fill="#FFF"/><polygon points="48,50 52,50 54,65 50,72 46,65" fill="#FFB300"/><circle cx="70" cy="35" r="4" fill="#FFD54F"/></svg>',
    "biz_kunde": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="32" r="14" fill="#FFA726"/><path d="M22,82 C22,58 68,58 68,82 Z" fill="#43A047"/><circle cx="72" cy="50" r="14" fill="#FFB300"/><path d="M66,50 L70,54 L78,46" stroke="#FFF" stroke-width="3" fill="none" stroke-linecap="round"/></svg>',
    "biz_vertrag": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="16" width="56" height="68" rx="4" fill="#FFF8E1" stroke="#8D6E63" stroke-width="3"/><line x1="32" y1="30" x2="68" y2="30" stroke="#5D4037" stroke-width="4"/><line x1="32" y1="42" x2="68" y2="42" stroke="#8D6E63" stroke-width="2.5"/><line x1="32" y1="52" x2="68" y2="52" stroke="#8D6E63" stroke-width="2.5"/><path d="M32,68 C40,64 50,72 60,66" stroke="#1565C0" stroke-width="3" fill="none"/><circle cx="68" cy="70" r="6" fill="#C62828"/></svg>',
    "biz_gehalt": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="30" width="64" height="42" rx="4" fill="#2E7D32"/><circle cx="50" cy="51" r="12" fill="#FFF"/><text x="50" y="58" font-family="sans-serif" font-weight="bold" font-size="16" fill="#2E7D32" text-anchor="middle">€</text><rect x="25" y="24" width="50" height="6" rx="2" fill="#81C784"/></svg>',
    "biz_vorstellungsgespraech": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="30" cy="35" r="12" fill="#FFA726"/><path d="M15,75 C15,58 45,58 45,75 Z" fill="#1565C0"/><circle cx="70" cy="35" r="12" fill="#FFCC80"/><path d="M55,75 C55,58 85,58 85,75 Z" fill="#37474F"/><rect x="42" y="50" width="16" height="25" fill="#8D6E63"/></svg>',
    "biz_lebenslauf": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="15" width="60" height="70" rx="4" fill="#FFF" stroke="#455A64" stroke-width="3"/><circle cx="35" cy="32" r="8" fill="#1565C0"/><line x1="48" y1="28" x2="70" y2="28" stroke="#37474F" stroke-width="3"/><line x1="48" y1="36" x2="65" y2="36" stroke="#78909C" stroke-width="2.5"/><line x1="28" y1="50" x2="72" y2="50" stroke="#78909C" stroke-width="3"/><line x1="28" y1="60" x2="72" y2="60" stroke="#78909C" stroke-width="3"/><line x1="28" y1="70" x2="55" y2="70" stroke="#78909C" stroke-width="3"/></svg>',
    "biz_bewerbung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="25" width="64" height="52" rx="5" fill="#FB8C00"/><polygon points="18,28 50,55 82,28" fill="#FFE082"/><rect x="35" y="15" width="30" height="20" rx="2" fill="#FFF" stroke="#E65100" stroke-width="2"/><line x1="40" y1="22" x2="60" y2="22" stroke="#E65100" stroke-width="2"/></svg>',
    "biz_projekt": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#6A1B9A"/><circle cx="50" cy="50" r="24" fill="#8E24AA"/><circle cx="50" cy="50" r="10" fill="#FFD54F"/><line x1="25" y1="50" x2="75" y2="50" stroke="#FFF" stroke-width="3"/><line x1="50" y1="25" x2="50" y2="75" stroke="#FFF" stroke-width="3"/></svg>',
    "biz_praesentation": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="18" width="64" height="45" rx="3" fill="#ECEFF1" stroke="#37474F" stroke-width="3"/><path d="M25,50 L40,38 L55,44 L72,28" stroke="#E53935" stroke-width="4" fill="none" stroke-linecap="round" stroke-linejoin="round"/><line x1="50" y1="63" x2="50" y2="84" stroke="#37474F" stroke-width="4"/><line x1="35" y1="84" x2="65" y2="84" stroke="#37474F" stroke-width="4"/></svg>',
    "biz_verhandlung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00897B"/><path d="M25,52 C32,42 42,46 50,54 C58,46 68,42 75,52" stroke="#FFF" stroke-width="6" fill="none" stroke-linecap="round"/><circle cx="50" cy="34" r="8" fill="#FFD54F"/></svg>',
    "biz_frist": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#D32F2F"/><circle cx="50" cy="50" r="28" fill="#FFF"/><line x1="50" y1="50" x2="50" y2="30" stroke="#D32F2F" stroke-width="5" stroke-linecap="round"/><line x1="50" y1="50" x2="65" y2="50" stroke="#D32F2F" stroke-width="4" stroke-linecap="round"/><polygon points="46,12 54,12 50,22" fill="#FFD54F"/></svg>',
    "biz_abteilung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="35" y="18" width="30" height="20" rx="3" fill="#1565C0"/><rect x="15" y="55" width="28" height="20" rx="3" fill="#1E88E5"/><rect x="57" y="55" width="28" height="20" rx="3" fill="#1E88E5"/><line x1="50" y1="38" x2="50" y2="48" stroke="#37474F" stroke-width="3"/><line x1="29" y1="48" x2="71" y2="48" stroke="#37474F" stroke-width="3"/><line x1="29" y1="48" x2="29" y2="55" stroke="#37474F" stroke-width="3"/><line x1="71" y1="48" x2="71" y2="55" stroke="#37474F" stroke-width="3"/></svg>',
    "biz_teamarbeit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="32" cy="40" r="10" fill="#E91E63"/><circle cx="50" cy="30" r="10" fill="#00BCD4"/><circle cx="68" cy="40" r="10" fill="#4CAF50"/><path d="M18,75 C18,60 46,60 46,75 Z" fill="#C2185B"/><path d="M36,75 C36,55 64,55 64,75 Z" fill="#0097A7"/><path d="M54,75 C54,60 82,60 82,75 Z" fill="#388E3C"/></svg>',
    "biz_rechnung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="18" width="56" height="66" rx="4" fill="#ECEFF1" stroke="#607D8B" stroke-width="3"/><line x1="30" y1="30" x2="70" y2="30" stroke="#37474F" stroke-width="4"/><line x1="30" y1="42" x2="60" y2="42" stroke="#78909C" stroke-width="3"/><line x1="30" y1="52" x2="60" y2="52" stroke="#78909C" stroke-width="3"/><line x1="30" y1="68" x2="50" y2="68" stroke="#1565C0" stroke-width="4"/><text x="64" y="72" font-family="sans-serif" font-weight="bold" font-size="14" fill="#C62828">€</text></svg>',
    "biz_angebot": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FF8F00"/><polygon points="35,35 65,35 75,50 65,65 35,65 25,50" fill="#FFF"/><text x="50" y="56" font-family="sans-serif" font-weight="bold" font-size="16" fill="#E65100" text-anchor="middle">OFFER</text></svg>',
    "biz_ueberstunden": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="45" r="28" fill="#37474F"/><circle cx="45" cy="45" r="20" fill="#FFF"/><line x1="45" y1="45" x2="45" y2="32" stroke="#D32F2F" stroke-width="3" stroke-linecap="round"/><line x1="45" y1="45" x2="56" y2="45" stroke="#D32F2F" stroke-width="3" stroke-linecap="round"/><circle cx="72" cy="72" r="16" fill="#FF9800"/><path d="M66,72 L78,72 M72,66 L72,78" stroke="#FFF" stroke-width="4" stroke-linecap="round"/></svg>',
    "biz_erfolg": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="35,78 65,78 60,65 40,65" fill="#795548"/><rect x="46" y="55" width="8" height="12" fill="#FFA000"/><path d="M30,22 L70,22 L62,55 C62,60 38,60 38,55 Z" fill="#FFD54F"/><circle cx="50" cy="38" r="8" fill="#FFF"/><polygon points="20,25 30,35 30,25" fill="#FFA000"/><polygon points="80,25 70,35 70,25" fill="#FFA000"/></svg>',
    "biz_karriere": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="65" width="16" height="20" fill="#90CAF9"/><rect x="38" y="50" width="16" height="35" fill="#42A5F5"/><rect x="58" y="35" width="16" height="50" fill="#1E88E5"/><rect x="78" y="20" width="16" height="65" fill="#0D47A1"/><path d="M22,55 L42,40 L62,25 L82,10" stroke="#FF9800" stroke-width="4" fill="none" stroke-linecap="round"/><polygon points="82,10 74,12 80,18" fill="#FF9800"/></svg>',
    "biz_qualifikation": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="40" r="22" fill="#FFD54F"/><polygon points="50,22 55,34 68,34 58,42 62,55 50,47 38,55 42,42 32,34 45,34" fill="#FFA000"/><polygon points="40,58 35,82 50,74 65,82 60,58" fill="#E53935"/></svg>',
    "biz_dienstreise": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="35" width="50" height="42" rx="6" fill="#5D4037"/><rect x="20" y="42" width="60" height="6" fill="#8D6E63"/><path d="M40,35 L40,24 C40,20 60,20 60,24 L60,35" stroke="#3E2723" stroke-width="5" fill="none"/><polygon points="65,18 78,24 72,30" fill="#00BCD4"/></svg>'
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
            "description": f"Vector illustration for business concept: {c['english']['word']}"
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
    
    if "business_workplace_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/politics_law_a2.json',",
            "'assets/content/vocabulary/politics_law_a2.json',\n    'assets/content/vocabulary/business_workplace_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط business_workplace_a2.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "business_workplace" not in cat_code:
        entry = """    CategoryMeta(
      id: 'business_workplace',
      titleAr: 'الأعمال والمراسلات المهنية',
      titleDe: 'Wirtschaft & Beruf',
      titleEn: 'Business & Workplace',
      icon: Icons.business_center_rounded,
      primaryColor: Color(0xFF1565C0),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم الأعمال والمراسلات في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 23", "TOTAL_VOCAB_CATEGORIES = 24")
    val_code = val_code.replace("TOTAL_CONCEPTS = 580", "TOTAL_CONCEPTS = 605")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 680", "TOTAL_SVG_ASSETS = 705")
    
    if "business_workplace_a2.json" not in val_code:
        val_code = val_code.replace(
            "'politics_law_a2.json',",
            "'politics_law_a2.json',\n    'business_workplace_a2.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (24 فئة، 605 مفاهيم، 705 أصول متجهية)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 041 Status (Completed - Level A2 Business & Workplace Category)
- **Feature:** Category 24: Business, Corporate & Workplace (`business_workplace_a2.json`).
- **New Concepts:** 25 trilingual vocabulary items for enterprise, contract, job interview, career, resume, and negotiation.
- **New Visuals:** 25 unique lightweight SVG vectors (`biz_*.svg`).
- **DOUBLE HISTORIC LANDMARK REACHED:**
  - 24 Vocabulary Categories.
  - 605 Core Vocabulary Concepts (Crossed 600+ word barrier).
  - 35 Base Verbs | 15 Perfekt Forms.
  - 50 Syntax Exercises (Sentence Builder).
  - 24 Prepositions | 5 Dialogues.
  - Articles, Genitiv, Relativsätze & Konjunktiv II Engines.
  - 705 Total SVG Vector Icons (Crossed 700+ asset milestone).
- **Integration:** Active in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 041 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 041 بنجاح تام!")
