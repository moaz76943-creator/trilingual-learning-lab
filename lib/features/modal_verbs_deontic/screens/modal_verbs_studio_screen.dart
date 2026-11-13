import 'package:flutter/material.dart';

import '../controllers/modal_verbs_controller.dart';
import '../models/modal_verbs_models.dart';

class ModalVerbsStudioScreen extends StatefulWidget {
  const ModalVerbsStudioScreen({super.key, this.controller});

  final ModalVerbsController? controller;

  @override
  State<ModalVerbsStudioScreen> createState() => _ModalVerbsStudioScreenState();
}

class _ModalVerbsStudioScreenState extends State<ModalVerbsStudioScreen>
    with SingleTickerProviderStateMixin {
  late final ModalVerbsController _controller;
  late final bool _ownsController;
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? ModalVerbsController();
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
            title: const Text('مُخْتَبَرُ أَفْعَالِ الْوُجُوبِ وَالِاحْتِمَالِ وَالْإِذْنِ'),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(Icons.balance_rounded),
                  text: 'التَّكْلِيفُ مُقَابِلَ الِاسْتِنْتَاجِ',
                ),
                Tab(
                  icon: Icon(Icons.task_alt_rounded),
                  text: 'اخْتِبَارُ الْأَفْعَالِ النَّاقِصَةِ',
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildExplorerTab(context, theme, state),
              _buildDrillTab(context, theme, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExplorerTab(
    BuildContext context,
    ThemeData theme,
    ModalVerbsState state,
  ) {
    final units = state.filteredUnits;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: _controller.updateSearch,
            decoration: InputDecoration(
              hintText: 'ابْحَثْ عَنْ dürfen، müssen، sollen، يَجُوزُ، must...',
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
                selected: state.selectedAxis == null,
                onSelected: (_) => _controller.selectAxis(null),
              ),
              const SizedBox(width: 8),
              ...ModalAxisCategory.values.map((axis) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(axis.titleAr),
                    selected: state.selectedAxis == axis,
                    onSelected: (_) => _controller.selectAxis(axis),
                  ),
                );
              }),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              FilterChip(
                label: const Text('الصِّيغَةُ الْمُقَابِلَةُ (Epistemic)'),
                selected: state.showContrastiveForm,
                onSelected: (_) => _controller.toggleContrastiveForm(),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('تَنْبِيهَاتُ الْخَلْطِ'),
                selected: state.showTrapAlerts,
                onSelected: (_) => _controller.toggleTrapAlerts(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: units.isEmpty
              ? const Center(
                  child: Text('لَا تُوجَدُ نَتَائِجُ مُطَابِقَةٌ.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: units.length,
                  itemBuilder: (context, index) {
                    return _ModalUnitCard(
                      unit: units[index],
                      showContrast: state.showContrastiveForm,
                      showTraps: state.showTrapAlerts,
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildDrillTab(
    BuildContext context,
    ThemeData theme,
    ModalVerbsState state,
  ) {
    final drill = state.currentDrill;
    if (drill == null) {
      return const Center(child: Text('لَا تُوجَدُ تَدْرِيبَاتٌ مُتَاحَةٌ.'));
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'مُؤَشِّرُ الْإِتْقَانِ: ${(state.masteryRatio * 100).round()}%',
                        style: theme.textTheme.titleMedium,
                      ),
                      Text('${state.correctCount} / ${state.answeredCount}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: state.masteryRatio),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(label: Text('${drill.targetLanguage} • ${drill.axis.titleEn}')),
                  const SizedBox(height: 12),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(drill.promptAr, style: theme.textTheme.titleMedium),
                  ),
                  const SizedBox(height: 6),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      '${drill.promptEn}\n${drill.promptDe}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(drill.options.length, (i) {
                    final selected = state.selectedOptionIndex;
                    final isSelected = selected == i;
                    final isCorrect = i == drill.correctIndex;
                    Color? tileColor;
                    if (selected != null) {
                      if (isCorrect) {
                        tileColor = Colors.green.withOpacity(0.16);
                      } else if (isSelected) {
                        tileColor = Colors.red.withOpacity(0.16);
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Material(
                        color: tileColor ??
                            theme.colorScheme.surfaceVariant.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                        child: ListTile(
                          title: Text(drill.options[i]),
                          trailing: selected == null
                              ? const Icon(Icons.radio_button_unchecked)
                              : Icon(
                                  isCorrect
                                      ? Icons.check_circle
                                      : (isSelected
                                          ? Icons.cancel
                                          : Icons.circle_outlined),
                                  color: isCorrect
                                      ? Colors.green
                                      : (isSelected ? Colors.red : null),
                                ),
                          onTap: () => _controller.submitAnswer(i),
                        ),
                      ),
                    );
                  }),
                  if (state.selectedOptionIndex != null) ...[
                    const Divider(),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(drill.explanationAr),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _controller.resetDrills,
                          child: const Text('إِعَادَةٌ'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton.icon(
                          onPressed: _controller.nextDrill,
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('التَّالِي'),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModalUnitCard extends StatelessWidget {
  const _ModalUnitCard({
    required this.unit,
    required this.showContrast,
    required this.showTraps,
  });

  final ModalContrastUnit unit;
  final bool showContrast;
  final bool showTraps;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      unit.titleAr,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Chip(label: Text(unit.modalTag)),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${unit.titleEn} • ${unit.titleDe}',
              style: theme.textTheme.bodySmall,
            ),
            const Divider(height: 20),
            _ModalLangBlock(
              lang: 'الْعَرَبِيَّةُ',
              primary: unit.deonticOrBaseAr,
              secondary: showContrast ? unit.epistemicOrContrastAr : null,
              rule: unit.ruleAr,
              rtl: true,
            ),
            const SizedBox(height: 12),
            _ModalLangBlock(
              lang: 'English',
              primary: unit.deonticOrBaseEn,
              secondary: showContrast ? unit.epistemicOrContrastEn : null,
              rule: unit.ruleEn,
              rtl: false,
            ),
            const SizedBox(height: 12),
            _ModalLangBlock(
              lang: 'Deutsch',
              primary: unit.deonticOrBaseDe,
              secondary: showContrast ? unit.epistemicOrContrastDe : null,
              rule: unit.ruleDe,
              rtl: false,
            ),
            if (showTraps) ...[
              const SizedBox(height: 10),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  'تَنْبِيهٌ: ${unit.trapAlertAr}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ModalLangBlock extends StatelessWidget {
  const _ModalLangBlock({
    required this.lang,
    required this.primary,
    required this.secondary,
    required this.rule,
    required this.rtl,
  });

  final String lang;
  final String primary;
  final String? secondary;
  final String rule;
  final bool rtl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            lang,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text('1) $primary', style: theme.textTheme.bodyLarge),
          if (secondary != null) ...[
            const SizedBox(height: 2),
            Text('2) $secondary', style: theme.textTheme.bodyMedium),
          ],
          const SizedBox(height: 3),
          Text(
            rule,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
