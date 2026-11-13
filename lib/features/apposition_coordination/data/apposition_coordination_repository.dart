import '../models/apposition_coordination_models.dart';

class AppositionCoordinationRepository {
  const AppositionCoordinationRepository();

  List<StructuralComparisonItem> getItems() {
    return const [
      StructuralComparisonItem(
        id: 'ac_01',
        type: AppositionCoordinationType.identicalApposition,
        titleAr: 'الْبَدَلُ الْمُطَابِقُ وَتَطَابُقُ الْحَالَةِ الْإِعْرَابِيَّةِ',
        titleEn: 'Non-Restrictive Apposition & German Case Congruence',
        titleDe: 'Apposition im selben Kasus (Dativ- und Akkusativkongruenz)',
        exampleAr: 'شَكَرْتُ الْمُعَلِّمَ خَالِدًا، صَاحِبَ الْعِلْمِ الْغَزِيرِ.',
        exampleEn: 'I thanked Professor Khalid, an experienced linguist.',
        exampleDe: 'Ich dankte meinem Lehrer, einem erfahrenen Sprachwissenschaftler.',
        grammarBreakdownAr:
            '«خَالِدًا» بَدَلٌ مُطَابِقٌ مَنْصُوبٌ تَبَعًا لِلْمُبْدَلِ مِنْهُ «الْمُعَلِّمَ»، وَ«صَاحِبَ» بَدَلٌ ثَانٍ أَوْ نَعْتٌ مَقْطُوعٌ إِلَى النَّصْبِ.',
        grammarBreakdownEn:
            'The non-restrictive appositive ("an experienced linguist") is set off by commas and clarifies the preceding noun phrase.',
        grammarBreakdownDe:
            'Nach „danken“ (Dativ) muss auch die nachgestellte Apposition im Dativ stehen: „meinem Lehrer, einem erfahrenen Sprachwissenschaftler“.',
        punctuationAndCaseNoteAr:
            'فِي الْأَلْمَانِيَّةِ تُفْصَلُ الِاسْمِيَّةُ التَّوْضِيحِيَّةُ بِفَاصِلَتَيْنِ وَتَأْخُذُ إِعْرَابَ الْمَتْبُوعِ نَفْسَهُ.',
        commonMistakeAr:
            'الْخَطَأُ الشَّائِعُ: وَضْعُ الْبَدَلِ فِي حَالَةِ الرَّفْعِ (Nominativ: „ein erfahrener...“) بَعْدَ مَفْعُولٍ مَجْرُورٍ أَوْ مَنْصُوبٍ.',
        registerLabel: 'Formal / Academic',
      ),
      StructuralComparisonItem(
        id: 'ac_02',
        type: AppositionCoordinationType.partitiveAndInclusiveApposition,
        titleAr: 'بَدَلُ الْبَعْضِ مِنَ الْكُلِّ وَبَدَلُ الِاشْتِمَالِ',
        titleEn: 'Partitive Apposition & Attribute-Based Specification',
        titleDe: 'Teil-Ganzes-Beziehung und Merkmalsangabe',
        exampleAr: 'قَرَأْتُ الْكِتَابَ نِصْفَهُ، وَأَعْجَبَنِي الْمُؤَلِّفُ إِتْقَانُهُ.',
        exampleEn: 'I read the book—half of it—and admired the author for his precision.',
        exampleDe: 'Ich habe das Buch, zumindest die Hälfte davon, gelesen und schätze den Autor wegen seiner Präzision.',
        grammarBreakdownAr:
            'يَشْتَرِطُ بَدَلُ الْبَعْضِ «نِصْفَهُ» وَبَدَلُ الِاشْتِمَالِ «إِتْقَانُهُ» اتِّصَالَهُمَا بِضَمِيرٍ يَعُودُ عَلَى الْمُبْدَلِ مِنْهُ وَيُطَابِقُهُ.',
        grammarBreakdownEn:
            'English rarely uses bare noun apposition for part-whole or abstract attributes; it employs "of"-partitives or prepositional phrases ("for his precision").',
        grammarBreakdownDe:
            'Im Deutschen werden Teil- oder Merkmalsbezüge meist durch „davon“, „zumindest“ oder präpositionale Wendungen („wegen seiner Präzision“) ausgedrückt.',
        punctuationAndCaseNoteAr:
            'تَأَكَّدْ فِي الْعَرَبِيَّةِ مِنْ إِعْرَابِ «نِصْفَهُ» (مَنْصُوبٌ) وَ«إِتْقَانُهُ» (مَرْفُوعٌ لِأَنَّ «الْمُؤَلِّفُ» فَاعِلُ «أَعْجَبَ»).',
        commonMistakeAr:
            'نِسْيَانُ الضَّمِيرِ الرَّابِطِ فِي بَدَلِ الْبَعْضِ وَالِاشْتِمَالِ يُخِلُّ بِتَرْكِيبِ الْبَدَلِ فِي الْعَرَبِيَّةِ.',
        registerLabel: 'Literary / Analytical',
      ),
      StructuralComparisonItem(
        id: 'ac_03',
        type: AppositionCoordinationType.sequentialCoordination,
        titleAr: 'دَقَائِقُ حُرُوفِ الْعَطْفِ: الْوَاوُ وَالْفَاءُ وَثُمَّ',
        titleEn: 'Nuances of Coordination: Simultaneity vs. Sequence',
        titleDe: 'Koordination: „und“ vs. „dann“ vs. „schließlich“',
        exampleAr: 'دَخَلَ الطُّلَّابُ فَالْأُسْتَاذُ، ثُمَّ بَدَأَ الدَّرْسُ بَعْدَ دَقَائِقَ.',
        exampleEn: 'The students entered and immediately after them the professor; then the lesson began a few minutes later.',
        exampleDe: 'Die Studierenden traten ein und unmittelbar darauf der Professor; danach begann die Vorlesung.',
        grammarBreakdownAr:
            'الْفَاءُ تُفِيدُ التَّرْتِيبَ وَالتَّعْقِيبَ بِدُونِ مُهْلَةٍ، بَيْنَمَا «ثُمَّ» تُفِيدُ التَّرْتِيبَ مَعَ التَّرَاخِي وَالْمُهْلَةِ الزَّمَنِيَّةِ.',
        grammarBreakdownEn:
            'English "and" is temporally neutral; temporal immediacy or delay requires explicit adverbs ("immediately", "then", "afterwards").',
        grammarBreakdownDe:
            'Das deutsche „und“ bleibt zeitlich unspezifisch; erst Adverbien wie „unmittelbar darauf“ oder „danach“ bilden „فَـ“ und „ثُمَّ“ genau ab.',
        punctuationAndCaseNoteAr:
            'فِي الْإِنْجِلِيزِيَّةِ وَالْأَلْمَانِيَّةِ لَا يَكْفِي «and / und» لِلتَّفْرِيقِ الدَّقِيقِ بَيْنَ الْفَاءِ وَثُمَّ عِنْدَ التَّرْجَمَةِ الْعِلْمِيَّةِ.',
        commonMistakeAr:
            'تَرْجَمَةُ «ثُمَّ» وَ«فَـ» دَائِمًا بِلَفْظٍ وَاحِدٍ يُضَيِّعُ التَّسَلْسُلَ الزَّمَنِيَّ الدَّقِيقَ لِلْأَحْدَاثِ.',
        registerLabel: 'Narrative / Precision',
      ),
      StructuralComparisonItem(
        id: 'ac_04',
        type: AppositionCoordinationType.rectifyingCoordination,
        titleAr: 'الْإِضْرَابُ بـ «بَلْ» وَالِاسْتِدْرَاكُ بـ «لَكِنْ» مُقَابِلَ «sondern / aber»',
        titleEn: 'Corrective "sondern" vs. Concessive "aber" & "but/rather"',
        titleDe: 'Berichtigung nach Negation: „sondern“ gegen „aber“',
        exampleAr: 'لَيْسَ الْحِفْظُ كَافِيًا، بَلِ الْفَهْمُ هُوَ الْأَسَاسُ؛ قَدْ يَصْعُبُ النَّصُّ لَكِنَّهُ مُمْتِعٌ.',
        exampleEn: 'Memorization is not enough; rather, comprehension is fundamental. The text may be challenging, but it is rewarding.',
        exampleDe: 'Auswendiglernen reicht nicht aus, sondern das Verstehen ist entscheidend; der Text ist zwar anspruchsvoll, aber lehrreich.',
        grammarBreakdownAr:
            'تُفِيدُ «بَلْ» بَعْدَ النَّفْيِ إِثْبَاتَ نَقِيضِ الْمَنْفِيِّ (الْإِضْرَابُ)، وَتُفِيدُ «لَكِنْ» الِاسْتِدْرَاكَ دُونَ إِبْطَالِ الْحُكْمِ السَّابِقِ.',
        grammarBreakdownEn:
            '"Rather" or "not X, but Y" performs corrective rectification, whereas "but" introduces a non-contradictory concession.',
        grammarBreakdownDe:
            'Nach einer Negation steht „sondern“, wenn das Vorherige ersetzt wird; „aber“ hingegen schränkt eine weiterhin gültige Aussage ein.',
        punctuationAndCaseNoteAr:
            'قَبْلَ «sondern» وَ«aber» تُوضَعُ فَاصِلَةٌ دَائِمًا فِي الْأَلْمَانِيَّةِ، وَلَا تَتَغَيَّرُ رُتْبَةُ الْفِعْلِ فِي الْمَوْقِعِ الثَّانِي (ADUSO).',
        commonMistakeAr:
            'اسْتِعْمَالُ «aber» بَعْدَ النَّفْيِ التَّصْحِيحِيِّ مِثْلَ «nicht A, aber B» خَطَأٌ شَائِعٌ؛ وَالصَّوَابُ «nicht A, sondern B».',
        registerLabel: 'Argumentative / Core Grammar',
      ),
      StructuralComparisonItem(
        id: 'ac_05',
        type: AppositionCoordinationType.clarificatoryReformulation,
        titleAr: 'التَّفْسِيرُ وَالتَّوْضِيحُ: «أَيْ / يَعْنِي» مُقَابِلَ «nämlich / d. h. / namely»',
        titleEn: 'Clarificatory Markers: "namely", "that is", "bzw."',
        titleDe: 'Präzisierung & Aufschlüsselung mit „nämlich“, „d. h.“ und „bzw.“',
        exampleAr: 'أَتْقَنَ الْمَهَارَتَيْنِ الْأَسَاسِيَّتَيْنِ: أَيِ الْقِرَاءَةَ وَالْكِتَابَةَ.',
        exampleEn: 'He mastered the two foundational skills, namely reading and writing.',
        exampleDe: 'Er beherrschte die beiden Grundfertigkeiten, nämlich Lesen und Schreiben.',
        grammarBreakdownAr:
            '«أَيْ» حَرْفُ تَفْسِيرٍ يَشْرَحُ الْمُجْمَلَ قَبْلَهُ، وَيَتْبَعُ مَا بَعْدَهُ مَا قَبْلَهُ فِي الْإِعْرَابِ إِذَا كَانَ عَطْفَ بَيَانٍ.',
        grammarBreakdownEn:
            '"Namely" introduces an exhaustive specification of a preceding plural or general noun phrase.',
        grammarBreakdownDe:
            '„Nämlich“ benennt Konkretes im Anschluss an eine allgemeine Ankündigung; „bzw.“ (beziehungsweise) präzisiert Alternativen oder Zuordnungen.',
        punctuationAndCaseNoteAr:
            'تُفْصَلُ «namely» وَ«nämlich» بِفَاصِلَةٍ قَبْلَهَا، وَتُحَافِظُ الْعَنَاصِرُ الْمُفَسَّرَةُ عَلَى التَّوَازِي النَّحْوِيِّ.',
        commonMistakeAr:
            'الْخَلْطُ بَيْنَ «namely» (لِلتَّفْصِيلِ الْحَصْرِيِّ) وَ«for example» (لِلتَّمْثِيلِ الْجُزْئِيِّ).',
        registerLabel: 'Expository / Technical',
      ),
      StructuralComparisonItem(
        id: 'ac_06',
        type: AppositionCoordinationType.parentheticalInsertion,
        titleAr: 'الْجُمْلَةُ الِاعْتِرَاضِيَّةُ بَيْنَ الْمُتَلَازِمَيْنِ',
        titleEn: 'Parenthetical Asides & Syntactic Interruption',
        titleDe: 'Eingeschobene Parenthesen zwischen Satzgliedern',
        exampleAr: 'الْأَمَانَةُ — وَفَّقَكَ اللهُ — رَكِيزَةُ الْعَمَلِ الْعِلْمِيِّ.',
        exampleEn: 'Integrity—may success accompany every scholar—is the pillar of academic work.',
        exampleDe: 'Aufrichtigkeit – und das gilt für jede Disziplin – bildet das Fundament wissenschaftlicher Arbeit.',
        grammarBreakdownAr:
            'الْجُمْلَةُ الِاعْتِرَاضِيَّةُ تَقَعُ بَيْنَ الْمُبْتَدَأِ وَالْخَبَرِ أَوِ الْفِعْلِ وَفَاعِلِهِ لِلدُّعَاءِ أَوِ التَّنْبِيهِ، وَلَا مَحَلَّ لَهَا مِنَ الْإِعْرَابِ.',
        grammarBreakdownEn:
            'Em-dashes isolate a parenthetical aside without disrupting the main subject-verb agreement.',
        grammarBreakdownDe:
            'Gedankenstriche (– ... –) schließen eine selbstständige Parenthese ein; das Hauptverb folgt danach weiterhin an der regulären Satzposition.',
        punctuationAndCaseNoteAr:
            'يُوضَعُ الشَّرْطَتَانِ (— ... —) فِي اللُّغَاتِ الثَّلَاثِ لِإِبْرَازِ الِاعْتِرَاضِ، مَعَ بَقَاءِ رُكْنَيِ الْجُمْلَةِ مُتَطَابِقَيْنِ.',
        commonMistakeAr:
            'إِسْنَادُ الْفِعْلِ الرَّئِيسِيِّ إِلَى اسْمٍ دَاخِلَ الْجُمْلَةِ الِاعْتِرَاضِيَّةِ بَدَلًا مِنَ الْمُبْتَدَأِ الْأَصْلِيِّ.',
        registerLabel: 'Rhetorical / Essayistic',
      ),
    ];
  }

  List<AppositionDrillItem> getDrills() {
    return const [
      AppositionDrillItem(
        id: 'acd_01',
        type: AppositionCoordinationType.identicalApposition,
        targetLanguage: 'German',
        promptAr: 'اخْتَرِ الضَّبْطَ الصَّحِيحَ لِلْبَدَلِ فِي الْجُمْلَةِ الْأَلْمَانِيَّةِ: „Ich helfe meinem Freund, ...“',
        promptEn: 'Choose the appositive with correct German Dativ case agreement:',
        promptDe: 'Wählen Sie die Apposition im passenden Kasus (Dativ):',
        options: [
          'ein junger Übersetzer',
          'einen jungen Übersetzer',
          'einem jungen Übersetzer',
        ],
        correctIndex: 2,
        rationaleAr: 'الْفِعْلُ «helfen» يَجُرُّ الْمَفْعُولَ فِي حَالَةِ Dativ، فَيَجِبُ تَطَابُقُ الْبَدَلِ مَعَهُ: «einem jungen Übersetzer».',
      ),
      AppositionDrillItem(
        id: 'acd_02',
        type: AppositionCoordinationType.partitiveAndInclusiveApposition,
        targetLanguage: 'Arabic',
        promptAr: 'مَا نَوْعُ الْبَدَلِ وَإِعْرَابُهُ فِي: «حَفِظْتُ الْقَصِيدَةَ ثُلُثَهَا»؟',
        promptEn: 'Identify the apposition type and case in the Arabic sentence:',
        promptDe: 'Bestimmen Sie Art und Kasus der arabischen Apposition:',
        options: [
          'بَدَلُ بَعْضٍ مِنَ الْكُلِّ مَنْصُوبٌ',
          'بَدَلُ اشْتِمَالٍ مَرْفُوعٌ',
          'بَدَلٌ مُطَابِقٌ مَجْرُورٌ',
        ],
        correctIndex: 0,
        rationaleAr: '«ثُلُثَهَا» جُزْءٌ حَقِيقِيٌّ مِنَ «الْقَصِيدَةَ» الْمَنْصُوبَةِ، فَهُوَ بَدَلُ بَعْضٍ مِنَ الْكُلِّ مَنْصُوبٌ.',
      ),
      AppositionDrillItem(
        id: 'acd_03',
        type: AppositionCoordinationType.sequentialCoordination,
        targetLanguage: 'Arabic',
        promptAr: 'أَيُّ حَرْفِ عَطْفٍ يَدُلُّ عَلَى التَّرْتِيبِ مَعَ التَّرَاخِي وَوُجُودِ مُهْلَةٍ زَمَنِيَّةٍ؟',
        promptEn: 'Which Arabic coordinator expresses sequence with a time gap?',
        promptDe: 'Welche arabische Konjunktion drückt zeitliche Abfolge mit Abstand aus?',
        options: [
          'الْفَاءُ',
          'ثُمَّ',
          'أَوْ',
        ],
        correctIndex: 1,
        rationaleAr: '«ثُمَّ» تُفِيدُ التَّرْتِيبَ مَعَ التَّرَاخِي، بِخِلَافِ الْفَاءِ الَّتِي تُفِيدُ التَّعْقِيبَ الْمُبَاشِرَ.',
      ),
      AppositionDrillItem(
        id: 'acd_04',
        type: AppositionCoordinationType.rectifyingCoordination,
        targetLanguage: 'German',
        promptAr: 'اخْتَرِ الرَّابِطَ الصَّحِيحَ بَعْدَ النَّفْيِ التَّصْحِيحِيِّ: „Das ist kein Fehler, ... eine bewusste Stilfigur.“',
        promptEn: 'Choose the German corrective coordinator after negation:',
        promptDe: 'Wählen Sie die korrekte Konjunktion zur Berichtigung:',
        options: [
          'aber',
          'sondern',
          'denn',
        ],
        correctIndex: 1,
        rationaleAr: 'بَعْدَ النَّفْيِ «kein Fehler» نَسْتَعْمِلُ «sondern» لِتَصْحِيحِ الْحُكْمِ وَإِثْبَاتِ الْبَدِيلِ.',
      ),
      AppositionDrillItem(
        id: 'acd_05',
        type: AppositionCoordinationType.clarificatoryReformulation,
        targetLanguage: 'English',
        promptAr: 'أَيُّ عِبَارَةٍ تَدُلُّ عَلَى التَّفْصِيلِ الْحَصْرِيِّ (أَيِ الْمَقْصُودِ تَحْدِيدًا)؟',
        promptEn: 'Which English marker introduces an exhaustive specification rather than an example?',
        promptDe: 'Welcher englische Ausdruck leitet eine genaue Aufschlüsselung ein?',
        options: [
          'namely',
          'for instance',
          'however',
        ],
        correctIndex: 0,
        rationaleAr: '«namely» تَحْصُرُ التَّفْسِيرَ فِي الْعَنَاصِرِ الْمَذْكُورَةِ تَحْدِيدًا، مِثْلَ «أَيْ» وَ«nämlich».',
      ),
      AppositionDrillItem(
        id: 'acd_06',
        type: AppositionCoordinationType.parentheticalInsertion,
        targetLanguage: 'Arabic',
        promptAr: 'مَا الْمَحَلُّ الْإِعْرَابِيُّ لِلْجُمْلَةِ الِاعْتِرَاضِيَّةِ «رَحِمَهُ اللهُ» فِي: «قَالَ الْعَالِمُ — رَحِمَهُ اللهُ — قَوْلًا سَدِيدًا»؟',
        promptEn: 'What is the syntactic status of a parenthetical aside in Arabic?',
        promptDe: 'Welchen syntaktischen Status hat eine eingeschobene Parenthese?',
        options: [
          'فِي مَحَلِّ نَصْبٍ حَالٌ',
          'لَا مَحَلَّ لَهَا مِنَ الْإِعْرَابِ',
          'فِي مَحَلِّ رَفْعٍ نَعْتٌ',
        ],
        correctIndex: 1,
        rationaleAr: 'الْجُمْلَةُ الِاعْتِرَاضِيَّةُ بَيْنَ مُتَلَازِمَيْنِ لَا مَحَلَّ لَهَا مِنَ الْإِعْرَابِ.',
      ),
    ];
  }
}
