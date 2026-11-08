import 'package:flutter/foundation.dart';

/// Trilingual comparative analysis for Ibn Muqla's proportioned script geometry (Al-Khatt Al-Mansub).
/// Models the linguistic framing of the rhombic dot metric, circumscribed circular diameter,
/// and harmonious letterform ratio rules across Arabic, German, and English.
class ProportionalScriptComparator {
  final String conceptId;
  final Map<String, String> scriptStructures;
  final List<String> syntacticMarkers;

  const ProportionalScriptComparator({
    required this.conceptId,
    required this.scriptStructures,
    required this.syntacticMarkers,
  });

  /// Evaluates alignment between geometric calligraphic proportion clauses across 3 languages.
  bool validateTrilingualAlignment() {
    final hasArabic = scriptStructures.containsKey('ar') && (scriptStructures['ar']?.isNotEmpty ?? false);
    final hasGerman = scriptStructures.containsKey('de') && (scriptStructures['de']?.isNotEmpty ?? false);
    final hasEnglish = scriptStructures.containsKey('en') && (scriptStructures['en']?.isNotEmpty ?? false);
    return hasArabic && hasGerman && hasEnglish && syntacticMarkers.isNotEmpty;
  }

  /// Factory producing standard curriculum model for Ibn Muqla's proportioned calligraphy system.
  factory ProportionalScriptComparator.proportionalModel() {
    return const ProportionalScriptComparator(
      conceptId: 'calligraphy_proportional_script_001',
      scriptStructures: {
        'ar': 'إِذَا ضَبَطَ الخَطَّاطُ ارْتِفَاعَ الأَلِفِ بِسَبْعِ نِقَاطٍ مَعِينِيَّةٍ دَاخِلَ الدَّائِرَةِ الحَاصِرَةِ، انْتَظَمَتْ نِسَبُ الحُرُوفِ كُلِّهَا فِي تَنَاغُمٍ هَنْدَسِيٍّ يَعْكِسُ العَدْلَ البَصَرِيَّ عَلَى الصَّفْحَةِ.',
        'de': 'Wenn der Kalligraph die Höhe des Alif auf genau sieben Rautenpunkte innerhalb des umschriebenen Kreises eicht, fügen sich die Maße aller Buchstaben in eine geometrische Harmonie, die vollkommene visuelle Gerechtigkeit auf dem Bogen spiegelt.',
        'en': 'When the calligrapher calibrates the height of the Alif to seven rhombic dots inside the circumscribed circle, the proportions of all letters align in geometric harmony reflecting visual justice across the folio.',
      },
      syntacticMarkers: [
        'conditional_geometric_idha_wenn_when',
        'rhombic_dot_metric_adverbial_phrase',
        'visual_justice_consequence_clause',
      ],
    );
  }

  Map<String, dynamic> toJson() => {
    'conceptId': conceptId,
    'scriptStructures': scriptStructures,
    'syntacticMarkers': syntacticMarkers,
  };
}
