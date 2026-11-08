import 'package:flutter/foundation.dart';

/// Trilingual comparative analysis for classical Ahar sizing and starch-glaze pore sealing structures.
/// Models the linguistic framing of surface pore occlusion, ink feathering prevention,
/// and smooth calligraphic gliding across Arabic, German, and English.
class AharSizingComparator {
  final String conceptId;
  final Map<String, String> sizingStructures;
  final List<String> syntacticMarkers;

  const AharSizingComparator({
    required this.conceptId,
    required this.sizingStructures,
    required this.syntacticMarkers,
  });

  /// Evaluates alignment between surface preparation clauses across 3 languages.
  bool validateTrilingualAlignment() {
    final hasArabic = sizingStructures.containsKey('ar') && (sizingStructures['ar']?.isNotEmpty ?? false);
    final hasGerman = sizingStructures.containsKey('de') && (sizingStructures['de']?.isNotEmpty ?? false);
    final hasEnglish = sizingStructures.containsKey('en') && (sizingStructures['en']?.isNotEmpty ?? false);
    return hasArabic && hasGerman && hasEnglish && syntacticMarkers.isNotEmpty;
  }

  /// Factory producing standard curriculum model for Shiraz Ahar paper sizing.
  factory AharSizingComparator.sizingModel() {
    return const AharSizingComparator(
      conceptId: 'codicology_ahar_sizing_001',
      sizingStructures: {
        'ar': 'حِينَمَا يُطْلَى الكَاغَدُ بِعَصِيرِ الآهَارِ النَّشَوِيِّ ثُمَّ يُصْقَلُ بِمَحَارِ العَقِيقِ، تَنْسَدُّ مَسَامُهُ الدَّقِيقَةُ فَيَجْرِي قَلَمُ الخَطَّاطِ دُونَ أَنْ يَتَسَرَّبَ الحِبْرُ فِي أَلْيَافِ الوَرَقِ.',
        'de': 'Sobald das Papier mit der stärkehaltigen Ahar-Schlichte bestrichen und mit dem Achat geglättet wird, schließen sich die feinen Poren, sodass die Rohrfeder gleitet, ohne dass Tinte in die Fasern ausblutet.',
        'en': 'Whenever the paper is coated with starch Ahar glaze and burnished with agate, its microscopic pores seal completely, allowing the reed pen to glide without ink feathering into the fibers.',
      },
      syntacticMarkers: [
        'temporal_subordinating_hinama_sobald_whenever',
        'pore_occlusion_consequence_clause',
        'negative_feathering_prepositional_phrase',
      ],
    );
  }

  Map<String, dynamic> toJson() => {
    'conceptId': conceptId,
    'sizingStructures': sizingStructures,
    'syntacticMarkers': syntacticMarkers,
  };
}
