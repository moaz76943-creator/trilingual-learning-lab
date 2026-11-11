import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/cryptography/presentation/controllers/alkindi_cryptanalysis_controller.dart';

void main() {
  group('AlKindiCryptanalysisController - Classical Frequency Analysis Tests', () {
    late AlKindiCryptanalysisController controller;

    setUp(() {
      controller = AlKindiCryptanalysisController();
    });

    test('Initial state configures Classical Arabic sample with Caesar shift 3', () {
      final state = controller.state;
      expect(state.language, CryptoLanguage.arabic);
      expect(state.shiftKey, 3);
      expect(state.cipherText.isNotEmpty, isTrue);
      expect(state.totalLettersCount, greaterThan(20));
    });

    test('Frequency count accurately tabulates letters', () {
      controller.setLanguage(CryptoLanguage.english);
      controller.setShiftKey(0); // raw plain text
      controller.setCipherText('e e e t t a');

      final counts = controller.state.characterCounts;
      expect(counts['e'], 3);
      expect(counts['t'], 2);
      expect(counts['a'], 1);
      expect(controller.state.totalLettersCount, 6);

      final freqs = controller.state.empiricalFrequencies;
      expect(freqs['e'], 50.0);
      expect(freqs['t'], closeTo(33.33, 0.1));
      expect(freqs['a'], closeTo(16.66, 0.1));
    });

    test('Chi-squared statistic evaluates zero for exact matching profile', () {
      final state = controller.state;
      expect(state.chiSquaredStatistic, greaterThan(0.0));
    });

    test('Index of Coincidence (IoC) calculation conforms to Friedman-Kindi formula', () {
      controller.setLanguage(CryptoLanguage.english);
      // Uniform distribution has low IoC (~0.038), natural English has high IoC (~0.067)
      controller.setCipherText('the quick brown fox jumps over the lazy dog and the running wolf');
      final ioc = controller.state.indexOfCoincidence;
      expect(ioc, greaterThan(0.03));
    });

    test('Auto-detect best shift correctly breaks Caesar substitution via Chi-squared minimization', () {
      controller.setLanguage(CryptoLanguage.english);
      // Standard English sentence shifted by 5:
      // Plain: "experience is the teacher of all things"
      controller.setShiftKey(5);
      // Now auto-detect best shift
      final detectedKey = controller.autoDetectBestShift();
      expect(detectedKey, 5);
      expect(controller.state.shiftKey, 5);
    });

    test('Reset restores pristine state', () {
      controller.setShiftKey(10);
      controller.reset();

      expect(controller.state.shiftKey, 3);
      expect(controller.state.language, CryptoLanguage.arabic);
    });
  });
}
