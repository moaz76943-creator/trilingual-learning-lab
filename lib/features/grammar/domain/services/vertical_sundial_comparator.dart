import 'package:flutter/foundation.dart';

/// Trilingual comparative analysis for vertical declining wall sundial structures.
/// Models the linguistic framing of facade orientation, wall azimuth declination,
/// and vertical gnomon shadow geometry across Arabic, German, and English.
class VerticalSundialComparator {
  final String conceptId;
  final Map<String, String> sundialStructures;
  final List<String> syntacticMarkers;

  const VerticalSundialComparator({
    required this.conceptId,
    required this.sundialStructures,
    required this.syntacticMarkers,
  });

  /// Evaluates alignment between vertical wall shadow clauses across 3 languages.
  bool validateTrilingualAlignment() {
    final hasArabic = sundialStructures.containsKey('ar') && (sundialStructures['ar']?.isNotEmpty ?? false);
    final hasGerman = sundialStructures.containsKey('de') && (sundialStructures['de']?.isNotEmpty ?? false);
    final hasEnglish = sundialStructures.containsKey('en') && (sundialStructures['en']?.isNotEmpty ?? false);
    return hasArabic && hasGerman && hasEnglish && syntacticMarkers.isNotEmpty;
  }

  /// Factory producing standard curriculum model for vertical declining sundial orientation.
  factory VerticalSundialComparator.verticalModel() {
    return const VerticalSundialComparator(
      conceptId: 'horology_vertical_declining_sundial_001',
      sundialStructures: {
        'ar': 'إِذَا انْحَرَفَ جِدَارُ المِئْذَنَةِ عَنْ جِهَةِ الجَنُوبِ الحَقِيقِيِّ، وَجَبَ إِمَالَةُ شَاخِصِ المِزْوَلَةِ بِزَاوِيَةٍ تُعَادِلُ انْحِرَافَ الحَائِطِ لِتَتَطَابَقَ سَاعَاتُ الظِّلِّ مَعَ الزَّمَنِ الشَّمْسِيِّ المَحَلِّيِّ.',
        'de': 'Weicht die Minarettwand von der echten Südrichtung ab, so muss der Gnomon um den exakten Wandabweichungswinkel geneigt werden, damit die Schattenstunden mit der wahren lokalen Sonnenzeit übereinstimmen.',
        'en': 'If the minaret wall declines from true astronomical south, the gnomon must be inclined by an angle compensating for the wall declination so that shadow hours coincide with local solar time.',
      },
      syntacticMarkers: [
        'conditional_imperative_idha_wajaba_wenn_so_muss_if_must',
        'azimuthal_declination_locative_marking',
        'solar_concordance_purpose_clause',
      ],
    );
  }

  Map<String, dynamic> toJson() => {
    'conceptId': conceptId,
    'sundialStructures': sundialStructures,
    'syntacticMarkers': syntacticMarkers,
  };
}
