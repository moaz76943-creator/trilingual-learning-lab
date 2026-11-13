import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../controllers/prosodic_rhythm_controller.dart';

/// Screen presenting the Trilingual Prosody, Metric Rhythm & Syllable Stress Studio
class ProsodicRhythmScreen extends StatefulWidget {
  final ProsodicRhythmController? controller;

  const ProsodicRhythmScreen({super.key, this.controller});

  @override
  State<ProsodicRhythmScreen> createState() => _ProsodicRhythmScreenState();
}

class _ProsodicRhythmScreenState extends State<ProsodicRhythmScreen>
    with SingleTickerProviderStateMixin {
  late final ProsodicRhythmController _controller;
  late final Ticker _ticker;
  double _accumulatedMs = 0.0;
  Duration _lastDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ProsodicRhythmController();
    _ticker = createTicker((elapsed) {
      if (_lastDuration != Duration.zero && _controller.state.isMetronomePlaying) {
        final dt = (elapsed - _lastDuration).inMilliseconds.toDouble();
        _accumulatedMs += dt;
        final stepIntervalMs = (60.0 / _controller.state.metronomeBpm) * 500.0;
        if (_accumulatedMs >= stepIntervalMs) {
          _accumulatedMs = 0.0;
          _controller.advanceSyllableTick();
        }
      }
      _lastDuration = elapsed;
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
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
              'مُخْتَبَرُ العَرُوضِ وَالنَّبْرِ الصَّوْتِيِّ',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Text(
              'Prosody, Syllable Stress & Metric Rhythm Studio (Al-Farahidi)',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_controller.state.isMetronomePlaying
                ? Icons.volume_up
                : Icons.volume_off),
            tooltip: 'تَشْغِيلُ / إِيقَافُ النَّقَرَاتِ الإِيقَاعِيَّةِ',
            onPressed: _controller.toggleMetronome,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'إِعَادَةُ الضَّبْطِ',
            onPressed: _controller.reset,
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final state = _controller.state;
          final item = state.selectedItem;
          final activeSyllable = state.activeSyllable;

          return Column(
            children: [
              _buildLanguageSelector(state),

              // Visual Rhythmic Waveform & Metrical Beat Canvas
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark acoustic studio slate
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
                      painter: ProsodyRhythmWavePainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Prosodic Readout Card
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
                          labelAr: 'المَقْطَعُ النَّشِطُ',
                          labelEn: 'Active Syllable',
                          value: '${activeSyllable.text} (${activeSyllable.phoneticStructure})',
                          color: activeSyllable.isStressed ? Colors.greenAccent : Colors.cyanAccent,
                        ),
                        _buildMetric(
                          labelAr: 'وَزْنُ المَقْطَعِ',
                          labelEn: 'Weight Symbol',
                          value: '${activeSyllable.weight.symbol} ${activeSyllable.weight.nameAr.split(' ').first}',
                          color: Colors.amberAccent,
                        ),
                        _buildMetric(
                          labelAr: 'حَالَةُ النَّبْرِ',
                          labelEn: 'Stress Accent',
                          value: activeSyllable.isStressed ? 'مَنْبُورٌ (Stressed)' : 'غَيْرُ مَنْبُورٍ',
                          color: activeSyllable.isStressed ? Colors.orangeAccent : Colors.white70,
                        ),
                        _buildMetric(
                          labelAr: 'سُرْعَةُ الإِيقَاعِ',
                          labelEn: 'Metronome BPM',
                          value: '${state.metronomeBpm.toInt()} bpm',
                          color: Colors.lightGreenAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Interactive Syllable Chips & Tempo Slider
              Expanded(
                flex: 4,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  children: [
                    // Item Selection Dropdown
                    DropdownButtonFormField<ProsodicItem>(
                      decoration: const InputDecoration(
                        labelText: 'النَّمُوذَجُ العَرُوضِيُّ أَوِ النَّبْرِيُّ',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      ),
                      value: item,
                      items: ProsodicItem.catalog
                          .where((i) => i.language == state.selectedLanguage)
                          .map((entry) {
                        return DropdownMenuItem(
                          value: entry,
                          child: Text(
                            '${entry.fullText} (${entry.titleAr})',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) _controller.selectItem(val);
                      },
                    ),

                    const SizedBox(height: 8),

                    // Syllable Pulse Row (Clickable)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < item.syllables.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ChoiceChip(
                              backgroundColor: item.syllables[i].isStressed
                                  ? const Color(0xFFD97706).withOpacity(0.3)
                                  : const Color(0xFF1E293B),
                              selectedColor: Colors.teal.shade700,
                              side: BorderSide(
                                color: state.activeSyllableIndex == i
                                    ? Colors.white
                                    : (item.syllables[i].isStressed ? Colors.amberAccent : Colors.cyanAccent),
                                width: state.activeSyllableIndex == i ? 2.5 : 1.0,
                              ),
                              label: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    item.syllables[i].text,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: item.syllables[i].isStressed ? Colors.amberAccent : Colors.white,
                                    ),
                                  ),
                                  Text(
                                    item.syllables[i].weight.symbol,
                                    style: const TextStyle(fontSize: 12, color: Colors.cyanAccent),
                                  ),
                                ],
                              ),
                              selected: state.activeSyllableIndex == i,
                              onSelected: (_) => _controller.selectSyllable(i),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Metronome BPM Slider
                    Row(
                      children: [
                        const SizedBox(
                          width: 140,
                          child: Text('سُرْعَةُ النَّقْرِ الإِيقَاعِيِّ (BPM):'),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.metronomeBpm,
                            min: 40.0,
                            max: 140.0,
                            divisions: 20,
                            label: '${state.metronomeBpm.toInt()} BPM',
                            onChanged: _controller.setMetronomeBpm,
                          ),
                        ),
                        Text('${state.metronomeBpm.toInt()} bpm'),
                      ],
                    ),

                    // Prosodic Rule Explanation Box
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F2E3A).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.cyanAccent.shade700, width: 1.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item.meterNameAr != null)
                            Text(
                              'البَحْرُ / التَّفْعِيلَةُ: ${item.meterNameAr!} | ${item.metricalFeetAr ?? ""}',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent),
                            ),
                          const SizedBox(height: 4),
                          Text(
                            item.prosodicRuleExplanationAr,
                            style: const TextStyle(fontSize: 12, color: Colors.white, height: 1.35),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLanguageSelector(ProsodicRhythmState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SegmentedButton<ProsodicLanguage>(
        segments: ProsodicLanguage.values.map((lang) {
          return ButtonSegment<ProsodicLanguage>(
            value: lang,
            label: Text(
              lang.nameAr.split(' ').first,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
          );
        }).toList(),
        selected: {state.selectedLanguage},
        onSelectionChanged: (set) => _controller.setLanguage(set.first),
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
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: color)),
      ],
    );
  }
}

/// Custom painter rendering the visual Prosodic Beats, Stress Peaks, and F0 Pitch Contour
class ProsodyRhythmWavePainter extends CustomPainter {
  final ProsodicRhythmState state;

  ProsodyRhythmWavePainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final item = state.selectedItem;
    final numSyllables = item.syllables.length;

    // Header label
    _drawText(canvas, 'مُخَطَّطُ النَّبْرِ وَالنَّقَرَاتِ الإِيقَاعِيَّةِ (Rhythm Pulse & F0)', const Offset(16, 12), Colors.amberAccent, 11.0);

    // 1. Draw Syllable Pillars & Stress Height
    final availableWidth = width - 40;
    final slotWidth = availableWidth / numSyllables;
    final baselineY = height * 0.75;

    final pitchPoints = <Offset>[];

    for (int i = 0; i < numSyllables; i++) {
      final syl = item.syllables[i];
      final isCurrentTick = state.activeSyllableIndex == i;

      final x = 20 + (i * slotWidth) + (slotWidth / 2);

      // Height of pillar reflects stress & syllable weight
      double pillarHeight = (syl.weight == SyllableWeight.superHeavy)
          ? 90.0
          : (syl.weight == SyllableWeight.heavy ? 70.0 : 45.0);
      if (syl.isStressed) {
        pillarHeight += 35.0; // Stressed peak
      }

      final pillarRect = Rect.fromLTWH(x - (slotWidth * 0.35), baselineY - pillarHeight, slotWidth * 0.70, pillarHeight);

      // Pillar Paint
      Color pillarColor = syl.isStressed ? Colors.amberAccent : Colors.tealAccent;
      if (isCurrentTick) {
        pillarColor = Colors.orangeAccent;
      }

      final fillPaint = Paint()
        ..color = isCurrentTick ? pillarColor.withOpacity(0.6) : pillarColor.withOpacity(0.25)
        ..style = PaintingStyle.fill;
      canvas.drawRRect(RRect.fromRectAndRadius(pillarRect, const Radius.circular(8)), fillPaint);

      final strokePaint = Paint()
        ..color = isCurrentTick ? Colors.white : pillarColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = isCurrentTick ? 2.5 : 1.2;
      canvas.drawRRect(RRect.fromRectAndRadius(pillarRect, const Radius.circular(8)), strokePaint);

      // Syllable text at bottom
      _drawText(
        canvas,
        syl.text,
        Offset(x - (syl.text.length * 4.5), baselineY + 8),
        isCurrentTick ? Colors.white : Colors.white70,
        14.0,
      );

      // Metrical symbol (— / ∪)
      _drawText(
        canvas,
        syl.weight.symbol,
        Offset(x - 5, pillarRect.top - 18),
        syl.isStressed ? Colors.amberAccent : Colors.cyanAccent,
        13.0,
      );

      // Collect target pitch points for F0 contour
      pitchPoints.add(Offset(x, pillarRect.top));
    }

    // 2. Draw Pitch F0 Contour Curve connecting syllable stress peaks
    if (state.showPitchContour && pitchPoints.length >= 2) {
      final contourPath = Path();
      contourPath.moveTo(pitchPoints.first.dx, pitchPoints.first.dy);

      for (int i = 0; i < pitchPoints.length - 1; i++) {
        final p1 = pitchPoints[i];
        final p2 = pitchPoints[i + 1];
        final midX = (p1.dx + p2.dx) / 2.0;
        contourPath.cubicTo(midX, p1.dy, midX, p2.dy, p2.dx, p2.dy);
      }

      final contourPaint = Paint()
        ..color = Colors.lightGreenAccent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawPath(contourPath, contourPaint);

      // Pitch Peak dots
      for (final pt in pitchPoints) {
        canvas.drawCircle(pt, 4.0, Paint()..color = Colors.lightGreenAccent);
      }
    }
  }

  void _drawText(Canvas canvas, String text, Offset offset, Color color, double fontSize) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant ProsodyRhythmWavePainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
