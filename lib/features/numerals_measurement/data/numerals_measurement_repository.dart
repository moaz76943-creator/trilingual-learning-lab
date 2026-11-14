import '../models/numerals_measurement_models.dart';

class NumeralsMeasurementRepository {
  const NumeralsMeasurementRepository();

  List<NumeralsLessonUnit> getUnits() {
    return const [
      NumeralsLessonUnit(
        id: 'nm_01',
        category: NumeralCategory.cardinalsPolarity,
        titleAr: 'مُخَالَفَةُ الْعَدَدِ لِلْمَعْدُودِ (٣–١٠) وَجَرُّ الْجَمْعِ بِالْإِضَافَةِ',
        titleEn: 'Arabic Gender Polarity (3–10) vs. Invariable German & English Cardinals',
        titleDe: 'Kardinalzahlen ab 2 verlangen den Plural ohne Genuswechsel',
        exampleAr: 'قَرَأْتُ ثَلَاثَةَ كُتُبٍ وَثَلَاثَ مَجَلَّاتٍ فِي الْمَكْتَبَةِ.',
        exampleEn: 'I read three books and three magazines in the library.',
        exampleDe: 'Ich habe drei Bücher und drei Zeitschriften in der Bibliothek gelesen.',
        ruleAr:
            'الْأَعْدَادُ مِن ٣ إِلَى ١٠ تُخَالِفُ مُفْرَدَ الْمَعْدُودِ تَذْكِيرًا وَتَأْنِيثًا، وَيَكُونُ تَمْيِيزُهَا جَمْعًا مَجْرُورًا بِالْإِضَافَةِ (كُتُبٍ، مَجَلَّاتٍ).',
        ruleEn:
            'English cardinals from 2 onward are completely invariable and require a plural noun.',
        ruleDe:
            'Im Deutschen sind Kardinalzahlen ab „zwei“ unveränderlich; das gezählte Nomen steht im Plural.',
        syntaxTag: '٣–١٠: مُخَالَفَةٌ + جَمْعٌ مَجْرُورٌ',
        pitfallAlertAr:
            'الْخَطَأُ الشَّائِعُ: الِاعْتِمَادُ عَلَى جَمْعِ الْمَعْدُودِ لِتَحْدِيدِ التَّذْكِيرِ؛ الْعِبْرَةُ بِالْمُفْرَدِ (مَجَلَّةٌ مُؤَنَّثٌ ← ثَلَاثُ مَجَلَّاتٍ).',
      ),
      NumeralsLessonUnit(
        id: 'nm_02',
        category: NumeralCategory.compoundAndReversedTens,
        titleAr: 'بِنَاءُ الْأَعْدَادِ (١١–١٩) وَقَلْبُ الْآحَادِ قَبْلَ الْعَشَرَاتِ فِي الْأَلْمَانِيَّةِ',
        titleEn: 'Arabic Accusative Singular (11–99) vs. German Unit-Before-Ten Order',
        titleDe: 'Einer vor Zehner: einundzwanzig (21) vs. twenty-one',
        exampleAr: 'فِي الْفَصْلِ ثَلَاثَةَ عَشَرَ طَالِبًا وَإِحْدَى وَعِشْرُونَ طَالِبَةً.',
        exampleEn: 'There are thirteen male students and twenty-one female students in the class.',
        exampleDe: 'In der Klasse sind dreizehn Schüler und einundzwanzig Schülerinnen.',
        ruleAr:
            'الْأَعْدَادُ (١١–١٩) تُبْنَى عَلَى فَتْحِ الْجُزْأَيْنِ (عَدَا ١٢)، وَمَعْدُودُ (١١–٩٩) مُفْرَدٌ مَنْصُوبٌ دَائِمًا (طَالِبًا، طَالِبَةً).',
        ruleEn:
            'English places the ten before the unit with a hyphen ("twenty-one") for 21–99.',
        ruleDe:
            'Ab 21 nennt das Deutsche den Einer vor dem Zehner mit „und“: einundzwanzig (21), zweiunddreißig (32).',
        syntaxTag: 'einundzwanzig • مُفْرَدٌ مَنْصُوبٌ',
        pitfallAlertAr:
            'احْذَرْ قَلْبَ الرَّقْمِ عِنْدَ التَّرْجَمَةِ: «dreiundvierzig» تَعْنِي ٤٣ وَلَيْسَ ٣٤، وَتَذَكَّرْ أَنَّ تَمْيِيزَ (١١–٩٩) مُفْرَدٌ مَنْصُوبٌ لَا جَمْعٌ.',
      ),
      NumeralsLessonUnit(
        id: 'nm_03',
        category: NumeralCategory.hundredsThousandsEinsEin,
        titleAr: 'تَمْيِيزُ الْمِئَةِ وَالْأَلْفِ وَالْفَرْقُ بَيْنَ eins وَein',
        titleEn: 'Genitive Singular After Hundred/Thousand & German eins vs. ein',
        titleDe: '„eins“ beim Zählen/Rechnen vs. „ein/eine“ vor Nomen & Hundert',
        exampleAr: 'تَضَمَّنَ الْمَرْجِعُ مِئَةَ صَفْحَةٍ وَأَلْفَ مِثَالٍ، وَرَقْمُ الدَّرْسِ وَاحِدٌ.',
        exampleEn: 'The reference included one hundred pages and a thousand examples; the lesson number is one.',
        exampleDe: 'Das Nachschlagewerk umfasst einhundert Seiten und eintausend Beispiele; die Lektionsnummer ist eins.',
        ruleAr:
            'الْمِئَةُ وَالْأَلْفُ وَمُضَاعَفَاتُهُمَا يَأْتِي مَعْدُودُهَا مُفْرَدًا مَجْرُورًا بِالْإِضَافَةِ (مِئَةُ صَفْحَةٍ، أَلْفُ مِثَالٍ).',
        ruleEn:
            'English "hundred" and "thousand" remain singular after multipliers ("two hundred pages", not *hundreds pages).',
        ruleDe:
            'Steht die Zahl 1 allein (z. B. beim Zählen oder als Uhrzeit „ein Uhr“ vs. „es ist eins“), heißt es „eins“; vor Nomen/Hundert nutzt man „ein/eine“.',
        syntaxTag: 'مُفْرَدٌ مَجْرُورٌ • eins vs. ein',
        pitfallAlertAr:
            'لَا تَقُلْ *eins hundert أو *ein Uhr ist eins؛ الصَّوَابُ «einhundert» قَبْلَ الْمُضَاعَفِ، وَ«es ist eins» عِنْدَ الْوَقْفِ.',
      ),
      NumeralsLessonUnit(
        id: 'nm_04',
        category: NumeralCategory.ordinalsAndDates,
        titleAr: 'صِيَاغَةُ الْعَدَدِ التَّرْتِيبِيِّ وَإِعْرَابُ التَّوَارِيخِ',
        titleEn: 'Ordinal Suffixes & Case-Marked Dates Across Three Languages',
        titleDe: 'Ordinalzahlen (-te bis 19., -ste ab 20.) & Dativ-Datum („am dritten Mai“)',
        exampleAr: 'يَبْدَأُ الْمُؤْتَمَرُ فِي الْيَوْمِ الثَّالِثِ مِنْ شَهْرِ أَيَّارَ.',
        exampleEn: 'The conference begins on the third of May (May 3rd).',
        exampleDe: 'Die Konferenz beginnt am dritten Mai (3. Mai).',
        ruleAr:
            'الْعَدَدُ التَّرْتِيبِيُّ فِي الْعَرَبِيَّةِ يُصَاغُ عَلَى وَزْنِ «فَاعِلٍ» (الثَّانِي، الثَّالِثُ) وَيُطَابِقُ مَنْعُوتَهُ تَذْكِيرًا وَتَأْنِيثًا وَإِعْرَابًا.',
        ruleEn:
            'English uses "-st, -nd, -rd, -th" ("the first, second, third, fourth") without grammatical case endings.',
        ruleDe:
            'Deutsche Ordinalzahlen enden bis 19 auf „-te“ (erste, dritte, siebte) und ab 20 auf „-ste“ (zwanzigste); nach „am“ steht Dativ (-en).',
        syntaxTag: 'am + -ten (Dativ) • فَاعِلٌ',
        pitfallAlertAr:
            'انْتَبِهْ لِلشَّوَاذِّ الْأَلْمَانِيَّةِ: erste (١)، dritte (٣)، siebte (٧)، achte (٨)؛ وَفِي التَّارِيخِ بَعْدَ «am» نُضِيفُ «-n»: am dritten Mai.',
      ),
      NumeralsLessonUnit(
        id: 'nm_05',
        category: NumeralCategory.clockTimeAsymmetry,
        titleAr: 'مُفَارَقَةُ السَّاعَةِ فِي الْأَلْمَانِيَّةِ (halb drei = الثَّانِيَةُ وَالنِّصْفُ)',
        titleEn: 'Why German "halb drei" Means 2:30, Not 3:30',
        titleDe: 'Uhrzeit-Falle: „halb drei“ = 02:30 Uhr (halb zur dritten Stunde)',
        exampleAr: 'تَبْدَأُ الْمُحَاضَرَةُ السَّاعَةَ الثَّانِيَةَ وَالنِّصْفَ (٢:٣٠) وَتَنْتَهِي الثَّالِثَةَ إِلَّا رُبْعًا (٢:٤٥).',
        exampleEn: 'The lecture starts at half past two (2:30) and ends at a quarter to three (2:45).',
        exampleDe: 'Die Vorlesung beginnt um halb drei (2:30) und endet um Viertel vor drei (2:45).',
        ruleAr:
            'فِي الْعَرَبِيَّةِ يُنْسَبُ النِّصْفُ إِلَى السَّاعَةِ الْمُنْقَضِيَةِ (الثَّانِيَةُ وَالنِّصْفُ = ٢:٣٠)، وَتُسْتَعْمَلُ «إِلَّا» قَبْلَ السَّاعَةِ التَّالِيَةِ.',
        ruleEn:
            'English "half past two" looks backward to 2:00, matching Arabic «الثَّانِيَةُ وَالنِّصْفُ».',
        ruleDe:
            'Im Deutschen blickt „halb + [nächste Stunde]“ voraus auf die kommende volle Stunde: „halb drei“ = eine halbe Stunde vor drei = 2:30.',
        syntaxTag: 'halb drei = 2:30 ≠ 3:30',
        pitfallAlertAr:
            'أَشْهَرُ فَخٍّ تَرْجَمِيٍّ: تَرْجَمَةُ «halb drei» بِـ ٣:٣٠! الصَّوَابُ ٢:٣٠؛ أَمَّا ٣:٣٠ فَهِيَ «halb vier».',
      ),
      NumeralsLessonUnit(
        id: 'nm_06',
        category: NumeralCategory.measurementPartitives,
        titleAr: 'إِفْرَادُ الْمَقَادِيرِ الْمُذَكَّرَةِ وَالْمُحَايِدَةِ فِي الْأَلْمَانِيَّةِ مُقَابِلَ الْجَمْعِ',
        titleEn: 'Singular German Measurement Units vs. Plural English & Arabic Tamyiz',
        titleDe: 'Maskuline/Neutrale Maßeinheiten bleiben im Singular (drei Liter / zwei Glas)',
        exampleAr: 'اشْتَرَيْتُ ثَلَاثَةَ لِتْرَاتٍ مِنَ الْمَاءِ وَفِنْجَانَيْنِ مِنَ الْقَهْوَةِ.',
        exampleEn: 'I bought three liters of water and two cups of coffee.',
        exampleDe: 'Ich habe drei Liter Wasser und zwei Tassen Kaffee gekauft.',
        ruleAr:
            'تُعْرَبُ وَحَدَاتُ الْقِيَاسِ فِي الْعَرَبِيَّةِ حَسَبَ قَوَاعِدِ الْعَدَدِ (ثَلَاثَةُ لِتْرَاتٍ: جَمْعٌ مَجْرُورٌ)، وَيُلْحَقُ الْمَوْزُونُ بِـ «مِنْ» أَوِ الْإِضَافَةِ.',
        ruleEn:
            'English pluralizes all countable units ("three liters", "two cups") and links the substance with "of".',
        ruleDe:
            'Maskuline und neutrale Maßeinheiten (Liter, Kilo, Gramm, Stück, Glas) stehen nach Zahlen im Singular; feminine Einheiten (Tasse, Flasche) stehen im Plural.',
        syntaxTag: 'drei Liter (Sg.) • zwei Tassen (Pl.)',
        pitfallAlertAr:
            'لَا تَجْمَعْ «Liter» أَوْ «Kilo» بَعْدَ الْأَرْقَامِ فِي الْأَلْمَانِيَّةِ (*drei Liters خَطَأٌ)؛ بَيْنَمَا تَجْمَعُ الْمُؤَنَّثَ مِثْلَ «Tassen» وَ«Flaschen».',
      ),
    ];
  }

  List<NumeralsDrillItem> getDrills() {
    return const [
      NumeralsDrillItem(
        id: 'nm_d1',
        category: NumeralCategory.cardinalsPolarity,
        targetLanguage: 'AR',
        promptAr: 'اخْتَرِ التَّرْكِيبَ الصَّحِيحَ لِلْعَدَدِ (٧) مَعَ كَلِمَةِ «مَجَلَّة»:',
        promptEn: 'Choose the grammatically accurate Arabic phrase for "7 magazines":',
        promptDe: 'Wähle die korrekte arabische Zahl-Nomen-Verbindung für „7 Zeitschriften“:',
        options: [
          'سَبْعُ مَجَلَّاتٍ',
          'سَبْعَةُ مَجَلَّاتٍ',
          'سَبْعُ مَجَلَّةً',
        ],
        correctIndex: 0,
        explanationAr:
            'مُفْرَدُ «مَجَلَّاتٍ» هُوَ «مَجَلَّةٌ» (مُؤَنَّثٌ)، وَالْعَدَدُ (٧) يُخَالِفُ الْمَعْدُودَ فَيُذَكَّرُ «سَبْعُ»، وَالْمَعْدُودُ جَمْعٌ مَجْرُورٌ.',
      ),
      NumeralsDrillItem(
        id: 'nm_d2',
        category: NumeralCategory.compoundAndReversedTens,
        targetLanguage: 'DE',
        promptAr: 'كَيْفَ تَكْتُبُ الْعَدَدَ (٤٧) بِالْأَلْمَانِيَّةِ؟',
        promptEn: 'How is the number 47 written in German?',
        promptDe: 'Wie schreibt man die Zahl 47 auf Deutsch?',
        options: [
          'siebenundvierzig',
          'vierundsiebzig',
          'vierzigundsieben',
        ],
        correctIndex: 0,
        explanationAr:
            'فِي الْأَلْمَانِيَّةِ يَسْبِقُ الْآحَادُ (sieben = ٧) الْعَشَرَاتِ (vierzig = ٤٠) مَفْصُولًا بِـ «und»: siebenundvierzig.',
      ),
      NumeralsDrillItem(
        id: 'nm_d3',
        category: NumeralCategory.hundredsThousandsEinsEin,
        targetLanguage: 'AR',
        promptAr: 'اخْتَرِ الضَّبْطَ الصَّحِيحَ لِلْمَعْدُودِ بَعْدَ «أَلْف»:',
        promptEn: 'Select the correct counted noun form after "one thousand" in Arabic:',
        promptDe: 'Welche Form des gezählten Nomens folgt auf „أَلْف“ (1000)?',
        options: [
          'أَلْفُ كِتَابٍ (مُفْرَدٌ مَجْرُورٌ)',
          'أَلْفُ كُتُبٍ (جَمْعٌ مَجْرُورٌ)',
          'أَلْفُ كِتَابًا (مُفْرَدٌ مَنْصُوبٌ)',
        ],
        correctIndex: 0,
        explanationAr:
            'تَمْيِيزُ الْمِئَةِ وَالْأَلْفِ وَمُضَاعَفَاتِهِمَا يَكُونُ مُفْرَدًا مَجْرُورًا بِالْإِضَافَةِ دَائِمًا: «أَلْفُ كِتَابٍ».',
      ),
      NumeralsDrillItem(
        id: 'nm_d4',
        category: NumeralCategory.ordinalsAndDates,
        targetLanguage: 'DE',
        promptAr: 'أَكْمِلِ التَّارِيخَ الْأَلْمَانِيَّ: «Der Kurs beginnt am ___ Mai.» (٣ أيار):',
        promptEn: 'Complete the German date expression for "on the 3rd of May":',
        promptDe: 'Ergänze das Datum korrekt: „Der Kurs beginnt am ___ Mai.“ (3. Mai):',
        options: [
          'dritten',
          'dritte',
          'dreite',
        ],
        correctIndex: 0,
        explanationAr:
            'الصِّيغَةُ التَّرْتِيبِيَّةُ لِلْعَدَدِ (٣) شَاذَّةٌ (dritt-)، وَبَعْدَ حَرْفِ الْجَرِّ الْمُدْمَجِ «am» (= an dem) يَلْزَمُ حَالَةُ Dativ بِإِضَافَةِ «-en»: am dritten Mai.',
      ),
      NumeralsDrillItem(
        id: 'nm_d5',
        category: NumeralCategory.clockTimeAsymmetry,
        targetLanguage: 'DE',
        promptAr: 'مَا التَّوْقِيتُ الدَّقِيقُ الَّذِي تَدُلُّ عَلَيْهِ الْعِبَارَةُ الْأَلْمَانِيَّةُ «Es ist halb neun»؟',
        promptEn: 'What exact time does the German expression "Es ist halb neun" indicate?',
        promptDe: 'Welche Uhrzeit bedeutet „Es ist halb neun“?',
        options: [
          '08:30 (الثَّامِنَةُ وَالنِّصْفُ)',
          '09:30 (التَّاسِعَةُ وَالنِّصْفُ)',
          '08:45 (التَّاسِعَةُ إِلَّا رُبْعًا)',
        ],
        correctIndex: 0,
        explanationAr:
            '«halb neun» تَعْنِي نِصْفَ الطَّرِيقِ نَحْوَ التَّاسِعَةِ، أَيِ السَّاعَةُ الثَّامِنَةُ وَالنِّصْفُ (08:30).',
      ),
      NumeralsDrillItem(
        id: 'nm_d6',
        category: NumeralCategory.measurementPartitives,
        targetLanguage: 'DE',
        promptAr: 'اخْتَرِ الْجُمْلَةَ الْأَلْمَانِيَّةَ السَّلِيمَةَ لِـ «أَرْبَعَةُ لِتْرَاتٍ مِنَ الْحَلِيبِ وَثَلَاثُ أَكْوَابٍ مِنَ الشَّايِ»:',
        promptEn: 'Choose the correct German measurement expression:',
        promptDe: 'Wähle den grammatisch korrekten Satz mit Maßangaben:',
        options: [
          'vier Liter Milch und drei Tassen Tee',
          'vier Liters Milch und drei Tasse Tee',
          'vier Liter Milch und drei Tasse Tee',
        ],
        correctIndex: 0,
        explanationAr:
            'وَحْدَةُ «Liter» مُذَكَّرَةٌ فَتَبْقَى مُفْرَدَةً بَعْدَ الْأَرْقَامِ (vier Liter)، أَمَّا «Tasse» فَمُؤَنَّثَةٌ فَتُجْمَعُ (drei Tassen).',
      ),
    ];
  }
}
