import json
import os

print("🚀 [CYCLE 054] بدء بناء قسم الأدب والشعر والتعبيرات البلاغية (Literature & Idioms - A2)...")

# 1. قائمة الـ 25 مفهومًا لقسم الأدب والشعر والتعبيرات الاصطلاحية
concepts = [
    {
        "id": "lit_literatur",
        "category": "literature_idioms",
        "arabic": {"word": "الأَدَبُ الرَّفِيعُ", "transliteration": "Al-Adab", "notes": "الإنتاج الفكري الإبداعي المكتوب شعرًا أو نثرًا"},
        "german": {"article": "die", "word": "Literatur", "plural": "die Literaturen", "gender": "feminine", "example": "Klassische deutsche Literatur begeistert Leser auf der ganzen Welt."},
        "english": {"word": "literature", "phonetic": "/ˈlɪt.rə.tʃər/", "example": "World literature offers profound perspectives on universal human nature."},
        "image_id": "img_lit_literatur"
    },
    {
        "id": "lit_poesie",
        "category": "literature_idioms",
        "arabic": {"word": "الشِّعْرُ / الفَنُّ الشِّعْرِيُّ", "transliteration": "Ash-Shi'r", "notes": "التعبير الوجداني الإيقاعي البليغ"},
        "german": {"article": "die", "word": "Poesie", "plural": "die Poesien", "gender": "feminine", "example": "Die emotionale Poesie berührt die tiefsten Saiten des Herzens."},
        "english": {"word": "poetry", "phonetic": "/ˈpəʊ.ɪ.tri/", "example": "Lyrical poetry conveys deep sorrow, joy, and transcendent wonder."},
        "image_id": "img_lit_poesie"
    },
    {
        "id": "lit_gedicht",
        "category": "literature_idioms",
        "arabic": {"word": "القَصِيدَةُ الشِّعْرِيَّةُ", "transliteration": "Al-Qaseedah", "notes": "النص الأدبي المنظوم في أبيات موزونة"},
        "german": {"article": "das", "word": "Gedicht", "plural": "die Gedichte", "gender": "neuter", "example": "In der Schule lernten die Schüler Goethes berühmtes Gedicht auswendig."},
        "english": {"word": "poem", "phonetic": "/ˈpəʊ.ɪm/", "example": "The actress recited a moving romantic poem with great passion."},
        "image_id": "img_lit_gedicht"
    },
    {
        "id": "lit_dichter",
        "category": "literature_idioms",
        "arabic": {"word": "الشَّاعِرُ / الأَدِيبُ المُنْشِدُ", "transliteration": "Ash-Sha'ir", "notes": "منشئ الشعر وصائغ الأبيات"},
        "german": {"article": "der", "word": "Dichter", "plural": "die Dichter", "gender": "masculine", "example": "Der gefeierte Dichter verfasste Verse über Freiheit und Gerechtigkeit."},
        "english": {"word": "poet", "phonetic": "/ˈpəʊ.ɪt/", "example": "The classical poet composed timeless stanzas about nature and peace."},
        "image_id": "img_lit_dichter"
    },
    {
        "id": "lit_roman",
        "category": "literature_idioms",
        "arabic": {"word": "الرِّوَايَةُ الأَدَبِيَّةُ", "transliteration": "Ar-Riwayah", "notes": "العمل النثري السردي الطويل المتعدد الشخصيات"},
        "german": {"article": "der", "word": "Roman", "plural": "die Romane", "gender": "masculine", "example": "Dieser historische Roman stand monatelang an der Spitze der Bestsellerlisten."},
        "english": {"word": "novel", "phonetic": "/ˈnɒv.əl/", "example": "She finished reading a gripping historical mystery novel."},
        "image_id": "img_lit_roman"
    },
    {
        "id": "lit_erzaehlung",
        "category": "literature_idioms",
        "arabic": {"word": "القِصَّةُ / الحِكَايَةُ السَّرْدِيَّةُ", "transliteration": "Al-Qissah", "notes": "العمل السردي المتوسط أو القصير"},
        "german": {"article": "die", "word": "Erzählung", "plural": "die Erzählungen", "gender": "feminine", "example": "Die spannende Erzählung schildert das Leben im mittelalterlichen Wien."},
        "english": {"word": "short story / narrative", "phonetic": "/ˈnær.ə.tɪv/", "example": "The engaging narrative captures the essence of rural childhood."},
        "image_id": "img_lit_erzaehlung"
    },
    {
        "id": "lit_maerchen",
        "category": "literature_idioms",
        "arabic": {"word": "حِكَايَةٌ خُرَافِيَّةٌ / قِصَّةٌ شَعْبِيَّةٌ", "transliteration": "Al-Hikayah Ash-Sha'biyyah", "notes": "القصص التراثية الخيالية (كحكايات الأخوين غريم وألف ليلة وليلة)"},
        "german": {"article": "das", "word": "Märchen", "plural": "die Märchen", "gender": "neuter", "example": "Die Gebrüder Grimm sammelten weltbekannte deutsche Märchen."},
        "english": {"word": "fairy tale", "phonetic": "/ˈfeə.ri ˌteɪl/", "example": "Traditional fairy tales teach ethical lessons through whimsical folklore."},
        "image_id": "img_lit_maerchen"
    },
    {
        "id": "lit_sprichwort",
        "category": "literature_idioms",
        "arabic": {"word": "المَثَلُ السَّائِرُ / الحِكْمَةُ المَأْثُورَةُ", "transliteration": "Al-Mathal", "notes": "قول موجز يلخص حكمة مجتمعية متوارثة"},
        "german": {"article": "das", "word": "Sprichwort", "plural": "die Sprichwörter", "gender": "neuter", "example": "Das deutsche Sprichwort 'Morgenstund hat Gold im Mund' lobt das Früheaufstehen."},
        "english": {"word": "proverb / saying", "phonetic": "/ˈprɒv.ɜːb/", "example": "An ancient proverb reminds us that actions speak louder than words."},
        "image_id": "img_lit_sprichwort"
    },
    {
        "id": "lit_redewendung",
        "category": "literature_idioms",
        "arabic": {"word": "التَّعْبِيرُ الِاصْطِلَاحِيُّ المَجَازِيُّ", "transliteration": "At-Ta'beer Al-Istilahi", "notes": "تركيب لغوي يحمل معنى كنائيًا غير حرفي"},
        "german": {"article": "die", "word": "Redewendung", "plural": "die Redewendungen", "gender": "feminine", "example": "Um Deutsch wie ein Muttersprachler zu sprechen, muss man gängige Redewendungen lernen."},
        "english": {"word": "idiom / idiomatic expression", "phonetic": "/ˈɪd.i.əm/", "example": "Mastering cultural idioms is crucial for natural conversational fluency."},
        "image_id": "img_lit_redewendung"
    },
    {
        "id": "lit_metapher",
        "category": "literature_idioms",
        "arabic": {"word": "الِاسْتِعَارَةُ / التَّشْبِيهُ البَلِيغُ", "transliteration": "Al-Isti'arah", "notes": "استعمال اللفظ في غير معناه الحقيقي لعلاقة المشابهة"},
        "german": {"article": "die", "word": "Metapher", "plural": "die Metaphern", "gender": "feminine", "example": "'Ein Meer von Möglichkeiten' ist eine wunderschöne poetische Metapher."},
        "english": {"word": "metaphor", "phonetic": "/ˈmet.ə.fɔːr/", "example": "The author employed a striking visual metaphor in the opening chapter."},
        "image_id": "img_lit_metapher"
    },
    {
        "id": "lit_reim",
        "category": "literature_idioms",
        "arabic": {"word": "القَافِيَةُ / الجِنَاسُ الصَّوْتِيُّ", "transliteration": "Al-Qafiyah", "notes": "توافق أواخر الكلمات صوتيًا في الشعر"},
        "german": {"article": "der", "word": "Reim", "plural": "die Reime", "gender": "masculine", "example": "Der melodische Reim verleiht den Versen einen harmonischen Klang."},
        "english": {"word": "rhyme", "phonetic": "/raɪm/", "example": "The rhythmic rhyme structure creates an enchanting poetic cadence."},
        "image_id": "img_lit_reim"
    },
    {
        "id": "lit_vers",
        "category": "literature_idioms",
        "arabic": {"word": "البَيْتُ الشِّعْرِيُّ / الشَّطْرُ", "transliteration": "Al-Bayt Ash-Shi'ri", "notes": "السطر الشعري الواحد المكون للمنظومة"},
        "german": {"article": "der", "word": "Vers", "plural": "die Verse", "gender": "masculine", "example": "Dieser lyrische Vers drückt tiefes Heimweh und Sehnsucht aus."},
        "english": {"word": "verse / stanza line", "phonetic": "/vɜːs/", "example": "Each poetic verse resonates with emotional authenticity."},
        "image_id": "img_lit_vers"
    },
    {
        "id": "lit_drama",
        "category": "literature_idioms",
        "arabic": {"word": "الدِّرَامَا / المَسْرَحِيَّةُ", "transliteration": "Ad-Drama", "notes": "النص الأدبي المكتوب ليمثله الممثلون على خشبة المسرح"},
        "german": {"article": "das", "word": "Drama", "plural": "die Dramen", "gender": "neuter", "example": "Schillers berühmtes Drama 'Wilhelm Tell' feiert den Freiheitskampf."},
        "english": {"word": "drama / theatrical play", "phonetic": "/ˈdrɑː.mə/", "example": "The classical drama portrays political intrigue and sacrifice."},
        "image_id": "img_lit_drama"
    },
    {
        "id": "lit_tragoedie",
        "category": "literature_idioms",
        "arabic": {"word": "المَأْسَاةُ / التَّرَاجِيدْيَا", "transliteration": "Al-Ma'sah", "notes": "المسرحية الحزينة ذات النهاية المفجعة"},
        "german": {"article": "die", "word": "Tragödie", "plural": "die Tragödien", "gender": "feminine", "example": "Shakespeares 'Hamlet' gilt als eine der größten Tragödien der Weltliteratur."},
        "english": {"word": "tragedy", "phonetic": "/ˈtrædʒ.ə.di/", "example": "The ancient Greek tragedy depicts the conflict between fate and duty."},
        "image_id": "img_lit_tragoedie"
    },
    {
        "id": "lit_komoedie",
        "category": "literature_idioms",
        "arabic": {"word": "المَلْهَاةُ / الكُومِيدْيَا", "transliteration": "Al-Malhah", "notes": "المسرحية الهزلية ذات النهاية السعيدة والفكاهة"},
        "german": {"article": "die", "word": "Komödie", "plural": "die Komödien", "gender": "feminine", "example": "Die heitere Komödie brachte das gesamte Theaterpublikum zum Lachen."},
        "english": {"word": "comedy", "phonetic": "/ˈkɒm.ə.di/", "example": "The witty romantic comedy delighted the audience with clever satire."},
        "image_id": "img_lit_komoedie"
    },
    {
        "id": "lit_kapitel",
        "category": "literature_idioms",
        "arabic": {"word": "الفَصْلُ مِنَ الكِتَابِ", "transliteration": "Al-Fasl", "notes": "الجزء المستقل المقسم إليه الكتاب أو الرواية"},
        "german": {"article": "das", "word": "Kapitel", "plural": "die Kapitel", "gender": "neuter", "example": "Ich lese jeden Abend vor dem Schlafen noch ein spannendes Kapitel."},
        "english": {"word": "chapter", "phonetic": "/ˈtʃæp.tər/", "example": "The final chapter resolves the plot's lingering central mystery."},
        "image_id": "img_lit_kapitel"
    },
    {
        "id": "lit_handlung",
        "category": "literature_idioms",
        "arabic": {"word": "حَبْكَةُ القِصَّةِ / السِّيَاقُ الدِّرَامِيُّ", "transliteration": "Habkat Al-Qissah", "notes": "تسلسل وترابط الأحداث في العمل السردي"},
        "german": {"article": "die", "word": "Handlung", "plural": "die Handlungen", "gender": "feminine", "example": "Die unvorhersehbare Handlung hielt die Leser bis zur letzten Seite in Atem."},
        "english": {"word": "plot / storyline", "phonetic": "/plɒt/", "example": "A well-structured narrative plot weaves suspense through every twist."},
        "image_id": "img_lit_handlung"
    },
    {
        "id": "lit_figur",
        "category": "literature_idioms",
        "arabic": {"word": "الشَّخْصِيَّةُ الأَدَبِيَّةُ / البَطَلُ", "transliteration": "Ash-Shakhsiyyah", "notes": "الفرد المصور في الرواية أو المسرحية"},
        "german": {"article": "die", "word": "Figur", "plural": "die Figuren", "gender": "feminine", "example": "Die Hauptfigur des Buches entwickelt sich im Laufe der Geschichte weiter."},
        "english": {"word": "character / protagonist", "phonetic": "/ˈkær.ək.tər/", "example": "The complex protagonist faces immense ethical crossroads throughout."},
        "image_id": "img_lit_figur"
    },
    {
        "id": "lit_fabel",
        "category": "literature_idioms",
        "arabic": {"word": "الخُرَافَةُ الرَّمْزِيَّةُ / مَثَلُ الحَيَوَانِ", "transliteration": "Al-Khurafah Ar-Ramziyyah", "notes": "قصة حكيمة على لسان الحيوانات تنتهي بموعظة (كحكايات إيسوب وكليلة ودمنة)"},
        "german": {"article": "die", "word": "Fabel", "plural": "die Fabeln", "gender": "feminine", "example": "In der Fabel vom Fuchs und dem Raben wird vor falscher Schmeichelei gewarnt."},
        "english": {"word": "fable", "phonetic": "/ˈfeɪ.bəl/", "example": "Ancient fables employ talking animal characters to teach timeless morals."},
        "image_id": "img_lit_fabel"
    },
    {
        "id": "lit_daumen_druecken",
        "category": "literature_idioms",
        "arabic": {"word": "تَمَنِّي التَّوْفِيقِ («أَشُدُّ لَكَ عَلَى إِبْهَامِي»)", "transliteration": "Tamanni At-Tawfeeq (Daumen drücken)", "notes": "تعبير اصطلاحي ألماني شهير يقابل 'Cross fingers' لتمني النجاح في الامتحان أو المقابلة"},
        "german": {"article": "", "word": "Daumen drücken", "plural": "", "gender": "Idiom", "example": "Ich drücke dir für deine morgige Deutschprüfung ganz fest die Daumen!"},
        "english": {"word": "to keep fingers crossed / wish luck", "phonetic": "/kɪːp ˈfɪŋ.ɡəz krɒst/", "example": "I will keep my fingers crossed for your final driving exam tomorrow!"},
        "image_id": "img_lit_daumen_druecken"
    },
    {
        "id": "lit_schwein_haben",
        "category": "literature_idioms",
        "arabic": {"word": "الحَظُّ السَّعِيدُ المُفَاجِئُ («حَالَفَهُ الحَظُّ»)", "transliteration": "Schwein haben (Al-Hath Al-Wafir)", "notes": "تعبير اصطلاحي تاريخي يعود لمسابقات العصور الوسطى يعني النجاة من ورطة أو مصادفة حظ غير متوقعة"},
        "german": {"article": "", "word": "Schwein haben", "plural": "", "gender": "Idiom", "example": "Da hast du aber Schwein gehabt, dass der Zug fünf Minuten Verspätung hatte!"},
        "english": {"word": "to strike luck / get lucky", "phonetic": "/ɡet ˈlʌk.i/", "example": "You really struck luck that the train was delayed just enough for you to catch it!"},
        "image_id": "img_lit_schwein_haben"
    },
    {
        "id": "lit_zwei_linke_haende",
        "category": "literature_idioms",
        "arabic": {"word": "قِلَّةُ المَهَارَةِ اليَدَوِيَّةِ («لَهُ يَدَانِ يُسْرَيَانِ»)", "transliteration": "Zwei linke Hände", "notes": "تعبير اصطلاحي يقال لمن لا يحسن الحرف اليدوية والإصلاحات المنزلية (يقابله All thumbs)"},
        "german": {"article": "", "word": "zwei linke Hände haben", "plural": "", "gender": "Idiom", "example": "Beim Heimwerken hat er leider zwei linke Hände."},
        "english": {"word": "to be all thumbs / clumsy", "phonetic": "/ɔːl θʌmz/", "example": "When it comes to assembling furniture, I am completely all thumbs."},
        "image_id": "img_lit_zwei_linke_haende"
    },
    {
        "id": "lit_nerven_treten",
        "category": "literature_idioms",
        "arabic": {"word": "إِزْعَاجُ الأَعْصَابِ («الدَّعْسُ عَلَى الأَعْصَابِ»)", "transliteration": "Auf die Nerven gehen / treten", "notes": "تعبير اصطلاحي دارج للتعبير عن الضيق الشديد والإزعاج المتكرر"},
        "german": {"article": "", "word": "auf die Nerven gehen", "plural": "", "gender": "Idiom", "example": "Dieser ständige Baulärm geht mir tierisch auf die Nerven."},
        "english": {"word": "to get on someone's nerves", "phonetic": "/ɡet ɒn nɜːvz/", "example": "The repetitive construction drilling is truly getting on my nerves."},
        "image_id": "img_lit_nerven_treten"
    },
    {
        "id": "lit_inspiration",
        "category": "literature_idioms",
        "arabic": {"word": "الإِلْهَامُ الإِبْدَاعِيُّ", "transliteration": "Al-Ilham", "notes": "انبثاق الفكرة الخلابة والدافع الفني في ذهن الكاتب أو الشاعر"},
        "german": {"article": "die", "word": "Inspiration", "plural": "die Inspirationen", "gender": "feminine", "example": "Die stille Schönheit der Berge schenkte dem Autor neue Inspiration."},
        "english": {"word": "creative inspiration", "phonetic": "/ˌɪn.spɪˈreɪ.ʃən/", "example": "Solitude in natural landscapes sparked fresh artistic inspiration."},
        "image_id": "img_lit_inspiration"
    },
    {
        "id": "lit_meisterwerk",
        "category": "literature_idioms",
        "arabic": {"word": "التُّحْفَةُ الأَدَبِيَّةُ / الشَّاهْكَار", "transliteration": "At-Tuhfah Al-Adabiyyah", "notes": "العمل الفني أو الأدبي البارع الذي يبلغ قمة الإتقان والخلود"},
        "german": {"article": "das", "word": "Meisterwerk", "plural": "die Meisterwerke", "gender": "neuter", "example": "Goethes 'Faust' gilt unbestritten als Meisterwerk der deutschen Sprache."},
        "english": {"word": "masterpiece / magnum opus", "phonetic": "/ˈmɑː.stə.piːs/", "example": "The timeless tragedy is recognized as a genuine literary masterpiece."},
        "image_id": "img_lit_meisterwerk"
    }
]

# حفظ ملف المفردات الجديد في content/vocabulary/literature_idioms_a2.json
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/literature_idioms_a2.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "literature_idioms",
        "category_name": {
            "ar": "الأدب والشعر والتعبيرات",
            "de": "Literatur, Poesie & Redewendungen",
            "en": "Literature, Poetry & Idioms"
        },
        "level": "A2",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم أدبية وبلاغية في {vocab_path}")

# 2. توليد 25 أيقونة SVG متقنة وخفيفة (<1.5KB)
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "lit_literatur": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#6D4C41"/><rect x="25" y="25" width="50" height="50" rx="4" fill="#FFF8E1"/><path d="M25,25 Q50,32 50,75 Q25,68 25,25 Z" fill="#D7CCC8"/><path d="M75,25 Q50,32 50,75 Q75,68 75,25 Z" fill="#EFEBE9"/><line x1="50" y1="32" x2="50" y2="75" stroke="#5D4037" stroke-width="2.5"/><polygon points="75,22 80,32 70,32" fill="#FFD54F"/></svg>',
    "lit_poesie": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#880E4F"/><path d="M30,75 C30,45 50,25 75,20 C65,45 60,70 30,75 Z" fill="#F8BBD0"/><line x1="30" y1="75" x2="70" y2="25" stroke="#AD1457" stroke-width="3"/><circle cx="70" cy="25" r="4" fill="#FFD54F"/></svg>',
    "lit_gedicht": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="16" width="56" height="68" rx="4" fill="#FFF8E1" stroke="#5D4037" stroke-width="3"/><line x1="32" y1="28" x2="68" y2="28" stroke="#4E342E" stroke-width="3"/><line x1="32" y1="38" x2="60" y2="38" stroke="#795548" stroke-width="2.5"/><line x1="32" y1="48" x2="64" y2="48" stroke="#795548" stroke-width="2.5"/><line x1="32" y1="58" x2="54" y2="58" stroke="#795548" stroke-width="2.5"/><circle cx="68" cy="68" r="6" fill="#C2185B"/></svg>',
    "lit_dichter": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="30" r="14" fill="#FFA726"/><path d="M26,82 C26,58 74,58 74,82 Z" fill="#3E2723"/><polygon points="46,44 54,44 50,60" fill="#FFF"/><path d="M68,48 L84,32 L88,36 L72,52 Z" fill="#FFB300"/></svg>',
    "lit_roman": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="18" width="56" height="64" rx="5" fill="#1565C0"/><rect x="18" y="18" width="10" height="64" fill="#0D47A1"/><line x1="36" y1="32" x2="68" y2="32" stroke="#FFF" stroke-width="3"/><line x1="36" y1="44" x2="68" y2="44" stroke="#FFF" stroke-width="3"/><circle cx="52" cy="60" r="8" fill="#FFD54F"/></svg>',
    "lit_erzaehlung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#4E342E"/><rect x="28" y="32" width="44" height="38" rx="3" fill="#FFF8E1"/><path d="M35,42 L55,42 M35,50 L65,50 M35,58 L50,58" stroke="#5D4037" stroke-width="2.5" stroke-linecap="round"/><circle cx="68" cy="30" r="6" fill="#FFA000"/></svg>',
    "lit_maerchen": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#4A148C"/><polygon points="50,18 55,32 70,32 58,42 62,56 50,48 38,56 42,42 30,32 45,32" fill="#FFD700"/><circle cx="28" cy="28" r="3" fill="#FFF"/><circle cx="72" cy="72" r="3" fill="#FFF"/><circle cx="75" cy="30" r="2.5" fill="#FFF"/></svg>',
    "lit_sprichwort": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#E65100"/><path d="M22,35 C22,25 32,20 50,20 C68,20 78,25 78,35 L78,60 C78,68 68,72 50,72 L32,84 L36,72 L22,72 Z" fill="#FFF"/><text x="50" y="52" font-family="serif" font-weight="bold" font-size="28" fill="#E65100" text-anchor="middle">“ ”</text></svg>',
    "lit_redewendung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00897B"/><path d="M30,45 Q50,25 70,45" stroke="#FFF" stroke-width="6" fill="none" stroke-linecap="round"/><path d="M70,55 Q50,75 30,55" stroke="#FFD54F" stroke-width="6" fill="none" stroke-linecap="round"/><circle cx="50" cy="50" r="6" fill="#FFF"/></svg>',
    "lit_metapher": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="38" cy="45" r="22" fill="#0288D1"/><circle cx="62" cy="55" r="22" fill="#FFB300" opacity="0.85"/><circle cx="50" cy="50" r="10" fill="#FFF"/></svg>',
    "lit_reim": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#5C6BC0"/><circle cx="36" cy="65" r="10" fill="#FFF"/><circle cx="66" cy="55" r="10" fill="#FFF"/><rect x="42" y="25" width="5" height="40" fill="#FFF"/><rect x="72" y="15" width="5" height="40" fill="#FFF"/><polygon points="42,25 77,15 77,25 42,35" fill="#FFD54F"/></svg>',
    "lit_vers": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="18" y="35" width="64" height="30" rx="4" fill="#ECEFF1" stroke="#37474F" stroke-width="3"/><line x1="26" y1="50" x2="74" y2="50" stroke="#C2185B" stroke-width="4" stroke-linecap="round"/></svg>',
    "lit_drama": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="36" cy="46" r="20" fill="#E91E63"/><circle cx="64" cy="46" r="20" fill="#7B1FA2"/><circle cx="32" cy="42" r="3" fill="#FFF"/><circle cx="40" cy="42" r="3" fill="#FFF"/><path d="M30,54 Q36,62 42,54" stroke="#FFF" stroke-width="2.5" fill="none"/><circle cx="60" cy="42" r="3" fill="#FFF"/><circle cx="68" cy="42" r="3" fill="#FFF"/><path d="M60,56 Q64,48 68,56" stroke="#FFF" stroke-width="2.5" fill="none"/></svg>',
    "lit_tragoedie": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#212121"/><circle cx="38" cy="42" r="4" fill="#FFF"/><circle cx="62" cy="42" r="4" fill="#FFF"/><path d="M35,66 Q50,50 65,66" stroke="#FFF" stroke-width="5" fill="none" stroke-linecap="round"/><circle cx="66" cy="50" r="3.5" fill="#42A5F5"/></svg>',
    "lit_komoedie": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FFD54F"/><circle cx="38" cy="42" r="5" fill="#3E2723"/><circle cx="62" cy="42" r="5" fill="#3E2723"/><path d="M34,58 Q50,76 66,58" stroke="#3E2723" stroke-width="6" fill="none" stroke-linecap="round"/></svg>',
    "lit_kapitel": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="16" width="56" height="68" rx="4" fill="#FFF8E1" stroke="#5D4037" stroke-width="3"/><text x="50" y="42" font-family="serif" font-weight="bold" font-size="16" fill="#C62828" text-anchor="middle">KAPITEL</text><text x="50" y="62" font-family="serif" font-weight="bold" font-size="18" fill="#3E2723" text-anchor="middle">I</text></svg>',
    "lit_handlung": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#37474F"/><path d="M22,65 Q35,35 50,55 T78,30" stroke="#00E5FF" stroke-width="6" fill="none" stroke-linecap="round"/><circle cx="78" cy="30" r="6" fill="#FFD54F"/></svg>',
    "lit_figur": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="30" r="14" fill="#FFB74D"/><path d="M26,82 C26,56 74,56 74,82 Z" fill="#6A1B9A"/><polygon points="50,15 54,23 63,23 56,29 58,37 50,32 42,37 44,29 37,23 46,23" fill="#FFD54F"/></svg>',
    "lit_fabel": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#E65100"/><polygon points="28,30 40,55 24,55" fill="#D84315"/><polygon points="72,30 60,55 76,55" fill="#D84315"/><polygon points="35,50 65,50 50,75" fill="#FFF"/><circle cx="50" cy="68" r="4" fill="#212121"/></svg>',
    "lit_daumen_druecken": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#43A047"/><rect x="35" y="40" width="30" height="35" rx="6" fill="#FFA726"/><path d="M35,40 C35,26 48,22 48,34 L48,40" stroke="#FFA726" stroke-width="8" stroke-linecap="round" fill="none"/><polygon points="72,25 76,34 85,34 78,40 80,48 72,43 64,48 66,40 59,34 68,34" fill="#FFD54F"/></svg>',
    "lit_schwein_haben": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#F48FB1"/><circle cx="50" cy="50" r="26" fill="#F06292"/><ellipse cx="50" cy="54" rx="12" ry="8" fill="#F8BBD0"/><circle cx="45" cy="54" r="2.5" fill="#880E4F"/><circle cx="55" cy="54" r="2.5" fill="#880E4F"/><circle cx="40" cy="40" r="3" fill="#212121"/><circle cx="60" cy="40" r="3" fill="#212121"/><polygon points="75,25 80,35 88,32" fill="#FFD54F"/></svg>',
    "lit_zwei_linke_haende": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#78909C"/><rect x="25" y="45" width="22" height="28" rx="4" fill="#FFB74D"/><path d="M25,45 C20,38 20,30 26,32 L26,45" stroke="#FFB74D" stroke-width="6" fill="none"/><rect x="53" y="45" width="22" height="28" rx="4" fill="#FFB74D"/><path d="M53,45 C48,38 48,30 54,32 L54,45" stroke="#FFB74D" stroke-width="6" fill="none"/></svg>',
    "lit_nerven_treten": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#D32F2F"/><path d="M25,50 L40,30 L55,70 L70,35 L80,50" stroke="#FFEB3B" stroke-width="5" fill="none" stroke-linecap="round" stroke-linejoin="round"/></svg>',
    "lit_inspiration": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#00ACC1"/><circle cx="50" cy="42" r="18" fill="#FFD54F"/><path d="M42,60 L58,60 L55,70 L45,70 Z" fill="#B0BEC5"/><polygon points="50,15 54,23 63,23 56,29 58,37 50,32 42,37 44,29 37,23 46,23" fill="#FFF"/></svg>',
    "lit_meisterwerk": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FFB300"/><rect x="26" y="24" width="48" height="52" rx="4" fill="#FFF8E1" stroke="#795548" stroke-width="3"/><polygon points="50,38 55,48 66,48 57,55 60,65 50,59 40,65 43,55 34,48 45,48" fill="#D81B60"/><circle cx="50" cy="53" r="4" fill="#FFD700"/></svg>'
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
            "description": f"Vector illustration for literature concept: {c['english']['word']}"
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
    
    if "literature_idioms_a2.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/history_civilizations_a2.json',",
            "'assets/content/vocabulary/history_civilizations_a2.json',\n    'assets/content/vocabulary/literature_idioms_a2.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم ربط literature_idioms_a2.json في lib/repositories/content_repository.dart")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "literature_idioms" not in cat_code:
        entry = """    CategoryMeta(
      id: 'literature_idioms',
      titleAr: 'الأدب والشعر والتعبيرات',
      titleDe: 'Literatur & Redewendungen',
      titleEn: 'Literature & Idioms',
      icon: Icons.menu_book_rounded,
      primaryColor: Color(0xFF6D4C41),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تسجيل قسم الأدب والشعر في lib/screens/categories_screen.dart")

# 6. تحديث فاحص الجودة الآلي validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 30", "TOTAL_VOCAB_CATEGORIES = 31")
    val_code = val_code.replace("TOTAL_CONCEPTS = 755", "TOTAL_CONCEPTS = 780")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 915", "TOTAL_SVG_ASSETS = 940")
    
    if "literature_idioms_a2.json" not in val_code:
        val_code = val_code.replace(
            "'history_civilizations_a2.json',",
            "'history_civilizations_a2.json',\n    'literature_idioms_a2.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث معايير الفحص في tests/validate_content.py (31 فئة، 780 مفهومًا، 940 أصلًا متجهيًا)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 054 Status (Completed - Level A2 Literature & Idioms Category)
- **Feature:** Category 31: Literature, Poetry & Expressive Idioms (`literature_idioms_a2.json`).
- **New Concepts:** 25 trilingual vocabulary items for poems, novels, drama, metaphors, proverbs, and popular cultural idioms (Daumen drücken, Schwein haben).
- **New Visuals:** 25 unique lightweight SVG vectors (`lit_*.svg`).
- **Milestone Reached:** 31 Vocabulary Categories | 780 Core Concepts | 35 Base Verbs | 15 Perfekt Forms | 80 Syntax Exercises | 24 Prepositions + 10 Temporal Systems | 5 Dialogues | 10 Grammar Engines | 940 Total SVG Icons.
- **Integration:** Active in ContentRepository, CategoriesScreen, Quiz & SRS flashcards.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 054 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 054 بنجاح تام!")
