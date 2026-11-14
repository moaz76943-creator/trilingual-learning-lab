import '../models/causative_valency_models.dart';

class CausativeValencyRepository {
  const CausativeValencyRepository();

  List<CausativeLessonUnit> getUnits() {
    return const [
      CausativeLessonUnit(
        id: 'cv_01',
        category: CausativeCategory.arabicMorphologicalCausative,
        titleAr: 'التَّعْدِيَةُ بِهَمْزَةِ «أَفْعَلَ» وَتَضْعِيفِ «فَعَّلَ» وَأَثَرُهُمَا فِي الْمَفْعُولَيْنِ',
        titleEn: 'Arabic Valency Increase via Afʿala / Faʿʿala vs. Analytical Causatives',
        titleDe: 'Morphologischer Kausativ im Arabischen vs. analytisches „lassen / bringen zu“',
        exampleAr: 'عَلِمَ الطَّالِبُ الْخَبَرَ ← أَعْلَمَ الْمُعَلِّمُ الطَّالِبَ الْخَبَرَ.',
        exampleEn: 'The student learned the news → The teacher informed the student of the news.',
        exampleDe: 'Der Schüler erfuhr die Nachricht → Der Lehrer ließ den Schüler die Nachricht wissen.',
        ruleAr:
            'تَزِيدُ هَمْزَةُ «أَفْعَلَ» وَتَضْعِيفُ «فَعَّلَ» مَفْعُولًا جَدِيدًا؛ فَاللَّازِمُ يَصِيرُ مُتَعَدِّيًا لِوَاحِدٍ (فَرِحَ ← أَفْرَحَ)، وَالْمُتَعَدِّي لِوَاحِدٍ يَصِيرُ مُتَعَدِّيًا لِاثْنَيْنِ (عَلِمَ ← أَعْلَمَ / عَلَّمَ).',
        ruleEn:
            'English rarely uses productive causative prefixes today, relying instead on lexical verbs ("inform", "teach") or "make/have + object + verb".',
        ruleDe:
            'Während das Arabische Verben morphologisch transitiviert, nutzt das Deutsche oft „lassen + Infinitiv“ oder eigene kausative Verben.',
        valencyTag: 'أَفْعَلَ / فَعَّلَ (+١ مفعول)',
        pitfallAlertAr:
            'احْذَرْ نِسْيَانَ نَصْبِ الْمَفْعُولَيْنِ بَعْدَ «أَعْلَمَ / عَلَّمَ»: الْمَفْعُولُ الْأَوَّلُ هُوَ الْفَاعِلُ الْأَصْلِيُّ، وَالثَّانِي هُوَ مَفْعُولُ الْجُمْلَةِ الْأُولَى.',
      ),
      CausativeLessonUnit(
        id: 'cv_02',
        category: CausativeCategory.germanLassenDualUse,
        titleAr: 'الْفِعْلُ الْأَلْمَانِيُّ «lassen» بَيْنَ السَّمَاحِ وَالتَّكْلِيفِ وَصِيغَةِ Perfekt',
        titleEn: 'German "lassen" (Allow vs. Cause) & Double Infinitive in Perfekt',
        titleDe: '„lassen + Infinitiv“ & Ersatzinfinitiv im Perfekt (hat ... reparieren lassen)',
        exampleAr: 'تَرَكَ الْأُسْتَاذُ الطَّالِبَ يَتَحَدَّثُ، وَأَصْلَحَ الْمِصْبَاحَ عِنْدَ الْفَنِّيِّ.',
        exampleEn: 'The professor let the student speak, and had the lamp repaired by the technician.',
        exampleDe: 'Der Professor ließ den Studenten sprechen; er hat die Lampe reparieren lassen.',
        ruleAr:
            'يُعَبِّرُ سِيَاقُ الْجُمْلَةِ فِي الْعَرَبِيَّةِ عَنِ الْفَرْقِ بَيْنَ الْإِذْنِ (سَمَحَ لَهُ بِـ) وَالتَّكْلِيفِ (أَمَرَ / أَوْكَلَ إِلَى غَيْرِهِ).',
        ruleEn:
            'English separates permissive "let someone do" from commissioned "have someone do / have something done".',
        ruleDe:
            'Steht „lassen“ im Perfekt zusammen mit einem Vollverb im Infinitiv, verwendet man den Ersatzinfinitiv „lassen“ (nicht *gelassen): „Er hat das Buch drucken lassen“.',
        valencyTag: 'hat + Inf. + lassen',
        pitfallAlertAr:
            'الْخَطَأُ الشَّائِعُ فِي الْأَلْمَانِيَّةِ: قَوْلُ *Er hat das Gerät reparieren gelassen؛ الصَّوَابُ دَائِمًا «reparieren lassen» بِصِيغَةِ الْمَصْدَرِ الْمُزْدَوَجِ.',
      ),
      CausativeLessonUnit(
        id: 'cv_03',
        category: CausativeCategory.englishCausativeVerbs,
        titleAr: 'سَبَبِيَّةُ (make / have / get) فِي الْإِنْجِلِيزِيَّةِ وَضَبْطُ «to»',
        titleEn: 'English Causative Ladder: Force (make), Assign (have), Persuade (get)',
        titleDe: 'Abstufung der englischen Kausativa im Vergleich zu „lassen / veranlassen“',
        exampleAr: 'جَعَلَ الْمُدَرِّبُ الطُّلَّابَ يُعِيدُونَ الصِّيَاغَةَ، وَأَقْنَعَ زَمِيلَهُ بِمُرَاجَعَةِ النَّصِّ.',
        exampleEn: 'The coach made the students rewrite the draft and got his colleague to review the text.',
        exampleDe: 'Der Trainer ließ die Schüler den Entwurf neu schreiben und brachte seinen Kollegen dazu, den Text zu prüfen.',
        ruleAr:
            'تُسْتَعْمَلُ «جَعَلَ» أَوْ «حَمَلَ عَلَى» فِي الْعَرَبِيَّةِ لِإِظْهَارِ التَّأْثِيرِ الْمُبَاشِرِ مَعَ جُمْلَةٍ فِعْلِيَّةٍ مَنْصُوبَةٍ أَوْ مَصْدَرٍ مُؤَوَّلٍ.',
        ruleEn:
            'Active "make", "have", and "let" take a BARE infinitive ("made him rewrite"), whereas active "get" requires a "to"-infinitive ("got him to review").',
        ruleDe:
            'Während Englisch zwischen „make“ (Zwang), „have“ (Auftrag) und „get ... to“ (Überredung) unterscheidet, bündelt Deutsch dies oft mit „lassen“ oder „dazu bringen“.',
        valencyTag: 'make + V • get + to V',
        pitfallAlertAr:
            'لَا تَضَعْ «to» بَعْدَ «make» أَوْ «let» فِي الْمَبْنِيِّ لِلْمَعْلُومِ (*made him to write خَطَأٌ)، لَكِنَّ «to» تَعُودُ إِذَا بُنِيَتِ الْجُمْلَةُ لِلْمَجْهُولِ (was made to write).',
      ),
      CausativeLessonUnit(
        id: 'cv_04',
        category: CausativeCategory.factitivePosturePairs,
        titleAr: 'أَزْوَاجُ التَّسْبِيبِ وَالثَّبَاتِ: stellen/stehen وَlegen/liegen وَlay/lie',
        titleEn: 'Causative-Transitive vs. Stative-Intransitive Verb Pairs',
        titleDe: 'Transitiv (+ Akkusativ) vs. Intransitiv (+ Dativ): legen/liegen, stellen/stehen',
        exampleAr: 'وَضَعْتُ الْكِتَابَ عَلَى الطَّاوِلَةِ، فَالْكِتَابُ مَوْضُوعٌ عَلَى الطَّاوِلَةِ.',
        exampleEn: 'I laid the book on the table, so now the book is lying on the table.',
        exampleDe: 'Ich lege das Buch auf den Tisch (Wohin? Akk.); jetzt liegt das Buch auf dem Tisch (Wo? Dat.).',
        ruleAr:
            'تُفَرِّقُ الْعَرَبِيَّةُ بَيْنَ الْفِعْلِ الْمُتَعَدِّي (وَضَعَ، أَقَامَ، أَجْلَسَ) وَاسْمِ الْمَفْعُولِ أَوِ اللَّازِمِ (وُضِعَ، قَامَ، جَلَسَ).',
        ruleEn:
            'English distinguishes transitive "lay / set / raise" from intransitive "lie / sit / rise" (often confused in past tense: lay vs. laid).',
        ruleDe:
            'Schwach konjugierte Kausativa (legen, stellen, setzen + Akk.) beantworten „Wohin?“, starke Intransitiva (liegen, stehen, sitzen + Dat.) beantworten „Wo?“.',
        valencyTag: 'stellen (Akk) ↔ stehen (Dat)',
        pitfallAlertAr:
            'فَخٌّ مُزْدَوَجٌ: فِي الْإِنْجِلِيزِيَّةِ مَاضِي «lie» (يَسْتَلْقِي/يَقَعُ) هُوَ «lay»، أَمَّا «lay» (يَضَعُ) فَمَاضِيهِ «laid»! وَفِي الْأَلْمَانِيَّةِ «legte» مُتَعَدٍّ وَ«lag» لَازِمٌ.',
      ),
      CausativeLessonUnit(
        id: 'cv_05',
        category: CausativeCategory.delegatedPassiveCausative,
        titleAr: 'التَّكْلِيفُ الْمَبْنِيُّ لِلْمَفْعُولِ (have/get something done ↔ etwas machen lassen)',
        titleEn: 'Delegated Passive Causative Without Naming the Performer',
        titleDe: 'Objekt + Infinitiv + lassen („Ich lasse den Text übersetzen“)',
        exampleAr: 'طَلَبْتُ تَرْجَمَةَ الْمَقَالِ (وَكَّلْتُ مَنْ يُتَرْجِمُ الْمَقَالَ).',
        exampleEn: 'I had the article translated (I got the article translated).',
        exampleDe: 'Ich habe den Artikel übersetzen lassen.',
        ruleAr:
            'تُؤَدِّي الْعَرَبِيَّةُ هَذَا الْمَعْنَى بِأَفْعَالِ الطَّلَبِ وَالتَّفْوِيضِ مَعَ الْمَصْدَرِ (طَلَبْتُ طِبَاعَتَهُ، أَمَرْتُ بِتَرْجَمَتِهِ) لِأَنَّ الْفَاعِلَ لَمْ يُبَاشِرْهُ بِنَفْسِهِ.',
        ruleEn:
            'English uses "have/get + object + past participle (V3)" to show a service performed for you by someone else.',
        ruleDe:
            'Im Deutschen genügt „Objekt + Infinitiv + lassen“ ohne Passivpartizip: „Ich lasse die Schuhe reparieren“ (nicht *repariert lassen).',
        valencyTag: 'have + O + V3 ↔ O + Inf. + lassen',
        pitfallAlertAr:
            'لَا تَسْتَعْمِلْ اسْمَ الْمَفْعُولِ (Partizip II) مَعَ «lassen» فِي الْأَلْمَانِيَّةِ (*Ich lasse den Text übersetzt خَطَأٌ)؛ الصَّوَابُ الْمَصْدَرُ: «übersetzen lassen».',
      ),
      CausativeLessonUnit(
        id: 'cv_06',
        category: CausativeCategory.benefactiveDativeInterest,
        titleAr: 'ضَمِيرُ الِانْتِفَاعِ وَالْإِحْسَانِ (Dativus Commodi) بَيْنَ اللُّغَاتِ الثَّلَاثِ',
        titleEn: 'Benefactive Dative & "for"-Constructions in Requests & Services',
        titleDe: 'Dativus Commodi („Ich mache dir Kaffee“) & reflexiver Dativ („Ich lasse mir Zeit“)',
        exampleAr: 'أَعْدَدْتُ لَكَ كُوبًا مِنَ الشَّايِ، وَأَخَذْتُ لِنَفْسِي وَقْتًا لِلْمُرَاجَعَةِ.',
        exampleEn: 'I made you a cup of tea (made a cup of tea for you) and gave myself time to review.',
        exampleDe: 'Ich habe dir eine Tasse Tee gekocht und mir Zeit zum Wiederholen gelassen.',
        ruleAr:
            'تُظْهِرُ الْعَرَبِيَّةُ الْمُسْتَفِيدَ بِحَرْفِ اللَّامِ (أَعْدَدْتُ لَكَ، اشْتَرَيْتُ لِأَخِي) مَعَ وُضُوحِ التَّفْرِيقِ بَيْنَ الْمِلْكِ وَالنَّفْعِ.',
        ruleEn:
            'English expresses the beneficiary either as an indirect object before the direct object ("make you tea") or with "for" ("make tea for you").',
        ruleDe:
            'Der Dativus Commodi nennt die Person, zu deren Vorteil etwas geschieht („Ich trage dir die Tasche“ = für dich).',
        valencyTag: 'لَكَ ↔ dir / for you',
        pitfallAlertAr:
            'فِي الْإِنْجِلِيزِيَّةِ تَقْبَلُ أَفْعَالُ الصُّنْعِ (make, buy, cook) حَرْفَ «for» وَلَيْسَ «to» عِنْدَ تَأْخِيرِ الْمُسْتَفِيدِ (*cook tea to you خَطَأٌ؛ الصَّوَابُ «for you»).',
      ),
    ];
  }

  List<CausativeDrillItem> getDrills() {
    return const [
      CausativeDrillItem(
        id: 'cv_d1',
        category: CausativeCategory.arabicMorphologicalCausative,
        targetLanguage: 'AR',
        promptAr: 'حَوِّلِ الْجُمْلَةَ التَّالِيَةَ إِلَى التَّعْدِيَةِ بِالْهَمْزَةِ: «فَهِمَ الطَّالِبُ الْمَسْأَلَةَ» (المُعَلِّمُ هُوَ الْفَاعِلُ):',
        promptEn: 'Convert the sentence to an Arabic causative with Afʿala / Faʿʿala:',
        promptDe: 'Wähle die korrekte arabische Kausativ-Transformation:',
        options: [
          'أَفْهَمَ الْمُعَلِّمُ الطَّالِبَ الْمَسْأَلَةَ',
          'أَفْهَمَ الْمُعَلِّمُ الطَّالِبُ الْمَسْأَلَةُ',
          'فَهِمَ الْمُعَلِّمُ الطَّالِبَ الْمَسْأَلَةَ',
        ],
        correctIndex: 0,
        explanationAr:
            'بِإِدْخَالِ هَمْزَةِ التَّعْدِيَةِ (أَفْهَمَ) يَصِيرُ «الْمُعَلِّمُ» فَاعِلًا مَرْفُوعًا، وَيُنْصَبُ «الطَّالِبَ» مَفْعُولًا أَوَّلَ وَ«الْمَسْأَلَةَ» مَفْعُولًا ثَانِيًا.',
      ),
      CausativeDrillItem(
        id: 'cv_d2',
        category: CausativeCategory.germanLassenDualUse,
        targetLanguage: 'DE',
        promptAr: 'اخْتَرِ الصِّيغَةَ الْأَلْمَانِيَّةَ السَّلِيمَةَ فِي زَمَنِ Perfekt لِـ «لَقَدْ أَصْلَحَ الْحَاسُوبَ عِنْدَ الْمُخْتَصِّ»:',
        promptEn: 'Choose the grammatically correct German Perfekt with "lassen":',
        promptDe: 'Welche Perfekt-Form mit „lassen“ ist grammatisch korrekt?',
        options: [
          'Er hat den Computer reparieren lassen.',
          'Er hat den Computer reparieren gelassen.',
          'Er hat den Computer repariert lassen.',
        ],
        correctIndex: 0,
        explanationAr:
            'عِنْدَ اجْتِمَاعِ «lassen» مَعَ مَصْدَرٍ آخَرَ فِي زَمَنِ Perfekt يَلْزَمُ اسْتِعْمَالُ الْمَصْدَرِ الْمُزْدَوَجِ (Ersatzinfinitiv): «reparieren lassen».',
      ),
      CausativeDrillItem(
        id: 'cv_d3',
        category: CausativeCategory.englishCausativeVerbs,
        targetLanguage: 'EN',
        promptAr: 'أَكْمِلِ الْجُمْلَةَ الْإِنْجِلِيزِيَّةَ: «The teacher ___ the students summarize the chapter.»',
        promptEn: 'Complete the English causative sentence accurately:',
        promptDe: 'Ergänze den englischen Kausativsatz korrekt:',
        options: [
          'had',
          'got',
          'asked',
        ],
        correctIndex: 0,
        explanationAr:
            'بِمَا أَنَّ الْفِعْلَ «summarize» جَاءَ مَصْدَرًا مُجَرَّدًا بِدُونِ «to»، فَإِنَّ «had» (أَوْ made) هِيَ الصَّحِيحَةُ، أَمَّا «got» وَ«asked» فَتَتَطَلَّبَانِ «to summarize».',
      ),
      CausativeDrillItem(
        id: 'cv_d4',
        category: CausativeCategory.factitivePosturePairs,
        targetLanguage: 'DE',
        promptAr: 'اخْتَرِ الْفِعْلَ وَالْحَالَةَ الصَّحِيحَةَ لِـ «أَضَعُ الدَّفْتَرَ عَلَى الْمَكْتَبِ» (حَرَكَةٌ ← Wohin?):',
        promptEn: 'Choose the correct German transitive verb and case for placing the notebook on the desk:',
        promptDe: 'Wähle das richtige Verb und den richtigen Kasus („Wohin?“):',
        options: [
          'Ich lege das Heft auf den Schreibtisch.',
          'Ich liege das Heft auf dem Schreibtisch.',
          'Ich lege das Heft auf dem Schreibtisch.',
        ],
        correctIndex: 0,
        explanationAr:
            'الْفِعْلُ الْمُتَعَدِّي هُوَ «legen» (يَضَعُ أُفُقِيًّا)، وَيُجِيبُ عَنْ «Wohin?» فَيَأْخُذُ مَفْعُولًا مَنْصُوبًا بَعْدَ «auf»: auf den Schreibtisch.',
      ),
      CausativeDrillItem(
        id: 'cv_d5',
        category: CausativeCategory.delegatedPassiveCausative,
        targetLanguage: 'EN',
        promptAr: 'تَرْجِمْ «طَبَعْتُ الْكُتَيِّبَ فِي الْمَطْبَعَةِ (بِوَاسِطَةِ غَيْرِي)» إِلَى الْإِنْجِلِيزِيَّةِ:',
        promptEn: 'Choose the accurate passive causative in English:',
        promptDe: 'Welche englische Form entspricht „Ich habe das Heft drucken lassen“?',
        options: [
          'I had the booklet printed.',
          'I had the booklet print.',
          'I made the booklet printed.',
        ],
        correctIndex: 0,
        explanationAr:
            'فِي السَّبَبِيَّةِ غَيْرِ الْمُبَاشِرَةِ نَسْتَعْمِلُ «have/get + Object + Past Participle (V3)»: I had the booklet printed.',
      ),
      CausativeDrillItem(
        id: 'cv_d6',
        category: CausativeCategory.benefactiveDativeInterest,
        targetLanguage: 'EN',
        promptAr: 'اخْتَرِ الْجُمْلَةَ الْإِنْجِلِيزِيَّةَ السَّلِيمَةَ لِـ «أَعْدَدْتُ لَكَ مُلَخَّصًا مُفِيدًا»:',
        promptEn: 'Choose the grammatically correct English benefactive preposition:',
        promptDe: 'Welche englische Präposition ist beim Benefaktiv korrekt?',
        options: [
          'I prepared a useful summary for you.',
          'I prepared a useful summary to you.',
          'I prepared for you a useful summary.',
        ],
        correctIndex: 0,
        explanationAr:
            'أَفْعَالُ الْإِعْدَادِ وَالصُّنْعِ (prepare, make, buy) تَأْخُذُ حَرْفَ الْجَرِّ «for» عِنْدَ تَأْخِيرِ الْمُسْتَفِيدِ: prepared ... for you.',
      ),
    ];
  }
}
