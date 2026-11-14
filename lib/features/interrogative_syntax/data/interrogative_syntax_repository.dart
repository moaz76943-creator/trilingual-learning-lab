import '../models/interrogative_syntax_models.dart';

class InterrogativeSyntaxRepository {
  const InterrogativeSyntaxRepository();

  List<InterrogativeLessonUnit> getUnits() {
    return const [
      InterrogativeLessonUnit(
        id: 'is_01',
        category: InterrogativeCategory.negativeQuestionsBalaDoch,
        titleAr: 'الْجَوَابُ عَنِ الِاسْتِفْهَامِ الْمَنْفِيِّ: «بَلَى» وَ«doch» مُقَابِلَ «Yes, I did»',
        titleEn: 'Answering Negative Questions: Arabic Balā & German Doch vs. English Yes',
        titleDe: 'Antwort auf verneinte Fragen: „doch“ (Zustimmung zum Gegenteil) vs. „nein“',
        exampleAr: 'أَلَمْ تَقْرَأِ الرِّسَالَةَ؟ — بَلَى، قَرَأْتُهَا الصَّبَاحَ!',
        exampleEn: 'Didn\'t you read the letter? — Yes, I did! I read it this morning.',
        exampleDe: 'Hast du den Brief nicht gelesen? — Doch, ich habe ihn heute Morgen gelesen!',
        ruleAr:
            'لِإِثْبَاتِ الْفِعْلِ بَعْدَ الِاسْتِفْهَامِ الْمَنْفِيِّ (أَلَمْ، أَلَيْسَ، أَمَا) تَسْتَعْمِلُ الْعَرَبِيَّةُ «بَلَى» حَصْرًا، بَيْنَمَا تَعْنِي «نَعَمْ» تَأْكِيدَ النَّفْيِ!',
        ruleEn:
            'English lacks a dedicated counter-affirmation particle, so it uses "Yes" plus an explicit positive auxiliary ("Yes, I did") to avoid ambiguity.',
        ruleDe:
            'Auf eine verneinte Entscheidungsfrage („nicht / kein“) antwortet man positiv mit „doch“ (entspricht exakt dem arabischen „بَلَى“), niemals mit einfachem *ja.',
        syntaxTag: 'بَلَى ↔ doch',
        pitfallAlertAr:
            'الْخَطَأُ الشَّائِعُ: الْإِجَابَةُ بِـ «نَعَمْ» عِنْدَ إِرَادَةِ الْإِثْبَاتِ بَعْدَ سُؤَالٍ مَنْفِيٍّ (*أَلَيْسَ مُفِيدًا؟ نَعَمْ، هُوَ مُفِيدٌ)؛ الصَّوَابُ «بَلَى» فِي الْعَرَبِيَّةِ وَ«doch» فِي الْأَلْمَانِيَّةِ.',
      ),
      InterrogativeLessonUnit(
        id: 'is_02',
        category: InterrogativeCategory.arabicPrepMaContraction,
        titleAr: 'حَذْفُ أَلِفِ «مَا» الِاسْتِفْهَامِيَّةِ وَمُرَكَّبَاتُ «wo(r)-» لِغَيْرِ الْعَاقِلِ',
        titleEn: 'Arabic Prep + "mā" Contraction (ʿamma, fīma) vs. German wo(r)- & English Stranding',
        titleDe: '„wo(r) + Präposition“ für Sachen (Worüber?) vs. „Präp. + wem/wen“ für Personen',
        exampleAr: 'عَمَّ تَتَحَدَّثُ، وَبِمَ تَسْتَعِينُ فِي بَحْثِكَ؟',
        exampleEn: 'What are you talking about, and what are you using in your research?',
        exampleDe: 'Worüber sprichst du, und womit arbeitest du bei deiner Forschung?',
        ruleAr:
            'تُحْذَفُ أَلِفُ «مَا» الِاسْتِفْهَامِيَّةِ وُجُوبًا إِذَا سُبِقَتْ بِحَرْفِ جَرٍّ (عَنْ+مَا=عَمَّ، فِي+مَا=فِيمَ، بِ+مَا=بِمَ، لِ+مَا=لِمَ) تَفْرِيقًا لَهَا عَنْ «مَا» الْمَوْصُولَةِ.',
        ruleEn:
            'English typically strands the preposition at the end of the question ("What are you talking about?"), reserving "About what..." for formal writing.',
        ruleDe:
            'Bei Dingen nutzt Deutsch „wo-“ (oder „wor-“ vor Vokal: worüber, worauf); bei Personen muss die Präposition mit „wem/wen“ stehen (Über wen?).',
        syntaxTag: 'عَمَّ / فِيمَ ↔ worüber',
        pitfallAlertAr:
            'لَا تَكْتُبْ أَلِفَ «مَا» الِاسْتِفْهَامِيَّةِ بَعْدَ حَرْفِ الْجَرِّ (*لِمَاذَا صَحِيحَةٌ لِأَنَّهَا مَزِيدَةٌ بِـ ذا، أَمَّا *لِمَا / *فِيمَا اسْتِفْهَامًا فَخَطَأٌ؛ الصَّوَابُ «لِمَ / فِيمَ»).',
      ),
      InterrogativeLessonUnit(
        id: 'is_03',
        category: InterrogativeCategory.spatialDirectionalWhere,
        titleAr: 'الْإِحَالَةُ الْمَكَانِيَّةُ الدَّقِيقَةُ: أَيْنَ وَإِلَى أَيْنَ وَمِنْ أَيْنَ (wo / wohin / woher)',
        titleEn: 'Static Location vs. Goal & Source: Arabic, German & English Where-Forms',
        titleDe: 'Drei W-Wörter für den Ort: „wo“ (Ruhe), „wohin“ (Ziel), „woher“ (Herkunft)',
        exampleAr: 'أَيْنَ تَسْكُنُ؟ وَإِلَى أَيْنَ تُسَافِرُ غَدًا؟ وَمِنْ أَيْنَ قَدِمْتَ؟',
        exampleEn: 'Where do you live? Where are you traveling to tomorrow? Where did you come from?',
        exampleDe: 'Wo wohnst du? Wohin reist du morgen? Woher kommst du?',
        ruleAr:
            'تُفَرِّقُ الْعَرَبِيَّةُ بَيْنَ السُّكُونِ (أَيْنَ) وَالْوِجْهَةِ (إِلَى أَيْنَ) وَالْمَصْدَرِ (مِنْ أَيْنَ) بِاسْتِعْمَالِ حُرُوفِ الْجَرِّ قَبْلَ «أَيْنَ».',
        ruleEn:
            'Modern English uses "where" for all three, optionally adding stranded "to" or mandatory "from" ("Where are you from?").',
        ruleDe:
            'Im Deutschen ist die Trennung strikt: „wo“ = Standort, „wohin“ = Richtung (oft getrennt: „Wo gehst du hin?“), „woher“ = Herkunft („Wo kommst du her?“).',
        syntaxTag: 'أَيْنَ / إِلَى / مِنْ ↔ wo / wohin / woher',
        pitfallAlertAr:
            'تَجَنَّبْ اسْتِعْمَالَ «wo» وَحْدَهَا مَعَ أَفْعَالِ الْحَرَكَةِ فِي الْأَلْمَانِيَّةِ (*Wo gehst du? خَطَأٌ؛ الصَّوَابُ «Wohin gehst du?»).',
      ),
      InterrogativeLessonUnit(
        id: 'is_04',
        category: InterrogativeCategory.indirectEmbeddedQuestions,
        titleAr: 'الِاسْتِفْهَامُ غَيْرُ الْمُبَاشِرِ: رُتْبَةُ الْفِعْلِ فِي «ob» وَالِاسْتِفْهَامِ الْمُدْمَجِ',
        titleEn: 'Embedded Questions: German Verb-Final "ob" vs. English No-Inversion SVO',
        titleDe: 'Nebensatz-Wortstellung bei indirekten Fragen („ob“ & W-Wort → Verb am Ende)',
        exampleAr: 'لَا أَعْلَمُ هَلْ يَصِلُ الْقِطَارُ فِي الْمَوْعِدِ أَمْ مَتَى يَبْدَأُ اللِّقَاءُ.',
        exampleEn: 'I do not know whether the train arrives on time or when the meeting starts.',
        exampleDe: 'Ich weiß nicht, ob der Zug pünktlich ankommt oder wann das Treffen beginnt.',
        ruleAr:
            'تَبْقَى أَدَاةُ الِاسْتِفْهَامِ (هَلْ، مَتَى، أَيْنَ) فِي صَدْرِ الْجُمْلَةِ الْمُضَمَّنَةِ دُونَ تَغْيِيرِ رُتْبَةِ الْفِعْلِ فِي الْعَرَبِيَّةِ.',
        ruleEn:
            'Embedded English questions drop "do"-support and restore normal Subject–Verb order ("when the meeting starts", NOT *when does the meeting start).',
        ruleDe:
            'Indirekte Fragen sind im Deutschen Nebensätze: „ob“ ersetzt Ja/Nein-Fragen, und das konjugierte Verb wandert ans Satzende.',
        syntaxTag: 'ob ... Verb-Ende • SVO',
        pitfallAlertAr:
            'خَطَأٌ شَائِعٌ فِي الْإِنْجِلِيزِيَّةِ: إِبْقَاءُ قَلْبِ السُّؤَالِ دَاخِلَ الْجُمْلَةِ (*Tell me where is the library؛ الصَّوَابُ «Tell me where the library is»).',
      ),
      InterrogativeLessonUnit(
        id: 'is_05',
        category: InterrogativeCategory.questionTagsConfirmation,
        titleAr: 'الِاسْتِفْهَامُ التَّقْرِيرِيُّ وَالْأَسْئِلَةُ الذَّيْلِيَّةُ (أَلَيْسَ كَذَلِكَ؟ / nicht wahr?)',
        titleEn: 'Confirmation Tags: Arabic & German Fixed Tags vs. English Echo Auxiliaries',
        titleDe: 'Vergewisserungsfragen: „nicht wahr? / oder?“ vs. englische Question Tags',
        exampleAr: 'الدَّرْسُ وَاضِحٌ، أَلَيْسَ كَذَلِكَ؟ وَأَنْتَ رَاجَعْتَ الْقَوَاعِدَ، أَلَيْسَ كَذَلِكَ؟',
        exampleEn: 'The lesson is clear, isn\'t it? And you reviewed the rules, didn\'t you?',
        exampleDe: 'Die Lektion ist klar, nicht wahr? Und du hast die Regeln wiederholt, oder?',
        ruleAr:
            'تَكْتَفِي الْعَرَبِيَّةُ بِتَعْبِيرٍ ثَابِتٍ فِي نِهَايَةِ الْجُمْلَةِ مِثْل «أَلَيْسَ كَذَلِكَ؟» مَهْمَا تَغَيَّرَ زَمَنُ الْفِعْلِ أَوْ ضَمِيرُهُ.',
        ruleEn:
            'English tags must mirror the tense, auxiliary, and subject pronoun with reversed polarity ("You reviewed..., didn\'t you?").',
        ruleDe:
            'Wie das Arabische nutzt Deutsch unveränderliche Anhängsel („nicht wahr?“, „oder?“, „stimmt\'s?“), ohne das Verb zu wiederholen.',
        syntaxTag: 'أَلَيْسَ كَذَلِكَ؟ ↔ nicht wahr? ↔ Aux+Pro',
        pitfallAlertAr:
            'لَا تَسْتَعْمِلْ *isn\'t it? فِي الْإِنْجِلِيزِيَّةِ لِكُلِّ الْجُمَلِ؛ إِذَا كَانَ الْفِعْلُ مَاضِيًا مَعَ ضَمِيرِ «you» فَالذَّيْلُ «didn\'t you?» وَلَيْسَ *isn\'t it?.',
      ),
      InterrogativeLessonUnit(
        id: 'is_06',
        category: InterrogativeCategory.selectiveWhichVsWhatKind,
        titleAr: 'التَّفْرِيقُ بَيْنَ «أَيُّ» لِلتَّعْيِينِ (welcher) وَالسُّؤَالِ عَنِ الصِّفَةِ (was für ein)',
        titleEn: 'Identifying a Specific Item ("which / welcher") vs. Asking Quality ("was für ein")',
        titleDe: 'Auswahl aus einer Gruppe („welcher?“) vs. Art/Qualität („was für ein?“)',
        exampleAr: 'أَيَّ كِتَابٍ اخْتَرْتَ مِنَ الرَّفِّ؟ وَمَا نَوْعُ الْقَلَمِ الَّذِي تَسْتَعْمِلُهُ؟',
        exampleEn: 'Which book did you choose from the shelf? And what kind of pen do you use?',
        exampleDe: 'Welches Buch hast du vom Regal gewählt? Und was für einen Stift benutzt du?',
        ruleAr:
            '«أَيُّ» فِي الْعَرَبِيَّةِ مُعْرَبَةٌ وَتُلَازِمُ الْإِضَافَةَ، وَتُفِيدُ التَّعْيِينَ مِنْ بَيْنَ مَجْمُوعَةٍ؛ أَمَّا السُّؤَالُ عَنِ الْمَاهِيَّةِ وَالصِّفَةِ فَيَكُونُ بِـ «مَا نَوْعُ / كَيْفَ».',
        ruleEn:
            'English uses "which" for a limited, known set and "what / what kind of" for an open category or quality.',
        ruleDe:
            '„welch-“ wird wie der bestimmte Artikel dekliniert (welcher/welches/welchen); bei „was für ein“ richtet sich nur „ein“ nach dem Kasus des Nomens (was für einen Stift).',
        syntaxTag: 'welch- ↔ أَيُّ • was für ein ↔ مَا نَوْعُ',
        pitfallAlertAr:
            'فِي الْأَلْمَانِيَّةِ «für» فِي تَرْكِيبِ «was für ein» لَا تَفْرِضُ حَالَةَ النَّصْبِ دَائِمًا؛ بَلْ مَوْقِعُ الِاسْمِ فِي الْجُمْلَةِ هُوَ الَّذِي يُحَدِّدُ الْإِعْرَابَ (مَثَلًا: Was für ein Buch liegt hier? [Nominativ]).',
      ),
    ];
  }

  List<InterrogativeDrillItem> getDrills() {
    return const [
      InterrogativeDrillItem(
        id: 'is_d1',
        category: InterrogativeCategory.negativeQuestionsBalaDoch,
        targetLanguage: 'DE',
        promptAr: 'سُئِلْتَ بِالْأَلْمَانِيَّةِ: «Kommst du heute nicht zum Kurs?» وَأَنْتَ سَتَحْضُرُ، فَبِمَاذَا تُجِيبُ؟',
        promptEn: 'You are asked "Kommst du heute nicht zum Kurs?" and you ARE coming. Choose the right reply:',
        promptDe: 'Welche Antwort drückt Zustimmung (ich komme) auf eine verneinte Frage aus?',
        options: [
          'Doch, ich komme gleich!',
          'Ja, ich komme nicht.',
          'Nein, ich komme gleich.',
        ],
        correctIndex: 0,
        explanationAr:
            'لِإِثْبَاتِ الْحُضُورِ رَدًّا عَلَى سُؤَالٍ مَنْفِيٍّ، تَسْتَعْمِلُ الْأَلْمَانِيَّةُ «Doch» (مِثْل «بَلَى» فِي الْعَرَبِيَّةِ).',
      ),
      InterrogativeDrillItem(
        id: 'is_d2',
        category: InterrogativeCategory.arabicPrepMaContraction,
        targetLanguage: 'AR',
        promptAr: 'اخْتَرِ الرَّسْمَ الْإِمْلَائِيَّ الصَّحِيحَ لِلسُّؤَالِ «About what are you asking?»:',
        promptEn: 'Choose the correct Arabic spelling for "preposition + interrogative mā":',
        promptDe: 'Welche arabische Schreibung von „عَنْ + مَا“ als Fragewort ist korrekt?',
        options: [
          'عَمَّ تَسْأَلُ؟',
          'عَمَّا تَسْأَلُ؟',
          'عَنْ مَا تَسْأَلُ؟',
        ],
        correctIndex: 0,
        explanationAr:
            'تُحْذَفُ أَلِفُ «مَا» الِاسْتِفْهَامِيَّةِ عِنْدَ دُخُولِ حَرْفِ الْجَرِّ وَتُدْغَمُ النُّونُ فِي الْمِيمِ: عَنْ + مَا = عَمَّ.',
      ),
      InterrogativeDrillItem(
        id: 'is_d3',
        category: InterrogativeCategory.spatialDirectionalWhere,
        targetLanguage: 'DE',
        promptAr: 'أَكْمِلِ السُّؤَالَ الْأَلْمَانِيَّ عَنِ الْوِجْهَةِ: «___ fährst du am Wochenende?» (إِلَى أَيْنَ؟):',
        promptEn: 'Complete the German directional question for "Where are you traveling to?":',
        promptDe: 'Ergänze das korrekte Richtungs-Fragewort:',
        options: [
          'Wohin',
          'Wo',
          'Woher',
        ],
        correctIndex: 0,
        explanationAr:
            'بِمَا أَنَّ الْفِعْلَ «fahren» يَدُلُّ عَلَى الْحَرَكَةِ نَحْوَ وِجْهَةٍ، فَالْأَدَاةُ الصَّحِيحَةُ هِيَ «Wohin».',
      ),
      InterrogativeDrillItem(
        id: 'is_d4',
        category: InterrogativeCategory.indirectEmbeddedQuestions,
        targetLanguage: 'EN',
        promptAr: 'اخْتَرِ السُّؤَالَ غَيْرَ الْمُبَاشِرِ السَّلِيمَ فِي الْإِنْجِلِيزِيَّةِ:',
        promptEn: 'Choose the grammatically accurate embedded question in English:',
        promptDe: 'Welcher indirekte englische Fragesatz hat die richtige Wortstellung?',
        options: [
          'Could you tell me when the library closes?',
          'Could you tell me when does the library close?',
          'Could you tell me when closes the library?',
        ],
        correctIndex: 0,
        explanationAr:
            'فِي السُّؤَالِ غَيْرِ الْمُبَاشِرِ بِالْإِنْجِلِيزِيَّةِ تَعُودُ الْجُمْلَةُ إِلَى التَّرْتِيبِ الْخَبَرِيِّ (SVO) وَيُحْذَفُ الْفِعْلُ الْمُسَاعِدُ «does».',
      ),
      InterrogativeDrillItem(
        id: 'is_d5',
        category: InterrogativeCategory.questionTagsConfirmation,
        targetLanguage: 'EN',
        promptAr: 'أَكْمِلِ السُّؤَالَ الذَّيْلِيَّ الْإِنْجِلِيزِيَّ: «She has already finished the task, ___?»',
        promptEn: 'Complete the English question tag accurately:',
        promptDe: 'Ergänze das passende englische Question Tag:',
        options: [
          'hasn\'t she',
          'isn\'t she',
          'didn\'t she',
        ],
        correctIndex: 0,
        explanationAr:
            'الْجُمْلَةُ فِي الْمُضَارِعِ التَّامِّ (has finished) مَعَ ضَمِيرِ «she»، فَيُعْكَسُ الْفِعْلُ الْمُسَاعِدُ نَفْسُهُ فِي الذَّيْلِ: hasn\'t she?.',
      ),
      InterrogativeDrillItem(
        id: 'is_d6',
        category: InterrogativeCategory.selectiveWhichVsWhatKind,
        targetLanguage: 'DE',
        promptAr: 'اخْتَرِ الْإِعْرَابَ السَّلِيمَ فِي: «___ Buch suchst du?» (سُؤَالٌ عَنْ نَوْعِ الْكِتَابِ، وَ«Buch» مُحَايِدٌ مَنْصُوبٌ):',
        promptEn: 'Choose the right German phrase for "What kind of book are you looking for?":',
        promptDe: 'Welche Form von „was für ein“ passt zu „das Buch“ im Akkusativ?',
        options: [
          'Was für ein Buch suchst du?',
          'Was für einen Buch suchst du?',
          'Welcher Buch suchst du?',
        ],
        correctIndex: 0,
        explanationAr:
            'كَلِمَةُ «das Buch» مُحَايِدَةٌ، وَصِيغَةُ «ein» لِلْمُحَايِدِ فِي النَّصْبِ (Akkusativ) تَبْقَى «ein»: Was für ein Buch.',
      ),
    ];
  }
}
