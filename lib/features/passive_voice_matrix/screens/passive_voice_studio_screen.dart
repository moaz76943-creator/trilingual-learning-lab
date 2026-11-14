import 'package:flutter/material.dart';

import '../controllers/passive_voice_controller.dart';
import '../models/passive_voice_models.dart';

class PassiveVoiceStudioScreen extends StatefulWidget {
  const PassiveVoiceStudioScreen({super.key, this.controller});

  final PassiveVoiceController? controller;

  @override
  State<PassiveVoiceStudioScreen> createState() =>
      _PassiveVoiceStudioScreenState();
}

class _PassiveVoiceStudioScreenState extends State<PassiveVoiceStudioScreen>
    with SingleTickerProviderStateMixin {
  late final PassiveVoiceController _controller;
  late final bool _ownsController;
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? PassiveVoiceController();
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
            title: const Text('مُخْتَبَرُ الْمَبْنِيِّ لِلْمَجْهُولِ وَوَسَائِطِ الْحَدَثِ'),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(Icons.swap_horiz_rounded),
                  text: 'الْمَعْلُومُ وَالْمَجْهُولُ وَالْبَدَائِلُ',
                ),
                Tab(
                  icon: Icon(Icons.quiz_outlined),
                  text: 'اخْتِبَارُ الْبِنَاءِ لِلْمَجْهُولِ',
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
    PassiveVoiceState state,
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
              hintText: 'ابْحَثْ عَنْ worden، Zustandspassiv، sich lassen، مَجْهُول...',
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
                selected: state.selectedType == null,
                onSelected: (_) => _controller.selectType(null),
              ),
              const SizedBox(width: 8),
              ...PassiveConstructionType.values.map((t) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(t.titleAr),
                    selected: state.selectedType == t,
                    onSelected: (_) => _controller.selectType(t),
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
              Expanded(
                child: SwitchListTile.adaptive(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    state.showPassiveTransformation
                        ? 'الْعَرْضُ: الْمَبْنِيُّ لِلْمَجْهُولِ (Passive)'
                        : 'الْعَرْضُ: الْمَبْنِيُّ لِلْمَعْلُومِ (Active)',
                  ),
                  value: state.showPassiveTransformation,
                  onChanged: (_) => _controller.togglePassiveMode(),
                ),
              ),
              FilterChip(
                label: const Text('الْقَوَاعِدُ'),
                selected: state.showRules,
                onSelected: (_) => _controller.toggleRules(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: units.isEmpty
              ? const Center(
                  child: Text('لَا تُوجَدُ نَتَائِجُ مُطَابِقَةٌ لِلْبَحْثِ.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: units.length,
                  itemBuilder: (context, index) {
                    return _PassiveCard(
                      unit: units[index],
                      showPassive: state.showPassiveTransformation,
                      showRules: state.showRules,
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
    PassiveVoiceState state,
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
                        'دِقَّةُ التَّحْوِيلِ: ${(state.accuracyRatio * 100).round()}%',
                        style: theme.textTheme.titleMedium,
                      ),
                      Text('${state.correctCount} / ${state.answeredCount}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: state.accuracyRatio),
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
                  Chip(label: Text('${drill.targetLanguage} • ${drill.type.titleEn}')),
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

class _PassiveCard extends StatelessWidget {
  const _PassiveCard({
    required this.unit,
    required this.showPassive,
    required this.showRules,
  });

  final PassiveComparisonUnit unit;
  final bool showPassive;
  final bool showRules;

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
                Chip(label: Text(unit.auxiliaryTag)),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${unit.titleEn} • ${unit.titleDe}',
              style: theme.textTheme.bodySmall,
            ),
            const Divider(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                showPassive ? unit.passiveFormAr : unit.activeOrBaseAr,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            if (showRules)
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  unit.ruleAr,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            const SizedBox(height: 10),
            Text(
              'EN: ${showPassive ? unit.passiveFormEn : unit.activeOrBaseEn}',
              style: theme.textTheme.bodyMedium,
            ),
            if (showRules)
              Text(
                unit.ruleEn,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            const SizedBox(height: 10),
            Text(
              'DE: ${showPassive ? unit.passiveFormDe : unit.activeOrBaseDe}',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            if (showRules)
              Text(
                unit.ruleDe,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            const SizedBox(height: 10),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'تَنْبِيهٌ: ${unit.pitfallAlertAr}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
