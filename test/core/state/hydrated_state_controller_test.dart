import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/state/hydrated_state_controller.dart';
import 'package:trilingual_learning_lab/core/state/state_persistence_engine.dart';

class SampleSimulatorState {
  final double alidadeAngle;
  final String tympanId;

  const SampleSimulatorState({
    required this.alidadeAngle,
    required this.tympanId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SampleSimulatorState &&
          other.alidadeAngle == alidadeAngle &&
          other.tympanId == tympanId;

  @override
  int get hashCode => alidadeAngle.hashCode ^ tympanId.hashCode;
}

class SampleHydratedSimulatorController extends HydratedStateController<SampleSimulatorState> {
  SampleHydratedSimulatorController({
    required StatePersistenceEngine engine,
  }) : super(
          storageKey: 'test_simulator_controller',
          defaultState: const SampleSimulatorState(alidadeAngle: 0.0, tympanId: 'damascus'),
          persistenceEngine: engine,
          schemaVersion: 1,
        );

  @override
  Map<String, dynamic> toJson(SampleSimulatorState state) => {
        'angle': state.alidadeAngle,
        'tympan': state.tympanId,
      };

  @override
  SampleSimulatorState fromJson(Map<String, dynamic> json) => SampleSimulatorState(
        alidadeAngle: (json['angle'] as num).toDouble(),
        tympanId: json['tympan'] as String,
      );
}

void main() {
  group('HydratedStateController Persistence & Rehydration Tests', () {
    late StatePersistenceEngine engine;

    setUp(() {
      engine = StatePersistenceEngine();
    });

    test('Initializes with default state and rehydrates cleanly', () async {
      final controller = SampleHydratedSimulatorController(engine: engine);

      expect(controller.state.alidadeAngle, equals(0.0));
      expect(controller.state.tympanId, equals('damascus'));
      expect(controller.isHydrated, isFalse);

      await controller.rehydrate();
      expect(controller.isHydrated, isTrue);
    });

    test('Emits new state, persists to storage, and resurrects on controller recreation', () async {
      final controller1 = SampleHydratedSimulatorController(engine: engine);
      await controller1.rehydrate();

      controller1.emit(const SampleSimulatorState(alidadeAngle: 45.0, tympanId: 'toledo'));
      await controller1.saveNow(); // Immediate commit

      expect(controller1.state.alidadeAngle, equals(45.0));
      expect(controller1.state.tympanId, equals('toledo'));

      // Simulate app restart / controller recreation
      final controller2 = SampleHydratedSimulatorController(engine: engine);
      expect(controller2.state.alidadeAngle, equals(0.0)); // Default before rehydration

      await controller2.rehydrate();
      expect(controller2.state.alidadeAngle, equals(45.0)); // Resurrected!
      expect(controller2.state.tympanId, equals('toledo'));
    });

    test('Handles corrupted storage data safely falling back to default state', () async {
      // Inject corrupted JSON
      await engine.write('test_simulator_controller', '{invalid_corrupted_json:');

      final controller = SampleHydratedSimulatorController(engine: engine);
      await controller.rehydrate();

      expect(controller.isHydrated, isTrue);
      // Must not crash; retains default state safely
      expect(controller.state.alidadeAngle, equals(0.0));
      expect(controller.state.tympanId, equals('damascus'));
    });
  });
}
