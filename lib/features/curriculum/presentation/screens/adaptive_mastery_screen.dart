import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../controllers/adaptive_mastery_controller.dart';

/// Screen presenting the Trilingual CEFR Competency Matrix & Adaptive Mastery Studio
class AdaptiveMasteryScreen extends StatefulWidget {
  final AdaptiveMasteryController? controller;

  const AdaptiveMasteryScreen({super.key, this.controller});

  @override
  State<AdaptiveMasteryScreen> createState() => _AdaptiveMasteryScreenState();
}

class _AdaptiveMasteryScreenState extends State<AdaptiveMasteryScreen> {
  late final AdaptiveMasteryController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? AdaptiveMasteryController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مُحَرِّكُ الكَفَايَةِ اللُّغَوِيَّةِ وَالإِتْقَانِ (CEFR)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Trilingual CEFR Mastery & Adaptive Competency Matrix',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics_outlined),
            tooltip: 'تَشْغِيلُ التَّدْقِيقِ التَّشْخِيصِيِّ التَّكَيُّفِيِّ',
            onPressed: _controller.runDiagnosticAudit,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'إِعَادَةُ الضَّبْطِ',
            onPressed: _controller.resetDefaults,
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final state = _controller.state;
          final overallScore = state.activeLanguageOverallScore;
          final cefr = state.activeLanguageCefr;
          final weakest = state.weakestCompetencyNode;

          return Column(
            children: [
              _buildLanguageSelector(state),

              // Visual Radar Chart / Competency Diamond
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark analytics slate
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amber.shade700, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CustomPaint(
                      painter: CompetencyRadarPainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Level Readout Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: const Color(0xFF1E293B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.amber.withOpacity(0.4)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMetric(
                          labelAr: 'المُسْتَوَى المِعْيَارِيُّ',
                          labelEn: 'CEFR Level',
                          value: cefr.code,
                          color: Colors.amberAccent,
                        ),
                        _buildMetric(
                          labelAr: 'نِسْبَةُ الإِتْقَانِ العَامَّةُ',
                          labelEn: 'Overall Mastery',
                          value: '${(overallScore * 100).toStringAsFixed(1)}%',
                          color: Colors.greenAccent,
                        ),
                        _buildMetric(
                          labelAr: 'أَضْعَفُ نِطَاقٍ (تَشْخِيص)',
                          labelEn: 'Target Deficit',
                          value: weakest.domain.nameAr.split(' ').first,
                          color: Colors.orangeAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Interactive Skill Testing & Bayesian Transition Controls
              Expanded(
                flex: 4,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  children: [
                    const Text(
                      'تَقْيِيمُ الكَفَايَةِ وَتَحْدِيثُ بَايِز التَّكَيُّفِيِّ (BKT Evidence):',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(height: 6),

                    // Iterate through the 4 domains
                    ...SkillDomain.values.map((domain) {
                      final key = '${state.activeLanguage.code}_${domain.name}';
                      final node = state.competencyNodes[key];
                      final score = node?.probabilityMastery ?? 0.5;

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        color: const Color(0xFF1E293B).withOpacity(0.6),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      domain.nameAr,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                    ),
                                    Text(
                                      '${(score * 100).toStringAsFixed(1)}% (${node?.cefrLevel.code}) - ${node?.correctAssessmentsCount}/${node?.totalAssessmentsCount}',
                                      style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.check_circle, color: Colors.greenAccent, size: 22),
                                tooltip: 'إِجَابَةٌ صَحِيحَةٌ (+BKT)',
                                onPressed: () => _controller.recordAssessmentResult(
                                  domain: domain,
                                  isCorrect: true,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.cancel, color: Colors.redAccent, size: 22),
                                tooltip: 'إِجَابَةٌ خَاطِئَةٌ (-BKT)',
                                onPressed: () => _controller.recordAssessmentResult(
                                  domain: domain,
                                  isCorrect: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLanguageSelector(AdaptiveMasteryState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SegmentedButton<AppLanguage>(
        segments: AppLanguage.values.map((lang) {
          return ButtonSegment<AppLanguage>(
            value: lang,
            label: Text(
              lang.nameAr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
          );
        }).toList(),
        selected: {state.activeLanguage},
        onSelectionChanged: (set) => _controller.setActiveLanguage(set.first),
      ),
    );
  }

  Widget _buildMetric({
    required String labelAr,
    required String labelEn,
    required String value,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(labelAr, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        Text(labelEn, style: TextStyle(fontSize: 9, color: Colors.grey.shade400)),
        const SizedBox(height: 3),
        Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: color)),
      ],
    );
  }
}

/// Custom painter rendering a 4-axis Radar / Polygon Chart for CEFR Competency
class CompetencyRadarPainter extends CustomPainter {
  final AdaptiveMasteryState state;

  CompetencyRadarPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final center = Offset(width * 0.5, height * 0.5);
    final maxRadius = math.min(width, height) * 0.38;

    final domains = SkillDomain.values;
    final numAxes = domains.length;

    // 1. Draw Concentric Polygonal Grid Lines (CEFR A1, A2, B1, B2, C1, C2)
    final gridPaint = Paint()
      ..color = Colors.white12
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const levels = [0.20, 0.40, 0.60, 0.80, 1.00];
    for (final fraction in levels) {
      final r = maxRadius * fraction;
      final gridPath = Path();
      for (int i = 0; i < numAxes; i++) {
        final angle = (i * 2 * math.pi / numAxes) - (math.pi / 2.0);
        final pt = Offset(center.dx + r * math.cos(angle), center.dy + r * math.sin(angle));
        if (i == 0) {
          gridPath.moveTo(pt.dx, pt.dy);
        } else {
          gridPath.lineTo(pt.dx, pt.dy);
        }
      }
      gridPath.close();
      canvas.drawPath(gridPath, gridPaint);
    }

    // 2. Draw Spokes / Axes
    final spokePaint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 1.2;

    for (int i = 0; i < numAxes; i++) {
      final angle = (i * 2 * math.pi / numAxes) - (math.pi / 2.0);
      final spokeEnd = Offset(center.dx + maxRadius * math.cos(angle), center.dy + maxRadius * math.sin(angle));
      canvas.drawLine(center, spokeEnd, spokePaint);

      // Label at spoke tip
      final domain = domains[i];
      final labelOffset = Offset(
        center.dx + (maxRadius + 22) * math.cos(angle) - 30,
        center.dy + (maxRadius + 18) * math.sin(angle) - 8,
      );
      _drawText(canvas, domain.nameAr.split(' ').first, labelOffset, Colors.amber.shade200, 10.0);
    }

    // 3. Draw Active Competency Polygon
    final polyPath = Path();
    final polyPoints = <Offset>[];

    for (int i = 0; i < numAxes; i++) {
      final domain = domains[i];
      final key = '${state.activeLanguage.code}_${domain.name}';
      final score = state.competencyNodes[key]?.probabilityMastery ?? 0.5;
      final r = maxRadius * score.clamp(0.05, 1.0);
      final angle = (i * 2 * math.pi / numAxes) - (math.pi / 2.0);
      final pt = Offset(center.dx + r * math.cos(angle), center.dy + r * math.sin(angle));

      polyPoints.add(pt);
      if (i == 0) {
        polyPath.moveTo(pt.dx, pt.dy);
      } else {
        polyPath.lineTo(pt.dx, pt.dy);
      }
    }
    polyPath.close();

    final fillPaint = Paint()
      ..color = Colors.tealAccent.withOpacity(0.35)
      ..style = PaintingStyle.fill;
    canvas.drawPath(polyPath, fillPaint);

    final strokePaint = Paint()
      ..color = Colors.tealAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawPath(polyPath, strokePaint);

    // Draw vertex dots
    final dotPaint = Paint()..color = Colors.amberAccent..style = PaintingStyle.fill;
    for (final pt in polyPoints) {
      canvas.drawCircle(pt, 4.5, dotPaint);
    }

    _drawText(canvas, 'مُخَطَّطُ الكَفَايَاتِ الأَرْبَعِ (${state.activeLanguage.nameAr})', const Offset(16, 16), Colors.amberAccent, 11.0);
  }

  void _drawText(Canvas canvas, String text, Offset offset, Color color, double fontSize) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.rtl,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CompetencyRadarPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
