import 'package:flutter/material.dart';

import '../controllers/prepositional_government_controller.dart';
import '../models/prepositional_government_models.dart';

class PrepositionalGovernmentStudioScreen extends StatefulWidget {
  const PrepositionalGovernmentStudioScreen({super.key, this.controller});

  final PrepositionalGovernmentController? controller;

  @override
  State<PrepositionalGovernmentStudioScreen> createState() =>
      _PrepositionalGovernmentStudioScreenState();
}

class _PrepositionalGovernmentStudioScreenState
    extends State<PrepositionalGovernmentStudioScreen>
    with SingleTickerProviderStateMixin {
  late final PrepositionalGovernmentController _controller;
  late final bool _ownsController;
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? PrepositionalGovernmentController();
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
            title: const Text('مُخْتَبَرُ حُرُوفِ الْجَرِّ وَالتَّعَدِّي اللُّغَوِيِّ'),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(Icons.alt_route_rounded),
                  text: 'مُقَارَنَةُ التَّلَازُمِ وَالْحَالَاتِ',
                ),
                Tab(
                  icon: Icon(Icons.check_circle_outline),
                  text: 'اخْتِبَارُ الْإِعْرَابِ وَالْحَرْفِ',
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
    PrepositionalGovernmentState state,
  ) {
    final pairs = state.filteredPairs;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: _controller.updateSearch,
            decoration: InputDecoration(
              hintText: 'ابْحَثْ عَنْ حَرْفٍ أَوْ قَاعِدَةٍ (Dativ، رَغِبَ، seit، auf)...',
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
                selected: state.selectedDomain == null,
                onSelected: (_) => _controller.selectDomain(null),
              ),
              const SizedBox(width: 8),
              ...PrepositionDomain.values.map((domain) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(domain.titleAr),
                    selected: state.selectedDomain == domain,
                    onSelected: (_) => _controller.selectDomain(domain),
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
                label: const Text('إِظْهَارُ النَّمَطِ الْمُقَابِلِ (B)'),
                selected: state.showContrastPatternB,
                onSelected: (_) => _controller.toggleContrastPatternB(),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('تَحْلِيلُ الْإِعْرَابِ'),
                selected: state.showValencyRules,
                onSelected: (_) => _controller.toggleValencyRules(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: pairs.isEmpty
              ? const Center(
                  child: Text('لَا تُوجَدُ نَتَائِجُ مُطَابِقَةٌ لِلْبَحْثِ.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: pairs.length,
                  itemBuilder: (context, index) {
                    return _ContrastCard(
                      pair: pairs[index],
                      showPatternB: state.showContrastPatternB,
                      showRules: state.showValencyRules,
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
    PrepositionalGovernmentState state,
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
                        'مُؤَشِّرُ الدِّقَّةِ: ${(state.accuracyRatio * 100).round()}%',
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
                  Chip(label: Text('${drill.targetLanguage} • ${drill.domain.titleEn}')),
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
                    Color? bg;
                    if (selected != null) {
                      if (isCorrect) {
                        bg = Colors.green.withOpacity(0.16);
                      } else if (isSelected) {
                        bg = Colors.red.withOpacity(0.16);
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Material(
                        color: bg ??
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

class _ContrastCard extends StatelessWidget {
  const _ContrastCard({
    required this.pair,
    required this.showPatternB,
    required this.showRules,
  });

  final PrepositionalContrastPair pair;
  final bool showPatternB;
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
                      pair.titleAr,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Chip(label: Text(pair.germanCaseTag)),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${pair.titleEn} • ${pair.titleDe}',
              style: theme.textTheme.bodySmall,
            ),
            const Divider(height: 20),
            _LanguageContrastBlock(
              lang: 'الْعَرَبِيَّةُ',
              patternA: pair.patternAAr,
              patternB: showPatternB ? pair.patternBAr : null,
              rule: showRules ? pair.caseOrValencyRuleAr : null,
              rtl: true,
            ),
            const SizedBox(height: 12),
            _LanguageContrastBlock(
              lang: 'English',
              patternA: pair.patternAEn,
              patternB: showPatternB ? pair.patternBEn : null,
              rule: showRules ? pair.caseOrValencyRuleEn : null,
              rtl: false,
            ),
            const SizedBox(height: 12),
            _LanguageContrastBlock(
              lang: 'Deutsch',
              patternA: pair.patternADe,
              patternB: showPatternB ? pair.patternBDe : null,
              rule: showRules ? pair.caseOrValencyRuleDe : null,
              rtl: false,
            ),
            const SizedBox(height: 10),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'تَنْبِيهٌ: ${pair.pitfallAlertAr}',
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

class _LanguageContrastBlock extends StatelessWidget {
  const _LanguageContrastBlock({
    required this.lang,
    required this.patternA,
    required this.patternB,
    required this.rule,
    required this.rtl,
  });

  final String lang;
  final String patternA;
  final String? patternB;
  final String? rule;
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
          Text('A: $patternA', style: theme.textTheme.bodyLarge),
          if (patternB != null) ...[
            const SizedBox(height: 2),
            Text('B: $patternB', style: theme.textTheme.bodyLarge),
          ],
          if (rule != null) ...[
            const SizedBox(height: 4),
            Text(
              rule!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
