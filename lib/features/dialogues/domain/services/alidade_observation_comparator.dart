import 'package:flutter/foundation.dart';

/// Comparative grammar service analyzing astrolabe alidade sighting clauses across AR, DE, EN.
class AlidadeObservationComparator {
  final String dialogueId;
  final Map<String, String> sightingClauses;
  final List<String> syntacticMarkers;

  const AlidadeObservationComparator({
    required this.dialogueId,
    required this.sightingClauses,
    required this.syntacticMarkers,
  });

  bool validateAlignment() {
    return sightingClauses.containsKey('ar') &&
           sightingClauses.containsKey('de') &&
           sightingClauses.containsKey('en') &&
           syntacticMarkers.isNotEmpty;
  }

  factory AlidadeObservationComparator.standard() {
    return const AlidadeObservationComparator(
      dialogueId: 'dialogue_168_astrolabe_alidade_observation',
      sightingClauses: {
        'ar': 'سَدَّدَ الرَّاصِدُ العِضَادَةَ نَحْوَ الشَّمْسِ حَتَّى سَقَطَ شُعَاعُ النُّورِ عَبْرَ الثَّقْبِ المَرْكَزِيِّ.',
        'de': 'Der Beobachter richtete die Alhidade auf die Sonne aus, bis der Lichtstrahl das zentrale Peilloch durchdrang.',
        'en': 'The observer collimated the alidade toward the sun until the ray of light passed through the central pinhole.',
      },
      syntacticMarkers: [
        'directional_nahwa_auf_toward',
        'purposive_hatta_bis_until',
        'instrumental_abra_durch_through',
      ],
    );
  }
}
