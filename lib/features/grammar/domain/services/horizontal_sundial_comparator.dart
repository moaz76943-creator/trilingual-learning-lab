import 'package:flutter/foundation.dart';

/// Trilingual comparative analysis for horizontal sundial gnomon shadow ratio structures.
/// Models the linguistic framing of solar altitude, shadow casting geometry,
/// and canonical daylight division across Arabic, German, and English.
class HorizontalSundialComparator {
  final String conceptId;
  final Map<String, String> sundialStructures;
  final List<String> syntacticMarkers;

  const HorizontalSundialComparator({
    required this.conceptId,
    required this.sundialStructures,
    required this.syntacticMarkers,
  });

  /// Evaluates alignment between gnomon shadow projection clauses across 3 languages.
  bool validateTrilingualAlignment() {
    final hasArabic = sundialStructures.containsKey('ar') && (sundialStructures['ar']?.isNotEmpty ?? false);
    final hasGerman = sundialStructures.containsKey('de') && (sundialStructures['de']?.isNotEmpty ?? false);
    final hasEnglish = sundialStructures.containsKey('en') && (sundialStructures['en']?.isNotEmpty ?? false);
    return hasArabic && hasGerman && hasEnglish && syntacticMarkers.isNotEmpty;
  }

  /// Factory producing standard curriculum model for horizontal sundial solar tracking.
  factory HorizontalSundialComparator.sundialModel() {
    return const HorizontalSundialComparator(
      conceptId: 'horology_horizontal_sundial_001',
      sundialStructures: {
        'ar': 'عِنْدَمَا يَمِيلُ ظِلُّ الشَّاخِصِ النُّحَاسِيِّ نَحْوَ قَوْسِ العَصْرِ، يُدْرِكُ النَّاظِرُ دُخُولَ الوَقْتِ بِدِقَّةِ مَسَارِ الشَّمْسِ دُونَ اعْتِمَادٍ عَلَى حَرَكَةِ التُّرُوسِ.',
        'de': 'Wenn der Schatten des messingfarbenen Gnomons den Asr-Bogen berührt, erkennt der Betrachter den Beginn der Gebetszeit an der exakten Sonnenbahn ohne Abhängigkeit von mechanischen Zahnrädern.',
        'en': 'When the shadow of the brass gnomon aligns with the Asr prayer arc, the observer discerns the onset of the canonical hour by the solar trajectory without reliance on mechanical clockwork.',
      },
      syntacticMarkers: [
        'temporal_alignment_indama_wenn_when',
        'solar_azimuth_directional_construct',
        'mechanical_independence_prepositional_phrase',
      ],
    );
  }

  Map<String, dynamic> toJson() => {
    'conceptId': conceptId,
    'sundialStructures': sundialStructures,
    'syntacticMarkers': syntacticMarkers,
  };
}
