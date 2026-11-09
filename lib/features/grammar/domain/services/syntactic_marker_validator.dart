import 'package:flutter/foundation.dart';

/// Evaluation result from comparative syntactic alignment validation.
class SyntacticAlignmentResult {
  final bool isValid;
  final List<String> missingLanguages;
  final List<String> satisfiedMarkers;
  final List<String> missingMarkers;
  final List<String> diagnostics;

  const SyntacticAlignmentResult({
    required this.isValid,
    required this.missingLanguages,
    required this.satisfiedMarkers,
    required this.missingMarkers,
    required this.diagnostics,
  });

  bool get hasDiagnostics => diagnostics.isNotEmpty;
}

/// Service evaluating grammatical parity and syntactic markers across trilingual sentences.
class SyntacticMarkerValidator {
  /// Known syntactic marker rule definitions.
  static final Map<String, Map<String, List<String>>> _markerLexicon = {
    'conditional_idha_wenn_when': {
      'ar': ['إِذَا', 'لَوْ', 'إِنْ'],
      'de': ['wenn', 'falls'],
      'en': ['when', 'if'],
    },
    'instrumental_bi_mit_with': {
      'ar': ['بِـ', 'بِوَاسِطَةِ', 'عَبْرَ'],
      'de': ['durch', 'mit', 'mittels'],
      'en': ['through', 'with', 'using', 'by'],
    },
    'exemption_duna_ohne_without': {
      'ar': ['دُونَ', 'بِلاَ', 'بِغَيْرِ'],
      'de': ['ohne'],
      'en': ['without'],
    },
  };

  /// Validates that [sentences] contains 'ar', 'de', 'en' and satisfies all [requiredMarkers].
  static SyntacticAlignmentResult validate({
    required Map<String, String> sentences,
    required List<String> requiredMarkers,
  }) {
    final missingLangs = <String>[];
    final satisfiedMarkers = <String>[];
    final missingMarkers = <String>[];
    final diagnostics = <String>[];

    for (final lang in ['ar', 'de', 'en']) {
      final s = sentences[lang];
      if (s == null || s.trim().isEmpty) {
        missingLangs.add(lang);
      }
    }

    if (missingLangs.isNotEmpty) {
      diagnostics.add('Missing language translations: ${missingLangs.join(', ')}');
      return SyntacticAlignmentResult(
        isValid: false,
        missingLanguages: missingLangs,
        satisfiedMarkers: const [],
        missingMarkers: requiredMarkers,
        diagnostics: diagnostics,
      );
    }

    final arText = sentences['ar']!;
    final deText = sentences['de']!.toLowerCase();
    final enText = sentences['en']!.toLowerCase();

    for (final markerKey in requiredMarkers) {
      final rule = _markerLexicon[markerKey];
      if (rule == null) {
        // Unknown custom marker: considered satisfied if all 3 languages are non-empty
        satisfiedMarkers.add(markerKey);
        continue;
      }

      final hasAr = rule['ar']!.any((kw) => arText.contains(kw));
      final hasDe = rule['de']!.any((kw) => deText.contains(kw));
      final hasEn = rule['en']!.any((kw) => enText.contains(kw));

      if (hasAr && hasDe && hasEn) {
        satisfiedMarkers.add(markerKey);
      } else {
        missingMarkers.add(markerKey);
        diagnostics.add('Marker [$markerKey] missing alignment: ar=$hasAr, de=$hasDe, en=$hasEn');
      }
    }

    final isValid = missingLangs.isEmpty && missingMarkers.isEmpty;

    return SyntacticAlignmentResult(
      isValid: isValid,
      missingLanguages: missingLangs,
      satisfiedMarkers: satisfiedMarkers,
      missingMarkers: missingMarkers,
      diagnostics: diagnostics,
    );
  }
}
