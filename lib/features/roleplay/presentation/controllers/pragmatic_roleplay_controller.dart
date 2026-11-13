import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// Formality Register and Politeness Level (حَالَةُ الخِطَابِ وَالمُسْتَوَى التَّدَاوُلِيُّ)
enum PragmaticRegister {
  formalAcademic(
    nameAr: 'رَسْمِيٌّ أَكَادِيمِيٌّ رَفِيعٌ',
    nameDe: 'Hochformell & Akademisch (Sie-Form)',
    nameEn: 'Formal Academic & Diplomatic',
    politenessScoreMin: 0.85,
  ),
  standardProfessional(
    nameAr: 'مِهْنِيٌّ مُعْتَمَدٌ',
    nameDe: 'Geschäftlich & Professionell',
    nameEn: 'Standard Professional',
    politenessScoreMin: 0.65,
  ),
  casualColloquial(
    nameAr: 'وُدِّيٌّ غَيْرُ رَسْمِيٍّ',
    nameDe: 'Informell & Freundschaftlich (Du-Form)',
    nameEn: 'Casual & Conversational',
    politenessScoreMin: 0.40,
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;
  final double politenessScoreMin;

  const PragmaticRegister({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.politenessScoreMin,
  });
}

/// Linguistic Speech Act Category (أَفْعَالُ الكَلامِ التَّدَاوُلِيَّةِ)
enum SpeechActType {
  inquiry(
    nameAr: 'طَلَبُ اسْتِفْسَارٍ / سُؤَالٌ',
    nameDe: 'Erkundigung / Anfrage',
    nameEn: 'Inquiry / Question',
  ),
  assertion(
    nameAr: 'تَقْرِيرٌ / حُجَّةٌ عِلْمِيَّةٌ',
    nameDe: 'Behauptung / Argumentation',
    nameEn: 'Assertion / Argument',
  ),
  request(
    nameAr: 'طَلَبُ مُسَاعَدَةٍ أَوْ خِدْمَةٍ',
    nameDe: 'Bitte / Höfliche Aufforderung',
    nameEn: 'Polite Request',
  ),
  agreement(
    nameAr: 'مُوَافَقَةٌ وَتَأْيِيدٌ',
    nameDe: 'Zustimmung / Bestätigung',
    nameEn: 'Agreement / Affirmation',
  ),
  politeRefusal(
    nameAr: 'اعْتِذَارٌ أَوْ رَفْضٌ لَبِقٌ',
    nameDe: 'Höfliche Ablehnung / Einwand',
    nameEn: 'Polite Refusal / Objection',
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;

  const SpeechActType({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
  });
}

/// Dialogue Turn Entry representing one conversational exchange
class DialogueTurn {
  final String speakerNameAr;
  final String speakerNameDe;
  final String speakerNameEn;
  final bool isUser;
  final String textAr;
  final String textDe;
  final String textEn;
  final SpeechActType speechAct;
  final PragmaticRegister register;
  final double pragmaticScore; // 0.0 to 1.0 (appropriateness)

  const DialogueTurn({
    required this.speakerNameAr,
    required this.speakerNameDe,
    required this.speakerNameEn,
    required this.isUser,
    required this.textAr,
    required this.textDe,
    required this.textEn,
    required this.speechAct,
    required this.register,
    required this.pragmaticScore,
  });
}

/// Conversational Scenario with branching possibilities
class RoleplayScenario {
  final String id;
  final String titleAr;
  final String titleDe;
  final String titleEn;
  final String settingDescriptionAr;
  final PragmaticRegister expectedRegister;
  final List<DialogueTurn> initialTurns;

  const RoleplayScenario({
    required this.id,
    required this.titleAr,
    required this.titleDe,
    required this.titleEn,
    required this.settingDescriptionAr,
    required this.expectedRegister,
    required this.initialTurns,
  });

  static final List<RoleplayScenario> scenarios = [
    RoleplayScenario(
      id: 'academic_colloquium',
      titleAr: 'مُنَاقَشَةُ رِسَالَةٍ عِلْمِيَّةٍ فِي مَجْمَعِ العُلُومِ',
      titleDe: 'Akademische Disputation im Wissenschaftskolleg',
      titleEn: 'Academic Thesis Defense & Scientific Colloquium',
      settingDescriptionAr: 'جَلْسَةٌ أَكَادِيمِيَّةٌ رَفِيعَةُ المُسْتَوَى تُنَاقِشُ مَخْطُوطَاتِ البَصَرِيَّاتِ لِابْنِ الهَيْثَمِ.',
      expectedRegister: PragmaticRegister.formalAcademic,
      initialTurns: [
        const DialogueTurn(
          speakerNameAr: 'الأُسْتَاذُ العَمِيدُ',
          speakerNameDe: 'Prof. Dekan',
          speakerNameEn: 'Dean Prof.',
          isUser: false,
          textAr: 'أَهْلاً بِكَ فِي المَجْمَعِ العِلْمِيِّ؛ هَلْ لَكَ أَنْ تَعْرِضَ لَنَا كَيْفَ بَرْهَنَ ابْنُ الهَيْثَمِ انْكِسَارَ الضَّوْءِ؟',
          textDe: 'Willkommen im Kollegium; könnten Sie darlegen, wie Alhazen die Lichtbrechung experimentell bewies?',
          textEn: 'Welcome to the scientific academy; could you elucidate how Ibn al-Haytham proved the refraction of light?',
          speechAct: SpeechActType.inquiry,
          register: PragmaticRegister.formalAcademic,
          pragmaticScore: 0.95,
        ),
      ],
    ),
    RoleplayScenario(
      id: 'manuscript_bazaar',
      titleAr: 'سُوقُ الوَرَّاقِينَ وَالمَخْطُوطَاتِ النَّادِرَةِ',
      titleDe: 'Bazar der Handschriften & Papiermacher',
      titleEn: 'Rare Manuscript Bookseller Bazaar',
      settingDescriptionAr: 'حِوَارٌ مِهْنِيٌّ فِي بَغْدَادَ لِشِرَاءِ نُسْخَةٍ أَصِيلَةٍ مِنْ كِتَابِ الحِيَلِ لِبَنِي مُوسَى.',
      expectedRegister: PragmaticRegister.standardProfessional,
      initialTurns: [
        const DialogueTurn(
          speakerNameAr: 'الوَرَّاقُ أَبُو جَعْفَر',
          speakerNameDe: 'Buchhändler Abu Dschaafar',
          speakerNameEn: 'Bookseller Abu Jaafar',
          isUser: false,
          textAr: 'مَرْحَباً بِكَ يَا سَيِّدِي فِي حَانُوتِنَا؛ لَدَيْنَا نُسْخَةٌ خَطِّيَّةٌ نَفِيسَةٌ عَلَى وَرَقٍ سَمَرْقَنْدِيٍّ مُعَتَّقٍ.',
          textDe: 'Guten Tag, mein Herr; wir besitzen ein kostbares Manuskript auf gealtertem Samarkand-Papier.',
          textEn: 'Welcome to our shop, sir; we possess a precious manuscript penned on aged Samarkand parchment.',
          speechAct: SpeechActType.assertion,
          register: PragmaticRegister.standardProfessional,
          pragmaticScore: 0.90,
        ),
      ],
    ),
  ];
}

/// State representation of the Pragmatic Roleplay Session
class PragmaticRoleplayState {
  final RoleplayScenario activeScenario;
  final List<DialogueTurn> conversationHistory;
  final double userFluencyScore; // 0% to 100%
  final double userPragmaticFitScore; // 0% to 100%
  final double lexicalRichnessScore; // 0% to 100%
  final int completedTurnsCount;
  final bool isEvaluating;

  const PragmaticRoleplayState({
    required this.activeScenario,
    required this.conversationHistory,
    required this.userFluencyScore,
    required this.userPragmaticFitScore,
    required this.lexicalRichnessScore,
    required this.completedTurnsCount,
    required this.isEvaluating,
  });

  factory PragmaticRoleplayState.initial() {
    final first = RoleplayScenario.scenarios.first;
    return PragmaticRoleplayState(
      activeScenario: first,
      conversationHistory: List.from(first.initialTurns),
      userFluencyScore: 88.0,
      userPragmaticFitScore: 92.0,
      lexicalRichnessScore: 85.0,
      completedTurnsCount: 1,
      isEvaluating: false,
    );
  }

  /// Composite Pragmatic Competency Index (0% to 100%)
  double get overallCompetencyIndex {
    return (userFluencyScore * 0.3) +
        (userPragmaticFitScore * 0.4) +
        (lexicalRichnessScore * 0.3);
  }

  PragmaticRoleplayState copyWith({
    RoleplayScenario? activeScenario,
    List<DialogueTurn>? conversationHistory,
    double? userFluencyScore,
    double? userPragmaticFitScore,
    double? lexicalRichnessScore,
    int? completedTurnsCount,
    bool? isEvaluating,
  }) {
    return PragmaticRoleplayState(
      activeScenario: activeScenario ?? this.activeScenario,
      conversationHistory:
          conversationHistory ?? this.conversationHistory,
      userFluencyScore: userFluencyScore ?? this.userFluencyScore,
      userPragmaticFitScore:
          userPragmaticFitScore ?? this.userPragmaticFitScore,
      lexicalRichnessScore:
          lexicalRichnessScore ?? this.lexicalRichnessScore,
      completedTurnsCount: completedTurnsCount ?? this.completedTurnsCount,
      isEvaluating: isEvaluating ?? this.isEvaluating,
    );
  }
}

/// Controller orchestrating the Pragmatic Dialogue Roleplay
class PragmaticRoleplayController extends ChangeNotifier {
  PragmaticRoleplayState _state = PragmaticRoleplayState.initial();

  PragmaticRoleplayState get state => _state;

  void selectScenario(RoleplayScenario scenario) {
    _state = _state.copyWith(
      activeScenario: scenario,
      conversationHistory: List.from(scenario.initialTurns),
      completedTurnsCount: 1,
    );
    notifyListeners();
  }

  /// Submit a user dialogue response with pragmatic speech act grading
  void submitUserTurn({
    required String textAr,
    required String textDe,
    required String textEn,
    required SpeechActType speechAct,
    required PragmaticRegister register,
  }) {
    // 1. Calculate pragmatic appropriateness penalty if register mismatches scenario
    final expected = _state.activeScenario.expectedRegister;
    double fitScore = 1.0;
    if (register != expected) {
      fitScore = (register.politenessScoreMin / expected.politenessScoreMin).clamp(0.4, 0.9);
    }

    // 2. Lexical richness based on vocalization and terminology
    final hasTashkeel = textAr.contains(RegExp(r'[\u064B-\u065F\u0670]'));
    final lexicalScore = hasTashkeel ? 0.95 : 0.70;

    final userTurn = DialogueTurn(
      speakerNameAr: 'المُتَعَلِّمُ البَاحِثُ',
      speakerNameDe: 'Sprachforscher',
      speakerNameEn: 'Learner Scholar',
      isUser: true,
      textAr: textAr,
      textDe: textDe,
      textEn: textEn,
      speechAct: speechAct,
      register: register,
      pragmaticScore: fitScore,
    );

    final history = List<DialogueTurn>.from(_state.conversationHistory)..add(userTurn);

    // 3. Automated Realistic Interlocutor Counter-Response
    final interlocutorResponse = _generateInterlocutorReply(speechAct, fitScore);
    history.add(interlocutorResponse);

    // Update metrics
    final newPragmatic = (_state.userPragmaticFitScore * 0.7) + (fitScore * 100.0 * 0.3);
    final newLexical = (_state.lexicalRichnessScore * 0.7) + (lexicalScore * 100.0 * 0.3);

    _state = _state.copyWith(
      conversationHistory: history,
      userPragmaticFitScore: newPragmatic,
      lexicalRichnessScore: newLexical,
      completedTurnsCount: _state.completedTurnsCount + 2,
    );
    notifyListeners();
  }

  DialogueTurn _generateInterlocutorReply(SpeechActType userAct, double userFit) {
    if (userFit < 0.6) {
      return const DialogueTurn(
        speakerNameAr: 'الأُسْتَاذُ العَمِيدُ',
        speakerNameDe: 'Prof. Dekan',
        speakerNameEn: 'Dean Prof.',
        isUser: false,
        textAr: 'نَلْفِتُ عِنَايَتَكُمْ إِلَى ضَرُورَةِ اسْتِعْمَالِ الخِطَابِ الأَكَادِيمِيِّ الرَّسْمِيِّ فِي حَرَمِ المَجْمَعِ؛ يُرْجَى إِعَادَةُ الصِّيَاغَةِ بِلَبَاقَةٍ.',
        textDe: 'Wir bitten um eine angemessenere akademische Ausdrucksweise im Kollegium; bitte formulieren Sie Ihre These förmlich.',
        textEn: 'We kindly remind you to observe the formal academic register; please rephrase your argument with due scholarly decorum.',
        speechAct: SpeechActType.politeRefusal,
        register: PragmaticRegister.formalAcademic,
        pragmaticScore: 0.90,
      );
    }

    switch (userAct) {
      case SpeechActType.assertion:
      case SpeechActType.inquiry:
        return const DialogueTurn(
          speakerNameAr: 'الأُسْتَاذُ العَمِيدُ',
          speakerNameDe: 'Prof. Dekan',
          speakerNameEn: 'Dean Prof.',
          isUser: false,
          textAr: 'بَيَانٌ عِلْمِيٌّ دَقِيقٌ وَمُفَصَّلٌ؛ وَهَذَا يَتَّفِقُ تَمَاماً مَعَ مَا أَثْبَتَهُ ابْنُ الهَيْثَمِ فِي المَقَالَةِ السَّابِعَةِ مِنْ كِتَابِ المَنَاظِرِ!',
          textDe: 'Eine überaus präzise und fundierte Darlegung; dies stimmt exakt mit Alhazens 7. Abhandlung im Buch der Optik überein!',
          textEn: 'An exceedingly precise and scholarly exposition; this aligns flawlessly with Ibn al-Haytham’s 7th treatise in the Book of Optics!',
          speechAct: SpeechActType.agreement,
          register: PragmaticRegister.formalAcademic,
          pragmaticScore: 0.98,
        );
      default:
        return const DialogueTurn(
          speakerNameAr: 'الأُسْتَاذُ العَمِيدُ',
          speakerNameDe: 'Prof. Dekan',
          speakerNameEn: 'Dean Prof.',
          isUser: false,
          textAr: 'نُثَمِّنُ هَذَا الطَّرْحَ اللَّبِقَ؛ هَلْ لَدَيْكُمْ إِضَافَةٌ حَوْلَ قَانُونِ الزَّوَايَا وَالانْعِكَاسِ؟',
          textDe: 'Wir schätzen diesen höflichen Beitrag sehr; haben Sie weitere Einsichten zum Gesetz der Reflexionswinkel?',
          textEn: 'We greatly value this courteous contribution; do you have further insights regarding the law of reflection angles?',
          speechAct: SpeechActType.inquiry,
          register: PragmaticRegister.formalAcademic,
          pragmaticScore: 0.95,
        );
    }
  }

  void reset() {
    _state = PragmaticRoleplayState.initial();
    notifyListeners();
  }
}
