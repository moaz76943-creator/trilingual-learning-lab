import '../models/nominalization_models.dart';

class NominalizationRepository {
  const NominalizationRepository();

  List<NominalizationLesson> getLessons() {
    return const [
      NominalizationLesson(
        id: 'nm_01',
        type: NominalizationPatternType.verbalNounInfinitive,
        titleAr: 'الْمَصْدَرُ الْقِيَاسِيُّ لِلْأَفْعَالِ الْمَزِيدَةِ وَالْمَصْدَرُ الْأَلْمَانِيُّ الْمُحَايِدُ',
        titleEn: 'Derived Arabic Masdar vs. German Substantivized Infinitive',
        titleDe: 'Substantivierter Infinitiv (immer Neutrum: das)',
        verbalFormAr: 'يَقْرَأُ الطَّالِبُ النَّصَّ بِتَأَنٍّ؛ وَيَسْتَخْرِجُ الْمَعَانِيَ.',
        nominalFormAr: 'قِرَاءَةُ الطَّالِبِ النَّصَّ بِتَأَنٍّ وَاسْتِخْرَاجُهُ الْمَعَانِيَ يُعَمِّقَانِ الْفَهْمَ.',
        verbalFormEn: 'The student reads the text carefully and extracts the meanings.',
        nominalFormEn: 'Careful reading of the text and extracting the meanings deepen comprehension.',
        verbalFormDe: 'Der Student liest den Text sorgfältig und erschließt die Bedeutungen.',
        nominalFormDe: 'Das sorgfältige Lesen des Textes und das Erschließen der Bedeutungen vertiefen das Verständnis.',
        morphologyRuleAr:
            'تُقَاسُ مَصَادِرُ الرُّبَاعِيِّ وَالْخُمَاسِيِّ وَالسُّدَاسِيِّ قِيَاسًا مُطَّرِدًا (اسْتَخْرَجَ ← اسْتِخْرَاجٌ، عَلَّمَ ← تَعْلِيمٌ)، بَيْنَمَا يَكْثُرُ السَّمَاعُ فِي الثُّلَاثِيِّ.',
        morphologyRuleEn:
            'English forms gerunds productively with "-ing" ("reading") alongside Latinate action nouns ("extraction").',
        morphologyRuleDe:
            'Jeder deutsche Infinitiv lässt sich durch Großschreibung zum sächlichen Nomen (Neutrum: das Lesen, beim Schreiben, zum Verstehen) substantivieren.',
        pitfallNoteAr:
            'فِي الْأَلْمَانِيَّةِ يَجِبُ كِتَابَةُ الْمَصْدَرِ الِاسْمِيِّ بِحَرْفٍ كَبِيرٍ وَإِسْنَادُ أَدَاةِ الْمُحَايِدِ «das» إِلَيْهِ دَائِمًا.',
        matrixEntries: [
          DerivationMatrixEntry(
            baseVerbOrAdj: 'عَلَّمَ / teach / lehren',
            derivedNounAr: 'تَعْلِيمٌ (تَفْعِيلٌ)',
            derivedNounEn: 'teaching / instruction',
            derivedNounDe: 'das Lehren',
            genderOrPatternTag: 'فَعَّلَ ← تَفْعِيلٌ | das',
          ),
          DerivationMatrixEntry(
            baseVerbOrAdj: 'اسْتَخْرَجَ / extract / erschließen',
            derivedNounAr: 'اسْتِخْرَاجٌ (اسْتِفْعَالٌ)',
            derivedNounEn: 'extraction',
            derivedNounDe: 'das Erschließen',
            genderOrPatternTag: 'اسْتَفْعَلَ ← اسْتِفْعَالٌ | das',
          ),
        ],
      ),
      NominalizationLesson(
        id: 'nm_02',
        type: NominalizationPatternType.suffixGenderDerivation,
        titleAr: 'الْمَصْدَرُ الصِّنَاعِيُّ (-يَّة) وَحَتْمِيَّةُ الْجِنْسِ فِي اللَّوَاحِقِ الْأَلْمَانِيَّةِ',
        titleEn: 'Abstract "-iyya" Nouns & German Suffix-Driven Gender',
        titleDe: 'Abstrakta auf -ung, -heit, -keit, -schaft (immer feminin)',
        verbalFormAr: 'نَتَحَمَّلُ الْمَسْؤُولِيَّةَ وَنَحْرِصُ عَلَى الْمَوْضُوعِيَّةِ.',
        nominalFormAr: 'الْمَسْؤُولِيَّةُ وَالْمَوْضُوعِيَّةُ وَالْوُضُوحُ أَسَاسُ الْبَحْثِ.',
        verbalFormEn: 'We act responsibly and aim to be objective and clear.',
        nominalFormEn: 'Responsibility, objectivity, and clarity form the basis of research.',
        verbalFormDe: 'Wir handeln verantwortlich und streben danach, objektiv und klar zu bleiben.',
        nominalFormDe: 'Die Verantwortung, die Objektivität und die Klarheit bilden die Grundlage der Forschung.',
        morphologyRuleAr:
            'يُصَاغُ الْمَصْدَرُ الصِّنَاعِيُّ بِزِيَادَةِ يَاءٍ مُشَدَّدَةٍ وَتَاءِ تَأْنِيثٍ (ـيَّة) عَلَى الْكَلِمَةِ لِلدَّلَالَةِ عَلَى الْمَفْهُومِ الْمُجَرَّدِ (مَسْؤُولٌ ← مَسْؤُولِيَّةٌ) بِشَرْطِ أَلَّا يَقَعَ نَعْتًا.',
        morphologyRuleEn:
            'English derives abstract quality nouns via "-ity", "-ness", and "-tion" ("clarity", "responsibility").',
        morphologyRuleDe:
            'Nomen auf -ung, -heit, -keit, -schaft und -tät sind im Deutschen ausnahmslos feminin (die).',
        pitfallNoteAr:
            'إِذَا وَقَعَتِ الْكَلِمَةُ الْمُخْتَتَمَةُ بـ «ـيَّة» نَعْتًا (مِثْلَ: الدِّرَاسَةُ الْعِلْمِيَّةُ) فَهِيَ اسْمٌ مَنْسُوبٌ لَا مَصْدَرٌ صِنَاعِيٌّ.',
        matrixEntries: [
          DerivationMatrixEntry(
            baseVerbOrAdj: 'مَوْضُوعِيٌّ / objective / objektiv',
            derivedNounAr: 'الْمَوْضُوعِيَّةُ',
            derivedNounEn: 'objectivity',
            derivedNounDe: 'die Objektivität',
            genderOrPatternTag: 'صِنَاعِيٌّ | die (-tät)',
          ),
          DerivationMatrixEntry(
            baseVerbOrAdj: 'وَاضِحٌ / clear / klar',
            derivedNounAr: 'الْوُضُوحُ',
            derivedNounEn: 'clarity',
            derivedNounDe: 'die Klarheit',
            genderOrPatternTag: 'فُعُولٌ | die (-heit)',
          ),
        ],
      ),
      NominalizationLesson(
        id: 'nm_03',
        type: NominalizationPatternType.clausalNominalization,
        titleAr: 'الْمَصْدَرُ الْمُؤَوَّلُ مُقَابِلَ الْأُسْلُوبِ الِاسْمِيِّ الْأَلْمَانِيِّ (Nominalstil)',
        titleEn: 'Clausal Nominalization vs. German Academic Nominalstil',
        titleDe: 'Transformation: Nebensatz (Verbalstil) ↔ Präpositionalgruppe (Nominalstil)',
        verbalFormAr: 'يَسُرُّنِي أَنْ تُتْقِنَ اللُّغَاتِ الثَّلَاثَ؛ وَصَلَ قَبْلَ أَنْ يَبْدَأَ الدَّرْسُ.',
        nominalFormAr: 'يَسُرُّنِي إِتْقَانُكَ اللُّغَاتِ الثَّلَاثَ؛ وَصَلَ قَبْلَ بَدْءِ الدَّرْسِ.',
        verbalFormEn: 'He arrived before the lesson began.',
        nominalFormEn: 'He arrived prior to the commencement of the lesson.',
        verbalFormDe: 'Er traf ein, bevor der Unterricht begann.',
        nominalFormDe: 'Er traf vor Beginn des Unterrichts ein.',
        morphologyRuleAr:
            'يَتَكَوَّنُ الْمَصْدَرُ الْمُؤَوَّلُ مِنْ «أَنْ + الْمُضَارِعُ» أَوْ «أَنَّ + اسْمِهَا وَخَبَرِهَا» وَيُؤَوَّلُ بِمَصْدَرٍ صَرِيحٍ لَهُ مَحَلٌّ مِنَ الْإِعْرَابِ.',
        morphologyRuleEn:
            'Academic English compresses temporal/causal clauses ("before the lesson began") into prepositional noun phrases ("prior to the commencement").',
        morphologyRuleDe:
            'Der deutsche Nominalstil ersetzt Nebensätze („bevor... begann“) durch Präposition + Nomen im Genitiv/Dativ („vor Beginn des Unterrichts“).',
        pitfallNoteAr:
            'الْإِفْرَاطُ فِي الْأُسْلُوبِ الِاسْمِيِّ يُثْقِلُ السَّرْدَ؛ فَالتَّوَازُنُ بَيْنَ الْأُسْلُوبِ الْفِعْلِيِّ وَالِاسْمِيِّ ضَرُورِيٌّ لِسَلَاسَةِ النَّصِّ.',
        matrixEntries: [
          DerivationMatrixEntry(
            baseVerbOrAdj: 'قَبْلَ أَنْ يَبْدَأَ / before it began / bevor es begann',
            derivedNounAr: 'قَبْلَ بَدْءِ...',
            derivedNounEn: 'prior to the start of...',
            derivedNounDe: 'vor Beginn (+ Genitiv)',
            genderOrPatternTag: 'تَأْوِيلُ الْمَصْدَرِ | Nominalstil',
          ),
        ],
      ),
      NominalizationLesson(
        id: 'nm_04',
        type: NominalizationPatternType.gerundVsInfinitive,
        titleAr: 'إِعْمَالُ الْمَصْدَرِ وَنَصْبُهُ لِلْمَفْعُولِ مُقَابِلَ الْجِرَانْدِ الْإِنْجِلِيزِيِّ',
        titleEn: 'Verbal Governance Inside Nominalizations (Iʿmal al-Masdar & Gerunds)',
        titleDe: 'Objektanschluss bei Nominalisierungen (Genitivattribut vs. Akkusativ)',
        verbalFormAr: 'أَنْ يُكْرِمَ الْمَرْءُ الضَّيْفَ خُلُقٌ كَرِيمٌ.',
        nominalFormAr: 'إِكْرَامُ الْمَرْءِ الضَّيْفَ خُلُقٌ كَرِيمٌ.',
        verbalFormEn: 'To honor a guest is a noble virtue.',
        nominalFormEn: 'Honoring a guest (or: one’s honoring of a guest) is a noble virtue.',
        verbalFormDe: 'Einen Gast zu ehren, ist eine edle Tugend.',
        nominalFormDe: 'Die Ehrung des Gastes ist eine edle Tugend.',
        morphologyRuleAr:
            'يَعْمَلُ الْمَصْدَرُ عَمَلَ فِعْلِهِ فَيُضَافُ إِلَى فَاعِلِهِ (الْمَرْءِ) وَيَنْصِبُ الْمَفْعُولَ بِهِ (الضَّيْفَ).',
        morphologyRuleEn:
            'An English verbal gerund ("honoring a guest") retains direct object governance, whereas a derived nominal ("the honoring of a guest") requires "of".',
        morphologyRuleDe:
            'Wird ein Verb durch „-ung“ nominalisiert („die Ehrung“), verwandelt sich das Akkusativobjekt in ein Genitivattribut („des Gastes“).',
        pitfallNoteAr:
            'فِي الْأَلْمَانِيَّةِ لَا يُمْكِنُ إِبْقَاءُ الْمَفْعُولِ الْمَنْصُوبِ بَعْدَ اسْمِ «-ung» مِثْلَ *die Ehrung einen Gast؛ بَلْ يَلْزَمُ الْإِضَافَةُ (Genitiv).',
        matrixEntries: [
          DerivationMatrixEntry(
            baseVerbOrAdj: 'أَكْرَمَ الضَّيْفَ / honor the guest / den Gast ehren',
            derivedNounAr: 'إِكْرَامُ الْمَرْءِ الضَّيْفَ',
            derivedNounEn: 'honoring a guest',
            derivedNounDe: 'die Ehrung des Gastes',
            genderOrPatternTag: 'إِعْمَالُ الْمَصْدَرِ | Genitivattribut',
          ),
        ],
      ),
      NominalizationLesson(
        id: 'nm_05',
        type: NominalizationPatternType.instanceAndMannerNouns,
        titleAr: 'اسْمُ الْمَرَّةِ (فَعْلَةٌ) وَاسْمُ الْهَيْئَةِ (فِعْلَةٌ) وَتَحْدِيدُ الْحَدَثِ',
        titleEn: 'Nouns of Single Instance vs. Manner of Action',
        titleDe: 'Ausdruck von Einmaligkeit (einmaliges...) und Art und Weise',
        verbalFormAr: 'جَلَسَ الطَّالِبُ وَقَرَأَ قِرَاءَةً وَاحِدَةً.',
        nominalFormAr: 'جَلَسَ الطَّالِبُ جِلْسَةَ الْمُتَأَمِّلِ، وَأَلْقَى نَظْرَةً وَاحِدَةً.',
        verbalFormEn: 'He looked once and sat in a contemplative manner.',
        nominalFormEn: 'He took a single glance and sat with the posture of a thinker.',
        verbalFormDe: 'Er blickte einmal hin und saß nachdenklich da.',
        nominalFormDe: 'Er warf einen einzigen Blick und nahm die Haltung eines Nachdenkenden ein.',
        morphologyRuleAr:
            'يُصَاغُ اسْمُ الْمَرَّةِ مِنَ الثُّلَاثِيِّ عَلَى وَزْنِ «فَعْلَة» (نَظْرَةٌ، جَلْسَةٌ)، وَاسْمُ الْهَيْئَةِ عَلَى وَزْنِ «فِعْلَة» (جِلْسَةٌ، مِشْيَةٌ).',
        morphologyRuleEn:
            'English and German lack dedicated morphological templates for instance/manner, relying on light-verb frames ("take a glance", "einen Blick werfen").',
        morphologyRuleDe:
            'Das Deutsche nutzt Funktionsverbgefüge („einen Blick werfen“, „eine Haltung einnehmen“) zur Wiedergabe von arabischem Ism al-Marra und Ism al-Hay’a.',
        pitfallNoteAr:
            'إِذَا كَانَ الْمَصْدَرُ الْأَصْلِيُّ مَخْتُومًا بِتَاءٍ (مِثْلَ: رَحْمَة، دَعْوَة) وَصَفْنَاهُ بـ «وَاحِدَة» لِلدَّلَالَةِ عَلَى الْمَرَّةِ.',
        matrixEntries: [
          DerivationMatrixEntry(
            baseVerbOrAdj: 'جَلَسَ / sit / sitzen',
            derivedNounAr: 'جَلْسَةٌ (مَرَّة) / جِلْسَةٌ (هَيْئَة)',
            derivedNounEn: 'a single sitting / posture',
            derivedNounDe: 'das einmalige Sitzen / die Sitzhaltung',
            genderOrPatternTag: 'فَعْلَةٌ vs. فِعْلَةٌ',
          ),
        ],
      ),
      NominalizationLesson(
        id: 'nm_06',
        type: NominalizationPatternType.participialNominalization,
        titleAr: 'اسْتِقْلَالُ اسْمِ الْفَاعِلِ وَالْمَفْعُولِ وَالْمُشْتَقَّاتِ الْمُصَرَّفَةِ أَلْمَانِيًّا',
        titleEn: 'Nominalized Participles & Adjective-Like Declension',
        titleDe: 'Substantivierte Partizipien (der Studierende / das Gesagte)',
        verbalFormAr: 'الَّذِينَ يَتَعَلَّمُونَ يَتَعَاوَنُونَ؛ وَمَا قِيلَ وَاضِحٌ.',
        nominalFormAr: 'الْمُتَعَلِّمُونَ مُتَعَاوِنُونَ؛ وَالْمَقُولُ وَاضِحٌ.',
        verbalFormEn: 'Those who are learning collaborate; what was said is clear.',
        nominalFormEn: 'The learners collaborate; what was stated is clear.',
        verbalFormDe: 'Diejenigen, die lernen, arbeiten zusammen; was gesagt wurde, ist klar.',
        nominalFormDe: 'Die Lernenden arbeiten zusammen; das Gesagte ist klar.',
        morphologyRuleAr:
            'تُغْنِي الصِّيَغُ الْمُشْتَقَّةُ (الْمُتَعَلِّمُونَ، الْمَقُولُ) عَنِ الْجُمَلِ الْمَوْصُولَةِ الطَّوِيلَةِ وَتُكْسِبُ الْعِبَارَةَ إِيجَازًا.',
        morphologyRuleEn:
            'English uses "-er" agent nouns ("learners") or free relatives ("what was said"), as bare participial nouns ("the learned") are restricted.',
        morphologyRuleDe:
            'Substantivierte Partizipien (der/ein Lernende(r), das Gesagte) werden großgeschrieben, behalten aber die Adjektivdeklination bei!',
        pitfallNoteAr:
            'فِي الْأَلْمَانِيَّةِ يَتَغَيَّرُ آخِرُ «der Lernende» إِلَى «ein Lernender» مَعَ أَدَاةِ التَّنْكِيرِ لِأَنَّهُ يَتْبَعُ تَصْرِيفَ الصِّفَاتِ.',
        matrixEntries: [
          DerivationMatrixEntry(
            baseVerbOrAdj: 'تَعَلَّمَ / learn / lernen',
            derivedNounAr: 'الْمُتَعَلِّمُ / مُتَعَلِّمٌ',
            derivedNounEn: 'the learner',
            derivedNounDe: 'der Lernende / ein Lernender',
            genderOrPatternTag: 'Adjektivdeklination',
          ),
        ],
      ),
    ];
  }

  List<NominalizationDrill> getDrills() {
    return const [
      NominalizationDrill(
        id: 'nmd_01',
        type: NominalizationPatternType.verbalNounInfinitive,
        targetLanguage: 'German',
        promptAr: 'مَا الْأَدَاةُ التَّعْرِيفِيَّةُ الصَّحِيحَةُ لِأَيِّ مَصْدَرٍ فِعْلِيٍّ مُحَوَّلٍ إِلَى اسْمٍ فِي الْأَلْمَانِيَّةِ (مِثْلَ: Schreiben)؟',
        promptEn: 'What is the grammatical gender of any German substantivized infinitive?',
        promptDe: 'Welchen Artikel hat jeder substantivierte Infinitiv im Deutschen?',
        options: [
          'der (maskulin)',
          'die (feminin)',
          'das (neutrum)',
        ],
        correctIndex: 2,
        explanationAr: 'كُلُّ مَصْدَرٍ أَلْمَانِيٍّ يُحَوَّلُ إِلَى اسْمٍ يَكُونُ مُحَايِدًا (das) دَائِمًا: «das Schreiben».',
      ),
      NominalizationDrill(
        id: 'nmd_02',
        type: NominalizationPatternType.suffixGenderDerivation,
        targetLanguage: 'German',
        promptAr: 'أَيُّ الِاخْتِيَارَاتِ يَحْمِلُ الْأَدَاةَ الصَّحِيحَةَ لِلِاسْمِ الْمُخْتَتَمِ بـ «-keit»؟',
        promptEn: 'Select the correct article for a German noun ending in "-keit":',
        promptDe: 'Wählen Sie den korrekten Artikel für ein Nomen auf „-keit“:',
        options: [
          'der Fähigkeit',
          'die Fähigkeit',
          'das Fähigkeit',
        ],
        correctIndex: 1,
        explanationAr: 'اللَّاحِقَةُ «-keit» (مِثْلَ -heit وَ-ung) تَجْعَلُ الِاسْمَ مُؤَنَّثًا (die) دَائِمًا.',
      ),
      NominalizationDrill(
        id: 'nmd_03',
        type: NominalizationPatternType.clausalNominalization,
        targetLanguage: 'Arabic',
        promptAr: 'مَا التَّحْوِيلُ الصَّحِيحُ لِلْمَصْدَرِ الْمُؤَوَّلِ فِي: «يَنْبَغِي أَنْ يَسْتَفِيدَ الطَّالِبُ مِنَ الْوَقْتِ» إِلَى مَصْدَرٍ صَرِيحٍ؟',
        promptEn: 'Convert the Arabic Masdar Mu’awwal "an yastafīda" into an explicit Masdar:',
        promptDe: 'Wandeln Sie das arabische „an yastafīda“ in ein explizites Masdar um:',
        options: [
          'إِفَادَةُ الطَّالِبِ',
          'اسْتِفَادَةُ الطَّالِبِ',
          'تَفِيدُ الطَّالِبِ',
        ],
        correctIndex: 1,
        explanationAr: 'الْفِعْلُ «اسْتَفَادَ» سُدَاسِيٌّ، وَمَصْدَرُهُ الْقِيَاسِيُّ «اسْتِفَادَةٌ».',
      ),
      NominalizationDrill(
        id: 'nmd_04',
        type: NominalizationPatternType.gerundVsInfinitive,
        targetLanguage: 'German',
        promptAr: 'كَيْفَ نَرْبِطُ الْمَفْعُولَ بِهِ بَعْدَ الِاسْمِ الْمُشْتَقِّ «die Übersetzung»؟',
        promptEn: 'How is the object attached after the German -ung nominalization "die Übersetzung"?',
        promptDe: 'Wie wird das Objekt nach der Nominalisierung „die Übersetzung“ angeschlossen?',
        options: [
          'die Übersetzung den Text',
          'die Übersetzung des Textes',
          'die Übersetzung dem Text',
        ],
        correctIndex: 1,
        explanationAr: 'بَعْدَ الِاسْمِ الْمُشْتَقِّ بـ «-ung» يَتَحَوَّلُ الْمَفْعُولُ الْمَنْصُوبُ إِلَى مُضَافٍ إِلَيْهِ مَجْرُورٍ (Genitivattribut).',
      ),
      NominalizationDrill(
        id: 'nmd_05',
        type: NominalizationPatternType.instanceAndMannerNouns,
        targetLanguage: 'Arabic',
        promptAr: 'أَيُّ الصِّيغَتَيْنِ تَدُلُّ عَلَى الْهَيْئَةِ وَالصِّفَةِ فِي الْجُلُوسِ؟',
        promptEn: 'Which Arabic vocalization indicates the manner of sitting (Ism al-Hay’a)?',
        promptDe: 'Welche Form bezeichnet die Art und Weise des Sitzens (Ism al-Hay’a)?',
        options: [
          'جَلْسَةٌ (بِفَتْحِ الْجِيمِ)',
          'جِلْسَةٌ (بِكَسْرِ الْجِيمِ)',
          'جُلُوسٌ',
        ],
        correctIndex: 1,
        explanationAr: 'اسْمُ الْهَيْئَةِ مِنَ الثُّلَاثِيِّ يَأْتِي عَلَى وَزْنِ «فِعْلَة» بِكَسْرِ الْفَاءِ: «جِلْسَةٌ».',
      ),
      NominalizationDrill(
        id: 'nmd_06',
        type: NominalizationPatternType.participialNominalization,
        targetLanguage: 'German',
        promptAr: 'اخْتَرِ الصِّيغَةَ الصَّحِيحَةَ بَعْدَ أَدَاةِ التَّنْكِيرِ «ein» لِاسْمِ الْفَاعِلِ الْمُحَوَّلِ إِلَى اسْمٍ:',
        promptEn: 'Select the correct declension after "ein" for the nominalized participle:',
        promptDe: 'Wählen Sie die korrekte Deklination nach „ein“:',
        options: [
          'ein Studierende',
          'ein Studierender',
          'ein Studierenden',
        ],
        correctIndex: 1,
        explanationAr: 'الِاسْمُ الْمَأْخُوذُ مِنَ الصِّفَةِ أَوِ اسْمِ الْفَاعِلِ يَتْبَعُ إِعْرَابَ الصِّفَاتِ، فَيَأْخُذُ «-er» بَعْدَ «ein» فِي الْمُذَكَّرِ الْمَرْفُوعِ.',
      ),
    ];
  }
}
