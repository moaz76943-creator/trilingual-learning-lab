import 'package:flutter/material.dart';

import '../controllers/nominalization_controller.dart';
import '../models/nominalization_models.dart';

class NominalizationStudioScreen extends StatefulWidget {
  const NominalizationStudioScreen({super.key, this.controller});

  final NominalizationController? controller;

  @override
  State<NominalizationStudioScreen> createState() =>
      _NominalizationStudioScreenState();
}

class _NominalizationStudioScreenState
    extends State<NominalizationStudioScreen>
    with SingleTickerProviderStateMixin {
  late final NominalizationController _controller;
  late final bool _ownsController;
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? NominalizationController();
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
            title: const Text('مُخْتَبَرُ الْمَصَادِرِ وَالِاسْمِيَّةِ وَالِاشْتِقَاقِ'),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(Icons.transform_rounded),
                  text: 'التَّحْوِيلُ الِاسْمِيُّ وَالْمَصْفُوفَةُ',
                ),
                Tab(
                  icon: Icon(Icons.school_outlined),
                  text: 'اخْتِبَارُ الصَّرْفِ وَالْأَجْنَاسِ',
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
    NominalizationState state,
  ) {
    final lessons = state.filteredLessons;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: _controller.updateSearch,
            decoration: InputDecoration(
              hintText: 'ابْحَثْ عَنِ الْمَصْدَرِ، Nominalstil، Gerund، -ung...',
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
              ...NominalizationPatternType.values.map((t) {
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
                    state.showNominalStyle
                        ? 'الْأُسْلُوبُ: الِاسْمِيُّ الْمُحَوَّلُ (Nominal)'
                        : 'الْأُسْلُوبُ: الْفِعْلِيُّ الْأَصْلِيُّ (Verbal)',
                  ),
                  value: state.showNominalStyle,
                  onChanged: (_) => _controller.toggleStyleMode(),
                ),
              ),
              FilterChip(
                label: const Text('مَصْفُوفَةُ الِاشْتِقَاقِ'),
                selected: state.showMatrix,
                onSelected: (_) => _controller.toggleMatrix(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: lessons.isEmpty
              ? const Center(
                  child: Text('لَا تُوجَدُ نَتَائِجُ مُطَابِقَةٌ.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: lessons.length,
                  itemBuilder: (context, index) {
                    return _LessonCard(
                      lesson: lessons[index],
                      nominalMode: state.showNominalStyle,
                      showMatrix: state.showMatrix,
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
    NominalizationState state,
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
                        'مُؤَشِّرُ الْإِتْقَانِ: ${(state.masteryPercentage * 100).round()}%',
                        style: theme.textTheme.titleMedium,
                      ),
                      Text('${state.correctCount} / ${state.answeredCount}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: state.masteryPercentage),
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

class _LessonCard extends StatelessWidget {
  const _LessonCard({
    required this.lesson,
    required this.nominalMode,
    required this.showMatrix,
  });

  final NominalizationLesson lesson;
  final bool nominalMode;
  final bool showMatrix;

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
            _LangSection(
              lang: 'الْعَرَبِيَّةُ',
              text: nominalMode ? lesson.nominalFormAr : lesson.verbalFormAr,
              rule: lesson.morphologyRuleAr,
              rtl: true,
            ),
            const SizedBox(height: 12),
            _LangSection(
              lang: 'English',
              text: nominalMode ? lesson.nominalFormEn : lesson.verbalFormEn,
              rule: lesson.morphologyRuleEn,
              rtl: false,
            ),
            const SizedBox(height: 12),
            _LangSection(
              lang: 'Deutsch',
              text: nominalMode ? lesson.nominalFormDe : lesson.verbalFormDe,
              rule: lesson.morphologyRuleDe,
              rtl: false,
            ),
            if (showMatrix && lesson.matrixEntries.isNotEmpty) ...[
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
                  children: lesson.matrixEntries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        '${e.baseVerbOrAdj}\n→ AR: ${e.derivedNounAr} | EN: ${e.derivedNounEn} | DE: ${e.derivedNounDe} (${e.genderOrPatternTag})',
                        style: theme.textTheme.bodySmall,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
            const SizedBox(height: 10),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'تَنْبِيهٌ صَرْفِيٌّ: ${lesson.pitfallNoteAr}',
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

class _LangSection extends StatelessWidget {
  const _LangSection({
    required this.lang,
    required this.text,
    required this.rule,
    required this.rtl,
  });

  final String lang;
  final String text;
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
