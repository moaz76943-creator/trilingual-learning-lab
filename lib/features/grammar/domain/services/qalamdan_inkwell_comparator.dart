import 'package:flutter/foundation.dart';

/// Trilingual comparative analysis for scribe's traveling pen-case (Qalamdan) integrated inkwell structures.
/// Models the linguistic framing of hermetic portable ink containment, silver inlay damascening,
/// and itinerant scholarly ergonomics across Arabic, German, and English.
class QalamdanInkwellComparator {
  final String conceptId;
  final Map<String, String> qalamdanStructures;
  final List<String> syntacticMarkers;

  const QalamdanInkwellComparator({
    required this.conceptId,
    required this.qalamdanStructures,
    required this.syntacticMarkers,
  });

  /// Evaluates alignment between traveling scribal instrument clauses across 3 languages.
  bool validateTrilingualAlignment() {
    final hasArabic = qalamdanStructures.containsKey('ar') && (qalamdanStructures['ar']?.isNotEmpty ?? false);
    final hasGerman = qalamdanStructures.containsKey('de') && (qalamdanStructures['de']?.isNotEmpty ?? false);
    final hasEnglish = qalamdanStructures.containsKey('en') && (qalamdanStructures['en']?.isNotEmpty ?? false);
    return hasArabic && hasGerman && hasEnglish && syntacticMarkers.isNotEmpty;
  }

  /// Factory producing standard curriculum model for Mosul silver-inlaid brass Qalamdan.
  factory QalamdanInkwellComparator.qalamdanModel() {
    return const QalamdanInkwellComparator(
      conceptId: 'codicology_qalamdan_inkwell_001',
      qalamdanStructures: {
        'ar': 'حِينَمَا يُغْلِقُ كَاتِبُ الدِّيوَانِ غِطَاءَ المَحْبَرَةِ المُلْتَحِمَةِ بِالمِقْلَمَةِ النُّحَاسِيَّةِ، يَنْحَبِسُ المِدَادُ بِإِحْكَامٍ يَأْمَنُ مَعَهُ السَّافِرُ مِنَ التَّسَرُّبِ أَثْنَاءَ وُثُوبِ الرَّوَاحِلِ فِي السَّفَرِ.',
        'de': 'Sobald der Kanzleischreiber den Schraubdeckel des an das Messingfutteral angegossenen Tintenfasses verschließt, bleibt die Tinte hermetisch versiegelt, sodass der Reisende selbst beim Trab der Reittiere vor Auslaufen sicher ist.',
        'en': 'Whenever the chancellery scribe closes the bayonet lid of the inkwell soldered to the brass pen-case, the ink seals hermetically, ensuring the traveler remains safe from spillage even amid the jolting trot of mounts.',
      },
      syntacticMarkers: [
        'temporal_subordinating_hinama_sobald_whenever',
        'hermetic_containment_prepositional_clause',
        'travel_resilience_adversative_phrase',
      ],
    );
  }

  Map<String, dynamic> toJson() => {
    'conceptId': conceptId,
    'qalamdanStructures': qalamdanStructures,
    'syntacticMarkers': syntacticMarkers,
  };
}
