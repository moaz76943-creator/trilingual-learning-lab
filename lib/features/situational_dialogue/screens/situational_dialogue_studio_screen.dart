import 'package:flutter/material.dart';

import '../controllers/situational_dialogue_controller.dart';
import '../models/situational_dialogue_models.dart';

class SituationalDialogueStudioScreen extends StatefulWidget {
  const SituationalDialogueStudioScreen({super.key, this.controller});

  final SituationalDialogueController? controller;

  @override
  State<SituationalDialogueStudioScreen> createState() =>
      _SituationalDialogueStudioScreenState();
}

class _SituationalDialogueStudioScreenState
    extends State<SituationalDialogueStudioScreen>
    with SingleTickerProviderStateMixin {
  late final SituationalDialogueController _controller;
  late final bool _ownsController;
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? SituationalDialogueController();
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
            title: const Text('مُخْتَبَرُ الْمُحَادَثَاتِ الْحَيَّةِ وَالْحِوَارِ الْمَوْقِفِيِّ'),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(Icons.forum_outlined),
                  text: 'سِينَارْيُوهَاتُ التَّخَاطُبِ',
                ),
                Tab(
                  icon: Icon(Icons.question_answer_outlined),
                  text: 'مُحَاكَاةُ الرَّدِّ الْمُهَذَّبِ',
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildScenariosTab(context, theme, state),
              _buildRoleplayTab(context, theme, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScenariosTab(
    BuildContext context,
    ThemeData theme,
    SituationalDialogueState state,
  ) {
    final scenarios = state.filteredScenarios;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: _controller.updateSearch,
            decoration: InputDecoration(
              hintText: 'ابْحَثْ فِي الْمَوَاقِفِ (الْمَكْتَبَةُ، Gleis، Apotheke، الضِّيَافَةُ)...',
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
              ...DialogueContextDomain.values.map((d) {
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
                label: const Text('مُلَاحَظَاتُ التَّدَاوُلِيَّةِ'),
                selected: state.showPragmaticNotes,
                onSelected: (_) => _controller.togglePragmaticNotes(),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('النَّصُّ الْأَلْمَانِيُّ'),
                selected: state.showGermanLine,
                onSelected: (_) => _controller.toggleGermanLine(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: scenarios.isEmpty
              ? const Center(
                  child: Text('لَا تُوجَدُ مُحَادَثَاتٌ مُطَابِقَةٌ لِلْبَحْثِ.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: scenarios.length,
                  itemBuilder: (context, index) {
                    return _DialogueScenarioCard(
                      scenario: scenarios[index],
                      showNotes: state.showPragmaticNotes,
                      showGerman: state.showGermanLine,
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildRoleplayTab(
    BuildContext context,
    ThemeData theme,
    SituationalDialogueState state,
  ) {
    final challenge = state.currentChallenge;
    if (challenge == null) {
      return const Center(child: Text('لَا تُوجَدُ تَحَدِّيَاتٌ مُتَاحَةٌ.'));
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
                        'دِقَّةُ الِاسْتِجَابَةِ الْمَوْقِفِيَّةِ: ${(state.accuracyRatio * 100).round()}%',
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
                  Chip(
                    label: Text(
                      '${challenge.targetLanguage} • ${challenge.domain.titleEn}',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      challenge.incomingPromptAr,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      '${challenge.incomingPromptEn}\n${challenge.incomingPromptDe}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(challenge.options.length, (i) {
                    final selected = state.selectedOptionIndex;
                    final isSelected = selected == i;
                    final isCorrect = i == challenge.correctIndex;
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
                          title: Text(challenge.options[i]),
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
                          onTap: () => _controller.submitResponse(i),
                        ),
                      ),
                    );
                  }),
                  if (state.selectedOptionIndex != null) ...[
                    const Divider(),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(challenge.feedbackAr),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _controller.resetChallenges,
                          child: const Text('إِعَادَةٌ'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton.icon(
                          onPressed: _controller.nextChallenge,
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

class _DialogueScenarioCard extends StatelessWidget {
  const _DialogueScenarioCard({
    required this.scenario,
    required this.showNotes,
    required this.showGerman,
  });

  final SituationalDialogueScenario scenario;
  final bool showNotes;
  final bool showGerman;

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
                Chip(label: Text(scenario.registerBadge)),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${scenario.titleEn} • ${scenario.titleDe}',
              style: theme.textTheme.bodySmall,
            ),
            const Divider(height: 20),
            ...scenario.turns.map((turn) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        '${turn.speakerRoleAr} (${turn.speakerRoleEn})',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(turn.lineAr, style: theme.textTheme.bodyLarge),
                    ),
                    const SizedBox(height: 4),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        'EN: ${turn.lineEn}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    if (showGerman) ...[
                      const SizedBox(height: 2),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          'DE: ${turn.lineDe}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                    if (showNotes) ...[
                      const SizedBox(height: 6),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'مُلَاحَظَةٌ: ${turn.pragmaticNoteAr}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'أَدَبُ التَّخَاطُبِ: ${scenario.culturalTipAr}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
