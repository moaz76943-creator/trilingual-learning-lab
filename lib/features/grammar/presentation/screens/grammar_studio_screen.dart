import 'package:flutter/material.dart';
import '../controllers/grammar_studio_controller.dart';

/// Full interactive comparative grammar studio screen.
class GrammarStudioScreen extends StatefulWidget {
  final GrammarStudioController controller;

  const GrammarStudioScreen({
    super.key,
    required this.controller,
  });

  @override
  State<GrammarStudioScreen> createState() => _GrammarStudioScreenState();
}

class _GrammarStudioScreenState extends State<GrammarStudioScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;
        final rule = ctrl.rule;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: const Text('مَخْبَرُ القَوَاعِدِ وَالمُقَارَنَةِ (Grammar Studio)'),
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(
                  ctrl.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: ctrl.isBookmarked ? const Color(0xFFF59E0B) : Colors.white,
                ),
                tooltip: 'حِفْظُ القَاعِدَةِ فِي المَرْجِعِ',
                onPressed: ctrl.toggleBookmark,
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Rule Header Card
                  _buildRuleHeader(rule),
                  const SizedBox(height: 16),
                  // Comparative Parallel Sentences Card
                  _buildComparativeCard(rule, ctrl),
                  const SizedBox(height: 20),
                  // Interactive Clause Ordering Puzzle
                  _buildPuzzleSection(ctrl),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRuleHeader(GrammarComparativeRule rule) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            rule.titleAr,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Amiri', color: Color(0xFF0F172A)),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 6),
          Text(
            '${rule.titleDe} • ${rule.titleEn}',
            style: const TextStyle(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildComparativeCard(GrammarComparativeRule rule, GrammarStudioController ctrl) {
    final sentences = rule.exampleSentences;

    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF5EEAD4), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.compare_arrows, color: Color(0xFF0D9488)),
              const SizedBox(width: 8),
              const Text(
                'التَّرَاكِيبُ المُتَقَابِلَةُ فِي اللُّغَاتِ الثَّلاَثِ',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F766E), fontSize: 14),
              ),
              const Spacer(),
              if (ctrl.alignmentResult.isValid)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCCFBF1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('تَطَابُقٌ نَحْوِيٌّ تَامٌّ', style: TextStyle(fontSize: 11, color: Color(0xFF0F766E), fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          const Divider(height: 20, color: Color(0xFF99F6E4)),
          // Arabic Sentence
          Text(
            sentences['ar'] ?? '',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Amiri', color: Color(0xFF134E4A)),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 10),
          // German Sentence
          Text(
            sentences['de'] ?? '',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 6),
          // English Sentence
          Text(
            sentences['en'] ?? '',
            style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
          ),
        ],
      ),
    );
  }

  Widget _buildPuzzleSection(GrammarStudioController ctrl) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'تَرْتِيبُ الجُمَلِ الشَّرْطِيَّةِ (Clause Alignment Puzzle)',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A), fontSize: 14),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 6),
          const Text(
            'رَتِّبِ المَقَاطِعَ النَّحْوِيَّةَ بِالتَّتَابُعِ المَنْطِقِيِّ الصَّحِيحِ:',
            style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 14),

          // User Arrangement Drop Target Area
          Container(
            constraints: const BoxConstraints(minHeight: 60),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ctrl.isPuzzleCorrect == null
                    ? const Color(0xFFCBD5E1)
                    : (ctrl.isPuzzleCorrect! ? const Color(0xFF10B981) : const Color(0xFFEF4444)),
                width: 1.5,
              ),
            ),
            child: ctrl.userArrangedClauses.isEmpty
                ? const Center(
                    child: Text('انْقُرْ عَلَى المَقَاطِعِ أَدْنَاهُ لِإِضَافَتِهَا هُنَا', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
                  )
                : Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: ctrl.userArrangedClauses.map((clause) {
                      return Chip(
                        backgroundColor: const Color(0xFFE0F2FE),
                        deleteIconColor: const Color(0xFF0284C7),
                        label: Text(clause, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0369A1))),
                        onDeleted: () => ctrl.removeClause(clause),
                      );
                    }).toList(),
                  ),
          ),
          const SizedBox(height: 14),

          // Available Clauses Pool
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: ctrl.availableClauses.map((clause) {
              return ActionChip(
                backgroundColor: const Color(0xFFF1F5F9),
                label: Text(clause),
                onPressed: () => ctrl.addClause(clause),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Action Buttons and Feedback
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F172A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: ctrl.userArrangedClauses.isNotEmpty ? ctrl.checkPuzzle : null,
                  child: const Text('تَحَقَّقْ مِنَ التَّرْتِيبِ (Verify)'),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: ctrl.resetPuzzle,
                child: const Text('إِعَادَةٌ'),
              ),
            ],
          ),

          if (ctrl.isPuzzleCorrect != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ctrl.isPuzzleCorrect! ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    ctrl.isPuzzleCorrect! ? Icons.check_circle : Icons.cancel,
                    color: ctrl.isPuzzleCorrect! ? const Color(0xFF059669) : const Color(0xFFDC2626),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    ctrl.isPuzzleCorrect! ? 'أَحْسَنْتَ! التَّرْتِيبُ النَّحْوِيُّ سَلِيمٌ 100%.' : 'التَّرْتِيبُ غَيْرُ صَحِيحٍ، حَاوِلْ مَرَّةً أُخْرَى.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: ctrl.isPuzzleCorrect! ? const Color(0xFF059669) : const Color(0xFFDC2626),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
