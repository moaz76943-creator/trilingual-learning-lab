import 'package:flutter/foundation.dart';

/// Comparative grammar service analyzing astrolabe rete proportional clauses across AR, DE, EN.
class AstrolabeReteComparator {
  final String dialogueId;
  final Map<String, String> technicalClauses;
  final List<String> syntacticMarkers;

  const AstrolabeReteComparator({
    required this.dialogueId,
    required this.technicalClauses,
    required this.syntacticMarkers,
  });

  bool validateAlignment() {
    return technicalClauses.containsKey('ar') &&
           technicalClauses.containsKey('de') &&
           technicalClauses.containsKey('en') &&
           syntacticMarkers.isNotEmpty;
  }

  factory AstrolabeReteComparator.standard() {
    return const AstrolabeReteComparator(
      dialogueId: 'dialogue_167_astrolabe_rete_pointers',
      technicalClauses: {
        'ar': 'فَرِّغِ النُّحَاسَ الزَّائِدَ بِالمِبْرَدِ حَتَّى تَبْدُوَ دَوَائِرُ المَقَنْطَرَاتِ بِوُضُوحٍ تَامٍّ.',
        'de': 'Feile das überschüssige Messing mit der Raspel aus, damit die Almutantarenkreise sichtbar werden.',
        'en': 'Pierce away the excess brass with the file so that the altitude circles show through clearly.',
      },
      syntacticMarkers: [
        'instrumental_bi_mit_with',
        'purposive_hatta_damit_so_that',
      ],
    );
  }
}
