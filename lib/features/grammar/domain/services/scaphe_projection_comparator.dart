import 'package:flutter/foundation.dart';

/// Trilingual comparative analysis for hemispherical scaphe sundial structures.
/// Models the linguistic framing of concave celestial mirroring, inverted dome projection,
/// and focal shadow nodus tracking across Arabic, German, and English.
class ScapheProjectionComparator {
  final String conceptId;
  final Map<String, String> scapheStructures;
  final List<String> syntacticMarkers;

  const ScapheProjectionComparator({
    required this.conceptId,
    required this.scapheStructures,
    required this.syntacticMarkers,
  });

  /// Evaluates alignment between concave projection clauses across 3 languages.
  bool validateTrilingualAlignment() {
    final hasArabic = scapheStructures.containsKey('ar') && (scapheStructures['ar']?.isNotEmpty ?? false);
    final hasGerman = scapheStructures.containsKey('de') && (scapheStructures['de']?.isNotEmpty ?? false);
    final hasEnglish = scapheStructures.containsKey('en') && (scapheStructures['en']?.isNotEmpty ?? false);
    return hasArabic && hasGerman && hasEnglish && syntacticMarkers.isNotEmpty;
  }

  /// Factory producing standard curriculum model for hemispherical scaphe solar tracking.
  factory ScapheProjectionComparator.scapheModel() {
    return const ScapheProjectionComparator(
      conceptId: 'horology_hemispherical_scaphe_001',
      scapheStructures: {
        'ar': 'حِينَ يَعْبُرُ ضَوْءُ الشَّمْسِ فَوْقَ حَبَّةِ الشَّاخِصِ المَرْكَزِيَّةِ، تَرْسُمُ نُقْطَةُ الظِّلِّ دَاخِلَ التَّجْوِيفِ النِّصْفِ كُرَوِيِّ مَسَارًا يُحَاكِي قُبَّةَ السَّمَاءِ مَعْكُوسَةً بِدِقَّةٍ مُتَنَاهِيَةٍ.',
        'de': 'Wenn das Sonnenlicht über die zentrale Gnomonkugel streicht, zeichnet der Schattenpunkt in der halbkugelförmigen Vertiefung eine Bahn, die das Himmelsgewölbe spiegelbildlich mit vollendeter Präzision nachbildet.',
        'en': 'When sunlight traverses the central gnomon nodus, the shadow point traces a trajectory inside the hemispherical hollow that mirrors the celestial dome inverted with consummate precision.',
      },
      syntacticMarkers: [
        'temporal_subordinating_hina_wenn_when',
        'concave_spatial_inversion_marking',
        'precision_adverbial_complement',
      ],
    );
  }

  Map<String, dynamic> toJson() => {
    'conceptId': conceptId,
    'scapheStructures': scapheStructures,
    'syntacticMarkers': syntacticMarkers,
  };
}
