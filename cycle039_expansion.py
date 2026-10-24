import json
import os

print("🚀 [CYCLE 039] بدء بناء قسم السياسة والقانون والمجتمع (Politics & Law - A2)...")

# 1. قائمة الـ 25 مفهومًا لقسم السياسة والقانون والمجتمع
concepts = [
    {
        "id": "pol_politik",
        "category": "politics_law",
        "arabic": {"word": "السِّيَاسَةُ", "transliteration": "As-Siyasah", "notes": "علم إدارة شؤون الدولة والمجتمع"},
        "german": {"article": "die", "word": "Politik", "plural": "die Politiken", "gender": "feminine", "example": "Er interessiert sich seit seiner Jugend für internationale Politik."},
        "english": {"word": "politics", "phonetic": "/ˈpɒl.ə.tɪks/", "example": "She has been actively engaged in local politics for years."},
        "image_id": "img_pol_politik"
    },
    {
        "id": "pol_regierung",
        "category": "politics_law",
        "arabic": {"word": "الحُكُومَةُ", "transliteration": "Al-Hukoomah", "notes": "الهيئة التنفيذية العليا للدولة"},
        "german": {"article": "die", "word": "Regierung", "plural": "die Regierungen", "gender": "feminine", "example": "Die Regierung beschließt neue Maßnahmen zur wirtschaftlichen Förderung."},
        "english": {"word": "government", "phonetic": "/ˈɡʌv.ən.mənt/", "example": "The federal government announced new educational reforms."},
        "image_id": "img_pol_regierung"
    },
    {
        "id": "pol_parlament",
        "category": "politics_law",
        "arabic": {"word": "البَرْلَمَانُ / مَجْلِسُ النُّوَّابِ", "transliteration": "Al-Barlaman", "notes": "المؤسسة التشريعية المنتخبة من الشعب"},
        "german": {"article": "das", "word": "Parlament", "plural": "die Parlamente", "gender": "neuter", "example": "Die Abgeordneten debattieren im Parlament über das neue Gesetz."},
        "english": {"word": "parliament", "phonetic": "/ˈpɑː.lɪ.mənt/", "example": "Members of parliament debated the national budget today."},
        "image_id": "img_pol_parlament"
    },
    {
        "id": "pol_demokratie",
        "category": "politics_law",
        "arabic": {"word": "الدِّيمُقْرَاطِيَّةُ", "transliteration": "Ad-Deemuqratiyyah", "notes": "حكم الشعب بالشعب عبر سيادة القانون والتعددية"},
        "german": {"article": "die", "word": "Demokratie", "plural": "die Demokratien", "gender": "feminine", "example": "Freie Meinungsäußerung ist ein tragender Pfeiler der Demokratie."},
        "english": {"word": "democracy", "phonetic": "/dɪˈmɒk.rə.si/", "example": "Democratic participation empowers citizens across the country."},
        "image_id": "img_pol_demokratie"
    },
    {
        "id": "pol_wahl",
        "category": "politics_law",
        "arabic": {"word": "الِانْتِخَابَاتُ", "transliteration": "Al-Intikhabat", "notes": "عملية اختيار ممثلي الشعب الدورية"},
        "german": {"article": "die", "word": "Wahl", "plural": "die Wahlen", "gender": "feminine", "example": "Am Sonntag findet die demokratische Parlamentswahl statt."},
        "english": {"word": "election", "phonetic": "/iˈlek.ʃən/", "example": "Voter turnout at the general election was exceptionally high."},
        "image_id": "img_pol_wahl"
    },
    {
        "id": "pol_abstimmung",
        "category": "politics_law",
        "arabic": {"word": "التَّصْوِيتُ / الإِدْلَاءُ بِالصَّوْتِ", "transliteration": "At-Tasweet", "notes": "ممارسة حق الاختيار في صندوق الاقتراع"},
        "german": {"article": "die", "word": "Abstimmung", "plural": "die Abstimmungen", "gender": "feminine", "example": "Die Bürger nehmen zahlreich an der geheimen Abstimmung teil."},
        "english": {"word": "vote / ballot", "phonetic": "/vəʊt/", "example": "Every eligible citizen is encouraged to cast their vote."},
        "image_id": "img_pol_abstimmung"
    },
    {
        "id": "pol_gesetz",
        "category": "politics_law",
        "arabic": {"word": "القَانُونُ", "transliteration": "Al-Qanoon", "notes": "القاعدة التشريعية الملزمة للجميع"},
        "german": {"article": "das", "word": "Gesetz", "plural": "die Gesetze", "gender": "neuter", "example": "Vor dem Gesetz sind alle Menschen vollkommen gleich."},
        "english": {"word": "law", "phonetic": "/lɔː/", "example": "All citizens must abide by the rule of law."},
        "image_id": "img_pol_gesetz"
    },
    {
        "id": "pol_verfassung",
        "category": "politics_law",
        "arabic": {"word": "الدُّسْتُورُ / القَانُونُ الأَسَاسِيُّ", "transliteration": "Ad-Dustoor", "notes": "القانون الأسمى الذي يحدد شكل الدولة وحقوق مواطنيها"},
        "german": {"article": "die", "word": "Verfassung", "plural": "die Verfassungen", "gender": "feminine", "example": "Das Grundgesetz ist die Verfassung der Bundesrepublik Deutschland."},
        "english": {"word": "constitution", "phonetic": "/ˌkɒn.stɪˈtʃuː.ʃən/", "example": "The constitution guarantees fundamental individual rights."},
        "image_id": "img_pol_verfassung"
    },
    {
        "id": "pol_gericht",
        "category": "politics_law",
        "arabic": {"word": "المَحْكَمَةُ", "transliteration": "Al-Mahkamah", "notes": "دار القضاء وفصل النزاعات بحياد"},
        "german": {"article": "das", "word": "Gericht", "plural": "die Gerichte", "gender": "neuter", "example": "Der Fall wird morgen vor dem zuständigen Gericht verhandelt."},
        "english": {"word": "court of law", "phonetic": "/kɔːt/", "example": "The civil case was heard before the district court."},
        "image_id": "img_pol_gericht"
    },
    {
        "id": "pol_richter",
        "category": "politics_law",
        "arabic": {"word": "القَاضِي", "transliteration": "Al-Qadi", "notes": "المسؤول عن إصدار الأحكام القضائية النزيهة"},
        "german": {"article": "der", "word": "Richter", "plural": "die Richter", "gender": "masculine", "example": "Der erfahrene Richter fällte ein faires und begründetes Urteil."},
        "english": {"word": "judge", "phonetic": "/dʒʌdʒ/", "example": "The presiding judge examined all the forensic evidence."},
        "image_id": "img_pol_richter"
    },
    {
        "id": "pol_anwalt",
        "category": "politics_law",
        "arabic": {"word": "المُحَامِي", "transliteration": "Al-Muhami", "notes": "المدافع القانوني عن حقوق الأفراد أمام القضاء"},
        "german": {"article": "der", "word": "Anwalt", "plural": "die Anwälte", "gender": "masculine", "example": "Der Anwalt berät seinen Mandanten in allen Rechtsfragen."},
        "english": {"word": "lawyer / attorney", "phonetic": "/ˈlɔɪ.ər/", "example": "She consulted an experienced lawyer before signing the contract."},
        "image_id": "img_pol_anwalt"
    },
    {
        "id": "pol_buerger",
        "category": "politics_law",
        "arabic": {"word": "المُواطِنُ", "transliteration": "Al-Muwatin", "notes": "عضو المجتمع الذي يتمتع بحقوق ويتحمل واجبات"},
        "german": {"article": "der", "word": "Bürger", "plural": "die Bürger", "gender": "masculine", "example": "Engagierte Bürger beteiligen sich aktiv an der Stadtentwicklung."},
        "english": {"word": "citizen", "phonetic": "/ˈsɪt.ɪ.zən/", "example": "Every active citizen contributes to a thriving society."},
        "image_id": "img_pol_buerger"
    },
    {
        "id": "pol_staatsbuergerschaft",
        "category": "politics_law",
        "arabic": {"word": "الجِنْسِيَّةُ / المُواطَنَةُ", "transliteration": "Al-Jinsiyyah", "notes": "الرابطة القانونية والسياسية بين الفرد والدولة"},
        "german": {"article": "die", "word": "Staatsbürgerschaft", "plural": "die Staatsbürgerschaften", "gender": "feminine", "example": "Nach mehreren Jahren erfolgreicher Integration erhielt er die Staatsbürgerschaft."},
        "english": {"word": "citizenship / nationality", "phonetic": "/ˈsɪt.ɪ.zən.ʃɪp/", "example": "He proudly received his citizenship certificate today."},
        "image_id": "img_pol_staatsbuergerschaft"
    },
    {
        "id": "pol_recht",
        "category": "politics_law",
        "arabic": {"word": "الحَقُّ القَانُونِيُّ", "transliteration": "Al-Haqq", "notes": "الامتياز أو الحماية التي يضمنها القانون للفرد"},
        "german": {"article": "das", "word": "Recht", "plural": "die Rechte", "gender": "neuter", "example": "Jedes Kind hat das fundamentale Recht auf Bildung und Schutz."},
        "english": {"word": "right / legal right", "phonetic": "/raɪt/", "example": "Access to education is a universal human right."},
        "image_id": "img_pol_recht"
    },
    {
        "id": "pol_pflicht",
        "category": "politics_law",
        "arabic": {"word": "الوَاجِبُ المَدَنِيُّ", "transliteration": "Al-Wajib", "notes": "المسؤولية الأخلاقية أو القانونية تجاه المجتمع"},
        "german": {"article": "die", "word": "Pflicht", "plural": "die Pflichten", "gender": "feminine", "example": "Steuern zu zahlen ist eine gesetzliche Pflicht aller Einwohner."},
        "english": {"word": "duty / civic obligation", "phonetic": "/ˈdʒuː.ti/", "example": "Voting is both a cherished right and a civic duty."},
        "image_id": "img_pol_pflicht"
    },
    {
        "id": "pol_freiheit",
        "category": "politics_law",
        "arabic": {"word": "الحُرِّيَّةُ", "transliteration": "Al-Hurriyyah", "notes": "القدرة على التفكير والتعبير والتصرف بوعي ومسؤولية"},
        "german": {"article": "die", "word": "Freiheit", "plural": "die Freiheiten", "gender": "feminine", "example": "Freiheit und Gerechtigkeit sind die höchsten Werte des Zusammenlebens."},
        "english": {"word": "freedom / liberty", "phonetic": "/ˈfriː.dəm/", "example": "Freedom of thought is protected by international charters."},
        "image_id": "img_pol_freiheit"
    },
    {
        "id": "pol_gerechtigkeit",
        "category": "politics_law",
        "arabic": {"word": "العَدَالَةُ / الإِنْصَافُ", "transliteration": "Al-'Adalah", "notes": "إعطاء كل ذي حق حقه دون تمييز"},
        "german": {"article": "die", "word": "Gerechtigkeit", "plural": "die Gerechtigkeiten", "gender": "feminine", "example": "Soziale Gerechtigkeit stärkt den Frieden innerhalb der Gesellschaft."},
        "english": {"word": "justice / fairness", "phonetic": "/ˈdʒʌs.tɪs/", "example": "True social justice ensures equal opportunities for everyone."},
        "image_id": "img_pol_gerechtigkeit"
    },
    {
        "id": "pol_frieden",
        "category": "politics_law",
        "arabic": {"word": "السَّلَامُ / الطُّمَأْنِينَةُ", "transliteration": "As-Salam", "notes": "حالة الأمن والوئام وغياب النزاعات المسلحة"},
        "german": {"article": "der", "word": "Frieden", "plural": "die Frieden", "gender": "masculine", "example": "Diplomatie ist der beste Weg, um dauerhaften Frieden zu sichern."},
        "english": {"word": "peace", "phonetic": "/piːs/", "example": "Diplomatic dialogue remains essential to lasting global peace."},
        "image_id": "img_pol_frieden"
    },
    {
        "id": "pol_praesident",
        "category": "politics_law",
        "arabic": {"word": "رَئِيسُ الدَّوْلَةِ", "transliteration": "Ra'ees Ad-Dawlah", "notes": "الرأس الدستوري الأعلى للجمهورية"},
        "german": {"article": "der", "word": "Präsident", "plural": "die Präsidenten", "gender": "masculine (n-Deklination)", "example": "Der Bundespräsident vertritt das Land völkerrechtlich."},
        "english": {"word": "president", "phonetic": "/ˈprez.ɪ.dənt/", "example": "The president addressed the nation in a live speech."},
        "image_id": "img_pol_praesident"
    },
    {
        "id": "pol_kanzler",
        "category": "politics_law",
        "arabic": {"word": "المُسْتَشَارُ (رَئِيسُ الحُكُومَةِ)", "transliteration": "Al-Mustashar", "notes": "رئيس مجلس الوزراء في ألمانيا والنمسا"},
        "german": {"article": "der", "word": "Kanzler", "plural": "die Kanzler", "gender": "masculine", "example": "Der Bundeskanzler bestimmt die allgemeinen Richtlinien der Politik."},
        "english": {"word": "chancellor / prime minister", "phonetic": "/ˈtʃɑːn.səl.ər/", "example": "The federal chancellor met with fellow European leaders."},
        "image_id": "img_pol_kanzler"
    },
    {
        "id": "pol_staat",
        "category": "politics_law",
        "arabic": {"word": "الدَّوْلَةُ", "transliteration": "Ad-Dawlah", "notes": "الكيان السياسي والقانوني ذو السيادة على إقليم وشعب"},
        "german": {"article": "der", "word": "Staat", "plural": "die Staaten", "gender": "masculine", "example": "Der Staat schützt die Sicherheit und das Wohl seiner Bürger."},
        "english": {"word": "state / nation", "phonetic": "/steɪt/", "example": "The modern sovereign state provides essential infrastructure."},
        "image_id": "img_pol_staat"
    },
    {
        "id": "pol_gesellschaft",
        "category": "politics_law",
        "arabic": {"word": "المُجْتَمَعُ", "transliteration": "Al-Mujtama'", "notes": "مجموع الأفراد المترابطين بنظام وعلاقات مشتركة"},
        "german": {"article": "die", "word": "Gesellschaft", "plural": "die Gesellschaften", "gender": "feminine", "example": "Eine offene Gesellschaft zeichnet sich durch Toleranz und Respekt aus."},
        "english": {"word": "society", "phonetic": "/səˈsaɪ.ə.ti/", "example": "A cohesive society values cultural inclusion and cooperation."},
        "image_id": "img_pol_gesellschaft"
    },
    {
        "id": "pol_menschenrechte",
        "category": "politics_law",
        "arabic": {"word": "حُقُوقُ الإِنْسَانِ", "transliteration": "Huqooq Al-Insan", "notes": "الحقوق الطبيعية الأصيلة لكل إنسان في العالم"},
        "german": {"article": "die", "word": "Menschenrechte", "plural": "die Menschenrechte", "gender": "plural", "example": "Die Achtung der Menschenrechte ist für alle Staaten verbindlich."},
        "english": {"word": "human rights", "phonetic": "/ˌhjuː.mən ˈraɪts/", "example": "Universal human rights safeguard dignity across the globe."},
        "image_id": "img_pol_menschenrechte"
    },
    {
        "id": "pol_vertrag",
        "category": "politics_law",
        "arabic": {"word": "المُعَاهَدَةُ / الِاتِّفَاقِيَّةُ الدَّوْلِيَّةُ", "transliteration": "Al-Mu'ahadah", "notes": "اتفاق رسمي ملزم بين دولتين أو أكثر"},
        "german": {"article": "der", "word": "Vertrag", "plural": "die Verträge", "gender": "masculine", "example": "Die Staaten unterzeichneten einen historischen internationalen Vertrag."},
        "english": {"word": "treaty / international agreement", "phonetic": "/ˈtriː.ti/", "example": "The bilateral trade treaty was signed by both ministers."},
        "image_id": "img_pol_vertrag"
    },
    {
        "id": "pol_solidaritaet",
        "category": "politics_law",
        "arabic": {"word": "التَّضَامُنُ / التَّكَافُلُ", "transliteration": "At-Tadamun", "notes": "التعاون المتبادل ونصرة الآخرين وقت الشدائد"},
        "german": {"article": "die", "word": "Solidarität", "plural": "die Solidaritäten", "gender": "feminine", "example": "In Krisenzeiten beweisen die Menschen große gegenseitige Solidarität."},
        "english": {"word": "solidarity", "phonetic": "/ˌsɒl.ɪˈdær.ə.ti/", "example": "International solidarity is vital when responding to natural crises."},
        "image_id": "img_pol_solidaritaet"
    }
]

# حفظ ملف المفردات الجديد في content/vocabulary/politics_law_a2.json
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/politics_law_a2.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "politics_law",
        "category_name": {
            "ar": "السياسة والقانون والمجتمع",
            "de": "Politik, Recht & Gesellschaft",
            "en": "Politics, Law & Society"
        },
        "level": "A2",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم مدنية وقانونية في {vocab_path}")

# 2. توليد 25 أيقونة SVG خفيفة ومتجهية (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "pol_politik": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,15 20,35 80,35" fill="#37474F"/><rect x="25" y="35" width="8" height="42" fill="#78909C"/><rect x="40" y="35" width="8" height="42" fill="#78909C"/><rect x="52" y="35" width="8" height="42" fill="#78909C"/><rect x="67" y="35" width="8" height="42" fill="#78909C"/><rect x="18" y="77" width="64" height="10" fill="#455A64"/><circle cx="50" cy="27" r="4" fill="#FFD54F"/></svg>',
    "pol_regierung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="35" width="70" height="48" rx="4" fill="#455A64"/><polygon points="50,14 10,35 90,35" fill="#C62828"/><rect x="42" y="52" width="16" height="31" fill="#FFD54F"/><circle cx="50" cy="44" r="5" fill="#FFF"/><rect x="23" y="45" width="12" height="15" fill="#B0BEC5"/><rect x="65" y="45" width="12" height="15" fill="#B0BEC5"/></svg>',
    "pol_parlament": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M20,75 A35,35 0 0,1 80,75" stroke="#1565C0" stroke-width="8" fill="none" stroke-linecap="round"/><circle cx="30" cy="55" r="4" fill="#FFB300"/><circle cx="43" cy="45" r="4" fill="#FFB300"/><circle cx="57" cy="45" r="4" fill="#FFB300"/><circle cx="70" cy="55" r="4" fill="#FFB300"/><rect x="45" y="65" width="10" height="16" fill="#37474F"/></svg>',
    "pol_demokratie": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1E88E5"/><circle cx="35" cy="42" r="8" fill="#FFF"/><circle cx="65" cy="42" r="8" fill="#FFF"/><circle cx="50" cy="65" r="8" fill="#FFF"/><path d="M35,42 L65,42 L50,65 Z" stroke="#FFD54F" stroke-width="3" fill="none"/></svg>',
    "pol_wahl": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="42" width="56" height="45" rx="4" fill="#37474F"/><rect x="35" y="20" width="30" height="30" fill="#FFF" stroke="#1565C0" stroke-width="3"/><path d="M42,35 L47,40 L58,28" stroke="#4CAF50" stroke-width="4" fill="none" stroke-linecap="round"/><line x1="32" y1="42" x2="68" y2="42" stroke="#B0BEC5" stroke-width="4"/></svg>',
    "pol_abstimmung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#43A047"/><path d="M30,52 L44,66 L72,36" fill="none" stroke="#FFF" stroke-width="8" stroke-linecap="round"/><circle cx="72" cy="25" r="5" fill="#FFEB3B"/></svg>',
    "pol_gesetz": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="16" width="50" height="68" rx="4" fill="#ECEFF1" stroke="#455A64" stroke-width="3"/><line x1="35" y1="30" x2="65" y2="30" stroke="#37474F" stroke-width="4"/><line x1="35" y1="42" x2="65" y2="42" stroke="#78909C" stroke-width="3"/><line x1="35" y1="52" x2="65" y2="52" stroke="#78909C" stroke-width="3"/><line x1="35" y1="62" x2="55" y2="62" stroke="#78909C" stroke-width="3"/><circle cx="65" cy="70" r="8" fill="#C62828"/></svg>',
    "pol_verfassung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="15" width="56" height="70" rx="5" fill="#8D6E63" stroke="#4E342E" stroke-width="4"/><rect x="28" y="24" width="44" height="52" rx="2" fill="#FFF8E1"/><polygon points="50,35 53,42 60,42 55,47 57,54 50,50 43,54 45,47 40,42 47,42" fill="#FFD54F"/><line x1="36" y1="62" x2="64" y2="62" stroke="#8D6E63" stroke-width="3"/></svg>',
    "pol_gericht": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><line x1="50" y1="20" x2="50" y2="78" stroke="#37474F" stroke-width="5"/><line x1="20" y1="35" x2="80" y2="35" stroke="#37474F" stroke-width="5"/><rect x="35" y="78" width="30" height="8" rx="2" fill="#37474F"/><path d="M20,35 L12,58 Q20,64 28,58 Z" fill="#FFA000"/><path d="M80,35 L72,58 Q80,64 88,58 Z" fill="#FFA000"/><circle cx="50" cy="20" r="5" fill="#C62828"/></svg>',
    "pol_richter": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="35,30 65,30 65,45 35,45" fill="#795548" transform="rotate(-35 50 40)"/><rect x="46" y="38" width="8" height="42" rx="3" fill="#5D4037" transform="rotate(-35 50 40)"/><rect x="25" y="75" width="50" height="12" rx="3" fill="#37474F"/></svg>',
    "pol_anwalt": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="28" r="14" fill="#FFA726"/><path d="M26,80 C26,56 74,56 74,80 Z" fill="#263238"/><polygon points="46,42 54,42 58,62 50,70 42,62" fill="#FFF"/><polygon points="48,50 52,50 54,65 50,72 46,65" fill="#C62828"/></svg>',
    "pol_buerger": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="30" r="14" fill="#FFA726"/><path d="M28,82 C28,58 72,58 72,82 Z" fill="#1565C0"/><circle cx="70" cy="55" r="12" fill="#4CAF50"/><path d="M66,55 L69,58 L75,52" stroke="#FFF" stroke-width="2.5" fill="none"/></svg>',
    "pol_staatsbuergerschaft": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="16" width="56" height="68" rx="5" fill="#1A237E"/><circle cx="50" cy="42" r="14" fill="#FFD700"/><ellipse cx="50" cy="42" rx="6" ry="14" stroke="#1A237E" stroke-width="2" fill="none"/><line x1="36" y1="42" x2="64" y2="42" stroke="#1A237E" stroke-width="2"/><rect x="32" y="65" width="36" height="6" rx="2" fill="#FFF"/></svg>',
    "pol_recht": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M50,15 L80,28 C80,62 50,85 50,85 C50,85 20,62 20,28 Z" fill="#1565C0"/><circle cx="50" cy="48" r="16" fill="#FFD54F"/><path d="M44,48 L48,52 L56,44" stroke="#1565C0" stroke-width="3" fill="none"/></svg>',
    "pol_pflicht": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#C62828"/><rect x="46" y="24" width="8" height="32" rx="3" fill="#FFF"/><circle cx="50" cy="68" r="5" fill="#FFF"/></svg>',
    "pol_freiheit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0288D1"/><path d="M30,65 C30,45 50,30 75,25 C65,50 60,70 30,65 Z" fill="#FFF"/><path d="M50,75 L50,55" stroke="#FFD54F" stroke-width="6" stroke-linecap="round"/></svg>',
    "pol_gerechtigkeit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#37474F"/><line x1="25" y1="40" x2="75" y2="40" stroke="#FFD54F" stroke-width="4"/><line x1="50" y1="25" x2="50" y2="75" stroke="#FFD54F" stroke-width="4"/><path d="M25,40 L18,58 Q25,62 32,58 Z" fill="#FFD54F"/><path d="M75,40 L68,58 Q75,62 82,58 Z" fill="#FFD54F"/></svg>',
    "pol_frieden": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#81D4FA"/><path d="M30,55 C35,40 55,30 70,35 C70,55 55,70 30,55 Z" fill="#FFF"/><circle cx="65" cy="38" r="3" fill="#0288D1"/><polygon points="70,38 78,35 74,42" fill="#FFA000"/><path d="M78,35 Q86,28 90,32" stroke="#4CAF50" stroke-width="2.5" fill="none"/></svg>',
    "pol_praesident": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="30" r="14" fill="#FFA726"/><path d="M26,80 C26,55 74,55 74,80 Z" fill="#1A237E"/><polygon points="46,42 54,42 58,60 50,66 42,60" fill="#FFF"/><polygon points="48,48 52,48 53,62 50,68 47,62" fill="#D32F2F"/><polygon points="50,10 53,18 62,18 55,23 57,31 50,26 43,31 45,23 38,18 47,18" fill="#FFD54F"/></svg>',
    "pol_kanzler": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="30" r="14" fill="#FFCC80"/><path d="M26,80 C26,55 74,55 74,80 Z" fill="#2E7D32"/><polygon points="46,42 54,42 56,58 50,64 44,58" fill="#FFF"/><circle cx="50" cy="70" r="5" fill="#FFB300"/></svg>',
    "pol_staat": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#283593"/><path d="M20,50 Q40,30 60,40 Q80,30 80,60 Q70,75 50,75 Q30,75 20,50 Z" fill="#43A047"/><circle cx="50" cy="50" r="6" fill="#FFD54F"/></svg>',
    "pol_gesellschaft": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="30" cy="40" r="10" fill="#E91E63"/><circle cx="50" cy="30" r="10" fill="#0288D1"/><circle cx="70" cy="40" r="10" fill="#4CAF50"/><path d="M16,75 C16,60 44,60 44,75 Z" fill="#C2185B"/><path d="M36,75 C36,55 64,55 64,75 Z" fill="#01579B"/><path d="M56,75 C56,60 84,60 84,75 Z" fill="#2E7D32"/></svg>',
    "pol_menschenrechte": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00897B"/><path d="M30,55 C35,40 50,45 65,55 L75,45 C60,30 35,30 20,45 Z" fill="#FFF"/><circle cx="50" cy="30" r="10" fill="#FFD54F"/></svg>',
    "pol_vertrag": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="18" width="56" height="66" rx="4" fill="#FFF8E1" stroke="#8D6E63" stroke-width="3"/><line x1="32" y1="32" x2="68" y2="32" stroke="#5D4037" stroke-width="4"/><line x1="32" y1="44" x2="68" y2="44" stroke="#8D6E63" stroke-width="2.5"/><line x1="32" y1="54" x2="68" y2="54" stroke="#8D6E63" stroke-width="2.5"/><path d="M32,68 C40,64 50,72 60,66" stroke="#1565C0" stroke-width="3" fill="none"/><circle cx="68" cy="70" r="6" fill="#C62828"/></svg>',
    "pol_solidaritaet": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#D81B60"/><path d="M25,50 L45,50 M55,50 L75,50" stroke="#FFF" stroke-width="6" stroke-linecap="round"/><circle cx="50" cy="50" r="10" fill="#FFEB3B"/></svg>'
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
            "description": f"Vector illustration for politics and law concept: {c['english']['word']}"
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
    
    if "politics_law_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/wellness_fitness_a2.json',",
            "'assets/content/vocabulary/wellness_fitness_a2.json',\n    'assets/content/vocabulary/politics_law_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط politics_law_a2.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "politics_law" not in cat_code:
        entry = """    CategoryMeta(
      id: 'politics_law',
      titleAr: 'السياسة والقانون والمجتمع',
      titleDe: 'Politik, Recht & Gesellschaft',
      titleEn: 'Politics, Law & Society',
      icon: Icons.gavel_rounded,
      primaryColor: Color(0xFF37474F),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم السياسة والقانون في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 22", "TOTAL_VOCAB_CATEGORIES = 23")
    val_code = val_code.replace("TOTAL_CONCEPTS = 555", "TOTAL_CONCEPTS = 580")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 645", "TOTAL_SVG_ASSETS = 670")
    
    if "politics_law_a2.json" not in val_code:
        val_code = val_code.replace(
            "'wellness_fitness_a2.json',",
            "'wellness_fitness_a2.json',\n    'politics_law_a2.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (23 فئة، 580 مفهومًا، 670 أصلًا متجهيًا)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 039 Status (Completed - Level A2 Politics & Law Category)
- **Feature:** Category 23: Politics, Law & Society (`politics_law_a2.json`).
- **New Concepts:** 25 trilingual vocabulary items for democracy, law, constitution, elections, human rights, and citizenship.
- **New Visuals:** 25 unique lightweight SVG vectors (`pol_*.svg`).
- **Milestone Reached:** 23 Vocabulary Categories | 580 Core Concepts | 35 Base Verbs | 15 Perfekt Forms | 45 Syntax Exercises | 24 Prepositions | 5 Dialogues | Articles, Genitiv & Relative Clauses Engines | 670 Total SVG Icons.
- **Integration:** Active in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 039 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 039 بنجاح تام!")
