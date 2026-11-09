import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/data/adapters/content_schema_adapter.dart';
import 'package:trilingual_learning_lab/features/dialogues/domain/services/dialogue_turn_orchestrator.dart';

void main() {
  group('DialogueTurnOrchestrator Interactive Turn Flow', () {
    late CanonicalDialogue testDialogue;

    setUp(() {
      testDialogue = const CanonicalDialogue(
        id: 'dial_sundial_001',
        title: TrilingualText(
          ar: 'حِوَارُ المِزْوَلَةِ الشَّمْسِيَّةِ',
          de: 'Sonnenuhr-Gespräch',
          en: 'Sundial Dialogue',
        ),
        turns: [
          CanonicalDialogueTurn(
            speaker: TrilingualText(ar: 'المُعَلِّمُ', de: 'Meister', en: 'Master'),
            speech: TrilingualText(
              ar: 'ثَبِّتْ مِحْوَرَ الشَّاخِصِ بِدِقَّةٍ حَسَبَ عَرْضِ البَلَدِ.',
              de: 'Richte den Polstab genau nach der geographischen Breite aus.',
              en: 'Align the gnomon axis precisely to the local latitude.',
            ),
          ),
          CanonicalDialogueTurn(
            speaker: TrilingualText(ar: 'المُتَدَرِّبُ', de: 'Lehrling', en: 'Apprentice'),
            speech: TrilingualText(
              ar: 'تَمَّ ضَبْطُهُ مَعَ خَطِّ الزَّوَالِ الحَقِيقِيِّ.',
              de: 'Er ist nun auf den wahren Mittagskreis ausgerichtet.',
              en: 'It is now calibrated to the true meridian line.',
            ),
          ),
        ],
      );
    });

    test('Initializes with study mode and exposes current turn', () {
      final orchestrator = DialogueTurnOrchestrator(dialogue: testDialogue);

      expect(orchestrator.mode, equals(DialogueMode.study));
      expect(orchestrator.currentIndex, equals(0));
      expect(orchestrator.totalTurns, equals(2));
      expect(orchestrator.isFinished, isFalse);
      expect(orchestrator.currentTurn!.speaker.ar, equals('المُعَلِّمُ'));
      expect(orchestrator.currentTurnState!.isRevealed, isTrue);
    });

    test('Advances turns and computes progress fraction', () {
      final orchestrator = DialogueTurnOrchestrator(dialogue: testDialogue);

      expect(orchestrator.progressFraction, equals(0.0));

      final advanced = orchestrator.nextTurn();
      expect(advanced, isTrue);
      expect(orchestrator.currentIndex, equals(1));
      expect(orchestrator.progressFraction, equals(0.5));
      expect(orchestrator.currentTurn!.speaker.ar, equals('المُتَدَرِّبُ'));

      final atEnd = orchestrator.nextTurn();
      expect(atEnd, isFalse); // Cannot advance past final turn
      expect(orchestrator.progressFraction, equals(1.0));
      expect(orchestrator.isFinished, isTrue);
    });

    test('Role-play mode hides speech for chosen role speaker', () {
      final orchestrator = DialogueTurnOrchestrator(
        dialogue: testDialogue,
        initialMode: DialogueMode.rolePlay,
        userRoleSpeaker: 'المُتَدَرِّبُ',
      );

      // Turn 0 is 'المُعَلِّمُ' (not user) -> revealed
      expect(orchestrator.currentTurnState!.isRevealed, isTrue);

      orchestrator.nextTurn();
      // Turn 1 is 'المُتَدَرِّبُ' (user role) -> hidden initially for recall
      expect(orchestrator.currentTurnState!.isRevealed, isFalse);

      orchestrator.toggleReveal();
      expect(orchestrator.currentTurnState!.isRevealed, isTrue);
    });

    test('Navigation backwards and reset functionality', () {
      final orchestrator = DialogueTurnOrchestrator(dialogue: testDialogue);
      orchestrator.nextTurn();
      expect(orchestrator.currentIndex, equals(1));

      expect(orchestrator.previousTurn(), isTrue);
      expect(orchestrator.currentIndex, equals(0));
      expect(orchestrator.previousTurn(), isFalse); // Cannot go before 0

      orchestrator.jumpToTurn(1);
      expect(orchestrator.currentIndex, equals(1));

      orchestrator.reset();
      expect(orchestrator.currentIndex, equals(0));
      expect(orchestrator.progressFraction, equals(0.0));
    });
  });
}
