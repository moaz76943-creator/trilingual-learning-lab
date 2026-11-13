import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/system_diagnostics/controllers/system_diagnostics_controller.dart';
import 'package:trilingual_learning_lab/features/system_diagnostics/models/diagnostic_models.dart';
import 'package:trilingual_learning_lab/features/system_diagnostics/screens/trilingual_master_hub_screen.dart';
import 'package:trilingual_learning_lab/features/system_diagnostics/services/trilingual_registry_service.dart';

void main() {
  group('TrilingualRegistryService & Self-Healing Audit', () {
    const service = TrilingualRegistryService();

    test('registers all 8 core studios (#1220-#1227) and passes health checks', () {
      final studios = service.getRegisteredStudios();
      expect(studios.length, 8);

      final reports = service.runSelfDiagnostics();
      expect(reports.length, 8);
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
    test('filters registered studios by domain group and search query', () {
      final controller = SystemDiagnosticsController();
      expect(controller.state.lastAuditPassed, isTrue);
      expect(controller.state.filteredStudios.length, 8);
      expect(controller.state.totalVerifiedLessons, 48);
      expect(controller.state.totalVerifiedDrills, 48);

      controller.selectGroup(StudioDomainGroup.morphologyAndPhonology);
      expect(controller.state.filteredStudios.length, 2);

      controller.selectGroup(null);
      controller.updateSearch('1227');
      expect(controller.state.filteredStudios.length, 1);
      expect(controller.state.filteredStudios.first.id, 'modal_verbs_deontic');
    });
  });

  group('TrilingualMasterHubScreen', () {
    testWidgets('renders hub, navigates to a studio, and displays health tab',
        (WidgetTester tester) async {
      final controller = SystemDiagnosticsController();
      await tester.pumpWidget(
        MaterialApp(
          home: TrilingualMasterHubScreen(controller: controller),
        ),
      );

      expect(
        find.text('الْبَوَّابَةُ الْمُوَحَّدَةُ وَفَحْصُ سَلَامَةِ الْمُخْتَبَرِ'),
        findsOneWidget,
      );
      expect(find.text('#1220'), findsOneWidget);

      await tester.tap(find.text('تَقْرِيرُ السَّلَامَةِ الْبَرْمَجِيَّةِ'));
      await tester.pumpAndSettle();

      expect(
        find.textContaining('حَالَةُ النِّظَامِ: جَمِيعُ الْمُخْتَبَرَاتِ سَلِيمَةٌ'),
        findsOneWidget,
      );
    });
  });
}
