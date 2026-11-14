import 'package:flutter/material.dart';

import '../controllers/comprehension_cloze_controller.dart';
import '../models/comprehension_cloze_models.dart';

class ComprehensionClozeStudioScreen extends StatefulWidget {
  const ComprehensionClozeStudioScreen({super.key, this.controller});

  final ComprehensionClozeController? controller;

  @override
  State<ComprehensionClozeStudioScreen> createState() =>
      _ComprehensionClozeStudioScreenState();
}

class _ComprehensionClozeStudioScreenState
    extends State<ComprehensionClozeStudioScreen>
    with SingleTickerProviderStateMixin {
  late final ComprehensionClozeController _controller;
  late final bool _ownsController;
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? ComprehensionClozeController();
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
            title: const Text('مُخْتَبَرُ الْفَهْمِ الْقِرَائِيِّ وَمَلْءِ الْفَرَاغَاتِ'),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(Icons.menu_book_outlined),
                  text: 'النُّصُوصُ الْمُتَوَازِيَةُ',
                ),
                Tab(
                  icon: Icon(Icons.edit_note_rounded),
                  text: 'تَدْرِيبُ مَلْءِ الْفَرَاغَاتِ (Cloze)',
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildPassagesTab(context, theme, state),
              _buildClozeTab(context, theme, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPassagesTab(
    BuildContext context,
    ThemeData theme,
    ComprehensionClozeState state,
  ) {
    final passages = state.filteredPassages;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: _controller.updateSearch,
            decoration: InputDecoration(
              hintText: 'ابْحَثْ فِي النُّصُوصِ (ابْنِ الْهَيْثَمِ، التَّرْجَمَةِ، Sensoren)...',
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
              ...PassageDomain.values.map((d) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(d.titleAr),
                    selected: state.selectedDomain == d,
                    onSelected: (_) => _controller.selectDomain(d),
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
                label: const Text('التَّرْجَمَةُ الْمُتَوَازِيَةُ (EN/DE)'),
                selected: state.showParallelTranslations,
                onSelected: (_) => _controller.toggleParallelTranslations(),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('الْمُصْطَلَحَاتُ'),
                selected: state.showGlossaryTerms,
                onSelected: (_) => _controller.toggleGlossaryTerms(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: passages.isEmpty
              ? const Center(
                  child: Text('لَا تُوجَدُ نُصُوصٌ مُطَابِقَةٌ لِلْبَحْثِ.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: passages.length,
                  itemBuilder: (context, index) {
                    return _PassageCard(
                      passage: passages[index],
                      showTranslations: state.showParallelTranslations,
                      showGlossary: state.showGlossaryTerms,
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildClozeTab(
    BuildContext context,
    ThemeData theme,
    ComprehensionClozeState state,
  ) {
    final item = state.currentCloze;
    if (item == null) {
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
                        'دِقَّةُ مَلْءِ الْفَرَاغَاتِ: ${(state.accuracyRatio * 100).round()}%',
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
                  Chip(label: Text('${item.targetLanguage} • ${item.domain.titleEn}')),
                  const SizedBox(height: 12),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      item.sentenceWithBlankAr,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      '${item.sentenceWithBlankEn}\n${item.sentenceWithBlankDe}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(item.options.length, (i) {
                    final selected = state.selectedOptionIndex;
                    final isSelected = selected == i;
                    final isCorrect = i == item.correctIndex;
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
                          title: Text(item.options[i]),
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
                          onTap: () => _controller.submitClozeAnswer(i),
                        ),
                      ),
                    );
                  }),
                  if (state.selectedOptionIndex != null) ...[
                    const Divider(),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(item.grammarReasonAr),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _controller.resetCloze,
                          child: const Text('إِعَادَةٌ'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton.icon(
                          onPressed: _controller.nextCloze,
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

class _PassageCard extends StatelessWidget {
  const _PassageCard({
    required this.passage,
    required this.showTranslations,
    required this.showGlossary,
  });

  final TrilingualReadingPassage passage;
  final bool showTranslations;
  final bool showGlossary;

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
                      passage.titleAr,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Chip(label: Text(passage.levelBadge)),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${passage.titleEn} • ${passage.titleDe}',
              style: theme.textTheme.bodySmall,
            ),
            const Divider(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(passage.bodyAr, style: theme.textTheme.bodyLarge),
            ),
            if (showTranslations) ...[
              const SizedBox(height: 12),
              Text('EN: ${passage.bodyEn}', style: theme.textTheme.bodyMedium),
              const SizedBox(height: 8),
              Text(
                'DE: ${passage.bodyDe}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            if (showGlossary && passage.keyTermsSummary.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: passage.keyTermsSummary
                      .map((term) => Text('• $term', style: theme.textTheme.bodySmall))
                      .toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
