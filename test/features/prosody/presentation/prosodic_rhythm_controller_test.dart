import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/prosody/presentation/controllers/prosodic_rhythm_controller.dart';

void main() {
  group('ProsodicRhythmController - Trilingual Prosody & Syllable Stress Tests', () {
    late ProsodicRhythmController controller;

    setUp(() {
      controller = ProsodicRhythmController();
    });

    test('Initial state configures Classical Arabic Farahidi meter (mutafaailun)', () {
      final state = controller.state;
      expect(state.selectedLanguage, ProsodicLanguage.arabic);
      expect(state.selectedItem.id, 'ar_mutafaailun');
      expect(state.selectedItem.syllables.length, 5);
      expect(state.selectedItem.syllables[2].isStressed, isTrue); // 'فا'
      expect(state.isMetronomePlaying, isTrue);
    });

    test('Syllable weight mapping correctly assigns light and heavy durations', () {
      final syllables = controller.state.selectedItem.syllables;
      expect(syllables[0].weight, SyllableWeight.light); // مُ (CV)
      expect(syllables[1].weight, SyllableWeight.light); // تَ (CV)
      expect(syllables[2].weight, SyllableWeight.heavy); // فَا (CVV)
      expect(syllables[3].weight, SyllableWeight.light); // عِ (CV)
      expect(syllables[4].weight, SyllableWeight.heavy); // لُنْ (CVC)
    });

    test('Language switching updates catalog to target prosodic items', () {
      controller.setLanguage(ProsodicLanguage.german);
      expect(controller.state.selectedLanguage, ProsodicLanguage.german);
      expect(controller.state.selectedItem.id, 'de_uebersetzen');

      controller.setLanguage(ProsodicLanguage.english);
      expect(controller.state.selectedLanguage, ProsodicLanguage.english);
      expect(controller.state.selectedItem.id, 'en_protest');
    });

    test('Metronome advancement steps through syllables circularly', () {
      controller.selectSyllable(0);
      expect(controller.state.activeSyllableIndex, 0);

      controller.advanceSyllableTick();
      expect(controller.state.activeSyllableIndex, 1);

      controller.advanceSyllableTick();
      expect(controller.state.activeSyllableIndex, 2);
    });

    test('Metronome BPM adjustment clamps within valid bounds', () {
      controller.setMetronomeBpm(120.0);
      expect(controller.state.metronomeBpm, 120.0);

      controller.setMetronomeBpm(200.0); // should clamp to 160
      expect(controller.state.metronomeBpm, 160.0);
    });

    test('Reset restores pristine state', () {
      controller.setLanguage(ProsodicLanguage.german);
      controller.reset();

      expect(controller.state.selectedLanguage, ProsodicLanguage.arabic);
      expect(controller.state.selectedItem.id, 'ar_mutafaailun');
    });
  });
}
