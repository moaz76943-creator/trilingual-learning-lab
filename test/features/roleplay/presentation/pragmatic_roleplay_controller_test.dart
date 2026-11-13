import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/roleplay/presentation/controllers/pragmatic_roleplay_controller.dart';

void main() {
  group('PragmaticRoleplayController - Trilingual Roleplay Unit Tests', () {
    late PragmaticRoleplayController controller;

    setUp(() {
      controller = PragmaticRoleplayController();
    });

    test('Initial state configures Academic Colloquium scenario with initial turn', () {
      final state = controller.state;
      expect(state.activeScenario.id, 'academic_colloquium');
      expect(state.conversationHistory.length, 1);
      expect(state.conversationHistory.first.isUser, isFalse);
      expect(state.userPragmaticFitScore, greaterThan(80.0));
    });

    test('Submitting formal turn matching expected register awards high pragmatic score', () {
      controller.submitUserTurn(
        textAr: 'أَثْبَتَ ابْنُ الهَيْثَمِ قَانُونَ الانْعِكَاسِ عَبْرَ التَّجْرِبَةِ العِلْمِيَّةِ.',
        textDe: 'Alhazen bewies das Reflexionsgesetz durch empirische Experimente.',
        textEn: 'Ibn al-Haytham proved the law of reflection through rigorous empirical experiments.',
        speechAct: SpeechActType.assertion,
        register: PragmaticRegister.formalAcademic,
      );

      final history = controller.state.conversationHistory;
      expect(history.length, 3); // 1 initial + 1 user + 1 interlocutor reply
      expect(history[1].isUser, isTrue);
      expect(history[1].pragmaticScore, 1.0);
      expect(history[2].isUser, isFalse);
      expect(history[2].speechAct, SpeechActType.agreement);
    });

    test('Submitting casual turn in formal setting penalizes pragmatic fit and prompts correction', () {
      controller.submitUserTurn(
        textAr: 'مرحبا، كيف حالك؟',
        textDe: 'Hallo, wie geht es dir?',
        textEn: 'Hi, how are you doing?',
        speechAct: SpeechActType.inquiry,
        register: PragmaticRegister.casualColloquial, // Mismatch!
      );

      final history = controller.state.conversationHistory;
      expect(history.length, 3);
      expect(history[1].pragmaticScore, lessThan(0.6));
      // Interlocutor should politely object and request formal phrasing
      expect(history[2].speechAct, SpeechActType.politeRefusal);
    });

    test('Scenario switching resets conversation history to chosen scenario', () {
      final second = RoleplayScenario.scenarios[1];
      controller.selectScenario(second);

      expect(controller.state.activeScenario.id, 'manuscript_bazaar');
      expect(controller.state.conversationHistory.length, 1);
      expect(controller.state.conversationHistory.first.speakerNameAr, 'الوَرَّاقُ أَبُو جَعْفَر');
    });

    test('Reset restores pristine state', () {
      controller.selectScenario(RoleplayScenario.scenarios[1]);
      controller.reset();

      expect(controller.state.activeScenario.id, 'academic_colloquium');
    });
  });
}
