import '../models/ellipsis_anaphora_models.dart';

class EllipsisAnaphoraRepository {
  const EllipsisAnaphoraRepository();

  List<EllipsisCaseStudy> getCaseStudies() {
    return const [
      EllipsisCaseStudy(
        id: 'ea_01',
        type: EllipsisPhenomenonType.verbalGapping,
        titleAr: 'حَذْفُ الْفِعْلِ الْمُتَكَرِّرِ فِي الْجُمْلَةِ الْمَعْطُوفَةِ',
        titleEn: 'Medial Verbal Gapping Across Coordinated Clauses',
        titleDe: 'Verb-Gapping: Weglassung des finiten Verbs im zweiten Teilsatz',
        surfaceAr: 'كَتَبَ طَارِقٌ مَقَالَةً عِلْمِيَّةً، وَأَمِينَةُ [—] بَحْثًا لُغَوِيًّا.',
        recoveredAr: 'كَتَبَ طَارِقٌ مَقَالَةً عِلْمِيَّةً، وَكَتَبَتْ أَمِينَةُ بَحْثًا لُغَوِيًّا.',
        surfaceEn: 'Tariq wrote a scientific article, and Amina [—] a linguistic paper.',
        recoveredEn: 'Tariq wrote a scientific article, and Amina wrote a linguistic paper.',
        surfaceDe: 'Tariq schrieb einen wissenschaftlichen Aufsatz und Amina [—] eine sprachliche Studie.',
        recoveredDe: 'Tariq schrieb einen wissenschaftlichen Aufsatz, und Amina schrieb eine sprachliche Studie.',
        analysisAr:
            'يُحْذَفُ الْفِعْلُ فِي الْجُمْلَةِ الثَّانِيَةِ لِدَلَالَةِ الْأَوَّلِ عَلَيْهِ، وَيَبْقَى الْمُتَعَاطِفَانِ مُتَوَازِيَيْنِ فِي الْإِعْرَابِ (فَاعِلٌ وَمَفْعُولٌ بِهِ).',
        analysisEn:
            'English Gapping deletes the identical finite verb in the second conjunct, leaving two contrasting remnants (subject + object).',
        analysisDe:
            'Im Deutschen ist Verb-Gapping nur möglich, wenn Subjekt und Objekt im zweiten Konjunkt parallel kontrastiert werden.',
        constraintWarningAr:
            'لَا يَجُوزُ الْفَصْلُ بِعَطْفٍ مَنْفِيٍّ أَوْ حَذْفُ الْفِعْلِ الْمُسَاعِدِ إِذَا اخْتَلَفَ الزَّمَنُ بَيْنَ الشَّطْرَيْنِ.',
        mappings: [
          RecoveryMapping(
            language: 'Arabic',
            elidedSurface: 'وَأَمِينَةُ [—] بَحْثًا',
            recoveredFullForm: 'وَكَتَبَتْ أَمِينَةُ بَحْثًا',
            omittedElementNote: 'حُذِفَ الْفِعْلُ «كَتَبَتْ» مَعَ مُرَاعَاةِ التَّأْنِيثِ عِنْدَ التَّقْدِيرِ.',
          ),
          RecoveryMapping(
            language: 'German',
            elidedSurface: 'und Amina [—] eine Studie',
            recoveredFullForm: 'und Amina schrieb eine Studie',
            omittedElementNote: 'Das finite Verb „schrieb“ wird aus dem ersten Satz ergänzt.',
          ),
        ],
      ),
      EllipsisCaseStudy(
        id: 'ea_02',
        type: EllipsisPhenomenonType.vpEllipsisAndObligatoryDeletion,
        titleAr: 'حَذْفُ الْخَبَرِ وُجُوبًا بَعْدَ «لَوْلَا» مُقَابِلَ حَذْفِ جُمْلَةِ الْفِعْلِ',
        titleEn: 'VP-Ellipsis with Stranded Auxiliaries vs. Arabic Obligatory Deletion',
        titleDe: 'Modalverb-Ellipse ohne Vollverb vs. Arabisches „Lawlā“',
        surfaceAr: 'لَوْلَا الْعِلْمُ [—] لَضَاعَتِ الْحَقَائِقُ؛ وَخَالِدٌ يُتْقِنُ النَّحْوَ وَسَامِي كَذَلِكَ [—].',
        recoveredAr: 'لَوْلَا الْعِلْمُ مَوْجُودٌ لَضَاعَتِ الْحَقَائِقُ؛ وَخَالِدٌ يُتْقِنُ النَّحْوَ وَسَامِي كَذَلِكَ يُتْقِنُهُ.',
        surfaceEn: 'Khalid speaks Arabic fluently, and Sami does [—] too.',
        recoveredEn: 'Khalid speaks Arabic fluently, and Sami speaks Arabic fluently too.',
        surfaceDe: 'Khalid kann fließend Arabisch sprechen, und Sami kann es auch [—].',
        recoveredDe: 'Khalid kann fließend Arabisch sprechen, und Sami kann auch fließend Arabisch sprechen.',
        analysisAr:
            'بَعْدَ «لَوْلَا» الِامْتِنَاعِيَّةِ يَجِبُ حَذْفُ الْخَبَرِ إِذَا كَانَ كَوْنًا عَامًّا (مَوْجُودٌ/حَاصِلٌ)؛ وَلَا تَسْتَعْمِلُ الْعَرَبِيَّةُ فِعْلًا مُسَاعِدًا مَعْزُولًا مِثْلَ «does» بَلْ تَسْتَعْمِلُ «كَذَلِكَ».',
        analysisEn:
            'English requires a stranded auxiliary ("does", "can", "will") to license VP-Ellipsis; bare main-verb omission is ungrammatical.',
        analysisDe:
            'Das Deutsche kennt keine „do“-Stütze; eine Prädikatsellipse gelingt meist nur nach Modalverben („kann es auch“) mit Pro-Form „es“.',
        constraintWarningAr:
            'تَجَنَّبْ تَرْجَمَةَ «and Sami does too» إِلَى «وَسَامِي يَفْعَلُ أَيْضًا»؛ فَهَذِهِ رَكَاكَةٌ تَرْجَمِيَّةٌ، وَالصَّوَابُ «وَسَامِي كَذَلِكَ».',
        mappings: [
          RecoveryMapping(
            language: 'Arabic',
            elidedSurface: 'لَوْلَا الْعِلْمُ [—]',
            recoveredFullForm: 'لَوْلَا الْعِلْمُ مَوْجُودٌ',
            omittedElementNote: 'حَذْفُ الْخَبَرِ وَاجِبٌ لِأَنَّهُ كَوْنٌ عَامٌّ.',
          ),
          RecoveryMapping(
            language: 'English',
            elidedSurface: 'and Sami does [—] too',
            recoveredFullForm: 'and Sami speaks Arabic fluently too',
            omittedElementNote: 'Dummy auxiliary "does" strands to carry tense and agreement.',
          ),
        ],
      ),
      EllipsisCaseStudy(
        id: 'ea_03',
        type: EllipsisPhenomenonType.sluicing,
        titleAr: 'الِاقْتِصَارُ عَلَى أَدَاةِ الِاسْتِفْهَامِ وَحَذْفُ بَقِيَّةِ الْجُمْلَةِ',
        titleEn: 'Sluicing: Retaining Only the Interrogative Phrase',
        titleDe: 'Sluicing: W-Wort-Rest ohne Nebensatz',
        surfaceAr: 'تَأَخَّرَ الْقِطَارُ عَنْ مَوْعِدِهِ، وَلَكِنَّنَا لَا نَعْلَمُ لِمَاذَا [—].',
        recoveredAr: 'تَأَخَّرَ الْقِطَارُ عَنْ مَوْعِدِهِ، وَلَكِنَّنَا لَا نَعْلَمُ لِمَاذَا تَأَخَّرَ الْقِطَارُ.',
        surfaceEn: 'The train was delayed, yet we do not know why [—].',
        recoveredEn: 'The train was delayed, yet we do not know why the train was delayed.',
        surfaceDe: 'Der Zug hatte Verspätung, aber wir wissen nicht, warum [—].',
        recoveredDe: 'Der Zug hatte Verspätung, aber wir wissen nicht, warum der Zug Verspätung hatte.',
        analysisAr:
            'يُحْذَفُ مُسْنَدُ جُمْلَةِ الِاسْتِفْهَامِ الْمُعَلَّقَةِ بَعْدَ الْأَدَاةِ (لِمَاذَا، مَتَى، مَنْ) إِذَا كَانَتْ مَعْلُومَةً مِنَ السِّيَاقِ السَّابِقِ.',
        analysisEn:
            'Sluicing elides the entire IP/clause following a wh-remnant under an embedding verb like "know" or "ask".',
        analysisDe:
            'Beim Sluicing bleibt nur das W-Wort („warum“, „wer“, „wohin“) nach einem Komma stehen; der Rest des Nebensatzes entfällt.',
        constraintWarningAr:
            'انْتَبِهْ إِلَى عَدَمِ تَكْرَارِ «تَأَخَّرَ» بَعْدَ «لِمَاذَا» إِلَّا لِلتَّوْكِيدِ؛ فَالْإِيجَازُ هُوَ الْأَفْصَحُ فِي اللُّغَاتِ الثَّلَاثِ.',
        mappings: [
          RecoveryMapping(
            language: 'German',
            elidedSurface: 'aber wir wissen nicht, warum [—]',
            recoveredFullForm: 'aber wir wissen nicht, warum er Verspätung hatte',
            omittedElementNote: 'Nebensatz nach „warum“ wird kontextuell erspart.',
          ),
        ],
      ),
      EllipsisCaseStudy(
        id: 'ea_04',
        type: EllipsisPhenomenonType.nominalAndMorphemeEllipsis,
        titleAr: 'حَذْفُ الْمُضَافِ فِي الْعَرَبِيَّةِ وَالِاخْتِزَالُ الصَّرْفِيُّ بِالْوُصْلَةِ فِي الْأَلْمَانِيَّةِ',
        titleEn: 'Nominal Head Deletion & German Compound Ergänzungsstrich',
        titleDe: 'Wortteil-Ellipse mit Ergänzungsstrich (Vor- und Nachmittage)',
        surfaceAr: 'تُقَدَّمُ الدُّرُوسُ فِي الصَّبَاحِ وَ[—] الْمَسَاءِ؛ وَاسْأَلِ الْقَرْيَةَ [—].',
        recoveredAr: 'تُقَدَّمُ الدُّرُوسُ فِي أَوْقَاتِ الصَّبَاحِ وَأَوْقَاتِ الْمَسَاءِ؛ وَاسْأَلْ أَهْلَ الْقَرْيَةِ.',
        surfaceEn: 'Courses run in the morning and [—] evening sessions.',
        recoveredEn: 'Courses run in the morning sessions and the evening sessions.',
        surfaceDe: 'Die Kurse finden an Vor- und Nachmittagen sowie in Sprach- und Literaturkursen statt.',
        recoveredDe: 'Die Kurse finden an Vormittagen und Nachmittagen sowie in Sprachkursen und Literaturkursen statt.',
        analysisAr:
            'فِي الْعَرَبِيَّةِ يُحْذَفُ الْمُضَافُ وَيَقُومُ الْمُضَافُ إِلَيْهِ مَقَامَهُ عِنْدَ أَمْنِ اللَّبْسِ، وَفِي الْأَلْمَانِيَّةِ يُعَوَّضُ الْجُزْءُ الْمُشْتَرَكُ مِنَ الْكَلِمَةِ الْمُرَكَّبَةِ بِشَرْطَةٍ.',
        analysisEn:
            'English deletes repeated nominal heads ("sessions") in coordinated noun phrases without needing morphological hyphens for single words.',
        analysisDe:
            'Der Ergänzungsstrich („Vor- und Nachmittage“) spart das gemeinsame Grundwort („-mittage“) oder Bestimmungswort („Sprach-“) im Kompositum ein.',
        constraintWarningAr:
            'فِي الْأَلْمَانِيَّةِ يَجِبُ وَضْعُ الشَّرْطَةِ (Ergänzungsstrich) مُلْتَصِقَةً بِالْجُزْءِ الْمَحْذُوفِ مَوْضِعَهُ، وَلَا تُحْذَفُ إِلَّا الْمَقَاطِعُ الْمُطَابِقَةُ لَفْظًا.',
        mappings: [
          RecoveryMapping(
            language: 'German',
            elidedSurface: 'Vor- und Nachmittagen',
            recoveredFullForm: 'Vormittagen und Nachmittagen',
            omittedElementNote: 'Das gemeinsame Grundwort „-mittagen“ wird im ersten Glied gespart.',
          ),
        ],
      ),
      EllipsisCaseStudy(
        id: 'ea_05',
        type: EllipsisPhenomenonType.proFormAnaphora,
        titleAr: 'ضَمَائِرُ الْإِحَالَةِ وَالرَّوَابِطُ الظَّرْفِيَّةُ (da- / do so / ذَلِكَ)',
        titleEn: 'Pro-Form Anaphora: "do so", "da(r)-" & Demonstrative Resumption',
        titleDe: 'Pronominaladverbien („darüber“, „damit“) als Satzverweise',
        surfaceAr: 'طَلَبْتُ مِنْهُ مُرَاجَعَةَ النَّصِّ، فَفَعَلَ ذَلِكَ فَوْرًا.',
        recoveredAr: 'طَلَبْتُ مِنْهُ مُرَاجَعَةَ النَّصِّ، فَرَاجَعَ النَّصَّ فَوْرًا.',
        surfaceEn: 'I asked him to revise the text, and he did so immediately.',
        recoveredEn: 'I asked him to revise the text, and he revised the text immediately.',
        surfaceDe: 'Ich bat ihn, den Text zu prüfen, und er hat es sofort getan; darüber freue ich mich.',
        recoveredDe: 'Ich bat ihn, den Text zu prüfen, und er hat den Text sofort geprüft; über seine Prüfung freue ich mich.',
        analysisAr:
            'يَنُوبُ «فَعَلَ ذَلِكَ» عَنْ مَضْمُونِ الْفِعْلِ السَّابِقِ وَمَفْعُولِهِ، كَمَا تَنُوبُ «darüber / damit» فِي الْأَلْمَانِيَّةِ عَنْ جُمْلَةٍ كَامِلَةٍ مَسْبُوقَةٍ بِحَرْفِ جَرٍّ.',
        analysisEn:
            '"did so" is an event-anaphoric pro-VP replacing active, controllable verb phrases (unlike stative verbs).',
        analysisDe:
            'Pronominaladverbien („darüber“, „dafür“) verweisen anaphorisch auf ganze Sachverhalte und ersetzen „Präposition + das“.',
        constraintWarningAr:
            'لَا تَسْتَعْمِلْ «did so» مَعَ أَفْعَالِ الْحَالَةِ السَّاكِنَةِ مِثْلَ «know» أَوْ «own» فِي الْإِنْجِلِيزِيَّةِ.',
        mappings: [
          RecoveryMapping(
            language: 'English',
            elidedSurface: 'he did so',
            recoveredFullForm: 'he revised the text',
            omittedElementNote: 'Pro-VP "do so" substitutes for an agentive verb phrase.',
          ),
        ],
      ),
      EllipsisCaseStudy(
        id: 'ea_06',
        type: EllipsisPhenomenonType.cataphoricAnticipation,
        titleAr: 'ضَمِيرُ الشَّأْنِ وَالْإِحَالَةُ الْبَعْدِيَّةُ التَّمْهِيدِيَّةُ',
        titleEn: 'Cataphoric Reference & Clause-Anticipatory Correlates',
        titleDe: 'Kataphorisches „es“ als Platzhalter für Nebensätze',
        surfaceAr: 'إِنَّهُ لَمِنَ الْمُؤَكَّدِ أَنَّ الْمُثَابَرَةَ تُثْمِرُ عِلْمًا نَافِعًا.',
        recoveredAr: 'الشَّأْنُ وَالْأَمْرُ: أَنَّ الْمُثَابَرَةَ تُثْمِرُ عِلْمًا نَافِعًا أَمْرٌ مُؤَكَّدٌ.',
        surfaceEn: 'It is certain that perseverance yields beneficial knowledge.',
        recoveredEn: 'That perseverance yields beneficial knowledge is certain.',
        surfaceDe: 'Es steht fest, dass Beharrlichkeit nützliches Wissen hervorbringt.',
        recoveredDe: 'Dass Beharrlichkeit nützliches Wissen hervorbringt, steht fest.',
        analysisAr:
            'ضَمِيرُ الشَّأْنِ «هُـ» فِي «إِنَّهُ» يُحِيلُ إِلَى الْجُمْلَةِ الَّتِي تَلِيهِ تَفْخِيمًا لِلْخَبَرِ، وَيُقَابِلُهُ «It / Es» التَّمْهِيدِيُّ.',
        analysisEn:
            'Extraposition moves heavy subject clauses to the end, leaving anticipatory "It" in subject position.',
        analysisDe:
            'Das Korrelat-„es“ im Vorfeld kündigt den nachfolgenden dass-Satz kataphorisch an und verschwindet, wenn der dass-Satz ins Vorfeld rückt.',
        constraintWarningAr:
            'فِي الْأَلْمَانِيَّةِ يُحْذَفُ «es» وُجُوبًا إِذَا تَقَدَّمَتِ الْجُمْلَةُ التَّابِعَةُ: «Dass Beharrlichkeit... steht fest» (بِدُونِ es).',
        mappings: [
          RecoveryMapping(
            language: 'German',
            elidedSurface: 'Es steht fest, dass...',
            recoveredFullForm: 'Dass..., steht fest (ohne „es“)',
            omittedElementNote: 'Vorfeld-Platzhalter „es“ entfällt bei Voranstellung des Nebensatzes.',
          ),
        ],
      ),
    ];
  }

  List<EllipsisDrillQuestion> getDrills() {
    return const [
      EllipsisDrillQuestion(
        id: 'ead_01',
        type: EllipsisPhenomenonType.verbalGapping,
        targetLanguage: 'German',
        promptAr: 'أَيُّ صِيغَةٍ أَلْمَانِيَّةٍ تُمَثِّلُ حَذْفَ الْفِعْلِ (Verb-Gapping) بِشَكْلٍ صَحِيحٍ؟',
        promptEn: 'Which German sentence uses grammatical verbal gapping?',
        promptDe: 'Welcher Satz zeigt korrektes Verb-Gapping?',
        options: [
          'Amir liest ein Buch und Layla eine Zeitschrift.',
          'Amir liest ein Buch und Layla liest.',
          'Amir liest ein Buch, weil Layla eine Zeitschrift.',
        ],
        correctIndex: 0,
        explanationAr: 'يَصِحُّ حَذْفُ الْفِعْلِ فِي الْعَطْفِ بِـ «und» عِنْدَ تَوَازِي الْفَاعِلِ وَالْمَفْعُولِ بِهِ.',
      ),
      EllipsisDrillQuestion(
        id: 'ead_02',
        type: EllipsisPhenomenonType.vpEllipsisAndObligatoryDeletion,
        targetLanguage: 'Arabic',
        promptAr: 'مَا التَّقْدِيرُ النَّحْوِيُّ الصَّحِيحُ لِلْخَبَرِ الْمَحْذُوفِ وُجُوبًا فِي: «لَوْلَا الصَّبْرُ لَفَشِلَ الْمُتَعَلِّمُ»؟',
        promptEn: 'What is the obligatorily elided predicate after "Lawlā" in Arabic?',
        promptDe: 'Welches Prädikat wird nach „Lawlā“ obligatorisch getilgt?',
        options: [
          'مَوْجُودٌ (كَوْنٌ عَامٌّ)',
          'صَعْبٌ (كَوْنٌ خَاصٌّ)',
          'مُتَأَخِّرٌ',
        ],
        correctIndex: 0,
        explanationAr: 'يُحْذَفُ الْخَبَرُ بَعْدَ «لَوْلَا» وُجُوبًا إِذَا كَانَ كَوْنًا عَامًّا تَقْدِيرُهُ «مَوْجُودٌ».',
      ),
      EllipsisDrillQuestion(
        id: 'ead_03',
        type: EllipsisPhenomenonType.sluicing,
        targetLanguage: 'English',
        promptAr: 'أَيُّ جُمْلَةٍ تُطَبِّقُ قَاعِدَةَ Sluicing بِأَسْلَمِ صُورَةٍ إِنْجِلِيزِيَّةٍ؟',
        promptEn: 'Choose the cleanest English sluicing construction:',
        promptDe: 'Wählen Sie die korrekte englische Sluicing-Konstruktion:',
        options: [
          'Someone left a notebook on the desk, but I do not know who.',
          'Someone left a notebook on the desk, but I do not know did who.',
          'Someone left a notebook on the desk, but I do not know that who.',
        ],
        correctIndex: 0,
        explanationAr: 'فِي Sluicing نَبْقِي أَدَاةَ الِاسْتِفْهَامِ (who) وَحْدَهَا بَعْدَ فِعْلِ الْعِلْمِ دُونَ إِقْحَامِ «that» أَوْ «did».',
      ),
      EllipsisDrillQuestion(
        id: 'ead_04',
        type: EllipsisPhenomenonType.nominalAndMorphemeEllipsis,
        targetLanguage: 'German',
        promptAr: 'كَيْفَ نَخْتَزِلُ «Sprachkurse und Literaturkurse» بِطَرِيقَةٍ إِمْلَائِيَّةٍ صَحِيحَةٍ فِي الْأَلْمَانِيَّةِ؟',
        promptEn: 'How do you correctly apply the German Ergänzungsstrich?',
        promptDe: 'Wie wendet man den Ergänzungsstrich korrekt an?',
        options: [
          'Sprach und Literaturkurse',
          'Sprach- und Literaturkurse',
          'Sprach-und-Literaturkurse',
        ],
        correctIndex: 1,
        explanationAr: 'تُلْصَقُ الشَّرْطَةُ بِالْجُزْءِ الْأَوَّلِ مُبَاشَرَةً ثُمَّ مَسَافَةٌ قَبْلَ «und».',
      ),
      EllipsisDrillQuestion(
        id: 'ead_05',
        type: EllipsisPhenomenonType.proFormAnaphora,
        targetLanguage: 'German',
        promptAr: 'أَيُّ أَدَاةِ إِحَالَةٍ تَنُوبُ عَنِ الْجُمْلَةِ السَّابِقَةِ مَعَ الْفِعْلِ «sich freuen über»؟',
        promptEn: 'Which German pronominal adverb refers back to a clause with "sich freuen über"?',
        promptDe: 'Welches Pronominaladverb verweist auf einen Sachverhalt nach „sich freuen über“?',
        options: [
          'darüber',
          'damit',
          'davor',
        ],
        correctIndex: 0,
        explanationAr: 'تَتَّحِدُ «da(r)-» مَعَ حَرْفِ الْجَرِّ الْمُلَازِمِ لِلْفِعْلِ (über) لِتُكَوِّنَ «darüber».',
      ),
      EllipsisDrillQuestion(
        id: 'ead_06',
        type: EllipsisPhenomenonType.cataphoricAnticipation,
        targetLanguage: 'German',
        promptAr: 'مَا الصِّيغَةُ الصَّحِيحَةُ عِنْدَ تَقْدِيمِ جُمْلَةِ «dass» إِلَى صَدْرِ الْجُمْلَةِ فِي الْأَلْمَانِيَّةِ؟',
        promptEn: 'What happens to anticipatory "es" when the dass-clause moves to first position?',
        promptDe: 'Was passiert mit dem Platzhalter-„es“, wenn der dass-Satz im Vorfeld steht?',
        options: [
          'Dass du pünktlich kommst, es freut mich.',
          'Dass du pünktlich kommst, freut mich.',
          'Es dass du pünktlich kommst, freut mich.',
        ],
        correctIndex: 1,
        explanationAr: 'يَسْقُطُ «es» التَّمْهِيدِيُّ وُجُوبًا عِنْدَ تَقْدِيمِ الْجُمْلَةِ التَّابِعَةِ إِلَى الْمَوْقِعِ الْأَوَّلِ.',
      ),
    ];
  }
}
