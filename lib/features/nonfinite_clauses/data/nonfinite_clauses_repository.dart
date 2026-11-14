import '../models/nonfinite_clauses_models.dart';

class NonFiniteClausesRepository {
  const NonFiniteClausesRepository();

  List<NonFiniteLessonUnit> getUnits() {
    return const [
      NonFiniteLessonUnit(
        id: 'nf_01',
        category: NonFiniteCategory.zuInfinitivVsBare,
        titleAr: 'مَوَاضِعُ «zu + Infinitiv» مُقَابِلَ الْمَصْدَرِ الْمُجَرَّدِ وَ«أَنْ + الْمُضَارِعُ»',
        titleEn: 'When German Requires "zu" vs. Bare Infinitive & Arabic "an"',
        titleDe: '„zu + Infinitiv“ (versuchen, hoffen) vs. ohne „zu“ (können, bleiben, gehen)',
        exampleAr: 'أُحَاوِلُ أَنْ أَفْهَمَ الْقَاعِدَةَ، وَأَسْتَطِيعُ أَنْ أُطَبِّقَهَا بِسُهُولَةٍ.',
        exampleEn: 'I try to understand the rule, and I can apply it easily.',
        exampleDe: 'Ich versuche, die Regel zu verstehen, und ich kann sie leicht anwenden.',
        ruleAr:
            'تَسْتَعْمِلُ الْعَرَبِيَّةُ «أَنْ» النَّاصِبَةَ قَبْلَ الْمُضَارِعِ بَعْدَ أَفْعَالِ الْمُحَاوَلَةِ وَالِاسْتِطَاعَةِ وَالرَّجَاءِ عَلَى حَدٍّ سَوَاءٍ.',
        ruleEn:
            'English uses "to" after lexical verbs ("try to understand") and drops "to" after modal auxiliaries ("can apply").',
        ruleDe:
            'Im Deutschen steht „zu“ vor dem Infinitiv am Ende (bei trennbaren Verben dazwischen: „anzuwenden“), entfällt aber nach Modalverben, „gehen“, „bleiben“, „sehen/hören“.',
        clauseTag: 'versuchen ... zu + V',
        pitfallAlertAr:
            'الْخَطَأُ الشَّائِعُ: وَضْعُ «zu» بَعْدَ الْفِعْلِ النَّاقِصِ (*Ich kann zu lesen) أَوْ حَذْفُهَا بَعْدَ «versuchen / beginnen» (*Ich versuche lesen).',
      ),
      NonFiniteLessonUnit(
        id: 'nf_02',
        category: NonFiniteCategory.purposeUmZuVsDamit,
        titleAr: 'جُمْلَةُ الْغَايَةِ: «um ... zu» عِنْدَ اتِّحَادِ الْفَاعِلِ وَ«damit» عِنْدَ اخْتِلَافِهِ',
        titleEn: 'Purpose Subordination: "um...zu" (Same Subject) vs. "damit" (Different Subject)',
        titleDe: 'Finalsätze: „um ... zu“ (gleiches Subjekt) vs. „damit“ (verschiedene Subjekte)',
        exampleAr: 'أُقَدِّمُ الْمِثَالَ بِوُضُوحٍ لِكَيْ يَفْهَمَ الطُّلَّابُ الدَّرْسَ.',
        exampleEn: 'I present the example clearly so that the students understand the lesson.',
        exampleDe: 'Ich erkläre das Beispiel deutlich, damit die Schüler die Lektion verstehen.',
        ruleAr:
            'تُؤَدِّي «لِكَيْ / حَتَّى / لَامُ التَّعْلِيلِ» مَعْنَى الْغَايَةِ فِي الْعَرَبِيَّةِ سَوَاءٌ اتَّحَدَ الْفَاعِلُ أَمِ اخْتَلَفَ.',
        ruleEn:
            'English uses "in order to + V" when the subject matches, and "so that + clause" when introducing a new subject.',
        ruleDe:
            'Sind die Subjekte in Haupt- und Nebensatz identisch, wählt man „um ... zu“; wechseln die Subjekte (ich → die Schüler), ist „damit“ Pflicht.',
        clauseTag: 'um...zu (S1=S2) ↔ damit (S1≠S2)',
        pitfallAlertAr:
            'يُمْنَعُ اسْتِعْمَالُ «um ... zu» إِذَا كَانَ فَاعِلُ الْغَايَةِ مُخْتَلِفًا عَنْ فَاعِلِ الْجُمْلَةِ الْأُولَى؛ تَذَكَّرْ تَطَابُقَ الْفَاعِلَيْنِ قَبْلَ اخْتِيَارِ «um ... zu».',
      ),
      NonFiniteLessonUnit(
        id: 'nf_03',
        category: NonFiniteCategory.withoutInsteadOfZu,
        titleAr: 'التَّرْكِيبُ السَّلْبِيُّ وَالْبَدَلِيُّ: «دُونَ أَنْ / بَدَلًا مِنْ أَنْ» وَ«ohne / statt ... zu»',
        titleEn: '"ohne...zu / statt...zu" vs. English "without / instead of + -ing"',
        titleDe: 'Modale Infinitivgruppen: „ohne ... zu“ & „(an)statt ... zu“ vs. „dass“',
        exampleAr: 'غَادَرَ الْقَاعَةَ دُونَ أَنْ يُسَبِّبَ إِزْعَاجًا، بَدَلًا مِنْ أَنْ يَنْتَظِرَ فِي الْمَمَرِّ.',
        exampleEn: 'He left the hall without causing any disturbance, instead of waiting in the corridor.',
        exampleDe: 'Er verließ den Saal, ohne Lärm zu machen, anstatt im Flur zu warten.',
        ruleAr:
            'تَسْتَعْمِلُ الْعَرَبِيَّةُ «دُونَ أَنْ» وَ«بَدَلًا مِنْ أَنْ» مَتْبُوعَتَيْنِ بِمُضَارِعٍ مَنْصُوبٍ، أَوْ «مِنْ غَيْرِ + مَصْدَرٍ صَرِيحٍ».',
        ruleEn:
            'English prepositions "without" and "instead of" strictly require a gerund ("-ing"), never a "to"-infinitive.',
        ruleDe:
            'Bei Subjektgleichheit nutzt Deutsch „ohne ... zu“ und „(an)statt ... zu“; bei Subjektwechsel stehen „ohne dass“ und „(an)statt dass“.',
        clauseTag: 'ohne...zu ↔ without + -ing',
        pitfallAlertAr:
            'لَا تَقُلْ فِي الْإِنْجِلِيزِيَّةِ *without to say أو *instead of wait؛ بَعْدَ حُرُوفِ الْجَرِّ يَجِبُ اسْتِعْمَالُ «-ing» دَائِمًا.',
      ),
      NonFiniteLessonUnit(
        id: 'nf_04',
        category: NonFiniteCategory.participlePrenominalLinksattribut,
        titleAr: 'تَقْدِيمُ اسْمِ الْفَاعِلِ وَالْمَفْعُولِ الْمُوَسَّعِ فِي الْأَلْمَانِيَّةِ (Linksattribut)',
        titleEn: 'German Left-Branching Participles vs. Right-Branching Arabic & English',
        titleDe: 'Erweitertes Partizip I („der lernende Schüler“) & Partizip II („das gelesene Buch“)',
        exampleAr: 'قَرَأْتُ الرِّسَالَةَ الْمَوْضُوعَةَ عَلَى الطَّاوِلَةِ وَاسْتَمَعْتُ إِلَى الطَّالِبِ الْمُتَحَدِّثِ بِوُضُوحٍ.',
        exampleEn: 'I read the letter placed on the table and listened to the student speaking clearly.',
        exampleDe: 'Ich las den auf dem Tisch liegenden Brief und hörte dem deutlich sprechenden Schüler zu.',
        ruleAr:
            'فِي الْعَرَبِيَّةِ يَتَأَخَّرُ النَّعْتُ الْمُشْتَقُّ (الْمَوْضُوعَةَ عَلَى الطَّاوِلَةِ) بَعْدَ الْمَنْعُوتِ دَائِمًا وَيُطَابِقُهُ إِعْرَابًا وَتَعْرِيفًا.',
        ruleEn:
            'English places multi-word participle phrases AFTER the noun ("the letter placed on the table"), while single participles precede it ("the speaking student").',
        ruleDe:
            'Das Deutsche setzt auch lange Partizipialphrasen VOR das Nomen zwischen Artikel und Substantiv: [Artikel] + [Ergänzungen] + [Partizip + Endung] + [Nomen].',
        clauseTag: 'Linksattribut ↔ نَعْتٌ مُتَأَخِّرٌ',
        pitfallAlertAr:
            'عِنْدَ تَرْجَمَةِ الْأَلْمَانِيَّةِ الْأَكَادِيمِيَّةِ، اِبْدَأْ بِالِاسْمِ بَعْدَ الصِّفَةِ الْمُطَوَّلَةِ ثُمَّ عُدْ لِلْخَلْفِ: «den auf dem Tisch liegenden Brief» = الرِّسَالَةَ الْمَوْضُوعَةَ عَلَى الطَّاوِلَةِ.',
      ),
      NonFiniteLessonUnit(
        id: 'nf_05',
        category: NonFiniteCategory.gerundVsInfinitiveSelection,
        titleAr: 'الْمَصْدَرُ (-ing) مُقَابِلَ (to + V) فِي الْإِنْجِلِيزِيَّةِ وَالْأَلْمَانِيَّةِ',
        titleEn: 'Verb Complement Split: English "-ing" vs. "to V" & German "zu"-Clauses',
        titleDe: 'Englisch „enjoy + -ing“ vs. „decide + to“ / Deutsch fast immer „zu + Infinitiv“',
        exampleAr: 'أَسْتَمْتِعُ بِقِرَاءَةِ الْكُتُبِ النَّافِعَةِ، وَقَرَّرْتُ أَنْ أُدَوِّنَ الْفَوَائِدَ.',
        exampleEn: 'I enjoy reading useful books, and I decided to write down the key points.',
        exampleDe: 'Ich genieße es, nützliche Bücher zu lesen, und habe beschlossen, die wichtigsten Punkte aufzuschreiben.',
        ruleAr:
            'تُؤَدِّي الْعَرَبِيَّةُ الْمَعْنَيَيْنِ بِالْمَصْدَرِ الصَّرِيحِ (بِقِرَاءَةِ) أَوْ بِالْمَصْدَرِ الْمُؤَوَّلِ (أَنْ أُدَوِّنَ) بِمُرُونَةٍ عَالِيَةٍ.',
        ruleEn:
            'English verbs strictly select either a gerund ("enjoy, avoid, suggest, finish + -ing") or an infinitive ("decide, hope, plan, refuse + to V").',
        ruleDe:
            'Das Deutsche kennt kein englisches Gerundium als Verb-Objekt; stattdessen nutzt man meist eine Infinitivgruppe mit „zu“ (oft mit Korrelat „es“).',
        clauseTag: 'enjoy + -ing ↔ zu + Infinitiv',
        pitfallAlertAr:
            'احْذَرْ قَوْلَ *I enjoy to read أو *I suggest to go بِالْإِنْجِلِيزِيَّةِ؛ أَفْعَالُ «enjoy / suggest / avoid / finish» تَلْزَمُ صِيغَةَ «-ing».',
      ),
      NonFiniteLessonUnit(
        id: 'nf_06',
        category: NonFiniteCategory.danglingControlAlignment,
        titleAr: 'رَابِطُ الْفَاعِلِ الْمُضْمَرِ وَتَجَنُّبُ تَعْلِيقِ الْحَالِ (Dangling Participle)',
        titleEn: 'Subject Alignment in Participle & Infinitive Clauses',
        titleDe: 'Gleichheit des Subjekts bei „Beim Betreten...“ und Partizipialsätzen',
        exampleAr: 'عِنْدَ دُخُولِهِ الْقَاعَةَ، أَلْقَى الطَّالِبُ التَّحِيَّةَ عَلَى الْحَاضِرِينَ.',
        exampleEn: 'Entering the hall, the student greeted everyone present.',
        exampleDe: 'Als er den Saal betrat (oder: Den Saal betretend), begrüßte der Student alle Anwesenden.',
        ruleAr:
            'يَجِبُ أَنْ يَعُودَ الضَّمِيرُ فِي الْحَالِ أَوِ الْمَصْدَرِ الْمُقَدَّمِ عَلَى الْفَاعِلِ الصَّرِيحِ فِي الْجُمْلَةِ الرَّئِيسِيَّةِ لِئَلَّا يَفْسُدَ الْمَعْنَى.',
        ruleEn:
            'The grammatical subject immediately following an introductory "-ing" clause must be the logical doer of that "-ing" verb.',
        ruleDe:
            'Auch in deutschen Partizipialkonstruktionen muss das Subjekt des Hauptsatzes der Handelnde des Partizips sein; sonst nutzt man einen „Als/Nachdem“-Nebensatz.',
        clauseTag: 'تَطَابُقُ الْفَاعِلِ • No Dangling',
        pitfallAlertAr:
            'تَجَنَّبْ تَعْلِيقَ الْفَاعِلِ مِثْل *Entering the hall, the door closed (فَالْبَابُ لَمْ يَدْخُلِ الْقَاعَةَ!)؛ الصَّوَابُ «Entering the hall, the student...».',
      ),
    ];
  }

  List<NonFiniteDrillItem> getDrills() {
    return const [
      NonFiniteDrillItem(
        id: 'nf_d1',
        category: NonFiniteCategory.zuInfinitivVsBare,
        targetLanguage: 'DE',
        promptAr: 'أَكْمِلِ الْجُمْلَةَ الْأَلْمَانِيَّةَ الصَّحِيحَةَ بِالْفِعْلِ الْمُنْفَصِلِ «mitbringen» (أَنْ أُحْضِرَ مَعِي):',
        promptEn: 'Complete the German sentence with the separable verb "mitbringen":',
        promptDe: 'Ergänze korrekt: „Ich habe vergessen, das Buch ___.“',
        options: [
          'mitzubringen',
          'zu mitbringen',
          'mitbringen',
        ],
        correctIndex: 0,
        explanationAr:
            'فِي الْأَفْعَالِ الْمُنْفَصِلَةِ تَدْخُلُ «zu» بَيْنَ السَّابِقَةِ وَجَذْرِ الْفِعْلِ فِي كَلِمَةٍ وَاحِدَةٍ: mit + zu + bringen = mitzubringen.',
      ),
      NonFiniteDrillItem(
        id: 'nf_d2',
        category: NonFiniteCategory.purposeUmZuVsDamit,
        targetLanguage: 'DE',
        promptAr: 'اخْتَرْ أَدَاةَ الْغَايَةِ الصَّحِيحَةَ: «Ich spreche langsam, ___ du alles verstehst.» (اخْتِلَافُ الْفَاعِلَيْنِ: ich ≠ du):',
        promptEn: 'Choose the right German purpose connector when subjects differ:',
        promptDe: 'Wähle die richtige Konjunktion bei Subjektwechsel (ich → du):',
        options: [
          'damit',
          'um ... zu',
          'ohne dass',
        ],
        correctIndex: 0,
        explanationAr:
            'بِمَا أَنَّ الْفَاعِلَ فِي الْجُمْلَةِ الْأُولَى (ich) يَخْتَلِفُ عَنِ الثَّانِيَةِ (du)، فَيَجِبُ اسْتِعْمَالُ «damit».',
      ),
      NonFiniteDrillItem(
        id: 'nf_d3',
        category: NonFiniteCategory.withoutInsteadOfZu,
        targetLanguage: 'EN',
        promptAr: 'اخْتَرِ الصِّيغَةَ الْإِنْجِلِيزِيَّةَ السَّلِيمَةَ لِـ «دُونَ أَنْ يَطْلُبَ مُسَاعَدَةً»:',
        promptEn: 'Choose the accurate English construction after "without":',
        promptDe: 'Welche englische Form nach „without“ ist grammatisch korrekt?',
        options: [
          'He solved it without asking for help.',
          'He solved it without to ask for help.',
          'He solved it without ask for help.',
        ],
        correctIndex: 0,
        explanationAr:
            'حَرْفُ الْجَرِّ «without» فِي الْإِنْجِلِيزِيَّةِ يَلْزَمُهُ اسْمُ الْفِعْلِ/الْمَصْدَرُ (-ing) دَائِمًا: without asking.',
      ),
      NonFiniteDrillItem(
        id: 'nf_d4',
        category: NonFiniteCategory.participlePrenominalLinksattribut,
        targetLanguage: 'DE',
        promptAr: 'اخْتَرِ النَّعْتَ الْأَلْمَانِيَّ الصَّحِيحَ لِـ «الطَّالِبُ الْقَارِئُ» (مَفْعُولٌ بِمَعْنَى اسْمِ الْفَاعِلِ، مَرْفُوعٌ):',
        promptEn: 'Choose the active Partizip I modifier for "the reading student":',
        promptDe: 'Welche Form drückt eine aktive, gleichzeitige Handlung aus („der Student, der liest“)?',
        options: [
          'der lesende Student',
          'der gelesene Student',
          'der lesen Student',
        ],
        correctIndex: 0,
        explanationAr:
            'اسْمُ الْفَاعِلِ (Partizip I: lesend) يَدُلُّ عَلَى الْفَاعِلِ الْحَالِيِّ، وَيُصَرَّفُ بَعْدَ «der» بِـ «-e»: der lesende Student.',
      ),
      NonFiniteDrillItem(
        id: 'nf_d5',
        category: NonFiniteCategory.gerundVsInfinitiveSelection,
        targetLanguage: 'EN',
        promptAr: 'أَكْمِلِ الْجُمْلَةَ الْإِنْجِلِيزِيَّةَ: «They avoided ___ the same mistake twice.»',
        promptEn: 'Select the required complement form after "avoid":',
        promptDe: 'Welche Verbform verlangt das englische Verb „avoid“?',
        options: [
          'making',
          'to make',
          'make',
        ],
        correctIndex: 0,
        explanationAr:
            'الْفِعْلُ «avoid» مِنَ الْأَفْعَالِ الَّتِي تَلْزَمُ صِيغَةَ «-ing» حَصْرًا: avoided making.',
      ),
      NonFiniteDrillItem(
        id: 'nf_d6',
        category: NonFiniteCategory.danglingControlAlignment,
        targetLanguage: 'EN',
        promptAr: 'أَيُّ جُمْلَةٍ تَخْلُو مِنْ خَطَإِ تَعْلِيقِ اسْمِ الْفَاعِلِ (Dangling Participle)؟',
        promptEn: 'Identify the sentence with proper subject control (no dangling participle):',
        promptDe: 'Welcher englische Satz hat eine logische Subjektkontrolle?',
        options: [
          'Reviewing the notes carefully, the student noticed a key rule.',
          'Reviewing the notes carefully, a key rule appeared on the page.',
          'Reviewing the notes carefully, the page became clearer.',
        ],
        correctIndex: 0,
        explanationAr:
            'الَّذِي يُرَاجِعُ الْمُلَاحَظَاتِ هُوَ «the student»، لِذَا يَجِبُ أَنْ يَكُونَ «the student» هُوَ فَاعِلَ الْجُمْلَةِ الرَّئِيسِيَّةِ مُبَاشَرَةً.',
      ),
    ];
  }
}
