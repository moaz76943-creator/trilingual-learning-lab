import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// Assessment result evaluating learner's spoken acoustic performance.
class PronunciationAssessmentResult {
  final double overallScore; // 0.0 to 100.0
  final double rhythmScore;
  final double durationScore;
  final double completenessScore;
  final String diagnosticAr;
  final String diagnosticDe;
  final String diagnosticEn;
  final bool isPassing;

  const PronunciationAssessmentResult({
    required this.overallScore,
    required this.rhythmScore,
    required this.durationScore,
    required this.completenessScore,
    required this.diagnosticAr,
    required this.diagnosticDe,
    required this.diagnosticEn,
    required this.isPassing,
  });
}

/// Service evaluating spoken utterance duration, rhythm, and syllable pacing.
class PronunciationAccuracyScorer {
  /// Evaluates learner utterance against reference target duration and syllable metrics.
  static PronunciationAssessmentResult evaluate({
    required int referenceDurationMs,
    required int learnerDurationMs,
    required int expectedSyllables,
    required int detectedPauseCount,
    required String languageCode,
  }) {
    if (referenceDurationMs <= 0 || learnerDurationMs <= 0) {
      return const PronunciationAssessmentResult(
        overallScore: 0.0,
        rhythmScore: 0.0,
        durationScore: 0.0,
        completenessScore: 0.0,
        diagnosticAr: 'لَمْ يَتِمَّ رَصْدُ إِشَارَةٍ صَوْتِيَّةٍ كَافِيَةٍ.',
        diagnosticDe: 'Kein ausreichendes Audiosignal erfasst.',
        diagnosticEn: 'No sufficient audio signal detected.',
        isPassing: false,
      );
    }

    // 1. Duration Score: Tolerance within ±25%
    final durationRatio = learnerDurationMs / referenceDurationMs;
    double durationScore = 100.0;
    if (durationRatio < 0.75) {
      // Too fast
      durationScore = math.max(30.0, (durationRatio / 0.75) * 100.0);
    } else if (durationRatio > 1.30) {
      // Too slow / drawn out
      durationScore = math.max(30.0, (1.30 / durationRatio) * 100.0);
    }

    // 2. Rhythm Score: Syllables pacing per second
    final expectedMsPerSyllable = referenceDurationMs / math.max(1, expectedSyllables);
    final actualMsPerSyllable = learnerDurationMs / math.max(1, expectedSyllables);
    final pacingDeviation = (actualMsPerSyllable - expectedMsPerSyllable).abs() / expectedMsPerSyllable;
    final rhythmScore = (100.0 - (pacingDeviation * 80.0)).clamp(20.0, 100.0);

    // 3. Completeness Score: Penalize excessive abnormal pauses or premature stop
    double completenessScore = 100.0;
    if (learnerDurationMs < referenceDurationMs * 0.50) {
      completenessScore = 40.0; // Incomplete utterance
    } else if (detectedPauseCount > 3) {
      completenessScore -= (detectedPauseCount - 3) * 10.0;
    }
    completenessScore = completenessScore.clamp(30.0, 100.0);

    // Weighted Overall Score: 40% Rhythm, 35% Duration, 25% Completeness
    final overall = (0.40 * rhythmScore) + (0.35 * durationScore) + (0.25 * completenessScore);
    final isPassing = overall >= 70.0;

    // Formulate localized diagnostics
    String diagAr;
    String diagDe;
    String diagEn;

    if (overall >= 90.0) {
      diagAr = 'نُطْقٌ مُمْتَازٌ! مَخَارِجُ الحُرُوفِ وَالإِيقَاعُ مُتَطَابِقَانِ تَمَامًا.';
      diagDe = 'Ausgezeichnete Aussprache! Rhythmus und Artikulation stimmen perfekt überein.';
      diagEn = 'Excellent pronunciation! Rhythm and articulation match the native model.';
    } else if (durationRatio < 0.75) {
      diagAr = 'النُّطْقُ سَرِيعٌ جِدًّا؛ أَعْطِ كُلَّ حَرْفٍ وَحَرَكَةٍ حَقَّهَا مِنَ الزَّمَنِ.';
      diagDe = 'Zu schnelles Sprechtempo; nimm dir mehr Zeit für die Silbenbildung.';
      diagEn = 'Pace is too rushed; allow more duration for each vowel and syllable.';
    } else if (durationRatio > 1.30) {
      diagAr = 'النُّطْقُ بَطِيءٌ مَعَ مَدٍّ زَائِدٍ؛ حَاوِلِ النُّطْقَ بِانْسِيَابِيَّةٍ أَكْبَرَ.';
      diagDe = 'Sprechtempo zu gedehnt; versuche flüssiger ohne lange Pausen zu sprechen.';
      diagEn = 'Pace is too slow with drawn-out pauses; aim for a smoother cadence.';
    } else {
      diagAr = 'أَدَاءٌ جَيِّدٌ جِدًّا؛ دَرِّبْ لِسَانَكَ مَرَّةً أُخْرَى لِبُلُوغِ الإِتْقَانِ التَّامِّ.';
      diagDe = 'Sehr gute Leistung; wiederhole die Übung für vollkommene Genauigkeit.';
      diagEn = 'Very good attempt; repeat once more to achieve full rhythmic mastery.';
    }

    return PronunciationAssessmentResult(
      overallScore: overall.clamp(0.0, 100.0),
      rhythmScore: rhythmScore,
      durationScore: durationScore,
      completenessScore: completenessScore,
      diagnosticAr: diagAr,
      diagnosticDe: diagDe,
      diagnosticEn: diagEn,
      isPassing: isPassing,
    );
  }
}
