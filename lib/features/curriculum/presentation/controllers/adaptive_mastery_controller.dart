import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// CEFR (Common European Framework of Reference) Proficiency Levels
enum CefrLevel {
  a1(
    code: 'A1',
    nameAr: 'المُبْتَدِئُ (Einstieg)',
    nameDe: 'Elementare Sprachverwendung (A1)',
    nameEn: 'Beginner / Breakthrough (A1)',
    minMasteryThreshold: 0.0,
    maxMasteryThreshold: 0.20,
  ),
  a2(
    code: 'A2',
    nameAr: 'الأَسَاسِيُّ (Grundlagen)',
    nameDe: 'Grundlegende Kenntnisse (A2)',
    nameEn: 'Elementary (A2)',
    minMasteryThreshold: 0.20,
    maxMasteryThreshold: 0.40,
  ),
  b1(
    code: 'B1',
    nameAr: 'المُتَوَسِّطُ (Mittelstufe)',
    nameDe: 'Selbstständige Sprachverwendung (B1)',
    nameEn: 'Intermediate (B1)',
    minMasteryThreshold: 0.40,
    maxMasteryThreshold: 0.60,
  ),
  b2(
    code: 'B2',
    nameAr: 'فَوْقَ المُتَوَسِّطِ (Gute Mittelstufe)',
    nameDe: 'Fortgeschrittene Sprachverwendung (B2)',
    nameEn: 'Upper Intermediate (B2)',
    minMasteryThreshold: 0.60,
    maxMasteryThreshold: 0.80,
  ),
  c1(
    code: 'C1',
    nameAr: 'المُتَقَدِّمُ الخَبِيرُ (Fachkundig)',
    nameDe: 'Fachkundige Sprachkenntnisse (C1)',
    nameEn: 'Advanced (C1)',
    minMasteryThreshold: 0.80,
    maxMasteryThreshold: 0.92,
  ),
  c2(
    code: 'C2',
    nameAr: 'الإِتْقَانُ الأَصِيلُ وَالفَصَاحَةُ التَّامَّةُ (Exzellenz)',
    nameDe: 'Annähernd muttersprachliche Kenntnisse (C2)',
    nameEn: 'Mastery / Proficiency (C2)',
    minMasteryThreshold: 0.92,
    maxMasteryThreshold: 1.00,
  );

  final String code;
  final String nameAr;
  final String nameDe;
  final String nameEn;
  final double minMasteryThreshold;
  final double maxMasteryThreshold;

  const CefrLevel({
    required this.code,
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.minMasteryThreshold,
    required this.maxMasteryThreshold,
  });

  static CefrLevel fromScore(double score) {
    final clamped = score.clamp(0.0, 1.0);
    for (final level in CefrLevel.values.reversed) {
      if (clamped >= level.minMasteryThreshold) {
        return level;
      }
    }
    return CefrLevel.a1;
  }
}

/// The Core Trilingual Languages
enum AppLanguage {
  arabic(
    code: 'ar',
    nameAr: 'العَرَبِيَّةُ الفُصْحَى المُشَكَّلَةُ',
    nameDe: 'Arabisch (Vokalisiert)',
    nameEn: 'Vocalized Arabic',
  ),
  german(
    code: 'de',
    nameAr: 'الأَلْمَانِيَّةُ المِعْيَارِيَّةُ',
    nameDe: 'Standarddeutsch',
    nameEn: 'German',
  ),
  english(
    code: 'en',
    nameAr: 'الإِنْجِلِيزِيَّةُ الأَكَادِيمِيَّةُ',
    nameDe: 'Akademisches Englisch',
    nameEn: 'Academic English',
  );

  final String code;
  final String nameAr;
  final String nameDe;
  final String nameEn;

  const AppLanguage({
    required this.code,
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
  });
}

/// The Four Pillars of Language Competency
enum SkillDomain {
  reading(
    nameAr: 'فَهْمُ المَقْرُوءِ وَالتَّرْكِيبِ',
    nameDe: 'Leseverstehen & Syntax',
    nameEn: 'Reading Comprehension & Syntax',
    weight: 0.25,
  ),
  listening(
    nameAr: 'الإِدْرَاكُ الصَّوْتِيُّ وَالنُّطْقُ',
    nameDe: 'Hörverstehen & Phonetik',
    nameEn: 'Auditory Perception & Phonetics',
    weight: 0.25,
  ),
  grammar(
    nameAr: 'النَّحْوُ وَالصَّرْفُ وَالمُعَادَلاتُ',
    nameDe: 'Grammatik & Morphologie',
    nameEn: 'Grammar & Morphology',
    weight: 0.25,
  ),
  scientificLexicon(
    nameAr: 'المُفْرَدَاتُ وَالتُّرَاثُ العِلْمِيُّ',
    nameDe: 'Wissenschafts- & Erbewortschatz',
    nameEn: 'Scientific & Heritage Lexicon',
    weight: 0.25,
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;
  final double weight;

  const SkillDomain({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.weight,
  });
}

/// State of an individual competency node using Bayesian Knowledge Tracing (BKT)
class CompetencyNode {
  final SkillDomain domain;
  final AppLanguage language;
  final double probabilityMastery; // P(L): probability that skill is mastered (0.0 to 1.0)
  final int totalAssessmentsCount;
  final int correctAssessmentsCount;
  final DateTime lastReviewed;

  const CompetencyNode({
    required this.domain,
    required this.language,
    required this.probabilityMastery,
    required this.totalAssessmentsCount,
    required this.correctAssessmentsCount,
    required this.lastReviewed,
  });

  CefrLevel get cefrLevel => CefrLevel.fromScore(probabilityMastery);

  /// Bayesian Knowledge Tracing (BKT) update rule:
  /// Given evidence: correct = true/false
  /// Parameters:
  /// pG (Probability of Guess) ~ 0.20
  /// pS (Probability of Slip) ~ 0.10
  /// pT (Probability of Transit/Learning) ~ 0.15
  CompetencyNode recordAssessment({required bool isCorrect}) {
    const pG = 0.20; // Guess
    const pS = 0.10; // Slip
    const pT = 0.15; // Transition/Learn

    final pLPrev = probabilityMastery;

    // 1. Posterior calculation P(L_t-1 | Observation)
    double pLPosterior;
    if (isCorrect) {
      pLPosterior = (pLPrev * (1.0 - pS)) /
          ((pLPrev * (1.0 - pS)) + ((1.0 - pLPrev) * pG));
    } else {
      pLPosterior = (pLPrev * pS) /
          ((pLPrev * pS) + ((1.0 - pLPrev) * (1.0 - pG)));
    }

    // 2. State transition P(L_t)
    final pLNew = pLPosterior + ((1.0 - pLPosterior) * pT);

    return CompetencyNode(
      domain: domain,
      language: language,
      probabilityMastery: pLNew.clamp(0.01, 0.999),
      totalAssessmentsCount: totalAssessmentsCount + 1,
      correctAssessmentsCount:
          correctAssessmentsCount + (isCorrect ? 1 : 0),
      lastReviewed: DateTime.now(),
    );
  }
}

/// Aggregate State of the Adaptive Mastery Matrix
class AdaptiveMasteryState {
  final AppLanguage activeLanguage;
  final Map<String, CompetencyNode> competencyNodes; // key: "${lang.code}_${domain.name}"
  final bool isDiagnosticActive;

  const AdaptiveMasteryState({
    required this.activeLanguage,
    required this.competencyNodes,
    required this.isDiagnosticActive,
  });

  factory AdaptiveMasteryState.initial() {
    final map = <String, CompetencyNode>{};
    final now = DateTime.now();

    for (final lang in AppLanguage.values) {
      for (final domain in SkillDomain.values) {
        // Initial baseline: moderate mastery (~0.45 B1)
        final initialP = (domain == SkillDomain.reading) ? 0.65 : 0.48;
        map['${lang.code}_${domain.name}'] = CompetencyNode(
          domain: domain,
          language: lang,
          probabilityMastery: initialP,
          totalAssessmentsCount: 12,
          correctAssessmentsCount: (12 * initialP).round(),
          lastReviewed: now,
        );
      }
    }

    return AdaptiveMasteryState(
      activeLanguage: AppLanguage.arabic,
      competencyNodes: map,
      isDiagnosticActive: false,
    );
  }

  /// Composite mastery score for the active language (0.0 to 1.0)
  double get activeLanguageOverallScore {
    double total = 0.0;
    for (final domain in SkillDomain.values) {
      final node = competencyNodes['${activeLanguage.code}_${domain.name}'];
      if (node != null) {
        total += node.probabilityMastery * domain.weight;
      }
    }
    return total;
  }

  CefrLevel get activeLanguageCefr =>
      CefrLevel.fromScore(activeLanguageOverallScore);

  /// Identifies the weakest domain in the active language (Deficit targeting)
  CompetencyNode get weakestCompetencyNode {
    CompetencyNode? weakest;
    double minScore = double.infinity;

    for (final domain in SkillDomain.values) {
      final node = competencyNodes['${activeLanguage.code}_${domain.name}'];
      if (node != null && node.probabilityMastery < minScore) {
        minScore = node.probabilityMastery;
        weakest = node;
      }
    }
    return weakest ??
        competencyNodes.values.firstWhere((n) => n.language == activeLanguage);
  }

  AdaptiveMasteryState copyWith({
    AppLanguage? activeLanguage,
    Map<String, CompetencyNode>? competencyNodes,
    bool? isDiagnosticActive,
  }) {
    return AdaptiveMasteryState(
      activeLanguage: activeLanguage ?? this.activeLanguage,
      competencyNodes: competencyNodes ?? this.competencyNodes,
      isDiagnosticActive: isDiagnosticActive ?? this.isDiagnosticActive,
    );
  }
}

/// Controller managing the Adaptive CEFR Competency Matrix
class AdaptiveMasteryController extends ChangeNotifier {
  AdaptiveMasteryState _state = AdaptiveMasteryState.initial();

  AdaptiveMasteryState get state => _state;

  void setActiveLanguage(AppLanguage lang) {
    _state = _state.copyWith(activeLanguage: lang);
    notifyListeners();
  }

  /// Simulate user assessment result for a given domain and active language
  void recordAssessmentResult({
    required SkillDomain domain,
    required bool isCorrect,
  }) {
    final key = '${_state.activeLanguage.code}_${domain.name}';
    final existing = _state.competencyNodes[key];
    if (existing == null) return;

    final updated = existing.recordAssessment(isCorrect: isCorrect);
    final map = Map<String, CompetencyNode>.from(_state.competencyNodes);
    map[key] = updated;

    _state = _state.copyWith(competencyNodes: map);
    notifyListeners();
  }

  /// Trigger intelligent diagnostic boost across all domains
  void runDiagnosticAudit() {
    final map = Map<String, CompetencyNode>.from(_state.competencyNodes);
    for (final key in map.keys) {
      final node = map[key]!;
      // Re-calibrate score based on rigorous audit
      final calibrated = (node.probabilityMastery * 0.95).clamp(0.05, 0.95);
      map[key] = CompetencyNode(
        domain: node.domain,
        language: node.language,
        probabilityMastery: calibrated,
        totalAssessmentsCount: node.totalAssessmentsCount + 1,
        correctAssessmentsCount: node.correctAssessmentsCount,
        lastReviewed: DateTime.now(),
      );
    }
    _state = _state.copyWith(competencyNodes: map, isDiagnosticActive: true);
    notifyListeners();
  }

  void resetDefaults() {
    _state = AdaptiveMasteryState.initial();
    notifyListeners();
  }
}
