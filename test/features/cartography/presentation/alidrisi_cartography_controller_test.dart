import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/cartography/presentation/controllers/alidrisi_cartography_controller.dart';

void main() {
  group('AlIdrisiCartographyController - Tabula Rogeriana Navigation Tests', () {
    late AlIdrisiCartographyController controller;

    setUp(() {
      controller = AlIdrisiCartographyController();
    });

    test('Initial state configures Palermo to Baghdad with classical South-Up orientation', () {
      final state = controller.state;
      expect(state.originCity, HistoricalGeoCity.palermo);
      expect(state.destinationCity, HistoricalGeoCity.baghdad);
      expect(state.isSouthOrientedUp, isTrue);
      expect(state.showClimaticZones, isTrue);
      expect(state.showGreatCirclePath, isTrue);
    });

    test('Haversine Great-Circle distance between Palermo and Baghdad is accurate', () {
      // Palermo (38.1157 N, 13.3615 E) to Baghdad (33.3152 N, 44.3661 E)
      // Geodesic distance ~ 2760 km
      final distKm = controller.state.greatCircleDistanceKm;
      expect(distKm, closeTo(2760.0, 50.0));

      // Arab Miles conversion (~ 1398 Arab miles)
      final miles = controller.state.distanceInArabMiles;
      expect(miles, closeTo(1400.0, 30.0));
    });

    test('Initial bearing calculation from Palermo to Baghdad', () {
      // Bearing should point East-South-East (~ 100° to 105°)
      final bearing = controller.state.initialBearingDeg;
      expect(bearing, closeTo(102.0, 5.0));
    });

    test('Swapping cities inverts origin and destination', () {
      controller.swapCities();
      expect(controller.state.originCity, HistoricalGeoCity.baghdad);
      expect(controller.state.destinationCity, HistoricalGeoCity.palermo);
    });

    test('Orientation toggle flips south-up flag', () {
      controller.toggleOrientation();
      expect(controller.state.isSouthOrientedUp, isFalse);

      controller.toggleOrientation();
      expect(controller.state.isSouthOrientedUp, isTrue);
    });

    test('Reset restores pristine state', () {
      controller.setOriginCity(HistoricalGeoCity.cordoba);
      controller.setDestinationCity(HistoricalGeoCity.mecca);
      controller.reset();

      expect(controller.state.originCity, HistoricalGeoCity.palermo);
      expect(controller.state.destinationCity, HistoricalGeoCity.baghdad);
    });
  });
}
