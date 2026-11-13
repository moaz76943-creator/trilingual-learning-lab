import '../models/prepositional_government_models.dart';

class PrepositionalGovernmentRepository {
  const PrepositionalGovernmentRepository();

  List<PrepositionalContrastPair> getPairs() {
    return const [
      PrepositionalContrastPair(
        id: 'pg_01',
        domain: PrepositionDomain.wechselpraepositionen,
        titleAr: 'الْوُجُودُ الثَّابِتُ (Wo?) مُقَابِلَ الِانْتِقَالِ وَالْوَضْعِ (Wohin?)',
        titleEn: 'Static Location vs. Directional Placement (liegen/legen, stehen/stellen)',
        titleDe: 'Wechselpräpositionen: Dativ bei Ruhe vs. Akkusativ bei Richtung',
        patternAAr: 'الْكِتَابُ مَوْضُوعٌ عَلَى الْمَكْتَبِ (سُكُونٌ وَثَبَاتٌ).',
        patternBAr: 'وَضَعْتُ الْكِتَابَ عَلَى الْمَكْتَبِ (حَرَكَةٌ وَانْتِقَالٌ).',
        patternAEn: 'The book is lying on the desk (static location).',
        patternBEn: 'I placed the book onto the desk (directional movement).',
        patternADe: 'Das Buch liegt auf dem Schreibtisch. (Wo? → Dativ)',
        patternBDe: 'Ich lege das Buch auf den Schreibtisch. (Wohin? → Akkusativ)',
        caseOrValencyRuleAr:
            'فِي الْعَرَبِيَّةِ يَظْهَرُ الْفَرْقُ فِي الْفِعْلِ وَالْمُشْتَقِّ (مَوْضُوعٌ / وَضَعْتُ) بَيْنَمَا يَبْقَى حَرْفُ «عَلَى» ثَابِتًا وَمَا بَعْدَهُ مَجْرُورًا.',
        caseOrValencyRuleEn:
            'English distinguishes static "on/in" from directional "onto/into" and pairs intransitive "lie" with transitive "lay".',
        caseOrValencyRuleDe:
            'Die neun Wechselpräpositionen (an, auf, hinter, in, neben, über, unter, vor, zwischen) regieren Dativ (Position) oder Akkusativ (Richtung).',
        pitfallAlertAr:
            'لَا تَخْلِطْ بَيْنَ «liegen» (يَسْتَلْقِي/مَوْضُوعٌ، لَازِمٌ + Dativ) وَ«legen» (يَضَعُ، مُتَعَدٍّ + Akkusativ).',
        germanCaseTag: 'Dativ vs. Akkusativ',
      ),
      PrepositionalContrastPair(
        id: 'pg_02',
        domain: PrepositionDomain.verbalValencyContrast,
        titleAr: 'تَبَدُّلُ مَعْنَى الْفِعْلِ الْوَاحِدِ بِتَبَدُّلِ حَرْفِ الْجَرِّ',
        titleEn: 'Radical Meaning Inversion via Prepositional Shift',
        titleDe: 'Kontrastive Verb-Präposition-Paare (freuen auf vs. über)',
        patternAAr: 'رَغِبَ الطَّالِبُ فِي تَعَلُّمِ اللُّغَاتِ (أَحَبَّهُ وَأَقْبَلَ عَلَيْهِ).',
        patternBAr: 'رَغِبَ الْعَاقِلُ عَنِ اللَّغْوِ (أَعْرَضَ عَنْهُ وَتَرَكَهُ).',
        patternAEn: 'He looks forward to the upcoming conference (future anticipation).',
        patternBEn: 'He is pleased about the positive feedback (present/past fact).',
        patternADe: 'Er freut sich auf die kommende Vorlesung. (Zukunft + Akk.)',
        patternBDe: 'Er freut sich über das gelungene Ergebnis. (Gegenwart/Vergangenheit + Akk.)',
        caseOrValencyRuleAr:
            'تَتَضَمَّنُ «رَغِبَ فِي» مَعْنَى الْمَيْلِ وَالْحِرْصِ، أَمَّا «رَغِبَ عَنْ» فَتَتَضَمَّنُ مَعْنَى الزُّهْدِ وَالْإِعْرَاضِ.',
        caseOrValencyRuleEn:
            'English often splits these meanings across distinct phrasal verbs ("look forward to" vs. "be pleased about").',
        caseOrValencyRuleDe:
            '„Sich freuen auf“ richtet sich auf ein zukünftiges Ereignis; „sich freuen über“ bezieht sich auf etwas bereits Eingetretenes.',
        pitfallAlertAr:
            'إِغْفَالُ الْفَرْقِ بَيْنَ «فِي» وَ«عَنْ» مَعَ «رَغِبَ» يَقْلِبُ الْمَعْنَى إِلَى النَّقِيضِ تَمَامًا.',
        germanCaseTag: 'auf + Akk vs. über + Akk',
      ),
      PrepositionalContrastPair(
        id: 'pg_03',
        domain: PrepositionDomain.fixedPrepositionalRektion,
        titleAr: 'التَّلَازُمُ الْحَرْفِيُّ الثَّابِتُ بَيْنَ اللُّغَاتِ الثَّلَاثِ',
        titleEn: 'Cross-Linguistic Non-Isomorphic Preposition Colligations',
        titleDe: 'Feste Rektion: denken an, warten auf, teilnehmen an',
        patternAAr: 'يَنْتَظِرُ الْمُسَافِرُ الْقِطَارَ (مُتَعَدٍّ بِنَفْسِهِ)؛ وَيُشَارِكُ فِي النَّدْوَةِ.',
        patternBAr: 'يُفَكِّرُ الْبَاحِثُ فِي الْمَسْأَلَةِ، وَيَعْتَمِدُ عَلَى الدَّلِيلِ.',
        patternAEn: 'The traveler waits for the train and participates in the seminar.',
        patternBEn: 'The researcher thinks about the issue and relies on the evidence.',
        patternADe: 'Der Reisende wartet auf den Zug (+ Akk.) und nimmt am Seminar teil (+ Dat.).',
        patternBDe: 'Der Forscher denkt an das Problem (+ Akk.) und verlässt sich auf den Beleg (+ Akk.).',
        caseOrValencyRuleAr:
            'الْفِعْلُ «انْتَظَرَ» يَتَعَدَّى بِنَفْسِهِ فِي الْعَرَبِيَّةِ دُونَ حَرْفٍ، بَيْنَمَا يَلْزَمُهُ «for» فِي الْإِنْجِلِيزِيَّةِ وَ«auf» فِي الْأَلْمَانِيَّةِ.',
        caseOrValencyRuleEn:
            'Prepositional colligations are idiomatic per verb ("wait for", "depend on", "participate in") and cannot be translated literally.',
        caseOrValencyRuleDe:
            'Im Deutschen muss der Kasus mitgelernt werden: „warten auf + Akkusativ“, „teilnehmen an + Dativ“.',
        pitfallAlertAr:
            'تَجَنَّبْ تَرْجَمَةَ «يفكر في» حَرْفِيًّا إِلَى *„denken in“؛ فَالْأَلْمَانِيَّةُ تَسْتَعْمِلُ «denken an + Akkusativ».',
        germanCaseTag: 'Rektion (an / auf)',
      ),
      PrepositionalContrastPair(
        id: 'pg_04',
        domain: PrepositionDomain.temporalAnchoring,
        titleAr: 'حُرُوفُ الزَّمَانِ: مُنْذُ (seit) وَقَبْلَ (vor) وَخِلَالَ (in)',
        titleEn: 'Temporal Prepositions: Ongoing Duration vs. Past Point vs. Future Span',
        titleDe: 'Zeitpräpositionen: seit (Andauern) vs. vor (Abgeschlossen) vs. in (Zukunft)',
        patternAAr: 'يَدْرُسُ الْأَلْمَانِيَّةَ مُنْذُ عَامَيْنِ (وَمَا زَالَ مُسْتَمِرًّا).',
        patternBAr: 'بَدَأَ الدِّرَاسَةَ قَبْلَ عَامَيْنِ؛ وَسَيُتِمُّ الْمُسْتَوَى خِلَالَ شَهْرَيْنِ.',
        patternAEn: 'He has been studying German for two years (ongoing up to now).',
        patternBEn: 'He started studying two years ago; he will finish the level in two months.',
        patternADe: 'Er lernt seit zwei Jahren Deutsch. (Präsens + Dativ)',
        patternBDe: 'Er begann vor zwei Jahren (Präteritum + Dativ); in zwei Monaten schließt er ab.',
        caseOrValencyRuleAr:
            '«مُنْذُ» تُفِيدُ ابْتِدَاءَ الْغَايَةِ الزَّمَنِيَّةِ الْمُمْتَدَّةِ حَتَّى الْحَاضِرِ، وَ«قَبْلَ» تَرْصُدُ نُقْطَةً مَاضِيَةً.',
        caseOrValencyRuleEn:
            'English pairs "for + duration" with Present Perfect Continuous, while past points take postposed "ago".',
        caseOrValencyRuleDe:
            '„Seit + Dativ“ steht im Deutschen mit dem Präsens für andauernde Handlungen; „vor + Dativ“ steht mit Vergangenheitszeiten.',
        pitfallAlertAr:
            'لَا تَسْتَعْمِلْ «for» بِمَعْنَى «für» فِي الْأَلْمَانِيَّةِ لِلتَّعْبِيرِ عَنِ الْمُدَّةِ الْمُمْتَدَّةِ مِنَ الْمَاضِي حَتَّى الْآنَ؛ بَلِ اسْتَعْمِلْ «seit».',
        germanCaseTag: 'Dativ (seit / vor / in)',
      ),
      PrepositionalContrastPair(
        id: 'pg_05',
        domain: PrepositionDomain.instrumentalAndCausal,
        titleAr: 'الْبَاءُ وَاللَّامُ مُقَابِلَ «mit / durch / wegen» وَ«by / with / due to»',
        titleEn: 'Instrumental Tool vs. Agency vs. Causal Explanation',
        titleDe: 'Mittel & Ursache: mit (+ Dativ), durch (+ Akkusativ), wegen (+ Genitiv)',
        patternAAr: 'كَتَبَ بِالْقَلَمِ (اسْتِعَانَةٌ)؛ وَنَجَحَ بِاجْتِهَادِهِ (سَبَبِيَّةٌ).',
        patternBAr: 'تَأَجَّلَ السَّفَرُ بِسَبَبِ الضَّبَابِ الْكَثِيفِ.',
        patternAEn: 'He wrote with a pen; he succeeded through perseverance.',
        patternBEn: 'The trip was postponed because of the dense fog.',
        patternADe: 'Er schrieb mit einem Stift (+ Dativ); durch Fleiß (+ Akkusativ) erreichte er das Ziel.',
        patternBDe: 'Wegen des dichten Nebels (+ Genitiv) wurde die Reise verschoben.',
        caseOrValencyRuleAr:
            'تَتَنَوَّعُ مَعَانِي الْبَاءِ فِي الْعَرَبِيَّةِ بَيْنَ الِاسْتِعَانَةِ (الْآلَةِ) وَالسَّبَبِيَّةِ، بَيْنَمَا تُفَصِّلُهَا الْأَلْمَانِيَّةُ فِي حُرُوفٍ وَحَالَاتٍ مُتَبَايِنَةٍ.',
        caseOrValencyRuleEn:
            'English uses "with" for concrete instruments, "through/by" for means/agency, and "because of/due to" for causes.',
        caseOrValencyRuleDe:
            '„Mit“ (Instrument) verlangt Dativ, „durch“ (Mittel/Vermittlung) Akkusativ, und „wegen“ (Grund) standardsprachlich Genitiv.',
        pitfallAlertAr:
            'فِي الْأَلْمَانِيَّةِ الْفَصِيحَةِ يَتْبَعُ «wegen» حَالَةُ Genitiv («wegen des Nebels»)، لَا Dativ فِي الْكِتَابَةِ الْعِلْمِيَّةِ.',
        germanCaseTag: 'Dativ / Akkusativ / Genitiv',
      ),
      PrepositionalContrastPair(
        id: 'pg_06',
        domain: PrepositionDomain.abstractMetaphoricalSpace,
        titleAr: 'الْمَجَازُ الْمَكَانِيُّ: «فِي» وَ«عَلَى» فِي التَّرَاكِيبِ الْمَعْنَوِيَّةِ',
        titleEn: 'Metaphorical Extension of Spatial Prepositions',
        titleDe: 'Übertragene Bedeutung räumlicher Präpositionen',
        patternAAr: 'هُوَ عَلَى خُلُقٍ عَظِيمٍ، وَيَبْحَثُ فِي أُصُولِ الْمَسْأَلَةِ.',
        patternBAr: 'دَخَلَ فِي حِوَارٍ بَنَّاءٍ، وَوَقَفَ عَلَى حَقِيقَةِ الْأَمْرِ.',
        patternAEn: 'He stands on firm ethical ground and delves into the core of the issue.',
        patternBEn: 'He entered into a constructive dialogue and arrived at the truth.',
        patternADe: 'Er steht auf festem Boden und geht auf den Kern der Sache ein.',
        patternBDe: 'Er trat in einen konstruktiven Dialog ein und kam der Wahrheit auf die Spur.',
        caseOrValencyRuleAr:
            'تَنْتَقِلُ حُرُوفُ الْجَرِّ مِنَ الْحَيِّزِ الْمَادِّيِّ إِلَى الْمَعْنَوِيِّ بِالِاسْتِعَارَةِ الْمَفْهُومِيَّةِ (وَقَفَ عَلَى = اطَّلَعَ وَفَهِمَ).',
        caseOrValencyRuleEn:
            'Spatial metaphors ("delve into", "stand on", "arrive at") map physical containment and surfaces onto abstract reasoning.',
        caseOrValencyRuleDe:
            'Verbindungen wie „auf etwas eingehen“ (+ Akk.) oder „im Blick behalten“ zeigen feste abstrakte Rektion.',
        pitfallAlertAr:
            'الْمُتَعَلِّمُ يُخْطِئُ حِينَ يَتَرْجِمُ الْحَرْفَ الْمَجَازِيَّ حَرْفِيًّا (مِثْلَ «وَقَفَ عَلَى» إِلَى *stand on بدلاً من grasp/discover).',
        germanCaseTag: 'Metaphorical Valency',
      ),
    ];
  }

  List<PrepositionDrillItem> getDrills() {
    return const [
      PrepositionDrillItem(
        id: 'pgd_01',
        domain: PrepositionDomain.wechselpraepositionen,
        targetLanguage: 'German',
        promptAr: 'اخْتَرِ الصِّيغَةَ الصَّحِيحَةَ لِلدَّلَالَةِ عَلَى الْوُجُودِ الثَّابِتِ (Wo?): „Die Lampe hängt ...“',
        promptEn: 'Choose the correct German case for static location (Wo?):',
        promptDe: 'Wählen Sie den richtigen Kasus für die Ortsangabe (Wo?):',
        options: [
          'über den Tisch',
          'über dem Tisch',
          'über des Tisches',
        ],
        correctIndex: 1,
        explanationAr: 'السُّؤَالُ بِـ «Wo?» (أَيْنَ؟) يَقْتَضِي حَالَةَ Dativ مَعَ «über»: «über dem Tisch».',
      ),
      PrepositionDrillItem(
        id: 'pgd_02',
        domain: PrepositionDomain.verbalValencyContrast,
        targetLanguage: 'Arabic',
        promptAr: 'مَا مَعْنَى «رَغِبَ عَنِ الشَّيْءِ» فِي الْعَرَبِيَّةِ الْفُصْحَى؟',
        promptEn: 'What does the Arabic verb-preposition pair "raghiba ʿan" mean?',
        promptDe: 'Was bedeutet die arabische Verbindung „raghiba ʿan“?',
        options: [
          'أَحَبَّهُ وَطَلَبَهُ بِشِدَّةٍ',
          'أَعْرَضَ عَنْهُ وَزَهِدَ فِيهِ',
          'سَأَلَ عَنْهُ وَبَحَثَ',
        ],
        correctIndex: 1,
        explanationAr: '«رَغِبَ فِي» بِمَعْنَى طَلَبَ وَأَحَبَّ، أَمَّا «رَغِبَ عَنْ» فَبِمَعْنَى زَهِدَ وَتَرَكَ.',
      ),
      PrepositionDrillItem(
        id: 'pgd_03',
        domain: PrepositionDomain.fixedPrepositionalRektion,
        targetLanguage: 'German',
        promptAr: 'أَيُّ حَرْفِ جَرٍّ وَحَالَةٍ إِعْرَابِيَّةٍ يَلْزَمُ الْفِعْلَ «teilnehmen» (يُشَارِكُ)؟',
        promptEn: 'Which preposition and case does "teilnehmen" govern in German?',
        promptDe: 'Welche Präposition und welchen Kasus regiert „teilnehmen“?',
        options: [
          'an + Dativ (am Workshop)',
          'für + Akkusativ (für den Workshop)',
          'auf + Akkusativ (auf den Workshop)',
        ],
        correctIndex: 0,
        explanationAr: 'الْفِعْلُ «teilnehmen» يَتَلَازَمُ دَائِمًا مَعَ «an + Dativ» («am Workshop teilnehmen»).',
      ),
      PrepositionDrillItem(
        id: 'pgd_04',
        domain: PrepositionDomain.temporalAnchoring,
        targetLanguage: 'German',
        promptAr: 'لِلتَّعْبِيرِ عَنْ حَدَثٍ بَدَأَ فِي الْمَاضِي وَمَا زَالَ مُسْتَمِرًّا حَتَّى الْآنَ: „Ich wohne ... drei Jahren in Amman.“',
        promptEn: 'Select the German preposition for an action continuing from the past into the present:',
        promptDe: 'Welche Präposition drückt eine bis in die Gegenwart andauernde Zeitspanne aus?',
        options: [
          'vor',
          'seit',
          'nach',
        ],
        correctIndex: 1,
        explanationAr: '«seit + Dativ» مَعَ الْمُضَارِعِ يُفِيدُ اسْتِمْرَارَ الْحَدَثِ مِنَ الْمَاضِي إِلَى الْحَاضِرِ.',
      ),
      PrepositionDrillItem(
        id: 'pgd_05',
        domain: PrepositionDomain.instrumentalAndCausal,
        targetLanguage: 'German',
        promptAr: 'اخْتَرِ الصِّيغَةَ الْفَصِيحَةَ بَعْدَ حَرْفِ السَّبَبِيَّةِ «wegen»:',
        promptEn: 'Choose the standard written German case after "wegen":',
        promptDe: 'Wählen Sie den standardsprachlichen Kasus nach „wegen“:',
        options: [
          'wegen dem starken Regen',
          'wegen den starken Regen',
          'wegen des starken Regens',
        ],
        correctIndex: 2,
        explanationAr: 'حَرْفُ «wegen» يَجُرُّ الِاسْمَ فِي اللُّغَةِ الْعِلْمِيَّةِ بِحَالَةِ Genitiv: «wegen des starken Regens».',
      ),
      PrepositionDrillItem(
        id: 'pgd_06',
        domain: PrepositionDomain.abstractMetaphoricalSpace,
        targetLanguage: 'English',
        promptAr: 'أَيُّ فِعْلٍ حَرْفِيٍّ يُقَابِلُ «وَثِقَ بِـ / اعْتَمَدَ عَلَى» فِي الْإِنْجِلِيزِيَّةِ؟',
        promptEn: 'Which English prepositional verb means "to trust and depend on"?',
        promptDe: 'Welches englische Präpositionalverb entspricht „sich verlassen auf“?',
        options: [
          'rely on',
          'look after',
          'put off',
        ],
        correctIndex: 0,
        explanationAr: '«rely on» يُقَابِلُ «اعْتَمَدَ عَلَى» وَ«sich verlassen auf».',
      ),
    ];
  }
}
