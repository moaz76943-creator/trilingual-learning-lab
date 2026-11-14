import '../models/passive_voice_models.dart';

class PassiveVoiceRepository {
  const PassiveVoiceRepository();

  List<PassiveComparisonUnit> getUnits() {
    return const [
      PassiveComparisonUnit(
        id: 'pv_01',
        type: PassiveConstructionType.processualVsStatal,
        titleAr: 'الْفَرْقُ بَيْنَ الْفِعْلِ الْحَدَثِيِّ (werden) وَالْحَالَةِ النَّاتِجَةِ (sein)',
        titleEn: 'Action-in-Progress vs. Resulting State in Passive Constructions',
        titleDe: 'Vorgangspassiv (werden) vs. Zustandspassiv (sein)',
        activeOrBaseAr: 'فَتَحَ أَمِينُ الْمَكْتَبَةِ الْقَاعَةَ السَّاعَةَ الثَّامِنَةَ.',
        passiveFormAr: 'فُتِحَتِ الْقَاعَةُ السَّاعَةَ الثَّامِنَةَ (حَدَثٌ)؛ وَالْقَاعَةُ مَفْتُوحَةٌ الْآنَ (حَالَةٌ).',
        activeOrBaseEn: 'The librarian opens the hall at eight.',
        passiveFormEn: 'The hall is opened at eight (process); the hall is open now (state).',
        activeOrBaseDe: 'Der Bibliothekar öffnet den Saal um acht Uhr.',
        passiveFormDe: 'Der Saal wird um acht Uhr geöffnet (Vorgang); jetzt ist der Saal geöffnet (Zustand).',
        ruleAr:
            'تُفَرِّقُ الْعَرَبِيَّةُ بَيْنَ الْحَدَثِ بِالْفِعْلِ الْمَبْنِيِّ لِلْمَجْهُولِ (فُتِحَتْ) وَالْحَالَةِ بِاسْمِ الْمَفْعُولِ (مَفْتُوحَةٌ)، كَمَا تُفَرِّقُ الْأَلْمَانِيَّةُ بَيْنَ «wird» وَ«ist».',
        ruleEn:
            'English uses "be + past participle" for passive events and often switches to an adjective ("is open") for resulting states.',
        ruleDe:
            'Das Vorgangspassiv (werden + Partizip II) beschreibt einen Prozess; das Zustandspassiv (sein + Partizip II) beschreibt das Ergebnis.',
        pitfallAlertAr:
            'لَا تَسْتَعْمِلْ «ist geöffnet» عِنْدَمَا تَقْصِدُ أَنَّ شَخْصًا يَقُومُ بِفَتْحِهِ الْآنَ؛ فَالْحَدَثُ الْجَارِي يَتَطَلَّبُ «wird geöffnet».',
        auxiliaryTag: 'wird vs. ist',
      ),
      PassiveComparisonUnit(
        id: 'pv_02',
        type: PassiveConstructionType.arabicMajhulVocalization,
        titleAr: 'ضَبْطُ الْمَجْهُولِ الْعَرَبِيِّ وَالْمَاضِي التَّامِّ الْأَلْمَانِيِّ (worden)',
        titleEn: 'Arabic Majhul Vocalic Melody & German Perfekt Passive ("worden")',
        titleDe: 'Perfekt Passiv: ist + Partizip II + worden (ohne ge-!)',
        activeOrBaseAr: 'كَتَبَ الْبَاحِثُ التَّقْرِيرَ ← يَكْتُبُ الْبَاحِثُ التَّقْرِيرَ.',
        passiveFormAr: 'كُتِبَ التَّقْرِيرُ (مَاضٍ) ← يُكْتَبُ التَّقْرِيرُ (مُضَارِعٌ).',
        activeOrBaseEn: 'The researcher has written the report.',
        passiveFormEn: 'The report has been written.',
        activeOrBaseDe: 'Der Forscher hat den Bericht geschrieben.',
        passiveFormDe: 'Der Bericht ist geschrieben worden.',
        ruleAr:
            'يُبْنَى الْمَاضِي لِلْمَجْهُولِ بِضَمِّ أَوَّلِهِ وَكَسْرِ مَا قَبْلَ آخِرِهِ (كُتِبَ)، وَالْمُضَارِعُ بِضَمِّ أَوَّلِهِ وَفَتْحِ مَا قَبْلَ آخِرِهِ (يُكْتَبُ).',
        ruleEn:
            'English forms the present perfect passive with "has/have + been + past participle".',
        ruleDe:
            'Im Perfekt Passiv verwendet das Deutsche das Hilfsverb „sein“ und die verkürzte Form „worden“ (nicht *geworden!).',
        pitfallAlertAr:
            'تَذَكَّرْ: «ist geschrieben worden» (بِدُونِ ge-) لِلْمَجْهُولِ، أَمَّا «ist Lehrer geworden» (بِـ ge-) فَمَعْنَاهَا «أَصْبَحَ مُعَلِّمًا».',
        auxiliaryTag: 'worden (kein ge-)',
      ),
      PassiveComparisonUnit(
        id: 'pv_03',
        type: PassiveConstructionType.agentAndInstrument,
        titleAr: 'حُرُوفُ الْفَاعِلِ وَالْوَسِيلَةِ فِي الْمَبْنِيِّ لِلْمَجْهُولِ (von / durch)',
        titleEn: 'Distinguishing Agent ("von / by") from Means ("durch / with")',
        titleDe: 'Agens & Mittel: von (+ Dativ, Urheber) vs. durch (+ Akkusativ, Mittel)',
        activeOrBaseAr: 'حَقَّقَتِ الْمُؤَسَّسَةُ النَّجَاحَ بِالتَّخْطِيطِ السَّلِيمِ.',
        passiveFormAr: 'تَحَقَّقَ النَّجَاحُ بِالتَّخْطِيطِ السَّلِيمِ (أُسْنِدَ إِلَى الْمُبَاشِرِ بِدُونِ ذِكْرِ الْفَاعِلِ أَصَالَةً).',
        activeOrBaseEn: 'The committee verified the data using automated checks.',
        passiveFormEn: 'The data was verified by the committee through automated checks.',
        activeOrBaseDe: 'Der Ausschuss prüfte die Daten durch automatisierte Tests.',
        passiveFormDe: 'Die Daten wurden vom Ausschuss (+ Dativ) durch automatisierte Tests (+ Akk.) geprüft.',
        ruleAr:
            'الْأَصْلُ فِي الْمَبْنِيِّ لِلْمَجْهُولِ الْعَرَبِيِّ حَذْفُ الْفَاعِلِ تَمَامًا؛ لِذَا سُمِّيَ «لِلْمَجْهُولِ» أَوْ «لِمَا لَمْ يُسَمَّ فَاعِلُهُ».',
        ruleEn:
            'English introduces human/institutional agents with "by" and instruments/methods with "with" or "through".',
        ruleDe:
            'Im deutschen Passiv steht „von + Dativ“ für handelnde Personen/Institutionen und „durch + Akkusativ“ für Mittel, Verfahren oder Naturkräfte.',
        pitfallAlertAr:
            'تَجَنَّبِ اسْتِعْمَالَ «von» مَعَ الْوَسَائِلِ غَيْرِ الْعَاقِلَةِ مِثْلَ *von einem Test؛ الصَّوَابُ «durch einen Test».',
        auxiliaryTag: 'von (Dat) vs. durch (Akk)',
      ),
      PassiveComparisonUnit(
        id: 'pv_04',
        type: PassiveConstructionType.impersonalAndPrepositionalPassive,
        titleAr: 'بِنَاءُ اللَّازِمِ لِلْمَجْهُولِ وَنِيَابَةُ الْجَارِّ وَالْمَجْرُورِ',
        titleEn: 'Impersonal Passives from Intransitive Verbs & Prepositional Passives',
        titleDe: 'Unpersönliches Passiv ohne Subjekt (Es wird heute fleißig gelernt)',
        activeOrBaseAr: 'يَجْتَهِدُ الطُّلَّابُ فِي الْمَكْتَبَةِ الْيَوْمَ.',
        passiveFormAr: 'نُظِرَ فِي الْمَسْأَلَةِ؛ وَيُجْتَهَدُ فِي الْمَكْتَبَةِ الْيَوْمَ.',
        activeOrBaseEn: 'Everyone is working diligently in the library today.',
        passiveFormEn: 'The matter was looked into; diligent work is being done today.',
        activeOrBaseDe: 'Man lernt heute fleißig in der Bibliothek.',
        passiveFormDe: 'Es wird heute in der Bibliothek fleißig gelernt. / In der Bibliothek wird heute gelernt.',
        ruleAr:
            'يُنَابُ الْجَارُّ وَالْمَجْرُورُ مَنَابَ الْفَاعِلِ فِي الْعَرَبِيَّةِ إِذَا كَانَ الْفِعْلُ لَازِمًا: «نُظِرَ فِي الْمَسْأَلَةِ».',
        ruleEn:
            'English allows prepositional passives ("The issue was looked into"), stranding the preposition at the end.',
        ruleDe:
            'Im unpersönlichen Passiv steht „es“ nur als Vorfeld-Platzhalter; rückt ein anderes Satzglied nach vorn, fällt „es“ weg, und das Verb bleibt 3. Person Singular.',
        pitfallAlertAr:
            'عِنْدَ تَقْدِيمِ الظَّرْفِ فِي الْمَجْهُولِ غَيْرِ الشَّخْصِيِّ بِالْأَلْمَانِيَّةِ يَسْقُطُ «es»: «Heute wird gelernt» (لَا *Heute wird es gelernt).',
        auxiliaryTag: 'Unpersönliches Passiv',
      ),
      PassiveComparisonUnit(
        id: 'pv_05',
        type: PassiveConstructionType.modalPassiveClusters,
        titleAr: 'اجْتِمَاعُ الْفِعْلِ النَّاقِصِ مَعَ الْمَبْنِيِّ لِلْمَجْهُولِ',
        titleEn: 'Modal Verb + Passive Infinitive Across Tenses',
        titleDe: 'Passiv mit Modalverben: muss geprüft werden / musste geprüft werden',
        activeOrBaseAr: 'يَجِبُ أَنْ يُرَاجِعَ الْمُحَرِّرُ النَّصَّ قَبْلَ الطِّبَاعَةِ.',
        passiveFormAr: 'يَجِبُ أَنْ يُرَاجَعَ النَّصُّ قَبْلَ الطِّبَاعَةِ.',
        activeOrBaseEn: 'The editor must review the text before printing.',
        passiveFormEn: 'The text must be reviewed before printing.',
        activeOrBaseDe: 'Der Redakteur muss den Text vor dem Druck prüfen.',
        passiveFormDe: 'Der Text muss vor dem Druck geprüft werden.',
        ruleAr:
            'يَبْقَى الْفِعْلُ الْأَوَّلُ (يَجِبُ) مَبْنِيًّا لِلْمَعْلُومِ وَيُبْنَى الْمُضَارِعُ بَعْدَ «أَنْ» لِلْمَجْهُولِ (أَنْ يُرَاجَعَ).',
        ruleEn:
            'English places "be + past participle" immediately after the modal auxiliary ("must be reviewed").',
        ruleDe:
            'Bei Modalverben im Passiv steht das konjugierte Modalverb auf Position 2, und am Satzende folgt „Partizip II + werden“.',
        pitfallAlertAr:
            'لَا تَخْلِطْ بَيْنَ «muss prüfen» (مَعْلُومٌ: يَجِبُ أَنْ يَفْحَصَ) وَ«muss geprüft werden» (مَجْهُولٌ: يَجِبُ أَنْ يُفْحَصَ).',
        auxiliaryTag: 'Modal + Partizip II + werden',
      ),
      PassiveComparisonUnit(
        id: 'pv_06',
        type: PassiveConstructionType.passiveAlternatives,
        titleAr: 'الْبَدَائِلُ الدَّلَالِيَّةُ لِلْمَجْهُولِ: «قَابِلٌ لِـ» وَ«sich lassen» وَ«-bar»',
        titleEn: 'Active-Form Passive Equivalents ("-able", "sich lassen", "zu + Inf.")',
        titleDe: 'Passiversatzformen: sich lassen, sein + zu + Infinitiv, -bar',
        activeOrBaseAr: 'يُمْكِنُ أَنْ تُفْهَمَ هَذِهِ الْقَاعِدَةُ بِسُهُولَةٍ.',
        passiveFormAr: 'هَذِهِ الْقَاعِدَةُ قَابِلَةٌ لِلْفَهْمِ، وَيَتَيَسَّرُ شَرْحُهَا.',
        activeOrBaseEn: 'This rule can be understood easily / is easy to understand.',
        passiveFormEn: 'This rule is easily understandable.',
        activeOrBaseDe: 'Diese Regel kann leicht verstanden werden.',
        passiveFormDe: 'Diese Regel lässt sich leicht verstehen / ist leicht verständlich / ist zu beachten.',
        ruleAr:
            'تَسْتَغْنِي الْعَرَبِيَّةُ عَنِ الْمَجْهُولِ بِأَفْعَالِ الْمُطَاوَعَةِ (انْكَسَرَ، تَيَسَّرَ) أَوْ بِعِبَارَةِ «قَابِلٌ لِـ».',
        ruleEn:
            'English expresses passive potentiality productively using "-able / -ible" adjectives ("readable", "verifiable").',
        ruleDe:
            '„Sich lassen + Infinitiv“ und Adjektive auf „-bar“ ersetzen „können + Passiv“; „sein + zu + Infinitiv“ ersetzt „müssen/können + Passiv“.',
        pitfallAlertAr:
            'الْفِعْلُ «ist zu beachten» يَحْمِلُ مَعْنَى الْإِلْزَامِ الْمَجْهُولِ (يَجِبُ أَنْ يُرَاعَى / must be observed) رَغْمَ خُلُوِّهِ مِنْ «muss» و«werden».',
        auxiliaryTag: 'sich lassen / -bar / zu',
      ),
    ];
  }

  List<PassiveDrillQuestion> getDrills() {
    return const [
      PassiveDrillQuestion(
        id: 'pvd_01',
        type: PassiveConstructionType.processualVsStatal,
        targetLanguage: 'German',
        promptAr: 'أَيُّ جُمْلَةٍ تَصِفُ الْحَالَةَ النَّاتِجَةَ (Zustandspassiv) لِكَوْنِ النَّافِذَةِ مَفْتُوحَةً الْآنَ؟',
        promptEn: 'Which German sentence expresses the resulting state (window is open now)?',
        promptDe: 'Welcher Satz beschreibt den Zustand (Zustandspassiv)?',
        options: [
          'Das Fenster wird gerade geöffnet.',
          'Das Fenster ist geöffnet.',
          'Das Fenster wurde geöffnet.',
        ],
        correctIndex: 1,
        explanationAr: '«ist geöffnet» (sein + Partizip II) تَصِفُ الْحَالَةَ الْقَائِمَةَ (Zustandspassiv).',
      ),
      PassiveDrillQuestion(
        id: 'pvd_02',
        type: PassiveConstructionType.arabicMajhulVocalization,
        targetLanguage: 'German',
        promptAr: 'مَا الصِّيغَةُ الصَّحِيحَةُ لِلْمَاضِي التَّامِّ الْمَبْنِيِّ لِلْمَجْهُولِ فِي الْأَلْمَانِيَّةِ؟',
        promptEn: 'Choose the correct German Perfekt Passiv sentence:',
        promptDe: 'Wählen Sie die korrekte Perfekt-Passiv-Form:',
        options: [
          'Der Brief ist schon geschrieben geworden.',
          'Der Brief ist schon geschrieben worden.',
          'Der Brief hat schon geschrieben worden.',
        ],
        correctIndex: 1,
        explanationAr: 'الْمَاضِي التَّامُّ الْمَجْهُولُ يَأْخُذُ «ist ... worden» بِدُونِ «ge-» قَبْلَ «worden».',
      ),
      PassiveDrillQuestion(
        id: 'pvd_03',
        type: PassiveConstructionType.agentAndInstrument,
        targetLanguage: 'German',
        promptAr: 'أَيُّ حَرْفِ جَرٍّ يُسْتَعْمَلُ لِإِظْهَارِ الْوَسِيلَةِ أَوِ السَّبَبِ غَيْرِ الْعَاقِلِ فِي الْمَجْهُولِ الْأَلْمَانِيِّ؟',
        promptEn: 'Which preposition introduces the means/cause in a German passive clause?',
        promptDe: 'Welche Präposition steht im Passiv für ein Mittel oder eine Ursache?',
        options: [
          'von (+ Dativ)',
          'durch (+ Akkusativ)',
          'bei (+ Dativ)',
        ],
        correctIndex: 1,
        explanationAr: '«durch + Akkusativ» تَدُلُّ عَلَى الْوَسِيلَةِ أَوِ السَّبَبِ، بَيْنَمَا «von + Dativ» لِلْفَاعِلِ الْمُبَاشِرِ.',
      ),
      PassiveDrillQuestion(
        id: 'pvd_04',
        type: PassiveConstructionType.impersonalAndPrepositionalPassive,
        targetLanguage: 'German',
        promptAr: 'أَيُّ صِيغَةٍ صَحِيحَةٌ لِلْمَجْهُولِ غَيْرِ الشَّخْصِيِّ عِنْدَ تَقْدِيمِ الظَّرْفِ «Hier»؟',
        promptEn: 'Select the accurate impersonal passive starting with "Hier":',
        promptDe: 'Wählen Sie das korrekte unpersönliche Passiv mit „Hier“ am Anfang:',
        options: [
          'Hier wird es ruhig gearbeitet.',
          'Hier wird ruhig gearbeitet.',
          'Hier werden ruhig gearbeitet.',
        ],
        correctIndex: 1,
        explanationAr: 'يَسْقُطُ «es» عِنْدَ شَغْلِ الْمَوْقِعِ الْأَوَّلِ بِـ «Hier»، وَيَبْقَى الْفِعْلُ مُفْرَدًا: «Hier wird ruhig gearbeitet».',
      ),
      PassiveDrillQuestion(
        id: 'pvd_05',
        type: PassiveConstructionType.modalPassiveClusters,
        targetLanguage: 'Arabic',
        promptAr: 'مَا الضَّبْطُ الصَّحِيحُ لِلْفِعْلِ الْمَبْنِيِّ لِلْمَجْهُولِ فِي: «يَجِبُ أَنْ ... الدَّرْسُ جَيِّدًا»؟',
        promptEn: 'Choose the vocalized Arabic passive subjunctive after "an":',
        promptDe: 'Wählen Sie die korrekte arabische Passivform nach „an“:',
        options: [
          'يُفْهَمُ',
          'يُفْهَمَ',
          'يَفْهَمَ',
        ],
        correctIndex: 1,
        explanationAr: 'يُبْنَى الْمُضَارِعُ لِلْمَجْهُولِ بِضَمِّ أَوَّلِهِ وَفَتْحِ مَا قَبْلَ آخِرِهِ وَيُنْصَبُ بَعْدَ «أَنْ»: «يُفْهَمَ».',
      ),
      PassiveDrillQuestion(
        id: 'pvd_06',
        type: PassiveConstructionType.passiveAlternatives,
        targetLanguage: 'German',
        promptAr: 'أَيُّ جُمْلَةٍ تُؤَدِّي مَعْنَى «يُمْكِنُ حَلُّ هَذِهِ الْمُشْكِلَةِ» بِأُسْلُوبِ Passiversatz؟',
        promptEn: 'Which German passive-substitute sentence means "This problem can be solved"?',
        promptDe: 'Welche Passiversatzform bedeutet „Dieses Problem kann gelöst werden“?',
        options: [
          'Dieses Problem lässt sich lösen.',
          'Dieses Problem hat zu lösen.',
          'Dieses Problem wird gelöst sein.',
        ],
        correctIndex: 0,
        explanationAr: '«sich lassen + Infinitiv» يُعَادِلُ «können + Passiv» (يُمْكِنُ أَنْ يُحَلَّ).',
      ),
    ];
  }
}
