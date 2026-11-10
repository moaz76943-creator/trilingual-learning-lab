import 'package:flutter/foundation.dart';

/// Comparative grammar service analyzing universal astrolabe clauses across AR, DE, EN.
class ZarqalluSaphaeaComparator {
  final String dialogueId;
  final Map<String, String> universalClauses;
  final List<String> syntacticMarkers;

  const ZarqalluSaphaeaComparator({
    required this.dialogueId,
    required this.universalClauses,
    required this.syntacticMarkers,
  });

  bool validateAlignment() {
    return universalClauses.containsKey('ar') &&
           universalClauses.containsKey('de') &&
           universalClauses.containsKey('en') &&
           syntacticMarkers.isNotEmpty;
  }

  factory ZarqalluSaphaeaComparator.standard() {
    return const ZarqalluSaphaeaComparator(
      dialogueId: 'dialogue_171_zarqallu_saphaea_dialogue',
      universalClauses: {
        'ar': 'عَمَّمَ الزَّرْقَالِيُّ صَفِيحَةَ الإِسْقَاطِ فَاسْتَغْنَى المَسَّاحُ عَنْ تَبْدِيلِ الصَّفَائِحِ فِي كُلِّ إِقْلِيمٍ.',
        'de': 'Al-Zarqali verallgemeinerte die Projektionsplatte, sodass der Gelehrte auf den Plattenwechsel in jeder Klimazone verzichten konnte.',
        'en': 'Al-Zarqali generalized the projection plate, allowing the surveyor to dispense with swapping plates in every climate.',
      },
      syntacticMarkers: [
        'causal_resultative_fa_sodass_allowing',
        'privative_istaghna_an_verzichten_dispense_with',
        'spatial_universal_kull_jeder_every',
      ],
    );
  }
}
