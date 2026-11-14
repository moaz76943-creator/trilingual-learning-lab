import '../models/situational_dialogue_models.dart';

class SituationalDialogueRepository {
  const SituationalDialogueRepository();

  List<SituationalDialogueScenario> getScenarios() {
    return const [
      SituationalDialogueScenario(
        id: 'sd_01',
        domain: DialogueContextDomain.academicLibrary,
        titleAr: 'الِاسْتِعْلَامُ عَنْ مَرْجِعٍ فِي الْمَكْتَبَةِ الْجَامِعِيَّةِ',
        titleEn: 'Requesting a Reference Book at the University Library',
        titleDe: 'Anfrage an der Auskunftstheke der Universitätsbibliothek',
        registerBadge: 'Formal / Sie',
        culturalTipAr:
            'فِي الْمُؤَسَّسَاتِ الْأَلْمَانِيَّةِ يَبْدَأُ الْحِوَارُ بِتَحِيَّةِ الْوَقْتِ مَعَ ضَمِيرِ الِاحْتِرَامِ «Sie» وَتَلَطُّفِ «könnten / hätten».',
        turns: [
          DialogueTurn(
            speakerRoleAr: 'الْبَاحِثُ',
            speakerRoleEn: 'Researcher',
            lineAr: 'السَّلَامُ عَلَيْكُمْ، عَفْوًا، هَلْ يُمْكِنُنِي الْحُصُولُ عَلَى نُسْخَةٍ مِنَ الْمُعْجَمِ التَّارِيخِيِّ لِلُّغَةِ؟',
            lineEn: 'Excuse me, could I access a copy of the historical language dictionary?',
            lineDe: 'Guten Tag, entschuldigen Sie bitte, könnte ich ein Exemplar des historischen Sprachwörterbuchs einsehen?',
            pragmaticNoteAr: 'اسْتِخْدَامُ «könnte ich» أَلْطَفُ وَأَكْثَرُ احْتِرَامًا مِنْ «kann ich».',
          ),
          DialogueTurn(
            speakerRoleAr: 'أَمِينُ الْمَكْتَبَةِ',
            speakerRoleEn: 'Librarian',
            lineAr: 'وَعَلَيْكُمُ السَّلَامُ، بِكُلِّ سُرُورٍ. النُّسْخَةُ الْمَطْبُوعَةُ فِي الطَّابِقِ الثَّانِي، وَالرَّقْمِيَّةُ مُتَاحَةٌ هُنَا.',
            lineEn: 'Certainly. The printed edition is on the second floor, and the digital copy is available here.',
            lineDe: 'Sehr gern. Die gedruckte Ausgabe steht im zweiten Obergeschoss, und die digitale Version ist hier verfügbar.',
            pragmaticNoteAr: '«Sehr gern» صِيغَةُ تَرْحِيبٍ مِهَنِيَّةٌ مَأْلُوفَةٌ فِي الْخِدْمَاتِ الْعَامَّةِ.',
          ),
          DialogueTurn(
            speakerRoleAr: 'الْبَاحِثُ',
            speakerRoleEn: 'Researcher',
            lineAr: 'جَزَاكَ اللهُ خَيْرًا، هَلْ يَجُوزُ تَصْوِيرُ بَعْضِ الصَّفَحَاتِ لِلْغَرَضِ الْعِلْمِيِّ؟',
            lineEn: 'Thank you kindly. Am I permitted to scan a few pages for academic study?',
            lineDe: 'Vielen Dank! Darf ich einige Seiten für meine wissenschaftliche Arbeit einscannen?',
            pragmaticNoteAr: 'يُسْتَعْمَلُ «Darf ich...?» دَائِمًا عِنْدَ طَلَبِ الْإِذْنِ النِّظَامِيِّ.',
          ),
        ],
      ),
      SituationalDialogueScenario(
        id: 'sd_02',
        domain: DialogueContextDomain.pharmacyAndCare,
        titleAr: 'الِاسْتِفْسَارُ عَنْ دَوَاءٍ وَجُرْعَتِهِ فِي الصَّيْدَلِيَّةِ',
        titleEn: 'Asking About Medication & Dosage at the Pharmacy',
        titleDe: 'Beratung zu Dosierung und Einnahme in der Apotheke',
        registerBadge: 'Polite / Advisory',
        culturalTipAr:
            'عِنْدَ السُّؤَالِ عَنِ الْجُرْعَةِ بِالْأَلْمَانِيَّةِ نُفَرِّقُ بَيْنَ «vor dem Essen» (قَبْلَ الطَّعَامِ) وَ«nach dem Essen» (بَعْدَهُ).',
        turns: [
          DialogueTurn(
            speakerRoleAr: 'الْمُرَاجِعُ',
            speakerRoleEn: 'Visitor',
            lineAr: 'مَرْحَبًا، أَبْحَثُ عَنْ قَطْرَةٍ مُرَطِّبَةٍ لِلْعَيْنِ، فَهَلْ تَتَوَفَّرُ لَدَيْكُمْ خَالِيَةً مِنَ الْمَوَادِّ الْحَافِظَةِ؟',
            lineEn: 'Hello, I am looking for moisturizing eye drops; do you have a preservative-free option?',
            lineDe: 'Guten Tag, ich suche befeuchtende Augentropfen. Haben Sie welche ohne Konservierungsstoffe?',
            pragmaticNoteAr: 'الصِّيغَةُ «Haben Sie welche ohne...?» طَبِيعِيَّةٌ وَعَمَلِيَّةٌ فِي الصَّيْدَلِيَّةِ.',
          ),
          DialogueTurn(
            speakerRoleAr: 'الصَّيْدَلَانِيُّ',
            speakerRoleEn: 'Pharmacist',
            lineAr: 'نَعَمْ، هَذَا النَّوْعُ مُنَاسِبٌ جِدًّا. يُسْتَعْمَلُ قَطْرَةً وَاحِدَةً ثَلَاثَ مَرَّاتٍ يَوْمِيًّا.',
            lineEn: 'Yes, this type is very suitable. Apply one drop three times daily.',
            lineDe: 'Ja, dieses Präparat ist sehr gut geeignet. Bitte wenden Sie dreimal täglich je einen Tropfen an.',
            pragmaticNoteAr: '«Bitte wenden Sie ... an» أَمْرٌ مُهَذَّبٌ بِصِيغَةِ الِاحْتِرَامِ لِلتَّعْلِيمَاتِ الطِّبِّيَّةِ.',
          ),
        ],
      ),
      SituationalDialogueScenario(
        id: 'sd_03',
        domain: DialogueContextDomain.transitAndTravel,
        titleAr: 'التَّأَكُّدُ مِنْ رَصِيفِ الْقِطَارِ وَتَغْيِيرِ التَّوْقِيتِ',
        titleEn: 'Confirming Train Platform & Transfer Connections',
        titleDe: 'Gleisänderung und Anschlusszug am Bahnhof erfragen',
        registerBadge: 'Everyday / Urgent',
        culturalTipAr:
            'فِي السَّفَرِ تَكْثُرُ صِيَغُ السُّؤَالِ غَيْرِ الْمُبَاشِرِ مِثْلَ «Wissen Sie zufällig, ob...?» لِسُرْعَةِ الْفَهْمِ وَاللُّطْفِ.',
        turns: [
          DialogueTurn(
            speakerRoleAr: 'الْمُسَافِرُ',
            speakerRoleEn: 'Traveler',
            lineAr: 'عَفْوًا، هَلْ يَنْطَلِقُ الْقِطَارُ الْمُتَّجِهُ إِلَى بَرْلِينَ مِنَ الرَّصِيفِ الرَّابِعِ أَمْ تَغَيَّرَ الرَّصِيفُ؟',
            lineEn: 'Excuse me, does the train to Berlin depart from platform four, or has the platform changed?',
            lineDe: 'Entschuldigung, fährt der Zug nach Berlin von Gleis vier ab, oder hat sich das Gleis geändert?',
            pragmaticNoteAr: '«abfahren» فِعْلٌ مُنْفَصِلٌ، لِذَلِكَ تَأْتِي «ab» فِي نِهَايَةِ الْجُمْلَةِ.',
          ),
          DialogueTurn(
            speakerRoleAr: 'الْمُوَظَّفُ',
            speakerRoleEn: 'Station Staff',
            lineAr: 'لَقَدْ تَأَخَّرَ عَشْرَ دَقَائِقَ وَانْتَقَلَ إِلَى الرَّصِيفِ السَّادِسِ. يُمْكِنُكَ اسْتِعْمَالُ الْمَمَرِّ الْأَيْمَنِ.',
            lineEn: 'It is delayed by ten minutes and moved to platform six. You may take the right underpass.',
            lineDe: 'Er hat zehn Minuten Verspätung und fährt heute von Gleis sechs. Nehmen Sie bitte den rechten Durchgang.',
            pragmaticNoteAr: 'تُسْتَعْمَلُ «Verspätung haben» دَائِمًا لِلتَّأَخُّرِ فِي الْمَوَاصَلَاتِ.',
          ),
        ],
      ),
      SituationalDialogueScenario(
        id: 'sd_04',
        domain: DialogueContextDomain.technicalCollaboration,
        titleAr: 'مُرَاجَعَةُ مِيزَةٍ بَرْمَجِيَّةٍ وَطَلَبُ تَحْسِينٍ بَنَّاءٍ',
        titleEn: 'Reviewing a Software Feature & Suggesting a Refactor',
        titleDe: 'Konstruktives Feedback im Software-Review geben',
        registerBadge: 'Professional / Tech',
        culturalTipAr:
            'النَّقْدُ الْهَنْدَسِيُّ الرَّاقِي يَبْدَأُ بِتَقْدِيرِ الْجُهْدِ ثُمَّ طَرْحِ الْبَدِيلِ بِأُسْلُوبٍ اقْتِرَاحِيٍّ (Könnten wir... / What if we...).',
        turns: [
          DialogueTurn(
            speakerRoleAr: 'الْمُطَوِّرُ الْأَوَّلُ',
            speakerRoleEn: 'Engineer A',
            lineAr: 'أَكْمَلْتُ بِنَاءَ وَحْدَةِ الْمُزَامَنَةِ الْمَحَلِّيَّةِ، وَأَوَدُّ سَمَاعَ مُلَاحَظَاتِكَ حَوْلَ سُرْعَةِ الِاسْتِجَابَةِ.',
            lineEn: 'I completed the offline sync module and would appreciate your feedback on latency.',
            lineDe: 'Ich habe das Offline-Sync-Modul fertiggestellt und würde mich über Ihr Feedback zur Antwortzeit freuen.',
            pragmaticNoteAr: '«Ich würde mich über ... freuen» صِيغَةٌ رَاقِيَةٌ لِطَلَبِ الْمُرَاجَعَةِ.',
          ),
          DialogueTurn(
            speakerRoleAr: 'الْمُرَاجِعُ التِّقْنِيُّ',
            speakerRoleEn: 'Reviewer',
            lineAr: 'عَمَلٌ مُتْقَنٌ! هَلْ نَسْتَطِيعُ فَصْلَ طَبَقَةِ التَّخْزِينِ لِتَسْهِيلِ اخْتِبَارَاتِ الْوَحْدَةِ؟',
            lineEn: 'Solid work! Could we decouple the storage layer so unit tests run faster?',
            lineDe: 'Sehr saubere Arbeit! Könnten wir die Speicherschicht noch entkoppeln, damit die Unit-Tests schneller laufen?',
            pragmaticNoteAr: '«damit» تَرْبِطُ السَّبَبَ الْغَائِيَّ بِتَغَيُّرِ الْفَاعِلِ (نَحْنُ ← الاختبارات).',
          ),
        ],
      ),
      SituationalDialogueScenario(
        id: 'sd_05',
        domain: DialogueContextDomain.hospitalityAndEtiquette,
        titleAr: 'آدَابُ الضِّيَافَةِ وَالتَّرْحِيبِ وَالشُّكْرِ اللَّطِيفِ',
        titleEn: 'Warm Hospitality, Hosting & Courteous Gratitude',
        titleDe: 'Herzliche Gastfreundschaft und höfliche Danksagung',
        registerBadge: 'Cultural / Warm',
        culturalTipAr:
            'التَّعْبِيرُ عَنِ الشُّكْرِ وَالدُّعَاءِ الْجَمِيلِ فِي الْعَرَبِيَّةِ يُقَابَلُ فِي الْأَلْمَانِيَّةِ بِـ «Herzlichen Dank für die Einladung».',
        turns: [
          DialogueTurn(
            speakerRoleAr: 'الْمُضِيفُ',
            speakerRoleEn: 'Host',
            lineAr: 'أَهْلًا وَسَهْلًا بِكُمْ، نَوَّرْتُمُ الْمَجْلِسَ. تَفَضَّلُوا بِالْجُلُوسِ، هَلْ تُفَضِّلُونَ الشَّايَ أَمِ الْقَهْوَةَ الْعَرَبِيَّةَ؟',
            lineEn: 'Welcome! Please have a seat. Would you prefer tea or Arabic coffee?',
            lineDe: 'Herzlich willkommen! Bitte nehmen Sie Platz. Möchten Sie lieber Tee oder arabischen Kaffee?',
            pragmaticNoteAr: '«Nehmen Sie Platz» تَعْنِي «تَفَضَّلْ بِالْجُلُوسِ» بِأَدَبٍ رَفِيعٍ.',
          ),
          DialogueTurn(
            speakerRoleAr: 'الضَّيْفُ',
            speakerRoleEn: 'Guest',
            lineAr: 'بَارَكَ اللهُ فِيكُمْ وَأَكْرَمَكُمْ، كُوبًا مِنَ الشَّايِ مِن فَضْلِكُمْ، وَلَا تُكَلِّفُوا أَنْفُسَكُمْ.',
            lineEn: 'May you be blessed for your generosity. A cup of tea, please—do not trouble yourselves.',
            lineDe: 'Herzlichen Dank für Ihre Gastfreundschaft! Gern eine Tasse Tee, bitte machen Sie sich keine Umstände.',
            pragmaticNoteAr: '«Machen Sie sich keine Umstände» هِيَ الْمُقَابِلُ الدَّقِيقُ لِـ «لَا تُكَلِّفُوا أَنْفُسَكُمْ».',
          ),
        ],
      ),
      SituationalDialogueScenario(
        id: 'sd_06',
        domain: DialogueContextDomain.conversationalRepair,
        titleAr: 'إِصْلَاحُ سُوءِ الْفَهْمِ وَطَلَبُ التَّوْضِيحِ بِأَدَبٍ',
        titleEn: 'Polite Conversational Repair & Requesting Rephrasing',
        titleDe: 'Höfliches Nachfragen und Umformulierung bei Unklarheit',
        registerBadge: 'Pragmatic Repair',
        culturalTipAr:
            'عِنْدَ عَدَمِ فَهْمِ جُمْلَةٍ سَرِيعَةٍ، يَسْتَعْمِلُ الْمُتَعَلِّمُ طَلَبَ الْإِبْطَاءِ أَوِ التَّلْخِيصِ دُونَ حَرَجٍ.',
        turns: [
          DialogueTurn(
            speakerRoleAr: 'الْمُحَاوِرُ',
            speakerRoleEn: 'Interlocutor',
            lineAr: 'عَفْوًا، لَمْ أَسْتَوْعِبِ الْجُزْءَ الْأَخِيرَ جَيِّدًا، هَلْ يُمْكِنُكَ إِعَادَتُهُ بِبُطْءٍ قَلِيلٍ؟',
            lineEn: 'Excuse me, I did not quite catch the last part; could you repeat it a bit more slowly?',
            lineDe: 'Entschuldigung, ich habe den letzten Teil nicht ganz verstanden. Könnten Sie das etwas langsamer wiederholen?',
            pragmaticNoteAr: '«nicht ganz verstanden» تُلَطِّفُ عَدَمَ الْفَهْمِ وَتُبْقِي الْحِوَارَ إِيجَابِيًّا.',
          ),
          DialogueTurn(
            speakerRoleAr: 'الْمُتَحَدِّثُ',
            speakerRoleEn: 'Speaker',
            lineAr: 'بِالتَّأْكِيدِ، أَقْصِدُ أَنَّ التَّسْجِيلَ يَنْتَهِي يَوْمَ الْخَمِيسِ السَّاعَةَ الرَّابِعَةَ عَصْرًا.',
            lineEn: 'Of course—I mean that registration closes on Thursday at four in the afternoon.',
            lineDe: 'Natürlich, ich meine damit, dass die Anmeldung am Donnerstag um sechzehn Uhr endet.',
            pragmaticNoteAr: '«ich meine damit, dass...» أَدَاةٌ مِثَالِيَّةٌ لِإِعَادَةِ الصِّيَاغَةِ التَّوْضِيحِيَّةِ.',
          ),
        ],
      ),
    ];
  }

  List<RoleplayTurnChallenge> getChallenges() {
    return const [
      RoleplayTurnChallenge(
        id: 'sdc_01',
        domain: DialogueContextDomain.academicLibrary,
        targetLanguage: 'German',
        incomingPromptAr: 'أَنْتَ فِي مَكْتَبَةِ الْجَامِعَةِ وَتُرِيدُ أَنْ تَسْتَأْذِنَ فِي اسْتِعْمَالِ مَاسِحٍ ضَوْئِيٍّ، مَا الْأَنْسَبُ؟',
        incomingPromptEn: 'You are at the university library and want to ask permission to use the scanner:',
        incomingPromptDe: 'Sie möchten in der Bibliothek höflich um Erlaubnis für den Scanner fragen:',
        options: [
          'Ich will den Scanner benutzen.',
          'Entschuldigung, darf ich hier den Scanner benutzen?',
          'Muss ich den Scanner jetzt benutzen?',
        ],
        correctIndex: 1,
        feedbackAr: '«darf ich...?» هِيَ الصِّيغَةُ الْمُهَذَّبَةُ الْمُخَصَّصَةُ لِطَلَبِ الْإِذْنِ.',
      ),
      RoleplayTurnChallenge(
        id: 'sdc_02',
        domain: DialogueContextDomain.pharmacyAndCare,
        targetLanguage: 'German',
        incomingPromptAr: 'الصَّيْدَلَانِيُّ يَسْأَلُكَ: «Haben Sie noch Fragen zur Einnahme?» كَيْفَ تَشْكُرُهُ بِوُضُوحٍ؟',
        incomingPromptEn: 'The pharmacist asks if you have further questions about taking the medicine:',
        incomingPromptDe: 'Wie bedanken Sie sich höflich, wenn alles klar ist?',
        options: [
          'Nein, alles ist klar. Vielen Dank für Ihre Beratung!',
          'Nein, ich habe kein Wort gehört.',
          'Gib mir das bitte sofort.',
        ],
        correctIndex: 0,
        feedbackAr: '«Vielen Dank für Ihre Beratung!» تَعْبِيرٌ دَقِيقٌ وَمُهَذَّبٌ فِي السِّيَاقِ الصَّيْدَلَانِيِّ.',
      ),
      RoleplayTurnChallenge(
        id: 'sdc_03',
        domain: DialogueContextDomain.transitAndTravel,
        targetLanguage: 'German',
        incomingPromptAr: 'تُرِيدُ أَنْ تَسْأَلَ عَنْ وُصُولِ الْقِطَارِ فِي مَوْعِدِهِ، أَيُّ جُمْلَةٍ أَصَحُّ؟',
        incomingPromptEn: 'Ask politely whether the train is on time:',
        incomingPromptDe: 'Fragen Sie höflich, ob der Zug pünktlich ist:',
        options: [
          'Wissen Sie zufällig, ob der Zug pünktlich abfährt?',
          'Wann der Zug fährt ab?',
          'Der Zug hat Verspätung warum?',
        ],
        correctIndex: 0,
        feedbackAr: 'السُّؤَالُ غَيْرُ الْمُبَاشِرِ بـ «ob» يَضَعُ الْفِعْلَ الْمُتَّصِلَ «abfährt» فِي نِهَايَةِ الْجُمْلَةِ.',
      ),
      RoleplayTurnChallenge(
        id: 'sdc_04',
        domain: DialogueContextDomain.technicalCollaboration,
        targetLanguage: 'English',
        incomingPromptAr: 'أَيُّ رَدٍّ يَقْتَرِحُ تَحْسِينًا بَرْمَجِيًّا بِأُسْلُوبٍ مِهَنِيٍّ مُتَعَاوِنٍ؟',
        incomingPromptEn: 'Choose the most constructive engineering code-review response:',
        incomingPromptDe: 'Welche Rückmeldung im Code-Review ist am konstruktivsten?',
        options: [
          'This code is completely unusable.',
          'Great progress! Could we extract the validation logic into a dedicated service?',
          'Why did you even write it like this?',
        ],
        correctIndex: 1,
        feedbackAr: 'الْجَمْعُ بَيْنَ التَّقْدِيرِ وَالِاقْتِرَاحِ الْعَمَلِيِّ يَبْنِي تَعَاوُنًا هَنْدَسِيًّا نَاجِحًا.',
      ),
      RoleplayTurnChallenge(
        id: 'sdc_05',
        domain: DialogueContextDomain.hospitalityAndEtiquette,
        targetLanguage: 'German',
        incomingPromptAr: 'مَا الْمُقَابِلُ الْأَلْمَانِيُّ الْمُهَذَّبُ لِعِبَارَةِ «لَا تُكَلِّفُوا أَنْفُسَكُمْ» عِنْدَ زِيَارَةِ مُضِيفٍ؟',
        incomingPromptEn: 'What is the polite German equivalent of "Please do not trouble yourselves"?',
        incomingPromptDe: 'Wie sagt man höflich „Bitte machen Sie sich keine Mühe“?',
        options: [
          'Bitte machen Sie sich keine Umstände.',
          'Ich brauche nichts von Ihnen.',
          'Lassen Sie das sofort liegen.',
        ],
        correctIndex: 0,
        feedbackAr: '«Bitte machen Sie sich keine Umstände» عِبَارَةٌ أَصِيلَةٌ لِلتَّأَدُّبِ مَعَ الْمُضِيفِ.',
      ),
      RoleplayTurnChallenge(
        id: 'sdc_06',
        domain: DialogueContextDomain.conversationalRepair,
        targetLanguage: 'Arabic',
        incomingPromptAr: 'لَمْ تَسْمَعِ الْمَوْعِدَ بِوُضُوحٍ، مَا أَلْطَفُ طَلَبٍ لِلتَّوْضِيحِ بِالْعَرَبِيَّةِ؟',
        incomingPromptEn: 'Select the most courteous Arabic clarification request:',
        incomingPromptDe: 'Welche arabische Nachfrage ist am höflichsten?',
        options: [
          'أَعِدْ كَلَامَكَ، لَمْ أَفْهَمْ شَيْئًا.',
          'عَفْوًا، هَلْ لَكَ أَنْ تُعِيدَ ذِكْرَ الْمَوْعِدِ، لَوْ تَكَرَّمْتَ؟',
          'تَكَلَّمْ بِصَوْتٍ أَعْلَى.',
        ],
        correctIndex: 1,
        feedbackAr: 'تَقْدِيمُ «عَفْوًا» وَالِاسْتِفْهَامُ بـ «هَلْ لَكَ أَنْ... لَوْ تَكَرَّمْتَ» يُحَافِظُ عَلَى الْأَدَبِ وَالْوُدِّ.',
      ),
    ];
  }
}
