import 'package:flutter/material.dart';

import '../controllers/system_diagnostics_controller.dart';
import '../models/diagnostic_models.dart';

class TrilingualMasterHubScreen extends StatefulWidget {
  const TrilingualMasterHubScreen({super.key, this.controller});

  final SystemDiagnosticsController? controller;

  @override
  State<TrilingualMasterHubScreen> createState() =>
      _TrilingualMasterHubScreenState();
}

class _TrilingualMasterHubScreenState extends State<TrilingualMasterHubScreen>
    with SingleTickerProviderStateMixin {
  late final SystemDiagnosticsController _controller;
  late final bool _ownsController;
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? SystemDiagnosticsController();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final state = _controller.state;
        return Scaffold(
          appBar: AppBar(
            title: const Text('الْبَوَّابَةُ الْمُوَحَّدَةُ وَفَحْصُ سَلَامَةِ الْمُخْتَبَرِ'),
            actions: [
              IconButton(
                tooltip: 'إِعَادَةُ الْفَحْصِ الذَّاتِيِّ',
                icon: const Icon(Icons.verified_rounded),
                onPressed: _controller.runFullDiagnosticAudit,
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(Icons.dashboard_customize_outlined),
                  text: 'مُخْتَبَرَاتُ اللُّغَاتِ الثَّلَاثِ',
                ),
                Tab(
                  icon: Icon(Icons.health_and_safety_outlined),
                  text: 'تَقْرِيرُ السَّلَامَةِ الْبَرْمَجِيَّةِ',
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildStudiosCatalog(context, theme, state),
              _buildDiagnosticsReport(context, theme, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStudiosCatalog(
    BuildContext context,
    ThemeData theme,
    SystemDiagnosticsState state,
  ) {
    final studios = state.filteredStudios;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: _controller.updateSearch,
            decoration: InputDecoration(
              hintText: 'ابْحَثْ فِي الْمُخْتَبَرَاتِ بِالِاسْمِ أَوْ رَقْمِ الْمُهِمَّةِ...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: state.searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _controller.updateSearch('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              FilterChip(
                label: const Text('الْكُلُّ'),
                selected: state.selectedGroup == null,
                onSelected: (_) => _controller.selectGroup(null),
              ),
              const SizedBox(width: 8),
              ...StudioDomainGroup.values.map((g) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(g.titleAr),
                    selected: state.selectedGroup == g,
                    onSelected: (_) => _controller.selectGroup(g),
                  ),
                );
              }),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: studios.isEmpty
              ? const Center(
                  child: Text('لَا تُوجَدُ مُخْتَبَرَاتٌ مُطَابِقَةٌ لِلْبَحْثِ.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: studios.length,
                  itemBuilder: (context, index) {
                    final studio = studios[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(studio.icon),
                        ),
                        title: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            studio.titleAr,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text('${studio.titleEn} • ${studio.titleDe}'),
                            const SizedBox(height: 4),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(studio.summaryAr),
                            ),
                          ],
                        ),
                        trailing: Chip(label: Text('#${studio.taskNumber}')),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: studio.builder,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildDiagnosticsReport(
    BuildContext context,
    ThemeData theme,
    SystemDiagnosticsState state,
  ) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      state.lastAuditPassed
                          ? Icons.check_circle_rounded
                          : Icons.warning_amber_rounded,
                      color: state.lastAuditPassed ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          state.lastAuditPassed
                              ? 'حَالَةُ النِّظَامِ: جَمِيعُ الْمُخْتَبَرَاتِ سَلِيمَةٌ وَمُتَكَامِلَةٌ'
                              : 'حَالَةُ النِّظَامِ: يُوجَدُ تَنْبِيهٌ فِي بَعْضِ الْوَحَدَاتِ',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    'إِجْمَالِيُّ الدُّرُوسِ الْمَفْحُوصَةِ: ${state.totalVerifiedLessons} • إِجْمَالِيُّ التَّدْرِيبَاتِ التَّفَاعُلِيَّةِ: ${state.totalVerifiedDrills}',
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...state.healthReports.map((report) {
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: Icon(
                report.isHealthy ? Icons.verified_user : Icons.error_outline,
                color: report.isHealthy ? Colors.green : Colors.red,
              ),
              title: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(report.titleAr),
              ),
              subtitle: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(report.diagnosticNoteAr),
              ),
            ),
          );
        }),
      ],
    );
  }
}
