import 'package:flutter/material.dart';

import '../controllers/discourse_connectives_controller.dart';
import '../models/discourse_connectives_models.dart';

class DiscourseConnectivesStudioScreen extends StatefulWidget {
  const DiscourseConnectivesStudioScreen({super.key, this.controller});

  final DiscourseConnectivesController? controller;

  @override
  State<DiscourseConnectivesStudioScreen> createState() =>
      _DiscourseConnectivesStudioScreenState();
}

class _DiscourseConnectivesStudioScreenState
    extends State<DiscourseConnectivesStudioScreen>
    with SingleTickerProviderStateMixin {
  late final DiscourseConnectivesController _controller;
  late final bool _ownsController;
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? DiscourseConnectivesController();
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
            title: const Text('مُخْتَبَرُ الرَّوَابِطِ النَّصِّيَّةِ وَتَمَاسُكِ الْفَقْرَةِ'),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(Icons.link_rounded),
                  text: 'الرَّوَابِطُ وَرُتْبَةُ الْفِعْلِ',
                ),
                Tab(
                  icon: Icon(Icons.assignment_turned_in_outlined),
                  text: 'اخْتِبَارُ الرَّبْطِ وَالتَّرْقِيمِ',
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
    DiscourseConnectivesState state,
  ) {
    final triplets = state.filteredTriplets;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: _controller.updateSearch,
            decoration: InputDecoration(
              hintText: 'ابْحَثْ عَنْ رَابِطٍ (weil، obwohl، deshalb، لِأَنَّ، therefore)...',
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
                selected: state.selectedRelation == null,
                onSelected: (_) => _controller.selectRelation(null),
              ),
              const SizedBox(width: 8),
              ...DiscourseRelationType.values.map((rel) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(rel.titleAr),
                    selected: state.selectedRelation == rel,
                    onSelected: (_) => _controller.selectRelation(rel),
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
                label: const Text('الْبَدِيلُ الظَّرْفِيُّ / الْجَرُّ'),
                selected: state.showAdverbialAndPrepVariant,
                onSelected: (_) => _controller.toggleAdverbialVariant(),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('قَوَاعِدُ الرُّتْبَةِ'),
                selected: state.showWordOrderRules,
                onSelected: (_) => _controller.toggleWordOrderRules(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: triplets.isEmpty
              ? const Center(
                  child: Text('لَا تُوجَدُ رَوَابِطُ مُطَابِقَةٌ لِلْبَحْثِ.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: triplets.length,
                  itemBuilder: (context, index) {
                    return _ConnectiveCard(
                      triplet: triplets[index],
                      showVariant: state.showAdverbialAndPrepVariant,
                      showRules: state.showWordOrderRules,
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
    DiscourseConnectivesState state,
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
                  Chip(label: Text('${drill.targetLanguage} • ${drill.relation.titleEn}')),
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

class _ConnectiveCard extends StatelessWidget {
  const _ConnectiveCard({
    required this.triplet,
    required this.showVariant,
    required this.showRules,
  });

  final ConnectiveSyntaxTriplet triplet;
  final bool showVariant;
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
                      triplet.titleAr,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Chip(label: Text(triplet.germanPositionTag)),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${triplet.titleEn} • ${triplet.titleDe}',
              style: theme.textTheme.bodySmall,
            ),
            const Divider(height: 20),
            _ConnectiveLangBlock(
              lang: 'الْعَرَبِيَّةُ',
              primary: triplet.subordinatingAr,
              secondary: showVariant ? triplet.adverbialOrPrepAr : null,
              rule: showRules ? triplet.wordOrderRuleAr : null,
              rtl: true,
            ),
            const SizedBox(height: 12),
            _ConnectiveLangBlock(
              lang: 'English',
              primary: triplet.subordinatingEn,
              secondary: showVariant ? triplet.adverbialOrPrepEn : null,
              rule: showRules ? triplet.wordOrderRuleEn : null,
              rtl: false,
            ),
            const SizedBox(height: 12),
            _ConnectiveLangBlock(
              lang: 'Deutsch',
              primary: triplet.subordinatingDe,
              secondary: showVariant ? triplet.adverbialOrPrepDe : null,
              rule: showRules ? triplet.wordOrderRuleDe : null,
              rtl: false,
            ),
            const SizedBox(height: 10),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'تَنْبِيهٌ: ${triplet.pitfallAlertAr}',
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

class _ConnectiveLangBlock extends StatelessWidget {
  const _ConnectiveLangBlock({
    required this.lang,
    required this.primary,
    required this.secondary,
    required this.rule,
    required this.rtl,
  });

  final String lang;
  final String primary;
  final String? secondary;
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
          Text(primary, style: theme.textTheme.bodyLarge),
          if (secondary != null) ...[
            const SizedBox(height: 2),
            Text(secondary!, style: theme.textTheme.bodyMedium),
          ],
          if (rule != null) ...[
            const SizedBox(height: 3),
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
