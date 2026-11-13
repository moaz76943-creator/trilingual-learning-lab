import 'package:flutter/material.dart';

import '../controllers/reported_speech_controller.dart';
import '../models/reported_speech_models.dart';

class ReportedSpeechStudioScreen extends StatefulWidget {
  const ReportedSpeechStudioScreen({super.key, this.controller});

  final ReportedSpeechController? controller;

  @override
  State<ReportedSpeechStudioScreen> createState() =>
      _ReportedSpeechStudioScreenState();
}

class _ReportedSpeechStudioScreenState extends State<ReportedSpeechStudioScreen>
    with SingleTickerProviderStateMixin {
  late final ReportedSpeechController _controller;
  late final bool _ownsController;
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? ReportedSpeechController();
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
            title: const Text('مُخْتَبَرُ الْكَلَامِ الْمَنْقُولِ وَالْإِحَالَةِ'),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(Icons.compare_arrows_rounded),
                  text: 'الْمُقَارَنَةُ التَّرْكِيبِيَّةُ',
                ),
                Tab(
                  icon: Icon(Icons.quiz_outlined),
                  text: 'التَّدْرِيبُ التَّشْخِيصِيُّ',
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
    ReportedSpeechState state,
  ) {
    final scenarios = state.filteredScenarios;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: _controller.updateSearchQuery,
            decoration: InputDecoration(
              hintText: 'ابْحَثْ بِالْعَرَبِيَّةِ أَوِ الْإِنْجِلِيزِيَّةِ أَوِ الْأَلْمَانِيَّةِ...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: state.searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _controller.updateSearchQuery('');
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
                selected: state.selectedCategory == null,
                onSelected: (_) => _controller.selectCategory(null),
              ),
              const SizedBox(width: 8),
              ...ReportedSpeechCategory.values.map((cat) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat.titleAr),
                    selected: state.selectedCategory == cat,
                    onSelected: (_) => _controller.selectCategory(cat),
                  ),
                );
              }),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            children: [
              Expanded(
                child: SwitchListTile.adaptive(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    state.showIndirectMode
                        ? 'الْعَرْضُ: الْخِطَابُ غَيْرُ الْمُبَاشِرِ'
                        : 'الْعَرْضُ: الْخِطَابُ الْمُبَاشِرُ',
                  ),
                  value: state.showIndirectMode,
                  onChanged: (_) => _controller.toggleSpeechMode(),
                ),
              ),
              const SizedBox(width: 8),
              FilterChip(
                avatar: const Icon(Icons.highlight_alt, size: 18),
                label: const Text('تَحَوُّلَاتُ الْإِحَالَةِ'),
                selected: state.highlightDeictics,
                onSelected: (_) => _controller.toggleDeicticHighlights(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: scenarios.isEmpty
              ? const Center(
                  child: Text('لَا تُوجَدُ نَتَائِجُ مُطَابِقَةٌ لِلْبَحْثِ الْحَالِيِّ.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: scenarios.length,
                  itemBuilder: (context, index) {
                    return _ScenarioCard(
                      scenario: scenarios[index],
                      showIndirect: state.showIndirectMode,
                      showDeictics: state.highlightDeictics,
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
    ReportedSpeechState state,
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
                      Text(
                        '${state.correctAnswers} / ${state.answeredCount}',
                        style: theme.textTheme.labelLarge,
                      ),
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
                  Chip(label: Text('${drill.targetLanguage} • ${drill.category.titleEn}')),
                  const SizedBox(height: 12),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      drill.promptAr,
                      style: theme.textTheme.titleMedium,
                    ),
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
                        tileColor = Colors.green.withOpacity(0.15);
                      } else if (isSelected) {
                        tileColor = Colors.red.withOpacity(0.15);
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Material(
                        color: tileColor ?? theme.colorScheme.surfaceVariant.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                        child: ListTile(
                          title: Text(drill.options[i]),
                          trailing: selected == null
                              ? const Icon(Icons.radio_button_unchecked)
                              : Icon(
                                  isCorrect
                                      ? Icons.check_circle
                                      : (isSelected ? Icons.cancel : Icons.circle_outlined),
                                  color: isCorrect
                                      ? Colors.green
                                      : (isSelected ? Colors.red : null),
                                ),
                          onTap: () => _controller.submitDrillAnswer(i),
                        ),
                      ),
                    );
                  }),
                  if (state.selectedOptionIndex != null) ...[
                    const Divider(),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        drill.explanationAr,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _controller.resetDrills,
                          child: const Text('إِعَادَةُ التَّدْرِيبِ'),
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

class _ScenarioCard extends StatelessWidget {
  const _ScenarioCard({
    required this.scenario,
    required this.showIndirect,
    required this.showDeictics,
  });

  final ReportedSpeechScenario scenario;
  final bool showIndirect;
  final bool showDeictics;

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
                      scenario.titleAr,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Chip(label: Text(scenario.registerTag)),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${scenario.titleEn} • ${scenario.titleDe}',
              style: theme.textTheme.bodySmall,
            ),
            const Divider(height: 20),
            _LanguageBlock(
              label: 'الْعَرَبِيَّةُ',
              text: showIndirect ? scenario.indirectAr : scenario.directAr,
              rule: scenario.grammarRuleAr,
              isRtl: true,
            ),
            const SizedBox(height: 12),
            _LanguageBlock(
              label: 'English',
              text: showIndirect ? scenario.indirectEn : scenario.directEn,
              rule: scenario.grammarRuleEn,
              isRtl: false,
            ),
            const SizedBox(height: 12),
            _LanguageBlock(
              label: 'Deutsch',
              text: showIndirect ? scenario.indirectDe : scenario.directDe,
              rule: scenario.grammarRuleDe,
              isRtl: false,
            ),
            if (showDeictics && scenario.deicticPairs.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'خَرِيطَةُ التَّحَوُّلَاتِ (Direct → Indirect):',
                      style: theme.textTheme.labelLarge,
                    ),
                    const SizedBox(height: 6),
                    ...scenario.deicticPairs.map(
                      (pair) => Text(
                        'AR: ${pair.directAr} → ${pair.indirectAr}\n'
                        'EN: ${pair.directEn} → ${pair.indirectEn}\n'
                        'DE: ${pair.directDe} → ${pair.indirectDe}',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 10),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'تَنْبِيهٌ نَحْوِيٌّ: ${scenario.pitfallNoteAr}',
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

class _LanguageBlock extends StatelessWidget {
  const _LanguageBlock({
    required this.label,
    required this.text,
    required this.rule,
    required this.isRtl,
  });

  final String label;
  final String text;
  final String rule;
  final bool isRtl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(text, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 2),
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
