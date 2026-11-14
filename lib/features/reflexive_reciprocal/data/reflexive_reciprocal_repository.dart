import '../models/reflexive_reciprocal_models.dart';

class ReflexiveReciprocalRepository {
  const ReflexiveReciprocalRepository();

  List<ReflexiveLessonUnit> getUnits() {
    return const [
      ReflexiveLessonUnit(
        id: 'rr_01',
        category: ReflexiveCategory.akkusativVsDativReflexive,
        titleAr: 'الْفَرْقُ بَيْنَ mich (نَصْبٌ) وَmir (جَرٌّ) عِنْدَ وُجُودِ مَفْعُولٍ ثَانٍ',
        titleEn: 'German Dativ Reflexive Triggered by a Direct Object',
        titleDe: 'Dativ-Reflexiv (Ich merke mir die Regel) vs. Akkusativ (Ich bereite mich vor)',
        exampleAr: 'أَحْفَظُ هَذِهِ الْقَاعِدَةَ فِي ذِهْنِي؛ وَأَغْسِلُ يَدَيَّ قَبْلَ الطَّعَامِ.',
        exampleEn: 'I keep this rule in mind; I wash my hands before eating.',
        exampleDe: 'Ich merke mir diese Regel (Dativ); ich wasche mir die Hände (Dativ).',
        ruleAr:
            'فِي الْعَرَبِيَّةِ وَالْإِنْجِلِيزِيَّةِ يَكْفِي ضَمِيرُ الْمِلْكِيَّةِ (يَدَيَّ / my hands)، أَمَّا فِي الْأَلْمَانِيَّةِ فَيَدُلُّ ضَمِيرُ Dativ (mir / dir) عَلَى الْمُسْتَفِيدِ إِذَا ذُكِرَ الْمَفْعُولُ الْمُبَاشِرُ.',
        ruleEn:
            'English uses possessive determiners ("my hands") rather than reflexive dative pronouns.',
        ruleDe:
            'Steht neben dem Reflexivpronomen ein zusätzliches Akkusativobjekt („diese Regel“, „die Hände“), muss das Reflexivpronomen im Dativ stehen: mir / dir / sich.',
        caseTag: 'mir (Dat) vs. mich (Akk)',
        pitfallAlertAr:
            'الْخَطَأُ الشَّائِعُ: قَوْلُ *Ich merke mich diese Regel؛ الصَّوَابُ «Ich merke mir diese Regel» لِوُجُودِ مَفْعُولٍ مَنْصُوبٍ (diese Regel).',
      ),
      ReflexiveLessonUnit(
        id: 'rr_02',
        category: ReflexiveCategory.trueReflexivesZeroEnglish,
        titleAr: 'أَفْعَالٌ انْعِكَاسِيَّةٌ فِي الْأَلْمَانِيَّةِ لَا تَقْبَلُ الضَّمِيرَ فِي الْإِنْجِلِيزِيَّةِ',
        titleEn: 'German Mandatory Reflexives vs. Non-Reflexive English Verbs',
        titleDe: 'Obligatorisches „sich“ (sich erinnern, sich setzen, sich ausruhen)',
        exampleAr: 'أَتَذَكَّرُ الْمِثَالَ جَيِّدًا، وَأُرَكِّزُ عَلَى الدَّرْسِ، وَأَسْتَرِيحُ قَلِيلًا.',
        exampleEn: 'I remember the example well, concentrate on the lesson, and rest a little.',
        exampleDe: 'Ich erinnere mich gut an das Beispiel, konzentriere mich auf die Lektion und ruhe mich kurz aus.',
        ruleAr:
            'أَفْعَالٌ مِثْلُ «تَذَكَّرَ، رَكَّزَ، اسْتَرَاحَ، جَلَسَ» لَا تَحْتَاجُ إِلَى «نَفْسَهُ» فِي الْعَرَبِيَّةِ وَلَا فِي الْإِنْجِلِيزِيَّةِ، لَكِنَّهَا تُلْزِمُ ضَمِيرَ «sich» فِي الْأَلْمَانِيَّةِ.',
        ruleEn:
            'Never add "-self" after English "remember", "concentrate", "relax", or "sit down".',
        ruleDe:
            'Viele Verben sind im Deutschen fest reflexiv („sich erinnern an“, „sich konzentrieren auf“, „sich beeilen“), ohne dass eine echte Selbsthandlung vorliegt.',
        caseTag: 'Echte Reflexiva',
        pitfallAlertAr:
            'احْذَرِ النَّقْلَ الْعَكْسِيَّ: لَا تَقُلْ فِي الْإِنْجِلِيزِيَّةِ *I remember myself، وَلَا تَحْذِفْ «mich» فِي الْأَلْمَانِيَّةِ *Ich erinnere an.',
      ),
      ReflexiveLessonUnit(
        id: 'rr_03',
        category: ReflexiveCategory.reciprocalTafaala,
        titleAr: 'وَزْنُ «تَفَاعَلَ» لِلْمُشَارَكَةِ مُقَابِلَ «each other» وَ«einander»',
        titleEn: 'Reciprocal Action: Arabic Tafāʿala vs. English & German Reciprocals',
        titleDe: 'Reziprozität: sich gegenseitig / einander vs. sich selbst',
        exampleAr: 'يَتَعَاوَنُ الزُّمَلَاءُ وَيُسَاعِدُونَ بَعْضَهُمْ بَعْضًا فِي الْمُرَاجَعَةِ.',
        exampleEn: 'The colleagues collaborate and help one another with the revision.',
        exampleDe: 'Die Kollegen arbeiten zusammen und helfen einander (oder: helfen sich gegenseitig) beim Wiederholen.',
        ruleAr:
            'صِيغَةُ «تَفَاعَلَ» (تَعَاوَنَ، تَبَادَلَ، تَحَاوَرَ) تَدُلُّ بِذَاتِهَا عَلَى الْمُشَارَكَةِ بَيْنَ طَرَفَيْنِ، وَيُؤَكَّدُ ذَلِكَ بِـ «بَعْضُهُمْ بَعْضًا».',
        ruleEn:
            'English strictly separates reflexive "They blamed themselves" from reciprocal "They blamed each other".',
        ruleDe:
            'Da „Sie helfen sich“ doppeldeutig sein kann (sich selbst oder gegenseitig), klärt „einander“ oder „sich gegenseitig“ die Wechselseitigkeit.',
        caseTag: 'تَفَاعَلَ • einander',
        pitfallAlertAr:
            'إِذَا أَرَدْتَ رَفْعَ اللَّبْسِ فِي الْأَلْمَانِيَّةِ بَيْنَ «سَاعَدُوا أَنْفُسَهُمْ» وَ«سَاعَدَ بَعْضُهُمْ بَعْضًا» فَاسْتَعْمِلْ «einander» أَوْ «sich gegenseitig».',
      ),
      ReflexiveLessonUnit(
        id: 'rr_04',
        category: ReflexiveCategory.arabicMutaawaMiddleVoice,
        titleAr: 'الْمُطَاوَعَةُ الْعَرَبِيَّةُ (انْفَعَلَ / تَفَعَّلَ) مُقَابِلَ الْأَفْعَالِ الْمُتَعَدِّيَةِ وَالِانْعِكَاسِيَّةِ',
        titleEn: 'Arabic Middle-Voice Mutaʿawa vs. German Reflexive Middle',
        titleDe: 'Medialkonstruktion: Die Tür öffnet sich / Das Problem löst sich',
        exampleAr: 'فَتَحْتُ الْبَابَ فَانْفَتَحَ؛ وَغَيَّرَ التَّدْرِيبُ النَّتِيجَةَ فَتَغَيَّرَتْ.',
        exampleEn: 'I opened the door and it opened; the practice changed the result, so it changed.',
        exampleDe: 'Die Tür öffnet sich von selbst; durch die Übung verändert sich das Ergebnis.',
        ruleAr:
            'تَتَحَوَّلُ الْجُمْلَةُ مِنَ التَّعْدِيَةِ إِلَى الْمُطَاوَعَةِ فِي الْعَرَبِيَّةِ صَرْفِيًّا (كَسَرَ ← انْكَسَرَ، غَيَّرَ ← تَغَيَّرَ)، بَيْنَمَا تَسْتَعْمِلُ الْأَلْمَانِيَّةُ «sich» مَعَ فَاعِلٍ غَيْرِ عَاقِلٍ.',
        ruleEn:
            'English uses labile/ergative verbs ("The door opened", "The result changed") with zero reflexive marker.',
        ruleDe:
            'Bei Vorgängen ohne sichtbaren menschlichen Verursacher nutzt das Deutsche oft reflexive Medialverben: „die Tür öffnet sich“, „es zeigt sich“.',
        caseTag: 'الْمُطَاوَعَةُ • sich',
        pitfallAlertAr:
            'لَا تَتَرْجِمْ «تَغَيَّرَ الْوَضْعُ» إِلَى *The situation changed itself بِالْإِنْجِلِيزِيَّةِ؛ الصَّوَابُ «The situation changed».',
      ),
      ReflexiveLessonUnit(
        id: 'rr_05',
        category: ReflexiveCategory.emphaticSelfhood,
        titleAr: 'الْفَرْقُ بَيْنَ الضَّمِيرِ الِانْعِكَاسِيِّ (sich) وَتَوْكِيدِ النَّفْسِ (selbst)',
        titleEn: 'Distinguishing Reflexive Object ("himself") from Emphatic "himself / selbst"',
        titleDe: 'Reflexivpronomen „sich“ vs. unveränderliches Fokuspartikel „selbst / selber“',
        exampleAr: 'أَعَدَّ الْمُحَاضِرُ نَفْسُهُ الْمُلَخَّصَ (تَوْكِيدٌ)؛ وَلَمْ يَمْدَحْ نَفْسَهُ (مَفْعُولٌ).',
        exampleEn: 'The lecturer himself prepared the summary; he did not praise himself.',
        exampleDe: 'Der Dozent selbst hat die Zusammenfassung erstellt; er lobte sich nicht.',
        ruleAr:
            'فِي الْعَرَبِيَّةِ تُعْرَبُ «نَفْسُهُ» تَوْكِيدًا مَعْنَوِيًّا مَرْفُوعًا إِذَا أَكَّدَتِ الْفَاعِلَ، وَمَفْعُولًا بِهِ مَنْصُوبًا إِذَا وَقَعَ عَلَيْهَا الْفِعْلُ.',
        ruleEn:
            'English uses the same "-self" form for both emphatic apposition ("he himself") and reflexive objects ("praised himself").',
        ruleDe:
            'Das deutsche „selbst“ (oder umgangssprachlich „selber“) ist unveränderlich und betont die Eigenständigkeit, während „sich“ das Objekt bezeichnet.',
        caseTag: 'selbst ≠ sich',
        pitfallAlertAr:
            'لَا تَسْتَبْدِلْ «selbst» بِـ «sich» فِي الْأَلْمَانِيَّةِ؛ إِذْ لَا يُقَالُ *Er selbst lobte بَدَلًا مِنْ «Er lobte sich».',
      ),
      ReflexiveLessonUnit(
        id: 'rr_06',
        category: ReflexiveCategory.prepositionalReflexiveCollocations,
        titleAr: 'الْأَفْعَالُ الِانْعِكَاسِيَّةُ الْمَقْرُونَةُ بِحَرْفِ جَرٍّ ثَابِتٍ',
        titleEn: 'Prepositional Reflexives & Da(r)-/Wo(r)- Compounds',
        titleDe: 'Reflexiv + Präposition: sich vorbereiten auf / sich interessieren für',
        exampleAr: 'يَسْتَعِدُّ الطَّالِبُ لِلِامْتِحَانِ، وَيَهْتَمُّ بِاللُّغَاتِ السَّامِيَّةِ وَالْجِرْمَانِيَّةِ.',
        exampleEn: 'The student prepares for the exam and is interested in comparative linguistics.',
        exampleDe: 'Der Student bereitet sich auf die Prüfung vor (+ Akk.) und interessiert sich für Sprachwissenschaft.',
        ruleAr:
            'تُقَابِلُ «اسْتَعَدَّ لِـ» وَ«اهْتَمَّ بِـ» فِي الْأَلْمَانِيَّةِ أَفْعَالًا انْعِكَاسِيَّةً مَقْرُونَةً بِحَرْفِ جَرٍّ ثَابِتٍ وَحَالَةٍ إِعْرَابِيَّةٍ مُحَدَّدَةٍ.',
        ruleEn:
            'English expresses these with intransitive + preposition ("prepare for") or participial adjective ("be interested in").',
        ruleDe:
            'Präpositionale Reflexivverben bilden Fragen mit „wo(r)+Präposition“ („Wofür interessierst du dich?“) bei Dingen und „Präposition+wen/wem“ bei Personen.',
        caseTag: 'sich + Präposition',
        pitfallAlertAr:
            'عِنْدَ السُّؤَالِ عَنْ شَيْءٍ غَيْرِ عَاقِلٍ مَعَ «sich interessieren für» قُلْ «Wofür interessierst du dich?» لَا *Für was... فِي اللُّغَةِ الْفَصِيحَةِ.',
      ),
    ];
  }

  List<ReflexiveDrillItem> getDrills() {
    return const [
      ReflexiveDrillItem(
        id: 'rrd_01',
        category: ReflexiveCategory.akkusativVsDativReflexive,
        targetLanguage: 'German',
        promptAr: 'اخْتَرِ الضَّمِيرَ الصَّحِيحَ لِوُجُودِ مَفْعُولٍ مَنْصُوبٍ ثَانٍ: «Ich merke ... diese Regel.»',
        promptEn: 'Choose the correct German reflexive pronoun when a direct object is present:',
        promptDe: 'Wählen Sie das richtige Reflexivpronomen: „Ich merke ... diese Regel.“',
        options: [
          'mich',
          'mir',
          'sich',
        ],
        correctIndex: 1,
        explanationAr: 'لِوُجُودِ مَفْعُولٍ مَنْصُوبٍ (diese Regel) يَأْتِي الضَّمِيرُ الِانْعِكَاسِيُّ فِي حَالَةِ Dativ: «mir».',
      ),
      ReflexiveDrillItem(
        id: 'rrd_02',
        category: ReflexiveCategory.trueReflexivesZeroEnglish,
        targetLanguage: 'English',
        promptAr: 'أَيُّ جُمْلَةٍ إِنْجِلِيزِيَّةٍ سَلِيمَةٌ لِلتَّعْبِيرِ عَنْ «أَتَذَكَّرُ الْمَوْعِدَ»؟',
        promptEn: 'Select the grammatical English sentence for recalling an appointment:',
        promptDe: 'Welcher englische Satz für „Ich erinnere mich an den Termin“ ist richtig?',
        options: [
          'I remember myself the appointment.',
          'I remember the appointment.',
          'I remember to me the appointment.',
        ],
        correctIndex: 1,
        explanationAr: 'الْفِعْلُ «remember» فِي الْإِنْجِلِيزِيَّةِ لَا يَأْخُذُ ضَمِيرًا انْعِكَاسِيًّا أَبَدًا.',
      ),
      ReflexiveDrillItem(
        id: 'rrd_03',
        category: ReflexiveCategory.reciprocalTafaala,
        targetLanguage: 'German',
        promptAr: 'أَيُّ كَلِمَةٍ تَرْفَعُ اللَّبْسَ وَتُؤَكِّدُ أَنَّ الْفِعْلَ مُتَبَادَلٌ بَيْنَ الطَّرَفَيْنِ (بَعْضُهُمْ بَعْضًا)؟',
        promptEn: 'Which German word unambiguously marks reciprocal action ("each other")?',
        promptDe: 'Welches Wort drückt eindeutig Wechselseitigkeit aus?',
        options: [
          'einander',
          'selbst',
          'allein',
        ],
        correctIndex: 0,
        explanationAr: '«einander» (أَوْ «sich gegenseitig») تُحَدِّدُ التَّبَادُلَ بَيْنَ الطَّرَفَيْنِ دُونَ لَبْسٍ.',
      ),
      ReflexiveDrillItem(
        id: 'rrd_04',
        category: ReflexiveCategory.arabicMutaawaMiddleVoice,
        targetLanguage: 'Arabic',
        promptAr: 'أَيُّ وَزْنٍ صَرْفِيٍّ يَدُلُّ عَلَى الْمُطَاوَعَةِ فِي: «كَسَرْتُ الزُّجَاجَ فـ ...»؟',
        promptEn: 'Which Arabic verb pattern expresses middle-voice mutaʿawa after "kasartu"?',
        promptDe: 'Welche arabische Verbform drückt das Resultat (Mutaʿawa) aus?',
        options: [
          'كَسَرَهُ',
          'انْكَسَرَ',
          'كَاسَرَ',
        ],
        correctIndex: 1,
        explanationAr: 'وَزْنُ «انْفَعَلَ» (انْكَسَرَ) هُوَ أَشْهَرُ أَوْزَانِ الْمُطَاوَعَةِ فِي الْعَرَبِيَّةِ.',
      ),
      ReflexiveDrillItem(
        id: 'rrd_05',
        category: ReflexiveCategory.emphaticSelfhood,
        targetLanguage: 'German',
        promptAr: 'كَيْفَ نُؤَكِّدُ أَنَّ الْمُدَرِّسَ بِنَفْسِهِ هُوَ الَّذِي كَتَبَ الْمُلَخَّصَ؟',
        promptEn: 'How do you say "The teacher himself wrote the summary" in German?',
        promptDe: 'Wie betont man „Der Lehrer persönlich“ im Deutschen?',
        options: [
          'Der Lehrer sich hat die Zusammenfassung geschrieben.',
          'Der Lehrer selbst hat die Zusammenfassung geschrieben.',
          'Der Lehrer mir hat die Zusammenfassung geschrieben.',
        ],
        correctIndex: 1,
        explanationAr: '«selbst» أَدَاةُ تَوْكِيدٍ لِلذَّاتِ تَعْنِي «بِنَفْسِهِ»، بَيْنَمَا «sich» ضَمِيرُ مَفْعُولٍ انْعِكَاسِيٌّ.',
      ),
      ReflexiveDrillItem(
        id: 'rrd_06',
        category: ReflexiveCategory.prepositionalReflexiveCollocations,
        targetLanguage: 'German',
        promptAr: 'مَا السُّؤَالُ الْفَصِيحُ عَنِ اهْتِمَامِ شَخْصٍ بِمَجَالٍ عِلْمِيٍّ (sich interessieren für)؟',
        promptEn: 'Choose the standard German question for "What are you interested in?":',
        promptDe: 'Wie fragt man standardsprachlich nach einem Sachthema bei „sich interessieren für“?',
        options: [
          'Wofür interessierst du dich?',
          'Wovon interessierst du dich?',
          'Für was interessierst du?',
        ],
        correctIndex: 0,
        explanationAr: 'الْفِعْلُ «sich interessieren für» يَأْخُذُ أَدَاةَ الِاسْتِفْهَامِ الْمُرَكَّبَةَ «Wofür» مَعَ ضَمِيرِ «dich».',
      ),
    ];
  }
}
