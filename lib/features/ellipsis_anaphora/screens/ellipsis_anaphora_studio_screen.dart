import 'package:flutter/material.dart';

import '../controllers/ellipsis_anaphora_controller.dart';
import '../models/ellipsis_anaphora_models.dart';

class EllipsisAnaphoraStudioScreen extends StatefulWidget {
  const EllipsisAnaphoraStudioScreen({super.key, this.controller});

  final EllipsisAnaphoraController? controller;

  @override
  State<EllipsisAnaphoraStudioScreen> createState() =>
      _EllipsisAnaphoraStudioScreenState();
}

class _EllipsisAnaphoraStudioScreenState
    extends State<EllipsisAnaphoraStudioScreen>
    with SingleTickerProviderStateMixin {
  late final EllipsisAnaphoraController _controller;
  late final bool _ownsController;
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? EllipsisAnaphoraController();
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
            title: const Text('مُخْتَبَرُ الْحَذْفِ وَالتَّقْدِيرِ وَالْإِحَالَةِ'),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(Icons.auto_fix_high_rounded),
                  text: 'اسْتِكْشَافُ الْحَذْفِ وَالتَّقْدِيرِ',
                ),
                Tab(
                  icon: Icon(Icons.fact_check_outlined),
                  text: 'اخْتِبَارُ التَّقْدِيرِ النَّحْوِيِّ',
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildExplorerView(context, theme, state),
              _buildDrillView(context, theme, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExplorerView(
    BuildContext context,
    ThemeData theme,
    EllipsisAnaphoraState state,
  ) {
    final cases = state.filteredCases;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: _controller.setSearchQuery,
            decoration: InputDecoration(
              hintText: 'ابْحَثْ عَنِ الْحَذْفِ أَوِ الْإِحَالَةِ (لَوْلَا، Gapping، Sluicing)...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: state.searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _controller.setSearchQuery('');
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
              ...EllipsisPhenomenonType.values.map((t) {
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
                    state.showRecoveredForm
                        ? 'الْعَرْضُ: التَّقْدِيرُ الْكَامِلُ (Recovered)'
                        : 'الْعَرْضُ: الصُّورَةُ الْمُخْتَزَلَةُ (Surface)',
                  ),
                  value: state.showRecoveredForm,
                  onChanged: (_) => _controller.toggleRecoveredForm(),
                ),
              ),
              FilterChip(
                label: const Text('خَرِيطَةُ التَّقْدِيرِ'),
                selected: state.showMappingsPanel,
                onSelected: (_) => _controller.toggleMappingsPanel(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: cases.isEmpty
              ? const Center(
                  child: Text('لَا تُوجَدُ نَتَائِجُ مُطَابِقَةٌ.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cases.length,
                  itemBuilder: (context, index) {
                    return _CaseStudyCard(
                      study: cases[index],
                      showRecovered: state.showRecoveredForm,
                      showMappings: state.showMappingsPanel,
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildDrillView(
    BuildContext context,
    ThemeData theme,
    EllipsisAnaphoraState state,
  ) {
    final drill = state.currentDrill;
    if (drill == null) {
      return const Center(child: Text('لَا تُوجَدُ أَسْئِلَةٌ مُتَاحَةٌ.'));
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
                        'دِقَّةُ التَّقْدِيرِ: ${(state.accuracy * 100).round()}%',
                        style: theme.textTheme.titleMedium,
                      ),
                      Text('${state.correctCount} / ${state.totalAnswered}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: state.accuracy),
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
                        color: bg ?? theme.colorScheme.surfaceVariant.withOpacity(0.4),
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
                          onTap: () => _controller.answerDrill(i),
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
                          label: const Text('السُّؤَالُ التَّالِي'),
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

class _CaseStudyCard extends StatelessWidget {
  const _CaseStudyCard({
    required this.study,
    required this.showRecovered,
    required this.showMappings,
  });

  final EllipsisCaseStudy study;
  final bool showRecovered;
  final bool showMappings;

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
                study.titleAr,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${study.titleEn} • ${study.titleDe}',
              style: theme.textTheme.bodySmall,
            ),
            const Divider(height: 20),
            _TriRow(
              lang: 'الْعَرَبِيَّةُ',
              sentence: showRecovered ? study.recoveredAr : study.surfaceAr,
              note: study.analysisAr,
              rtl: true,
            ),
            const SizedBox(height: 12),
            _TriRow(
              lang: 'English',
              sentence: showRecovered ? study.recoveredEn : study.surfaceEn,
              note: study.analysisEn,
              rtl: false,
            ),
            const SizedBox(height: 12),
            _TriRow(
              lang: 'Deutsch',
              sentence: showRecovered ? study.recoveredDe : study.surfaceDe,
              note: study.analysisDe,
              rtl: false,
            ),
            if (showMappings && study.mappings.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: study.mappings.map((m) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        '[${m.language}] ${m.elidedSurface}  ⇒  ${m.recoveredFullForm}\n${m.omittedElementNote}',
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
                'قَيْدٌ نَحْوِيٌّ: ${study.constraintWarningAr}',
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

class _TriRow extends StatelessWidget {
  const _TriRow({
    required this.lang,
    required this.sentence,
    required this.note,
    required this.rtl,
  });

  final String lang;
  final String sentence;
  final String note;
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
          Text(sentence, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 2),
          Text(
            note,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
