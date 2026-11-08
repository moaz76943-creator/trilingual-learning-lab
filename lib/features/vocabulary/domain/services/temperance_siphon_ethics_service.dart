import 'package:flutter/foundation.dart';

/// Values and ethics service guiding ingenious automata toward moral instruction,
/// promoting the virtue of moderation (قَنَاعَة), and warning against unbridled greed and civic waste.
class TemperanceSiphonEthicsService {
  final String principleId;
  final String coreTenetAr;
  final String coreTenetDe;
  final String coreTenetEn;
  final List<String> ethicalImperatives;

  const TemperanceSiphonEthicsService({
    required this.principleId,
    required this.coreTenetAr,
    required this.coreTenetDe,
    required this.coreTenetEn,
    required this.ethicalImperatives,
  });

  /// Factory creating the classical canon of mechanical temperance and ethical contentment.
  factory TemperanceSiphonEthicsService.temperanceCanon() {
    return const TemperanceSiphonEthicsService(
      principleId: 'ethics_temperance_siphon_001',
      coreTenetAr: 'تَسْخِيرُ الحِيَلِ الهَيْدْرُولِيكِيَّةِ لِتَرْبِيَةِ النُّفُوسِ عَلَى الِاقْتِصَادِ وَالقَنَاعَةِ، وَالتَّنْفِيرِ مِنَ الإِسْرَافِ وَالجَشَعِ بِالبُرْهَانِ المَحْسُوسِ.',
      coreTenetDe: 'Einsatz hydraulischer Vorrichtungen zur Erziehung zu Genügsamkeit und Mäßigung und zur sinnlichen Veranschaulichung der Torheit von Gier und Maßlosigkeit.',
      coreTenetEn: 'Harnessing hydraulic automata to cultivate habits of frugality and contentment, tangibly demonstrating the folly of greed and excess.',
      ethicalImperatives: [
        'practical_pedagogy_of_moderation_in_abundance',
        'rejection_of_gluttony_and_wasteful_consumption',
        'harmonious_synthesis_of_playful_wit_and_moral_wisdom',
        'humility_in_contemplating_physical_laws',
      ],
    );
  }

  bool verifyEthicalCompliance() {
    return coreTenetAr.isNotEmpty &&
           coreTenetDe.isNotEmpty &&
           coreTenetEn.isNotEmpty &&
           ethicalImperatives.length >= 3;
  }
}
