import '../models/verb_paradigm_models.dart';

class VerbParadigmRepository {
  const VerbParadigmRepository();

  List<VerbParadigmEntry> getEntries() {
    return const [
      VerbParadigmEntry(
        id: 'vp_01',
        axis: VerbMorphologyAxis.triliteralMeasureShift,
        titleAr: 'التَّحَوُّلُ الصَّرْفِيُّ: عَلِمَ ← عَلَّمَ ← تَعَلَّمَ ← اسْتَعْلَمَ',
        titleEn: 'Root-Pattern Derivation vs. Lexical Causative Verbs',
        titleDe: 'Wortfamilien: wissen / lehren / lernen / sich erkundigen',
        arabicRootAndMeasure: 'الْجَذْرُ: (ع ل م) | فَعِلَ / فَعَّلَ / تَفَعَّلَ / اسْتَفْعَلَ',
        arabicForms: 'عَلِمَ (أَدْرَكَ) • عَلَّمَ (غَيْرَهُ) • تَعَلَّمَ (ذَاتُهُ) • اسْتَعْلَمَ (طَلَبَ الْعِلْمَ)',
        englishForms: 'know (knew / known) • teach (taught / taught) • learn (learned) • inquire',
        germanForms: 'wissen (weiß, wusste, gewusst) • lehren (lehrte) • lernen (lernte) • sich erkundigen',
        morphologyRuleAr:
            'التَّضْعِيفُ فِي «عَلَّمَ» يَنْقُلُ الْفِعْلَ إِلَى التَّعْدِيَةِ، وَالتَّاءُ فِي «تَعَلَّمَ» تُفِيدُ الْمُطَاوَعَةَ، وَالسِّينُ وَالتَّاءُ فِي «اسْتَعْلَمَ» تُفِيدَانِ الطَّلَبَ.',
        morphologyRuleEn:
            'English often uses completely distinct lexical roots ("teach" vs. "learn") where Arabic derives systematically from one consonantal root.',
        morphologyRuleDe:
            'Im Deutschen ist „lehren“ (unterrichten) strikt von „lernen“ (sich aneignen) zu trennen; „wissen“ zeigt Vokalwechsel im Präsens Singular.',
        pitfallAlertAr:
            'لَا تَخْلِطْ بَيْنَ «lehren» (يُعَلِّمُ) وَ«lernen» (يَتَعَلَّمُ)، وَلَا تَسْتَعْمِلْ «lernen» بِمَعْنَى يُدَرِّسُ.',
        paradigmTag: 'ع ل م • Awzan',
      ),
      VerbParadigmEntry(
        id: 'vp_02',
        axis: VerbMorphologyAxis.strongAblautSeries,
        titleAr: 'سَلَاسِلُ التَّبَدُّلِ الصَّائِتِيِّ (Ablaut): كَتَبَ / تَكَلَّمَ / قَرَأَ',
        titleEn: 'Strong Verb Vowel Gradation Across Tenses',
        titleDe: 'Starke Verben: e-a-o / ei-ie-ie / e-a-e Ablautreihen',
        arabicRootAndMeasure: 'كَتَبَ يَكْتُبُ (فَعَلَ يَفْعُلُ) • قَرَأَ يَقْرَأُ (فَعَلَ يَفْعَلُ)',
        arabicForms: 'كَتَبَ / يَكْتُبُ / اكْتُبْ • نَطَقَ / يَنْطِقُ / انْطِقْ',
        englishForms: 'write / wrote / written • speak / spoke / spoken • read / read / read',
        germanForms: 'schreiben / schrieb / geschrieben • sprechen (spricht) / sprach / gesprochen',
        morphologyRuleAr:
            'تَتَغَيَّرُ حَرَكَةُ عَيْنِ الْفِعْلِ الثُّلَاثِيِّ بَيْنَ الْمَاضِي وَالْمُضَارِعِ (كَتَبَ ← يَكْتُبُ)، وَفِي الْأَلْمَانِيَّةِ يَتَبَدَّلُ الصَّائِتُ الجَذْرِيُّ عَبْرَ الصِّيَغِ الثَّلَاثِ.',
        morphologyRuleEn:
            'English strong verbs preserve Germanic ablaut ("write/wrote/written"), ending the participle in "-en".',
        morphologyRuleDe:
            'Starke Verben mit Stammvokal e (sprechen, helfen, lesen) wechseln in der 2./3. Pers. Sg. Präsens zu i/ie („er spricht“, „er liest“) und bilden Partizip II auf -en.',
        pitfallAlertAr:
            'انْتَبِهْ لِأَنَّ الْأَلْمَانِيَّةَ تَقُولُ «er spricht» وَلَيْسَ *er sprecht، وَفِي الْمَاضِي «er sprach» لَا *sprechte.',
        paradigmTag: 'Ablaut (e-i-a-o)',
      ),
      VerbParadigmEntry(
        id: 'vp_03',
        axis: VerbMorphologyAxis.habenVsSeinPerfekt,
        titleAr: 'اخْتِيَارُ الْفِعْلِ الْمُسَاعِدِ فِي الْمَاضِي: haben مُقَابِلَ sein',
        titleEn: 'German Perfekt Auxiliary: Motion/State Change (sein) vs. Default (haben)',
        titleDe: 'Perfekt: „ist gefahren / ist eingeschlafen“ vs. „hat geschrieben“',
        arabicRootAndMeasure: 'سَافَرَ / ذَهَبَ / نَامَ (أَفْعَالُ حَرَكَةٍ وَتَحَوُّلِ حَالٍ)',
        arabicForms: 'سَافَرَ إِلَى الْمَدِينَةِ • اسْتَيْقَظَ مُبَكِّرًا • بَقِيَ فِي الْمَكْتَبَةِ',
        englishForms: 'He has traveled • He has woken up • He has stayed (always "have")',
        germanForms: 'Er ist gereist • Er ist aufgewacht • Er ist geblieben • (aber: Er hat gelesen)',
        morphologyRuleAr:
            'يَكْتَفِي الْعَرَبِيُّ وَالْإِنْجِلِيزِيُّ بِصِيغَةٍ وَاحِدَةٍ لِلْمَاضِي، أَمَّا الْأَلْمَانِيَّةُ فَتُلْزِمُ اسْتِعْمَالَ «sein» مَعَ أَفْعَالِ الِانْتِقَالِ وَتَحَوُّلِ الْحَالَةِ وَفِعْلَيِ «sein / bleiben».',
        morphologyRuleEn:
            'Modern English uses "have" exclusively as the perfect auxiliary (unlike German "sein").',
        morphologyRuleDe:
            'Das Hilfsverb „sein“ steht bei intransitiven Verben der Ortsveränderung (gehen, fahren, reisen), Zustandsveränderung (einschlafen, aufwachen) sowie bei sein, werden, bleiben.',
        pitfallAlertAr:
            'فِعْلُ «bleiben» (بَقِيَ) يَأْخُذُ «sein» رَغْمَ عَدَمِ وُجُودِ حَرَكَةٍ: «Er ist zu Hause geblieben» (وَلَيْسَ *hat geblieben).',
        paradigmTag: 'sein vs. haben',
      ),
      VerbParadigmEntry(
        id: 'vp_04',
        axis: VerbMorphologyAxis.hollowAndDefectiveArabic,
        titleAr: 'تَصْرِيفُ الْأَجْوَفِ وَالنَّاقِصِ فِي الْجَزْمِ وَالْأَمْرِ',
        titleEn: 'Weak-Root Vowel Reduction in Arabic Jussive & Imperative',
        titleDe: 'Vokalverkürzung & Stammveränderung in schwachen Kontexten',
        arabicRootAndMeasure: 'الْأَجْوَفُ: قَالَ (ق و ل) | النَّاقِصُ: دَعَا (د ع و) / سَعَى (س ع ي)',
        arabicForms: 'قَالَ / يَقُولُ / لَمْ يَقُلْ / قُلْ • سَعَى / يَسْعَى / لَمْ يَسْعَ / اسْعَ',
        englishForms: 'say / said / said • strive / strove / striven',
        germanForms: 'sagen / sagte / gesagt • streben / strebte / gestrebt',
        morphologyRuleAr:
            'فِي الْأَجْوَفِ يَسْقُطُ حَرْفُ الْعِلَّةِ عِنْدَ سُكُونِ الْآخِرِ مَنْعًا لِالْتِقَاءِ السَّاكِنَيْنِ (لَمْ يَقُلْ، قُلْ)؛ وَفِي النَّاقِصِ يُجْزَمُ بِحَذْفِ حَرْفِ الْعِلَّةِ (لَمْ يَسْعَ).',
        morphologyRuleEn:
            'English irregular "say" shortens the vowel in "says" (/sez/) and "said" (/sed/) despite spelling.',
        morphologyRuleDe:
            'Regelmäßige schwache Verben im Deutschen behalten ihren Stammvokal unverändert (sagen – sagte – gesagt).',
        pitfallAlertAr:
            'الْخَطَأُ الشَّائِعُ فِي الْعَرَبِيَّةِ: إِثْبَاتُ الْيَاءِ أَوِ الْأَلِفِ فِي الْمَجْزُومِ النَّاقِصِ مِثْلَ *لَمْ يَسْعَى؛ وَالصَّوَابُ «لَمْ يَسْعَ».',
        paradigmTag: 'جَزْمُ الْمُعْتَلِّ',
      ),
      VerbParadigmEntry(
        id: 'vp_05',
        axis: VerbMorphologyAxis.separablePrefixInflection,
        titleAr: 'الْأَفْعَالُ الْمُنْفَصِلَةُ الْأَلْمَانِيَّةُ: الْمَوْضِعُ وَ«ge-» وَ«zu»',
        titleEn: 'Separable Verb Framing vs. Arabic & English Phrasal Particles',
        titleDe: 'Trennbare Verben: anrufen → ruft ... an / angerufen / anzurufen',
        arabicRootAndMeasure: 'نَظَّمَ / بَدَأَ / أَعَدَّ / تَوَاصَلَ',
        arabicForms: 'يَبْدَأُ الدَّرْسُ السَّاعَةَ الثَّامِنَةَ • أَعَدَّ الْخُطَّةَ • يُرِيدُ أَنْ يُعِدَّ',
        englishForms: 'begin (began / begun) • prepare • look up (looked ... up)',
        germanForms: 'anfangen: fängt ... an / fing ... an / hat angefangen / anzufangen',
        morphologyRuleAr:
            'فِي الْإِنْجِلِيزِيَّةِ يَنفَصِلُ الظَّرْفُ بَعْدَ الْمَفْعُولِ الضَّمِيرِيِّ (look it up)، أَمَّا فِي الْأَلْمَانِيَّةِ فَتَذْهَبُ السَّابِقَةُ الْمُنْفَصِلَةُ إِلَى نِهَايَةِ الْجُمْلَةِ الرَّئِيسِيَّةِ.',
        morphologyRuleEn:
            'English phrasal verbs ("look up", "pick up") require pronoun objects between verb and particle ("look it up").',
        morphologyRuleDe:
            'Bei trennbaren Verben wandert das Präfix im Hauptsatz ans Satzende („fängt um 8 Uhr an“); im Partizip II tritt „-ge-“ dazwischen („angefangen“), im Infinitiv „-zu-“ („anzufangen“).',
        pitfallAlertAr:
            'فِي الْجُمْلَةِ التَّابِعَةِ مَعَ «weil / dass» تَعُودُ السَّابِقَةُ وَتَتَّصِلُ بِالْفِعْلِ فِي النِّهَايَةِ: «weil der Kurs um 8 Uhr anfängt».',
        paradigmTag: 'an-ge-fangen / an-zu-fangen',
      ),
      VerbParadigmEntry(
        id: 'vp_06',
        axis: VerbMorphologyAxis.mixedAndIrregularVerbs,
        titleAr: 'الْأَفْعَالُ الْمُخْتَلَطَةُ (Mixed Verbs): تَغَيُّرُ الصَّائِتِ مَعَ لَاحِقَةِ الضَّعِيفِ',
        titleEn: 'German Mixed Verbs (denken, bringen, kennen, wissen)',
        titleDe: 'Gemischte Verben: Stammvokalwechsel + schwache Endung (-te / ge-...-t)',
        arabicRootAndMeasure: 'فَكَّرَ / أَحْضَرَ / عَرَفَ / سَمَّى',
        arabicForms: 'فَكَّرَ فِي الْأَمْرِ • أَحْضَرَ الْكِتَابَ • عَرَفَ الْحَقِيقَةَ',
        englishForms: 'think / thought / thought • bring / brought / brought • know / knew / known',
        germanForms: 'denken (dachte, gedacht) • bringen (brachte, gebracht) • kennen (kannte, gekannt)',
        morphologyRuleAr:
            'تَجْمَعُ الْأَفْعَالُ الْمُخْتَلَطَةُ فِي الْأَلْمَانِيَّةِ بَيْنَ تَبَدُّلِ الصَّائِتِ (كَالْأَفْعَالِ الْقَوِيَّةِ) وَنِهَايَاتِ «-te / -t» (كَالْأَفْعَالِ الضَّعِيفَةِ).',
        morphologyRuleEn:
            'English mirrors this exact Germanic class in "think/thought" and "bring/brought" (vowel/consonant shift + dental suffix -t).',
        morphologyRuleDe:
            'Die kleine Gruppe der gemischten Verben (brennen, kennen, nennen, rennen, senden, wenden, denken, bringen, wissen) kombiniert Vokalwechsel mit schwachen Endungen (-te, -t).',
        pitfallAlertAr:
            'لَا تَقُلْ *gedenkt أَوْ *gebringt؛ الصَّوَابُ هُوَ «gedacht» وَ«gebracht».',
        paradigmTag: 'dachte / gedacht',
      ),
    ];
  }

  List<VerbParadigmDrill> getDrills() {
    return const [
      VerbParadigmDrill(
        id: 'vpd_01',
        axis: VerbMorphologyAxis.triliteralMeasureShift,
        targetLanguage: 'German',
        promptAr: 'أَيُّ فِعْلٍ أَلْمَانِيٍّ يَعْنِي «يُعَلِّمُ / يُدَرِّسُ» (بِمَعْنَى التَّعْدِيَةِ لِلْغَيْرِ، مِثْلَ عَلَّمَ)؟',
        promptEn: 'Which German verb means "to teach" (transitive causative)?',
        promptDe: 'Welches Verb bedeutet „jemandem Wissen vermitteln / unterrichten“?',
        options: [
          'lernen',
          'lehren',
          'sich erkundigen',
        ],
        correctIndex: 1,
        explanationAr: '«lehren» تَعْنِي يُعَلِّمُ غَيْرَهُ (عَلَّمَ)، أَمَّا «lernen» فَتَعْنِي يَتَعَلَّمُ.',
      ),
      VerbParadigmDrill(
        id: 'vpd_02',
        axis: VerbMorphologyAxis.strongAblautSeries,
        targetLanguage: 'German',
        promptAr: 'مَا التَّصْرِيفُ الصَّحِيحُ لِلْفِعْلِ «sprechen» مَعَ الضَّمِيرِ «er» فِي الْمُضَارِعِ وَالْمَاضِي التَّامِّ؟',
        promptEn: 'Choose the accurate 3rd-person singular Präsens and Perfekt of "sprechen":',
        promptDe: 'Wählen Sie die korrekten Formen von „sprechen“ (3. Pers. Sg.):',
        options: [
          'er sprecht / er hat gesprecht',
          'er spricht / er hat gesprochen',
          'er spracht / er ist gesprochen',
        ],
        correctIndex: 1,
        explanationAr: '«sprechen» فِعْلٌ قَوِيٌّ يَتَحَوَّلُ فِيهِ e إِلَى i فِي الْمُفْرَدِ (spricht) وَاسْمُ الْمَفْعُولِ «gesprochen».',
      ),
      VerbParadigmDrill(
        id: 'vpd_03',
        axis: VerbMorphologyAxis.habenVsSeinPerfekt,
        targetLanguage: 'German',
        promptAr: 'اخْتَرِ الْفِعْلَ الْمُسَاعِدَ الصَّحِيحَ لِلْفِعْلِ «bleiben» (بَقِيَ) فِي صِيغَةِ Perfekt:',
        promptEn: 'Select the correct Perfekt auxiliary for "bleiben" (to stay):',
        promptDe: 'Welches Hilfsverb verlangt „bleiben“ im Perfekt?',
        options: [
          'Er hat zu Hause geblieben.',
          'Er ist zu Hause geblieben.',
          'Er wird zu Hause geblieben.',
        ],
        correctIndex: 1,
        explanationAr: 'الْفِعْلَانِ «sein» وَ«bleiben» يَأْخُذَانِ دَائِمًا الْفِعْلَ الْمُسَاعِدَ «sein» فِي الْمَاضِي الْمُرَكَّبِ.',
      ),
      VerbParadigmDrill(
        id: 'vpd_04',
        axis: VerbMorphologyAxis.hollowAndDefectiveArabic,
        targetLanguage: 'Arabic',
        promptAr: 'مَا الصِّيغَةُ الصَّحِيحَةُ لِلْفِعْلِ النَّاقِصِ «يَسْعَى» بَعْدَ أَدَاةِ الْجَزْمِ «لَمْ»؟',
        promptEn: 'Choose the correct Arabic jussive form of "yasʿā" after "lam":',
        promptDe: 'Wählen Sie den korrekten arabischen Jussiv (Madschzūm) von „yasʿā“:',
        options: [
          'لَمْ يَسْعَى',
          'لَمْ يَسْعَ',
          'لَمْ يَسْعِي',
        ],
        correctIndex: 1,
        explanationAr: 'يُجْزَمُ الْفِعْلُ الْمُضَارِعُ الْمُعْتَلُّ الْآخِرِ بِحَذْفِ حَرْفِ الْعِلَّةِ: «لَمْ يَسْعَ».',
      ),
      VerbParadigmDrill(
        id: 'vpd_05',
        axis: VerbMorphologyAxis.separablePrefixInflection,
        targetLanguage: 'German',
        promptAr: 'كَيْفَ نَصُوغُ الْمَصْدَرَ مَعَ «zu» لِلْفِعْلِ الْمُنْفَصِلِ «vorbereiten» (يُعِدُّ / يُحَضِّرُ)؟',
        promptEn: 'How do you form the "zu-infinitive" of the separable verb "vorbereiten"?',
        promptDe: 'Wie lautet der zu-Infinitiv des trennbaren Verbs „vorbereiten“?',
        options: [
          'zu vorbereiten',
          'vorzubereiten',
          'vorbereitzuen',
        ],
        correctIndex: 1,
        explanationAr: 'تَدْخُلُ «zu» بَيْنَ السَّابِقَةِ الْمُنْفَصِلَةِ وَجَذْرِ الْفِعْلِ: «vorzubereiten».',
      ),
      VerbParadigmDrill(
        id: 'vpd_06',
        axis: VerbMorphologyAxis.mixedAndIrregularVerbs,
        targetLanguage: 'German',
        promptAr: 'مَا اسْمُ الْمَفْعُولِ (Partizip II) الصَّحِيحُ لِلْفِعْلِ «bringen»؟',
        promptEn: 'What is the correct Partizip II of the German mixed verb "bringen"?',
        promptDe: 'Wie lautet das Partizip II von „bringen“?',
        options: [
          'gebringt',
          'gebracht',
          'gebrungen',
        ],
        correctIndex: 1,
        explanationAr: '«bringen» مِنَ الْأَفْعَالِ الْمُخْتَلَطَةِ: «bringen – brachte – hat gebracht».',
      ),
    ];
  }
}
