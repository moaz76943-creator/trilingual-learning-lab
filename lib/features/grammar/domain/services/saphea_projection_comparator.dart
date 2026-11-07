import 'package:flutter/foundation.dart';

/// Trilingual comparative analysis for universal stereographic projection structures (Saphea Arzachelis).
/// Models the linguistic framing of latitude-independent projection, coordinate transformations,
/// and trans-geographic universality across Arabic, German, and English.
class SapheaProjectionComparator {
  final String conceptId;
  final Map<String, String> projectionStructures;
  final List<String> syntacticMarkers;

  const SapheaProjectionComparator({
    required this.conceptId,
    required this.projectionStructures,
    required this.syntacticMarkers,
  });

  /// Evaluates alignment between universal celestial coordinate clauses across 3 languages.
  bool validateTrilingualAlignment() {
    final hasArabic = projectionStructures.containsKey('ar') && (projectionStructures['ar']?.isNotEmpty ?? false);
    final hasGerman = projectionStructures.containsKey('de') && (projectionStructures['de']?.isNotEmpty ?? false);
    final hasEnglish = projectionStructures.containsKey('en') && (projectionStructures['en']?.isNotEmpty ?? false);
    return hasArabic && hasGerman && hasEnglish && syntacticMarkers.isNotEmpty;
  }

  /// Factory producing standard curriculum model for al-Zarqali's universal Saphea plate.
  factory SapheaProjectionComparator.sapheaModel() {
    return const SapheaProjectionComparator(
      conceptId: 'astronomy_universal_saphea_001',
      projectionStructures: {
        'ar': 'بِفَضْلِ إِسْقَاطِ الزَّرْقَالِيِّ الشَّامِلِ عَلَى مُسْتَوَى قُطْبَيِ الاِعْتِدَالَيْنِ، اسْتَغْنَى المَسَافِرُ عَنْ تَبْدِيلِ صَفَائِحِ الآفَاقِ لِكُلِّ بَلْدَةٍ يَرْتَحِلُ إِلَيْهَا.',
        'de': 'Dank der universellen Projektion von az-Zarqali auf die Ebene der Äquinoktialpole benötigte der Reisende keinen Austausch von Horizontplatten mehr für jeden Ort, den er bereiste.',
        'en': 'Owing to al-Zarqali’s universal projection onto the plane of the solstitial colure, the traveler was liberated from exchanging latitude plates for every town he traversed.',
      },
      syntacticMarkers: [
        'causal_prepositional_bifadli_dank_owing_to',
        'trans_geographic_universality_marker',
        'relative_locative_clause_alignment',
      ],
    );
  }

  Map<String, dynamic> toJson() => {
    'conceptId': conceptId,
    'projectionStructures': projectionStructures,
    'syntacticMarkers': syntacticMarkers,
  };
}
