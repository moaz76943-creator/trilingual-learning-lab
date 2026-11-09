import 'package:flutter/foundation.dart';

/// Comparative grammar service analyzing astrolabe stereographic projection clauses across AR, DE, EN.
class StereographicProjectionComparator {
  final String dialogueId;
  final Map<String, String> projectionClauses;
  final List<String> syntacticMarkers;

  const StereographicProjectionComparator({
    required this.dialogueId,
    required this.projectionClauses,
    required this.syntacticMarkers,
  });

  bool validateAlignment() {
    return projectionClauses.containsKey('ar') &&
           projectionClauses.containsKey('de') &&
           projectionClauses.containsKey('en') &&
           syntacticMarkers.isNotEmpty;
  }

  factory StereographicProjectionComparator.standard() {
    return const StereographicProjectionComparator(
      dialogueId: 'dialogue_169_stereographic_tympan_projection',
      projectionClauses: {
        'ar': 'أَسْقَطَ الفَلَكِيُّ دَوَائِرَ الِارتِفَاعِ بِالبِرْكَارِ حَتَّى تَبْدُوَ خُطُوطُ السُّمُوتِ جَلِيَّةً.',
        'de': 'Der Astronom projizierte die Höhenkreise mit dem Zirkel, damit die Azimutlinien deutlich hervortreten.',
        'en': 'The astronomer projected the altitude circles with the compass so that the azimuth lines appear distinctly.',
      },
      syntacticMarkers: [
        'instrumental_bi_mit_with',
        'purposive_hatta_damit_so_that',
        'adverbial_clarity_construct',
      ],
    );
  }
}
