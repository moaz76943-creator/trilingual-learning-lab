import 'package:flutter/material.dart';
import '../controllers/dictation_evaluator_controller.dart';

/// Full interactive audio dictation and orthographic verification screen.
class DictationEvaluatorScreen extends StatefulWidget {
  final DictationEvaluatorController controller;

  const DictationEvaluatorScreen({
    super.key,
    required this.controller,
  });

  @override
  State<DictationEvaluatorScreen> createState() => _DictationEvaluatorScreenState();
}

class _DictationEvaluatorScreenState extends State<DictationEvaluatorScreen> {
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
        final result = ctrl.lastResult;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: const Text('مَخْبَرُ الإِمْلاَءِ وَالتَّدْقِيقِ الصَّوْتِيِّ'),
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'إِعَادَةُ المَحَاوَلَةِ',
                onPressed: () {
                  _inputController.clear();
                  ctrl.reset();
                },
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Audio Listening Bar
                  _buildAudioBar(ctrl),
                  const SizedBox(height: 16),
                  // Dictation Typing Input Field
                  _buildInputCard(ctrl),
                  const SizedBox(height: 16),
                  // Action Evaluation Button
                  _buildSubmitButton(ctrl),
                  // Word-by-Word Diff Card (Visible upon evaluation)
                  if (result != null) ...[
                    const SizedBox(height: 20),
                    _buildDiffCard(result),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAudioBar(DictationEvaluatorController ctrl) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          FloatingActionButton.small(
            backgroundColor: const Color(0xFF0D9488),
            foregroundColor: Colors.white,
            onPressed: ctrl.togglePlay,
            child: Icon(ctrl.isPlaying ? Icons.pause : Icons.volume_up),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'اسْتَمِعْ جَيِّدًا وَاكْتُبِ الجُمْلَةَ بِدِقَّةٍ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                ),
                Text(
                  ctrl.isSlowSpeed ? 'سُرْعَةٌ مُبَطَّأَةٌ (0.75x Slow)' : 'سُرْعَةٌ طَبِيعِيَّةٌ (1.0x Normal)',
                  style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: ctrl.isSlowSpeed ? const Color(0xFF0D9488) : const Color(0xFF64748B),
              side: BorderSide(color: ctrl.isSlowSpeed ? const Color(0xFF0D9488) : const Color(0xFFCBD5E1)),
            ),
            onPressed: ctrl.toggleSlowSpeed,
            child: const Text('0.75x'),
          ),
        ],
      ),
    );
  }

  Widget _buildInputCard(DictationEvaluatorController ctrl) {
    final isArabic = ctrl.languageCode == 'ar';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _inputController,
            maxLines: 4,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            style: TextStyle(
              fontSize: isArabic ? 20 : 16,
              fontFamily: isArabic ? 'Amiri' : null,
              color: const Color(0xFF0F172A),
            ),
            decoration: const InputDecoration(
              hintText: 'اكْتُبْ مَا تَسْمَعُهُ هُنَا...',
              border: InputBorder.none,
            ),
            onChanged: ctrl.setTypedInput,
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(DictationEvaluatorController ctrl) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0F172A),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: ctrl.typedInput.trim().isNotEmpty ? ctrl.evaluate : null,
        icon: const Icon(Icons.spellcheck),
        label: const Text('تَحَقَّقْ مِنَ الإِمْلاَءِ (Verify Dictation)', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildDiffCard(DictationEvaluationResult result) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: result.isPerfect ? const Color(0xFFF0FDF4) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: result.isPerfect ? const Color(0xFF86EFAC) : const Color(0xFFE2E8F0),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'نِسْبَةُ الدِّقَّةِ: ${result.scorePercentage.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: result.isPerfect ? const Color(0xFF16A34A) : const Color(0xFFD97706),
                ),
              ),
              Text(
                '${result.matchedWords} / ${result.totalReferenceWords} كَلِمَاتٍ مُطَابِقَةٍ',
                style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          const Divider(height: 20),
          const Text(
            'التَّدْقِيقُ التَّفْصِيلِيُّ لِكُلِّ كَلِمَةٍ:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: result.wordDiffs.map((diff) {
              Color chipBg;
              Color chipText;

              switch (diff.status) {
                case WordMatchStatus.exact:
                  chipBg = const Color(0xFFDCFCE7);
                  chipText = const Color(0xFF15803D);
                  break;
                case WordMatchStatus.partial:
                  chipBg = const Color(0xFFFEF3C7);
                  chipText = const Color(0xFFB45309);
                  break;
                case WordMatchStatus.mismatched:
                  chipBg = const Color(0xFFFEE2E2);
                  chipText = const Color(0xFFB91C1C);
                  break;
              }

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: chipBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  diff.typedWord ?? '[${diff.referenceWord}]',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Amiri',
                    color: chipText,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
