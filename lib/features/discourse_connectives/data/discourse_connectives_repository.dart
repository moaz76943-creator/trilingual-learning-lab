import '../models/discourse_connectives_models.dart';

class DiscourseConnectivesRepository {
  const DiscourseConnectivesRepository();

  List<ConnectiveSyntaxTriplet> getTriplets() {
    return const [
      ConnectiveSyntaxTriplet(
        id: 'dc_01',
        relation: DiscourseRelationType.causal,
        titleAr: 'التَّعْلِيلُ بَيْنَ «لِأَنَّ / إِذْ» وَ«weil / denn / wegen»',
        titleEn: 'Causal Subordination vs. Coordination vs. Preposition',
        titleDe: 'Kausal: weil (Verbletzt) vs. denn (Position 0) vs. wegen (Genitiv)',
        subordinatingAr: 'يَتَعَلَّمُ النَّحْوَ بِشَغَفٍ؛ لِأَنَّهُ يُعِينُهُ عَلَى فَهْمِ التُّرَاثِ.',
        adverbialOrPrepAr: 'بَلَغَ الْإِتْقَانَ بِسَبَبِ مُثَابَرَتِهِ الْمُسْتَمِرَّةِ.',
        subordinatingEn: 'He studies grammar eagerly because it helps him understand heritage.',
        adverbialOrPrepEn: 'He achieved mastery because of his continuous perseverance.',
        subordinatingDe: 'Er lernt Grammatik mit Begeisterung, weil sie ihm beim Verstehen hilft.',
        adverbialOrPrepDe: 'Er lernt Grammatik, denn sie hilft ihm; wegen seines Fleißes macht er Fortschritte.',
        wordOrderRuleAr:
            'تَدْخُلُ «لِأَنَّ» عَلَى الْجُمْلَةِ الِاسْمِيَّةِ فَتَنْصِبُ الْمُبْتَدَأَ وَتَرْفَعُ الْخَبَرَ، أَمَّا «بِسَبَبِ» فَتَجُرُّ الْمَصْدَرَ أَوِ الِاسْمَ الصَّرِيحَ.',
        wordOrderRuleEn:
            '"Because" takes a full finite clause, whereas "because of / due to" requires a noun phrase.',
        wordOrderRuleDe:
            '„Weil“ schickt das konjugierte Verb ans Satzende (Nebensatz); „denn“ steht auf Position 0 (Verb bleibt auf Position 2); „wegen“ regiert Genitiv.',
        pitfallAlertAr:
            'لَا تَضَعِ الْفِعْلَ فِي الْمَوْقِعِ الثَّانِي بَعْدَ «weil» فِي الْكِتَابَةِ الْفَصِيحَةِ، وَلَا تَسْتَعْمِلْ «because» قَبْلَ اسْمٍ مُفْرَدٍ بِدُونِ «of».',
        germanPositionTag: 'Verbletzt vs. Pos. 0',
      ),
      ConnectiveSyntaxTriplet(
        id: 'dc_02',
        relation: DiscourseRelationType.concessive,
        titleAr: 'الِاسْتِدْرَاكُ الرَّغْمِيُّ: «مَعَ أَنَّ / بِالرَّغْمِ مِنْ» مُقَابِلَ «obwohl / trotzdem / trotz»',
        titleEn: 'Concessive Clauses vs. Conjunctive Adverbs vs. Prepositions',
        titleDe: 'Konzessiv: obwohl (NS) vs. trotzdem (Inversion) vs. trotz (Genitiv)',
        subordinatingAr: 'وَاصلَ الْبَحْثَ عَلَى الرَّغْمِ مِنْ أَنَّ الْمَسْأَلَةَ دَقِيقَةٌ.',
        adverbialOrPrepAr: 'الْمَسْأَلَةُ دَقِيقَةٌ؛ وَمَعَ ذَلِكَ وَاصلَ الْبَحْثَ بِهِمَّةٍ.',
        subordinatingEn: 'He continued researching although the issue was intricate.',
        adverbialOrPrepEn: 'Despite the intricacy of the issue, he continued; nevertheless, he checked every source.',
        subordinatingDe: 'Er forschte weiter, obwohl die Frage sehr komplex war.',
        adverbialOrPrepDe: 'Die Frage war komplex; trotzdem forschte er weiter. Trotz der Komplexität gab er nicht auf.',
        wordOrderRuleAr:
            '«عَلَى الرَّغْمِ مِنْ أَنَّ» تَرْبِطُ جُمْلَةً اسْمِيَّةً، بَيْنَمَا «رَغْمَ / بِالرَّغْمِ مِنْ» تَجُرُّ الِاسْمَ، وَ«مَعَ ذَلِكَ» تَسْتَأْنِفُ النَّتِيجَةَ الْمُخَالِفَةَ.',
        wordOrderRuleEn:
            'Never pair "although" and "but" in the same sentence; use "despite + NP" or "nevertheless" between independent clauses.',
        wordOrderRuleDe:
            '„Obwohl“ (Nebensatz, Verb am Ende) steht im Gegensatz zu „trotzdem“ (Konjunktionaladverb auf Position 1 mit Inversion: Verb auf Position 2).',
        pitfallAlertAr:
            'مِنْ أَشْهَرِ الْأَخْطَاءِ: الْجَمْعُ بَيْنَ «although» وَ«but» فِي جُمْلَةٍ وَاحِدَةٍ، أَوْ تَرْكُ الْفَاعِلِ قَبْلَ الْفِعْلِ بَعْدَ «trotzdem».',
        germanPositionTag: 'NS vs. Pos. 1 Inversion',
      ),
      ConnectiveSyntaxTriplet(
        id: 'dc_03',
        relation: DiscourseRelationType.consecutive,
        titleAr: 'النَّتِيجَةُ وَالتَّعْقِيبُ: «لِذَلِكَ / حَتَّى» مُقَابِلَ «deshalb / sodass»',
        titleEn: 'Resultative Adverbs vs. Consecutive Clauses',
        titleDe: 'Konsekutiv: deshalb (Hauptsatz-Inversion) vs. sodass (Nebensatz)',
        subordinatingAr: 'رَتَّبَ أَفْكَارَهُ بِدِقَّةٍ، بِحَيْثُ جَاءَتِ الْمَقَالَةُ مُتَمَاسِكَةً.',
        adverbialOrPrepAr: 'رَتَّبَ أَفْكَارَهُ بِدِقَّةٍ؛ وَلِذَلِكَ جَاءَتِ الْمَقَالَةُ مُتَمَاسِكَةً.',
        subordinatingEn: 'He organized his ideas carefully, so that the essay turned out cohesive.',
        adverbialOrPrepEn: 'He organized his ideas carefully; therefore, the essay was cohesive.',
        subordinatingDe: 'Er ordnete seine Gedanken sorgfältig, sodass der Aufsatz schlüssig wurde.',
        adverbialOrPrepDe: 'Er ordnete seine Gedanken sorgfältig; deshalb wurde der Aufsatz sehr schlüssig.',
        wordOrderRuleAr:
            'تُقَدِّمُ «لِذَلِكَ» وَ«وَمِنْ ثَمَّ» النَّتِيجَةَ فِي جُمْلَةٍ مُسْتَقِلَّةٍ، بَيْنَمَا تَرْبِطُ «بِحَيْثُ» النَّتِيجَةَ بِسَبَبِهَا مُبَاشَرَةً.',
        wordOrderRuleEn:
            '"Therefore" and "consequently" are conjunctive adverbs requiring a semicolon or period before them.',
        wordOrderRuleDe:
            '„Sodass“ leitet einen Nebensatz ein (Verb am Ende), während „deshalb / daher / infolgedessen“ im Hauptsatz Inversion auslösen.',
        pitfallAlertAr:
            'فِي الْإِنْجِلِيزِيَّةِ يَقَعُ كَثِيرٌ فِي «comma splice» بِوَضْعِ فَاصِلَةٍ فَقَطْ قَبْلَ «therefore» بَدَلَ الْفَاصِلَةِ الْمَنْقُوطَةِ (;) أَوِ النُّقْطَةِ.',
        germanPositionTag: 'Inversion vs. Nebensatz',
      ),
      ConnectiveSyntaxTriplet(
        id: 'dc_04',
        relation: DiscourseRelationType.purposive,
        titleAr: 'التَّعْلِيلُ الْمَقْصِدِيُّ: «كَيْ / لِكَيْ» مُقَابِلَ «um ... zu» وَ«damit»',
        titleEn: 'Same-Subject Infinitive Purpose vs. Different-Subject Purpose Clause',
        titleDe: 'Finalsatz: um ... zu (gleiches Subjekt) vs. damit (Subjektwechsel)',
        subordinatingAr: 'يُرَاجِعُ الطَّالِبُ دُرُوسَهُ كَيْ يَتَمَكَّنَ مِنَ الْقَوَاعِدِ.',
        adverbialOrPrepAr: 'يَشْرَحُ الْأُسْتَاذُ بِوُضُوحٍ لِكَيْ يَفْهَمَ الطُّلَّابُ جَمِيعُهُمْ.',
        subordinatingEn: 'The student reviews his lessons in order to master the rules.',
        adverbialOrPrepEn: 'The professor explains clearly so that all students can understand.',
        subordinatingDe: 'Der Student wiederholt den Stoff, um die Regeln sicher zu beherrschen.',
        adverbialOrPrepDe: 'Der Professor erklärt es anschaulich, damit alle Studierenden es verstehen.',
        wordOrderRuleAr:
            'تَنْصِبُ «كَيْ / لِكَيْ / لَامُ التَّعْلِيلِ» الْفِعْلَ الْمُضَارِعَ فِي الْعَرَبِيَّةِ سَوَاءٌ اتَّحَدَ الْفَاعِلُ أَمِ اخْتَلَفَ.',
        wordOrderRuleEn:
            '"In order to + infinitive" is preferred for same-subject purpose, while "so that" handles distinct subjects.',
        wordOrderRuleDe:
            'Bei gleichem Subjekt in Haupt- und Nebensatz nutzt man „um ... zu + Infinitiv“; bei verschiedenen Subjekten ist „damit“ obligatorisch.',
        pitfallAlertAr:
            'لَا تَسْتَعْمِلْ «um ... zu» عِنْدَ اخْتِلَافِ الْفَاعِلِ بَيْنَ الْجُمْلَتَيْنِ فِي الْأَلْمَانِيَّةِ؛ بَلِ اسْتَعْمِلْ «damit».',
        germanPositionTag: 'um...zu vs. damit',
      ),
      ConnectiveSyntaxTriplet(
        id: 'dc_05',
        relation: DiscourseRelationType.adversativeContrast,
        titleAr: 'التَّبَايُنُ الْمُقَارِنُ: «فِي حِينِ أَنَّ / بَيْنَمَا» مُقَابِلَ «während / hingegen / whereas»',
        titleEn: 'Contrastive "whereas" vs. Temporal/Adversative "während"',
        titleDe: 'Gegenüberstellung: während (NS) vs. hingegen / im Gegensatz dazu',
        subordinatingAr: 'تَبْدَأُ الْجُمْلَةُ الْفِعْلِيَّةُ بِالْفِعْلِ، فِي حِينِ أَنَّ الْجُمْلَةَ الِاسْمِيَّةَ تَبْدَأُ بِالْمُبْتَدَأِ.',
        adverbialOrPrepAr: 'تَعْتَمِدُ الْعَرَبِيَّةُ عَلَى الْإِعْرَابِ، وَعَلَى النَّقِيضِ مِنْ ذَلِكَ تَعْتَمِدُ الْإِنْجِلِيزِيَّةُ عَلَى التَّرْتِيبِ.',
        subordinatingEn: 'Arabic relies heavily on case endings, whereas English relies on strict word order.',
        adverbialOrPrepEn: 'Arabic relies on inflection; by contrast, English relies on word order.',
        subordinatingDe: 'Während das Arabische stark auf Kasusendungen setzt, stützt sich das Englische auf die Wortstellung.',
        adverbialOrPrepDe: 'Das Arabische nutzt Kasusendungen; das Englische hingegen verlässt sich auf die Wortstellung.',
        wordOrderRuleAr:
            'تُفِيدُ «بَيْنَمَا / فِي حِينِ أَنَّ» الْمُقَابَلَةَ بَيْنَ ظَاهِرَتَيْنِ مُتَزَامِنَتَيْنِ أَوْ مُتَبَايِنَتَيْنِ دُونَ تَعَارُضٍ نَفْيِيٍّ.',
        wordOrderRuleEn:
            '"Whereas" and "while" introduce contrastive clauses; "whereas" is strictly adversative and formal.',
        wordOrderRuleDe:
            '„Während“ kann sowohl temporal (gleichzeitig) als auch adversativ (gegenüberstellend) sein und fordert Verbletztstellung.',
        pitfallAlertAr:
            'فِي الْأَلْمَانِيَّةِ احْذَرْ مِنْ تَرْجَمَةِ «whereas» إِلَى «weil»؛ فـ «während» هِيَ الْمُقَابِلُ التَّبَايُنِيُّ الصَّحِيحُ.',
        germanPositionTag: 'Adversativ (während)',
      ),
      ConnectiveSyntaxTriplet(
        id: 'dc_06',
        relation: DiscourseRelationType.additiveElaboration,
        titleAr: 'التَّمَاسُكُ الْإِضَافِيُّ: «عِلَاوَةً عَلَى ذَلِكَ / فَضْلًا عَنْ» مُقَابِلَ «außerdem / zudem»',
        titleEn: 'Additive Cohesion: "Moreover", "Furthermore" & "Darüber hinaus"',
        titleDe: 'Erweiterung: außerdem, zudem, darüber hinaus (Position 1)',
        subordinatingAr: 'يُتْقِنُ الْقِرَاءَةَ الْفَاحِصَةَ، عِلَاوَةً عَلَى أَنَّهُ يُحَرِّرُ النُّصُوصَ بِدِقَّةٍ.',
        adverbialOrPrepAr: 'يُتْقِنُ الْقِرَاءَةَ، وَفَضْلًا عَنْ ذَلِكَ يُحَرِّرُ النُّصُوصَ بِدِقَّةٍ.',
        subordinatingEn: 'He excels at close reading; furthermore, he edits texts with precision.',
        adverbialOrPrepEn: 'In addition to close reading, he edits texts with precision.',
        subordinatingDe: 'Er beherrscht genaues Lesen; darüber hinaus redigiert er Texte sehr präzise.',
        adverbialOrPrepDe: 'Außerdem verfügt er über ein feines Sprachgefühl.',
        wordOrderRuleAr:
            'تَرْبِطُ «عِلَاوَةً عَلَى ذَلِكَ» وَ«فَضْلًا عَنْ» الْأَفْكَارَ الْمُتَّسِقَةَ فِي السِّيَاقِ الْبُرْهَانِيِّ وَتَمْنَعُ تَفَكُّكَ الْفَقْرَةِ.',
        wordOrderRuleEn:
            '"Moreover" and "furthermore" elevate the argumentative weight of the second point.',
        wordOrderRuleDe:
            'Adverbien wie „außerdem“, „zudem“ und „darüber hinaus“ besetzen das Vorfeld (Position 1), sodass das Verb sofort folgt.',
        pitfallAlertAr:
            'بَعْدَ «außerdem» فِي صَدْرِ الْجُمْلَةِ لَا تَضَعْ فَاصِلَةً أَبَدًا فِي الْأَلْمَانِيَّةِ، عَكْسَ «Furthermore,» فِي الْإِنْجِلِيزِيَّةِ.',
        germanPositionTag: 'Kein Komma nach Pos. 1',
      ),
    ];
  }

  List<DiscourseDrillItem> getDrills() {
    return const [
      DiscourseDrillItem(
        id: 'dcd_01',
        relation: DiscourseRelationType.causal,
        targetLanguage: 'German',
        promptAr: 'اخْتَرِ الْجُمْلَةَ الْأَلْمَانِيَّةَ الصَّحِيحَةَ تَرْكِيبًا بَعْدَ أَدَاةِ التَّعْلِيلِ «weil»:',
        promptEn: 'Choose the grammatically accurate German clause with "weil":',
        promptDe: 'Wählen Sie den grammatisch korrekten Satz mit „weil“:',
        options: [
          'Ich lese täglich, weil es erweitert meinen Wortschatz.',
          'Ich lese täglich, weil es meinen Wortschatz erweitert.',
          'Ich lese täglich, weil erweitert es meinen Wortschatz.',
        ],
        correctIndex: 1,
        explanationAr: '«weil» أَدَاةُ رَبْطٍ تَابِعَةٌ تَدْفَعُ الْفِعْلَ الْمُصَرَّفَ (erweitert) إِلَى نِهَايَةِ الْجُمْلَةِ.',
      ),
      DiscourseDrillItem(
        id: 'dcd_02',
        relation: DiscourseRelationType.concessive,
        targetLanguage: 'German',
        promptAr: 'مَا التَّرْتِيبُ الصَّحِيحُ لِلْكَلِمَاتِ بَعْدَ «trotzdem» فِي صَدْرِ الْجُمْلَةِ؟',
        promptEn: 'Select the correct German word order after "trotzdem":',
        promptDe: 'Wählen Sie die korrekte Wortstellung nach „trotzdem“:',
        options: [
          'Der Text war schwer; trotzdem habe ich ihn verstanden.',
          'Der Text war schwer; trotzdem ich habe ihn verstanden.',
          'Der Text war schwer; trotzdem ihn verstanden habe ich.',
        ],
        correctIndex: 0,
        explanationAr: '«trotzdem» ظَرْفُ رَبْطٍ يَقَعُ فِي الْمَوْقِعِ الْأَوَّلِ، فَيَجِبُ أَنْ يَتْلُوَهُ الْفِعْلُ الْمُصَرَّفُ (habe) مُبَاشَرَةً.',
      ),
      DiscourseDrillItem(
        id: 'dcd_03',
        relation: DiscourseRelationType.consecutive,
        targetLanguage: 'English',
        promptAr: 'أَيُّ جُمْلَةٍ إِنْجِلِيزِيَّةٍ تَلْتَزِمُ التَّرْقِيمَ الصَّحِيحَ مَعَ «therefore»؟',
        promptEn: 'Which English sentence punctuates "therefore" without a comma splice?',
        promptDe: 'Welcher englische Satz setzt die Zeichensetzung bei „therefore“ korrekt?',
        options: [
          'He practiced daily, therefore, he improved.',
          'He practiced daily; therefore, he improved.',
          'He practiced daily therefore he improved.',
        ],
        correctIndex: 1,
        explanationAr: '«therefore» ظَرْفُ رَبْطٍ وَلَيْسَ حَرْفَ عَطْفٍ، فَيَلْزَمُ قَبْلَهُ فَاصِلَةٌ مَنْقُوطَةٌ (;) أَوْ نُقْطَةٌ.',
      ),
      DiscourseDrillItem(
        id: 'dcd_04',
        relation: DiscourseRelationType.purposive,
        targetLanguage: 'German',
        promptAr: 'عِنْدَ اخْتِلَافِ الْفَاعِلِ بَيْنَ الْجُمْلَتَيْنِ، أَيُّ رَابِطٍ غَائِيٍّ يَجِبُ اسْتِخْدَامُهُ فِي الْأَلْمَانِيَّةِ؟',
        promptEn: 'Which German purposive connector is mandatory when subjects differ?',
        promptDe: 'Welcher Finalsatz-Konnektor ist bei Subjektwechsel obligatorisch?',
        options: [
          'um ... zu',
          'damit',
          'deshalb',
        ],
        correctIndex: 1,
        explanationAr: 'نَسْتَعْمِلُ «um ... zu» عِنْدَ اتِّحَادِ الْفَاعِلِ، وَ«damit» عِنْدَ اخْتِلَافِ الْفَاعِلِ.',
      ),
      DiscourseDrillItem(
        id: 'dcd_05',
        relation: DiscourseRelationType.adversativeContrast,
        targetLanguage: 'Arabic',
        promptAr: 'أَيُّ أَدَاةٍ عَرَبِيَّةٍ تُؤَدِّي مَعْنَى الْمُقَابَلَةِ التَّبَايُنِيَّةِ (whereas / während) بَيْنَ حَقِيقَتَيْنِ؟',
        promptEn: 'Which Arabic expression corresponds to contrastive "whereas"?',
        promptDe: 'Welcher arabische Ausdruck entspricht dem adversativen „während“?',
        options: [
          'لِأَنَّ',
          'فِي حِينِ أَنَّ / بَيْنَمَا',
          'كَيْ',
        ],
        correctIndex: 1,
        explanationAr: '«فِي حِينِ أَنَّ» وَ«بَيْنَمَا» تَعْقِدَانِ مُقَابَلَةً تَبَايُنِيَّةً بَيْنَ قَضِيَّتَيْنِ.',
      ),
      DiscourseDrillItem(
        id: 'dcd_06',
        relation: DiscourseRelationType.additiveElaboration,
        targetLanguage: 'German',
        promptAr: 'هَلْ تُوضَعُ فَاصِلَةٌ بَعْدَ «Außerdem» فِي بِدَايَةِ الْجُمْلَةِ الْأَلْمَانِيَّةِ؟',
        promptEn: 'Should a comma follow "Außerdem" at the start of a German sentence?',
        promptDe: 'Steht nach „Außerdem“ am Satzanfang ein Komma?',
        options: [
          'نَعَمْ، مِثْلَ Furthermore, فِي الْإِنْجِلِيزِيَّةِ',
          'لَا، يَتْبَعُهَا الْفِعْلُ مُبَاشَرَةً بِدُونِ فَاصِلَةٍ',
          'فَقَطْ إِذَا كَانَتِ الْجُمْلَةُ طَوِيلَةً',
        ],
        correctIndex: 1,
        explanationAr: 'فِي الْأَلْمَانِيَّةِ لَا يُفْصَلُ الْمَوْقِعُ الْأَوَّلُ (Außerdem) عَنِ الْفِعْلِ فِي الْمَوْقِعِ الثَّانِي بِفَاصِلَةٍ.',
      ),
    ];
  }
}
