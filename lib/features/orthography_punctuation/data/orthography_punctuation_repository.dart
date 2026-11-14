import '../models/orthography_punctuation_models.dart';

class OrthographyPunctuationRepository {
  const OrthographyPunctuationRepository();

  List<OrthographyLessonUnit> getUnits() {
    return const [
      OrthographyLessonUnit(
        id: 'op_01',
        category: OrthographyCategory.germanCapitalizationNominalization,
        titleAr: 'كِتَابَةُ الْأَسْمَاءِ وَالْمَصَادِرِ الْمُؤَسَّمَةِ بِحَرْفٍ كَبِيرٍ فِي الْأَلْمَانِيَّةِ',
        titleEn: 'German Universal Noun Capitalization vs. English Selective Capitals',
        titleDe: 'Alle Nomen und Substantivierungen (das Lesen, etwas Neues) groß',
        exampleAr: 'الْقِرَاءَةُ الْمُتَأَنِّيَةُ تُعِينُ عَلَى تَعَلُّمِ كُلِّ شَيْءٍ جَدِيدٍ.',
        exampleEn: 'Careful reading helps in learning something new.',
        exampleDe: 'Das sorgfältige Lesen hilft dabei, etwas Neues zu lernen.',
        ruleAr:
            'لَا تَعْرِفُ الْأَبْجَدِيَّةُ الْعَرَبِيَّةُ نِظَامَ الْحُرُوفِ الْكَبِيرَةِ وَالصَّغِيرَةِ، بَلْ تُحَافِظُ الْحُرُوفُ عَلَى شَكْلِهَا فِي كُلِّ مَوْضِعٍ.',
        ruleEn:
            'English capitalizes only proper nouns, sentence starts, and the pronoun "I" — never common nouns ("reading", "book").',
        ruleDe:
            'Im Deutschen werden ausnahmslos alle Nomen sowie substantivierte Verben/Adjektive (nach Artikeln oder nach „etwas / viel / nichts“) großgeschrieben.',
        scriptTag: 'Großschreibung • لا تفخيم خطي',
        pitfallAlertAr:
            'الْخَطَأُ الشَّائِعُ: كِتَابَةُ «das lesen» أَوْ «etwas neues» بِحَرْفٍ صَغِيرٍ؛ الصَّوَابُ «das Lesen» وَ«etwas Neues» لِأَنَّهُمَا صَارَا اسْمَيْنِ.',
      ),
      OrthographyLessonUnit(
        id: 'op_02',
        category: OrthographyCategory.szettVsDoubleS,
        titleAr: 'التَّفْرِيقُ الصَّوْتِيُّ بَيْنَ «ß» وَ«ss» فِي الْإِمْلَاءِ الْأَلْمَانِيِّ',
        titleEn: 'German "ß" After Long Vowels/Diphthongs vs. "ss" After Short Vowels',
        titleDe: 'Langer Vokal/Diphthong + ß (Straße, weiß) vs. kurzer Vokal + ss (Fluss, dass)',
        exampleAr: 'نَظَرْتُ إِلَى الشَّارِعِ الطَّوِيلِ وَالنَّهْرِ الصَّافِي، وَعَلِمْتُ أَنَّهُ قَرِيبٌ.',
        exampleEn: 'I looked at the long street and the clear river, and I knew that it is near.',
        exampleDe: 'Ich sah auf die lange Straße und den klaren Fluss und wusste, dass er nah ist.',
        ruleAr:
            'يَقْبَلُ الْإِمْلَاءُ الْعَرَبِيُّ تَضْعِيفَ الصَّامِتِ بِالشَّدَّةِ (ـّ) وَمَدَّ الصَّائِتِ بِحُرُوفِ الْمَدِّ (ا، و، ي) دُونَ تَبْدِيلِ شَكْلِ السِّينِ.',
        ruleEn:
            'English doubles consonants in many short-vowel contexts ("river" vs. "pass", "miss") and has no equivalent to "ß".',
        ruleDe:
            'Nach einem langen Vokal oder Diphthong (ei, au, eu) schreibt man „ß“ (Straße, heißen, Fuß); nach einem kurzen Vokal schreibt man „ss“ (Fluss, muss, dass).',
        scriptTag: 'ß (طويل) ↔ ss (قصير)',
        pitfallAlertAr:
            'لَا تَسْتَعْمِلْ *daß بِالشَّكْلِ الْقَدِيمِ بَعْدَ إِصْلَاحِ ١٩٩٦؛ الْحَرْفُ «a» فِي «dass» قَصِيرٌ، لِذَا يُكْتَبُ دَائِمًا «dass» وَ«muss».',
      ),
      OrthographyLessonUnit(
        id: 'op_03',
        category: OrthographyCategory.arabicHamzaRules,
        titleAr: 'سُلَّمُ أَقْوَى الْحَرَكَاتِ فِي رَسْمِ الْهَمْزَةِ الْمُتَوَسِّطَةِ وَهَمْزَةِ الْوَصْلِ',
        titleEn: 'Arabic Hamza Seat Selection (Kasra > Damma > Fatha) & Wasl vs. Qatʿ',
        titleDe: 'Arabische Hamza-Schreibung nach Vokalstärke (i > u > a)',
        exampleAr: 'سَأَلَ الطَّالِبُ عَنِ الْمَسْأَلَةِ، فَسُئِلَ عَنْ قِرَاءَةِ الْمُؤَلَّفِ وَاسْتِفَادَ.',
        exampleEn: 'The student asked about the issue, was asked about reading the book, and benefited.',
        exampleDe: 'Der Student fragte nach der Aufgabe, wurde nach der Lektüre des Werkes gefragt und profitierte.',
        ruleAr:
            'تُقَارَنُ حَرَكَةُ الْهَمْزَةِ الْمُتَوَسِّطَةِ بِحَرَكَةِ مَا قَبْلَهَا وَتُكْتَبُ عَلَى الْحَرْفِ الْمُنَاسِبِ لِأَقْوَاهُمَا (الْكَسْرَةُ ← يَاءٌ، الضَّمَّةُ ← وَاوٌ، الْفَتْحَةُ ← أَلِفٌ).',
        ruleEn:
            'English marks vowel quality through digraphs or silent "-e", whereas Arabic encodes glottal stops and seats in a single hamza grapheme.',
        ruleDe:
            'Während das Deutsche den Knacklaut vor anlautendem Vokal nicht schreibt, markiert das Arabische ihn genau als القطع (أ/إ) oder lässt ihn als الوصل (ا) aus.',
        scriptTag: 'كسرة > ضمة > فتحة > سكون',
        pitfallAlertAr:
            'احْذَرْ كِتَابَةَ هَمْزَةِ قَطْعٍ فِي مَصْدَرِ الْخُمَاسِيِّ وَالسُّدَاسِيِّ (*إِسْتَفَادَ خَطَأٌ؛ الصَّوَابُ «اِسْتَفَادَ» بِأَلِفِ وَصْلٍ)، أَمَّا الرُّبَاعِيُّ فَقَطْعٌ (أَكْرَمَ، إِكْرَامًا).',
      ),
      OrthographyLessonUnit(
        id: 'op_04',
        category: OrthographyCategory.taaMarbutaVsHaa,
        titleAr: 'مِقْيَاسُ التَّفْرِيقِ بَيْنَ التَّاءِ الْمَرْبُوطَةِ (ـة) وَالْهَاءِ (ـه) وَالأَلِفِ اللَّيِّنَةِ',
        titleEn: 'Distinguishing Arabic Tāʾ Marbūṭa (ـة) from Hāʾ (ـه) & Alif Maqṣūra',
        titleDe: 'Unterscheidung zwischen ة (Tāʾ marbūṭa) und ه (Hāʾ) durch Aussprachetest',
        exampleAr: 'أَكْرَمَ الْمُعَلِّمُ هَذِهِ الْمَدْرَسَةَ بِمَكْتَبَتِهِ الْعَامِرَةِ وَسَعَى إِلَى رِضَا اللهِ.',
        exampleEn: 'The teacher honored this school with his thriving library and strove for good.',
        exampleDe: 'Der Lehrer bereicherte diese Schule mit seiner Bibliothek und strebte nach dem Guten.',
        ruleAr:
            'لِلتَّفْرِيقِ بَيْنَ (ـة) وَ(ـه) نُحَرِّكُ الْكَلِمَةَ أَوْ نَصِلُهَا بِمَا بَعْدَهَا؛ فَإِنْ نُطِقَتْ تَاءً فَهِيَ مَرْبُوطَةٌ (مَدْرَسَةٌ)، وَإِنْ بَقِيَتْ هَاءً فَهِيَ هَاءٌ (مَكْتَبَتُهُ، هَذِهِ).',
        ruleEn:
            'In Arabic, "ـة" marks feminine/unit nouns and sounds like /t/ in liaison, whereas "ـه" is a possessive pronoun or root letter.',
        ruleDe:
            'Die Punktierung über dem „ة“ entscheidet über die Bedeutung: „مَكْتَبَة“ (Bibliothek) vs. „مَكْتَبَه“ (sein Büro).',
        scriptTag: 'ة (وصل=ت) ≠ ه (وصل=ه)',
        pitfallAlertAr:
            'فِي الْأَلِفِ اللَّيِّنَةِ الثُّلَاثِيَّةِ: إِذَا كَانَ أَصْلُهَا وَاوًا كُتِبَتْ مَمْدُودَةً (دَعَا ← يَدْعُو)، وَإِذَا كَانَ أَصْلُهَا يَاءً كُتِبَتْ مَقْصُورَةً (سَعَى / رَمَى ← يَرْمِي).',
      ),
      OrthographyLessonUnit(
        id: 'op_05',
        category: OrthographyCategory.trilingualCommaSyntax,
        titleAr: 'الْفَاصِلَةُ النَّحْوِيَّةُ: إلْزَامُهَا قَبْلَ الْجُمْلَةِ التَّابِعَةِ فِي الْأَلْمَانِيَّةِ مُقَابِلَ الْإِنْجِلِيزِيَّةِ',
        titleEn: 'Comma Discipline: German Grammatical Commas vs. English Prosodic Commas',
        titleDe: 'Pflichtkomma vor Nebensätzen („Ich weiß, dass...“) und Relativsätzen',
        exampleAr: 'أَعْلَمُ أَنَّ التَّدْرِيبَ الْمُسْتَمِرَّ، الَّذِي يُتْقِنُهُ الطَّالِبُ، يَرْفَعُ الْمُسْتَوَى.',
        exampleEn: 'I know that continuous practice, which the student masters, raises the level.',
        exampleDe: 'Ich weiß, dass kontinuierliches Training, das der Schüler beherrscht, das Niveau hebt.',
        ruleAr:
            'تُوضَعُ الْفَاصِلَةُ الْعَرَبِيَّةُ (،) بَيْنَ الْجُمَلِ الْمَعْطُوفَةِ وَقَبْلَ وَبَعْدَ الْجُمْلَةِ الِاعْتِرَاضِيَّةِ، وَلَا تُوضَعُ قَبْلَ «أَنَّ».',
        ruleEn:
            'English NEVER places a comma before a restrictive "that"-clause ("I know that...", NOT *I know, that...), though non-restrictive ", which..." takes commas.',
        ruleDe:
            'Im Deutschen trennt ein Komma zwingend jeden Nebensatz („dass“, „weil“, „ob“, Relativsatz) vom Hauptsatz.',
        scriptTag: 'DE: Pflichtkomma ↔ EN: No ", that"',
        pitfallAlertAr:
            'أَكْثَرُ أَخْطَاءِ التَّدَاخُلِ اللُّغَوِيِّ: نَقْلُ الْفَاصِلَةِ الْأَلْمَانِيَّةِ قَبْلَ «that» إِلَى الْإِنْجِلِيزِيَّةِ (*I think, that...)، أَوْ حَذْفُهَا قَبْلَ «dass» فِي الْأَلْمَانِيَّةِ.',
      ),
      OrthographyLessonUnit(
        id: 'op_06',
        category: OrthographyCategory.quotationMarksApostrophes,
        titleAr: 'عَلَامَاتُ التَّنْصِيصِ وَالْفَاصِلَةُ الْعُلْيَا (الْأَبُوسْتْرُوف) بَيْنَ النُّظُمِ الثَّلَاثَةِ',
        titleEn: 'Quotation Marks & Possessive Apostrophes: English \'s vs. German No-Apostrophe',
        titleDe: 'Deutsche Anführungszeichen („...“) & Genitiv ohne Apostroph (Karls Buch)',
        exampleAr: 'قَالَ الْمُحَاضِرُ: «مُلَخَّصُ الدَّرْسِ جَاهِزٌ فِي مَكْتَبِ الْمُدِيرِ».',
        exampleEn: 'The lecturer said, "The lesson summary is ready in the director\'s office."',
        exampleDe: 'Der Dozent sagte: „Die Zusammenfassung liegt in Annas Büro.“',
        ruleAr:
            'تَسْتَعْمِلُ الْعَرَبِيَّةُ عَلَامَتَيِ التَّنْصِيصِ «...» بَعْدَ النَّقْطَتَيْنِ الرَّأْسِيَّتَيْنِ (:)، وَلَا تَسْتَعْمِلُ الْفَاصِلَةَ الْعُلْيَا لِلْمِلْكِيَّةِ.',
        ruleEn:
            'English uses curved double quotes (“...”) and requires an apostrophe for possessive "-s" ("director\'s") and contractions ("don\'t").',
        ruleDe:
            'Im Deutschen steht das öffnende Anführungszeichen unten („...“). Beim Genitiv-s von Namen steht KEIN Apostroph (Annas Buch, nicht *Anna\'s Buch).',
        scriptTag: '«...» ↔ “...” ↔ „...“',
        pitfallAlertAr:
            'تَجَنَّبِ «Deppenapostroph» فِي الْأَلْمَانِيَّةِ: لَا تَضَعْ فَاصِلَةً عُلْيَا قَبْلَ «s» الْمِلْكِيَّةِ (*Berlin\'s Straßen خَطَأٌ؛ الصَّوَابُ «Berlins Straßen»).',
      ),
    ];
  }

  List<OrthographyDrillItem> getDrills() {
    return const [
      OrthographyDrillItem(
        id: 'op_d1',
        category: OrthographyCategory.germanCapitalizationNominalization,
        targetLanguage: 'DE',
        promptAr: 'اخْتَرِ الرَّسْمَ الْإِمْلَائِيَّ الصَّحِيحَ لِلْجُمْلَةِ الْأَلْمَانِيَّةِ:',
        promptEn: 'Choose the correctly capitalized German sentence:',
        promptDe: 'Welcher Satz ist nach der Groß- und Kleinschreibung korrekt?',
        options: [
          'Wir haben heute etwas Interessantes über das Schreiben gelernt.',
          'Wir haben heute etwas interessantes über das schreiben gelernt.',
          'Wir haben heute etwas Interessantes über das schreiben gelernt.',
        ],
        correctIndex: 0,
        explanationAr:
            'تُكْتَبُ كَلِمَةُ «Interessantes» بِحَرْفٍ كَبِيرٍ بَعْدَ «etwas»، وَكَذَلِكَ الْمَصْدَرُ الْمُعَرَّفُ بـ «das»: «das Schreiben».',
      ),
      OrthographyDrillItem(
        id: 'op_d2',
        category: OrthographyCategory.szettVsDoubleS,
        targetLanguage: 'DE',
        promptAr: 'اخْتَرِ الْكِتَابَةَ الصَّحِيحَةَ وَفْقَ قَاعِدَةِ «ß / ss»:',
        promptEn: 'Select the sentence with accurate German ß vs. ss spelling:',
        promptDe: 'In welchem Satz sind „ß“ und „ss“ richtig verwendet?',
        options: [
          'Ich weiß, dass du viel Fleiß hast.',
          'Ich weiss, daß du viel Fleiss hast.',
          'Ich weiß, daß du viel Fleiß hast.',
        ],
        correctIndex: 0,
        explanationAr:
            'تَأْتِي «ß» بَعْدَ الصَّائِتِ الْمُرَكَّبِ (weiß, Fleiß)، بَيْنَمَا تَأْتِي «ss» بَعْدَ الْحَرْفِ الْقَصِيرِ فِي «dass».',
      ),
      OrthographyDrillItem(
        id: 'op_d3',
        category: OrthographyCategory.arabicHamzaRules,
        targetLanguage: 'AR',
        promptAr: 'اخْتَرِ الرَّسْمَ الصَّحِيحَ لِلْهَمْزَةِ فِي كَلِمَةِ «سُئِلَ» وَمَصْدَرِ «اسْتِخْرَاج»:',
        promptEn: 'Choose the accurately spelled Arabic sentence with Hamza rules:',
        promptDe: 'Welcher arabische Satz wendet die Hamza-Regeln korrekt an?',
        options: [
          'سُئِلَ الطَّالِبُ عَنِ اسْتِخْرَاجِ الْمَعْنَى.',
          'سُؤِلَ الطَّالِبُ عَنْ إِسْتِخْرَاجِ الْمَعْنَى.',
          'سُئِلَ الطَّالِبُ عَنْ إِسْتِخْرَاجِ الْمَعْنَى.',
        ],
        correctIndex: 0,
        explanationAr:
            'فِي «سُئِلَ» الْكَسْرَةُ أَقْوَى مِنَ الضَّمَّةِ فَتُكْتَبُ عَلَى نَبِرَةٍ، وَ«اسْتِخْرَاج» مَصْدَرٌ سُدَاسِيٌّ هَمْزَتُهُ هَمْزَةُ وَصْلٍ.',
      ),
      OrthographyDrillItem(
        id: 'op_d4',
        category: OrthographyCategory.taaMarbutaVsHaa,
        targetLanguage: 'AR',
        promptAr: 'اخْتَرِ الْجُمْلَةَ الْخَالِيَةَ مِنَ الْأَخْطَاءِ فِي التَّاءِ الْمَرْبُوطَةِ وَالْهَاءِ وَالْأَلِفِ اللَّيِّنَةِ:',
        promptEn: 'Select the Arabic sentence with correct ة/ه and Alif Maqṣūra:',
        promptDe: 'Welcher arabische Satz unterscheidet ة/ه und ا/ى korrekt?',
        options: [
          'دَعَا الْمُدَرِّسُ إِلَى حِمَايَةِ الْمَكْتَبَةِ وَهَذِهِ الْقَاعَةِ.',
          'دَعَى الْمُدَرِّسُ إِلَى حِمَايَه الْمَكْتَبَه وَهَذِةِ الْقَاعَة.',
          'دَعَا الْمُدَرِّسُ إِلَى حِمَايَةِ الْمَكْتَبَه وَهَذِةِ الْقَاعَةِ.',
        ],
        correctIndex: 0,
        explanationAr:
            '«دَعَا» أَصْلُ أَلِفِهَا وَاوٌ (يَدْعُو) فَتُكْتَبُ مَمْدُودَةً، وَ«الْمَكْتَبَة» تَاءٌ مَرْبُوطَةٌ، وَ«هَذِهِ» هَاءٌ مَنْطُوقَةٌ وَصْلًا وَوَقْفًا.',
      ),
      OrthographyDrillItem(
        id: 'op_d5',
        category: OrthographyCategory.trilingualCommaSyntax,
        targetLanguage: 'EN',
        promptAr: 'اخْتَرِ التَّرْقِيمَ الْإِنْجِلِيزِيَّ السَّلِيمَ قَبْلَ «that»:',
        promptEn: 'Choose the English sentence with standard punctuation before "that":',
        promptDe: 'Welcher englische Satz hat die richtige Kommasetzung vor „that“?',
        options: [
          'She knows that regular practice improves fluency.',
          'She knows, that regular practice improves fluency.',
          'She knows that, regular practice improves fluency.',
        ],
        correctIndex: 0,
        explanationAr:
            'فِي الْإِنْجِلِيزِيَّةِ يُمْنَعُ وَضْعُ فَاصِلَةٍ قَبْلَ «that» الْمَصْدَرِيَّةِ، بِخِلَافِ «dass» الْأَلْمَانِيَّةِ الَّتِي تَلْزَمُهَا الْفَاصِلَةُ.',
      ),
      OrthographyDrillItem(
        id: 'op_d6',
        category: OrthographyCategory.quotationMarksApostrophes,
        targetLanguage: 'DE',
        promptAr: 'اخْتَرِ الصِّيغَةَ الْأَلْمَانِيَّةَ الصَّحِيحَةَ لِـ «مَكْتَبُ طَارِق» (دُونَ خَطَأِ الْفَاصِلَةِ الْعُلْيَا):',
        promptEn: 'Choose the standard German possessive name form:',
        promptDe: 'Welche Genitivschreibung ohne Fehler ist korrekt?',
        options: [
          'Tariqs Wörterbuch liegt auf dem Tisch.',
          'Tariq\'s Wörterbuch liegt auf dem Tisch.',
          'Tariqs\' Wörterbuch liegt auf dem Tisch.',
        ],
        correctIndex: 0,
        explanationAr:
            'فِي الْإِمْلَاءِ الْأَلْمَانِيِّ يُضَافُ حَرْفُ «s» مُبَاشَرَةً إِلَى الِاسْمِ دُونَ فَاصِلَةٍ عُلْيَا (Tariqs Wörterbuch).',
      ),
    ];
  }
}
