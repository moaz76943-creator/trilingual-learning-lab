import '../models/reported_speech_models.dart';

class ReportedSpeechRepository {
  const ReportedSpeechRepository();

  List<ReportedSpeechScenario> getScenarios() {
    return const [
      ReportedSpeechScenario(
        id: 'rs_01',
        category: ReportedSpeechCategory.declarativeShift,
        titleAr: 'كَسْرُ هَمْزَةِ «إِنَّ» بَعْدَ الْقَوْلِ مُقَابِلَ التَّرْجِيعِ الزَّمَنِيِّ',
        titleEn: 'Arabic Kasr al-Hamza vs. English Backshift & German Konjunktiv I',
        titleDe: 'Aussagesatz: Konjunktiv I im Deutschen vs. Zeitenfolge',
        directAr: 'قَالَ الْبَاحِثُ: «إِنَّ الْمَخْطُوطَةَ تَحْفَظُ النَّصَّ الْأَصْلِيَّ».',
        indirectAr: 'أَفَادَ الْبَاحِثُ أَنَّ الْمَخْطُوطَةَ تَحْفَظُ النَّصَّ الْأَصْلِيَّ (وَيُقَالُ: قَالَ إِنَّ الْمَخْطُوطَةَ...).',
        directEn: 'The researcher said: "The manuscript preserves the original text."',
        indirectEn: 'The researcher stated that the manuscript preserved the original text.',
        directDe: 'Der Forscher sagte: „Die Handschrift bewahrt den Originaltext.“',
        indirectDe: 'Der Forscher erklärte, die Handschrift bewahre den Originaltext.',
        grammarRuleAr:
            'فِي الْعَرَبِيَّةِ تُكْسَرُ هَمْزَةُ «إِنَّ» وُجُوبًا إِذَا وَقَعَتْ فِي صَدْرِ جُمْلَةِ مَقُولِ الْقَوْلِ، بَيْنَمَا تُفْتَحُ «أَنَّ» مَعَ أَفْعَالِ الْإِفَادَةِ وَالتَّصْرِيحِ لِتَأْوِيلِهَا بِمَصْدَرٍ مُؤَوَّلٍ.',
        grammarRuleEn:
            'English shifts the finite verb back one tense ("preserves" -> "preserved") after a past reporting verb ("stated").',
        grammarRuleDe:
            'Im Deutschen markiert der Konjunktiv I („bewahre“) die indirekte Rede ohne Zeitverschiebung und signalisiert sachliche Distanz.',
        pitfallNoteAr:
            'الْخَطَأُ الشَّائِعُ: فَتْحُ هَمْزَةِ «أَنَّ» مُبَاشَرَةً بَعْدَ «قَالَ» بِدُونِ تَقْدِيرٍ، أَوِ اسْتِخْدَامُ الْمَاضِي الدَّلَالِيِّ فِي الْأَلْمَانِيَّةِ بَدَلًا مِنْ Konjunktiv I.',
        deicticPairs: [
          DeicticPair(
            directAr: 'قَالَ: إِنَّ',
            indirectAr: 'أَفَادَ أَنَّ',
            directEn: 'preserves',
            indirectEn: 'preserved',
            directDe: 'bewahrt (Indikativ)',
            indirectDe: 'bewahre (Konjunktiv I)',
          ),
        ],
        registerTag: 'Academic / Journalistic',
      ),
      ReportedSpeechScenario(
        id: 'rs_02',
        category: ReportedSpeechCategory.konjunktivEvidential,
        titleAr: 'الْبَدِيلُ الشَّرْطِيُّ (Konjunktiv II) عِنْدَ تَطَابُقِ الصِّيَغِ وَالْإِسْنَادِ التَّضْعِيفِيِّ',
        titleEn: 'Konjunktiv II Fallback & Epistemic Hedging',
        titleDe: 'Ersatzregel: Konjunktiv II bei Formengleichheit mit dem Indikativ',
        directAr: 'قَالَ الْعُلَمَاءُ: «نَحْنُ نَمْلِكُ أَدِلَّةً جَدِيدَةً حَوْلَ التَّارِيخِ».',
        indirectAr: 'زَعَمَ الْعُلَمَاءُ أَنَّهُمْ يَمْلِكُونَ أَدِلَّةً جَدِيدَةً حَوْلَ التَّارِيخِ.',
        directEn: 'The scholars said: "We possess new evidence regarding the date."',
        indirectEn: 'The scholars claimed that they possessed new evidence regarding the date.',
        directDe: 'Die Gelehrten sagten: „Wir haben neue Belege für das Datum.“',
        indirectDe: 'Die Gelehrten berichteten, sie hätten neue Belege für das Datum.',
        grammarRuleAr:
            'يُعَبِّرُ الْفِعْلُ «زَعَمَ» أَوْ «يُقَالُ» فِي الْعَرَبِيَّةِ عَنِ التَّحَفُّظِ التَّوْثِيقِيِّ، وَهُوَ يُقَابِلُ مَقْصِدَ الصِّيغَةِ غَيْرِ الْمُبَاشِرَةِ فِي الصِّحَافَةِ الْأَلْمَانِيَّةِ.',
        grammarRuleEn:
            'Reporting verbs like "claimed" or "reportedly" convey evidential distance without committing the reporter to truth value.',
        grammarRuleDe:
            'Da „sie haben“ im Konjunktiv I mit dem Indikativ identisch ist, weicht man auf den Konjunktiv II („sie hätten“) aus.',
        pitfallNoteAr:
            'احْذَرْ مِنْ قَوْلِ «sie haben» فِي الْخِطَابِ الصَّحَفِيِّ الْأَلْمَانِيِّ الرَّسْمِيِّ؛ لِأَنَّهَا لَا تُمَيِّزُ النَّقْلَ عَنِ الْإِخْبَارِ الْمُبَاشِرِ.',
        deicticPairs: [
          DeicticPair(
            directAr: 'قَالَ: نَمْلِكُ',
            indirectAr: 'زَعَمَ أَنَّهُمْ يَمْلِكُونَ',
            directEn: 'said: we possess',
            indirectEn: 'claimed that they possessed',
            directDe: 'wir haben',
            indirectDe: 'sie hätten (Konj. II)',
          ),
        ],
        registerTag: 'Journalistic / Critical',
      ),
      ReportedSpeechScenario(
        id: 'rs_03',
        category: ReportedSpeechCategory.interrogativeReported,
        titleAr: 'الِاسْتِفْهَامُ الْمَنْقُولُ وَتَعْلِيقُ الْفِعْلِ فِي الْعَرَبِيَّةِ وَتَأْخِيرُ الْفِعْلِ فِي الْأَلْمَانِيَّةِ',
        titleEn: 'Indirect Polar & Wh-Questions: Word Order Reversal',
        titleDe: 'Indirekte Fragen mit „ob“ und W-Wörtern (Verbletztstellung)',
        directAr: 'سَأَلَ الطَّالِبُ أُسْتَاذَهُ: «هَلْ تَبْدَأُ الْمُحَاضَرَةُ غَدًا؟»',
        indirectAr: 'سَأَلَ الطَّالِبُ أُسْتَاذَهُ هَلْ تَبْدَأُ الْمُحَاضَرَةُ فِي الْيَوْمِ التَّالِي (أَمْ لَا).',
        directEn: 'The student asked his professor: "Does the lecture start tomorrow?"',
        indirectEn: 'The student asked his professor whether the lecture started the next day.',
        directDe: 'Der Student fragte seinen Professor: „Beginnt die Vorlesung morgen?“',
        indirectDe: 'Der Student fragte seinen Professor, ob die Vorlesung am nächsten Tag beginne.',
        grammarRuleAr:
            'فِي الْعَرَبِيَّةِ يُعَلَّقُ فِعْلُ السُّؤَالِ أَوِ الْعِلْمِ بِأَدَاةِ الِاسْتِفْهَامِ دُونَ حَذْفِهَا، وَلَا تَتَغَيَّرُ رُتْبَةُ الْجُمْلَةِ كَمَا فِي الْإِنْجِلِيزِيَّةِ وَالْأَلْمَانِيَّةِ.',
        grammarRuleEn:
            'Indirect yes/no questions use "if" or "whether" and revert to declarative subject-before-verb order (no do-support).',
        grammarRuleDe:
            'Indirekte Entscheidungsfragen werden mit „ob“ eingeleitet; das konjugierte Verb („beginne“) wandert ans Satzende.',
        pitfallNoteAr:
            'لَا تَسْتَعْمِلْ «did/does» فِي السُّؤَالِ الْمَنْقُولِ بِالْإِنْجِلِيزِيَّةِ، وَلَا تَضَعِ الْفِعْلَ فِي الْمَوْقِعِ الثَّانِي بَعْدَ «ob» فِي الْأَلْمَانِيَّةِ.',
        deicticPairs: [
          DeicticPair(
            directAr: 'هَلْ تَبْدَأُ... غَدًا؟',
            indirectAr: 'سَأَلَ هَلْ تَبْدَأُ... فِي الْيَوْمِ التَّالِي',
            directEn: 'Does ... start tomorrow?',
            indirectEn: 'whether ... started the next day',
            directDe: 'Beginnt ... morgen?',
            indirectDe: 'ob ... am nächsten Tag beginne',
          ),
        ],
        registerTag: 'Academic Dialogue',
      ),
      ReportedSpeechScenario(
        id: 'rs_04',
        category: ReportedSpeechCategory.imperativeReporting,
        titleAr: 'نَقْلُ الْأَمْرِ وَالنَّهْيِ وَصِيَغُ التَّوْجِيهِ الْمُؤَدَّبِ',
        titleEn: 'Reporting Imperatives: Infinitival vs. Modal Jussive',
        titleDe: 'Indirekte Aufforderungen mit „sollen“ und „mögen“',
        directAr: 'أَوْصَى الْمُشْرِفُ الْمُتَدَرِّبَ: «رَاجِعِ الْمَصَادِرَ قَبْلَ النَّشْرِ».',
        indirectAr: 'أَوْصَى الْمُشْرِفُ الْمُتَدَرِّبَ بِأَنْ يُرَاجِعَ الْمَصَادِرَ قَبْلَ النَّشْرِ.',
        directEn: 'The supervisor advised the trainee: "Review the sources before publishing."',
        indirectEn: 'The supervisor advised the trainee to review the sources before publishing.',
        directDe: 'Der Betreuer riet dem Praktikanten: „Prüfen Sie die Quellen vor der Veröffentlichung!“',
        indirectDe: 'Der Betreuer riet dem Praktikanten, er solle die Quellen vor der Veröffentlichung prüfen.',
        grammarRuleAr:
            'يُنْقَلُ الْأَمْرُ فِي الْعَرَبِيَّةِ عَبْرَ «أَنْ + الْمُضَارِعُ الْمَنْصُوبُ» بَعْدَ أَفْعَالِ التَّوْجِيهِ وَالطَّلَبِ مِثْلَ (أَمَرَ، أَوْصَى، طَلَبَ).',
        grammarRuleEn:
            'Direct imperatives become "to-infinitive" clauses after object-control verbs ("advised X to review").',
        grammarRuleDe:
            'Der Imperativ wird im Deutschen durch „sollen“ (neutrale Aufforderung) oder „mögen“ (höfliche Bitte) im Konjunktiv I ersetzt.',
        pitfallNoteAr:
            'تَجَنَّبْ تَرْجَمَةَ «er soll» حَرْفِيًّا بِمَعْنَى الْوُجُوبِ الْمُطْلَقِ؛ فَهِيَ هُنَا أَدَاةٌ نَحْوِيَّةٌ لِنَقْلِ الْأَمْرِ.',
        deicticPairs: [
          DeicticPair(
            directAr: 'رَاجِعْ (أَمْرٌ)',
            indirectAr: 'بِأَنْ يُرَاجِعَ',
            directEn: 'Review!',
            indirectEn: 'advised ... to review',
            directDe: 'Prüfen Sie!',
            indirectDe: 'er solle ... prüfen',
          ),
        ],
        registerTag: 'Professional / Advisory',
      ),
      ReportedSpeechScenario(
        id: 'rs_05',
        category: ReportedSpeechCategory.deicticReanchoring,
        titleAr: 'إِعَادَةُ إِرْسَاءِ الظُّرُوفِ الزَّمَانِيَّةِ وَالْمَكَانِيَّةِ',
        titleEn: 'Deictic Shifting: Time, Place & Demonstrative Anchors',
        titleDe: 'Deiktische Transformation von Zeit-, Orts- und Personenangaben',
        directAr: 'قَالَ الْمُهَنْدِسُ: «سَنَفْتَتِحُ هَذَا الْمَخْبَرَ هُنَا الْيَوْمَ».',
        indirectAr: 'صَرَّحَ الْمُهَنْدِسُ أَنَّهُمْ سَيَفْتَتِحُونَ ذَلِكَ الْمَخْبَرَ هُنَاكَ فِي ذَلِكَ الْيَوْمِ.',
        directEn: 'The engineer said: "We will open this lab here today."',
        indirectEn: 'The engineer announced that they would open that lab there on that day.',
        directDe: 'Der Ingenieur sagte: „Wir werden dieses Labor heute hier eröffnen.“',
        indirectDe: 'Der Ingenieur kündigte an, sie würden jenes Labor an jenem Tag dort eröffnen.',
        grammarRuleAr:
            'تَتَحَوَّلُ أَسْمَاءُ الْإِشَارَةِ لِلْقَرِيبِ (هَذَا، هُنَا) وَالظُّرُوفُ الْآنِيَّةُ (الْيَوْمَ، الْآنَ) إِلَى صِيَغِ الْبُعْدِ عِنْدَ انْقِطَاعِ السِّيَاقِ الْمُبَاشِرِ.',
        grammarRuleEn:
            'Proximal deictics ("this", "here", "today") shift to distal anchors ("that", "there", "that day") when reported from outside the original context.',
        grammarRuleDe:
            'Deiktische Ausdrücke passen sich der Sprecherperspektive an: „dieses“ -> „jenes“, „heute“ -> „an jenem Tag“, „hier“ -> „dort“.',
        pitfallNoteAr:
            'إِذَا كَانَ النَّاقِلُ مَا زَالَ فِي نَفْسِ الْمَكَانِ أَوْ نَفْسِ الْيَوْمِ، جَازَ إِبْقَاءُ «هُنَا» وَ«الْيَوْمَ» بِحَسَبِ الصِّدْقِ الْوَاقِعِيِّ.',
        deicticPairs: [
          DeicticPair(
            directAr: 'هَذَا / هُنَا / الْيَوْمَ',
            indirectAr: 'ذَلِكَ / هُنَاكَ / فِي ذَلِكَ الْيَوْمِ',
            directEn: 'this / here / today',
            indirectEn: 'that / there / on that day',
            directDe: 'dieses / hier / heute',
            indirectDe: 'jenes / dort / an jenem Tag',
          ),
        ],
        registerTag: 'Narrative / Technical',
      ),
      ReportedSpeechScenario(
        id: 'rs_06',
        category: ReportedSpeechCategory.universalTruthException,
        titleAr: 'ثَبَاتُ الزَّمَنِ عِنْدَ نَقْلِ الْحَقَائِقِ الْعِلْمِيَّةِ وَالْقَوَانِينِ الثَّابِتَةِ',
        titleEn: 'No-Backshift Rule for Universal Truths & Timeless Laws',
        titleDe: 'Zeitlose Wahrheiten: Indikativ Präsens oder Konjunktiv I',
        directAr: 'قَالَ الْمُعَلِّمُ: «الْمَاءُ يَغْلِي عِنْدَ مِئَةِ دَرَجَةٍ مِئَوِيَّةٍ».',
        indirectAr: 'أَخْبَرَ الْمُعَلِّمُ تَلَامِيذَهُ أَنَّ الْمَاءَ يَغْلِي عِنْدَ مِئَةِ دَرَجَةٍ مِئَوِيَّةٍ.',
        directEn: 'The teacher said: "Water boils at one hundred degrees Celsius."',
        indirectEn: 'The teacher told his students that water boils at one hundred degrees Celsius.',
        directDe: 'Der Lehrer sagte: „Wasser kocht bei hundert Grad Celsius.“',
        indirectDe: 'Der Lehrer erklärte seinen Schülern, dass Wasser bei hundert Grad Celsius kocht.',
        grammarRuleAr:
            'الْحَقَائِقُ الْعِلْمِيَّةُ وَالْعَادَاتُ الْمُسْتَمِرَّةُ تَلْزَمُ صِيغَةَ الْمُضَارِعِ الدَّالِّ عَلَى الدَّوَامِ وَلَا تَتَأَثَّرُ بِمُضِيِّ فِعْلِ الْقَوْلِ.',
        grammarRuleEn:
            'Present simple ("boils") is preserved even after a past reporting verb ("told") when stating a timeless scientific fact.',
        grammarRuleDe:
            'Bei allgemein gültigen Tatsachen bleibt häufig der Indikativ Präsens („kocht“) stehen, um die Faktizität zu betonen.',
        pitfallNoteAr:
            'التَّحْوِيلُ الْآلِيُّ إِلَى «boiled» فِي هَذِهِ الْجُمْلَةِ قَدْ يُوهِمُ أَنَّ الْحَقِيقَةَ تَغَيَّرَتْ أَوْ انْتَهَتْ فِي الْمَاضِي.',
        deicticPairs: [
          DeicticPair(
            directAr: 'يَغْلِي (حَقِيقَةٌ ثَابِتَةٌ)',
            indirectAr: 'يَغْلِي (يَبْقَى مُضَارِعًا)',
            directEn: 'boils',
            indirectEn: 'boils (no backshift)',
            directDe: 'kocht',
            indirectDe: 'kocht (Indikativ Präsens)',
          ),
        ],
        registerTag: 'Scientific / Educational',
      ),
    ];
  }

  List<ReportedSpeechDrill> getDrills() {
    return const [
      ReportedSpeechDrill(
        id: 'drill_01',
        category: ReportedSpeechCategory.declarativeShift,
        targetLanguage: 'Arabic',
        promptAr: 'اخْتَرِ الضَّبْطَ الصَّحِيحَ لِهَمْزَةِ «إنّ/أنّ» بَعْدَ فِعْلِ الْقَوْلِ: «قَالَ الشَّاهِدُ: ... الْحَقَّ وَاضِحٌ».',
        promptEn: 'Choose the correct hamza vocalization after "qala" (said).',
        promptDe: 'Wählen Sie die korrekte Vokalisation nach „qala“.',
        options: [
          'إِنَّ الْحَقَّ وَاضِحٌ',
          'أَنَّ الْحَقَّ وَاضِحٌ',
          'أَنَّ الْحَقُّ وَاضِحٌ',
        ],
        correctIndex: 0,
        explanationAr: 'تُكْسَرُ هَمْزَةُ «إِنَّ» وُجُوبًا إِذَا وَقَعَتْ فِي أَوَّلِ جُمْلَةِ مَقُولِ الْقَوْلِ.',
      ),
      ReportedSpeechDrill(
        id: 'drill_02',
        category: ReportedSpeechCategory.konjunktivEvidential,
        targetLanguage: 'German',
        promptAr: 'أَيُّ الصِّيَغِ الْأَلْمَانِيَّةِ أَصَحُّ لِنَقْلِ قَوْلِ الْجَمْعِ: „Sie sagten, wir haben Zeit“؟',
        promptEn: 'Which German indirect speech form correctly avoids Indikativ overlap for 3rd person plural?',
        promptDe: 'Welche Form der indirekten Rede vermeidet die Formengleichheit mit dem Indikativ?',
        options: [
          'Sie sagten, sie haben Zeit.',
          'Sie sagten, sie hätten Zeit.',
          'Sie sagten, sie hat Zeit.',
        ],
        correctIndex: 1,
        explanationAr: 'لِأَنَّ «sie haben» تَتَطَابَقُ فِي الْمُضَارِعِ الْمَرْفُوعِ وَKonjunktiv I، نَنْتَقِلُ إِلَى Konjunktiv II: «sie hätten».',
      ),
      ReportedSpeechDrill(
        id: 'drill_03',
        category: ReportedSpeechCategory.interrogativeReported,
        targetLanguage: 'German',
        promptAr: 'حَوِّلِ السُّؤَالَ إِلَى خِطَابٍ غَيْرِ مُبَاشِرٍ: „Kommt der Zug pünktlich?“',
        promptEn: 'Convert the German yes/no question into indirect speech.',
        promptDe: 'Wandeln Sie die Entscheidungsfrage in indirekte Rede um.',
        options: [
          'Er fragte, ob kommt der Zug pünktlich.',
          'Er fragte, dass der Zug pünktlich komme.',
          'Er fragte, ob der Zug pünktlich komme.',
        ],
        correctIndex: 2,
        explanationAr: 'أَسْئِلَةُ «نَعَمْ/لَا» تُرْبَطُ بِـ «ob» وَيَنْتَقِلُ الْفِعْلُ الْمُصَرَّفُ (komme) إِلَى آخِرِ الْجُمْلَةِ.',
      ),
      ReportedSpeechDrill(
        id: 'drill_04',
        category: ReportedSpeechCategory.imperativeReporting,
        targetLanguage: 'German',
        promptAr: 'كَيْفَ تَنْقُلُ الْأَمْرَ: „Schreiben Sie den Bericht!“ بِأُسْلُوبٍ صَحَفِيٍّ مُحَايِدٍ؟',
        promptEn: 'How do you report the formal imperative neutrally in German?',
        promptDe: 'Wie gibt man den Imperativ neutral in der indirekten Rede wieder?',
        options: [
          'Er sagte, man solle den Bericht schreiben.',
          'Er sagte, man schreibt den Bericht.',
          'Er sagte, schreiben den Bericht.',
        ],
        correctIndex: 0,
        explanationAr: 'يُسْتَعْمَلُ الْفِعْلُ النَّاقِصُ «sollen» فِي صِيغَةِ Konjunktiv I («solle») لِنَقْلِ الْأَمْرِ وَالتَّوْجِيهِ.',
      ),
      ReportedSpeechDrill(
        id: 'drill_05',
        category: ReportedSpeechCategory.deicticReanchoring,
        targetLanguage: 'English',
        promptAr: 'مَا التَّحْوِيلُ الْإِشَارِيُّ الدَّقِيقُ لِجُمْلَةِ: She said, "I will finish this here tomorrow."؟',
        promptEn: 'Select the accurate deictic & tense backshift for the reported sentence.',
        promptDe: 'Wählen Sie die korrekte deiktische Verschiebung im Englischen.',
        options: [
          'She said she will finish this here tomorrow.',
          'She said she would finish that there the next day.',
          'She said she would finish this there yesterday.',
        ],
        correctIndex: 1,
        explanationAr: 'تَتَحَوَّلُ will -> would، وَthis -> that، وَhere -> there، وَtomorrow -> the next day.',
      ),
      ReportedSpeechDrill(
        id: 'drill_06',
        category: ReportedSpeechCategory.universalTruthException,
        targetLanguage: 'English',
        promptAr: 'اخْتَرِ الصِّيغَةَ الْأَدَقَّ لِنَقْلِ حَقِيقَةٍ عِلْمِيَّةٍ ثَابِتَةٍ:',
        promptEn: 'Choose the most accurate indirect report of a timeless scientific fact:',
        promptDe: 'Wählen Sie die präziseste Wiedergabe einer zeitlosen wissenschaftlichen Tatsache:',
        options: [
          'The professor reminded us that the Earth revolves around the Sun.',
          'The professor reminded us that the Earth was revolving around the Sun.',
          'The professor reminded us that the Earth had revolved around the Sun.',
        ],
        correctIndex: 0,
        explanationAr: 'الْحَقَائِقُ الثَّابِتَةُ تَحْتَفِظُ بِالْمُضَارِعِ الْبَسِيطِ (revolves) رَغْمَ مُضِيِّ فِعْلِ النَّقْلِ (reminded).',
      ),
    ];
  }
}
