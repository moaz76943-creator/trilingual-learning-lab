import 'package:flutter/material.dart';

import '../controllers/verb_paradigm_controller.dart';
import '../models/verb_paradigm_models.dart';

class VerbParadigmStudioScreen extends StatefulWidget {
  const VerbParadigmStudioScreen({super.key, this.controller});

  final VerbParadigmController? controller;

  @override
  State<VerbParadigmStudioScreen> createState() =>
      _VerbParadigmStudioScreenState();
}

class _VerbParadigmStudioScreenState extends State<VerbParadigmStudioScreen>
    with SingleTickerProviderStateMixin {
  late final VerbParadigmController _controller;
  late final bool _ownsController;
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? VerbParadigmController();
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
            title: const Text('مُخْتَبَرُ تَصْرِيفِ الْأَفْعَالِ وَالْمِيزَانِ الصَّرْفِيِّ'),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(Icons.table_chart_outlined),
                  text: 'جَدَاوِلُ التَّصْرِيفِ وَالْأَوْزَانِ',
                ),
                Tab(
                  icon: Icon(Icons.quiz_outlined),
                  text: 'اخْتِبَارُ التَّصْرِيفِ',
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
    VerbParadigmState state,
  ) {
    final entries = state.filteredEntries;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: _controller.updateSearch,
            decoration: InputDecoration(
              hintText: 'ابْحَثْ عَنْ جَذْرٍ أَوْ فِعْلٍ (sprechen، bleiben، عَلِمَ)...',
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
              ...VerbMorphologyAxis.values.map((axis) {
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
                label: const Text('الشَّرْحُ الصَّرْفِيُّ'),
                selected: state.showMorphologyRules,
                onSelected: (_) => _controller.toggleMorphologyRules(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: entries.isEmpty
              ? const Center(
                  child: Text('لَا تُوجَدُ نَتَائِجُ مُطَابِقَةٌ لِلْبَحْثِ.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    return _VerbParadigmCard(
                      entry: entries[index],
                      showRules: state.showMorphologyRules,
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
    VerbParadigmState state,
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
                        'دِقَّةُ التَّصْرِيفِ: ${(state.accuracyRatio * 100).round()}%',
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

class _VerbParadigmCard extends StatelessWidget {
  const _VerbParadigmCard({
    required this.entry,
    required this.showRules,
  });

  final VerbParadigmEntry entry;
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
                      entry.titleAr,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Chip(label: Text(entry.paradigmTag)),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${entry.titleEn} • ${entry.titleDe}',
              style: theme.textTheme.bodySmall,
            ),
            const Divider(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                '${entry.arabicRootAndMeasure}\n${entry.arabicForms}',
                style: theme.textTheme.bodyLarge,
              ),
            ),
            if (showRules) ...[
              const SizedBox(height: 4),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  entry.morphologyRuleAr,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 10),
            Text('EN: ${entry.englishForms}', style: theme.textTheme.bodyMedium),
            if (showRules)
              Text(
                entry.morphologyRuleEn,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            const SizedBox(height: 10),
            Text(
              'DE: ${entry.germanForms}',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            if (showRules)
              Text(
                entry.morphologyRuleDe,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            const SizedBox(height: 10),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'تَنْبِيهٌ: ${entry.pitfallAlertAr}',
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
