import '../models/idafa_compound_models.dart';

class IdafaCompoundRepository {
  const IdafaCompoundRepository();

  List<CompoundIdafaLessonUnit> getUnits() {
    return const [
      CompoundIdafaLessonUnit(
        id: 'ic_01',
        category: CompoundIdafaCategory.idafaVsKomposita,
        titleAr: 'انْعِكَاسُ التَّرْتِيبِ: الْمُضَافُ أَوَّلًا فِي الْعَرَبِيَّةِ وَالْأَسَاسُ آخِرًا فِي الْأَلْمَانِيَّةِ',
        titleEn: 'Head-Initial Idafa vs. Head-Final German & English Compounds',
        titleDe: 'Letztes Glied (Grundwort) bestimmt Genus und Plural',
        exampleAr: 'أَخَذْتُ قَامُوسَ الطَّالِبِ إِلَى مَكْتَبَةِ الْجَامِعَةِ.',
        exampleEn: 'I took the student dictionary to the university library.',
        exampleDe: 'Ich habe das Wörterbuch (das Buch) in die Universitätsbibliothek (die Bibliothek) mitgenommen.',
        ruleAr:
            'فِي الْإِضَافَةِ الْعَرَبِيَّةِ يَتَقَدَّمُ الْمُضَافُ (قَامُوسُ، مَكْتَبَةِ) وَيَتْبَعُهُ الْمُضَافُ إِلَيْهِ مَجْرُورًا؛ أَمَّا فِي الْأَلْمَانِيَّةِ وَالْإِنْجِلِيزِيَّةِ فَالْكَلِمَةُ الْأَسَاسِيَّةُ تَأْتِي فِي النِّهَايَةِ.',
        ruleEn:
            'English forms open noun-noun compounds ("university library") where the final noun is the grammatical head.',
        ruleDe:
            'Bei deutschen Komposita bestimmt immer das letzte Wort (Grundwort) den Artikel und den Plural: das Wort + die Bücher = die Wörterbücher.',
        structureTag: 'Head-Initial ↔ Head-Final',
        pitfallAlertAr:
            'الْخَطَأُ الشَّائِعُ: أَخْذُ أَدَاةِ التَّعْرِيفِ مِنَ الْكَلِمَةِ الْأُولَى فِي الْمُرَكَّبِ الْأَلْمَانِيِّ (مِثْل: *die Schreibtisch لِأَنَّ die كتابة!)؛ الصَّوَابُ «der Schreibtisch» لِأَنَّ «der Tisch» مُذَكَّرٌ.',
      ),
      CompoundIdafaLessonUnit(
        id: 'ic_02',
        category: CompoundIdafaCategory.fugenElements,
        titleAr: 'حُرُوفُ الرَّبْطِ الْأَلْمَانِيَّةُ (Fugenelemente) مُقَابِلَ حَذْفِ التَّنْوِينِ وَ«ال»',
        titleEn: 'German Linking Morphemes (-s-, -n-, -er-) vs. Idafa Bare Head',
        titleDe: 'Fugen-s (Arbeitsplatz), Fugen-n (Straßenbahn), Plural-er (Bücherregal)',
        exampleAr: 'رَتَّبْتُ رَفَّ الْكُتُبِ فِي مَكَانِ الْعَمَلِ قَبْلَ يَوْمِ الِامْتِحَانِ.',
        exampleEn: 'I organized the bookshelf at the workplace before exam day.',
        exampleDe: 'Ich habe das Bücherregal am Arbeitsplatz vor dem Prüfungstag geordnet.',
        ruleAr:
            'يُجَرَّدُ الْمُضَافُ فِي الْعَرَبِيَّةِ مِنْ «ال» وَمِنَ التَّنْوِينِ وَنُونِ الْمُثَنَّى وَجَمْعِ الْمُذَكَّرِ السَّالِمِ وُجُوبًا (مَكَانُ الْعَمَلِ لَا *الْمَكَانُ الْعَمَلِ).',
        ruleEn:
            'English noun modifiers are almost always singular without linking suffixes ("bookshelf", "exam day").',
        ruleDe:
            'Nach Nomen auf -ung, -heit, -keit, -schaft, -tion steht fast immer das Fugen-s (Prüfungstag, Universitätsbibliothek).',
        structureTag: 'Fugen-s/-n • تَجْرِيدُ الْمُضَافِ',
        pitfallAlertAr:
            'لَا تَضَعْ «ال» عَلَى الْمُضَافِ أَبَدًا (*الْمَكْتَبُ الْبَرِيدِ خَطَأٌ)، وَلَا تَنْسَ حَرْفَ «s» بَعْدَ «-ung/-heit/-keit» فِي الْمُرَكَّبَاتِ الْأَلْمَانِيَّةِ.',
      ),
      CompoundIdafaLessonUnit(
        id: 'ic_03',
        category: CompoundIdafaCategory.genitiveVsVonDativ,
        titleAr: 'الْإِضَافَةُ الْمِلْكِيَّةُ: Genitiv الْأَلْمَانِيُّ مُقَابِلَ \'s وَof الْإِنْجِلِيزِيَّيْنِ',
        titleEn: 'Possessive Genitive vs. English \'s / of & German von + Dativ',
        titleDe: 'Genitiv (das Buch des Lehrers) vs. von + Dativ (das Buch vom Lehrer)',
        exampleAr: 'شَرَحَ الدَّرْسُ مَوْضُوعَ الْكِتَابِ وَمُلَخَّصَ الْمُحَاضِرِ.',
        exampleEn: 'The lesson explained the topic of the book and the lecturer\'s summary.',
        exampleDe: 'Die Lektion erklärte das Thema des Buches und die Zusammenfassung des Dozenten.',
        ruleAr:
            'تَسْتَغْنِي الْعَرَبِيَّةُ بِالْإِضَافَةِ عَنْ حُرُوفِ الْمِلْكِيَّةِ فِي أَغْلَبِ السِّيَاقَاتِ، وَيَتَعَرَّفُ الْمُضَافُ إِذَا أُضِيفَ إِلَى مَعْرِفَةٍ.',
        ruleEn:
            'English prefers "\'s" for people/animate possessors ("the lecturer\'s summary") and "of" for inanimate things ("the topic of the book").',
        ruleDe:
            'Im Genitiv erhalten maskuline und neutrale Nomen -(e)s (des Buches) und schwache Maskulina -(e)n (des Dozenten); mündlich ersetzt oft „von + Dativ“.',
        structureTag: 'Genitiv -(e)s • \'s / of',
        pitfallAlertAr:
            'تَذَكَّرْ أَنَّ الْأَسْمَاءَ الْمُذَكَّرَةَ الضَّعِيفَةَ (der Dozent, der Student) تَأْخُذُ «-en» فِي الْمَجْرُورِ (des Dozenten) وَلَيْسَ «-s».',
      ),
      CompoundIdafaLessonUnit(
        id: 'ic_04',
        category: CompoundIdafaCategory.adjectivePlacementInIdafa,
        titleAr: 'تَأْخِيرُ النَّعْتِ بَعْدَ الْمُضَافِ إِلَيْهِ فِي الْعَرَبِيَّةِ وَضَبْطُ حَرَكَتِهِ',
        titleEn: 'Breaking the Idafa Trap: Post-Chain Adjectives vs. Fronted Adjectives',
        titleDe: 'Das Adjektiv vor dem Kompositum bezieht sich auf das Grundwort',
        exampleAr: 'قَرَأْتُ مَقَالَ الْمَجَلَّةِ الْجَدِيدَ (المقال)؛ وَمَقَالَ الْمَجَلَّةِ الْجَدِيدَةِ (المجلة).',
        exampleEn: 'I read the new article of the magazine vs. the article of the new magazine.',
        exampleDe: 'Ich las den neuen Zeitschriftenartikel vs. den Artikel der neuen Zeitschrift.',
        ruleAr:
            'يُمْنَعُ الْفَصْلُ بَيْنَ الْمُضَافِ وَالْمُضَافِ إِلَيْهِ بِالنَّعْتِ فِي الْعَرَبِيَّةِ؛ فَيُؤَخَّرُ النَّعْتُ بَعْدَهُمَا وَتُحَدِّدُ حَرَكَتُهُ الْإِعْرَابِيَّةُ الْمَنْعُوتَ.',
        ruleEn:
            'In English, placing an adjective before a closed/open compound ("the new magazine article") usually modifies the whole compound head ("article").',
        ruleDe:
            'Im Deutschen steht das Adjektiv vor dem gesamten Kompositum und richtet sich in Genus, Numerus und Kasus nach dem Grundwort: „der neue Artikel“.',
        structureTag: 'حَرَكَةُ النَّعْتِ تَكْشِفُ الْمَنْعُوتَ',
        pitfallAlertAr:
            'الْخَطَأُ الْقَاتِلُ: قَوْلُ *مَقَالُ الْجَدِيدُ الْمَجَلَّةِ! لَا يَجُوزُ إِدْخَالُ النَّعْتِ بَيْنَ الْمُضَافِ وَالْمُضَافِ إِلَيْهِ أَبَدًا.',
      ),
      CompoundIdafaLessonUnit(
        id: 'ic_05',
        category: CompoundIdafaCategory.verbalSyntheticCompounds,
        titleAr: 'الْإِضَافَةُ اللَّفْظِيَّةُ (غَيْرُ الْمَحْضَةِ) وَالْمُرَكَّبَاتُ الْمُشْتَقَّةُ',
        titleEn: 'Arabic Verbal Idafa (Lafẓiyya) vs. Agentive Synthetic Compounds',
        titleDe: 'Rektionskomposita: Sprachlehrer, Buchleser, Ratschlag',
        exampleAr: 'هُوَ مُعَلِّمُ اللُّغَةِ الصَّبُورُ وَقَارِئُ الْكُتُبِ الْمُثَابِرُ.',
        exampleEn: 'He is a patient language teacher and a diligent book reader.',
        exampleDe: 'Er ist ein geduldiger Sprachlehrer und ein fleißiger Buchleser.',
        ruleAr:
            'الْإِضَافَةُ اللَّفْظِيَّةُ يَكُونُ فِيهَا الْمُضَافُ وَصْفًا مُشْتَقًّا (اسْمَ فَاعِلٍ أَوْ صِفَةً مُشَبَّهَةً) مِثْل «قَارِئُ الْكُتُبِ»، وَلَا تُفِيدُ تَعْرِيفًا بَلْ تَخْفِيفًا.',
        ruleEn:
            'English synthetic compounds combine an object noun with an "-er" agentive noun ("book reader", "language teacher").',
        ruleDe:
            'Deutsche Rektionskomposita verbinden das Objekt als Bestimmungswort mit dem Nomen Agentis (-er): „Sprache“ + „Lehrer“ → „Sprachlehrer“.',
        structureTag: 'اسْمُ فَاعِلٍ + مَعْمُولٌ ↔ N+-er',
        pitfallAlertAr:
            'فِي الْعَرَبِيَّةِ، «قَارِئُ الْكُتُبِ» تَبْقَى نَكِرَةً مَا لَمْ تَدْخُلْ «ال» عَلَى «الْقَارِئُ»، وَيَجُوزُ نَعْتُهَا بِالنَّكِرَةِ أَوِ الْمَعْرِفَةِ حَسَبَ الْإِفْرَادِ وَالتَّعْرِيفِ.',
      ),
      CompoundIdafaLessonUnit(
        id: 'ic_06',
        category: CompoundIdafaCategory.semanticAmbiguityScope,
        titleAr: 'الْإِضَافَةُ الْمُتَعَدِّدَةُ وَتَفَادِي اللَّبْسِ بِالشَّرْطَةِ (Bindestrich)',
        titleEn: 'Recursive Idafa Chains vs. German Hyphenated Compounds',
        titleDe: 'Durchkopplung & Lesbarkeit bei langen Komposita',
        exampleAr: 'حَفِظْتُ مِفْتَاحَ بَابِ قَاعَةِ الْمُحَاضَرَاتِ فِي دَفْتَرِ الْمُلَاحَظَاتِ.',
        exampleEn: 'I kept the lecture-hall door key in the notebook.',
        exampleDe: 'Ich habe den Vorlesungssaal-Türschlüssel im Notizbuch aufbewahrt.',
        ruleAr:
            'تَتَسَلْسَلُ الْإِضَافَةُ فِي الْعَرَبِيَّةِ مِنْ دَاخِلٍ إِلَى خَارِجٍ؛ فَكُلُّ اسْمٍ وَسَطِيٍّ مَجْرُورٌ بِمَا قَبْلَهُ وَمُضَافٌ لِمَا بَعْدَهُ بِدُونِ «ال».',
        ruleEn:
            'English uses hyphens in multi-word modifiers ("lecture-hall door key") to group sub-modifiers clearly.',
        ruleDe:
            'Bei dreigliedrigen oder unübersichtlichen Komposita empfiehlt der Duden einen Bindestrich (Vorlesungssaal-Türschlüssel, Deutsch-Arabisch-Wörterbuch).',
        structureTag: 'تَسَلْسُلُ الْإِضَافَةِ • Bindestrich',
        pitfallAlertAr:
            'فِي السِّلْسِلَةِ الطَّوِيلَةِ، «ال» لَا تَدْخُلُ إِلَّا عَلَى الِاسْمِ الْأَخِيرِ فَقَطْ (مِفْتَاحُ بَابِ قَاعَةِ الْمُحَاضَرَاتِ)؛ وَإِدْخَالُهَا فِي الْوَسَطِ يَقْطَعُ الْإِضَافَةَ.',
      ),
    ];
  }

  List<CompoundIdafaDrillItem> getDrills() {
    return const [
      CompoundIdafaDrillItem(
        id: 'ic_d1',
        category: CompoundIdafaCategory.idafaVsKomposita,
        targetLanguage: 'DE',
        promptAr: 'مَا أَدَاةُ التَّعْرِيفِ الصَّحِيحَةُ لِلْمُرَكَّبِ «Wörterbuch» (من die Wörter + das Buch)؟',
        promptEn: 'Which definite article is correct for the German compound "Wörterbuch"?',
        promptDe: 'Welcher Artikel gehört zum Kompositum „Wörterbuch“?',
        options: [
          'das Wörterbuch (تَبَعًا لِـ das Buch)',
          'die Wörterbuch (تَبَعًا لِـ die Wörter)',
          'der Wörterbuch',
        ],
        correctIndex: 0,
        explanationAr:
            'فِي الْأَلْمَانِيَّةِ تَتْبَعُ أَدَاةُ الْمُرَكَّبِ الِاسْمَ الْأَخِيرَ (Grundwort) دَائِمًا؛ وَبِمَا أَنَّ «das Buch» مُحَايِدٌ فَالْمُرَكَّبُ «das Wörterbuch».',
      ),
      CompoundIdafaDrillItem(
        id: 'ic_d2',
        category: CompoundIdafaCategory.fugenElements,
        targetLanguage: 'DE',
        promptAr: 'اخْتَرِ الصِّيغَةَ السَّلِيمَةَ لِتَرْكِيبِ «die Prüfung + der Tag» (يَوْمُ الِامْتِحَانِ):',
        promptEn: 'Choose the correct German compound for "exam day" (Prüfung + Tag):',
        promptDe: 'Wie lautet das korrekte Kompositum aus „die Prüfung“ und „der Tag“?',
        options: [
          'der Prüfungstag (بِإِضَافَةِ Fugen-s)',
          'der Prüfungtag (بِدُونِ رَابِطٍ)',
          'die Prüfungstag',
        ],
        correctIndex: 0,
        explanationAr:
            'الْأَسْمَاءُ الْمُنْتَهِيَةُ بِلَاحِقَةِ «-ung» تَأْخُذُ رَابِطَ «-s-» وُجُوبًا، وَالْأَدَاةُ تَتْبَعُ «der Tag»: der Prüfungstag.',
      ),
      CompoundIdafaDrillItem(
        id: 'ic_d3',
        category: CompoundIdafaCategory.genitiveVsVonDativ,
        targetLanguage: 'DE',
        promptAr: 'أَكْمِلْ جُمْلَةَ الْمِلْكِيَّةِ بِحَالَةِ Genitiv: «Das ist die Tasche ___» (الطَّالِبِ):',
        promptEn: 'Complete the German Genitive phrase for "the student\'s bag":',
        promptDe: 'Ergänze den Genitiv korrekt: „Das ist die Tasche ___“ (der Student):',
        options: [
          'des Studenten',
          'des Students',
          'dem Student',
        ],
        correctIndex: 0,
        explanationAr:
            'كَلِمَةُ «der Student» مِنَ الْأَسْمَاءِ الْمُذَكَّرَةِ الضَّعِيفَةِ (n-Deklination)، لِذَا تَنْتَهِي بِـ «-en» فِي الْمَجْرُورِ: des Studenten.',
      ),
      CompoundIdafaDrillItem(
        id: 'ic_d4',
        category: CompoundIdafaCategory.adjectivePlacementInIdafa,
        targetLanguage: 'AR',
        promptAr: 'تَرْجِمْ «The new gate of the university» (الْبَوَّابَةُ هِيَ الْجَدِيدَةُ) تَرْجَمَةً نَحْوِيَّةً سَلِيمَةً:',
        promptEn: 'Choose the accurate Arabic Idafa with adjective modifying "gate":',
        promptDe: 'Wähle die korrekte arabische Übersetzung für „das neue Tor der Universität“:',
        options: [
          'بَوَّابَةُ الْجَامِعَةِ الْجَدِيدَةُ',
          'بَوَّابَةُ الْجَدِيدَةُ الْجَامِعَةِ',
          'الْبَوَّابَةُ الْجَامِعَةِ الْجَدِيدَةُ',
        ],
        correctIndex: 0,
        explanationAr:
            'لَا يُفْصَلُ بَيْنَ الْمُضَافِ وَالْمُضَافِ إِلَيْهِ؛ فَيَتَأَخَّرُ النَّعْتُ «الْجَدِيدَةُ» مَرْفُوعًا لِيَصِفَ «بَوَّابَةُ» وَلَيْسَ «الْجَامِعَةِ».',
      ),
      CompoundIdafaDrillItem(
        id: 'ic_d5',
        category: CompoundIdafaCategory.verbalSyntheticCompounds,
        targetLanguage: 'EN',
        promptAr: 'مَا الصِّيغَةُ الْإِنْجِلِيزِيَّةُ الطَّبِيعِيَّةُ لِـ «مُعَلِّمُ اللُّغَةِ» كَمُرَكَّبٍ اسْمِيٍّ؟',
        promptEn: 'Select the natural English synthetic compound for "language teacher":',
        promptDe: 'Welche englische Form entspricht „Sprachlehrer“?',
        options: [
          'a language teacher',
          'a languages teacher',
          'a teacher language',
        ],
        correctIndex: 0,
        explanationAr:
            'فِي الْمُرَكَّبَاتِ الْإِنْجِلِيزِيَّةِ يَبْقَى الِاسْمُ الْمُحَدِّدُ الْأَوَّلُ مُفْرَدًا (language) وَيَسْبِقُ اسْمَ الْفَاعِلِ (teacher).',
      ),
      CompoundIdafaDrillItem(
        id: 'ic_d6',
        category: CompoundIdafaCategory.semanticAmbiguityScope,
        targetLanguage: 'AR',
        promptAr: 'اخْتَرِ الضَّبْطَ الصَّحِيحَ لِلْإِضَافَةِ الْمُتَسَلْسِلَةِ «key of the door of the hall»:',
        promptEn: 'Select the grammatically sound multi-level Arabic Idafa chain:',
        promptDe: 'Welche mehrgliedrige arabische Genitivkette ist grammatisch korrekt?',
        options: [
          'مِفْتَاحُ بَابِ الْقَاعَةِ',
          'مِفْتَاحُ الْبَابِ الْقَاعَةِ',
          'الْمِفْتَاحُ بَابِ الْقَاعَةِ',
        ],
        correctIndex: 0,
        explanationAr:
            'فِي الْإِضَافَةِ الْمُتَسَلْسِلَةِ تَتَجَرَّدُ جَمِيعُ الْأَسْمَاءِ السَّابِقَةِ مِنْ «ال»، وَتَدْخُلُ «ال» عَلَى الْمُضَافِ إِلَيْهِ الْأَخِيرِ فَقَطْ: مِفْتَاحُ بَابِ الْقَاعَةِ.',
      ),
    ];
  }
}
