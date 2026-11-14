import '../models/word_order_models.dart';

class WordOrderRepository {
  const WordOrderRepository();

  List<WordOrderPattern> getPatterns() {
    return const [
      WordOrderPattern(
        id: 'wo_01',
        topic: WordOrderTopic.v2AndInversion,
        titleAr: 'ثَبَاتُ الْفِعْلِ فِي الْمَوْقِعِ الثَّانِي (V2) عِنْدَ تَقْدِيمِ الزَّمَانِ أَوِ الْمَكَانِ',
        titleEn: 'German V2 Inversion vs. English Subject-Before-Verb Retention',
        titleDe: 'V2-Regel: Vorfeld (Heute) + Finites Verb (lernt) + Subjekt (er)',
        sentenceAr: 'الْيَوْمَ يَدْرُسُ الطَّالِبُ النَّحْوَ فِي الْمَكْتَبَةِ.',
        sentenceEn: 'Today, the student studies grammar in the library.',
        sentenceDe: 'Heute lernt der Student in der Bibliothek Grammatik.',
        slotBreakdownDe: '[Vorfeld: Heute] | [Linke Klammer: lernt] | [Mittelfeld: der Student in der Bibliothek Grammatik]',
        ruleAr:
            'تَسْمَحُ الْعَرَبِيَّةُ وَالْأَلْمَانِيَّةُ بِتَقْدِيمِ الظَّرْفِ قَبْلَ الْفِعْلِ، لَكِنَّ الْأَلْمَانِيَّةَ تُحَتِّمُ بَقَاءَ الْفِعْلِ فِي الْمَوْقِعِ الثَّانِي مُبَاشَرَةً بَعْدَ الظَّرْفِ.',
        ruleEn:
            'When an adverbial ("Today,") is fronted in English, the subject ("the student") still precedes the verb.',
        ruleDe:
            'Im deutschen Aussagesatz steht das finite Verb immer auf Position 2. Besetzt ein Adverb das Vorfeld, rückt das Subjekt hinter das Verb.',
        pitfallAlertAr:
            'الْخَطَأُ الشَّائِعُ لَدَى مُتَعَلِّمِي الْإِنْجِلِيزِيَّةِ: قَوْلُ *Heute der Student lernt؛ الصَّوَابُ «Heute lernt der Student».',
        topologyTag: 'V2 (Position 2)',
      ),
      WordOrderPattern(
        id: 'wo_02',
        topic: WordOrderTopic.satzklammer,
        titleAr: 'الْإِطَارُ الْفِعْلِيُّ الْأَلْمَانِيُّ (Satzklammer): الْفِعْلُ الْمُسَاعِدُ وَنِهَايَةُ الْجُمْلَةِ',
        titleEn: 'German Satzklammer vs. Contiguous English Auxiliaries',
        titleDe: 'Satzklammer: Hilfs-/Modalverb (Pos. 2) ... Infinitiv/Partizip (Ende)',
        sentenceAr: 'لَقَدْ رَاجَعَ الْبَاحِثُ الْمَصَادِرَ التَّارِيخِيَّةَ كُلَّهَا بِدِقَّةٍ أَمْسِ.',
        sentenceEn: 'The researcher carefully reviewed all historical sources yesterday.',
        sentenceDe: 'Der Forscher hat gestern alle historischen Quellen sorgfältig geprüft.',
        slotBreakdownDe: '[Vorfeld: Der Forscher] | [LK: hat] | [Mittelfeld: gestern alle historischen Quellen sorgfältig] | [RK: geprüft]',
        ruleAr:
            'يَتَجَاوَرُ الْفِعْلُ وَفَاعِلُهُ وَمَفْعُولُهُ فِي الْعَرَبِيَّةِ وَالْإِنْجِلِيزِيَّةِ، بَيْنَمَا تَفْتَحُ الْأَلْمَانِيَّةُ قَوْسًا بَيْنَ الْفِعْلِ الْمُصَرَّفِ (hat) وَالْمَصْدَرِ أَوِ اسْمِ الْمَفْعُولِ فِي آخِرِ الْجُمْلَةِ (geprüft).',
        ruleEn:
            'English keeps auxiliary and main verb together ("has reviewed"), whereas German wraps all objects and adverbs inside the bracket.',
        ruleDe:
            'Die Satzklammer trennt das finite Verb (Position 2) vom infiniten Verbteil (Partizip II, Infinitiv oder trennbares Präfix) am Satzende.',
        pitfallAlertAr:
            'لَا تَضَعْ «geprüft» مُبَاشَرَةً بَعْدَ «hat» فِي الْأَلْمَانِيَّةِ مِثْلَ *hat geprüft alle Quellen؛ بَلْ أَخِّرْهُ إِلَى نِهَايَةِ الْجُمْلَةِ.',
        topologyTag: 'Satzklammer',
      ),
      WordOrderPattern(
        id: 'wo_03',
        topic: WordOrderTopic.tekamoloVsMpt,
        titleAr: 'تَرْتِيبُ الظُّرُوفِ الْأَرْبَعَةِ: TeKaMoLo الْأَلْمَانِيَّةُ مُقَابِلَ MPT الْإِنْجِلِيزِيَّةِ',
        titleEn: 'Adverbial Order Mirror: German TeKaMoLo vs. English Manner–Place–Time',
        titleDe: 'TeKaMoLo-Regel: Temporal → Kausal → Modal → Lokal',
        sentenceAr: 'سَافَرَ الْيَوْمَ بِسَبَبِ النَّدْوَةِ بِالْقِطَارِ إِلَى بَرْلِينَ.',
        sentenceEn: 'He traveled to Berlin by train today because of the seminar.',
        sentenceDe: 'Er fährt heute wegen des Seminars mit dem Zug nach Berlin.',
        slotBreakdownDe: '[heute: Temporal] → [wegen des Seminars: Kausal] → [mit dem Zug: Modal] → [nach Berlin: Lokal]',
        ruleAr:
            'الْعَرَبِيَّةُ مَرِنَةٌ فِي تَقْدِيمِ الْجَارِّ وَالْمَجْرُورِ بِحَسَبِ الْعِنَايَةِ، أَمَّا الْأَلْمَانِيَّةُ فَتُلْزِمُ التَّرْتِيبَ الطَّبِيعِيَّ (TeKaMoLo)، وَالْإِنْجِلِيزِيَّةُ تَعْكِسُهُ إِلَى (Place → Manner/Time).',
        ruleEn:
            'English naturally places destination/place early ("to Berlin"), followed by manner ("by train") and time ("today").',
        ruleDe:
            'Im deutschen Mittelfeld gilt als unmarkierte Grundfolge Te-Ka-Mo-Lo: Wann? → Warum? → Wie? → Wo/Wohin?.',
        pitfallAlertAr:
            'تَجَنَّبْ تَقْدِيمَ الْمَكَانِ (nach Berlin) قَبْلَ الزَّمَانِ (heute) فِي الْوَسَطِ الْأَلْمَانِيِّ؛ فَالزَّمَانُ يَسْبِقُ الْمَكَانَ دَائِمًا فِي TeKaMoLo.',
        topologyTag: 'TeKaMoLo vs. MPT',
      ),
      WordOrderPattern(
        id: 'wo_04',
        topic: WordOrderTopic.dativeAccusativePronouns,
        titleAr: 'تَرْتِيبُ الْمَفْعُولَيْنِ: الْأَسْمَاءُ الظَّاهِرَةُ مُقَابِلَ الضَّمَائِرِ',
        titleEn: 'Dative-Accusative Noun Order vs. Accusative-Dative Pronoun Flip',
        titleDe: 'Objektstellung: Dativ vor Akkusativ (Nomen) vs. Akk vor Dat (Pronomen)',
        sentenceAr: 'أَعْطَى الْمُعَلِّمُ الطَّالِبَ الْكِتَابَ؛ ثُمَّ أَعْطَاهُ إِيَّاهُ.',
        sentenceEn: 'The teacher gave the student the book; then he gave it to him.',
        sentenceDe: 'Der Lehrer gibt dem Schüler das Buch; dann gibt er es ihm.',
        slotBreakdownDe: 'Nomen: [dem Schüler (Dativ)] → [das Buch (Akk)] | Pronomen: [es (Akk)] → [ihm (Dativ)]',
        ruleAr:
            'فِي الْعَرَبِيَّةِ يَتَقَدَّمُ الْآخِذُ (الطَّالِبَ) عَلَى الْمَأْخُوذِ (الْكِتَابَ)، وَفِي الضَّمَائِرِ يَتَّصِلُ الْأَخَصُّ أَوَّلًا: «أَعْطَاهُ إِيَّاهُ».',
        ruleEn:
            'English allows "gave the student the book" (no preposition) or "gave it to him" (prepositional "to").',
        ruleDe:
            'Bei zwei Nomen steht Dativ vor Akkusativ („dem Schüler das Buch“). Sind beide Pronomen, kehrt sich die Reihenfolge um: Akkusativ vor Dativ („es ihm“).',
        pitfallAlertAr:
            'لَا تَقُلْ *gibt er ihm es فِي الْأَلْمَانِيَّةِ الْفَصِيحَةِ؛ بَلْ قَدِّمْ ضَمِيرَ الْمَفْعُولِ بِهِ (es) قَبْلَ (ihm): «gibt er es ihm».',
        topologyTag: 'es ihm (Akk → Dat)',
      ),
      WordOrderPattern(
        id: 'wo_05',
        topic: WordOrderTopic.arabicVsoVsSvo,
        titleAr: 'الْأَصْلُ الْفِعْلِيُّ (VSO) وَوُجُوبُ تَقْدِيمِ الْخَبَرِ فِي النَّكِرَةِ الْمَحْضَةِ',
        titleEn: 'Arabic VSO Default & Obligatory Predicate Fronting',
        titleDe: 'Arabische VSO-Struktur vs. Voranstellung des Prädikats',
        sentenceAr: 'كَتَبَ الطَّالِبُ الدَّرْسَ؛ وَفِي الْمَكْتَبَةِ كُتُبٌ قَيِّمَةٌ.',
        sentenceEn: 'There are valuable books in the library.',
        sentenceDe: 'In der Bibliothek befinden sich wertvolle Bücher.',
        slotBreakdownDe: '[Vorfeld: In der Bibliothek] | [Verb: befinden sich] | [Subjekt: wertvolle Bücher]',
        ruleAr:
            'الْأَصْلُ فِي الْعَرَبِيَّةِ تَقَدُّمُ الْفِعْلِ (كَتَبَ الطَّالِبُ)، وَيَجِبُ تَقْدِيمُ الْخَبَرِ الشِّبْهِ جُمْلَةٍ إِذَا كَانَ الْمُبْتَدَأُ نَكِرَةً غَيْرَ مُخَصَّصَةٍ: «فِي الْمَكْتَبَةِ كُتُبٌ».',
        ruleEn:
            'English introduces indefinite existential subjects using dummy "There is/are" instead of bare prepositional fronting.',
        ruleDe:
            'Auch das Deutsche stellt oft die Ortsangabe ins Vorfeld („In der Bibliothek stehen...“) oder nutzt „Es gibt + Akkusativ“.',
        pitfallAlertAr:
            'تَجَنَّبْ تَرْجَمَةَ «فِي الْمَكْتَبَةِ كُتُبٌ» إِلَى *In the library are books بِالْإِنْجِلِيزِيَّةِ؛ بَلِ اسْتَعْمِلْ «There are books in the library».',
        topologyTag: 'VSO & تَقْدِيمُ الْخَبَرِ',
      ),
      WordOrderPattern(
        id: 'wo_06',
        topic: WordOrderTopic.negativeInversionAndEmphaticFronting,
        titleAr: 'الْقَلْبُ التَّرْكِيبِيُّ بَعْدَ النَّفْيِ الْمُقَدَّمِ فِي الْإِنْجِلِيزِيَّةِ وَالْأَلْمَانِيَّةِ',
        titleEn: 'Subject-Auxiliary Inversion After Fronted Negative Expressions',
        titleDe: 'Hervorhebung negativer Ausdrücke im Vorfeld (Nie habe ich...)',
        sentenceAr: 'لَمْ أَقْرَأْ قَطُّ شَرْحًا أَوْضَحَ مِنْ هَذَا الشَّرْحِ.',
        sentenceEn: 'Never have I read a clearer explanation than this.',
        sentenceDe: 'Nie habe ich eine klarere Erklärung als diese gelesen.',
        slotBreakdownDe: '[Vorfeld: Nie] | [LK: habe] | [Subjekt: ich] | [Mittelfeld: eine klarere Erklärung...] | [RK: gelesen]',
        ruleAr:
            'تَقْدِيمُ النَّفْيِ «Never» أَوْ «Not only» فِي الْإِنْجِلِيزِيَّةِ يُوجِبُ تَقْدِيمَ الْفِعْلِ الْمُسَاعِدِ عَلَى الْفَاعِلِ، فَيُشْبِهُ حِينَئِذٍ قَاعِدَةَ V2 الْأَلْمَانِيَّةَ تَمَامًا!',
        ruleEn:
            'Fronting negative/restrictive adverbials ("Never", "Seldom", "Only then") triggers mandatory subject-auxiliary inversion in English.',
        ruleDe:
            'Im Deutschen ist „Nie habe ich...“ schlicht ein regulärer V2-Satz mit „Nie“ im Vorfeld.',
        pitfallAlertAr:
            'الْخَطَأُ الشَّائِعُ فِي الْإِنْجِلِيزِيَّةِ: قَوْلُ *Never I have read؛ الصَّوَابُ «Never have I read».',
        topologyTag: 'Negative Inversion',
      ),
    ];
  }

  List<WordOrderDrill> getDrills() {
    return const [
      WordOrderDrill(
        id: 'wod_01',
        topic: WordOrderTopic.v2AndInversion,
        targetLanguage: 'German',
        promptAr: 'اخْتَرِ التَّرْتِيبَ الْأَلْمَانِيَّ الصَّحِيحَ عِنْدَ تَقْدِيمِ الظَّرْفِ «Morgen»:',
        promptEn: 'Select the grammatical German sentence starting with "Morgen":',
        promptDe: 'Wählen Sie den korrekten V2-Satz mit „Morgen“ im Vorfeld:',
        options: [
          'Morgen wir besuchen die Bibliothek.',
          'Morgen besuchen wir die Bibliothek.',
          'Morgen die Bibliothek besuchen wir.',
        ],
        correctIndex: 1,
        explanationAr: 'بِسَبَبِ قَاعِدَةِ V2 يَقَعُ الْفِعْلُ (besuchen) فِي الْمَوْقِعِ الثَّانِي مُبَاشَرَةً بَعْدَ «Morgen».',
      ),
      WordOrderDrill(
        id: 'wod_02',
        topic: WordOrderTopic.satzklammer,
        targetLanguage: 'German',
        promptAr: 'أَيْنَ يَقَعُ اسْمُ الْمَفْعُولِ «gelesen» فِي جُمْلَةِ الْمَاضِي الْمُرَكَّبِ؟',
        promptEn: 'Where does the past participle "gelesen" go in a German main clause?',
        promptDe: 'Wo steht das Partizip II „gelesen“ im Hauptsatz?',
        options: [
          'Er hat gelesen gestern das ganze Buch.',
          'Er hat gestern das ganze Buch gelesen.',
          'Er gelesen hat gestern das ganze Buch.',
        ],
        correctIndex: 1,
        explanationAr: 'يُغْلِقُ اسْمُ الْمَفْعُولِ (gelesen) الْقَوْسَ الْفِعْلِيَّ (Satzklammer) فِي نِهَايَةِ الْجُمْلَةِ.',
      ),
      WordOrderDrill(
        id: 'wod_03',
        topic: WordOrderTopic.tekamoloVsMpt,
        targetLanguage: 'German',
        promptAr: 'أَيُّ جُمْلَةٍ تَتَّبِعُ تَرْتِيبَ TeKaMoLo الْقِيَاسِيَّ فِي الْأَلْمَانِيَّةِ؟',
        promptEn: 'Which German sentence follows the standard TeKaMoLo adverbial order?',
        promptDe: 'Welcher Satz folgt der TeKaMoLo-Reihenfolge?',
        options: [
          'Er fährt nach Berlin mit dem Zug heute.',
          'Er fährt heute wegen des Termins mit dem Zug nach Berlin.',
          'Er fährt wegen des Termins nach Berlin heute mit dem Zug.',
        ],
        correctIndex: 1,
        explanationAr: 'التَّرْتِيبُ الْقِيَاسِيُّ هُوَ: Temporal (heute) → Kausal (wegen...) → Modal (mit dem Zug) → Lokal (nach Berlin).',
      ),
      WordOrderDrill(
        id: 'wod_04',
        topic: WordOrderTopic.dativeAccusativePronouns,
        targetLanguage: 'German',
        promptAr: 'مَا التَّرْتِيبُ الصَّحِيحُ إِذَا كَانَ الْمَفْعُولَانِ ضَمِيرَيْنِ (es وَ ihm)؟',
        promptEn: 'Choose the correct German pronoun order for "gives it to him":',
        promptDe: 'Wählen Sie die korrekte Pronomenfolge:',
        options: [
          'Er gibt ihm es.',
          'Er gibt es ihm.',
          'Es gibt er ihm.',
        ],
        correctIndex: 1,
        explanationAr: 'عِنْدَمَا يَكُونُ الْمَفْعُولَانِ ضَمِيرَيْنِ، يَتَقَدَّمُ Akkusativ (es) عَلَى Dativ (ihm).',
      ),
      WordOrderDrill(
        id: 'wod_05',
        topic: WordOrderTopic.arabicVsoVsSvo,
        targetLanguage: 'Arabic',
        promptAr: 'لِمَاذَا وَجَبَ تَقْدِيمُ الْخَبَرِ فِي قَوْلِنَا: «فِي الْحَقِيبَةِ كِتَابٌ»؟',
        promptEn: 'Why is predicate fronting obligatory in "fī l-ḥaqībati kitābun"?',
        promptDe: 'Warum steht das Prädikat in „fī l-ḥaqībati kitābun“ zwingend am Anfang?',
        options: [
          'لِأَنَّ الْمُبْتَدَأَ «كِتَابٌ» نَكِرَةٌ غَيْرُ مُخَصَّصَةٍ وَالْخَبَرَ شِبْهُ جُمْلَةٍ',
          'لِأَنَّ الْخَبَرَ فِعْلٌ مَاضٍ',
          'لِأَنَّ الْمُبْتَدَأَ مَعْرِفَةٌ',
        ],
        correctIndex: 0,
        explanationAr: 'يَتَقَدَّمُ الْخَبَرُ وُجُوبًا إِذَا كَانَ شِبْهَ جُمْلَةٍ وَالْمُبْتَدَأُ نَكِرَةً مَحْضَةً.',
      ),
      WordOrderDrill(
        id: 'wod_06',
        topic: WordOrderTopic.negativeInversionAndEmphaticFronting,
        targetLanguage: 'English',
        promptAr: 'اخْتَرِ الصِّيغَةَ الْإِنْجِلِيزِيَّةَ الصَّحِيحَةَ بَعْدَ تَقْدِيمِ «Not only»:',
        promptEn: 'Select the grammatical English inversion after fronted "Not only":',
        promptDe: 'Wählen Sie die korrekte englische Inversion nach „Not only“:',
        options: [
          'Not only he mastered Arabic, but also German.',
          'Not only did he master Arabic, but also German.',
          'Not only mastered he Arabic, but also German.',
        ],
        correctIndex: 1,
        explanationAr: 'تَقْدِيمُ «Not only» يُوجِبُ تَقْدِيمَ الْفِعْلِ الْمُسَاعِدِ «did» عَلَى الْفَاعِلِ «he».',
      ),
    ];
  }
}
