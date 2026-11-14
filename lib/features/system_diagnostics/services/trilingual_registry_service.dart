import 'package:flutter/material.dart';

import '../../apposition_coordination/data/apposition_coordination_repository.dart';
import '../../apposition_coordination/screens/apposition_coordination_studio_screen.dart';
import '../../comprehension_cloze/data/comprehension_cloze_repository.dart';
import '../../comprehension_cloze/screens/comprehension_cloze_studio_screen.dart';
import '../../discourse_connectives/data/discourse_connectives_repository.dart';
import '../../discourse_connectives/screens/discourse_connectives_studio_screen.dart';
import '../../ellipsis_anaphora/data/ellipsis_anaphora_repository.dart';
import '../../ellipsis_anaphora/screens/ellipsis_anaphora_studio_screen.dart';
import '../../false_friends_register/data/false_friends_repository.dart';
import '../../false_friends_register/screens/false_friends_studio_screen.dart';
import '../../modal_verbs_deontic/data/modal_verbs_repository.dart';
import '../../modal_verbs_deontic/screens/modal_verbs_studio_screen.dart';
import '../../nominal_agreement_declension/data/nominal_agreement_repository.dart';
import '../../nominal_agreement_declension/screens/nominal_agreement_studio_screen.dart';
import '../../nominalization_morphology/data/nominalization_repository.dart';
import '../../nominalization_morphology/screens/nominalization_studio_screen.dart';
import '../../passive_voice_matrix/data/passive_voice_repository.dart';
import '../../passive_voice_matrix/screens/passive_voice_studio_screen.dart';
import '../../phonotactics_prosody/data/phonotactics_prosody_repository.dart';
import '../../phonotactics_prosody/screens/phonotactics_prosody_studio_screen.dart';
import '../../prepositional_government/data/prepositional_government_repository.dart';
import '../../prepositional_government/screens/prepositional_government_studio_screen.dart';
import '../../reflexive_reciprocal/data/reflexive_reciprocal_repository.dart';
import '../../reflexive_reciprocal/screens/reflexive_reciprocal_studio_screen.dart';
import '../../reported_speech/data/reported_speech_repository.dart';
import '../../reported_speech/screens/reported_speech_studio_screen.dart';
import '../../situational_dialogue/data/situational_dialogue_repository.dart';
import '../../situational_dialogue/screens/situational_dialogue_studio_screen.dart';
import '../../srs_mastery_engine/data/srs_seed_repository.dart';
import '../../srs_mastery_engine/screens/srs_mastery_studio_screen.dart';
import '../../verb_paradigm_matrix/data/verb_paradigm_repository.dart';
import '../../verb_paradigm_matrix/screens/verb_paradigm_studio_screen.dart';
import '../../word_order_topology/data/word_order_repository.dart';
import '../../word_order_topology/screens/word_order_studio_screen.dart';
import '../models/diagnostic_models.dart';

class TrilingualRegistryService {
  const TrilingualRegistryService();

  List<TrilingualStudioDescriptor> getRegisteredStudios() {
    return [
      TrilingualStudioDescriptor(
        id: 'reported_speech',
        taskNumber: 1220,
        group: StudioDomainGroup.discourseAndMastery,
        titleAr: 'مُخْتَبَرُ الْكَلَامِ الْمَنْقُولِ وَتَحَوُّلَاتِ الْإِحَالَةِ',
        titleEn: 'Reported Speech & Deictic Shift Studio',
        titleDe: 'Indirekte Rede (Konjunktiv I/II) & Deixis',
        summaryAr:
            'كَسْرُ هَمْزَةِ إِنَّ بَعْدَ الْقَوْلِ، التَّرْجِيعُ الزَّمَنِيُّ، وَصِيغَةُ Konjunktiv I/II مَعَ تَحَوُّلَاتِ الزَّمَانِ وَالْمَكَانِ.',
        icon: Icons.record_voice_over_outlined,
        builder: (_) => const ReportedSpeechStudioScreen(),
      ),
      TrilingualStudioDescriptor(
        id: 'ellipsis_anaphora',
        taskNumber: 1221,
        group: StudioDomainGroup.syntaxAndGrammar,
        titleAr: 'مُخْتَبَرُ الْحَذْفِ وَالتَّقْدِيرِ وَالْإِحَالَةِ الضَّمِيرِيَّةِ',
        titleEn: 'Ellipsis, Gapping, Sluicing & Pro-Forms Studio',
        titleDe: 'Ellipse, Verb-Gapping, Sluicing & Pronominaladverbien',
        summaryAr:
            'حَذْفُ الْفِعْلِ وَالْمُضَافِ وَالْخَبَرِ بَعْدَ «لَوْلَا» مُقَابِلَ Gapping وَSluicing وَالشَّرْطَةِ الصَّرْفِيَّةِ الْأَلْمَانِيَّةِ.',
        icon: Icons.auto_fix_high_outlined,
        builder: (_) => const EllipsisAnaphoraStudioScreen(),
      ),
      TrilingualStudioDescriptor(
        id: 'apposition_coordination',
        taskNumber: 1222,
        group: StudioDomainGroup.syntaxAndGrammar,
        titleAr: 'مُخْتَبَرُ الْبَدَلِ وَالْعَطْفِ وَالْجُمْلَةِ الِاعْتِرَاضِيَّةِ',
        titleEn: 'Apposition, Coordination & Parenthetical Studio',
        titleDe: 'Apposition, Kasus-Kongruenz & Koordination (sondern/aber)',
        summaryAr:
            'الْبَدَلُ الْمُطَابِقُ وَبَدَلُ الْبَعْضِ وَالِاشْتِمَالِ، وَدَقَائِقُ حُرُوفِ الْعَطْفِ وَالْإِضْرَابِ بـ «بَلْ / sondern».',
        icon: Icons.account_tree_outlined,
        builder: (_) => const AppositionCoordinationStudioScreen(),
      ),
      TrilingualStudioDescriptor(
        id: 'prepositional_government',
        taskNumber: 1223,
        group: StudioDomainGroup.syntaxAndGrammar,
        titleAr: 'مُخْتَبَرُ حُرُوفِ الْجَرِّ وَالتَّعَدِّي اللُّغَوِيِّ',
        titleEn: 'Prepositional Semantics & Verbal Valency Studio',
        titleDe: 'Wechselpräpositionen (Dativ/Akkusativ) & Verb-Rektion',
        summaryAr:
            'الْمُقَارَنَةُ بَيْنَ السُّكُونِ (Wo? Dativ) وَالْحَرَكَةِ (Wohin? Akkusativ) وَتَبَدُّلِ مَعْنَى الْفِعْلِ بِحَرْفِ الْجَرِّ.',
        icon: Icons.alt_route_rounded,
        builder: (_) => const PrepositionalGovernmentStudioScreen(),
      ),
      TrilingualStudioDescriptor(
        id: 'nominalization_morphology',
        taskNumber: 1224,
        group: StudioDomainGroup.morphologyAndPhonology,
        titleAr: 'مُخْتَبَرُ الْمَصَادِرِ وَالِاسْمِيَّةِ وَالِاشْتِقَاقِ',
        titleEn: 'Nominalization, Masdar & Derivational Morphology Studio',
        titleDe: 'Substantivierung, Nominalstil & Genus-Suffixe',
        summaryAr:
            'الْمَصْدَرُ الصَّرِيحُ وَالصِّنَاعِيُّ وَالْمُؤَوَّلُ، وَإِعْمَالُ الْمَصْدَرِ، وَقَوَاعِدُ جِنْسِ الْأَسْمَاءِ الْمُشْتَقَّةِ فِي الْأَلْمَانِيَّةِ.',
        icon: Icons.transform_rounded,
        builder: (_) => const NominalizationStudioScreen(),
      ),
      TrilingualStudioDescriptor(
        id: 'phonotactics_prosody',
        taskNumber: 1225,
        group: StudioDomainGroup.morphologyAndPhonology,
        titleAr: 'مُخْتَبَرُ الصَّوْتِيَّاتِ وَالْإِدْغَامِ وَالنَّبْرِ',
        titleEn: 'Phonotactics, Assimilation & Prosodic Stress Studio',
        titleDe: 'Auslautverhärtung, Ich-/Ach-Laut & Wortakzent',
        summaryAr:
            'الْإِبْدَالُ الصَّوْتِيُّ، وَتَوْزِيعُ صَوْتَيِ [ç] وَ[x]، وَأَثَرُ النَّبْرِ فِي فَصْلِ السَّوَابِقِ الْفِعْلِيَّةِ الْأَلْمَانِيَّةِ.',
        icon: Icons.graphic_eq_rounded,
        builder: (_) => const PhonotacticsProsodyStudioScreen(),
      ),
      TrilingualStudioDescriptor(
        id: 'discourse_connectives',
        taskNumber: 1226,
        group: StudioDomainGroup.discourseAndMastery,
        titleAr: 'مُخْتَبَرُ الرَّوَابِطِ النَّصِّيَّةِ وَتَمَاسُكِ الْفَقْرَةِ',
        titleEn: 'Discourse Connectives & Paragraph Cohesion Studio',
        titleDe: 'Konnektoren (weil, obwohl, deshalb, damit) & Satzbau',
        summaryAr:
            'رَوَابِطُ التَّعْلِيلِ وَالِاسْتِدْرَاكِ وَالْغَايَةِ وَالنَّتِيجَةِ وَأَثَرُهَا عَلَى رُتْبَةِ الْفِعْلِ وَالتَّرْقِيمِ.',
        icon: Icons.link_rounded,
        builder: (_) => const DiscourseConnectivesStudioScreen(),
      ),
      TrilingualStudioDescriptor(
        id: 'modal_verbs_deontic',
        taskNumber: 1227,
        group: StudioDomainGroup.semanticsAndPragmatics,
        titleAr: 'مُخْتَبَرُ أَفْعَالِ الْوُجُوبِ وَالِاحْتِمَالِ وَالْإِذْنِ',
        titleEn: 'Modal Auxiliaries: Deontic vs. Epistemic Studio',
        titleDe: 'Modalverben: Pflicht, Vermutung, Verbot & Ersatzinfinitiv',
        summaryAr:
            'التَّفْرِيقُ بَيْنَ الْإِلْزَامِ وَالِاسْتِنْتَاجِ، وَالْمَنْعِ (darf nicht) وَعَدَمِ اللُّزُومِ (muss nicht)، وَالْمَصْدَرِ الْمُزْدَوَجِ.',
        icon: Icons.balance_rounded,
        builder: (_) => const ModalVerbsStudioScreen(),
      ),
      TrilingualStudioDescriptor(
        id: 'srs_mastery_engine',
        taskNumber: 1229,
        group: StudioDomainGroup.discourseAndMastery,
        titleAr: 'مُحَرِّكُ التَّكْرَارِ الْمُتَبَاعِدِ وَالْإِتْقَانِ (SM-2)',
        titleEn: 'Spaced Repetition (SM-2) & Adaptive Mastery Engine',
        titleDe: 'Spaced-Repetition-System (SM-2) & Fehlertraining',
        summaryAr:
            'جَدْوَلَةُ الْمُرَاجَعَاتِ الذَّكِيَّةُ بِخَوَارِزْمِيَّةِ SM-2 مَعَ تَتَبُّعِ مُعَامِلِ السُّهُولَةِ وَالتَّعَثُّرَاتِ.',
        icon: Icons.psychology_outlined,
        builder: (_) => const SrsMasteryStudioScreen(),
      ),
      TrilingualStudioDescriptor(
        id: 'situational_dialogue',
        taskNumber: 1230,
        group: StudioDomainGroup.semanticsAndPragmatics,
        titleAr: 'مُخْتَبَرُ الْمُحَادَثَاتِ الْحَيَّةِ وَالْحِوَارِ الْمَوْقِفِيِّ',
        titleEn: 'Real-World Situational Dialogue & Roleplay Studio',
        titleDe: 'Alltagsdialoge, Rollenspiel & Höflichkeitsstrategien',
        summaryAr:
            'حِوَارَاتٌ وَاقِعِيَّةٌ فِي الْمَكْتَبَةِ وَالصَّيْدَلِيَّةِ وَالْقِطَارِ وَالْعَمَلِ التِّقْنِيِّ وَآدَابِ الضِّيَافَةِ.',
        icon: Icons.forum_outlined,
        builder: (_) => const SituationalDialogueStudioScreen(),
      ),
      TrilingualStudioDescriptor(
        id: 'false_friends_register',
        taskNumber: 1232,
        group: StudioDomainGroup.semanticsAndPragmatics,
        titleAr: 'مُخْتَبَرُ الْأَلْفَاظِ الْخَادِعَةِ (Falsche Freunde)',
        titleEn: 'False Friends & Semantic Divergence Studio',
        titleDe: 'Falsche Freunde (bekommen/become, aktuell, Gift)',
        summaryAr:
            'كَشْفُ الْكَلِمَاتِ الْمُتَشَابِهَةِ رَسْمًا بَيْنَ الْأَلْمَانِيَّةِ وَالْإِنْجِلِيزِيَّةِ وَالْمُخْتَلِفَةِ مَعْنًى.',
        icon: Icons.warning_amber_rounded,
        builder: (_) => const FalseFriendsStudioScreen(),
      ),
      TrilingualStudioDescriptor(
        id: 'verb_paradigm_matrix',
        taskNumber: 1233,
        group: StudioDomainGroup.morphologyAndPhonology,
        titleAr: 'مُخْتَبَرُ تَصْرِيفِ الْأَفْعَالِ وَالْمِيزَانِ الصَّرْفِيِّ',
        titleEn: 'Verb Conjugation, Root-Measure & Ablaut Studio',
        titleDe: 'Starke/Gemischte Verben, Ablaut & haben/sein Perfekt',
        summaryAr:
            'الْأَوْزَانُ الصَّرْفِيَّةُ، وَسَلَاسِلُ Ablaut، وَالْمَاضِي الْمُرَكَّبُ بِـ haben/sein، وَجَزْمُ الْمُعْتَلِّ وَالْأَفْعَالُ الْمُنْفَصِلَةُ.',
        icon: Icons.table_chart_outlined,
        builder: (_) => const VerbParadigmStudioScreen(),
      ),
      TrilingualStudioDescriptor(
        id: 'nominal_agreement_declension',
        taskNumber: 1234,
        group: StudioDomainGroup.syntaxAndGrammar,
        titleAr: 'مُخْتَبَرُ النَّعْتِ وَالتَّصْرِيفِ الِاسْمِيِّ وَالتَّعْرِيفِ',
        titleEn: 'Adjective Declension, Definiteness & Naʿt Agreement Studio',
        titleDe: 'Adjektivdeklination (schwach/gemischt/stark) & Kongruenz',
        summaryAr:
            'تَصْرِيفُ الصِّفَاتِ الْأَلْمَانِيَّةِ بَعْدَ der/ein/Nullartikel، وَمُطَابَقَةُ جَمْعِ غَيْرِ الْعَاقِلِ، وَالتَّعْرِيفُ التَّجْرِيدِيُّ.',
        icon: Icons.view_list_outlined,
        builder: (_) => const NominalAgreementStudioScreen(),
      ),
      TrilingualStudioDescriptor(
        id: 'comprehension_cloze',
        taskNumber: 1235,
        group: StudioDomainGroup.discourseAndMastery,
        titleAr: 'مُخْتَبَرُ الْفَهْمِ الْقِرَائِيِّ وَمَلْءِ الْفَرَاغَاتِ',
        titleEn: 'Connected Reading & Contextual Cloze Studio',
        titleDe: 'Leseverstehen & Lückentext-Training (Cloze)',
        summaryAr:
            'نُصُوصٌ قِرَائِيَّةٌ مُتَرَابِطَةٌ بِاللُّغَاتِ الثَّلَاثِ مَعَ مَسْرَدِ الْمُصْطَلَحَاتِ وَتَدْرِيبَاتِ مَلْءِ الْفَرَاغَاتِ السِّيَاقِيَّةِ.',
        icon: Icons.menu_book_outlined,
        builder: (_) => const ComprehensionClozeStudioScreen(),
      ),
      TrilingualStudioDescriptor(
        id: 'word_order_topology',
        taskNumber: 1236,
        group: StudioDomainGroup.syntaxAndGrammar,
        titleAr: 'مُخْتَبَرُ رُتْبَةِ الْكَلِمَاتِ وَالْقَوْسِ الْفِعْلِيِّ',
        titleEn: 'Word Order Topology, Satzklammer & TeKaMoLo Studio',
        titleDe: 'Wortstellung: V2, Satzklammer, TeKaMoLo & Objektfolge',
        summaryAr:
            'قَاعِدَةُ الْمَوْقِعِ الثَّانِي (V2) وَالْقَوْسِ الْفِعْلِيِّ وَتَرْتِيبِ TeKaMoLo مُقَابِلَ MPT وَتَقْدِيمِ الْخَبَرِ الْعَرَبِيِّ.',
        icon: Icons.view_week_outlined,
        builder: (_) => const WordOrderStudioScreen(),
      ),
      TrilingualStudioDescriptor(
        id: 'passive_voice_matrix',
        taskNumber: 1237,
        group: StudioDomainGroup.syntaxAndGrammar,
        titleAr: 'مُخْتَبَرُ الْمَبْنِيِّ لِلْمَجْهُولِ وَوَسَائِطِ الْحَدَثِ',
        titleEn: 'Passive Voice, Vorgangs-/Zustandspassiv & Majhul Studio',
        titleDe: 'Vorgangs- vs. Zustandspassiv, worden & Passiversatz',
        summaryAr:
            'الْمَبْنِيُّ لِلْمَجْهُولِ الْعَرَبِيُّ، وَالْفَرْقُ بَيْنَ werden وَsein، وَاستِعْمَالُ von/durch، وَبَدَائِلُ الْمَجْهُولِ (sich lassen / -bar).',
        icon: Icons.swap_horiz_rounded,
        builder: (_) => const PassiveVoiceStudioScreen(),
      ),
      TrilingualStudioDescriptor(
        id: 'reflexive_reciprocal',
        taskNumber: 1238,
        group: StudioDomainGroup.morphologyAndPhonology,
        titleAr: 'مُخْتَبَرُ الْأَفْعَالِ الِانْعِكَاسِيَّةِ وَالْمُطَاوَعَةِ',
        titleEn: 'Reflexive Verbs, Reciprocal Actions & Mutaʿawa Studio',
        titleDe: 'Reflexivpronomen (mich/mir), einander & Medialverben',
        summaryAr:
            'الْفَرْقُ بَيْنَ mich وَmir، وَالْأَفْعَالُ الِانْعِكَاسِيَّةُ اللَّازِمَةُ، وَصِيغَةُ تَفَاعَلَ مُقَابِلَ einander وَالْمُطَاوَعَةِ.',
        icon: Icons.loop_rounded,
        builder: (_) => const ReflexiveReciprocalStudioScreen(),
      ),
    ];
  }

  List<ModuleHealthReport> runSelfDiagnostics() {
    final reportedRepo = const ReportedSpeechRepository();
    final ellipsisRepo = const EllipsisAnaphoraRepository();
    final appositionRepo = const AppositionCoordinationRepository();
    final prepRepo = const PrepositionalGovernmentRepository();
    final nomRepo = const NominalizationRepository();
    final phonoRepo = const PhonotacticsProsodyRepository();
    final discourseRepo = const DiscourseConnectivesRepository();
    final modalRepo = const ModalVerbsRepository();
    final srsRepo = const SrsSeedRepository();
    final dialogueRepo = const SituationalDialogueRepository();
    final falseFriendsRepo = const FalseFriendsRepository();
    final verbRepo = const VerbParadigmRepository();
    final agreementRepo = const NominalAgreementRepository();
    final clozeRepo = const ComprehensionClozeRepository();
    final wordOrderRepo = const WordOrderRepository();
    final passiveRepo = const PassiveVoiceRepository();
    final reflexiveRepo = const ReflexiveReciprocalRepository();

    return [
      _verifyModule(
        id: 'reported_speech',
        titleAr: 'مُخْتَبَرُ الْكَلَامِ الْمَنْقُولِ (#1220)',
        itemsCount: reportedRepo.getScenarios().length,
        drillsCount: reportedRepo.getDrills().length,
        hasValidTrilingualContent: reportedRepo.getScenarios().every(
              (s) =>
                  s.directAr.isNotEmpty &&
                  s.indirectEn.isNotEmpty &&
                  s.indirectDe.isNotEmpty,
            ),
      ),
      _verifyModule(
        id: 'ellipsis_anaphora',
        titleAr: 'مُخْتَبَرُ الْحَذْفِ وَالتَّقْدِيرِ (#1221)',
        itemsCount: ellipsisRepo.getCaseStudies().length,
        drillsCount: ellipsisRepo.getDrills().length,
        hasValidTrilingualContent: ellipsisRepo.getCaseStudies().every(
              (c) =>
                  c.surfaceAr.isNotEmpty &&
                  c.recoveredEn.isNotEmpty &&
                  c.recoveredDe.isNotEmpty,
            ),
      ),
      _verifyModule(
        id: 'apposition_coordination',
        titleAr: 'مُخْتَبَرُ الْبَدَلِ وَالْعَطْفِ (#1222)',
        itemsCount: appositionRepo.getItems().length,
        drillsCount: appositionRepo.getDrills().length,
        hasValidTrilingualContent: appositionRepo.getItems().every(
              (i) =>
                  i.exampleAr.isNotEmpty &&
                  i.exampleEn.isNotEmpty &&
                  i.exampleDe.isNotEmpty,
            ),
      ),
      _verifyModule(
        id: 'prepositional_government',
        titleAr: 'مُخْتَبَرُ حُرُوفِ الْجَرِّ (#1223)',
        itemsCount: prepRepo.getPairs().length,
        drillsCount: prepRepo.getDrills().length,
        hasValidTrilingualContent: prepRepo.getPairs().every(
              (p) =>
                  p.patternAAr.isNotEmpty &&
                  p.patternAEn.isNotEmpty &&
                  p.patternADe.isNotEmpty,
            ),
      ),
      _verifyModule(
        id: 'nominalization_morphology',
        titleAr: 'مُخْتَبَرُ الْمَصَادِرِ وَالِاشْتِقَاقِ (#1224)',
        itemsCount: nomRepo.getLessons().length,
        drillsCount: nomRepo.getDrills().length,
        hasValidTrilingualContent: nomRepo.getLessons().every(
              (l) =>
                  l.nominalFormAr.isNotEmpty &&
                  l.nominalFormEn.isNotEmpty &&
                  l.nominalFormDe.isNotEmpty,
            ),
      ),
      _verifyModule(
        id: 'phonotactics_prosody',
        titleAr: 'مُخْتَبَرُ الصَّوْتِيَّاتِ وَالنَّبْرِ (#1225)',
        itemsCount: phonoRepo.getLessons().length,
        drillsCount: phonoRepo.getDrills().length,
        hasValidTrilingualContent: phonoRepo.getLessons().every(
              (l) =>
                  l.arabicExamples.isNotEmpty &&
                  l.englishExamples.isNotEmpty &&
                  l.germanExamples.isNotEmpty,
            ),
      ),
      _verifyModule(
        id: 'discourse_connectives',
        titleAr: 'مُخْتَبَرُ الرَّوَابِطِ النَّصِّيَّةِ (#1226)',
        itemsCount: discourseRepo.getTriplets().length,
        drillsCount: discourseRepo.getDrills().length,
        hasValidTrilingualContent: discourseRepo.getTriplets().every(
              (t) =>
                  t.subordinatingAr.isNotEmpty &&
                  t.subordinatingEn.isNotEmpty &&
                  t.subordinatingDe.isNotEmpty,
            ),
      ),
      _verifyModule(
        id: 'modal_verbs_deontic',
        titleAr: 'مُخْتَبَرُ الْأَفْعَالِ النَّاقِصَةِ (#1227)',
        itemsCount: modalRepo.getUnits().length,
        drillsCount: modalRepo.getDrills().length,
        hasValidTrilingualContent: modalRepo.getUnits().every(
              (u) =>
                  u.deonticOrBaseAr.isNotEmpty &&
                  u.deonticOrBaseEn.isNotEmpty &&
                  u.deonticOrBaseDe.isNotEmpty,
            ),
      ),
      _verifyModule(
        id: 'srs_mastery_engine',
        titleAr: 'مُحَرِّكُ التَّكْرَارِ الْمُتَبَاعِدِ (#1229)',
        itemsCount: srsRepo.loadInitialDeck().length,
        drillsCount: srsRepo.loadInitialDeck().length,
        hasValidTrilingualContent: srsRepo.loadInitialDeck().every(
              (c) =>
                  c.promptAr.isNotEmpty &&
                  c.answerEn.isNotEmpty &&
                  c.answerDe.isNotEmpty,
            ),
      ),
      _verifyModule(
        id: 'situational_dialogue',
        titleAr: 'مُخْتَبَرُ الْمُحَادَثَاتِ الْحَيَّةِ (#1230)',
        itemsCount: dialogueRepo.getScenarios().length,
        drillsCount: dialogueRepo.getChallenges().length,
        hasValidTrilingualContent: dialogueRepo.getScenarios().every(
              (s) => s.turns.isNotEmpty && s.turns.first.lineDe.isNotEmpty,
            ),
      ),
      _verifyModule(
        id: 'false_friends_register',
        titleAr: 'مُخْتَبَرُ الْأَلْفَاظِ الْخَادِعَةِ (#1232)',
        itemsCount: falseFriendsRepo.getEntries().length,
        drillsCount: falseFriendsRepo.getDrills().length,
        hasValidTrilingualContent: falseFriendsRepo.getEntries().every(
              (e) =>
                  e.germanTerm.isNotEmpty &&
                  e.englishLookalike.isNotEmpty &&
                  e.exampleAr.isNotEmpty,
            ),
      ),
      _verifyModule(
        id: 'verb_paradigm_matrix',
        titleAr: 'مُخْتَبَرُ تَصْرِيفِ الْأَفْعَالِ (#1233)',
        itemsCount: verbRepo.getEntries().length,
        drillsCount: verbRepo.getDrills().length,
        hasValidTrilingualContent: verbRepo.getEntries().every(
              (v) =>
                  v.arabicForms.isNotEmpty &&
                  v.englishForms.isNotEmpty &&
                  v.germanForms.isNotEmpty,
            ),
      ),
      _verifyModule(
        id: 'nominal_agreement_declension',
        titleAr: 'مُخْتَبَرُ النَّعْتِ وَالتَّصْرِيفِ الِاسْمِيِّ (#1234)',
        itemsCount: agreementRepo.getLessons().length,
        drillsCount: agreementRepo.getDrills().length,
        hasValidTrilingualContent: agreementRepo.getLessons().every(
              (a) =>
                  a.exampleAr.isNotEmpty &&
                  a.exampleEn.isNotEmpty &&
                  a.exampleDe.isNotEmpty,
            ),
      ),
      _verifyModule(
        id: 'comprehension_cloze',
        titleAr: 'مُخْتَبَرُ الْفَهْمِ الْقِرَائِيِّ وَمَلْءِ الْفَرَاغَاتِ (#1235)',
        itemsCount: clozeRepo.getPassages().length,
        drillsCount: clozeRepo.getClozeDrills().length,
        hasValidTrilingualContent: clozeRepo.getPassages().every(
              (p) =>
                  p.bodyAr.isNotEmpty &&
                  p.bodyEn.isNotEmpty &&
                  p.bodyDe.isNotEmpty,
            ),
      ),
      _verifyModule(
        id: 'word_order_topology',
        titleAr: 'مُخْتَبَرُ رُتْبَةِ الْكَلِمَاتِ وَالْقَوْسِ الْفِعْلِيِّ (#1236)',
        itemsCount: wordOrderRepo.getPatterns().length,
        drillsCount: wordOrderRepo.getDrills().length,
        hasValidTrilingualContent: wordOrderRepo.getPatterns().every(
              (w) =>
                  w.sentenceAr.isNotEmpty &&
                  w.sentenceEn.isNotEmpty &&
                  w.sentenceDe.isNotEmpty,
            ),
      ),
      _verifyModule(
        id: 'passive_voice_matrix',
        titleAr: 'مُخْتَبَرُ الْمَبْنِيِّ لِلْمَجْهُولِ (#1237)',
        itemsCount: passiveRepo.getUnits().length,
        drillsCount: passiveRepo.getDrills().length,
        hasValidTrilingualContent: passiveRepo.getUnits().every(
              (u) =>
                  u.passiveFormAr.isNotEmpty &&
                  u.passiveFormEn.isNotEmpty &&
                  u.passiveFormDe.isNotEmpty,
            ),
      ),
      _verifyModule(
        id: 'reflexive_reciprocal',
        titleAr: 'مُخْتَبَرُ الْأَفْعَالِ الِانْعِكَاسِيَّةِ وَالْمُطَاوَعَةِ (#1238)',
        itemsCount: reflexiveRepo.getUnits().length,
        drillsCount: reflexiveRepo.getDrills().length,
        hasValidTrilingualContent: reflexiveRepo.getUnits().every(
              (r) =>
                  r.exampleAr.isNotEmpty &&
                  r.exampleEn.isNotEmpty &&
                  r.exampleDe.isNotEmpty,
            ),
      ),
    ];
  }

  ModuleHealthReport _verifyModule({
    required String id,
    required String titleAr,
    required int itemsCount,
    required int drillsCount,
    required bool hasValidTrilingualContent,
  }) {
    final healthy =
        itemsCount >= 6 && drillsCount >= 6 && hasValidTrilingualContent;
    return ModuleHealthReport(
      moduleId: id,
      titleAr: titleAr,
      isHealthy: healthy,
      verifiedItemsCount: itemsCount,
      verifiedDrillsCount: drillsCount,
      diagnosticNoteAr: healthy
          ? 'مُكْتَمِلٌ وَسَلِيمٌ بَرْمَجِيًّا وَلُغَوِيًّا ($itemsCount وَحَدَاتٍ / $drillsCount تَدْرِيبَاتٍ)'
          : 'يَحْتَاجُ إِلَى اسْتِكْمَالِ بَعْضِ الْبَيَانَاتِ',
    );
  }
}
