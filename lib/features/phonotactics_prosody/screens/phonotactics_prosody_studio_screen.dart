import 'package:flutter/material.dart';

import '../controllers/phonotactics_prosody_controller.dart';
import '../models/phonotactics_prosody_models.dart';

class PhonotacticsProsodyStudioScreen extends StatefulWidget {
  const PhonotacticsProsodyStudioScreen({super.key, this.controller});

  final PhonotacticsProsodyController? controller;

  @override
  State<PhonotacticsProsodyStudioScreen> createState() =>
      _PhonotacticsProsodyStudioScreenState();
}

class _PhonotacticsProsodyStudioScreenState
    extends State<PhonotacticsProsodyStudioScreen>
    with SingleTickerProviderStateMixin {
  late final PhonotacticsProsodyController _controller;
  late final bool _ownsController;
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? PhonotacticsProsodyController();
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
            title: const Text('مُخْتَبَرُ الصَّوْتِيَّاتِ وَالْإِدْغَامِ وَالنَّبْرِ'),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(Icons.graphic_eq_rounded),
                  text: 'الْأَصْوَاتُ وَالْإِمْلَاءُ (IPA)',
                ),
                Tab(
                  icon: Icon(Icons.hearing_outlined),
                  text: 'التَّدْرِيبُ الصَّوْتِيُّ',
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
    PhonotacticsProsodyState state,
  ) {
    final lessons = state.filteredLessons;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: _controller.updateSearchQuery,
            decoration: InputDecoration(
              hintText: 'ابْحَثْ عَنِ النَّبْرِ، Ich-Laut، Auslautverhärtung، إِدْغَام...',
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
              ...PhonotacticsCategory.values.map((cat) {
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              FilterChip(
                label: const Text('النَّقْلُ الصَّوْتِيُّ (IPA)'),
                selected: state.showIpaTranscriptions,
                onSelected: (_) => _controller.toggleIpaTranscriptions(),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('إِرْشَادَاتُ النُّطْقِ'),
                selected: state.showArticulationTips,
                onSelected: (_) => _controller.toggleArticulationTips(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: lessons.isEmpty
              ? const Center(
                  child: Text('لَا تُوجَدُ نَتَائِجُ مُطَابِقَةٌ لِلْبَحْثِ.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: lessons.length,
                  itemBuilder: (context, index) {
                    return _PhonotacticsCard(
                      lesson: lessons[index],
                      showIpa: state.showIpaTranscriptions,
                      showTips: state.showArticulationTips,
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
    PhonotacticsProsodyState state,
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
                        'دِقَّةُ التَّمْيِيزِ الصَّوْتِيِّ: ${(state.masteryRatio * 100).round()}%',
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
                  Chip(label: Text('${drill.targetLanguage} • ${drill.category.titleEn}')),
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

class _PhonotacticsCard extends StatelessWidget {
  const _PhonotacticsCard({
    required this.lesson,
    required this.showIpa,
    required this.showTips,
  });

  final PhonotacticsLesson lesson;
  final bool showIpa;
  final bool showTips;

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
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                lesson.titleAr,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${lesson.titleEn} • ${lesson.titleDe}',
              style: theme.textTheme.bodySmall,
            ),
            const Divider(height: 20),
            _PhoneticLangBlock(
              lang: 'الْعَرَبِيَّةُ',
              examples: lesson.arabicExamples,
              rule: lesson.ruleAr,
              showIpa: showIpa,
              rtl: true,
            ),
            const SizedBox(height: 12),
            _PhoneticLangBlock(
              lang: 'English',
              examples: lesson.englishExamples,
              rule: lesson.ruleEn,
              showIpa: showIpa,
              rtl: false,
            ),
            const SizedBox(height: 12),
            _PhoneticLangBlock(
              lang: 'Deutsch',
              examples: lesson.germanExamples,
              rule: lesson.ruleDe,
              showIpa: showIpa,
              rtl: false,
            ),
            if (showTips) ...[
              const SizedBox(height: 10),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  'إِرْشَادٌ صَوْتِيٌّ: ${lesson.articulationTipAr}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
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

class _PhoneticLangBlock extends StatelessWidget {
  const _PhoneticLangBlock({
    required this.lang,
    required this.examples,
    required this.rule,
    required this.showIpa,
    required this.rtl,
  });

  final String lang;
  final List<PhoneticPairExample> examples;
  final String rule;
  final bool showIpa;
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
          const SizedBox(height: 4),
          ...examples.map((ex) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                showIpa
                    ? '${ex.orthography}  ${ex.ipaTranscription} — ${ex.glossAr}'
                    : '${ex.orthography} — ${ex.glossAr}',
                style: theme.textTheme.bodyMedium,
              ),
            );
          }),
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
