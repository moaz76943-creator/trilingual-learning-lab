import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/craftsmanship/presentation/controllers/kundekari_studio_controller.dart';

void main() {
  group('KundekariStudioController Joinery & Expansion State', () {
    late KundekariStudioController controller;

    setUp(() {
      controller = KundekariStudioController(); // Default: Walnut at 45% RH
    });

    test('Initializes with Walnut wood preset and safe expansion', () {
      expect(controller.activeWood.id, equals('wood_walnut'));
      expect(controller.relativeHumidityPercent, equals(45.0));
      expect(controller.assemblyStage, equals(2));
      expect(controller.isJointLocked, isTrue);
      expect(controller.dimensionalExpansionMm, equals(0.0)); // At base 45% RH
      expect(controller.isExpansionSafe, isTrue);
    });

    test('Calculates positive expansion at high humidity and negative at low humidity', () {
      controller.setRelativeHumidity(85.0); // High humidity (delta +40%)
      expect(controller.dimensionalExpansionMm, greaterThan(0.0));
      expect(controller.isExpansionSafe, isTrue); // Within 1.4mm clearance

      controller.setRelativeHumidity(15.0); // Low humidity (delta -30%)
      expect(controller.dimensionalExpansionMm, lessThan(0.0));
    });

    test('Advances and clamps assembly stages', () {
      controller.setAssemblyStage(0);
      expect(controller.assemblyStage, equals(0));

      controller.setAssemblyStage(5); // Clamped to 2
      expect(controller.assemblyStage, equals(2));
    });

    test('Toggles joint locking peg and resets state', () {
      expect(controller.isJointLocked, isTrue);
      controller.toggleJointLock();
      expect(controller.isJointLocked, isFalse);

      controller.reset();
      expect(controller.activeWood.id, equals('wood_walnut'));
      expect(controller.isJointLocked, isTrue);
      expect(controller.relativeHumidityPercent, equals(45.0));
    });
  });
}
