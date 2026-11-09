import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/syntactic_marker_validator.dart';

void main() {
  group('SyntacticMarkerValidator Comparative Grammar Alignment', () {
    test('Validates complete tripartite comparative sentences with markers', () {
      final sentences = {
        'ar': 'إِذَا صَوَّبَ المَسَّاحُ خَيْطَ الشَّاقُولِ، قَاسَ الِارتِفَاعَ عَبْرَ السِّلْكِ دُونَ مَشَقَّةٍ.',
        'de': 'Wenn der Landvermesser das Lot ausrichtet, misst er die Höhe durch den Faden ohne Mühe.',
        'en': 'When the surveyor aligns the plumb line, he measures the height through the wire without trouble.',
      };

      final result = SyntacticMarkerValidator.validate(
        sentences: sentences,
        requiredMarkers: [
          'conditional_idha_wenn_when',
          'instrumental_bi_mit_with',
          'exemption_duna_ohne_without',
        ],
      );

      expect(result.isValid, isTrue);
      expect(result.missingLanguages, isEmpty);
      expect(result.satisfiedMarkers.length, equals(3));
      expect(result.missingMarkers, isEmpty);
      expect(result.hasDiagnostics, isFalse);
    });

    test('Detects missing language and returns appropriate diagnostics', () {
      final incomplete = {
        'ar': 'إِذَا رَكَّبَ العَجَلَةَ دَارَتْ.',
        'de': 'Wenn er das Rad montiert, dreht es sich.',
        // Missing English!
      };

      final result = SyntacticMarkerValidator.validate(
        sentences: incomplete,
        requiredMarkers: ['conditional_idha_wenn_when'],
      );

      expect(result.isValid, isFalse);
      expect(result.missingLanguages, contains('en'));
      expect(result.hasDiagnostics, isTrue);
    });

    test('Detects broken marker alignment when a language omits the clause particle', () {
      final brokenMarker = {
        'ar': 'إِذَا صَوَّبَ المَسَّاحُ المِزْوَلَةَ.',
        'de': 'Wenn der Landvermesser die Sonnenuhr ausrichtet.',
        'en': 'The surveyor points the sundial directly.', // Missing 'when' / 'if'
      };

      final result = SyntacticMarkerValidator.validate(
        sentences: brokenMarker,
        requiredMarkers: ['conditional_idha_wenn_when'],
      );

      expect(result.isValid, isFalse);
      expect(result.missingMarkers, contains('conditional_idha_wenn_when'));
      expect(result.diagnostics.first, contains('en=false'));
    });
  });
}
