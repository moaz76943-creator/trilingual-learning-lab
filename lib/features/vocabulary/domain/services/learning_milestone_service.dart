class MilestoneProgress {
  final int masteredConcepts;
  final int completedDialogues;
  final double overallRetentionRate;
  final String levelTitle;

  const MilestoneProgress({
    required this.masteredConcepts,
    required this.completedDialogues,
    required this.overallRetentionRate,
    required this.levelTitle,
  });
}

class LearningMilestoneService {
  static MilestoneProgress calculateProgress({
    required int conceptsCount,
    required int dialoguesCount,
    required int successfulReviews,
    required int totalReviews,
  }) {
    final retention = totalReviews == 0 ? 100.0 : (successfulReviews / totalReviews) * 100.0;
    String title = 'مُبْتَدِئٌ شَغُوفٌ (A1)';
    if (conceptsCount >= 50 && dialoguesCount >= 5) {
      title = 'مُتَعَلِّمٌ مُتَقَدِّمٌ (A2)';
    } else if (conceptsCount >= 100 && dialoguesCount >= 10) {
      title = 'مُتَمَكِّنٌ مُتْقِنٌ (B1)';
    }

    return MilestoneProgress(
      masteredConcepts: conceptsCount,
      completedDialogues: dialoguesCount,
      overallRetentionRate: double.parse(retention.toStringAsFixed(1)),
      levelTitle: title,
    );
  }
}
