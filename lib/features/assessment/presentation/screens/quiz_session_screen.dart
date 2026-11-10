import 'package:flutter/material.dart';
import '../../domain/services/quiz_evaluator_engine.dart';
import '../controllers/quiz_session_controller.dart';

/// Full interactive assessment and examination screen.
class QuizSessionScreen extends StatefulWidget {
  final QuizSessionController controller;
  final VoidCallback? onExamCompleted;

  const QuizSessionScreen({
    super.key,
    required this.controller,
    this.onExamCompleted,
  });

  @override
  State<QuizSessionScreen> createState() => _QuizSessionScreenState();
}

class _QuizSessionScreenState extends State<QuizSessionScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.controller.state == QuizSessionState.initial) {
      widget.controller.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: const Text('اخْتِبَارُ اللُّغَاتِ الثَّلاَثِ (Quiz Studio)'),
            backgroundColor: const Color(0xFF0F172A),
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

  Widget _buildBody(BuildContext context, QuizSessionController ctrl) {
    if (ctrl.state == QuizSessionState.completed) {
      return _buildCompletionSummary(context, ctrl);
    }

    final question = ctrl.currentQuestion;
    if (question == null) {
      return const Center(child: Text('لاَ تُوجَدُ أَسْئِلَةٌ مُتَاحَةٌ.'));
    }

    return Column(
      children: [
        // Progress Indicator
        LinearProgressIndicator(
          value: ctrl.progressPercentage / 100.0,
          backgroundColor: const Color(0xFFE2E8F0),
          valueColor: const AlwaysStoppedAnimation(Color(0xFF2563EB)),
          minHeight: 6,
        ),
        // Header Status
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'السُّؤَالُ ${ctrl.currentIndex + 1} مِنْ ${ctrl.totalQuestions}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF334155)),
              ),
              Text(
                'النِّقَاطُ: ${ctrl.currentScore}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF059669)),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Prompt Card
                Container(
                  padding: const EdgeInsets.all(22.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'مَا هُوَ المَعْنَى المَقْرُونُ لِهَذَا المُصْطَلَحِ؟',
                        style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        question.prompt,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                          fontFamily: 'Amiri',
                        ),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Options List
                ...question.options.map((option) {
                  return _buildOptionTile(option: option, ctrl: ctrl, question: question);
                }),
                // Rich Multilingual Explanation Card (Visible upon evaluation)
                if (ctrl.state == QuizSessionState.evaluated) ...[
                  const SizedBox(height: 16),
                  _buildExplanationCard(question: question, result: ctrl.lastResult!),
                ],
              ],
            ),
          ),
        ),
        // Action Button Bar
        _buildBottomBar(ctrl),
      ],
    );
  }

  Widget _buildOptionTile({
    required String option,
    required QuizSessionController ctrl,
    required QuizQuestion question,
  }) {
    final isSelected = ctrl.selectedOption == option;
    final isEvaluated = ctrl.state == QuizSessionState.evaluated;
    final isCorrect = option == question.correctAnswer;

    Color tileColor = Colors.white;
    Color borderColor = const Color(0xFFCBD5E1);

    if (isEvaluated) {
      if (isCorrect) {
        tileColor = const Color(0xFFECFDF5);
        borderColor = const Color(0xFF059669);
      } else if (isSelected) {
        tileColor = const Color(0xFFFFF1F2);
        borderColor = const Color(0xFFE11D48);
      }
    } else if (isSelected) {
      tileColor = const Color(0xFFEFF6FF);
      borderColor = const Color(0xFF2563EB);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: isEvaluated ? null : () => ctrl.selectOption(option),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: tileColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: isSelected || (isEvaluated && isCorrect) ? 2.0 : 1.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ),
              if (isEvaluated) ...[
                if (isCorrect)
                  const Icon(Icons.check_circle, color: Color(0xFF059669))
                else if (isSelected)
                  const Icon(Icons.cancel, color: Color(0xFFE11D48)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExplanationCard({
    required QuizQuestion question,
    required QuizEvaluationResult result,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: result.isCorrect ? const Color(0xFFF0FDF4) : const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: result.isCorrect ? const Color(0xFF86EFAC) : const Color(0xFFFECDD3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                result.isCorrect ? Icons.lightbulb : Icons.info_outline,
                color: result.isCorrect ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
              ),
              const SizedBox(width: 8),
              Text(
                result.isCorrect ? 'إِجَابَةٌ صَحِيحَةٌ!' : 'تَوْضِيحُ الإِجَابَةِ الصَّحِيحَةِ:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: result.isCorrect ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(question.explanationAr, style: const TextStyle(fontSize: 14, color: Color(0xFF1E293B))),
          const SizedBox(height: 4),
          Text(question.explanationDe, style: const TextStyle(fontSize: 13, color: Color(0xFF475569))),
          const SizedBox(height: 2),
          Text(question.explanationEn, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B))),
        ],
      ),
    );
  }

  Widget _buildBottomBar(QuizSessionController ctrl) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: ctrl.state == QuizSessionState.answering
              ? (ctrl.selectedOption != null ? ctrl.submitAnswer : null)
              : ctrl.nextQuestion,
          child: Text(
            ctrl.state == QuizSessionState.answering
                ? 'تَأْكِيدُ الإِجَابَةِ (Submit)'
                : (ctrl.currentIndex < ctrl.totalQuestions - 1 ? 'السُّؤَالُ التَّالِي (Next)' : 'عَرْضُ النَّتِيجَةِ (Finish)'),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildCompletionSummary(BuildContext context, QuizSessionController ctrl) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.workspace_premium, size: 84, color: Color(0xFFF59E0B)),
            const SizedBox(height: 16),
            const Text(
              'نَتِيجَةُ الاخْتِبَارِ النِّهَائِيَّةُ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 8),
            Text(
              '${ctrl.scorePercentage.toStringAsFixed(0)}%',
              style: const TextStyle(fontSize: 54, fontWeight: FontWeight.w900, color: Color(0xFF2563EB)),
            ),
            const SizedBox(height: 8),
            Text(
              'النِّقَاطُ المُحْرَزَةُ: ${ctrl.currentScore} مِنْ ${ctrl.totalQuestions * 10}',
              style: const TextStyle(fontSize: 16, color: Color(0xFF475569)),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF059669),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  widget.onExamCompleted?.call();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.check),
                label: const Text('إِتْمَامٌ وَحِفْظُ التَّقَدُّمِ'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
