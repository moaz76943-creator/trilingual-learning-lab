import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/system_diagnostics/controllers/system_diagnostics_controller.dart';
import 'package:trilingual_learning_lab/features/system_diagnostics/models/diagnostic_models.dart';
import 'package:trilingual_learning_lab/features/system_diagnostics/screens/trilingual_master_hub_screen.dart';
import 'package:trilingual_learning_lab/features/system_diagnostics/services/trilingual_registry_service.dart';
import 'package:trilingual_learning_lab/main.dart';

void main() {
  group('TrilingualRegistryService & Complete 20-Studio Audit', () {
    const service = TrilingualRegistryService();

    test('registers all 20 studios (#1220-#1241) and verifies health', () {
      final studios = service.getRegisteredStudios();
      expect(studios.length, 20);

      final reports = service.runSelfDiagnostics();
      expect(reports.length, 20);
      for (final report in reports) {
        expect(
          report.isHealthy,
          isTrue,
          reason: 'Module ${report.moduleId} failed health verification',
        );
        expect(report.verifiedItemsCount, greaterThanOrEqualTo(6));
        expect(report.verifiedDrillsCount, greaterThanOrEqualTo(6));
      }
    });
  });

  group('SystemDiagnosticsController', () {
    test('computes totals across all 20 studios and filters by group/query', () {
      final controller = SystemDiagnosticsController();
      expect(controller.state.lastAuditPassed, isTrue);
      expect(controller.state.filteredStudios.length, 20);
      expect(controller.state.totalVerifiedLessons, greaterThanOrEqualTo(120));
      expect(controller.state.totalVerifiedDrills, greaterThanOrEqualTo(120));

      controller.selectGroup(StudioDomainGroup.morphologyAndPhonology);
      expect(controller.state.filteredStudios.length, 4);

      controller.selectGroup(null);
      controller.updateSearch('1241');
      expect(controller.state.filteredStudios.length, 1);
      expect(
        controller.state.filteredStudios.first.id,
        'imperative_requests',
      );
    });
  });

  group('TrilingualLearningLabApp & Master Hub Smoke Test', () {
    testWidgets('boots full app and navigates between catalog and health tabs',
        (WidgetTester tester) async {
      await tester.pumpWidget(const TrilingualLearningLabApp());

      expect(
        find.text('الْبَوَّابَةُ الْمُوَحَّدَةُ وَفَحْصُ سَلَامَةِ الْمُخْتَبَرِ'),
        findsOneWidget,
      );

      await tester.tap(find.text('تَقْرِيرُ السَّلَامَةِ الْبَرْمَجِيَّةِ'));
      await tester.pumpAndSettle();

      expect(
        find.textContaining('حَالَةُ النِّظَامِ: جَمِيعُ الْمُخْتَبَرَاتِ سَلِيمَةٌ'),
        findsOneWidget,
      );
    });
  });
}
