import '../models/modal_verbs_models.dart';

class ModalVerbsRepository {
  const ModalVerbsRepository();

  List<ModalContrastUnit> getUnits() {
    return const [
      ModalContrastUnit(
        id: 'mv_01',
        axis: ModalAxisCategory.deonticVsEpistemic,
        titleAr: 'التَّمِييزُ بَيْنَ الْوُجُوبِ التَّكْلِيفِيِّ وَالِاسْتِنْتَاجِ الْيَقِينِيِّ',
        titleEn: 'Deontic "must" (Obligation) vs. Epistemic "must" (Deduction)',
        titleDe: 'Objektive Pflicht vs. subjektive Schlussfolgerung (müssen / dürfte)',
        deonticOrBaseAr: 'يَجِبُ عَلَى الْبَاحِثِ أَنْ يُوَثِّقَ كُلَّ مَصْدَرٍ (وُجُوبٌ).',
        epistemicOrContrastAr: 'لَا بُدَّ أَنَّهُ فِي الْمَكْتَبَةِ؛ فَمِصْبَاحُهُ مُضَاءٌ (اسْتِنْتَاجٌ).',
        deonticOrBaseEn: 'The researcher must cite every source (obligation).',
        epistemicOrContrastEn: 'He must be in the library; his lamp is on (logical deduction).',
        deonticOrBaseDe: 'Der Forscher muss jede Quelle belegen. (Pflicht)',
        epistemicOrContrastDe: 'Er muss in der Bibliothek sein; sein Licht brennt. (Vermutung)',
        ruleAr:
            'فِي الْعَرَبِيَّةِ نُفَرِّقُ بِالْأَدَاةِ: «يَجِبُ أَنْ» لِلْإِلْزَامِ، وَ«لَا بُدَّ أَنَّ» أَوْ «يُحْتَمَلُ» لِلِاسْتِنْتَاجِ، بَيْنَمَا تَسْتَعْمِلُ الْإِنْجِلِيزِيَّةُ وَالْأَلْمَانِيَّةُ الْفِعْلَ نَفْسَهُ.',
        ruleEn:
            'Epistemic "must" expresses near-certain inference from evidence and negates with "can’t" ("He can’t be there"), not "mustn’t".',
        ruleDe:
            'Im Deutschen drückt „er muss sein“ hohe Sicherheit aus; für mittlere Wahrscheinlichkeit nutzt man Konjunktiv II: „er dürfte sein“.',
        trapAlertAr:
            'نَفْيُ الِاسْتِنْتَاجِ «must be» فِي الْإِنْجِلِيزِيَّةِ هُوَ «can’t be» وَلَيْسَ *mustn’t be.',
        modalTag: 'müssen / dürfte',
      ),
      ModalContrastUnit(
        id: 'mv_02',
        axis: ModalAxisCategory.negationAsymmetry,
        titleAr: 'الْفَرْقُ الْحَاسِمُ بَيْنَ الْمَنْعِ (darf nicht) وَانْتِفَاءِ اللُّزُومِ (muss nicht)',
        titleEn: 'Prohibition ("must not") vs. No Obligation ("don’t have to")',
        titleDe: 'Verbot (darf nicht) vs. fehlende Notwendigkeit (braucht nicht zu)',
        deonticOrBaseAr: 'لَا يَجُوزُ نَقْلُ الْكَلَامِ بِغَيْرِ تَثَبُّتٍ (مَنْعٌ وَحَظْرٌ).',
        epistemicOrContrastAr: 'لَا يَلْزَمُكَ حِفْظُ النَّصِّ حَرْفِيًّا (عَدَمُ وُجُوبٍ).',
        deonticOrBaseEn: 'You must not report speech without verification (prohibition).',
        epistemicOrContrastEn: 'You do not have to memorize the text word for word (no obligation).',
        deonticOrBaseDe: 'Man darf Aussagen nicht ungeprüft weitergeben. (Verbot)',
        epistemicOrContrastDe: 'Du musst den Text nicht wörtlich lernen / Du brauchst ihn nicht zu lernen.',
        ruleAr:
            '«لَا يَجُوزُ» تَمْنَعُ الْفِعْلَ، وَ«لَا يَلْزَمُ» تَرْفَعُ الْحَرَجَ وَالْإِلْزَامَ وَتُخَيِّرُ الْمُخَاطَبَ.',
        ruleEn:
            '"Must not" forbids the action; "do not have to / needn’t" removes the requirement.',
        ruleDe:
            'Die Verneinung von „müssen“ lautet „nicht müssen“ oder eleganter „nicht brauchen + zu + Infinitiv“; „nicht dürfen“ bedeutet striktes Verbot.',
        trapAlertAr:
            'أَشْهَرُ خَطَأٍ بَيْنَ الْإِنْجِلِيزِيَّةِ وَالْأَلْمَانِيَّةِ: تَرْجَمَةُ «You must not» إِلَى *Du musst nicht؛ وَالصَّوَابُ «Du darfst nicht».',
        modalTag: 'darf nicht ≠ muss nicht',
      ),
      ModalContrastUnit(
        id: 'mv_03',
        axis: ModalAxisCategory.permissionVsAbility,
        titleAr: 'الِاسْتِطَاعَةُ الْمَهَارِيَّةُ (können) مُقَابِلَ الْإِذْنِ وَالتَّرْخِيصِ (dürfen)',
        titleEn: 'Ability ("can / be able to") vs. Permission ("may / be allowed to")',
        titleDe: 'Fähigkeit/Möglichkeit (können) vs. Berechtigung (dürfen)',
        deonticOrBaseAr: 'يَسْتَطِيعُ الطَّالِبُ قِرَاءَةَ الْمَخْطُوطَاتِ (قُدْرَةٌ وَمَهَارَةٌ).',
        epistemicOrContrastAr: 'يَجُوزُ لِلزَّائِرِ اسْتِعَارَةُ ثَلَاثَةِ كُتُبٍ (إِذْنٌ نِظَامِيٌّ).',
        deonticOrBaseEn: 'The student can read manuscripts (skill/ability).',
        epistemicOrContrastEn: 'A visitor may borrow three books (official permission).',
        deonticOrBaseDe: 'Der Student kann Handschriften lesen. (Fähigkeit)',
        epistemicOrContrastDe: 'Ein Besucher darf drei Bücher ausleihen. (Erlaubnis)',
        ruleAr:
            'تُفَرِّقُ الْعَرَبِيَّةُ وَالْأَلْمَانِيَّةُ بِوُضُوحٍ بَيْنَ «يَسْتَطِيعُ / können» لِلْقُدْرَةِ وَ«يَجُوزُ / dürfen» لِلْإِذْنِ.',
        ruleEn:
            'Informal English often uses "can" for both, whereas formal English reserves "may" for permission.',
        ruleDe:
            'Im Deutschen ist die Trennung streng: „Darf ich hier sitzen?“ (Erlaubnis) vs. „Kann ich das lösen?“ (Fähigkeit).',
        trapAlertAr:
            'عِنْدَ طَلَبِ الْإِذْنِ فِي الْمَوَاقِفِ الرَّسْمِيَّةِ بِالْأَلْمَانِيَّةِ اسْتَعْمِلْ «Darf ich...?» لَا «Kann ich...?».',
        modalTag: 'können vs. dürfen',
      ),
      ModalContrastUnit(
        id: 'mv_04',
        axis: ModalAxisCategory.evidentialModals,
        titleAr: 'الْإِسْنَادُ التَّضْعِيفِيُّ: «يُقَالُ إِنَّهُ» (sollen) وَ«يَدَّعِي أَنَّهُ» (wollen)',
        titleEn: 'Epistemic Hearsay ("is said to") vs. Self-Claim ("claims to")',
        titleDe: 'Evidenzielle Modalverben: sollen (Fremdbehauptung) vs. wollen (Eigenbehauptung)',
        deonticOrBaseAr: 'يُقَالُ إِنَّ الْمَعْهَدَ أَعَدَّ مَنْهَجًا جَدِيدًا (نَقْلٌ عَنِ الْغَيْرِ).',
        epistemicOrContrastAr: 'يَزْعُمُ الْكَاتِبُ أَنَّهُ رَاجَعَ النُّسَخَ كُلَّهَا (ادِّعَاءُ الْمُتَحَدِّثِ عَنْ نَفْسِهِ).',
        deonticOrBaseEn: 'The institute is said to have prepared a new curriculum.',
        epistemicOrContrastEn: 'The writer claims to have reviewed all copies himself.',
        deonticOrBaseDe: 'Das Institut soll ein neues Curriculum entwickelt haben.',
        epistemicOrContrastDe: 'Der Verfasser will alle Handschriften selbst geprüft haben.',
        ruleAr:
            'يُنْسَبُ الْخَبَرُ فِي «sollen» إِلَى رِوَايَةٍ خَارِجِيَّةٍ (يُقَالُ)، وَفِي «wollen» إِلَى دَعْوَى صَاحِبِهِ مَعَ شَكِّ النَّاقِلِ (يَزْعُمُ).',
        ruleEn:
            'English conveys this distinction lexically via "is said/reported to" vs. "claims/purports to".',
        ruleDe:
            'Mit Infinitiv Perfekt („entwickelt haben“) drücken „sollen“ (Gerücht/Bericht) und „wollen“ (skeptische Wiedergabe einer Eigenbehauptung) Distanz aus.',
        trapAlertAr:
            '«Er will das gesehen haben» لَا تَعْنِي «يُرِيدُ أَنْ يَرَى»؛ بَلْ تَعْنِي «يَزْعُمُ أَنَّهُ رَأَى ذَلِكَ».',
        modalTag: 'sollen / wollen (Evidenziell)',
      ),
      ModalContrastUnit(
        id: 'mv_05',
        axis: ModalAxisCategory.pastCounterfactualModals,
        titleAr: 'الْمَاضِي الشَّرْطِيُّ لِلْأَفْعَالِ النَّاقِصَةِ: «كَانَ يَنْبَغِي أَنْ» وَالْمَصْدَرُ الْمُزْدَوَجُ',
        titleEn: 'Past Unfulfilled Obligation ("should have") & German Ersatzinfinitiv',
        titleDe: 'Irrealis der Vergangenheit: hätte + Infinitiv + Modalverb-Infinitiv',
        deonticOrBaseAr: 'كَانَ يَنْبَغِي أَنْ يُرَاجِعَ الطَّالِبُ الْإِجَابَاتِ قَبْلَ التَّسْلِيمِ.',
        epistemicOrContrastAr: 'كَانَ بِإِمْكَانِهِ أَنْ يَتَجَنَّبَ الْخَطَأَ لَوْ تَأَنَّى.',
        deonticOrBaseEn: 'The student should have reviewed the answers before submitting.',
        epistemicOrContrastEn: 'He could have avoided the mistake if he had been careful.',
        deonticOrBaseDe: 'Der Student hätte die Antworten vor der Abgabe prüfen sollen.',
        epistemicOrContrastDe: 'Er hätte den Fehler vermeiden können, wenn er sorgfältiger gewesen wäre.',
        ruleAr:
            'يَدْخُلُ «كَانَ» عَلَى «يَنْبَغِي» أَوْ «يُمْكِنُ» لِلْإِشَارَةِ إِلَى تَفْوِيتِ الْفِعْلِ فِي الْمَاضِي، وَفِي الْأَلْمَانِيَّةِ يَجْتَمِعُ مَصْدَرَانِ فِي نِهَايَةِ الْجُمْلَةِ.',
        ruleEn:
            'English forms past counterfactual modals with "modal + have + past participle".',
        ruleDe:
            'Wenn ein Modalverb im Perfekt oder Konjunktiv II Plusquamperfekt mit einem Vollverb steht, verwendet man den Ersatzinfinitiv („hätte prüfen sollen“, nicht *gesollt).',
        trapAlertAr:
            'فِي الْأَلْمَانِيَّةِ عِنْدَ وُجُودِ جُمْلَةٍ تَابِعَةٍ مَعَ «dass»، يَتَقَدَّمُ «hätte» قَبْلَ الْمَصْدَرَيْنِ: «dass er es hätte prüfen sollen».',
        modalTag: 'hätte ... sollen / können',
      ),
      ModalContrastUnit(
        id: 'mv_06',
        axis: ModalAxisCategory.politeVolition,
        titleAr: 'التَّلَطُّفُ فِي الطَّلَبِ وَالرَّغْبَةِ: «أَوَدُّ / هَلْ تَتَفَضَّلُ»',
        titleEn: 'Mitigated Volition & Polite Requests',
        titleDe: 'Höflichkeit durch Konjunktiv II: möchten, könnten, dürften',
        deonticOrBaseAr: 'أَوَدُّ الِاطِّلَاعَ عَلَى الْمَعْجَمِ التَّارِيخِيِّ، مِنْ فَضْلِكَ.',
        epistemicOrContrastAr: 'هَلْ يُمْكِنُكَ أَنْ تُوَضِّحَ هَذِهِ النُّقْطَةَ، لَوْ تَكَرَّمْتَ؟',
        deonticOrBaseEn: 'I would like to consult the historical dictionary, please.',
        epistemicOrContrastEn: 'Could you clarify this point, please?',
        deonticOrBaseDe: 'Ich möchte gern das historische Wörterbuch einsehen, bitte.',
        epistemicOrContrastDe: 'Könnten Sie diesen Punkt bitte näher erläutern?',
        ruleAr:
            'تَسْتَبْدِلُ اللُّغَاتُ الثَّلَاثُ الصِّيغَةَ الْمُبَاشِرَةَ «أُرِيدُ / I want / ich will» بِصِيَغِ التَّمَنِّي وَالِاسْتِفْهَامِ التَّهْذِيبِيِّ.',
        ruleEn:
            '"Would like" and past-tense modals ("could", "would") create social distance and politeness.',
        ruleDe:
            '„Ich will“ wirkt gegenüber Fremden schroff; Konjunktiv II („ich möchte“, „könnten Sie“, „dürfte ich“) ist der Standard der Höflichkeit.',
        trapAlertAr:
            'تَجَنَّبِ اسْتِخْدَامَ «Ich will» عِنْدَ الطَّلَبِ فِي الْمَقَاهِي أَوِ الْمُؤَسَّسَاتِ، وَاسْتَعْمِلْ «Ich möchte» أَوْ «Ich hätte gern».',
        modalTag: 'möchten / könnten Sie',
      ),
    ];
  }

  List<ModalDrillQuestion> getDrills() {
    return const [
      ModalDrillQuestion(
        id: 'mvd_01',
        axis: ModalAxisCategory.deonticVsEpistemic,
        targetLanguage: 'English',
        promptAr: 'مَا النَّفْيُ الصَّحِيحُ لِلِاسْتِنْتَاجِ الْعَقْلِيِّ: «He must be at home»؟',
        promptEn: 'What is the logical opposite (impossibility) of epistemic "He must be at home"?',
        promptDe: 'Was ist die logische Verneinung von „He must be at home“?',
        options: [
          'He mustn’t be at home.',
          'He can’t be at home.',
          'He doesn’t have to be at home.',
        ],
        correctIndex: 1,
        explanationAr: 'نَفْيُ الِاسْتِنْتَاجِ الْيَقِينِيِّ هُوَ «can’t be» (يَسْتَحِيلُ أَنْ يَكُونَ)، أَمَّا «mustn’t» فَلِلْمَنْعِ التَّكْلِيفِيِّ.',
      ),
      ModalDrillQuestion(
        id: 'mvd_02',
        axis: ModalAxisCategory.negationAsymmetry,
        targetLanguage: 'German',
        promptAr: 'كَيْفَ نُعَبِّرُ بِالْأَلْمَانِيَّةِ عَنْ «لَا يَلْزَمُكَ أَنْ تَأْتِيَ غَدًا» (عَدَمُ الضَّرُورَةِ)؟',
        promptEn: 'How do you express "You do not have to come tomorrow" in German?',
        promptDe: 'Wie drückt man fehlende Notwendigkeit korrekt aus?',
        options: [
          'Du darfst morgen nicht kommen.',
          'Du musst morgen nicht kommen / Du brauchst morgen nicht zu kommen.',
          'Du sollst morgen nicht kommen.',
        ],
        correctIndex: 1,
        explanationAr: '«muss nicht» وَ«braucht nicht zu» تَدُلَّانِ عَلَى عَدَمِ اللُّزُومِ، بَيْنَمَا «darf nicht» تَدُلُّ عَلَى الْمَنْعِ.',
      ),
      ModalDrillQuestion(
        id: 'mvd_03',
        axis: ModalAxisCategory.permissionVsAbility,
        targetLanguage: 'German',
        promptAr: 'اخْتَرِ الْفِعْلَ النَّاقِصَ الْأَدَقَّ لِطَلَبِ الْإِذْنِ الرَّسْمِيِّ: «... ich eine Frage stellen?»',
        promptEn: 'Choose the most accurate German modal for asking official permission:',
        promptDe: 'Welches Modalverb fragt präzise nach einer Erlaubnis?',
        options: [
          'Darf ich eine Frage stellen?',
          'Muss ich eine Frage stellen?',
          'Will ich eine Frage stellen?',
        ],
        correctIndex: 0,
        explanationAr: 'الْفِعْلُ «dürfen» هُوَ الْمُخَصَّصُ لِلْإِذْنِ وَالسَّمَاحِ فِي الْأَلْمَانِيَّةِ.',
      ),
      ModalDrillQuestion(
        id: 'mvd_04',
        axis: ModalAxisCategory.evidentialModals,
        targetLanguage: 'German',
        promptAr: 'مَا مَعْنَى الْجُمْلَةِ الْأَلْمَانِيَّةِ: «Er will das Buch schon gelesen haben»؟',
        promptEn: 'What does "Er will das Buch schon gelesen haben" mean?',
        promptDe: 'Was bedeutet „Er will das Buch schon gelesen haben“?',
        options: [
          'يُرِيدُ أَنْ يَقْرَأَ الْكِتَابَ غَدًا',
          'يَزْعُمُ أَنَّهُ قَرَأَ الْكِتَابَ بِالْفِعْلِ (مَعَ تَشْكِيكِ النَّاقِلِ)',
          'يَجِبُ عَلَيْهِ قِرَاءَةُ الْكِتَابِ',
        ],
        correctIndex: 1,
        explanationAr: '«wollen + Infinitiv Perfekt» يُفِيدُ ادِّعَاءَ الشَّخْصِ عَنْ نَفْسِهِ مَعَ عَدَمِ تَبَنِّي النَّاقِلِ لِلْخَبَرِ.',
      ),
      ModalDrillQuestion(
        id: 'mvd_05',
        axis: ModalAxisCategory.pastCounterfactualModals,
        targetLanguage: 'German',
        promptAr: 'أَيُّ صِيغَةٍ تَسْتَعْمِلُ الْمَصْدَرَ الْمُزْدَوَجَ (Ersatzinfinitiv) بِشَكْلٍ صَحِيحٍ؟',
        promptEn: 'Select the grammatical German past counterfactual modal sentence:',
        promptDe: 'Welcher Satz bildet den Ersatzinfinitiv korrekt?',
        options: [
          'Du hättest das prüfen gesollt.',
          'Du hättest das prüfen sollen.',
          'Du hast das prüfen gesollen.',
        ],
        correctIndex: 1,
        explanationAr: 'مَعَ الْمَصْدَرِ الْمُزْدَوَجِ فِي الْمَاضِي الشَّرْطِيِّ يَبْقَى الْفِعْلُ النَّاقِصُ مَصْدَرًا: «hättest ... prüfen sollen».',
      ),
      ModalDrillQuestion(
        id: 'mvd_06',
        axis: ModalAxisCategory.politeVolition,
        targetLanguage: 'Arabic',
        promptAr: 'أَيُّ عِبَارَةٍ عَرَبِيَّةٍ أَكْثَرُ تَأَدُّبًا فِي الطَّلَبِ الرَّسْمِيِّ؟',
        promptEn: 'Which Arabic phrasing expresses polite, mitigated request?',
        promptDe: 'Welche arabische Formulierung ist besonders höflich?',
        options: [
          'أَعْطِنِي الْمَرْجِعَ الْآنَ.',
          'أَوَدُّ الِاسْتِعَانَةَ بِهَذَا الْمَرْجِعِ، لَوْ تَكَرَّمْتَ.',
          'أُرِيدُ الْمَرْجِعَ فَوْرًا.',
        ],
        correctIndex: 1,
        explanationAr: 'اسْتِعْمَالُ «أَوَدُّ» مَعَ التَّلَطُّفِ «لَوْ تَكَرَّمْتَ» يُقَابِلُ «I would like / Ich möchte».',
      ),
    ];
  }
}
