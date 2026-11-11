import 'package:flutter/material.dart';
import '../controllers/morphology_cloze_controller.dart';

/// Full interactive morphology and root-radical cloze exercise screen.
class MorphologyClozeScreen extends StatefulWidget {
  final MorphologyClozeController controller;

  const MorphologyClozeScreen({
    super.key,
    required this.controller,
  });

  @override
  State<MorphologyClozeScreen> createState() => _MorphologyClozeScreenState();
}

class _MorphologyClozeScreenState extends State<MorphologyClozeScreen> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;
        final ex = ctrl.currentExercise;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: const Text('مَخْبَرُ الأَوْزَانِ وَالصَّرْفِ (Cloze Studio)'),
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'إِعَادَةُ التَّدْرِيبِ',
                onPressed: () {
                  _inputController.clear();
                  ctrl.reset();
                },
              ),
            ],
          ),
          body: SafeArea(
            child: ex == null
                ? const Center(child: Text('لاَ تُوجَدُ تَمَارِينُ مُتَاحَةٌ.'))
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Progress Status
                        _buildProgressHeader(ctrl),
                        const SizedBox(height: 16),
                        // Cloze Sentence Card
                        _buildSentenceCard(ex, ctrl),
                        const SizedBox(height: 16),
                        // Input Field Card
                        _buildInputCard(ctrl),
                        const SizedBox(height: 16),
                        // Action Button
                        _buildActionButton(ctrl),
                        // Evaluation Feedback (Visible upon submission)
                        if (ctrl.lastResult != null) ...[
                          const SizedBox(height: 16),
                          _buildFeedbackCard(ctrl.lastResult!),
                        ],
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildProgressHeader(MorphologyClozeController ctrl) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'التَّمْرِينُ ${ctrl.currentIndex + 1} مِنْ ${ctrl.totalExercises}',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF334155)),
          ),
          Text(
            'المَجْمُوعُ: ${ctrl.totalScore.toStringAsFixed(0)} نُقْطَةٍ',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D9488)),
          ),
        ],
      ),
    );
  }

  Widget _buildSentenceCard(MorphologyClozeExercise ex, MorphologyClozeController ctrl) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Cloze Sentence in Arabic
          Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 22, fontFamily: 'Amiri', color: Color(0xFF0F172A), height: 1.6),
              children: [
                TextSpan(text: '${ex.sentenceArBefore} '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFF59E0B)),
                    ),
                    child: Text(
                      ctrl.userAnswer.isEmpty ? '[.........]' : ctrl.userAnswer,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF92400E)),
                    ),
                  ),
                ),
                TextSpan(text: ' ${ex.sentenceArAfter}'),
              ],
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
          const Divider(height: 24),
          // German and English Context Translations
          Text('DE: ${ex.translationDe}', style: const TextStyle(fontSize: 13, color: Color(0xFF334155))),
          const SizedBox(height: 4),
          Text('EN: ${ex.translationEn}', style: const TextStyle(fontSize: 13, color: Color(0xFF64748B))),
          const SizedBox(height: 12),
          // Root Hint Button
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
              icon: Icon(ctrl.showRootHint ? Icons.visibility_off : Icons.lightbulb_outline, size: 16),
              label: Text(ctrl.showRootHint ? 'إِخْفَاءُ الجَذْرِ' : 'كَشْفُ جَذْرِ الكَلِمَةِ'),
              onPressed: ctrl.toggleRootHint,
            ),
          ),
          if (ctrl.showRootHint) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'الجَذْرُ: ${ex.rootAr} | الوَزْنُ الصَّرْفِيُّ: ${ex.templateAr}',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1E40AF)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputCard(MorphologyClozeController ctrl) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _inputController,
            textDirection: TextDirection.rtl,
            style: const TextStyle(fontSize: 20, fontFamily: 'Amiri', fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              hintText: 'اكْتُبِ الفِعْلَ بِالتَّصْرِيفِ الصَّحِيحِ...',
              border: OutlineInputBorder(),
            ),
            onChanged: ctrl.setUserAnswer,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(MorphologyClozeController ctrl) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0F172A),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: !ctrl.isEvaluated
            ? (ctrl.userAnswer.trim().isNotEmpty ? ctrl.submitAnswer : null)
            : (ctrl.currentIndex < ctrl.totalExercises - 1 ? () {
                _inputController.clear();
                ctrl.nextExercise();
              } : null),
        child: Text(
          !ctrl.isEvaluated
              ? 'تَأْكِيدُ الصَّرْفِ (Verify)'
              : (ctrl.currentIndex < ctrl.totalExercises - 1 ? 'التَّمْرِينُ التَّالِي (Next)' : 'اكْتَمَلَتِ التَّمَارِينُ'),
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildFeedbackCard(ClozeEvaluationResult result) {
    Color bg;
    Color border;
    Color text;

    switch (result.tier) {
      case ClozeEvaluationTier.exact:
        bg = const Color(0xFFF0FDF4);
        border = const Color(0xFF86EFAC);
        text = const Color(0xFF15803D);
        break;
      case ClozeEvaluationTier.normalized:
        bg = const Color(0xFFFEF3C7);
        border = const Color(0xFFFDE68A);
        text = const Color(0xFFB45309);
        break;
      case ClozeEvaluationTier.rootMatch:
        bg = const Color(0xFFEFF6FF);
        border = const Color(0xFFBFDBFE);
        text = const Color(0xFF1D4ED8);
        break;
      case ClozeEvaluationTier.mismatched:
        bg = const Color(0xFFFEF2F2);
        border = const Color(0xFFFECDD3);
        text = const Color(0xFFB91C1C);
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                '+${result.scoreEarned.toStringAsFixed(0)} نِقَاطٍ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: text),
              ),
              const Spacer(),
              Text(
                result.feedbackAr,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: text, fontFamily: 'Amiri'),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(result.feedbackDe, style: TextStyle(fontSize: 12, color: text.withOpacity(0.9))),
          const SizedBox(height: 2),
          Text(result.feedbackEn, style: TextStyle(fontSize: 12, color: text.withOpacity(0.8))),
        ],
      ),
    );
  }
}
