import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/data/adapters/content_schema_adapter.dart';
import 'package:trilingual_learning_lab/features/dialogues/domain/services/dialogue_turn_orchestrator.dart';
import 'package:trilingual_learning_lab/features/dialogues/presentation/controllers/dialogue_player_controller.dart';

void main() {
  group('DialoguePlayerController Full Turn & Mode Lifecycle', () {
    late CanonicalDialogue sampleDialogue;
    late DialoguePlayerController controller;

    setUp(() {
      sampleDialogue = const CanonicalDialogue(
        id: 'dial_test_001',
        title: TrilingualText(
          ar: 'حِوَارُ مَشْغَلِ الفَلَكِ',
          de: 'Werkstattgespräch Astronomie',
          en: 'Astronomy Workshop Dialogue',
        ),
        turns: [
          CanonicalDialogueTurn(
            speaker: TrilingualText(ar: 'المُعَلِّمُ', de: 'Meister', en: 'Master'),
            speech: TrilingualText(
              ar: 'فَرِّغْ نُحَاسَ الصَّفِيحَةِ بِدِقَّةٍ.',
              de: 'Feile das Plattenmessing präzise aus.',
              en: 'Pierce the plate brass precisely.',
            ),
          ),
          CanonicalDialogueTurn(
            speaker: TrilingualText(ar: 'التِّلْمِيذُ', de: 'Schüler', en: 'Student'),
            speech: TrilingualText(
              ar: 'سَأُتِمُّ نَقْشَ المَقَنْطَرَاتِ الآنَ.',
              de: 'Ich vollende nun die Almutantaren.',
              en: 'I will complete the altitude circles now.',
            ),
          ),
        ],
      );

      controller = DialoguePlayerController(dialogue: sampleDialogue);
    });

    test('Initializes with study mode and stopped playback', () {
      expect(controller.mode, equals(DialogueMode.study));
      expect(controller.playbackState, equals(DialoguePlaybackState.stopped));
      expect(controller.currentTurnIndex, equals(0));
      expect(controller.totalTurns, equals(2));
      expect(controller.currentTurn!.speaker.ar, equals('المُعَلِّمُ'));
    });

    test('Toggles play/pause state properly', () {
      controller.play();
      expect(controller.playbackState, equals(DialoguePlaybackState.playing));

      controller.pause();
      expect(controller.playbackState, equals(DialoguePlaybackState.paused));
    });

    test('Advances and retreats turns manually with completion tracking', () {
      expect(controller.isCompleted, isFalse);

      final hasNext = controller.nextTurn();
      expect(hasNext, isTrue);
      expect(controller.currentTurnIndex, equals(1));
      expect(controller.currentTurn!.speaker.ar, equals('التِّلْمِيذُ'));

      final atEnd = controller.nextTurn();
      expect(atEnd, isFalse);
      expect(controller.isCompleted, isTrue);

      controller.previousTurn();
      expect(controller.currentTurnIndex, equals(0));
    });

    test('Role-play mode hides target speaker lines and allows reveal', () {
      controller.setMode(DialogueMode.rolePlay, userRoleSpeaker: 'التِّلْمِيذُ');

      expect(controller.mode, equals(DialogueMode.rolePlay));
      expect(controller.userRoleSpeaker, equals('التِّلْمِيذُ'));

      // Turn 0 is 'المُعَلِّمُ' (not user) -> revealed
      expect(controller.currentTurnState!.isRevealed, isTrue);

      // Advance to user role turn
      controller.nextTurn();
      expect(controller.currentTurnIndex, equals(1));
      expect(controller.currentTurnState!.isRevealed, isFalse); // Hidden for recall

      controller.toggleReveal();
      expect(controller.currentTurnState!.isRevealed, isTrue);
    });
  });
}
