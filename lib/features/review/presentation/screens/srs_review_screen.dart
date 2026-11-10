import 'package:flutter/material.dart';
import '../../../../models/srs_card.dart';
import '../controllers/srs_review_controller.dart';

/// Interactive Spaced Repetition flashcard review screen.
class SrsReviewScreen extends StatefulWidget {
  final SrsReviewController controller;
  final VoidCallback? onSessionCompleted;

  const SrsReviewScreen({
    super.key,
    required this.controller,
    this.onSessionCompleted,
  });

  @override
  State<SrsReviewScreen> createState() => _SrsReviewScreenState();
}

class _SrsReviewScreenState extends State<SrsReviewScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.controller.state == SrsReviewState.initial) {
      widget.controller.startSession();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;

        return Scaffold(
          backgroundColor: const Color(0xFFF9F6F0), // Heritage warm parchment
          appBar: AppBar(
            title: const Text('مُرَاجَعَةُ التَّكْرَارِ المُتَبَاعِدِ (SRS)'),
            backgroundColor: const Color(0xFF1E293B),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: SafeArea(
            child: _buildBody(context, ctrl),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, SrsReviewController ctrl) {
    switch (ctrl.state) {
      case SrsReviewState.loading:
        return const Center(child: CircularProgressIndicator());

      case SrsReviewState.emptyQueue:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle_outline, size: 72, color: Color(0xFF059669)),
                const SizedBox(height: 16),
                const Text(
                  'لاَ تُوجَدُ بِطَاقَاتٌ مُسْتَحَقَّةٌ لِلْمُرَاجَعَةِ الآنَ!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Keine Karten zur Wiederholung fällig / All flashcards reviewed for today.',
                  style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('العَوْدَةُ إِلَى الرَّئِيسِيَّةِ'),
                ),
              ],
            ),
          ),
        );

      case SrsReviewState.sessionCompleted:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.stars, size: 80, color: Color(0xFFD97706)),
                const SizedBox(height: 16),
                const Text(
                  'اِكْتَمَلَتْ جَلْسَةُ المُرَاجَعَةِ بِنَجَاحٍ!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'البِطَاقَاتُ المُنْجَزَةُ: ${ctrl.completedCount} | نِسْبَةُ التَّذَكُّرِ: ${ctrl.retentionRate.toStringAsFixed(1)}%',
                  style: const TextStyle(fontSize: 16, color: Color(0xFF475569)),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {
                    widget.onSessionCompleted?.call();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('إِنْهَاءُ الجَلْسَةِ'),
                ),
              ],
            ),
          ),
        );

      case SrsReviewState.reviewing:
        final card = ctrl.currentCard;
        if (card == null) return const SizedBox.shrink();

        return Column(
          children: [
            // Progress Bar
            LinearProgressIndicator(
              value: ctrl.progressPercentage / 100.0,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: const ColorAnimation(const AlwaysStoppedAnimation(Color(0xFF0D9488))),
              minHeight: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'البِطَاقَةُ ${ctrl.currentIndex + 1} مِنْ ${ctrl.totalInSession}',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF334155)),
                  ),
                  Text(
                    'الـتَّذَكُّرُ: ${ctrl.retentionRate.toStringAsFixed(0)}%',
                    style: const TextStyle(color: Color(0xFF059669), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Interactive Flashcard
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: ctrl.flipCard,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(minHeight: 280),
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Arabic Front (Always visible)
                      Text(
                        card.frontAr,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                          fontFamily: 'Amiri',
                        ),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 24),
                      if (!ctrl.isFlipped) ...[
                        const Icon(Icons.touch_app, size: 28, color: Color(0xFF94A3B8)),
                        const SizedBox(height: 8),
                        const Text(
                          'اِنْقُرْ لِكَشْفِ التَّرْجَمَةِ / Antippen zum Aufdecken',
                          style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                        ),
                      ] else ...[
                        const Divider(height: 32, thickness: 1.2),
                        // German translation
                        Text(
                          card.frontDe,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        // English translation
                        Text(
                          card.frontEn,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xFF475569),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            // Rating Action Bar (Visible when flipped)
            if (ctrl.isFlipped)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    _buildRatingButton(
                      label: 'مُجَدَّدًا\n(1d)',
                      color: const Color(0xFFE11D48),
                      onPressed: () => ctrl.answerCard(0),
                    ),
                    const SizedBox(width: 8),
                    _buildRatingButton(
                      label: 'صَعْبٌ\n(Hard)',
                      color: const Color(0xFFD97706),
                      onPressed: () => ctrl.answerCard(3),
                    ),
                    const SizedBox(width: 8),
                    _buildRatingButton(
                      label: 'جَيِّدٌ\n(Good)',
                      color: const Color(0xFF0D9488),
                      onPressed: () => ctrl.answerCard(4),
                    ),
                    const SizedBox(width: 8),
                    _buildRatingButton(
                      label: 'سَهْلٌ\n(Easy)',
                      color: const Color(0xFF2563EB),
                      onPressed: () => ctrl.answerCard(5),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
          ],
        );

      case SrsReviewState.initial:
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildRatingButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
