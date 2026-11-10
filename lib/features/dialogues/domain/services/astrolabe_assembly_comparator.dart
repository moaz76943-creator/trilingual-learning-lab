import 'package:flutter/foundation.dart';

/// Comparative grammar service analyzing astrolabe mechanical assembly clauses across AR, DE, EN.
class AstrolabeAssemblyComparator {
  final String dialogueId;
  final Map<String, String> assemblyClauses;
  final List<String> syntacticMarkers;

  const AstrolabeAssemblyComparator({
    required this.dialogueId,
    required this.assemblyClauses,
    required this.syntacticMarkers,
  });

  bool validateAlignment() {
    return assemblyClauses.containsKey('ar') &&
           assemblyClauses.containsKey('de') &&
           assemblyClauses.containsKey('en') &&
           syntacticMarkers.isNotEmpty;
  }

  factory AstrolabeAssemblyComparator.standard() {
    return const AstrolabeAssemblyComparator(
      dialogueId: 'dialogue_170_astrolabe_final_assembly',
      assemblyClauses: {
        'ar': 'شَدَّ الصَّانِعُ فَرَسَ التَّثْبِيتِ فِي شَقِّ القُطْبِ لِيَدُورَ العَنْكَبُوتُ بِانْسِيَابٍ دُونَ اهْتِزَازٍ.',
        'de': 'Der Handwerker trieb den Keil in den Bolzenschlitz, damit die Rete reibungslos ohne Spiel rotiert.',
        'en': 'The craftsman secured the wedge into the pin slot so that the rete rotates smoothly without play.',
      },
      syntacticMarkers: [
        'locative_fi_in_into',
        'purposive_li_damit_so_that',
        'privative_duna_ohne_without',
      ],
    );
  }
}
