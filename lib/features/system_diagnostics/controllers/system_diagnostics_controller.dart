import 'package:flutter/foundation.dart';

import '../models/diagnostic_models.dart';
import '../services/trilingual_registry_service.dart';

@immutable
class SystemDiagnosticsState {
  const SystemDiagnosticsState({
    required this.studios,
    required this.healthReports,
    this.selectedGroup,
    this.searchQuery = '',
    this.lastAuditPassed = true,
  });

  final List<TrilingualStudioDescriptor> studios;
  final List<ModuleHealthReport> healthReports;
  final StudioDomainGroup? selectedGroup;
  final String searchQuery;
  final bool lastAuditPassed;

  List<TrilingualStudioDescriptor> get filteredStudios {
    final q = searchQuery.trim().toLowerCase();
    return studios.where((s) {
      final matchesGroup = selectedGroup == null || s.group == selectedGroup;
      if (!matchesGroup) return false;
      if (q.isEmpty) return true;
      return s.titleAr.toLowerCase().contains(q) ||
          s.titleEn.toLowerCase().contains(q) ||
          s.titleDe.toLowerCase().contains(q) ||
          s.summaryAr.toLowerCase().contains(q) ||
          s.taskNumber.toString().contains(q);
    }).toList(growable: false);
  }

  int get totalVerifiedLessons =>
      healthReports.fold(0, (sum, r) => sum + r.verifiedItemsCount);

  int get totalVerifiedDrills =>
      healthReports.fold(0, (sum, r) => sum + r.verifiedDrillsCount);

  SystemDiagnosticsState copyWith({
    List<TrilingualStudioDescriptor>? studios,
    List<ModuleHealthReport>? healthReports,
    StudioDomainGroup? selectedGroup,
    bool clearGroup = false,
    String? searchQuery,
    bool? lastAuditPassed,
  }) {
    return SystemDiagnosticsState(
      studios: studios ?? this.studios,
      healthReports: healthReports ?? this.healthReports,
      selectedGroup: clearGroup ? null : (selectedGroup ?? this.selectedGroup),
      searchQuery: searchQuery ?? this.searchQuery,
      lastAuditPassed: lastAuditPassed ?? this.lastAuditPassed,
    );
  }
}

class SystemDiagnosticsController extends ChangeNotifier {
  SystemDiagnosticsController({TrilingualRegistryService? service})
      : _service = service ?? const TrilingualRegistryService() {
    runFullDiagnosticAudit();
  }

  final TrilingualRegistryService _service;
  late SystemDiagnosticsState _state;

  SystemDiagnosticsState get state => _state;

  void runFullDiagnosticAudit() {
    final studios = _service.getRegisteredStudios();
    final reports = _service.runSelfDiagnostics();
    final allHealthy = reports.every((r) => r.isHealthy);
    _state = SystemDiagnosticsState(
      studios: studios,
      healthReports: reports,
      lastAuditPassed: allHealthy,
    );
    notifyListeners();
  }

  void selectGroup(StudioDomainGroup? group) {
    if (group == null) {
      _state = _state.copyWith(clearGroup: true);
    } else {
      _state = _state.copyWith(selectedGroup: group);
    }
    notifyListeners();
  }

  void updateSearch(String query) {
    _state = _state.copyWith(searchQuery: query);
    notifyListeners();
  }
}
