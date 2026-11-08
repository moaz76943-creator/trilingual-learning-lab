import 'package:flutter/foundation.dart';

/// Values and ethics service guiding pen sharpening and cutting crafts toward decisive focus,
/// treating blades with reverence as intellectual instruments, and understanding that unambiguous expression demands keen precision.
class NibMasteryEthicsService {
  final String principleId;
  final String coreTenetAr;
  final String coreTenetDe;
  final String coreTenetEn;
  final List<String> ethicalImperatives;

  const NibMasteryEthicsService({
    required this.principleId,
    required this.coreTenetAr,
    required this.coreTenetDe,
    required this.coreTenetEn,
    required this.ethicalImperatives,
  });

  /// Factory creating the classical canon of pen trimming mastery and calligraphic resolve.
  factory NibMasteryEthicsService.resolveCanon() {
    return const NibMasteryEthicsService(
      principleId: 'ethics_nib_mastery_001',
      coreTenetAr: 'شَحْذُ العَزِيمَةِ مَعَ شَحْذِ السِّكِّينِ، وَمُبَاشَرَةُ القَطْعِ بِصِدْقٍ وَيَقِينٍ دُونَ تَرَدُّدٍ؛ فَمَا تَعَثَّرَ القَلَمُ إِلاَّ حِينَ تَرَدَّدَتِ اليَدُ.',
      coreTenetDe: 'Schärfung der inneren Entschlossenheit zugleich mit der Klinge; unerschütterliche Meisterschaft ohne Zögern, denn die Feder stockt nur, wenn die Hand zweifelt.',
      coreTenetEn: 'Honing inner resolve alongside the blade, executing the cut with unwavering certainty without hesitation; for the pen falters only when the hand wavers.',
      ethicalImperatives: [
        'decisive_unwavering_execution_in_nib_beveling',
        'reverence_for_blades_as_sacred_tools_of_thought',
        'meticulous_care_in_preventing_fiber_splintering',
        'cultivating_patience_and_humility_at_the_whetstone',
      ],
    );
  }

  bool verifyEthicalCompliance() {
    return coreTenetAr.isNotEmpty &&
           coreTenetDe.isNotEmpty &&
           coreTenetEn.isNotEmpty &&
           ethicalImperatives.length >= 4;
  }
}
