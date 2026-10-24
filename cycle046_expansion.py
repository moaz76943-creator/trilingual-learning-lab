import json
import os

print("🚀 [CYCLE 046] بدء بناء قسم الإعلام والصحافة والمعلومات (Media & Journalism - A2)...")

# 1. قائمة الـ 25 مفهومًا لقسم الإعلام والصحافة
concepts = [
    {
        "id": "med_journalismus",
        "category": "media_journalism",
        "arabic": {"word": "الصِّحَافَةُ / مِهْنَةُ الإِعْلَامِ", "transliteration": "As-Sihafah", "notes": "جمع الأخبار وتحليلها ونشرها للجماهير"},
        "german": {"article": "der", "word": "Journalismus", "plural": "die Journalismen", "gender": "masculine", "example": "Unabhängiger Journalismus ist unverzichtbar für eine freie Gesellschaft."},
        "english": {"word": "journalism", "phonetic": "/ˈdʒɜː.nə.lɪ.zəm/", "example": "Investigative journalism uncovers essential public facts."},
        "image_id": "img_med_journalismus"
    },
    {
        "id": "med_journalist",
        "category": "media_journalism",
        "arabic": {"word": "الصَّحَفِيُّ / الإِعْلَامِيُّ", "transliteration": "As-Sahafi", "notes": "المشتغل بجمع ونشر التقارير الإخبارية (يتبع N-Deklination)"},
        "german": {"article": "der", "word": "Journalist", "plural": "die Journalisten", "gender": "masculine (n-Deklination)", "example": "Der mutige Journalist berichtete direkt aus dem Krisengebiet."},
        "english": {"word": "journalist / reporter (male)", "phonetic": "/ˈdʒɜː.nə.lɪst/", "example": "The seasoned journalist verified every source thoroughly."},
        "image_id": "img_med_journalist"
    },
    {
        "id": "med_journalistin",
        "category": "media_journalism",
        "arabic": {"word": "الصَّحَفِيَّةُ / الإِعْلَامِيَّةُ", "transliteration": "As-Sahafiyyah", "notes": "المرأة المشتغلة بنقل الأخبار والتحقيقات"},
        "german": {"article": "die", "word": "Journalistin", "plural": "die Journalistinnen", "gender": "feminine", "example": "Die Journalistin führte ein exklusives Interview mit dem Minister."},
        "english": {"word": "journalist / reporter (female)", "phonetic": "/ˈdʒɜː.nə.lɪst/", "example": "The foreign correspondent conducted a comprehensive interview."},
        "image_id": "img_med_journalistin"
    },
    {
        "id": "med_presse",
        "category": "media_journalism",
        "arabic": {"word": "الصَّحَافَةُ المَطْبُوعَةُ / أَهْلُ القَلَمِ", "transliteration": "Al-Pressah", "notes": "المؤسسات الصحفية والوسائل الإخبارية"},
        "german": {"article": "die", "word": "Presse", "plural": "die Pressen", "gender": "feminine", "example": "Die internationale Presse berichtete ausführlich über den Gipfel."},
        "english": {"word": "press / news media", "phonetic": "/pres/", "example": "Freedom of the press is constitutionally safeguarded."},
        "image_id": "img_med_presse"
    },
    {
        "id": "med_pressekonferenz",
        "category": "media_journalism",
        "arabic": {"word": "المُؤْتَمَرُ الصَّحَفِيُّ", "transliteration": "Al-Mu'tamar As-Sahafi", "notes": "لقاء المسؤولين مع ممثلي وسائل الإعلام"},
        "german": {"article": "die", "word": "Pressekonferenz", "plural": "die Pressekonferenzen", "gender": "feminine", "example": "Auf der Pressekonferenz beantwortete die Sprecherin alle Fragen."},
        "english": {"word": "press conference", "phonetic": "/ˈpres ˌkɒn.fər.əns/", "example": "Reporters gathered eagerly for the emergency press conference."},
        "image_id": "img_med_pressekonferenz"
    },
    {
        "id": "med_schlagzeile",
        "category": "media_journalism",
        "arabic": {"word": "العُنْوَانُ الرَّئِيسِيُّ / المَانْشِيت", "transliteration": "Al-'Unwan Ar-Ra'eessi", "notes": "عنوان الخبر البارز بالخط العريض"},
        "german": {"article": "die", "word": "Schlagzeile", "plural": "die Schlagzeilen", "gender": "feminine", "example": "Die dramatische Schlagzeile auf der Titelseite erregte großes Aufsehen."},
        "english": {"word": "headline", "phonetic": "/ˈhed.laɪn/", "example": "The morning headline drew global attention to the treaty."},
        "image_id": "img_med_schlagzeile"
    },
    {
        "id": "med_bericht",
        "category": "media_journalism",
        "arabic": {"word": "التَّقْرِيرُ الإِخْبَارِيُّ", "transliteration": "At-Taqreer", "notes": "عرض تفصيلي للوقائع والأحداث"},
        "german": {"article": "der", "word": "Bericht", "plural": "die Berichte", "gender": "masculine", "example": "Ein fundierter Bericht beleuchtete die Hintergründe der Entscheidung."},
        "english": {"word": "news report", "phonetic": "/rɪˈpɔːt/", "example": "The investigative report examined the environmental impacts."},
        "image_id": "img_med_bericht"
    },
    {
        "id": "med_artikel",
        "category": "media_journalism",
        "arabic": {"word": "المَقَالُ الصَّحَفِيُّ", "transliteration": "Al-Maqal", "notes": "قطعة كتابية تحليلية في جريدة أو مجلة"},
        "german": {"article": "der", "word": "Artikel", "plural": "die Artikel", "gender": "masculine", "example": "Ich habe einen lesenswerten Artikel über künstliche Intelligenz gelesen."},
        "english": {"word": "article / column", "phonetic": "/ˈɑː.tɪ.kəl/", "example": "She wrote an insightful article for the weekend edition."},
        "image_id": "img_med_artikel"
    },
    {
        "id": "med_interview",
        "category": "media_journalism",
        "arabic": {"word": "الحِوَارُ الصَّحَفِيُّ / المُقَابَلَةُ", "transliteration": "Al-Hiwar As-Sahafi", "notes": "حوار إعلامي مسجل بين صحفي وشخصية"},
        "german": {"article": "das", "word": "Interview", "plural": "die Interviews", "gender": "neuter", "example": "Das aufschlussreiche Interview wurde im Fernsehen live übertragen."},
        "english": {"word": "media interview", "phonetic": "/ˈɪn.tə.vjuː/", "example": "The broadcast featured an exclusive live interview."},
        "image_id": "img_med_interview"
    },
    {
        "id": "med_sendung",
        "category": "media_journalism",
        "arabic": {"word": "البَرْنَامَجُ الإِعْلَامِيُّ / البَثُّ", "transliteration": "Al-Barnamaj", "notes": "المحتوى المذاع عبر التلفاز أو الراديو"},
        "german": {"article": "die", "word": "Sendung", "plural": "die Sendungen", "gender": "feminine", "example": "Die wöchentliche Kultursendung erfreut sich großer Beliebtheit."},
        "english": {"word": "broadcast / television program", "phonetic": "/ˈbrɔːd.kɑːst/", "example": "The documentary program airs prime-time every Thursday."},
        "image_id": "img_med_sendung"
    },
    {
        "id": "med_quelle",
        "category": "media_journalism",
        "arabic": {"word": "المَصْدَرُ الإِخْبَارِيُّ", "transliteration": "Al-Masdar", "notes": "الجهة أو الوثيقة التي يستقى منها الخبر"},
        "german": {"article": "die", "word": "Quelle", "plural": "die Quellen", "gender": "feminine", "example": "Seriöse Journalisten prüfen immer mindestens zwei unabhängige Quellen."},
        "english": {"word": "news source", "phonetic": "/sɔːs/", "example": "Reporters must protect confidential sources of information."},
        "image_id": "img_med_quelle"
    },
    {
        "id": "med_falschnachrichten",
        "category": "media_journalism",
        "arabic": {"word": "الأَخْبَارُ الزَّائِفَةُ / المُضَلِّلَةُ", "transliteration": "Al-Akhbar Az-Za'ifah", "notes": "المعلومات الكاذبة التي تنشر عمدًا للتضليل"},
        "german": {"article": "die", "word": "Falschnachrichten", "plural": "die Falschnachrichten", "gender": "plural", "example": "Faktenchecker decken Falschnachrichten in sozialen Netzwerken auf."},
        "english": {"word": "fake news / misinformation", "phonetic": "/feɪk njuːz/", "example": "Fact-checkers actively combat digital misinformation."},
        "image_id": "img_med_falschnachrichten"
    },
    {
        "id": "med_information",
        "category": "media_journalism",
        "arabic": {"word": "المَعْلُومَةُ", "transliteration": "Al-Ma'loomah", "notes": "البيانات الموثقة ذات الدلالة والفائدة"},
        "german": {"article": "die", "word": "Information", "plural": "die Informationen", "gender": "feminine", "example": "Der freie Zugang zu wahrhaftiger Information ist ein Bürgerrecht."},
        "english": {"word": "information", "phonetic": "/ˌɪn.fəˈmeɪ.ʃən/", "example": "Transparent public information strengthens civic trust."},
        "image_id": "img_med_information"
    },
    {
        "id": "med_pressefreiheit",
        "category": "media_journalism",
        "arabic": {"word": "حُرِّيَّةُ الصَّحَافَةِ", "transliteration": "Hurriyyat As-Sihafah", "notes": "حق الصحفيين في النشر دون رقابة أو ترهيب"},
        "german": {"article": "die", "word": "Pressefreiheit", "plural": "die Pressefreiheiten", "gender": "feminine", "example": "Die Pressefreiheit schützt Journalisten vor politischer Zensur."},
        "english": {"word": "freedom of the press", "phonetic": "/ˈfriː.dəm əv ðə pres/", "example": "Press freedom is a vital pillar of a healthy democracy."},
        "image_id": "img_med_pressefreiheit"
    },
    {
        "id": "med_redakteur",
        "category": "media_journalism",
        "arabic": {"word": "المُحَرِّرُ الصَّحَفِيُّ", "transliteration": "Al-Muharrir", "notes": "المسؤول عن تدقيق وصياغة المواد قبل النشر"},
        "german": {"article": "der", "word": "Redakteur", "plural": "die Redakteure", "gender": "masculine", "example": "Der leitende Redakteur korrigierte den Text vor der Drucklegung."},
        "english": {"word": "editor (male)", "phonetic": "/ˈed.ɪ.tər/", "example": "The senior editor reviewed the lead story before publishing."},
        "image_id": "img_med_redakteur"
    },
    {
        "id": "med_podcast",
        "category": "media_journalism",
        "arabic": {"word": "البُودْكَاسْت / التَّدْوِينُ الصَّوْتِيُّ", "transliteration": "Al-Podcast", "notes": "الملفات الصوتية الرقمية المتاحة عبر الإنترنت"},
        "german": {"article": "der", "word": "Podcast", "plural": "die Podcasts", "gender": "masculine", "example": "Ich höre auf dem Weg zur Arbeit täglich einen Bildungspodcast."},
        "english": {"word": "podcast", "phonetic": "/ˈpɒd.kɑːst/", "example": "The weekly history podcast reached a global listening audience."},
        "image_id": "img_med_podcast"
    },
    {
        "id": "med_sender",
        "category": "media_journalism",
        "arabic": {"word": "القَنَاةُ الإِعْلَامِيَّةُ / المَحَطَّةُ", "transliteration": "Al-Qanah", "notes": "المؤسسة الباثة للبرامج الإذاعية أو التلفزيونية"},
        "german": {"article": "der", "word": "Sender", "plural": "die Sender", "gender": "masculine", "example": "Der öffentlich-rechtliche Sender bietet verlässliche Nachrichten."},
        "english": {"word": "broadcasting channel / station", "phonetic": "/ˈbrɔːd.kɑːs.tɪŋ ˌtʃæn.əl/", "example": "The public broadcasting channel provides impartial news coverage."},
        "image_id": "img_med_sender"
    },
    {
        "id": "med_publikum",
        "category": "media_journalism",
        "arabic": {"word": "الجُمْهُورُ / المُتَلَقُّونَ", "transliteration": "Al-Jumhoor", "notes": "مجموع المتابعين والقراء والمشاهدين"},
        "german": {"article": "das", "word": "Publikum", "plural": "die Publika", "gender": "neuter", "example": "Das interessierte Publikum stellte nach dem Vortrag viele Fragen."},
        "english": {"word": "audience / viewers", "phonetic": "/ˈɔː.di.əns/", "example": "The live television debate engaged a diverse national audience."},
        "image_id": "img_med_publikum"
    },
    {
        "id": "med_auflage",
        "category": "media_journalism",
        "arabic": {"word": "عَدَدُ النُّسَخِ المَطْبُوعَةِ / التَّدَاوُلُ", "transliteration": "Al-'Ittlaq / Al-Mu'addal", "notes": "كمية النسخ الصادرة من المطبوعة"},
        "german": {"article": "die", "word": "Auflage", "plural": "die Auflagen", "gender": "feminine", "example": "Die überregionale Tageszeitung erscheint in hoher Auflage."},
        "english": {"word": "circulation / print run", "phonetic": "/ˌsɜː.kjəˈleɪ.ʃən/", "example": "The newspaper boasts the largest weekend print circulation."},
        "image_id": "img_med_auflage"
    },
    {
        "id": "med_livestream",
        "category": "media_journalism",
        "arabic": {"word": "البَثُّ الحَيُّ المُبَاشِرُ", "transliteration": "Al-Bath Al-Mubashir", "notes": "نقل الأحداث في لحظة وقوعها رقميًا"},
        "german": {"article": "der", "word": "Livestream", "plural": "die Livestreams", "gender": "masculine", "example": "Tausende Zuschauer verfolgten den spannenden Livestream im Internet."},
        "english": {"word": "live stream", "phonetic": "/ˈlaɪv.striːm/", "example": "Viewers tuned in to watch the press briefing live stream."},
        "image_id": "img_med_livestream"
    },
    {
        "id": "med_kommentar",
        "category": "media_journalism",
        "arabic": {"word": "التَّعْلِيقُ الصَّحَفِيُّ / الرَّأْيُ", "transliteration": "At-Ta'leeq", "notes": "رأي الصحفي وتحليله لحدث معين"},
        "german": {"article": "der", "word": "Kommentar", "plural": "die Kommentare", "gender": "masculine", "example": "Im meinungsstarken Kommentar analysierte sie die Wahlergebnisse."},
        "english": {"word": "commentary / editorial", "phonetic": "/ˈkɒm.ən.tər.i/", "example": "The editorial commentary offered a balanced political perspective."},
        "image_id": "img_med_kommentar"
    },
    {
        "id": "med_pr",
        "category": "media_journalism",
        "arabic": {"word": "العَلَاقَاتُ العَامَّةُ", "transliteration": "Al-'Alaqat Al-'Ammah", "notes": "إدارة التواصل وبناء الصورة الإيجابية للمؤسسة"},
        "german": {"article": "die", "word": "Öffentlichkeitsarbeit", "plural": "die Öffentlichkeitsarbeiten", "gender": "feminine", "example": "Gute Öffentlichkeitsarbeit fördert das Vertrauen in Organisationen."},
        "english": {"word": "public relations (PR)", "phonetic": "/ˌpʌb.lɪk rɪˈleɪ.ʃənz/", "example": "Transparent public relations builds enduring community goodwill."},
        "image_id": "img_med_pr"
    },
    {
        "id": "med_recherche",
        "category": "media_journalism",
        "arabic": {"word": "التَّحْقِيقُ الِاسْتِقْصَائِيُّ / التَّدْقِيقُ", "transliteration": "At-Tahqeeq", "notes": "البحث المعمق في الوثائق والشهادات لكشف الحقائق"},
        "german": {"article": "die", "word": "Recherche", "plural": "die Recherchen", "gender": "feminine", "example": "Gründliche journalistische Recherche erfordert oft monatelange Arbeit."},
        "english": {"word": "fact-checking / investigation", "phonetic": "/rɪˈsɜːtʃ/", "example": "Meticulous investigative research uncovers hidden discrepancies."},
        "image_id": "img_med_recherche"
    },
    {
        "id": "med_netzwerk",
        "category": "media_journalism",
        "arabic": {"word": "الشَّبَكَةُ الِاجْتِمَاعِيَّةُ", "transliteration": "Ash-Shabakah Al-Ijtima'iyyah", "notes": "منصات التواصل والتفاعل الرقمي"},
        "german": {"article": "das", "word": "soziale Netzwerk", "plural": "die sozialen Netzwerke", "gender": "neuter", "example": "Nachrichten verbreiten sich rasend schnell im sozialen Netzwerk."},
        "english": {"word": "social network", "phonetic": "/ˌsəʊ.ʃəl ˈnet.wɜːk/", "example": "Modern breaking news breaks immediately on social networks."},
        "image_id": "img_med_netzwerk"
    },
    {
        "id": "med_glaubwuerdigkeit",
        "category": "media_journalism",
        "arabic": {"word": "المِصْدَاقِيَّةُ الإِعْلَامِيَّةُ", "transliteration": "Al-Misdaqiyyah", "notes": "الثقة والنزاهة التي تحظى بها الوسيلة الإعلامية"},
        "german": {"article": "die", "word": "Glaubwürdigkeit", "plural": "die Glaubwürdigkeiten", "gender": "feminine", "example": "Glaubwürdigkeit ist das wertvollste Kapital einer Redaktion."},
        "english": {"word": "credibility / trustworthiness", "phonetic": "/ˌkred.əˈbɪl.ə.ti/", "example": "Rigorous accuracy cements enduring journalistic credibility."},
        "image_id": "img_med_glaubwuerdigkeit"
    }
]

# حفظ ملف المفردات الجديد في content/vocabulary/media_journalism_a2.json
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/media_journalism_a2.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "media_journalism",
        "category_name": {
            "ar": "الإعلام والصحافة",
            "de": "Medien, Journalismus & Information",
            "en": "Media, Journalism & Information"
        },
        "level": "A2",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم إعلامية وصحفية في {vocab_path}")

# 2. توليد 25 أيقونة SVG خفيفة ومتجهية (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "med_journalismus": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="20" width="64" height="60" rx="4" fill="#ECEFF1" stroke="#37474F" stroke-width="3"/><rect x="25" y="28" width="50" height="8" rx="2" fill="#C2185B"/><rect x="25" y="42" width="22" height="22" fill="#90A4AE"/><line x1="52" y1="44" x2="75" y2="44" stroke="#455A64" stroke-width="3"/><line x1="52" y1="52" x2="75" y2="52" stroke="#455A64" stroke-width="3"/><line x1="52" y1="60" x2="75" y2="60" stroke="#455A64" stroke-width="3"/><line x1="25" y1="70" x2="75" y2="70" stroke="#78909C" stroke-width="2.5"/></svg>',
    "med_journalist": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="30" r="14" fill="#FFA726"/><path d="M22,82 C22,58 68,58 68,82 Z" fill="#263238"/><rect x="62" y="45" width="8" height="20" rx="3" fill="#78909C"/><circle cx="66" cy="42" r="5" fill="#424242"/></svg>',
    "med_journalistin": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="30" r="14" fill="#FFCC80"/><path d="M28,20 C38,12 52,12 62,20 C66,36 24,36 28,20 Z" fill="#4E342E"/><path d="M22,82 C22,58 68,58 68,82 Z" fill="#C2185B"/><rect x="62" y="45" width="8" height="20" rx="3" fill="#78909C"/><circle cx="66" cy="42" r="5" fill="#424242"/></svg>',
    "med_presse": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="25" width="55" height="55" rx="3" fill="#ECEFF1" stroke="#455A64" stroke-width="3" transform="rotate(8 50 50)"/><rect x="20" y="20" width="55" height="55" rx="3" fill="#FFF" stroke="#263238" stroke-width="3"/><text x="47" y="42" font-family="sans-serif" font-weight="bold" font-size="14" fill="#C2185B" text-anchor="middle">PRESS</text><line x1="28" y1="52" x2="66" y2="52" stroke="#546E7A" stroke-width="2.5"/><line x1="28" y1="60" x2="66" y2="60" stroke="#546E7A" stroke-width="2.5"/></svg>',
    "med_pressekonferenz": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="45" width="50" height="35" rx="4" fill="#37474F"/><circle cx="50" cy="28" r="10" fill="#FFA726"/><path d="M38,45 C38,38 62,38 62,45 Z" fill="#1565C0"/><rect x="42" y="40" width="16" height="5" fill="#B0BEC5"/><rect x="34" y="38" width="5" height="10" fill="#212121"/><rect x="61" y="38" width="5" height="10" fill="#212121"/></svg>',
    "med_schlagzeile": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="20" width="70" height="60" rx="4" fill="#FFF" stroke="#212121" stroke-width="4"/><rect x="20" y="28" width="60" height="15" fill="#D32F2F"/><text x="50" y="40" font-family="sans-serif" font-weight="bold" font-size="10" fill="#FFF" text-anchor="middle">BREAKING</text><line x1="20" y1="52" x2="80" y2="52" stroke="#455A64" stroke-width="3"/><line x1="20" y1="60" x2="80" y2="60" stroke="#455A64" stroke-width="3"/><line x1="20" y1="68" x2="65" y2="68" stroke="#455A64" stroke-width="3"/></svg>',
    "med_bericht": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="16" width="56" height="68" rx="4" fill="#ECEFF1" stroke="#455A64" stroke-width="3"/><rect x="28" y="24" width="44" height="6" fill="#1565C0"/><line x1="28" y1="36" x2="72" y2="36" stroke="#78909C" stroke-width="2.5"/><line x1="28" y1="44" x2="72" y2="44" stroke="#78909C" stroke-width="2.5"/><line x1="28" y1="52" x2="72" y2="52" stroke="#78909C" stroke-width="2.5"/><polygon points="65,70 78,55 83,60 70,75" fill="#C2185B"/></svg>',
    "med_artikel": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="18" width="60" height="64" rx="4" fill="#FFF" stroke="#546E7A" stroke-width="3"/><rect x="26" y="26" width="30" height="6" fill="#00897B"/><rect x="26" y="38" width="48" height="4" fill="#90A4AE"/><rect x="26" y="46" width="48" height="4" fill="#90A4AE"/><rect x="26" y="54" width="48" height="4" fill="#90A4AE"/><rect x="26" y="62" width="32" height="4" fill="#90A4AE"/></svg>',
    "med_interview": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="42" y="30" width="16" height="35" rx="8" fill="#37474F"/><rect x="45" y="65" width="10" height="15" fill="#78909C"/><line x1="30" y1="80" x2="70" y2="80" stroke="#37474F" stroke-width="4" stroke-linecap="round"/><circle cx="50" cy="24" r="10" fill="#E91E63"/><path d="M28,32 Q20,40 28,48" stroke="#00BCD4" stroke-width="4" fill="none" stroke-linecap="round"/><path d="M72,32 Q80,40 72,48" stroke="#00BCD4" stroke-width="4" fill="none" stroke-linecap="round"/></svg>',
    "med_sendung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="24" width="70" height="52" rx="6" fill="#212121"/><rect x="20" y="29" width="60" height="42" fill="#00BCD4"/><circle cx="50" cy="50" r="12" fill="#E53935"/><polygon points="46,44 56,50 46,56" fill="#FFF"/><line x1="35" y1="14" x2="45" y2="24" stroke="#757575" stroke-width="4"/><line x1="65" y1="14" x2="55" y2="24" stroke="#757575" stroke-width="4"/></svg>',
    "med_quelle": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1565C0"/><polygon points="35,42 45,30 65,30 55,42" fill="#FFF"/><polygon points="35,70 45,58 65,58 55,70" fill="#FFF"/><path d="M40,42 L40,58 M60,42 L60,58" stroke="#FFD54F" stroke-width="4"/></svg>',
    "med_falschnachrichten": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#D32F2F"/><line x1="30" y1="30" x2="70" y2="70" stroke="#FFF" stroke-width="8" stroke-linecap="round"/><line x1="70" y1="30" x2="30" y2="70" stroke="#FFF" stroke-width="8" stroke-linecap="round"/><circle cx="50" cy="50" r="34" fill="none" stroke="#FFCDD2" stroke-width="3" stroke-dasharray="6,4"/></svg>',
    "med_information": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0288D1"/><circle cx="50" cy="32" r="5" fill="#FFF"/><rect x="45" y="44" width="10" height="28" rx="2" fill="#FFF"/><circle cx="50" cy="50" r="34" fill="none" stroke="#B3E5FC" stroke-width="3"/></svg>',
    "med_pressefreiheit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#43A047"/><path d="M30,65 C30,45 50,30 75,25 C65,50 60,70 30,65 Z" fill="#FFF"/><line x1="50" y1="75" x2="50" y2="52" stroke="#FFD54F" stroke-width="6" stroke-linecap="round"/></svg>',
    "med_redakteur": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="28" r="14" fill="#FFA726"/><path d="M26,80 C26,56 74,56 74,80 Z" fill="#37474F"/><polygon points="46,42 54,42 52,58 48,58" fill="#FFF"/><rect x="65" y="60" width="18" height="22" rx="3" fill="#FFE082"/><line x1="68" y1="65" x2="80" y2="65" stroke="#E65100" stroke-width="2"/></svg>',
    "med_podcast": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#6A1B9A"/><rect x="43" y="32" width="14" height="26" rx="7" fill="#FFF"/><path d="M35,46 C35,56 65,56 65,46" stroke="#FFF" stroke-width="4" fill="none"/><line x1="50" y1="56" x2="50" y2="70" stroke="#FFF" stroke-width="4"/><line x1="40" y1="70" x2="60" y2="70" stroke="#FFF" stroke-width="4"/></svg>',
    "med_sender": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="75" r="8" fill="#E53935"/><path d="M36,60 A20,20 0 0,1 64,60" stroke="#E53935" stroke-width="6" fill="none" stroke-linecap="round"/><path d="M24,45 A36,36 0 0,1 76,45" stroke="#E53935" stroke-width="6" fill="none" stroke-linecap="round"/><path d="M12,30 A52,52 0 0,1 88,30" stroke="#E53935" stroke-width="6" fill="none" stroke-linecap="round"/></svg>',
    "med_publikum": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="30" cy="40" r="10" fill="#FFA726"/><circle cx="50" cy="35" r="10" fill="#FFB74D"/><circle cx="70" cy="40" r="10" fill="#FFA726"/><path d="M18,75 C18,60 42,60 42,75 Z" fill="#1565C0"/><path d="M36,75 C36,55 64,55 64,75 Z" fill="#0D47A1"/><path d="M58,75 C58,60 82,60 82,75 Z" fill="#1565C0"/></svg>',
    "med_auflage": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="35" width="50" height="45" rx="3" fill="#B0BEC5"/><rect x="22" y="28" width="50" height="45" rx="3" fill="#CFD8DC"/><rect x="19" y="20" width="50" height="45" rx="3" fill="#ECEFF1" stroke="#37474F" stroke-width="2"/><circle cx="75" cy="72" r="14" fill="#E91E63"/><path d="M75,64 L75,80 M67,72 L83,72" stroke="#FFF" stroke-width="3" stroke-linecap="round"/></svg>',
    "med_livestream": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="22" width="64" height="48" rx="6" fill="#C62828"/><polygon points="44,36 60,46 44,56" fill="#FFF"/><circle cx="30" cy="80" r="4" fill="#E53935"/><text x="40" y="84" font-family="sans-serif" font-weight="bold" font-size="12" fill="#E53935">LIVE</text></svg>',
    "med_kommentar": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M20,25 C20,18 28,15 50,15 C72,15 80,18 80,25 L80,60 C80,67 72,70 50,70 L30,85 L32,70 L20,70 Z" fill="#00897B"/><line x1="32" y1="35" x2="68" y2="35" stroke="#FFF" stroke-width="4" stroke-linecap="round"/><line x1="32" y1="48" x2="58" y2="48" stroke="#FFF" stroke-width="4" stroke-linecap="round"/></svg>',
    "med_pr": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FF8F00"/><polygon points="25,40 50,25 50,75 25,60" fill="#FFF"/><path d="M50,38 L72,28 L72,72 L50,62" fill="#FFE082"/><path d="M78,42 Q86,50 78,58" stroke="#FFF" stroke-width="4" fill="none" stroke-linecap="round"/></svg>',
    "med_recherche": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="44" cy="44" r="24" fill="#E0F7FA" stroke="#0097A7" stroke-width="6"/><line x1="62" y1="62" x2="84" y2="84" stroke="#006064" stroke-width="8" stroke-linecap="round"/><circle cx="44" cy="44" r="8" fill="#FFB300"/></svg>',
    "med_netzwerk": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="28" cy="35" r="12" fill="#E91E63"/><circle cx="72" cy="35" r="12" fill="#0288D1"/><circle cx="50" cy="72" r="12" fill="#43A047"/><line x1="36" y1="42" x2="64" y2="42" stroke="#BDBDBD" stroke-width="4"/><line x1="33" y1="45" x2="45" y2="62" stroke="#BDBDBD" stroke-width="4"/><line x1="67" y1="45" x2="55" y2="62" stroke="#BDBDBD" stroke-width="4"/></svg>',
    "med_glaubwuerdigkeit": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#1565C0"/><polygon points="50,18 78,32 78,65 50,82 22,65 22,32" fill="#FFF"/><path d="M38,50 L46,58 L62,40" stroke="#43A047" stroke-width="6" fill="none" stroke-linecap="round" stroke-linejoin="round"/></svg>'
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
            "description": f"Vector illustration for media concept: {c['english']['word']}"
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
    
    if "media_journalism_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/philosophy_logic_a2.json',",
            "'assets/content/vocabulary/philosophy_logic_a2.json',\n    'assets/content/vocabulary/media_journalism_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط media_journalism_a2.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "media_journalism" not in cat_code:
        entry = """    CategoryMeta(
      id: 'media_journalism',
      titleAr: 'الإعلام والصحافة',
      titleDe: 'Medien & Journalismus',
      titleEn: 'Media & Journalism',
      icon: Icons.newspaper_rounded,
      primaryColor: Color(0xFFC2185B),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم الإعلام والصحافة في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 26", "TOTAL_VOCAB_CATEGORIES = 27")
    val_code = val_code.replace("TOTAL_CONCEPTS = 655", "TOTAL_CONCEPTS = 680")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 775", "TOTAL_SVG_ASSETS = 800")
    
    if "media_journalism_a2.json" not in val_code:
        val_code = val_code.replace(
            "'philosophy_logic_a2.json',",
            "'philosophy_logic_a2.json',\n    'media_journalism_a2.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (27 فئة، 680 مفهومًا، 800 أصل متجهي)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 046 Status (Completed - Level A2 Media & Journalism Category)
- **Feature:** Category 27: Media, Journalism & Information (`media_journalism_a2.json`).
- **New Concepts:** 25 trilingual vocabulary items for journalism, press freedom, headlines, news reporting, broadcasting, and verification.
- **New Visuals:** 25 unique lightweight SVG vectors (`med_*.svg`).
- **MONUMENTAL MILESTONE REACHED:**
  - 27 Vocabulary Categories.
  - 680 Core Vocabulary Concepts.
  - 35 Base Verbs | 15 Perfekt Forms.
  - 60 Syntax Exercises (Sentence Builder).
  - 24 Prepositions | 5 Dialogues.
  - Articles, Genitiv, Relativsätze, Konjunktiv II, Passiv & Conjunctions Engines.
  - 800 Total SVG Vector Icons (Crossed 800+ assets milestone).
- **Integration:** Active in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 046 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 046 بنجاح تام!")
