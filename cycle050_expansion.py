import json
import os

print("🚀 [CYCLE 050 - GOLDEN JUBILEE] بدء بناء قسم الاقتصاد والمال والتجارة العالمية (Economy & Finance - A2)...")

# 1. قائمة الـ 25 مفهومًا لقسم الاقتصاد والمال والتجارة
concepts = [
    {
        "id": "eco_wirtschaft",
        "category": "economy_finance",
        "arabic": {"word": "الِاقْتِصَادُ", "transliteration": "Al-Iqtisad", "notes": "منظومة الإنتاج والتوزيع والتبادل والاستهلاك"},
        "german": {"article": "die", "word": "Wirtschaft", "plural": "die Wirtschaften", "gender": "feminine", "example": "Eine starke Wirtschaft schafft viele sichere Arbeitsplätze."},
        "english": {"word": "economy", "phonetic": "/iˈkɒn.ə.mi/", "example": "A resilient national economy fosters sustainable job growth."},
        "image_id": "img_eco_wirtschaft"
    },
    {
        "id": "eco_markt",
        "category": "economy_finance",
        "arabic": {"word": "السُّوقُ التِّجَارِيُّ / المَالِيُّ", "transliteration": "As-Sooq", "notes": "ميدان التقاء البائعين والمشترين وتبادل السلع"},
        "german": {"article": "der", "word": "Markt", "plural": "die Märkte", "gender": "masculine", "example": "Das Unternehmen erschließt erfolgreich neue internationale Märkte."},
        "english": {"word": "market", "phonetic": "/ˈmɑː.kɪt/", "example": "The global tech market is expanding rapidly this quarter."},
        "image_id": "img_eco_markt"
    },
    {
        "id": "eco_handel",
        "category": "economy_finance",
        "arabic": {"word": "التِّجَارَةُ / التَّبَادُلُ التِّجَارِيُّ", "transliteration": "At-Tijarah", "notes": "عمليات البيع والشراء وتبادل البضائع"},
        "german": {"article": "der", "word": "Handel", "plural": "die Händel", "gender": "masculine", "example": "Der faire internationale Handel stärkt die weltweite Zusammenarbeit."},
        "english": {"word": "trade / commerce", "phonetic": "/treɪd/", "example": "Maritime trade routes connect continents across the globe."},
        "image_id": "img_eco_handel"
    },
    {
        "id": "eco_export",
        "category": "economy_finance",
        "arabic": {"word": "التَّصْدِيرُ / الصَّادِرَاتُ", "transliteration": "At-Tasdeer", "notes": "بيع السلع المنتجة محليًا إلى الأسواق الخارجية"},
        "german": {"article": "der", "word": "Export", "plural": "die Exporte", "gender": "masculine", "example": "Der Export von modernen Maschinen ist ein wichtiger Wirtschaftszweig."},
        "english": {"word": "export", "phonetic": "/ˈek.spɔːt/", "example": "Industrial exports reached a record high this year."},
        "image_id": "img_eco_export"
    },
    {
        "id": "eco_import",
        "category": "economy_finance",
        "arabic": {"word": "الِاسْتِيرَادُ / الوَارِدَاتُ", "transliteration": "Al-Isteerad", "notes": "جلب البضائع والموارد من الخارج للسوق المحلي"},
        "german": {"article": "der", "word": "Import", "plural": "die Importe", "gender": "masculine", "example": "Das Land ist auf den Import von seltenen Rohstoffen angewiesen."},
        "english": {"word": "import", "phonetic": "/ˈɪm.pɔːt/", "example": "The country relies on the import of tropical agricultural goods."},
        "image_id": "img_eco_import"
    },
    {
        "id": "eco_bank",
        "category": "economy_finance",
        "arabic": {"word": "المَصْرِفُ / البَنْكُ", "transliteration": "Al-Masrif / Al-Bank", "notes": "المؤسسة المالية لحفظ الودائع وتقديم التمويل"},
        "german": {"article": "die", "word": "Bank", "plural": "die Banken", "gender": "feminine", "example": "Ich gehe heute zur Bank, um ein neues Konto zu eröffnen."},
        "english": {"word": "bank", "phonetic": "/bæŋk/", "example": "The central bank regulates monetary stability."},
        "image_id": "img_eco_bank"
    },
    {
        "id": "eco_bankkonto",
        "category": "economy_finance",
        "arabic": {"word": "الحِسَابُ المَصْرِفِيُّ", "transliteration": "Al-Hisab Al-Masrifi", "notes": "السجل المالي الشخصي أو التجاري لدى البنك"},
        "german": {"article": "das", "word": "Bankkonto", "plural": "die Bankkonten", "gender": "neuter", "example": "Für das Studium in Deutschland benötigt man ein aktives Bankkonto."},
        "english": {"word": "bank account", "phonetic": "/ˈbæŋk əˌkaʊnt/", "example": "You can manage your savings bank account via mobile banking."},
        "image_id": "img_eco_bankkonto"
    },
    {
        "id": "eco_ueberweisung",
        "category": "economy_finance",
        "arabic": {"word": "التَّحْوِيلُ المَصْرِفِيُّ", "transliteration": "At-Tahweel Al-Masrifi", "notes": "نقل الأموال إلكترونيًا من حساب إلى آخر"},
        "german": {"article": "die", "word": "Überweisung", "plural": "die Überweisungen", "gender": "feminine", "example": "Ich bezahle die monatliche Miete bequem per Banküberweisung."},
        "english": {"word": "bank transfer", "phonetic": "/ˈbæŋk ˌtræns.fɜːr/", "example": "International wire transfers now process within minutes."},
        "image_id": "img_eco_ueberweisung"
    },
    {
        "id": "eco_zins",
        "category": "economy_finance",
        "arabic": {"word": "الفَائِدَةُ المَالِيَّةُ / العَائِدُ", "transliteration": "Al-Fa'idah", "notes": "النسبة المئوية المضافة على الودائع أو القروض"},
        "german": {"article": "der", "word": "Zins", "plural": "die Zinsen", "gender": "masculine", "example": "Auf diesem Sparkonto erhält man jährlich attraktive Zinsen."},
        "english": {"word": "interest / rate", "phonetic": "/ˈɪn.trəst/", "example": "Lower interest rates encourage housing investments."},
        "image_id": "img_eco_zins"
    },
    {
        "id": "eco_steuer",
        "category": "economy_finance",
        "arabic": {"word": "الضَّرِيبَةُ", "transliteration": "Ad-Dareebah", "notes": "الاقتطاع المالي القانوني لتمويل الخدمات العامة"},
        "german": {"article": "die", "word": "Steuer", "plural": "die Steuern", "gender": "feminine", "example": "Aus den gezahlten Steuern werden Schulen und Straßen finanziert."},
        "english": {"word": "tax", "phonetic": "/tæks/", "example": "Public infrastructure is funded through annual income taxes."},
        "image_id": "img_eco_steuer"
    },
    {
        "id": "eco_inflation",
        "category": "economy_finance",
        "arabic": {"word": "التَّضَخُّمُ المَالِيُّ", "transliteration": "At-Tadakh-khum", "notes": "الارتفاع العام في الأسعار وانخفاض القوة الشرائية"},
        "german": {"article": "die", "word": "Inflation", "plural": "die Inflationen", "gender": "feminine", "example": "Hohe Inflation verringert die Kaufkraft des Geldes im Alltag."},
        "english": {"word": "inflation", "phonetic": "/ɪnˈfleɪ.ʃən/", "example": "Rising inflation affects household grocery budgets."},
        "image_id": "img_eco_inflation"
    },
    {
        "id": "eco_investition",
        "category": "economy_finance",
        "arabic": {"word": "الِاسْتِثْمَارُ", "transliteration": "Al-Istithmar", "notes": "توظيف رأس المال في مشاريع منتجة لتحقيق نمو مستقبلي"},
        "german": {"article": "die", "word": "Investition", "plural": "die Investitionen", "gender": "feminine", "example": "Bildung ist die beste und sicherste Investition in die Zukunft."},
        "english": {"word": "investment", "phonetic": "/ɪnˈvest.mənt/", "example": "Strategic investment in renewable energy yields long-term returns."},
        "image_id": "img_eco_investition"
    },
    {
        "id": "eco_aktie",
        "category": "economy_finance",
        "arabic": {"word": "السَّهْمُ المَالِيُّ", "transliteration": "As-Sahm", "notes": "حصة ملكية في شركة مساهمة مطروحة للتداول"},
        "german": {"article": "die", "word": "Aktie", "plural": "die Aktien", "gender": "feminine", "example": "Der Kurs dieser Technologie-Aktie ist im letzten Jahr stark gestiegen."},
        "english": {"word": "share / stock", "phonetic": "/ʃeər/", "example": "She purchased shares in a promising green technology firm."},
        "image_id": "img_eco_aktie"
    },
    {
        "id": "eco_boerse",
        "category": "economy_finance",
        "arabic": {"word": "البُورْصَةُ / سُوقُ الأَسْهُمِ", "transliteration": "Al-Boorsah", "notes": "السوق المالي المنظم لتداول الأوراق المالية والأسهم"},
        "german": {"article": "die", "word": "Börse", "plural": "die Börsen", "gender": "feminine", "example": "An der Frankfurter Börse werden täglich Millionen Aktien gehandelt."},
        "english": {"word": "stock exchange", "phonetic": "/ˈstɒk ɪksˌtʃeɪndʒ/", "example": "Trading volume on the stock exchange surged this morning."},
        "image_id": "img_eco_boerse"
    },
    {
        "id": "eco_gewinn",
        "category": "economy_finance",
        "arabic": {"word": "الرِّبْحُ / العَائِدُ الصَّافِي", "transliteration": "Ar-Ribh", "notes": "الفائض المالي الإيجابي بعد خصم التكاليف"},
        "german": {"article": "der", "word": "Gewinn", "plural": "die Gewinne", "gender": "masculine", "example": "Die Firma erzielte im vergangenen Geschäftsjahr einen hohen Gewinn."},
        "english": {"word": "profit / net gain", "phonetic": "/ˈprɒf.ɪt/", "example": "The company reinvested its annual profit into research."},
        "image_id": "img_eco_gewinn"
    },
    {
        "id": "eco_verlust",
        "category": "economy_finance",
        "arabic": {"word": "الخَسَارَةُ المَالِيَّةُ", "transliteration": "Al-Khasarah", "notes": "نقصان رأس المال أو زيادة النفقات عن الإيرادات"},
        "german": {"article": "der", "word": "Verlust", "plural": "die Verluste", "gender": "masculine", "example": "Durch kluge Planung konnte das Unternehmen finanzielle Verluste vermeiden."},
        "english": {"word": "financial loss", "phonetic": "/lɒs/", "example": "Careful risk management prevented severe financial losses."},
        "image_id": "img_eco_verlust"
    },
    {
        "id": "eco_budget",
        "category": "economy_finance",
        "arabic": {"word": "المِيزَانِيَّةُ المَالِيَّةُ", "transliteration": "Al-Meezaniyyah", "notes": "الخطة التقديرية للإيرادات والمصروفات"},
        "german": {"article": "das", "word": "Budget", "plural": "die Budgets", "gender": "neuter", "example": "Für das neue Forschungsprojekt steht ein ausreichendes Budget bereit."},
        "english": {"word": "budget", "phonetic": "/ˈbʌdʒ.ɪt/", "example": "Sticking to a monthly household budget builds financial security."},
        "image_id": "img_eco_budget"
    },
    {
        "id": "eco_schuld",
        "category": "economy_finance",
        "arabic": {"word": "الدُّيُونُ / الِالْتِزَامَاتُ المَالِيَّةُ", "transliteration": "Ad-Duyoon", "notes": "المبالغ المستحقة السداد للغير (تُستعمل غالبًا بصيغة الجمع die Schulden)"},
        "german": {"article": "die", "word": "Schulden", "plural": "die Schulden", "gender": "plural", "example": "Er hat alle seine Bankkredite abbezahlt und hat nun keine Schulden mehr."},
        "english": {"word": "debt / liabilities", "phonetic": "/det/", "example": "Paying off high-interest debt is a smart financial priority."},
        "image_id": "img_eco_schuld"
    },
    {
        "id": "eco_kredit",
        "category": "economy_finance",
        "arabic": {"word": "القَرْضُ المَصْرِفِيُّ / التَّمْوِيلُ", "transliteration": "Al-Qard", "notes": "مبلغ مالي يمنحه البنك على أن يُردّ على أقساط"},
        "german": {"article": "der", "word": "Kredit", "plural": "die Kredite", "gender": "masculine", "example": "Die Familie nahm einen günstigen Kredit für den Hausbau auf."},
        "english": {"word": "loan / credit", "phonetic": "/ləʊn/", "example": "The small business secured a low-interest development loan."},
        "image_id": "img_eco_kredit"
    },
    {
        "id": "eco_waehrung",
        "category": "economy_finance",
        "arabic": {"word": "العُمْلَةُ النَّقْدِيَّةُ", "transliteration": "Al-'Umlah", "notes": "وحدة التبادل النقدي الرسمية للدولة كاليورو والدينار والدولار"},
        "german": {"article": "die", "word": "Währung", "plural": "die Währungen", "gender": "feminine", "example": "Der Euro ist die gemeinsame offizielle Währung vieler europäischer Länder."},
        "english": {"word": "currency", "phonetic": "/ˈkʌr.ən.si/", "example": "You can exchange foreign currency at the international airport."},
        "image_id": "img_eco_waehrung"
    },
    {
        "id": "eco_wechselkurs",
        "category": "economy_finance",
        "arabic": {"word": "سِعْرُ الصَّرْفِ", "transliteration": "Si'r As-Sarf", "notes": "قيمة عملة دولة ما مقابل عملة دولة أخرى"},
        "german": {"article": "der", "word": "Wechselkurs", "plural": "die Wechselkurse", "gender": "masculine", "example": "Vor der Auslandsreise prüfe ich den aktuellen Wechselkurs."},
        "english": {"word": "exchange rate", "phonetic": "/ɪksˈtʃeɪndʒ ˌreɪt/", "example": "Fluctuating exchange rates impact international travel costs."},
        "image_id": "img_eco_wechselkurs"
    },
    {
        "id": "eco_wohlstand",
        "category": "economy_finance",
        "arabic": {"word": "الثَّرْوَةُ / الرَّخَاءُ الِاقْتِصَادِيُّ", "transliteration": "Ar-Rakha'", "notes": "حالة الازدهار المادي وجودة المعيشة المرتفعة"},
        "german": {"article": "der", "word": "Wohlstand", "plural": "die Wohlstände", "gender": "masculine", "example": "Bildung, Frieden und Fleiß bilden die Grundlage für gesellschaftlichen Wohlstand."},
        "english": {"word": "prosperity / wealth", "phonetic": "/prɒsˈper.ə.ti/", "example": "Innovation and fair trade promote shared economic prosperity."},
        "image_id": "img_eco_wohlstand"
    },
    {
        "id": "eco_wettbewerb",
        "category": "economy_finance",
        "arabic": {"word": "المُنَافَسَةُ التِّجَارِيَّةُ", "transliteration": "Al-Munafasah", "notes": "التسابق بين الشركات لتقديم أفضل جودة وسعر"},
        "german": {"article": "der", "word": "Wettbewerb", "plural": "die Wettbewerbe", "gender": "masculine", "example": "Ein fairer Wettbewerb fördert die Qualität und senkt die Preise."},
        "english": {"word": "competition", "phonetic": "/ˌkɒm.pəˈtɪʃ.ən/", "example": "Healthy market competition drives continuous product innovation."},
        "image_id": "img_eco_wettbewerb"
    },
    {
        "id": "eco_angebot",
        "category": "economy_finance",
        "arabic": {"word": "العَرْضُ الِاقْتِصَادِيُّ", "transliteration": "Al-'Ard Al-Iqtisadi", "notes": "كمية السلع والخدمات المتاحة للبيع في السوق"},
        "german": {"article": "das", "word": "Angebot", "plural": "die Angebote", "gender": "neuter", "example": "Auf dem freien Markt regeln Angebot und Nachfrage den Preis."},
        "english": {"word": "economic supply", "phonetic": "/səˈplaɪ/", "example": "When supply exceeds demand, market prices generally fall."},
        "image_id": "img_eco_angebot"
    },
    {
        "id": "eco_nachfrage",
        "category": "economy_finance",
        "arabic": {"word": "الطَّلَبُ الِاقْتِصَادِيُّ", "transliteration": "At-Talab Al-Iqtisadi", "notes": "رغبة وقدرة المستهلكين على شراء سلعة معينة"},
        "german": {"article": "die", "word": "Nachfrage", "plural": "die Nachfragen", "gender": "feminine", "example": "Die Nachfrage nach Elektroautos und Solartechnik wächst weltweit."},
        "english": {"word": "economic demand", "phonetic": "/dɪˈmɑːnd/", "example": "Consumer demand for eco-friendly products is rising steadily."},
        "image_id": "img_eco_nachfrage"
    }
]

# حفظ ملف المفردات الجديد في content/vocabulary/economy_finance_a2.json
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/economy_finance_a2.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "economy_finance",
        "category_name": {
            "ar": "الاقتصاد والمال والتجارة العالمية",
            "de": "Wirtschaft, Finanzen & Welthandel",
            "en": "Economy, Finance & Global Trade"
        },
        "level": "A2",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم اقتصادية ومالية في {vocab_path}")

# 2. توليد 25 أيقونة SVG خفيفة ومتجهية (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "eco_wirtschaft": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#F57F17"/><rect x="26" y="55" width="10" height="20" fill="#FFF"/><rect x="42" y="42" width="10" height="33" fill="#FFF"/><rect x="58" y="28" width="10" height="47" fill="#FFF"/><path d="M24,50 L45,35 L65,22" stroke="#FFF9C4" stroke-width="4" fill="none" stroke-linecap="round"/></svg>',
    "eco_markt": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="42" width="60" height="40" rx="4" fill="#ECEFF1" stroke="#455A64" stroke-width="3"/><polygon points="15,42 25,22 75,22 85,42" fill="#E53935"/><circle cx="38" cy="62" r="8" fill="#FFB300"/><circle cx="62" cy="62" r="8" fill="#43A047"/></svg>',
    "eco_handel": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0288D1"/><path d="M28,40 L72,40 M60,30 L72,40 L60,50" stroke="#FFF" stroke-width="5" fill="none" stroke-linecap="round"/><path d="M72,60 L28,60 M40,50 L28,60 L40,70" stroke="#FFD54F" stroke-width="5" fill="none" stroke-linecap="round"/></svg>',
    "eco_export": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="40" width="50" height="40" rx="4" fill="#8D6E63"/><path d="M50,48 L50,16 M38,28 L50,16 L62,28" stroke="#2E7D32" stroke-width="6" fill="none" stroke-linecap="round" stroke-linejoin="round"/></svg>',
    "eco_import": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="45" width="50" height="38" rx="4" fill="#5D4037"/><path d="M50,14 L50,42 M38,30 L50,42 L62,30" stroke="#1565C0" stroke-width="6" fill="none" stroke-linecap="round" stroke-linejoin="round"/></svg>',
    "eco_bank": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,14 14,34 86,34" fill="#37474F"/><rect x="22" y="34" width="8" height="42" fill="#90A4AE"/><rect x="38" y="34" width="8" height="42" fill="#90A4AE"/><rect x="54" y="34" width="8" height="42" fill="#90A4AE"/><rect x="70" y="34" width="8" height="42" fill="#90A4AE"/><rect x="14" y="76" width="72" height="10" fill="#263238"/><circle cx="50" cy="26" r="4" fill="#FFD54F"/></svg>',
    "eco_bankkonto": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="16" y="28" width="68" height="44" rx="6" fill="#1565C0"/><rect x="16" y="36" width="68" height="10" fill="#0D47A1"/><rect x="24" y="54" width="14" height="10" rx="2" fill="#FFD54F"/><circle cx="68" cy="60" r="6" fill="#E53935"/><circle cx="74" cy="60" r="6" fill="#FFB300" opacity="0.8"/></svg>',
    "eco_ueberweisung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00897B"/><rect x="24" y="34" width="36" height="24" rx="3" fill="#FFF"/><path d="M48,58 L76,58 M66,48 L76,58 L66,68" stroke="#FFD54F" stroke-width="6" fill="none" stroke-linecap="round" stroke-linejoin="round"/></svg>',
    "eco_zins": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#43A047"/><line x1="32" y1="68" x2="68" y2="32" stroke="#FFF" stroke-width="6" stroke-linecap="round"/><circle cx="36" cy="36" r="7" fill="none" stroke="#FFD54F" stroke-width="5"/><circle cx="64" cy="64" r="7" fill="none" stroke="#FFD54F" stroke-width="5"/></svg>',
    "eco_steuer": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="16" width="56" height="68" rx="4" fill="#ECEFF1" stroke="#455A64" stroke-width="3"/><text x="50" y="44" font-family="sans-serif" font-weight="bold" font-size="16" fill="#C62828" text-anchor="middle">TAX</text><line x1="32" y1="54" x2="68" y2="54" stroke="#78909C" stroke-width="3"/><line x1="32" y1="64" x2="56" y2="64" stroke="#78909C" stroke-width="3"/></svg>',
    "eco_inflation": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#D32F2F"/><path d="M24,68 L44,48 L56,56 L76,28 M62,28 L76,28 L76,42" stroke="#FFF" stroke-width="6" fill="none" stroke-linecap="round" stroke-linejoin="round"/><circle cx="34" cy="36" r="8" fill="#FFD54F"/></svg>',
    "eco_investition": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="68" r="14" fill="#FFA000"/><path d="M50,54 L50,24" stroke="#2E7D32" stroke-width="6" stroke-linecap="round"/><path d="M50,40 Q30,30 34,18 Q50,22 50,40 Z" fill="#43A047"/><path d="M50,34 Q70,24 66,12 Q50,16 50,34 Z" fill="#66BB6A"/></svg>',
    "eco_aktie": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="16" y="22" width="68" height="56" rx="4" fill="#1A237E"/><path d="M24,62 L38,46 L52,54 L66,32 L78,38" stroke="#00E676" stroke-width="5" fill="none" stroke-linecap="round" stroke-linejoin="round"/><circle cx="66" cy="32" r="4" fill="#FFD54F"/></svg>',
    "eco_boerse": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="14" y="18" width="72" height="64" rx="6" fill="#263238"/><line x1="28" y1="30" x2="28" y2="70" stroke="#00E676" stroke-width="3"/><rect x="24" y="40" width="8" height="20" fill="#00E676"/><line x1="50" y1="26" x2="50" y2="66" stroke="#FF5252" stroke-width="3"/><rect x="46" y="36" width="8" height="22" fill="#FF5252"/><line x1="72" y1="24" x2="72" y2="68" stroke="#00E676" stroke-width="3"/><rect x="68" y="32" width="8" height="24" fill="#00E676"/></svg>',
    "eco_gewinn": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#2E7D32"/><path d="M26,64 L44,44 L56,52 L74,30 M60,30 L74,30 L74,44" stroke="#FFD54F" stroke-width="6" fill="none" stroke-linecap="round" stroke-linejoin="round"/></svg>',
    "eco_verlust": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#C62828"/><path d="M26,32 L44,52 L56,44 L74,68 M60,68 L74,68 L74,54" stroke="#FFF" stroke-width="6" fill="none" stroke-linecap="round" stroke-linejoin="round"/></svg>',
    "eco_budget": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="36" fill="#1E88E5"/><path d="M50,50 L50,14 A36,36 0 0,1 86,50 Z" fill="#FFB300"/><path d="M50,50 L86,50 A36,36 0 0,1 50,86 Z" fill="#43A047"/></svg>',
    "eco_schuld": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="56" r="26" fill="#455A64"/><rect x="44" y="22" width="12" height="10" fill="#37474F"/><path d="M36,56 L64,56" stroke="#FF5252" stroke-width="6" stroke-linecap="round"/></svg>',
    "eco_kredit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="36" r="16" fill="#FFD54F"/><text x="50" y="42" font-family="sans-serif" font-weight="bold" font-size="16" fill="#E65100" text-anchor="middle">€</text><path d="M24,66 C34,58 66,58 76,66 L70,76 L30,76 Z" fill="#1565C0"/></svg>',
    "eco_waehrung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="38" cy="40" r="20" fill="#FFB300"/><text x="38" y="47" font-family="sans-serif" font-weight="bold" font-size="18" fill="#FFF" text-anchor="middle">€</text><circle cx="64" cy="62" r="20" fill="#00897B"/><text x="64" y="69" font-family="sans-serif" font-weight="bold" font-size="18" fill="#FFF" text-anchor="middle">$</text></svg>',
    "eco_wechselkurs": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#5E35B1"/><path d="M30,38 L70,38 M60,28 L70,38 L60,48" stroke="#FFD54F" stroke-width="5" fill="none" stroke-linecap="round"/><path d="M70,62 L30,62 M40,52 L30,62 L40,72" stroke="#FFF" stroke-width="5" fill="none" stroke-linecap="round"/></svg>',
    "eco_wohlstand": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="30,28 70,28 84,48 50,84 16,48" fill="#00BCD4"/><polygon points="30,28 50,48 70,28" fill="#80DEEA"/><circle cx="50" cy="20" r="4" fill="#FFD54F"/></svg>',
    "eco_wettbewerb": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="58" width="20" height="24" fill="#90A4AE"/><rect x="40" y="40" width="20" height="42" fill="#FFB300"/><rect x="62" y="50" width="20" height="32" fill="#B0BEC5"/><polygon points="50,16 54,26 64,26 56,32 59,42 50,36 41,42 44,32 36,26 46,26" fill="#E65100"/></svg>',
    "eco_angebot": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="48" width="26" height="28" rx="3" fill="#FFA000"/><rect x="54" y="48" width="26" height="28" rx="3" fill="#FFA000"/><rect x="37" y="22" width="26" height="26" rx="3" fill="#FFB300"/></svg>',
    "eco_nachfrage": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="32" cy="64" r="10" fill="#1565C0"/><circle cx="50" cy="64" r="10" fill="#1E88E5"/><circle cx="68" cy="64" r="10" fill="#42A5F5"/><path d="M50,46 L50,20 M40,30 L50,20 L60,30" stroke="#E53935" stroke-width="6" fill="none" stroke-linecap="round" stroke-linejoin="round"/></svg>'
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
            "description": f"Vector illustration for economy concept: {c['english']['word']}"
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
    
    if "economy_finance_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/architecture_housing_a2.json',",
            "'assets/content/vocabulary/architecture_housing_a2.json',\n    'assets/content/vocabulary/economy_finance_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط economy_finance_a2.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "economy_finance" not in cat_code:
        entry = """    CategoryMeta(
      id: 'economy_finance',
      titleAr: 'الاقتصاد والمال والتجارة',
      titleDe: 'Wirtschaft & Finanzen',
      titleEn: 'Economy & Finance',
      icon: Icons.trending_up_rounded,
      primaryColor: Color(0xFFF57F17),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم الاقتصاد والمال في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 28", "TOTAL_VOCAB_CATEGORIES = 29")
    val_code = val_code.replace("TOTAL_CONCEPTS = 705", "TOTAL_CONCEPTS = 730")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 845", "TOTAL_SVG_ASSETS = 870")
    
    if "economy_finance_a2.json" not in val_code:
        val_code = val_code.replace(
            "'architecture_housing_a2.json',",
            "'architecture_housing_a2.json',\n    'economy_finance_a2.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (29 فئة، 730 مفهومًا، 870 أصلًا متجهيًا)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 050 Status (Completed - GOLDEN JUBILEE MILESTONE 🌟)
- **Feature:** Category 29: Economy, Finance & Global Trade (`economy_finance_a2.json`).
- **New Concepts:** 25 trilingual vocabulary items for markets, banking, stocks, inflation, taxes, supply & demand.
- **New Visuals:** 25 unique lightweight SVG vectors (`eco_*.svg`).
- **GOLDEN JUBILEE LANDMARK (50 Cumulative Cycles):**
  - 29 Vocabulary Categories.
  - 730 Core Vocabulary Concepts.
  - 35 Base Verbs | 15 Perfekt Forms.
  - 70 Syntax Exercises (Sentence Builder).
  - 24 Prepositions | 5 Dialogues.
  - 8 Comprehensive Grammar Engines.
  - 870 Total SVG Vector Icons.
- **Integration:** Active in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق اليوبيل الذهبي (الدورة 050) في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 050 بنجاح تام!")
