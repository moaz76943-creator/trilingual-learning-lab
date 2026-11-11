import 'package:flutter/material.dart';
import '../controllers/phonetic_studio_controller.dart';

/// Full interactive phonetics laboratory and auditory discernment studio screen.
class PhoneticStudioScreen extends StatefulWidget {
  final PhoneticStudioController controller;

  const PhoneticStudioScreen({
    super.key,
    required this.controller,
  });

  @override
  State<PhoneticStudioScreen> createState() => _PhoneticStudioScreenState();
}

class _PhoneticStudioScreenState extends State<PhoneticStudioScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;
        final pair = ctrl.currentPair;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: const Text('مَخْبَرُ التَّمْيِيزِ الصَّوْتِيِّ (Phonetics Lab)'),
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'إِعَادَةُ التَّدْرِيبِ',
                onPressed: ctrl.reset,
              ),
            ],
          ),
          body: SafeArea(
            child: pair == null
                ? const Center(child: Text('لاَ تُوجَدُ أَزْوَاجٌ صَوْتِيَّةٌ مُتَاحَةٌ.'))
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Header Scorecard
                        _buildScoreHeader(ctrl),
                        const SizedBox(height: 16),
                        // Pair Category Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFBFDBFE)),
                          ),
                          child: Text(
                            pair.categoryName,
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1D4ED8), fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Auditory Minimal Pair Discernment Card
                        _buildAuditoryCard(pair, ctrl),
                        const SizedBox(height: 20),
                        // Articulatory Guidance Sheet
                        _buildArticulatoryGuide(pair),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildScoreHeader(PhoneticStudioController ctrl) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'الاخْتِبَارُ ${ctrl.activePairIndex + 1} مِنْ ${ctrl.totalPairs}',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF334155)),
          ),
          Text(
            'دِقَّةُ التَّمْيِيزِ: ${ctrl.accuracyPercentage.toStringAsFixed(0)}% (${ctrl.score}/${ctrl.totalAttempts})',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF059669)),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditoryCard(PhoneticMinimalPair pair, PhoneticStudioController ctrl) {
    return Container(
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
            'اسْتَمِعْ إِلَى النُّطْقِ وَحَدِّدِ الكَلِمَةَ المَسْمُوعَةَ:',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Listen Button
          FloatingActionButton.large(
            backgroundColor: const Color(0xFF0D9488),
            foregroundColor: Colors.white,
            elevation: 2,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('نُطْقُ الكَلِمَةِ: /${pair.isWordACorrect ? pair.ipaA : pair.ipaB}/'),
                  duration: const Duration(milliseconds: 1200),
                ),
              );
            },
            child: const Icon(Icons.volume_up, size: 44),
          ),
          const SizedBox(height: 24),
          // Choice Tiles
          Row(
            children: [
              Expanded(
                child: _buildChoiceButton(
                  word: pair.wordA,
                  ipa: pair.ipaA,
                  meaning: pair.meaningA,
                  isSelected: ctrl.selectedWord == pair.wordA,
                  isTarget: pair.targetWord == pair.wordA,
                  isEvaluated: ctrl.isCorrect != null,
                  onTap: () => ctrl.submitChoice(pair.wordA),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildChoiceButton(
                  word: pair.wordB,
                  ipa: pair.ipaB,
                  meaning: pair.meaningB,
                  isSelected: ctrl.selectedWord == pair.wordB,
                  isTarget: pair.targetWord == pair.wordB,
                  isEvaluated: ctrl.isCorrect != null,
                  onTap: () => ctrl.submitChoice(pair.wordB),
                ),
              ),
            ],
          ),
          if (ctrl.isCorrect != null) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ctrl.isCorrect! ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    ctrl.isCorrect! ? Icons.check_circle : Icons.cancel,
                    color: ctrl.isCorrect! ? const Color(0xFF059669) : const Color(0xFFDC2626),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      ctrl.isCorrect!
                          ? 'تَمْيِيزٌ صَوْتِيٌّ سَلِيمٌ! أَحْسَنْتَ.'
                          : 'إِجَابَةٌ خَاطِئَةٌ؛ الكَلِمَةُ المَسْمُوعَةُ هِيَ: ${pair.targetWord}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ctrl.isCorrect! ? const Color(0xFF059669) : const Color(0xFFDC2626),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            if (ctrl.activePairIndex < ctrl.totalPairs - 1)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F172A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('التَّالِي (Next Pair)'),
                onPressed: ctrl.nextPair,
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildChoiceButton({
    required String word,
    required String ipa,
    required String meaning,
    required bool isSelected,
    required bool isTarget,
    required bool isEvaluated,
    required VoidCallback onTap,
  }) {
    Color bg = Colors.white;
    Color border = const Color(0xFFCBD5E1);

    if (isEvaluated) {
      if (isTarget) {
        bg = const Color(0xFFECFDF5);
        border = const Color(0xFF059669);
      } else if (isSelected) {
        bg = const Color(0xFFFFF1F2);
        border = const Color(0xFFE11D48);
      }
    } else if (isSelected) {
      bg = const Color(0xFFEFF6FF);
      border = const Color(0xFF2563EB);
    }

    return InkWell(
      onTap: isEvaluated ? null : onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: border, width: isSelected || (isEvaluated && isTarget) ? 2.0 : 1.0),
        ),
        child: Column(
          children: [
            Text(
              word,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Amiri', color: Color(0xFF0F172A)),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 4),
            Text(
              '/$ipa/',
              style: const TextStyle(fontSize: 12, fontFamily: 'monospace', color: Color(0xFF0D9488)),
            ),
            const SizedBox(height: 6),
            Text(
              meaning,
              style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticulatoryGuide(PhoneticMinimalPair pair) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: const [
              Icon(Icons.record_voice_over, color: Color(0xFF0F766E), size: 20),
              SizedBox(width: 8),
              Text(
                'إِرْشَادَاتُ المَخْرَجِ الصَّوْتِيِّ (Articulatory Guide)',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F766E), fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            pair.articulatoryTipAr,
            style: const TextStyle(fontSize: 14, color: Color(0xFF1E293B)),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 6),
          Text(
            pair.articulatoryTipDe,
            style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
          ),
          const SizedBox(height: 4),
          Text(
            pair.articulatoryTipEn,
            style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }
}
