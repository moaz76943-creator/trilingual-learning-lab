import '../models/phonotactics_prosody_models.dart';

class PhonotacticsProsodyRepository {
  const PhonotacticsProsodyRepository();

  List<PhonotacticsLesson> getLessons() {
    return const [
      PhonotacticsLesson(
        id: 'pp_01',
        category: PhonotacticsCategory.consonantAssimilation,
        titleAr: 'الْإِبْدَالُ فِي «افْتَعَلَ» وَتَقْسِيَةُ الْأَوَاخِرِ فِي الْأَلْمَانِيَّةِ',
        titleEn: 'Consonant Assimilation & German Final Obstruent Devoicing',
        titleDe: 'Auslautverhärtung (b/d/g → [p/t/k]) & arabische Assimilation',
        arabicExamples: [
          PhoneticPairExample(
            orthography: 'اصْطَبَرَ (أَصْلُهَا: اصْتَبَرَ)',
            ipaTranscription: '/ʔisˤ.tˤa.ba.ra/',
            glossAr: 'أُبْدِلَتْ تَاءُ الِافْتِعَالِ طَاءً بَعْدَ الصَّادِ',
          ),
          PhoneticPairExample(
            orthography: 'ازْدَهَرَ (أَصْلُهَا: ازْتَهَرَ)',
            ipaTranscription: '/ʔiz.da.ha.ra/',
            glossAr: 'أُبْدِلَتِ التَّاءُ دَالًا بَعْدَ الزَّايِ',
          ),
        ],
        englishExamples: [
          PhoneticPairExample(
            orthography: 'impossible (in + possible)',
            ipaTranscription: '/ɪmˈpɒs.ə.bəl/',
            glossAr: 'تَحَوُّلُ النُّونِ إِلَى مِيمٍ قَبْلَ الْبَاءِ وَالْبَاءِ الْمَهْمُوسَةِ',
          ),
        ],
        germanExamples: [
          PhoneticPairExample(
            orthography: 'Tag / Tage',
            ipaTranscription: '[taːk] / [ˈtaː.ɡə]',
            glossAr: 'يُنْطَقُ حَرْفُ g كَافًا مَهْمُوسَةً فِي نِهَايَةِ الْكَلِمَةِ وَيَعُودُ جِيمًا مَجْهُورَةً عِنْدَ الْجَمْعِ',
          ),
          PhoneticPairExample(
            orthography: 'Hand / Hände',
            ipaTranscription: '[hant] / [ˈhɛn.də]',
            glossAr: 'يُنْطَقُ حَرْفُ d تَاءً فِي نِهَايَةِ الْمَقْطَعِ',
          ),
        ],
        ruleAr:
            'فِي الْعَرَبِيَّةِ تَتَأَثَّرُ تَاءُ «افْتَعَلَ» بِمَا قَبْلَهَا إِطْبَاقًا وَجَهْرًا فَتُقْلَبُ طَاءً أَوْ دَالًا، وَفِي الْأَلْمَانِيَّةِ تَفْقِدُ الصَّوَامِتُ الْمَجْهُورَةُ (b, d, g) جَهْرَهَا فِي نِهَايَةِ الْمَقْطَعِ.',
        ruleEn:
            'English nasal prefixes ("in-") assimilate in place of articulation ("im-possible", "il-legal"), while final stops remain voiced ("bag" /bæɡ/).',
        ruleDe:
            'Im Deutschen werden b, d, g, v, s am Silbenende stimmlos ausgesprochen ([p, t, k, f, s]), obwohl die Schreibung erhalten bleibt.',
        articulationTipAr:
            'لَا تَنْطِقْ «Tag» بِصَوْتٍ مَجْهُورٍ فِي آخِرِهِ بِالْأَلْمَانِيَّةِ، بَلْ أَنْهِهِ بِصَوْتِ [k] خَفِيفٍ.',
      ),
      PhonotacticsLesson(
        id: 'pp_02',
        category: PhonotacticsCategory.allophonicDistribution,
        titleAr: 'تَوْزِيعُ صَوْتَيِ «ch» فِي الْأَلْمَانِيَّةِ: الشِّينُ الرَّقِيقَةُ [ç] وَالْخَاءُ [x]',
        titleEn: 'German "ch" Allophony: Palatal [ç] vs. Velar/Uvular [x]',
        titleDe: 'Komplementäre Verteilung von Ich-Laut [ç] und Ach-Laut [x]',
        arabicExamples: [
          PhoneticPairExample(
            orthography: 'خَالِدٌ / يَخْرُجُ',
            ipaTranscription: '/xaː.lid/ /jax.ru.dʒu/',
            glossAr: 'الْخَاءُ الْعَرَبِيَّةُ فُونِيمٌ مُسْتَقِلٌّ يُمَيِّزُ الْمَعَانِيَ',
          ),
        ],
        englishExamples: [
          PhoneticPairExample(
            orthography: 'huge (palatal fricative onset)',
            ipaTranscription: '/çuːdʒ/ ~ /hjuːdʒ/',
            glossAr: 'يُقَارِبُ صَوْتَ Ich-Laut فِي بِدَايَةِ «huge»',
          ),
        ],
        germanExamples: [
          PhoneticPairExample(
            orthography: 'Buch / Nacht / auch',
            ipaTranscription: '[buːx] / [naxt] / [aʊ̯x]',
            glossAr: 'صَوْتُ [x] (يُقَارِبُ الْخَاءَ) بَعْدَ الصَّوَائِتِ الْخَلْفِيَّةِ a, o, u, au',
          ),
          PhoneticPairExample(
            orthography: 'ich / Bücher / Mädchen',
            ipaTranscription: '[ɪç] / [ˈbyː.çɐ] / [ˈmɛːt.çən]',
            glossAr: 'صَوْتُ [ç] بَعْدَ الصَّوَائِتِ الْأَمَامِيَّةِ وَالْمُمَالَةِ وَالصَّوَامِتِ',
          ),
        ],
        ruleAr:
            'الْخَاءُ فِي الْعَرَبِيَّةِ حَرْفٌ أَصِيلٌ مُسْتَقِلٌّ، أَمَّا فِي الْأَلْمَانِيَّةِ فَيَتَحَدَّدُ نُطْقُ «ch» بِحَسَبِ الصَّائِتِ السَّابِقِ لَهُ تَمَامًا.',
        ruleEn:
            'English lacks the velar fricative /x/ in standard vocabulary, rendering German "ch" a key articulatory milestone.',
        ruleDe:
            'Nach hinteren Vokalen (a, o, u, au) steht [x]; nach vorderen Vokalen (i, e, ä, ö, ü, ei, eu) sowie nach Konsonanten (l, n, r) steht [ç].',
        articulationTipAr:
            'عِنْدَ جَمْعِ «Buch» [buːx] إِلَى «Bücher» [ˈbyːçɐ]، يَتَحَوَّلُ الصَّوْتُ تِلْقَائِيًّا مِنَ الْخَلْفِ إِلَى الْأَمَامِ بِسَبَبِ الْإِمَالَةِ (ü).',
      ),
      PhonotacticsLesson(
        id: 'pp_03',
        category: PhonotacticsCategory.vowelLengthAndOrthography,
        titleAr: 'قِيَاسُ طُولِ الْحَرَكَاتِ: الْمَدُّ الْعَرَبِيُّ وَالتَّضْعِيفُ الْأَلْمَانِيُّ',
        titleEn: 'Vowel Length Signaling: Arabic Madd vs. German Spelling Cues',
        titleDe: 'Vokalquantität: Dehnung (ah, ie, aa) vs. Schärfung (mm, ck, tz)',
        arabicExamples: [
          PhoneticPairExample(
            orthography: 'كَتَبَ / كَاتَبَ',
            ipaTranscription: '/ka.ta.ba/ vs. /kaː.ta.ba/',
            glossAr: 'الْحَرَكَةُ الطَّوِيلَةُ تُغَيِّرُ الْوَزْنَ الصَّرْفِيَّ وَالْمَعْنَى',
          ),
        ],
        englishExamples: [
          PhoneticPairExample(
            orthography: 'ship / sheep',
            ipaTranscription: '/ʃɪp/ vs. /ʃiːp/',
            glossAr: 'الْفَرْقُ بَيْنَ الصَّائِتِ الْقَصِيرِ الْمَرْخِيِّ وَالطَّوِيلِ الْمَشْدُودِ',
          ),
        ],
        germanExamples: [
          PhoneticPairExample(
            orthography: 'Staat / Stadt',
            ipaTranscription: '[ʃtaːt] vs. [ʃtat]',
            glossAr: 'تَكْرَارُ الْحَرْفِ aa يُطِيلُ الصَّائِتَ، وَتَرَاكُمُ الصَّوَامِتِ dt يُقَصِّرُهُ',
          ),
          PhoneticPairExample(
            orthography: 'Miete / Mitte',
            ipaTranscription: '[ˈmiː.tə] vs. [ˈmɪ.tə]',
            glossAr: 'الْمَقْطَعُ ie يُطِيلُ الْكَسْرَةَ، وَتَضْعِيفُ tt يُقَصِّرُهَا',
          ),
        ],
        ruleAr:
            'تُعَبِّرُ الْعَرَبِيَّةُ عَنِ الطُّولِ بِحُرُوفِ الْمَدِّ (ا، و، ي)، بَيْنَمَا تَسْتَعْمِلُ الْأَلْمَانِيَّةُ «h» الصَّامِتَةَ (fahren) أَوْ «ie» لِلْمَدِّ، وَتَضْعِيفَ الصَّامِتِ لِلتَّقْصِيرِ.',
        ruleEn:
            'English distinguishes tense/long vowels from lax/short ones primarily by vowel quality alongside duration.',
        ruleDe:
            'Ein Doppelkonsonant nach einem Vokal (Mitte, kommen) zeigt im Deutschen an, dass der Vokal kurz und ungespannt gesprochen wird.',
        articulationTipAr:
            'حَرْفُ «h» فِي وَسَطِ الْكَلِمَةِ مِثْلَ «fahren» وَ«sehen» لَا يُنْطَقُ كَهَاءٍ؛ بَلْ هُوَ عَلَامَةُ مَدٍّ فَقَطْ.',
      ),
      PhonotacticsLesson(
        id: 'pp_04',
        category: PhonotacticsCategory.stressAndSemanticShift,
        titleAr: 'النَّبْرُ الصَّوْتِيُّ الْمُمَيِّزُ لِلْمَعْنَى وَالسَّوَابِقِ الْأَلْمَانِيَّةِ',
        titleEn: 'Contrastive Lexical Stress & Verb Separability',
        titleDe: 'Betonung bestimmt Bedeutung & Trennbarkeit (ˈübersetzen vs. überˈsetzen)',
        arabicExamples: [
          PhoneticPairExample(
            orthography: 'عَلِمَ / عَلَّمَ',
            ipaTranscription: '/ˈʕa.li.ma/ vs. /ˈʕal.la.ma/',
            glossAr: 'النَّبْرُ فِي الْعَرَبِيَّةِ مَقْطَعِيٌّ غَيْرُ فُونِيمِيٍّ، وَالتَّشْدِيدُ هُوَ الَّذِي يُغَيِّرُ الْمَعْنَى',
          ),
        ],
        englishExamples: [
          PhoneticPairExample(
            orthography: 'ˈrecord (N) / reˈcord (V)',
            ipaTranscription: '/ˈrek.ɔːd/ vs. /rɪˈkɔːd/',
            glossAr: 'انْتِقَالُ النَّبْرِ يُحَوِّلُ الِاسْمَ إِلَى فِعْلٍ وَيُغَيِّرُ الصَّائِتَ',
          ),
        ],
        germanExamples: [
          PhoneticPairExample(
            orthography: 'ˈübersetzen (trennbar)',
            ipaTranscription: '[ˈyː.bɐ.zɛt.sn̩]',
            glossAr: 'يَعْبُرُ بِالسَّفِينَةِ (السَّابِقَةُ مَنْبُورَةٌ وَمُنْفَصِلَةٌ)',
          ),
          PhoneticPairExample(
            orthography: 'überˈsetzen (untrennbar)',
            ipaTranscription: '[y.bɐˈzɛt.sn̩]',
            glossAr: 'يُتَرْجِمُ نَصًّا (النَّبْرُ عَلَى جَذْرِ الْفِعْلِ وَالسَّابِقَةُ غَيْرُ مُنْفَصِلَةٍ)',
          ),
        ],
        ruleAr:
            'انْتِقَالُ النَّبْرِ فِي الْإِنْجِلِيزِيَّةِ يُفَرِّقُ بَيْنَ الِاسْمِ وَالْفِعْلِ، وَفِي الْأَلْمَانِيَّةِ يُحَدِّدُ هَلِ السَّابِقَةُ مُنْفَصِلَةٌ أَمْ مُتَّصِلَةٌ.',
        ruleEn:
            'Two-syllable Latinate pairs in English typically stress syllable 1 for nouns/adjectives and syllable 2 for verbs.',
        ruleDe:
            'Bei Verben mit durch-/über-/um-/unter- ist das Verb trennbar, wenn das Präfix betont wird, und untrennbar, wenn der Verbstamm betont wird.',
        articulationTipAr:
            'تَذَكَّرْ: الْأَفْعَالُ ذَاتُ السَّابِقَةِ غَيْرِ الْمَنْبُورَةِ (überˈsetzen) لَا تَأْخُذُ «ge-» فِي اسْمِ الْمَفْعُولِ («übersetzt» لَا *übergesetzt).',
      ),
      PhonotacticsLesson(
        id: 'pp_05',
        category: PhonotacticsCategory.morphophonemicAlternation,
        titleAr: 'الْإِعْلَالُ الْعَرَبِيُّ وَالتَّنَاوُبُ الصَّوْتِيُّ لِلنِّهَايَاتِ فِي الْإِنْجِلِيزِيَّةِ',
        titleEn: 'Morphophonemic Endings (-ed / -s) & Arabic Vowel Elision',
        titleDe: 'Morphophonologie: Umlautbildung & Konsonantenwechsel',
        arabicExamples: [
          PhoneticPairExample(
            orthography: 'يَقُولُ ← لَمْ يَقُلْ',
            ipaTranscription: '/ja.quː.lu/ → /lam ja.qul/',
            glossAr: 'حُذِفَتِ الْوَاوُ لِالْتِقَاءِ السَّاكِنَيْنِ عِنْدَ الْجَزْمِ',
          ),
        ],
        englishExamples: [
          PhoneticPairExample(
            orthography: 'worked / lived / waited',
            ipaTranscription: '/wɜːkt/ /lɪvd/ /ˈweɪ.tɪd/',
            glossAr: 'نُطْقُ «-ed» ثَلَاثَةُ أَشْكَالٍ بِحَسَبِ الصَّوْتِ الْأَخِيرِ لِلْجَذْرِ',
          ),
        ],
        germanExamples: [
          PhoneticPairExample(
            orthography: 'laufen → er läuft',
            ipaTranscription: '[ˈlaʊ̯.fn̩] → [lɔʏ̯ft]',
            glossAr: 'تَحَوُّلُ الصَّائِتِ الْمُرَكَّبِ au إِلَى äu فِي الْمُفْرَدِ الْمُخَاطَبِ وَالْغَائِبِ',
          ),
        ],
        ruleAr:
            'تَسْقُطُ حُرُوفُ الْعِلَّةِ فِي الْأَجْوَفِ عِنْدَ سُكُونِ الْآخِرِ مَنْعًا لِالْتِقَاءِ السَّاكِنَيْنِ، وَفِي الْإِنْجِلِيزِيَّةِ يَتَّبِعُ نُطْقُ «-ed» جَهْرَ الصَّوْتِ السَّابِقِ.',
        ruleEn:
            'English "-ed" surfaces as /t/ after voiceless sounds, /d/ after voiced sounds, and /ɪd/ after alveolar stops /t, d/.',
        ruleDe:
            'Starke Verben mit Stammvokal a oder au zeigen in der 2. und 3. Person Singular Präsens häufig Umlautung (fährt, läuft).',
        articulationTipAr:
            'تَجَنَّبْ إِضَافَةَ مَقْطَعٍ زَائِدٍ فِي «worked»؛ إِذْ يُنْطَقُ بِمَقْطَعٍ وَاحِدٍ /wɜːkt/ لَا /wɜːkɪd/.',
      ),
      PhonotacticsLesson(
        id: 'pp_06',
        category: PhonotacticsCategory.junctureAndGlottalRules,
        titleAr: 'هَمْزَةُ الْوَصْلِ وَالْقَطْعِ مُقَابِلَ الْهَمْزَةِ الْأَلْمَانِيَّةِ (Knacklaut)',
        titleEn: 'Glottal Onset (Knacklaut) vs. Arabic Wasl/Qatʿ & English Linking',
        titleDe: 'Glottisschlag [ʔ] vor Vokal am Wort- und Morphemanfang',
        arabicExamples: [
          PhoneticPairExample(
            orthography: 'وَاسْتَمِعْ / وَأَكْرِمْ',
            ipaTranscription: '/was.ta.miʕ/ vs. /wa.ʔak.rim/',
            glossAr: 'تَسْقُطُ هَمْزَةُ الْوَصْلِ فِي الدَّرْجِ وَتَثْبُتُ هَمْزَةُ الْقَطْعِ دَائِمًا',
          ),
        ],
        englishExamples: [
          PhoneticPairExample(
            orthography: 'an apple (connected linking)',
            ipaTranscription: '/ən‿ˈæp.əl/',
            glossAr: 'الْوَصْلُ الصَّوْتِيُّ بَيْنَ الْكَلِمَتَيْنِ دُونَ وَقْفَةٍ حَنْجَرِيَّةٍ',
          ),
        ],
        germanExamples: [
          PhoneticPairExample(
            orthography: 'beachten / Theater',
            ipaTranscription: '[bəˈʔax.tn̩] / [teˈʔaː.tɐ]',
            glossAr: 'الْهَمْزَةُ الصَّوْتِيَّةُ [ʔ] تَفْصِلُ الصَّائِتَيْنِ وَلَا تُدْمِجُهُمَا',
          ),
        ],
        ruleAr:
            'تَتَمَيَّزُ الْأَلْمَانِيَّةُ بِحِفَاظِهَا عَلَى نَبْرَةِ قَطْعٍ حَنْجَرِيَّةٍ [ʔ] قَبْلَ كُلِّ صَائِتٍ فِي بِدَايَةِ جَذْرٍ جَدِيدٍ، عَلَى عَكْسِ الْوَصْلِ السَّلِسِ فِي الْإِنْجِلِيزِيَّةِ.',
        ruleEn:
            'English prefers C-V linking across word boundaries ("an apple" sounds like "a napple"), avoiding glottal stops.',
        ruleDe:
            'Der deutsche Knacklaut [ʔ] markiert klare Silben- und Morphemgrenzen vor anlautenden Vokalen (z. B. ver-ein-en).',
        articulationTipAr:
            'إِذَا وَصَلْتَ كَلِمَتَيْنِ فِي الْأَلْمَانِيَّةِ مِثْلَ «ein Apfel» دُونَ [ʔ] بَدَا النُّطْقُ إِنْجِلِيزِيًّا لَا أَلْمَانِيًّا.',
      ),
    ];
  }

  List<PhonotacticsDrill> getDrills() {
    return const [
      PhonotacticsDrill(
        id: 'ppd_01',
        category: PhonotacticsCategory.consonantAssimilation,
        targetLanguage: 'German',
        promptAr: 'كَيْفَ يُنْطَقُ حَرْفُ «d» فِي آخِرِ الْكَلِمَةِ الْأَلْمَانِيَّةِ «Freund»؟',
        promptEn: 'How is the final "d" in German "Freund" pronounced?',
        promptDe: 'Wie wird das auslautende „d“ in „Freund“ ausgesprochen?',
        options: [
          '[d] مَجْهُورَةً كَمَا فِي Freunde',
          '[t] مَهْمُوسَةً بِسَبَبِ Auslautverhärtung',
          'صَامِتَةً لَا تُنْطَقُ',
        ],
        correctIndex: 1,
        explanationAr: 'بِسَبَبِ تَقْسِيَةِ الْأَوَاخِرِ (Auslautverhärtung) يُنْطَقُ [t] فِي «Freund» [frɔʏ̯nt].',
      ),
      PhonotacticsDrill(
        id: 'ppd_02',
        category: PhonotacticsCategory.allophonicDistribution,
        targetLanguage: 'German',
        promptAr: 'أَيُّ نُطْقٍ صَحِيحٌ لِلْمَقْطَعِ «ch» فِي كَلِمَةِ «Bücher»؟',
        promptEn: 'Which sound represents "ch" in German "Bücher"?',
        promptDe: 'Welcher Laut steht für „ch“ in „Bücher“?',
        options: [
          'Ach-Laut [x] (مِثْلَ الْخَاءِ)',
          'Ich-Laut [ç] (لِأَنَّ مَا قَبْلَهُ صَائِتٌ أَمَامِيٌّ ü)',
          'صَوْتُ [k]',
        ],
        correctIndex: 1,
        explanationAr: 'بَعْدَ «ü» يَقَعُ الصَّوْتُ فِي الْأَمَامِ فَيُنْطَقُ Ich-Laut [ç].',
      ),
      PhonotacticsDrill(
        id: 'ppd_03',
        category: PhonotacticsCategory.vowelLengthAndOrthography,
        targetLanguage: 'German',
        promptAr: 'مَا دَلَالَةُ تَضْعِيفِ «mm» فِي كَلِمَةِ «kommen» عَلَى الصَّائِتِ «o»؟',
        promptEn: 'What does the double consonant "mm" indicate about the preceding "o" in "kommen"?',
        promptDe: 'Was zeigt der Doppelkonsonant „mm“ in „kommen“ über das „o“ an?',
        options: [
          'أَنَّ الصَّائِتَ «o» قَصِيرٌ',
          'أَنَّ الصَّائِتَ «o» طَوِيلٌ مَمْدُودٌ',
          'أَنَّ «m» الثَّانِيَةَ صَامِتَةٌ',
        ],
        correctIndex: 0,
        explanationAr: 'تَضْعِيفُ الصَّامِتِ فِي الْأَلْمَانِيَّةِ عَلَامَةٌ قَاطِعَةٌ عَلَى قِصَرِ الصَّائِتِ قَبْلَهُ.',
      ),
      PhonotacticsDrill(
        id: 'ppd_04',
        category: PhonotacticsCategory.stressAndSemanticShift,
        targetLanguage: 'German',
        promptAr: 'أَيُّ صِيغَةٍ مِنَ الْفِعْلِ «übersetzen» تَعْنِي «يُتَرْجِمُ نَصًّا» وَمَا مَوْضِعُ النَّبْرِ فِيهَا؟',
        promptEn: 'Which stress pattern of "übersetzen" means "to translate"?',
        promptDe: 'Welche Betonung von „übersetzen“ bedeutet „in eine andere Sprache übertragen“?',
        options: [
          'ˈübersetzen (النَّبْرُ عَلَى السَّابِقَةِ، مُنْفَصِلٌ)',
          'überˈsetzen (النَّبْرُ عَلَى الْجَذْرِ، مُتَّصِلٌ)',
          'لَا فَرْقَ فِي النَّبْرِ بَيْنَ الْمَعْنَيَيْنِ',
        ],
        correctIndex: 1,
        explanationAr: '«überˈsetzen» بِالنَّبْرِ عَلَى الْجَذْرِ فِعْلٌ غَيْرُ مُنْفَصِلٍ مَعْنَاهُ يُتَرْجِمُ.',
      ),
      PhonotacticsDrill(
        id: 'ppd_05',
        category: PhonotacticsCategory.morphophonemicAlternation,
        targetLanguage: 'English',
        promptAr: 'كَيْفَ تُنْطَقُ النِّهَايَةُ «-ed» فِي الْفِعْلِ الْإِنْجِلِيزِيِّ «helped»؟',
        promptEn: 'How is the "-ed" suffix pronounced in "helped"?',
        promptDe: 'Wie wird die Endung „-ed“ in „helped“ ausgesprochen?',
        options: [
          '/ɪd/ (بِمَقْطَعٍ إِضَافِيٍّ)',
          '/d/ (مَجْهُورَةً)',
          '/t/ (مَهْمُوسَةً بَعْدَ p)',
        ],
        correctIndex: 2,
        explanationAr: 'الْحَرْفُ الْأَخِيرُ /p/ صَوْتٌ مَهْمُوسٌ، فَتُنْطَقُ النِّهَايَةُ /t/: /helpt/.',
      ),
      PhonotacticsDrill(
        id: 'ppd_06',
        category: PhonotacticsCategory.junctureAndGlottalRules,
        targetLanguage: 'Arabic',
        promptAr: 'أَيُّ الْكَلِمَتَيْنِ تَبْدَأُ بِهَمْزَةِ وَصْلٍ تَسْقُطُ لَفْظًا عِنْدَ وَصْلِهَا بِالْوَاوِ؟',
        promptEn: 'Which Arabic word begins with Hamzat al-Wasl (elided in connected speech)?',
        promptDe: 'Welches arabische Wort beginnt mit einem Hamzat al-Wasl?',
        options: [
          'أَكْرَمَ (وَأَكْرَمَ)',
          'اسْتَفْهَمَ (وَاسْتَفْهَمَ)',
          'إِعْلَامٌ (وَإِعْلَامٌ)',
        ],
        correctIndex: 1,
        explanationAr: 'الْمَاضِي السُّدَاسِيُّ «اسْتَفْهَمَ» هَمْزَتُهُ هَمْزَةُ وَصْلٍ تَسْقُطُ فِي الدَّرْجِ: «وَاسْتَفْهَمَ».',
      ),
    ];
  }
}
