import '../models/nominal_agreement_models.dart';

class NominalAgreementRepository {
  const NominalAgreementRepository();

  List<NominalAgreementLesson> getLessons() {
    return const [
      NominalAgreementLesson(
        id: 'na_01',
        axis: DeclensionAgreementAxis.weakDefiniteDeclension,
        titleAr: 'مُطَابَقَةُ النَّعْتِ الْمُعَرَّفِ وَالتَّصْرِيفُ الضَّعِيفُ بَعْدَ der/die/das',
        titleEn: 'Full Arabic Naʿt Agreement vs. German Weak Declension',
        titleDe: 'Schwache Adjektivdeklination: nur -e oder -en nach der/die/das',
        exampleAr: 'قَرَأْتُ الْمَقَالَ الْجَدِيدَ فِي الْمَجَلَّةِ الْعِلْمِيَّةِ الْمُحَكَّمَةِ.',
        exampleEn: 'I read the new article in the peer-reviewed scientific journal.',
        exampleDe: 'Ich habe den neuen Artikel in der begutachteten Fachzeitschrift gelesen.',
        ruleAr:
            'يَتْبَعُ النَّعْتُ الْمَنْعُوتَ فِي الْعَرَبِيَّةِ فِي أَرْبَعَةٍ مِنْ عَشَرَةٍ (التَّعْرِيفِ، التَّذْكِيرِ، الْإِفْرَادِ، وَالْإِعْرَابِ: الْمَقَالَ الْجَدِيدَ).',
        ruleEn:
            'English attributive adjectives are completely invariable regardless of definiteness, gender, number, or grammatical role.',
        ruleDe:
            'Nach bestimmtem Artikel (der/die/das) trägt das Adjektiv nur -e (Nom. Sg. + Akk. Fem./Neutr.) oder -en (alle anderen Fälle, inkl. Plural).',
        declensionPatternTag: 'Schwache (-e / -en)',
        pitfallAlertAr:
            'فِي الْأَلْمَانِيَّةِ يَأْخُذُ الْمُذَكَّرُ الْمَنْصُوبُ (den) وَالْجَمْعُ الْمُعَرَّفُ (die) نِهَايَةَ «-en» دَائِمًا: «den neuen Artikel»، «die neuen Bücher».',
      ),
      NominalAgreementLesson(
        id: 'na_02',
        axis: DeclensionAgreementAxis.mixedIndefiniteDeclension,
        titleAr: 'التَّصْرِيفُ الْمُخْتَلَطُ بَعْدَ أَدَوَاتِ التَّنْكِيرِ وَالنَّفْيِ (ein / kein / mein)',
        titleEn: 'German Mixed Declension When Article Lacks Gender Marker',
        titleDe: 'Gemischte Deklination: ein guter Rat / ein neues Buch',
        exampleAr: 'هَذَا كِتَابٌ مُفِيدٌ، وَتِلْكَ نَصِيحَةٌ حَكِيمَةٌ لِكُلِّ بَاحِثٍ.',
        exampleEn: 'This is a useful book, and that is a wise piece of advice for every researcher.',
        exampleDe: 'Das ist ein nützliches Buch und ein guter Rat für jeden Forscher.',
        ruleAr:
            'النَّعْتُ الْمُنَكَّرُ فِي الْعَرَبِيَّةِ يَحْمِلُ التَّنْوِينَ نَفْسَهُ (كِتَابٌ مُفِيدٌ) رَفْعًا وَنَصْبًا وَجَرًّا.',
        ruleEn:
            'English distinguishes "a/an" phonologically before vowel vs. consonant sounds, while adjectives stay uninflected.',
        ruleDe:
            'Da „ein“ im Nominativ Maskulinum und Nom./Akk. Neutrum keine Endung trägt, übernimmt das Adjektiv die Signalendung: „ein guter“ (-er), „ein nützliches“ (-es).',
        declensionPatternTag: 'Gemischte (-er/-es/-e/-en)',
        pitfallAlertAr:
            'لَا تَقُلْ *ein gute Buch؛ لِأَنَّ «ein» لَا تُظْهِرُ جِنْسَ الْمُحَايِدِ، فَيَجِبُ أَنْ يَحْمِلَ النَّعْتُ عَلَامَتَهُ: «ein gutes Buch».',
      ),
      NominalAgreementLesson(
        id: 'na_03',
        axis: DeclensionAgreementAxis.strongZeroArticleDeclension,
        titleAr: 'التَّصْرِيفُ الْقَوِيُّ عِنْدَ انْعِدَامِ الْأَدَاةِ (Nullartikel)',
        titleEn: 'Zero-Article Noun Phrases & German Strong Endings',
        titleDe: 'Starke Deklination ohne Artikel (kaltes Wasser, gute Ideen)',
        exampleAr: 'أَثْمَرَ التَّعَاوُنُ نَتَائِجَ بَاهِرَةً وَعِلْمًا نَافِعًا.',
        exampleEn: 'Collaboration yielded impressive results and beneficial knowledge.',
        exampleDe: 'Die Zusammenarbeit brachte beeindruckende Ergebnisse und nützliches Wissen hervor.',
        ruleAr:
            'تُجَرَّدُ النَّكِرَةُ فِي الْعَرَبِيَّةِ مِنْ «أَلْ» وَيَبْقَى التَّنْوِينُ دَالًّا عَلَى التَّنْكِيرِ وَالْإِعْرَابِ.',
        ruleEn:
            'English uses zero article with plural count nouns ("impressive results") and uncountable mass nouns ("beneficial knowledge").',
        ruleDe:
            'Fehlt der Artikel, übernimmt das Adjektiv die Endungen des bestimmten Artikels (außer Genitiv Mask./Neutr. Sg.: -en statt -es, z. B. „trotz guten Willens“).',
        declensionPatternTag: 'Starke (ohne Artikel)',
        pitfallAlertAr:
            'فِي الْجَرِّ الْإِضَافِيِّ (Genitiv) بِدُونِ أَدَاةٍ لِلْمُذَكَّرِ وَالْمُحَايِدِ تَظْهَرُ «-en» لَا «-es»: «wegen starken Regens».',
      ),
      NominalAgreementLesson(
        id: 'na_04',
        axis: DeclensionAgreementAxis.arabicNonHumanPluralAgreement,
        titleAr: 'قَاعِدَةُ جَمْعِ غَيْرِ الْعَاقِلِ فِي الْعَرَبِيَّةِ مُقَابِلَ الْجَمْعِ الْأَلْمَانِيِّ',
        titleEn: 'Arabic Non-Human Plural Agreement vs. German/English Plural',
        titleDe: 'Arabischer Sachplural (Fem. Sg.) vs. deutscher Plural (die)',
        exampleAr: 'هَذِهِ الْمَخْطُوطَاتُ النَّادِرَةُ مَحْفُوظَةٌ بِعِنَايَةٍ.',
        exampleEn: 'These rare manuscripts are preserved carefully.',
        exampleDe: 'Diese seltenen Handschriften werden sorgfältig aufbewahrt.',
        ruleAr:
            'جَمْعُ غَيْرِ الْعَاقِلِ (الْمَخْطُوطَاتُ، الْكُتُبُ) يُنْعَتُ وَيُشَارُ إِلَيْهِ بِالْمُفْرَدَةِ الْمُؤَنَّثَةِ غَالِبًا: «هَذِهِ الْمَخْطُوطَاتُ النَّادِرَةُ».',
        ruleEn:
            'English uses plural demonstratives ("these") and plural verb agreement ("are") for all plurals regardless of animacy.',
        ruleDe:
            'Im Deutschen ist der Plural geschlechtsneutral („die/diese seltenen Handschriften“) und das Adjektiv endet nach „diese“ auf -en.',
        declensionPatternTag: 'جَمْعُ غَيْرِ الْعَاقِلِ',
        pitfallAlertAr:
            'لَا تَنْقُلْ عَادَةَ الْإِفْرَادِ وَالتَّأْنِيثِ لِجَمْعِ غَيْرِ الْعَاقِلِ إِلَى الْأَلْمَانِيَّةِ أَوِ الْإِنْجِلِيزِيَّةِ؛ فَالْجَمْعُ فِيهِمَا يَأْخُذُ فِعْلًا وَإِشَارَةً لِلْجَمْعِ دَائِمًا.',
      ),
      NominalAgreementLesson(
        id: 'na_05',
        axis: DeclensionAgreementAxis.definitenessAndZeroArticle,
        titleAr: 'الْأَسْمَاءُ الْمُجَرَّدَةُ وَالْجِنْسِيَّةُ: «أَلْ» الْعَرَبِيَّةُ مُقَابِلَ الصِّفْرِ فِي الْإِنْجِلِيزِيَّةِ',
        titleEn: 'Abstract & Generic Nouns: Arabic "al-" vs. English Zero Article',
        titleDe: 'Abstrakta im Deutschen: oft ohne Artikel oder mit bestimmtem Artikel',
        exampleAr: 'الصِّدْقُ مَنْجَاةٌ، وَالْعِلْمُ يُنِيرُ الْعُقُولَ.',
        exampleEn: 'Honesty brings safety, and knowledge illuminates minds.',
        exampleDe: 'Ehrlichkeit führt zum Erfolg, und Wissen erleuchtet den Verstand.',
        ruleAr:
            'تَسْتَعْمِلُ الْعَرَبِيَّةُ «أَلْ» الْجِنْسِيَّةَ لِلتَّعْبِيرِ عَنِ الْمَفَاهِيمِ الْمُجَرَّدَةِ (الصِّدْقُ، الْعِلْمُ، الصَّبْرُ).',
        ruleEn:
            'Generic uncountable and abstract nouns in English take ZERO article ("Honesty", NOT *"The honesty").',
        ruleDe:
            'Im Deutschen stehen allgemeine Abstrakta im Nominativ meist artikellos („Ehrlichkeit“, „Wissen“), können aber bei Präpositionen einen Artikel annehmen („mit der Geduld“).',
        declensionPatternTag: 'Generik (al- vs. Ø)',
        pitfallAlertAr:
            'تَرْجَمَةُ «الْعِلْمُ نُورٌ» إِلَى *The knowledge is light خَطَأٌ شَائِعٌ؛ الصَّوَابُ فِي الْإِنْجِلِيزِيَّةِ «Knowledge is light».',
      ),
      NominalAgreementLesson(
        id: 'na_06',
        axis: DeclensionAgreementAxis.predicativeVsAttributive,
        titleAr: 'فَصْلُ النَّعْتِ الْمُتَصَرِّفِ عَنِ الْخَبَرِ الثَّابِتِ فِي الْأَلْمَانِيَّةِ',
        titleEn: 'Attributive Agreement vs. Uninflected Predicative Adjectives',
        titleDe: 'Attributives Adjektiv (flektiert) vs. prädikatives Adjektiv (endungslos)',
        exampleAr: 'النَّصُّ الْوَاضِحُ نَافِعٌ؛ وَالْجُمْلَةُ الدَّقِيقَةُ مَفْهُومَةٌ.',
        exampleEn: 'The clear text is useful; the precise sentence is understandable.',
        exampleDe: 'Der klare Text ist nützlich; der genaue Satz ist verständlich.',
        ruleAr:
            'فِي الْعَرَبِيَّةِ يَتَطَابَقُ الْخَبَرُ مَعَ الْمُبْتَدَأِ تَذْكِيرًا وَتَأْنِيثًا وَعَدَدًا (النَّصُّ نَافِعٌ / الْجُمْلَةُ مَفْهُومَةٌ).',
        ruleEn:
            'English adjectives remain invariable in both attributive and predicative positions.',
        ruleDe:
            'Nur das attributive Adjektiv vor dem Nomen wird dekliniert („der klare Text“); nach „sein / werden / bleiben“ bleibt es völlig endungslos („ist nützlich“).',
        declensionPatternTag: 'Attributiv vs. Prädikativ',
        pitfallAlertAr:
            'لَا تُضِفْ أَيَّ نِهَايَةٍ لِلصِّفَةِ الْأَلْمَانِيَّةِ بَعْدَ «ist / sind» مِثْلَ *Der Text ist nützlicher (إِلَّا فِي الْمُقَارَنَةِ «أَنْفَعُ»).',
      ),
    ];
  }

  List<NominalAgreementDrill> getDrills() {
    return const [
      NominalAgreementDrill(
        id: 'nad_01',
        axis: DeclensionAgreementAxis.weakDefiniteDeclension,
        targetLanguage: 'German',
        promptAr: 'اخْتَرِ النِّهَايَةَ الصَّحِيحَةَ لِلنَّعْتِ بَعْدَ أَدَاةِ التَّعْرِيفِ الْمَنْصُوبَةِ: «Ich lese den ... Artikel.»',
        promptEn: 'Choose the correct German weak adjective ending after "den":',
        promptDe: 'Wählen Sie die korrekte Adjektivendung nach „den“:',
        options: [
          'neue',
          'neuen',
          'neuer',
        ],
        correctIndex: 1,
        explanationAr: 'بَعْدَ «den» (الْمُذَكَّرُ الْمَنْصُوبُ) تَأْخُذُ الصِّفَةُ نِهَايَةَ «-en» دَائِمًا: «den neuen Artikel».',
      ),
      NominalAgreementDrill(
        id: 'nad_02',
        axis: DeclensionAgreementAxis.mixedIndefiniteDeclension,
        targetLanguage: 'German',
        promptAr: 'مَا النِّهَايَةُ الصَّحِيحَةُ لِلنَّعْتِ بَعْدَ «ein» مَعَ الِاسْمِ الْمُحَايِدِ (das Buch): «Das ist ein ... Buch.»؟',
        promptEn: 'Select the mixed declension ending for neuter "Buch" after "ein":',
        promptDe: 'Welche Endung braucht das Adjektiv in „Das ist ein ... Buch“?',
        options: [
          'gute',
          'guter',
          'gutes',
        ],
        correctIndex: 2,
        explanationAr: '«ein» لَا تُظْهِرُ جِنْسَ الْمُحَايِدِ (das)، فَتَحْمِلُ الصِّفَةُ «-es»: «ein gutes Buch».',
      ),
      NominalAgreementDrill(
        id: 'nad_03',
        axis: DeclensionAgreementAxis.strongZeroArticleDeclension,
        targetLanguage: 'German',
        promptAr: 'اخْتَرِ الصِّيغَةَ الصَّحِيحَةَ فِي الْجَرِّ الْإِضَافِيِّ بِدُونِ أَدَاةٍ: «trotz ... Regens»',
        promptEn: 'Choose the strong zero-article Genitive ending before "Regens":',
        promptDe: 'Wählen Sie die korrekte Endung im artikellosen Genitiv:',
        options: [
          'starkes',
          'starken',
          'starker',
        ],
        correctIndex: 1,
        explanationAr: 'فِي Genitiv بِدُونِ أَدَاةٍ لِلْمُذَكَّرِ وَالْمُحَايِدِ نَسْتَعْمِلُ «-en» لِأَنَّ الِاسْمَ يَحْمِلُ «-s»: «trotz starken Regens».',
      ),
      NominalAgreementDrill(
        id: 'nad_04',
        axis: DeclensionAgreementAxis.arabicNonHumanPluralAgreement,
        targetLanguage: 'Arabic',
        promptAr: 'مَا النَّعْتُ الْأَفْصَحُ لِجَمْعِ غَيْرِ الْعَاقِلِ: «قَرَأْتُ الْكُتُبَ ...»؟',
        promptEn: 'Choose the standard Arabic agreement for the non-human plural "al-kutub":',
        promptDe: 'Welche Kongruenz gilt für den arabischen Sachplural „al-kutub“?',
        options: [
          'الْمُفِيدُونَ',
          'الْمُفِيدَةَ',
          'الْمُفِيدَ',
        ],
        correctIndex: 1,
        explanationAr: 'جَمْعُ التَّكْسِيرِ لِغَيْرِ الْعَاقِلِ يُعَامَلُ مُعَامَلَةَ الْمُفْرَدَةِ الْمُؤَنَّثَةِ: «الْكُتُبَ الْمُفِيدَةَ».',
      ),
      NominalAgreementDrill(
        id: 'nad_05',
        axis: DeclensionAgreementAxis.definitenessAndZeroArticle,
        targetLanguage: 'English',
        promptAr: 'أَيُّ تَرْجَمَةٍ إِنْجِلِيزِيَّةٍ أَصَحُّ لِجُمْلَةِ: «الصَّبْرُ مِفْتَاحُ الْفَهْمِ»؟',
        promptEn: 'Choose the natural English rendering of the generic abstract statement:',
        promptDe: 'Welche englische Übersetzung verwendet den Artikel bei Abstrakta richtig?',
        options: [
          'The patience is the key to the understanding.',
          'Patience is the key to understanding.',
          'A patience is key to understanding.',
        ],
        correctIndex: 1,
        explanationAr: 'الْأَسْمَاءُ الْمُجَرَّدَةُ الْعَامَّةُ فِي الْإِنْجِلِيزِيَّةِ تَتَجَرَّدُ مِنْ «the»: «Patience is the key to understanding».',
      ),
      NominalAgreementDrill(
        id: 'nad_06',
        axis: DeclensionAgreementAxis.predicativeVsAttributive,
        targetLanguage: 'German',
        promptAr: 'اخْتَرِ الصِّيغَةَ الصَّحِيحَةَ لِلصِّفَةِ الْخَبَرِيَّةِ بَعْدَ «sind»: «Die Aufgaben sind ...»',
        promptEn: 'Select the correct predicative adjective form in German:',
        promptDe: 'Wählen Sie die korrekte prädikative Adjektivform:',
        options: [
          'klare',
          'klaren',
          'klar',
        ],
        correctIndex: 2,
        explanationAr: 'الصِّفَةُ الْخَبَرِيَّةُ بَعْدَ «sein» لَا تَأْخُذُ أَيَّ لَاحِقَةٍ إِعْرَابِيَّةٍ فِي الْأَلْمَانِيَّةِ: «sind klar».',
      ),
    ];
  }
}
