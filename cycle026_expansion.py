import json
import os

print("🚀 [CYCLE 026] بدء بناء قسم التعليم والمدرسة (Education & School)...")

# 1. قائمة المفاهيم الـ 25 لقسم التعليم والمدرسة
concepts = [
    {
        "id": "edu_school",
        "category": "education_school",
        "arabic": {"word": "المَدْرَسَةُ", "transliteration": "Al-Madrasah", "notes": "اسم مؤنث يدل على مؤسسة التعليم الأساسي والثانوي"},
        "german": {"article": "die", "word": "Schule", "plural": "die Schulen", "gender": "feminine", "example": "Die Kinder gehen um acht Uhr in die Schule."},
        "english": {"word": "school", "phonetic": "/skuːl/", "example": "School starts at eight o'clock in the morning."},
        "image_id": "img_edu_school"
    },
    {
        "id": "edu_classroom",
        "category": "education_school",
        "arabic": {"word": "الفَصْلُ الدِّرَاسِيُّ", "transliteration": "Al-Fasl Ad-Dirasi", "notes": "القاعة التعليمية داخل المدرسة"},
        "german": {"article": "das", "word": "Klassenzimmer", "plural": "die Klassenzimmer", "gender": "neuter", "example": "Unser Klassenzimmer ist groß und hell."},
        "english": {"word": "classroom", "phonetic": "/ˈklɑːs.ruːm/", "example": "Our classroom is bright and comfortable."},
        "image_id": "img_edu_classroom"
    },
    {
        "id": "edu_teacher_m",
        "category": "education_school",
        "arabic": {"word": "المُعَلِّمُ / الأُسْتَاذُ", "transliteration": "Al-Mu'allim", "notes": "المدرّس المذكر"},
        "german": {"article": "der", "word": "Lehrer", "plural": "die Lehrer", "gender": "masculine", "example": "Der Lehrer erklärt die Grammatik sehr geduldig."},
        "english": {"word": "teacher (male)", "phonetic": "/ˈtiː.tʃər/", "example": "The teacher explains the grammar clearly."},
        "image_id": "img_edu_teacher_m"
    },
    {
        "id": "edu_teacher_f",
        "category": "education_school",
        "arabic": {"word": "المُعَلِّمَةُ / الأُسْتَاذَةُ", "transliteration": "Al-Mu'allimah", "notes": "المدرّسة المؤنثة"},
        "german": {"article": "die", "word": "Lehrerin", "plural": "die Lehrerinnen", "gender": "feminine", "example": "Die Lehrerin stellt eine interessante Frage."},
        "english": {"word": "teacher (female)", "phonetic": "/ˈtiː.tʃər/", "example": "The female teacher asks an engaging question."},
        "image_id": "img_edu_teacher_f"
    },
    {
        "id": "edu_student_m",
        "category": "education_school",
        "arabic": {"word": "التِّلْمِيذُ / الطَّالِبُ", "transliteration": "At-Tilmeez", "notes": "المتعلم الذكر"},
        "german": {"article": "der", "word": "Schüler", "plural": "die Schüler", "gender": "masculine", "example": "Der Schüler macht seine Hausaufgaben sorgfältig."},
        "english": {"word": "pupil / student (male)", "phonetic": "/ˈpjuː.pəl/", "example": "The student completes his homework carefully."},
        "image_id": "img_edu_student_m"
    },
    {
        "id": "edu_student_f",
        "category": "education_school",
        "arabic": {"word": "التِّلْمِيذَةُ / الطَّالِبَةُ", "transliteration": "At-Tilmeezah", "notes": "المتعلمة الأنثى"},
        "german": {"article": "die", "word": "Schülerin", "plural": "die Schülerinnen", "gender": "feminine", "example": "Die Schülerin liest einen spannenden Text vor."},
        "english": {"word": "pupil / student (female)", "phonetic": "/ˈpjuː.pəl/", "example": "The student reads an exciting story aloud."},
        "image_id": "img_edu_student_f"
    },
    {
        "id": "edu_university",
        "category": "education_school",
        "arabic": {"word": "الجَامِعَةُ", "transliteration": "Al-Jami'ah", "notes": "مؤسسة التعليم العالي"},
        "german": {"article": "die", "word": "Universität", "plural": "die Universitäten", "gender": "feminine", "example": "Sie studiert Informatik an der Universität."},
        "english": {"word": "university", "phonetic": "/ˌjuː.nɪˈvɜː.sə.ti/", "example": "She studies computer science at the university."},
        "image_id": "img_edu_university"
    },
    {
        "id": "edu_library",
        "category": "education_school",
        "arabic": {"word": "المَكْتَبَةُ", "transliteration": "Al-Maktabah", "notes": "دار الكتب والمطالعة"},
        "german": {"article": "die", "word": "Bibliothek", "plural": "die Bibliotheken", "gender": "feminine", "example": "Wir lernen jeden Nachmittag in der Bibliothek."},
        "english": {"word": "library", "phonetic": "/ˈlaɪ.brər.i/", "example": "We study quietly in the campus library."},
        "image_id": "img_edu_library"
    },
    {
        "id": "edu_book",
        "category": "education_school",
        "arabic": {"word": "الكِتَابُ", "transliteration": "Al-Kitab", "notes": "مجلد القراءة أو التعلم"},
        "german": {"article": "das", "word": "Buch", "plural": "die Bücher", "gender": "neuter", "example": "Schlagt bitte eure Bücher auf Seite zwanzig auf."},
        "english": {"word": "book", "phonetic": "/bʊk/", "example": "Please open your course books to page twenty."},
        "image_id": "img_edu_book"
    },
    {
        "id": "edu_notebook",
        "category": "education_school",
        "arabic": {"word": "الدَّفْتَرُ / الكُرَّاسَةُ", "transliteration": "Ad-Daftar", "notes": "كراس التدوين والكتابة"},
        "german": {"article": "das", "word": "Heft", "plural": "die Hefte", "gender": "neuter", "example": "Ich notiere alle neuen Vokabeln in mein Heft."},
        "english": {"word": "notebook", "phonetic": "/ˈnəʊt.bʊk/", "example": "I write down all new vocabulary in my notebook."},
        "image_id": "img_edu_notebook"
    },
    {
        "id": "edu_pen",
        "category": "education_school",
        "arabic": {"word": "قَلَمُ الحِبْرِ الجَافُّ", "transliteration": "Qalam Al-Hibr", "notes": "أداة كتابة بالحبر"},
        "german": {"article": "der", "word": "Kugelschreiber", "plural": "die Kugelschreiber", "gender": "masculine", "example": "Hast du einen blauen Kugelschreiber für mich?"},
        "english": {"word": "ballpoint pen", "phonetic": "/ˈbɔːl.pɔɪnt pen/", "example": "Do you have an extra blue pen for me?"},
        "image_id": "img_edu_pen"
    },
    {
        "id": "edu_pencil",
        "category": "education_school",
        "arabic": {"word": "قَلَمُ الرَّصَاصِ", "transliteration": "Qalam Ar-Rasas", "notes": "قلم غرافيت قابل للمحو"},
        "german": {"article": "der", "word": "Bleistift", "plural": "die Bleistifte", "gender": "masculine", "example": "Zeichne die Skizze zuerst mit einem Bleistift."},
        "english": {"word": "pencil", "phonetic": "/ˈpen.səl/", "example": "Draw the diagram first using a sharp pencil."},
        "image_id": "img_edu_pencil"
    },
    {
        "id": "edu_eraser",
        "category": "education_school",
        "arabic": {"word": "المِمْحَاةُ", "transliteration": "Al-Mimhah", "notes": "أداة إزالة أثر الرصاص"},
        "german": {"article": "der", "word": "Radiergummi", "plural": "die Radiergummis", "gender": "masculine", "example": "Ich habe einen Fehler gemacht und brauche einen Radiergummi."},
        "english": {"word": "eraser / rubber", "phonetic": "/ɪˈreɪ.zər/", "example": "I made an error and need an eraser."},
        "image_id": "img_edu_eraser"
    },
    {
        "id": "edu_ruler",
        "category": "education_school",
        "arabic": {"word": "المِسْطَرَةُ", "transliteration": "Al-Mistarah", "notes": "أداة رسم الخطوط المستقيمة والقياس"},
        "german": {"article": "das", "word": "Lineal", "plural": "die Lineale", "gender": "neuter", "example": "Mit dem Lineal zieht er eine gerade Linie."},
        "english": {"word": "ruler", "phonetic": "/ˈruː.lər/", "example": "Draw a straight baseline using the plastic ruler."},
        "image_id": "img_edu_ruler"
    },
    {
        "id": "edu_backpack",
        "category": "education_school",
        "arabic": {"word": "الحَقِيبَةُ المَدْرَسِيَّةُ", "transliteration": "Al-Haqeebah Al-Madrasiyyah", "notes": "حقيبة حمل الكتب والدفاتر"},
        "german": {"article": "der", "word": "Schulranzen", "plural": "die Schulranzen", "gender": "masculine", "example": "Sein Schulranzen ist heute besonders schwer."},
        "english": {"word": "school bag / backpack", "phonetic": "/ˈskuːl.bæɡ/", "example": "His school backpack is quite heavy today."},
        "image_id": "img_edu_backpack"
    },
    {
        "id": "edu_blackboard",
        "category": "education_school",
        "arabic": {"word": "السَّبُّورَةُ", "transliteration": "As-Saboorah", "notes": "لوح الشرح في الفصل"},
        "german": {"article": "die", "word": "Tafel", "plural": "die Tafeln", "gender": "feminine", "example": "Die Lehrerin schreibt den neuen Satz an die Tafel."},
        "english": {"word": "blackboard / whiteboard", "phonetic": "/ˈblæk.bɔːd/", "example": "The teacher writes the sentence on the board."},
        "image_id": "img_edu_blackboard"
    },
    {
        "id": "edu_lesson",
        "category": "education_school",
        "arabic": {"word": "الدَّرْسُ / الحِصَّةُ", "transliteration": "Ad-Dars", "notes": "الحصة التعليمية المحددة"},
        "german": {"article": "die", "word": "Lektion", "plural": "die Lektionen", "gender": "feminine", "example": "Die heutige Deutschlektion war sehr lehrreich."},
        "english": {"word": "lesson", "phonetic": "/ˈles.ən/", "example": "Today's language lesson was very engaging."},
        "image_id": "img_edu_lesson"
    },
    {
        "id": "edu_homework",
        "category": "education_school",
        "arabic": {"word": "الوَاجِبُ المَنْزِلِيُّ", "transliteration": "Al-Wajib Al-Manzili", "notes": "التكاليف الدراسية للبيت"},
        "german": {"article": "die", "word": "Hausaufgabe", "plural": "die Hausaufgaben", "gender": "feminine", "example": "Hast du deine Hausaufgaben für morgen schon erledigt?"},
        "english": {"word": "homework", "phonetic": "/ˈhəʊm.wɜːk/", "example": "Have you finished your homework for tomorrow?"},
        "image_id": "img_edu_homework"
    },
    {
        "id": "edu_exam",
        "category": "education_school",
        "arabic": {"word": "الِامْتِحَانُ / الِاخْتِبَارُ", "transliteration": "Al-Imtihan", "notes": "تقييم تحصيل المتعلم"},
        "german": {"article": "die", "word": "Prüfung", "plural": "die Prüfungen", "gender": "feminine", "example": "Morgen schreiben wir eine wichtige Deutschprüfung."},
        "english": {"word": "exam / test", "phonetic": "/ɪɡˈzæm/", "example": "Tomorrow we have a crucial language exam."},
        "image_id": "img_edu_exam"
    },
    {
        "id": "edu_grade",
        "category": "education_school",
        "arabic": {"word": "العَلَامَةُ / الدَّرَجَةُ", "transliteration": "Al-'Alamah", "notes": "النتيجة الرقمية أو التقديرية"},
        "german": {"article": "die", "word": "Note", "plural": "die Noten", "gender": "feminine", "example": "Sie hat eine ausgezeichnete Note bekommen."},
        "english": {"word": "grade / mark", "phonetic": "/ɡreɪd/", "example": "She received an excellent grade in mathematics."},
        "image_id": "img_edu_grade"
    },
    {
        "id": "edu_question",
        "category": "education_school",
        "arabic": {"word": "السُّؤَالُ", "transliteration": "As-Su'al", "notes": "طلب المعرفة والاستفسار"},
        "german": {"article": "die", "word": "Frage", "plural": "die Fragen", "gender": "feminine", "example": "Darf ich dazu eine kurze Frage stellen?"},
        "english": {"word": "question", "phonetic": "/ˈkwes.tʃən/", "example": "May I ask a quick clarifying question?"},
        "image_id": "img_edu_question"
    },
    {
        "id": "edu_answer",
        "category": "education_school",
        "arabic": {"word": "الجَوَابُ / الإِجَابَةُ", "transliteration": "Al-Jawab", "notes": "رد على استفسار أو حل لمسألة"},
        "german": {"article": "die", "word": "Antwort", "plural": "die Antworten", "gender": "feminine", "example": "Deine Antwort war absolut richtig."},
        "english": {"word": "answer / reply", "phonetic": "/ˈɑːn.sər/", "example": "Your answer was completely accurate."},
        "image_id": "img_edu_answer"
    },
    {
        "id": "edu_dictionary",
        "category": "education_school",
        "arabic": {"word": "القَامُوسُ / المُعْجَمُ", "transliteration": "Al-Qamoos", "notes": "مرجع شرح المفردات وترجمتها"},
        "german": {"article": "das", "word": "Wörterbuch", "plural": "die Wörterbücher", "gender": "neuter", "example": "Schlage das unbekannte Wort im Wörterbuch nach."},
        "english": {"word": "dictionary", "phonetic": "/ˈdɪk.ʃən.ər.i/", "example": "Look up the unfamiliar term in the dictionary."},
        "image_id": "img_edu_dictionary"
    },
    {
        "id": "edu_break",
        "category": "education_school",
        "arabic": {"word": "الِاسْتِرَاحَةُ المَدْرَسِيَّةُ / الفُسْحَةُ", "transliteration": "Al-Istirahah", "notes": "فترة الراحة بين الدروس"},
        "german": {"article": "die", "word": "Schulpause", "plural": "die Schulpausen", "gender": "feminine", "example": "In der großen Pause spielen die Schüler auf dem Schulhof."},
        "english": {"word": "school recess / break", "phonetic": "/ˈriː.ses/", "example": "Students play football outside during the break."},
        "image_id": "img_edu_break"
    },
    {
        "id": "edu_desk",
        "category": "education_school",
        "arabic": {"word": "مَكْتَبُ الدِّرَاسَةِ", "transliteration": "Maktab Ad-Dirasah", "notes": "طاولة المذاكرة والكتابة"},
        "german": {"article": "der", "word": "Schreibtisch", "plural": "die Schreibtische", "gender": "masculine", "example": "Auf meinem Schreibtisch stehen eine Lampe und mein Laptop."},
        "english": {"word": "study desk", "phonetic": "/ˈstʌd.i desk/", "example": "Keep your study desk neat and tidy."},
        "image_id": "img_edu_desk"
    }
]

# حفظ ملف المفردات
os.makedirs("content/vocabulary", exist_ok=True)
vocab_path = "content/vocabulary/education_school_a1.json"
with open(vocab_path, "w", encoding="utf-8") as f:
    json.dump({
        "category_id": "education_school",
        "category_name": {
            "ar": "التعليم والمدرسة",
            "de": "Bildung & Schule",
            "en": "Education & School"
        },
        "level": "A1",
        "concepts": concepts
    }, f, ensure_ascii=False, indent=2)

print(f"✅ تم حفظ {len(concepts)} مفاهيم جديدة في {vocab_path}")

# 2. توليد 25 أيقونة SVG متجهية خفيفة عالية الدقة
os.makedirs("content/assets/svg", exist_ok=True)

svg_templates = {
    "edu_school": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="45" width="70" height="45" fill="#3F51B5" rx="3"/><polygon points="50,15 10,45 90,45" fill="#E91E63"/><rect x="42" y="60" width="16" height="30" fill="#FFE082"/><circle cx="50" cy="35" r="7" fill="#FFF"/><rect x="23" y="52" width="12" height="15" fill="#BBDEFB"/><rect x="65" y="52" width="12" height="15" fill="#BBDEFB"/></svg>',
    "edu_classroom": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="10" y="20" width="80" height="40" fill="#2E7D32" rx="3" stroke="#8D6E63" stroke-width="4"/><rect x="25" y="70" width="50" height="20" fill="#8D6E63" rx="2"/><rect x="35" y="62" width="30" height="8" fill="#FFC107" rx="2"/></svg>',
    "edu_teacher_m": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="30" r="14" fill="#FFA726"/><path d="M25,85 C25,58 65,58 65,85 Z" fill="#1E88E5"/><rect x="68" y="25" width="22" height="40" fill="#26A69A" rx="2"/><line x1="60" y1="45" x2="72" y2="35" stroke="#FFA726" stroke-width="3"/></svg>',
    "edu_teacher_f": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="45" cy="30" r="14" fill="#FFCC80"/><path d="M30,22 Q45,10 60,22 Q58,38 32,38 Z" fill="#6D4C41"/><path d="M25,85 C25,58 65,58 65,85 Z" fill="#8E24AA"/><rect x="68" y="25" width="22" height="40" fill="#43A047" rx="2"/></svg>',
    "edu_student_m": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="30" r="14" fill="#FFA726"/><path d="M30,85 C30,60 70,60 70,85 Z" fill="#FF7043"/><rect x="62" y="65" width="18" height="20" fill="#0288D1" rx="2"/></svg>',
    "edu_student_f": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="30" r="14" fill="#FFCC80"/><path d="M34,20 C42,12 58,12 66,20 C70,36 30,36 34,20 Z" fill="#4E342E"/><path d="M30,85 C30,60 70,60 70,85 Z" fill="#EC407A"/></svg>',
    "edu_university": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="50,15 15,35 85,35" fill="#455A64"/><rect x="22" y="35" width="8" height="45" fill="#90A4AE"/><rect x="40" y="35" width="8" height="45" fill="#90A4AE"/><rect x="58" y="35" width="8" height="45" fill="#90A4AE"/><rect x="74" y="35" width="8" height="45" fill="#90A4AE"/><rect x="15" y="80" width="70" height="10" fill="#37474F"/></svg>',
    "edu_library": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="15" width="70" height="75" fill="#5D4037" rx="3"/><rect x="22" y="22" width="10" height="25" fill="#E53935"/><rect x="34" y="22" width="12" height="25" fill="#1E88E5"/><rect x="48" y="22" width="10" height="25" fill="#FDD835"/><rect x="60" y="22" width="16" height="25" fill="#43A047"/><line x1="15" y1="50" x2="85" y2="50" stroke="#8D6E63" stroke-width="4"/><rect x="25" y="55" width="14" height="28" fill="#AB47BC"/><rect x="42" y="55" width="12" height="28" fill="#FB8C00"/><rect x="57" y="55" width="16" height="28" fill="#26C6DA"/></svg>',
    "edu_book": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M15,25 Q50,32 50,75 Q15,68 15,25 Z" fill="#E53935"/><path d="M85,25 Q50,32 50,75 Q85,68 85,25 Z" fill="#EF5350"/><line x1="50" y1="32" x2="50" y2="75" stroke="#B71C1C" stroke-width="3"/></svg>',
    "edu_notebook": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="15" width="55" height="70" fill="#42A5F5" rx="3"/><circle cx="20" cy="25" r="4" fill="#78909C"/><circle cx="20" cy="40" r="4" fill="#78909C"/><circle cx="20" cy="55" r="4" fill="#78909C"/><circle cx="20" cy="70" r="4" fill="#78909C"/><line x1="35" y1="30" x2="70" y2="30" stroke="#FFF" stroke-width="2"/><line x1="35" y1="45" x2="70" y2="45" stroke="#FFF" stroke-width="2"/><line x1="35" y1="60" x2="60" y2="60" stroke="#FFF" stroke-width="2"/></svg>',
    "edu_pen": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="44" y="20" width="12" height="50" fill="#1565C0" rx="2" transform="rotate(35 50 50)"/><polygon points="32,75 22,86 35,84" fill="#B0BEC5"/><circle cx="22" cy="86" r="2" fill="#0D47A1"/></svg>',
    "edu_pencil": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="43" y="18" width="14" height="50" fill="#FDD835" rx="1" transform="rotate(35 50 50)"/><polygon points="32,73 22,86 36,83" fill="#FFE082"/><polygon points="22,86 26,81 29,84" fill="#212121"/><rect x="64" y="18" width="14" height="8" fill="#F48FB1" transform="rotate(35 50 50)"/></svg>',
    "edu_eraser": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="35" width="25" height="30" fill="#E53935" rx="2"/><rect x="50" y="35" width="25" height="30" fill="#1E88E5" rx="2"/><line x1="50" y1="35" x2="50" y2="65" stroke="#FFF" stroke-width="2"/></svg>',
    "edu_ruler": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="38" width="70" height="24" fill="#FFB300" rx="2"/><line x1="25" y1="38" x2="25" y2="48" stroke="#3E2723" stroke-width="2"/><line x1="35" y1="38" x2="35" y2="45" stroke="#3E2723" stroke-width="2"/><line x1="45" y1="38" x2="45" y2="48" stroke="#3E2723" stroke-width="2"/><line x1="55" y1="38" x2="55" y2="45" stroke="#3E2723" stroke-width="2"/><line x1="65" y1="38" x2="65" y2="48" stroke="#3E2723" stroke-width="2"/><line x1="75" y1="38" x2="75" y2="45" stroke="#3E2723" stroke-width="2"/></svg>',
    "edu_backpack": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="28" y="30" width="44" height="52" fill="#E91E63" rx="10"/><rect x="35" y="55" width="30" height="22" fill="#C2185B" rx="4"/><path d="M38,30 C38,15 62,15 62,30" fill="none" stroke="#880E4F" stroke-width="6"/></svg>',
    "edu_blackboard": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="12" y="18" width="76" height="52" fill="#1B5E20" rx="3" stroke="#5D4037" stroke-width="4"/><line x1="20" y1="74" x2="10" y2="90" stroke="#5D4037" stroke-width="4"/><line x1="80" y1="74" x2="90" y2="90" stroke="#5D4037" stroke-width="4"/><rect x="40" y="66" width="12" height="4" fill="#FFF"/></svg>',
    "edu_lesson": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="20" y="15" width="60" height="70" fill="#ECEFF1" rx="4"/><line x1="30" y1="30" x2="70" y2="30" stroke="#37474F" stroke-width="4"/><line x1="30" y1="42" x2="65" y2="42" stroke="#78909C" stroke-width="3"/><line x1="30" y1="52" x2="68" y2="52" stroke="#78909C" stroke-width="3"/><line x1="30" y1="62" x2="55" y2="62" stroke="#78909C" stroke-width="3"/><polygon points="70,68 85,68 80,82" fill="#00C853"/></svg>',
    "edu_homework": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="15" width="50" height="70" fill="#FFF" rx="3" stroke="#9E9E9E" stroke-width="2"/><path d="M50,10 L30,25 L70,25 Z" fill="#FF9800"/><path d="M35,45 L43,53 L62,35" fill="none" stroke="#4CAF50" stroke-width="4"/><line x1="35" y1="65" x2="65" y2="65" stroke="#9E9E9E" stroke-width="3"/></svg>',
    "edu_exam": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="22" y="15" width="56" height="70" fill="#FAFAFA" rx="3" stroke="#616161" stroke-width="2"/><circle cx="65" cy="35" r="12" fill="none" stroke="#D32F2F" stroke-width="3"/><text x="60" y="40" font-family="sans-serif" font-weight="bold" font-size="14" fill="#D32F2F">A+</text><line x1="30" y1="30" x2="48" y2="30" stroke="#757575" stroke-width="3"/><line x1="30" y1="45" x2="48" y2="45" stroke="#757575" stroke-width="3"/><line x1="30" y1="60" x2="68" y2="60" stroke="#757575" stroke-width="3"/></svg>',
    "edu_grade": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FFD54F"/><circle cx="50" cy="50" r="30" fill="#FFA000"/><text x="50" y="60" font-family="sans-serif" font-weight="bold" font-size="28" fill="#FFF" text-anchor="middle">100</text></svg>',
    "edu_question": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#0288D1"/><text x="50" y="68" font-family="sans-serif" font-weight="bold" font-size="52" fill="#FFF" text-anchor="middle">?</text></svg>',
    "edu_answer": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#2E7D32"/><path d="M30,50 L44,64 L72,36" fill="none" stroke="#FFF" stroke-width="8" stroke-linecap="round"/></svg>',
    "edu_dictionary": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="25" y="15" width="55" height="70" fill="#311B92" rx="4"/><rect x="20" y="15" width="10" height="70" fill="#D50000"/><text x="44" y="45" font-family="sans-serif" font-weight="bold" font-size="18" fill="#FFF">A-Z</text><line x1="42" y1="58" x2="68" y2="58" stroke="#FFE082" stroke-width="3"/><line x1="42" y1="68" x2="62" y2="68" stroke="#FFE082" stroke-width="3"/></svg>',
    "edu_break": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="38" fill="#FF7043"/><circle cx="50" cy="50" r="30" fill="#FFF"/><line x1="50" y1="50" x2="50" y2="30" stroke="#D84315" stroke-width="4" stroke-linecap="round"/><line x1="50" y1="50" x2="65" y2="50" stroke="#D84315" stroke-width="4" stroke-linecap="round"/><circle cx="50" cy="50" r="4" fill="#D84315"/></svg>',
    "edu_desk": '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><rect x="15" y="42" width="70" height="12" fill="#795548" rx="2"/><rect x="22" y="54" width="8" height="34" fill="#5D4037"/><rect x="70" y="54" width="8" height="34" fill="#5D4037"/><rect x="30" y="24" width="22" height="18" fill="#42A5F5" rx="1"/><rect x="62" y="22" width="6" height="20" fill="#FFCA28"/></svg>'
}

# كتابة ملفات الـ SVG
for c in concepts:
    c_id = c["id"]
    svg_content = svg_templates[c_id]
    svg_file = f"content/assets/svg/{c_id}.svg"
    with open(svg_file, "w", encoding="utf-8") as f:
        f.write(svg_content)

print(f"✅ تم إنشاء {len(concepts)} ملفات SVG بنجاح في content/assets/svg/")

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
            "description": f"Vector illustration for {c['english']['word']}"
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
    
    if "education_school_a1.json" not in repo_code:
        repo_code = repo_code.replace(
            "'assets/content/vocabulary/hobbies_sports_a1.json',",
            "'assets/content/vocabulary/hobbies_sports_a1.json',\n    'assets/content/vocabulary/education_school_a1.json',"
        )
        with open(content_repo_path, "w", encoding="utf-8") as f:
            f.write(repo_code)
        print("✅ تم تحديث lib/repositories/content_repository.dart بنجاح")
    else:
        print("ℹ️ قسم التعليم موجود مسبقاً في ContentRepository")

# 5. تحديث CategoriesScreen في Dart
cat_screen_path = "lib/screens/categories_screen.dart"
if os.path.exists(cat_screen_path):
    with open(cat_screen_path, "r", encoding="utf-8") as f:
        cat_code = f.read()

    if "education_school" not in cat_code:
        entry = """    CategoryMeta(
      id: 'education_school',
      titleAr: 'التعليم والمدرسة',
      titleDe: 'Bildung & Schule',
      titleEn: 'Education & School',
      icon: Icons.school,
      primaryColor: Color(0xFF3949AB),
    ),
"""
        cat_code = cat_code.replace("  static const List<CategoryMeta> all = [", "  static const List<CategoryMeta> all = [\n" + entry)
        with open(cat_screen_path, "w", encoding="utf-8") as f:
            f.write(cat_code)
        print("✅ تم تحديث lib/screens/categories_screen.dart بنجاح")
    else:
        print("ℹ️ قسم التعليم موجود مسبقاً في CategoriesScreen")

# 6. تحديث فاحص الجودة validate_content.py
val_path = "tests/validate_content.py"
if os.path.exists(val_path):
    with open(val_path, "r", encoding="utf-8") as f:
        val_code = f.read()
    
    val_code = val_code.replace("TOTAL_VOCAB_CATEGORIES = 14", "TOTAL_VOCAB_CATEGORIES = 15")
    val_code = val_code.replace("TOTAL_CONCEPTS = 355", "TOTAL_CONCEPTS = 380")
    val_code = val_code.replace("TOTAL_SVG_ASSETS = 395", "TOTAL_SVG_ASSETS = 420")
    
    if "education_school_a1.json" not in val_code:
        val_code = val_code.replace(
            "'hobbies_sports_a1.json',",
            "'hobbies_sports_a1.json',\n    'education_school_a1.json',"
        )
    with open(val_path, "w", encoding="utf-8") as f:
        f.write(val_code)
    print("✅ تم تحديث tests/validate_content.py بالمعايير الجديدة (15 فئة، 380 مفهومًا، 420 SVG)")

# 7. تحديث docs/PROJECT_STATE.md
state_path = "docs/PROJECT_STATE.md"
if os.path.exists(state_path):
    with open(state_path, "r", encoding="utf-8") as f:
        state_content = f.read()
    
    state_content += """
## Cycle 026 Status (Completed)
- **Feature:** Category 15: Education & School (`education_school_a1.json`).
- **New Concepts:** 25 trilingual education concepts.
- **New Visuals:** 25 unique lightweight SVG vectors (`edu_*.svg`).
- **Total Milestone:** 15 Vocabulary Categories | 380 Core Concepts | 420 Total SVG Icons.
- **Integrated:** Live in ContentRepository, CategoriesScreen, Quiz & Instant Search.
"""
    with open(state_path, "w", encoding="utf-8") as f:
        f.write(state_content)
    print("✅ تم توثيق الدورة 026 في docs/PROJECT_STATE.md")

print("✨ اكتمل تنفيذ كود CYCLE 026 بنجاح تام!")
