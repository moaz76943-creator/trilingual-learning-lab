import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/metrology/presentation/controllers/alkhazini_balance_controller.dart';

void main() {
  group('AlKhaziniBalanceController - Hydrostatic Balance Unit Tests', () {
    late AlKhaziniBalanceController controller;

    setUp(() {
      controller = AlKhaziniBalanceController();
    });

    test('Initial state configures Alloy Fraud Detection (70% Gold / 30% Silver)', () {
      final state = controller.state;
      expect(state.mode, BalanceMode.alloyFraudDetection);
      expect(state.massInAirGrams, 100.0);
      expect(state.goldPercentageInAlloy, 70.0);
      expect(state.isImmersedInWater, isTrue);
    });

    test('Pure Gold specific gravity matches Al-Khazini 1121 CE value (19.05 g/cm³)', () {
      controller.setMode(BalanceMode.specificGravityMeasurement);
      controller.setMaterial(MetrologyMaterial.pureGold);
      controller.setMassInAir(100.0);

      // Volume = 100 / 19.05 ~ 5.249 cm³
      // Buoyant loss = 5.249 g
      // W_water = 100 - 5.249 = 94.75 g
      // SG = 100 / 5.249 ~ 19.05
      final sg = controller.state.calculatedSpecificGravity;
      expect(sg, closeTo(19.05, 0.05));
    });

    test('Pure Silver specific gravity matches Al-Khazini 1121 CE value (10.30 g/cm³)', () {
      controller.setMode(BalanceMode.specificGravityMeasurement);
      controller.setMaterial(MetrologyMaterial.pureSilver);
      controller.setMassInAir(100.0);

      final sg = controller.state.calculatedSpecificGravity;
      expect(sg, closeTo(10.30, 0.05));
    });

    test('Crown adulteration mystery correctly solves gold and silver mass components', () {
      // 200g alloy with 65% gold = 130g gold and 70g silver
      controller.loadCrownAdulterationMystery();

      final goldGrams = controller.state.calculatedGoldMassGrams;
      final silverGrams = controller.state.calculatedSilverMassGrams;

      expect(goldGrams, closeTo(130.0, 1.0));
      expect(silverGrams, closeTo(70.0, 1.0));
      expect(goldGrams + silverGrams, closeTo(200.0, 0.1));
    });

    test('Toggling water immersion updates apparent weight', () {
      controller.setMode(BalanceMode.specificGravityMeasurement);
      controller.setMaterial(MetrologyMaterial.copper);
      controller.setMassInAir(100.0);

      // In air, mass in water is set to massInAir
      controller.toggleWaterImmersion(); // now false
      expect(controller.state.massInWaterGrams, 100.0);

      controller.toggleWaterImmersion(); // now true (immersed)
      expect(controller.state.massInWaterGrams, lessThan(100.0));
    });

    test('Reset restores pristine state', () {
      controller.setMassInAir(350.0);
      controller.setGoldPercentage(40.0);
      controller.reset();

      expect(controller.state.massInAirGrams, 100.0);
      expect(controller.state.goldPercentageInAlloy, 70.0);
    });
  });
}
