import 'package:flutter/material.dart';

import '../controllers/nonfinite_clauses_controller.dart';
import '../models/nonfinite_clauses_models.dart';

class NonFiniteClausesStudioScreen extends StatefulWidget {
  const NonFiniteClausesStudioScreen({
    super.key,
    this.controller,
  });

  final NonFiniteClausesController? controller;

  @override
  State<NonFiniteClausesStudioScreen> createState() =>
      _NonFiniteClausesStudioScreenState();
}

class _NonFiniteClausesStudioScreenState
    extends State<NonFiniteClausesStudioScreen>
    with SingleTickerProviderStateMixin {
  late final NonFiniteClausesController _controller;
  late final bool _ownsController;
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? NonFiniteClausesController();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('مُخْتَبَرُ الْمَصْدَرِ الْمُؤَوَّلِ وَالْجُمَلِ غَيْرِ الْمُصَرَّفَةِ'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                icon: Icon(Icons.schema_outlined),
                text: 'الِاسْتِكْشَافُ وَالْمُقَارَنَةُ',
              ),
              Tab(
                icon: Icon(Icons.quiz_outlined),
                text: 'التَّدْرِيبُ التَّفَاعُلِيُّ',
              ),
            ],
          ),
        ),
        body: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final state = _controller.state;
            return TabBarView(
              controller: _tabController,
              children: [
                _buildExplorerTab(theme, state),
                _buildDrillTab(theme, state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildExplorerTab(ThemeData theme, NonFiniteClausesState state) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: _searchController,
          onChanged: _controller.updateSearch,
          decoration: InputDecoration(
            hintText: 'ابْحَثْ عَنْ تَرْكِيبٍ أَوْ مِثَالٍ (مِثَال: damit، Linksattribut، أَنْ أَفْهَمَ)...',
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
        const SizedBox(height: 12),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('الشَّرْحُ وَالتَّحْلِيلُ'),
          subtitle: const Text('إِظْهَارُ الْقَوَاعِدِ النَّحْوِيَّةِ وَتَنْبِيهَاتِ الْأَخْطَاءِ الشَّائِعَةِ'),
          value: state.showRules,
          onChanged: (_) => _controller.toggleRules(),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: FilterChip(
                  label: const Text('الْكُلُّ'),
                  selected: state.selectedCategory == null,
                  onSelected: (_) => _controller.selectCategory(null),
                ),
              ),
              ...NonFiniteCategory.values.map(
                (cat) => Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: FilterChip(
                    label: Text(cat.titleAr),
                    selected: state.selectedCategory == cat,
                    onSelected: (_) => _controller.selectCategory(cat),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (state.filteredUnits.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'لَا تُوجَدُ وَحَدَاتٌ مُطَابِقَةٌ لِلْبَحْثِ الْحَالِيِّ.',
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ),
          )
        else
          ...state.filteredUnits.map((unit) => _buildUnitCard(theme, unit, state.showRules)),
      ],
    );
  }

  Widget _buildUnitCard(
    ThemeData theme,
    NonFiniteLessonUnit unit,
    bool showRules,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    unit.titleAr,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(
                    unit.clauseTag,
                    style: theme.textTheme.labelSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    unit.titleEn,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Text(
                    unit.titleDe,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 24),
            _buildLanguageExampleRow(
              theme: theme,
              badge: 'AR',
              text: unit.exampleAr,
              direction: TextDirection.rtl,
            ),
            const SizedBox(height: 8),
            _buildLanguageExampleRow(
              theme: theme,
              badge: 'EN',
              text: unit.exampleEn,
              direction: TextDirection.ltr,
            ),
            const SizedBox(height: 8),
            _buildLanguageExampleRow(
              theme: theme,
              badge: 'DE',
              text: unit.exampleDe,
              direction: TextDirection.ltr,
            ),
            if (showRules) ...[
              const Divider(height: 24),
              Text(
                unit.ruleAr,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 6),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EN: ${unit.ruleEn}',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'DE: ${unit.ruleDe}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: theme.colorScheme.error,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        unit.pitfallAlertAr,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageExampleRow({
    required ThemeData theme,
    required String badge,
    required String text,
    required TextDirection direction,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          padding: const EdgeInsets.symmetric(vertical: 4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            badge,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Directionality(
            textDirection: direction,
            child: Text(
              text,
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDrillTab(ThemeData theme, NonFiniteClausesState state) {
    final drill = state.currentDrill;
    if (drill == null) {
      return const Center(child: Text('لَا تُوجَدُ تَدْرِيبَاتٌ مُتَاحَةٌ.'));
    }

    final hasAnswered = state.selectedOptionIndex != null;
    final accuracyPercent = (state.accuracyRatio * 100).round();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'السُّؤَالُ ${state.currentDrillIndex + 1} مِنْ ${state.drills.length}',
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  'الدِّقَّةُ: $accuracyPercent% (${state.correctCount}/${state.answeredCount})',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Chip(
                    label: Text('اللُّغَةُ الْمُسْتَهْدَفَةُ: ${drill.targetLanguage}'),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  drill.promptAr,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(drill.promptEn, style: theme.textTheme.bodySmall),
                      const SizedBox(height: 2),
                      Text(drill.promptDe, style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ...List.generate(drill.options.length, (idx) {
                  final optionText = drill.options[idx];
                  final isSelected = state.selectedOptionIndex == idx;
                  final isCorrectOption = idx == drill.correctIndex;

                  Color? tileColor;
                  if (hasAnswered) {
                    if (isCorrectOption) {
                      tileColor = theme.colorScheme.primaryContainer;
                    } else if (isSelected) {
                      tileColor = theme.colorScheme.errorContainer;
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: tileColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        alignment: AlignmentDirectional.centerStart,
                      ),
                      onPressed: hasAnswered
                          ? null
                          : () => _controller.submitAnswer(idx),
                      child: Directionality(
                        textDirection: drill.targetLanguage == 'AR'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        child: Text(
                          optionText,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  );
                }),
                if (hasAnswered) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      drill.explanationAr,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _controller.nextDrill,
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('التَّدْرِيبُ التَّالِي'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton.icon(
                        onPressed: _controller.resetDrills,
                        icon: const Icon(Icons.refresh),
                        label: const Text('إِعَادَةُ الْجَوْلَةِ'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
