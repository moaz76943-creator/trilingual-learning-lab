import 'package:flutter/material.dart';

import '../controllers/srs_mastery_controller.dart';
import '../models/srs_models.dart';

class SrsMasteryStudioScreen extends StatefulWidget {
  const SrsMasteryStudioScreen({super.key, this.controller});

  final SrsMasteryController? controller;

  @override
  State<SrsMasteryStudioScreen> createState() => _SrsMasteryStudioScreenState();
}

class _SrsMasteryStudioScreenState extends State<SrsMasteryStudioScreen> {
  late final SrsMasteryController _controller;
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? SrsMasteryController();
  }

  @override
  void dispose() {
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
        final card = state.activeCard;

        return Scaffold(
          appBar: AppBar(
            title: const Text('مُحَرِّكُ التَّكْرَارِ الْمُتَبَاعِدِ (SM-2)'),
            actions: [
              IconButton(
                tooltip: 'إِعَادَةُ ضَبْطِ التَّقَدُّمِ',
                icon: const Icon(Icons.restart_alt_rounded),
                onPressed: _controller.resetAllProgress,
              ),
            ],
          ),
          body: Column(
            children: [
              _buildStatsBar(theme, state),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('الْكُلُّ'),
                      selected: state.selectedDomain == null,
                      onSelected: (_) => _controller.selectDomain(null),
                    ),
                    const SizedBox(width: 8),
                    ...SrsDeckDomain.values.map((d) {
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
              const Divider(height: 1),
              Expanded(
                child: card == null
                    ? _buildQueueCompleteState(theme, state)
                    : _buildActiveReviewCard(theme, state, card),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatsBar(ThemeData theme, SrsMasteryState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatMetric(
                label: 'الْمُسْتَحَقُّ',
                value: '${state.dueQueue.length}',
              ),
              _StatMetric(
                label: 'الْمُرَاجَعَاتُ',
                value: '${state.reviewedTodayCount}',
              ),
              _StatMetric(
                label: 'مُعَدَّلُ السُّهُولَةِ',
                value: '${state.averageEaseFactor}',
              ),
              _StatMetric(
                label: 'الْمُتْقَنُ',
                value: '${state.masteredCount}/${state.cards.length}',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveReviewCard(
    ThemeData theme,
    SrsMasteryState state,
    SrsReviewCard card,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(label: Text(card.domain.titleEn)),
                      Text(
                        'Rep: ${card.repetitions} • EF: ${card.easeFactor}',
                        style: theme.textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      card.promptAr,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      'EN: ${card.promptEn}\nDE: ${card.promptDe}',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  if (state.isAnswerRevealed) ...[
                    const Divider(height: 24),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        card.answerAr,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        'EN: ${card.answerEn}\nDE: ${card.answerDe}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'مِفْتَاحُ التَّذَكُّرِ: ${card.mnemonicAr}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (!state.isAnswerRevealed)
            FilledButton.icon(
              onPressed: _controller.revealAnswer,
              icon: const Icon(Icons.visibility_rounded),
              label: const Text('إِظْهَارُ الْإِجَابَةِ الثُّلَاثِيَّةِ'),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: RecallGrade.values.map((grade) {
                return FilledButton.tonal(
                  onPressed: () => _controller.submitRecallGrade(grade),
                  child: Text(grade.labelAr),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildQueueCompleteState(ThemeData theme, SrsMasteryState state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.verified_rounded, size: 56, color: Colors.green),
            const SizedBox(height: 12),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'أَتْمَمْتَ جَمِيعَ الْبِطَاقَاتِ الْمُسْتَحَقَّةِ لِلْيَوْمِ!',
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _controller.advanceDayForSimulation,
              icon: const Icon(Icons.fast_forward_rounded),
              label: const Text('مُحَاكَاةُ الْيَوْمِ التَّالِي (+1 يَوْم)'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatMetric extends StatelessWidget {
  const _StatMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
