import '../models/imperative_requests_models.dart';

class ImperativeRequestsRepository {
  const ImperativeRequestsRepository();

  List<ImperativeLessonUnit> getUnits() {
    return const [
      ImperativeLessonUnit(
        id: 'ir_01',
        category: ImperativeCategory.imperativeMorphology,
        titleAr: 'صِيَاغَةُ الْأَمْرِ: حَذْفُ حَرْفِ الْمُضَارَعَةِ فِي الْعَرَبِيَّةِ وَتَثْلِيثُ الْخِطَابِ فِي الْأَلْمَانِيَّةِ',
        titleEn: 'Arabic Jussive-Derived Imperative vs. German du/ihr/Sie & English Bare Base',
        titleDe: 'Drei Formen im Deutschen: Schreib! (du) / Schreibt! (ihr) / Schreiben Sie! (Sie)',
        exampleAr: 'اُكْتُبِ الْمُلَخَّصَ يَا صَدِيقِي، وَاكْتُبُوا الْمُلَاحَظَاتِ يَا طُلَّابُ!',
        exampleEn: 'Write the summary, my friend, and write down the notes, students!',
        exampleDe: 'Schreib die Zusammenfassung, mein Freund! Schreiben Sie bitte die Notizen auf!',
        ruleAr:
            'يُصَاغُ الْأَمْرُ فِي الْعَرَبِيَّةِ مِنَ الْمُضَارِعِ الْمَجْزُومِ بَعْدَ حَذْفِ حَرْفِ الْمُضَارَعَةِ؛ فَإِنْ سَكَنَ أَوَّلُهُ جُلِبَتْ هَمْزَةُ الْوَصْلِ (اُكْتُبْ، اِجْلِسْ).',
        ruleEn:
            'English uses a single invariable bare infinitive ("Write!") for singular, plural, and formal addressees.',
        ruleDe:
            'Für „du“ entfällt das Pronomen und die Endung -(s)t (Schreib!); für „ihr“ bleibt -t (Schreibt!); für „Sie“ steht das Verb vor „Sie“ (Schreiben Sie!).',
        moodTag: 'du / ihr / Sie • اُكْتُبْ',
        pitfallAlertAr:
            'الْخَطَأُ الشَّائِعُ: نِسْيَانُ ضَمِيرِ «Sie» فِي الْأَمْرِ الرَّسْمِيِّ الْأَلْمَانِيِّ (*Schreiben! خَطَأٌ؛ الصَّوَابُ «Schreiben Sie!»)، أَوْ كِتَابَةُ هَمْزَةِ قَطْعٍ عَلَى أَمْرِ الثُّلَاثِيِّ (*أُكْتُبْ).',
      ),
      ImperativeLessonUnit(
        id: 'ir_02',
        category: ImperativeCategory.hollowDefectiveSeparable,
        titleAr: 'الْأَمْرُ مِنَ الْأَجْوَفِ وَالنَّاقِصِ وَتَبَدُّلُ الْحَرَكَةِ وَفَصْلُ السَّابِقَةِ',
        titleEn: 'Hollow/Defective Truncation vs. German e→i Stem-Vowel & Separable Prefixes',
        titleDe: 'Vokalwechsel e→i (Lies! Nimm! Gib!) ohne Umlaut (Fahr!) & Vorsilbe am Ende',
        exampleAr: 'قُلِ الصِّدْقَ، وَادْعُ إِلَى الْخَيْرِ، وَابْدَأِ الْعَمَلَ بَاكِرًا!',
        exampleEn: 'Speak the truth, call to what is good, and start work early!',
        exampleDe: 'Sprich die Wahrheit, nimm dir Zeit und fang früh mit der Arbeit an!',
        ruleAr:
            'يُحْذَفُ حَرْفُ الْعِلَّةِ فِي أَمْرِ النَّاقِصِ (ادْعُ، ارْمِ، اسْعَ) وَيُحْذَفُ وَسَطُ الْأَجْوَفِ لِالْتِقَاءِ السَّاكِنَيْنِ (قُلْ، بِعْ، سِرْ).',
        ruleEn:
            'English separable phrasal verbs keep the particle together ("start out", "stand up") with no stem change.',
        ruleDe:
            'Verben mit e→i/ie-Wechsel behalten diesen im du-Imperativ ohne Endung -e (Lies!, Nimm!, Sprich!); Umlaut a→ä fällt weg (Fahr!, Schlaf!). Trennbare Vorsilben wandern ans Satzende.',
        moodTag: 'قُلْ / ادْعُ • Sprich! / Fang an!',
        pitfallAlertAr:
            'انْتَبِهْ: فِي الْأَلْمَانِيَّةِ يَبْقَى تَحَوُّلُ «e→i» فِي الْأَمْرِ (Nimm! وَلَيْسَ *Nehme!)، أَمَّا «a→ä» فَيَسْقُطُ (Fahr! وَلَيْسَ *Fähr!).',
      ),
      ImperativeLessonUnit(
        id: 'ir_03',
        category: ImperativeCategory.prohibitionVsNegation,
        titleAr: 'التَّفْرِيقُ بَيْنَ «لَا النَّاهِيَةِ» الْجَازِمَةِ وَ«لَا النَّافِيَةِ» وَصِيَغِ النَّهْيِ',
        titleEn: 'Prohibitive "Don\'t" / Lā al-Nāhiya vs. Declarative Negation',
        titleDe: 'Verbot im Imperativ (Vergiss nicht! / Sei nicht ungeduldig!)',
        exampleAr: 'لَا تَنْسَ الْمَوْعِدَ، وَلَا تَتَسَرَّعْ فِي الْحُكْمِ!',
        exampleEn: 'Do not forget the appointment, and do not rush to judgment!',
        exampleDe: 'Vergiss den Termin nicht und urteile nicht vorschnell!',
        ruleAr:
            '«لَا النَّاهِيَةُ» تَجْزِمُ الْمُضَارِعَ (لَا تَنْسَ، لَا تَقُلْ، لَا تَذْهَبُوا)، أَمَّا «لَا النَّافِيَةُ» فَتُبْقِيهِ مَرْفُوعًا (أَنْتَ لَا تَنْسَى).',
        ruleEn:
            'English requires "do-support" ("Do not / Don\'t + base verb") even with "be" ("Don\'t be late!").',
        ruleDe:
            'Im deutschen negativen Imperativ steht „nicht“ meist am Satzende (oder vor der trennbaren Vorsilbe/Adjektiv): „Schlafen Sie nicht ein!“.',
        moodTag: 'لَا تَنْسَ ≠ لَا تَنْسَى • Do not',
        pitfallAlertAr:
            'لَا تَثْبِتْ حَرْفَ الْعِلَّةِ أَوْ نُونَ الْأَفْعَالِ الْخَمْسَةِ بَعْدَ «لَا النَّاهِيَةِ» (*لَا تَنْسَى الْمَوْعِدَ خَطَأٌ؛ الصَّوَابُ «لَا تَنْسَ»).',
      ),
      ImperativeLessonUnit(
        id: 'ir_04',
        category: ImperativeCategory.hortativeLetUs,
        titleAr: 'لَامُ الْأَمْرِ وَصِيَغُ الْحَثِّ الْجَمَاعِيِّ (لِنَبْدَأْ / Let\'s / Fangen wir an!)',
        titleEn: 'Shared Action: Arabic Lām al-Amr vs. English "Let\'s" & German wir-Imperativ',
        titleDe: 'Gemeinsamer Aufruf: „Fangen wir an!“ / „Gehen wir!“ / „Lassen Sie uns ...“',
        exampleAr: 'لِنَبْدَأِ الْمُرَاجَعَةَ الْآنَ وَلْنَتَعَاوَنْ عَلَى حَلِّ التَّدْرِيبِ!',
        exampleEn: 'Let\'s start the revision now and collaborate on solving the exercise!',
        exampleDe: 'Fangen wir jetzt mit der Wiederholung an und lösen wir die Aufgabe gemeinsam!',
        ruleAr:
            'تُكْسَرُ لَامُ الْأَمْرِ (لِـ) وَتُسَكَّنُ بَعْدَ الْوَاوِ وَالْفَاءِ وَثُمَّ (وَلْـ / فَلْـ)، وَتَجْزِمُ الْفِعْلَ الْمُضَارِعَ (لِنَبْدَأْ، فَلْيَجْتَهِدْ).',
        ruleEn:
            'English uses the contracted hortative "Let\'s + bare infinitive" ("Let\'s go", negative "Let\'s not waste time").',
        ruleDe:
            'Im Deutschen nutzt man Verb-Erst-Stellung mit „wir“ („Gehen wir!“, „Seien wir ehrlich!“) oder formeller „Lassen Sie uns beginnen!“.',
        moodTag: 'لِنَبْدَأْ • Let\'s • Fangen wir an!',
        pitfallAlertAr:
            'فِي الْعَرَبِيَّةِ تَجْزِمُ لَامُ الْأَمْرِ الْفِعْلَ، وَتُحَرَّكُ بِالْكَسْرِ عِنْدَ الِالْتِقَاءِ بِالسَّاكِنِ: «لِنَبْدَأِ الْمُرَاجَعَةَ».',
      ),
      ImperativeLessonUnit(
        id: 'ir_05',
        category: ImperativeCategory.politeMitigation,
        titleAr: 'تَلْطِيفُ الطَّلَبِ وَالتَّحَوُّلُ مِنَ الْأَمْرِ الْمُبَاشِرِ إِلَى الِاسْتِفْهَامِ الْمُؤَدَّبِ',
        titleEn: 'Softening Directives: Konjunktiv II, "Would you mind" & Arabic Polite Formulas',
        titleDe: 'Höfliche Bitten: „Könnten Sie bitte...?“ / „Würden Sie mir helfen?“',
        exampleAr: 'لَوْ تَكَرَّمْتَ، هَلْ يُمْكِنُكَ أَنْ تُعِيدَ شَرْحَ هَذِهِ النُّقْطَةِ؟',
        exampleEn: 'If you don\'t mind, could you please explain this point again?',
        exampleDe: 'Könnten Sie diesen Punkt bitte noch einmal erklären?',
        ruleAr:
            'تَسْتَبْدِلُ الْعَرَبِيَّةُ الْأَمْرَ الصَّرِيحَ فِي مَقَامِ التَّأَدُّبِ بِعِبَارَاتِ الدُّعَاءِ وَالِالْتِمَاسِ (مِنْ فَضْلِكَ، لَوْ تَكَرَّمْتَ، هَلْ لَكَ أَنْ...).',
        ruleEn:
            'English softens requests with modal past forms ("Could you...", "Would you mind + -ing?") rather than bare imperatives.',
        ruleDe:
            'Im Deutschen macht der Konjunktiv II („Könnten Sie...?“, „Würden Sie...?“) zusammen mit „bitte“ oder „mal/doch“ eine Aufforderung höflich.',
        moodTag: 'مِنْ فَضْلِكَ • Könnten Sie...',
        pitfallAlertAr:
            'الْأَمْرُ الْمُبَاشِرُ مَعَ الْغُرَبَاءِ أَوِ الْأَسَاتِذَةِ قَدْ يَبْدُو جَافًّا فِي اللُّغَاتِ الثَّلَاثِ؛ اسْتَعْمِلِ الصِّيَغَ الْمُلَطَّفَةَ فِي السِّيَاقِ الرَّسْمِيِّ.',
      ),
      ImperativeLessonUnit(
        id: 'ir_06',
        category: ImperativeCategory.impersonalInstructions,
        titleAr: 'التَّعْلِيمَاتُ الْعَامَّةُ وَاللَّافِتَاتُ: الْمَصْدَرُ الْأَلْمَانِيُّ مُقَابِلَ الْأَمْرِ وَالْمَمْنُوعِ',
        titleEn: 'Public Signs & Recipes: German Infinitive/Participle vs. English/Arabic Signs',
        titleDe: 'Schilder & Rezepte: Infinitiv („Bitte nicht stören!“) & Partizip II („Aufgepasst!“)',
        exampleAr: 'يُرْجَى عَدَمُ الْإِزْعَاجِ؛ حَافِظُوا عَلَى الْهُدُوءِ فِي قَاعَةِ الْمُطَالَعَةِ!',
        exampleEn: 'Please do not disturb; keep quiet in the reading hall!',
        exampleDe: 'Bitte nicht stören! Im Lesesaal bitte ruhig bleiben!',
        ruleAr:
            'فِي اللَّافِتَاتِ الْعَرَبِيَّةِ يَشِيعُ الْمَصْدَرُ النَّائِبُ عَنِ الْفِعْلِ أَوِ التَّرْجِي (يُرْجَى عَدَمُ...، مَمْنُوعٌ...) لِتَعْمِيمِ الْخِطَابِ.',
        ruleEn:
            'English signs use bare imperatives ("Do not disturb", "Keep quiet") or "No + gerund" ("No parking").',
        ruleDe:
            'Auf Schildern, in Anleitungen und Rezepten verwendet das Deutsche den neutralen Infinitiv am Ende („Nicht berühren!“, „Zwiebeln klein schneiden“).',
        moodTag: 'يُرْجَى عَدَمُ... • Infinitiv',
        pitfallAlertAr:
            'لَا تَتَرْجِمْ «Bitte nicht stören!» إِلَى أَمْرٍ مُفْرَدٍ جَافٍّ؛ صِيغَةُ الْمَصْدَرِ فِي الْأَلْمَانِيَّةِ تُخَاطِبُ الْجَمِيعَ بِلَبَاقَةٍ.',
      ),
    ];
  }

  List<ImperativeDrillItem> getDrills() {
    return const [
      ImperativeDrillItem(
        id: 'ir_d1',
        category: ImperativeCategory.imperativeMorphology,
        targetLanguage: 'DE',
        promptAr: 'اخْتَرْ صِيغَةَ الْأَمْرِ الرَّسْمِيَّةَ (Sie) لِفِعْلِ «lesen» (اقْرَأْ حَضْرَتُكَ):',
        promptEn: 'Choose the formal German imperative (Sie) for "lesen":',
        promptDe: 'Wie lautet der höfliche Imperativ (Sie-Form) von „lesen“?',
        options: [
          'Lesen Sie bitte den Text!',
          'Lest Sie bitte den Text!',
          'Lies bitte den Text, Sie!',
        ],
        correctIndex: 0,
        explanationAr:
            'صِيغَةُ الْأَمْرِ الرَّسْمِيَّةُ (Sie) تَسْتَعْمِلُ الْمَصْدَرَ مَتْبُوعًا بِضَمِيرِ «Sie» وُجُوبًا: Lesen Sie bitte!',
      ),
      ImperativeDrillItem(
        id: 'ir_d2',
        category: ImperativeCategory.hollowDefectiveSeparable,
        targetLanguage: 'DE',
        promptAr: 'مَا صِيغَةُ الْأَمْرِ الصَّحِيحَةُ لِلْمُخَاطَبِ الْمُفْرَدِ (du) مِنَ الْفِعْلِ «nehmen» (خُذْ)؟',
        promptEn: 'Select the correct German du-imperative of "nehmen" (to take):',
        promptDe: 'Wie lautet der du-Imperativ von „nehmen“?',
        options: [
          'Nimm das Buch!',
          'Nehme das Buch!',
          'Nimmst das Buch!',
        ],
        correctIndex: 0,
        explanationAr:
            'الْأَفْعَالُ الَّتِي يَتَحَوَّلُ فِيهَا «e ← i» مَعَ (du) تَحْتَفِظُ بِهَذَا التَّحَوُّلِ فِي الْأَمْرِ دُونَ «-e» أَوْ «-st»: Nimm!',
      ),
      ImperativeDrillItem(
        id: 'ir_d3',
        category: ImperativeCategory.prohibitionVsNegation,
        targetLanguage: 'AR',
        promptAr: 'اخْتَرِ النَّهْيَ السَّلِيمَ نَحْوِيًّا لِـ «Do not forget your notebook!»: ',
        promptEn: 'Choose the grammatically accurate Arabic prohibition:',
        promptDe: 'Wähle den grammatisch korrekten arabischen Verbotssatz:',
        options: [
          'لَا تَنْسَ دَفْتَرَكَ!',
          'لَا تَنْسَى دَفْتَرَكَ!',
          'لَا تَنْسِ دَفْتَرَكَ!',
        ],
        correctIndex: 0,
        explanationAr:
            '«لَا النَّاهِيَةُ» تَجْزِمُ الْفِعْلَ الْمُضَارِعَ النَّاقِصَ بِحَذْفِ حَرْفِ الْعِلَّةِ (تَنْسَى ← لَا تَنْسَ) وَتَبْقَى الْفَتْحَةُ دَلِيلًا عَلَى الْأَلِفِ الْمَحْذُوفَةِ.',
      ),
      ImperativeDrillItem(
        id: 'ir_d4',
        category: ImperativeCategory.hortativeLetUs,
        targetLanguage: 'DE',
        promptAr: 'مَا التَّرْجَمَةُ الْأَلْمَانِيَّةُ الطَّبِيعِيَّةُ لِـ «لِنَبْدَأِ الْآنَ / Let\'s start now!»؟',
        promptEn: 'Select the natural German 1st-person plural hortative for "Let\'s start now!":',
        promptDe: 'Welche Form entspricht „Let\'s start now!“?',
        options: [
          'Fangen wir jetzt an!',
          'Wir fangen jetzt an!',
          'Fangt wir jetzt an!',
        ],
        correctIndex: 0,
        explanationAr:
            'فِي صِيغَةِ الْحَثِّ الْجَمَاعِيِّ (Adhortativ) يَتَقَدَّمُ الْفِعْلُ عَلَى «wir» وَتَبْقَى السَّابِقَةُ الْمُنْفَصِلَةُ فِي النِّهَايَةِ: Fangen wir jetzt an!',
      ),
      ImperativeDrillItem(
        id: 'ir_d5',
        category: ImperativeCategory.politeMitigation,
        targetLanguage: 'EN',
        promptAr: 'اخْتَرِ الطَّلَبَ الْإِنْجِلِيزِيَّ الْأَكْثَرَ تَأَدُّبًا فِي السِّيَاقِ الْأَكَادِيمِيِّ:',
        promptEn: 'Choose the most polite academic English request:',
        promptDe: 'Welche englische Bitte ist im akademischen Kontext am höflichsten?',
        options: [
          'Would you mind explaining this rule again?',
          'Explain me this rule right now!',
          'Must you explain this rule again?',
        ],
        correctIndex: 0,
        explanationAr:
            'صِيغَةُ «Would you mind + V-ing?» تُخَفِّفُ وَقْعَ الطَّلَبِ وَتُعَدُّ مِنْ أَرْقَى صِيَغِ التَّلَطُّفِ فِي الْإِنْجِلِيزِيَّةِ.',
      ),
      ImperativeDrillItem(
        id: 'ir_d6',
        category: ImperativeCategory.impersonalInstructions,
        targetLanguage: 'DE',
        promptAr: 'أَيُّ صِيغَةٍ تُسْتَعْمَلُ عَلَى اللَّافِتَاتِ الْأَلْمَانِيَّةِ لِـ «يُرْجَى عَدَمُ الْإِزْعَاجِ / Please do not disturb»؟',
        promptEn: 'Which form is standard on German public signs for "Please do not disturb"?',
        promptDe: 'Welche Formulierung ist auf deutschen Schildern üblich?',
        options: [
          'Bitte nicht stören!',
          'Störst du bitte nicht!',
          'Nicht gestört bitte!',
        ],
        correctIndex: 0,
        explanationAr:
            'تَسْتَعْمِلُ اللَّافِتَاتُ وَالتَّعْلِيمَاتُ الْعَامَّةُ فِي الْأَلْمَانِيَّةِ الْمَصْدَرَ غَيْرَ الْمُصَرَّفِ (Infinitiv) بَعْدَ «Bitte nicht»: Bitte nicht stören!',
      ),
    ];
  }
}
