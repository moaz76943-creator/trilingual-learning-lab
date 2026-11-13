import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../controllers/formant_phonetic_trainer_controller.dart';

/// Screen presenting the F1/F2 Acoustic Formant Chart & Minimal Pair Trainer
class FormantPhoneticTrainerScreen extends StatefulWidget {
  final FormantPhoneticTrainerController? controller;

  const FormantPhoneticTrainerScreen({super.key, this.controller});

  @override
  State<FormantPhoneticTrainerScreen> createState() =>
      _FormantPhoneticTrainerScreenState();
}

class _FormantPhoneticTrainerScreenState
    extends State<FormantPhoneticTrainerScreen> {
  late final FormantPhoneticTrainerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FormantPhoneticTrainerController();
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
              'مُحَلِّلُ رَنِينِ الأَصْوَاتِ وَالأَزْوَاجِ الدَّقِيقَةِ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Acoustic Formant (F1/F2) & Minimal-Pair Trainer',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_controller.state.isMicrophoneActive
                ? Icons.mic
                : Icons.mic_off),
            tooltip: 'تَفْعِيلُ / إِيقَافُ التَّقْلِيطِ الصَّوْتِيِّ',
            onPressed: _controller.toggleMicrophone,
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
          final ex = state.selectedExercise;
          final score = state.acousticClosenessScore;

          return Column(
            children: [
              _buildLanguageSelector(state),

              // Visual Formant Space Canvas (F1 vs F2 Vowel Chart)
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark acoustic lab slate
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
                      painter: FormantVowelChartPainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Phonetic Readout Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: const Color(0xFF1E293B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: score > 85 ? Colors.greenAccent : Colors.amber.withOpacity(0.4),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMetric(
                          labelAr: 'الكَلِمَةُ الهَدَفُ',
                          labelEn: 'Target Word',
                          value: '${state.targetWord} (${state.targetIpa})',
                          color: Colors.amberAccent,
                        ),
                        _buildMetric(
                          labelAr: 'التَّطَابُقُ الصَّوْتِيُّ',
                          labelEn: 'Acoustic Match',
                          value: '${score.toStringAsFixed(1)}%',
                          color: score > 85 ? Colors.greenAccent : Colors.orangeAccent,
                        ),
                        _buildMetric(
                          labelAr: 'رَنِينُ F1 / F2',
                          labelEn: 'Formants (Hz)',
                          value: '${state.userCurrentF1Hz.toStringAsFixed(0)} / ${state.userCurrentF2Hz.toStringAsFixed(0)}',
                          color: Colors.cyanAccent,
                        ),
                        _buildMetric(
                          labelAr: 'نِسْبَةُ التَّمْيِيزِ',
                          labelEn: 'Discrimination',
                          value: '${state.correctDiscriminationsCount}/${state.totalAttemptsCount}',
                          color: Colors.lightGreenAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Minimal Pair Interactive Selection & Slider Tuning
              Expanded(
                flex: 4,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  children: [
                    // Exercise dropdown selector
                    DropdownButtonFormField<MinimalPairExercise>(
                      decoration: const InputDecoration(
                        labelText: 'الزَّوْجُ الصَّوْتِيُّ المَفْحُوصُ (Minimal Pair)',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      ),
                      value: ex,
                      items: MinimalPairExercise.catalog
                          .where((e) => e.language == state.language)
                          .map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            '${item.wordA} (${item.ipaA})  ↔  ${item.wordB} (${item.ipaB})',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) _controller.selectExercise(val);
                      },
                    ),

                    const SizedBox(height: 8),

                    // Minimal Pair Target Choice Segmented Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: state.targetIsWordA ? Colors.teal.shade700 : const Color(0xFF334155),
                            ),
                            onPressed: () => _controller.switchTargetWord(true),
                            child: Column(
                              children: [
                                Text(ex.wordA, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                Text('${ex.ipaA} - ${ex.meaningArA}', style: const TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: !state.targetIsWordA ? Colors.teal.shade700 : const Color(0xFF334155),
                            ),
                            onPressed: () => _controller.switchTargetWord(false),
                            child: Column(
                              children: [
                                Text(ex.wordB, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                Text('${ex.ipaB} - ${ex.meaningArB}', style: const TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // F1 Frequency Slider (Jaw Height / Openness)
                    Row(
                      children: [
                        const SizedBox(
                          width: 140,
                          child: Text('رَنِينُ الفَتْحِ F1 (Jaw Height):',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.userCurrentF1Hz,
                            min: 250.0,
                            max: 950.0,
                            divisions: 70,
                            label: '${state.userCurrentF1Hz.toStringAsFixed(0)} Hz',
                            onChanged: (val) => _controller.updateUserFormants(
                              f1Hz: val,
                              f2Hz: state.userCurrentF2Hz,
                            ),
                          ),
                        ),
                        Text('${state.userCurrentF1Hz.toStringAsFixed(0)} Hz'),
                      ],
                    ),

                    // F2 Frequency Slider (Tongue Frontness)
                    Row(
                      children: [
                        const SizedBox(
                          width: 140,
                          child: Text('رَنِينُ التَّقَدُّمِ F2 (Frontness):',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.userCurrentF2Hz,
                            min: 700.0,
                            max: 2600.0,
                            divisions: 95,
                            label: '${state.userCurrentF2Hz.toStringAsFixed(0)} Hz',
                            onChanged: (val) => _controller.updateUserFormants(
                              f1Hz: state.userCurrentF1Hz,
                              f2Hz: val,
                            ),
                          ),
                        ),
                        Text('${state.userCurrentF2Hz.toStringAsFixed(0)} Hz'),
                      ],
                    ),

                    // Phonetic Guidance Callout
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F2E3A).withOpacity(0.35),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.cyanAccent.shade700, width: 1.0),
                      ),
                      child: Text(
                        'الفَارِقُ الصَّوْتِيُّ الجَوْهَرِيُّ: ${ex.contrastingFeatureAr}',
                        style: const TextStyle(fontSize: 11, color: Colors.cyanAccent, height: 1.3),
                        textAlign: TextAlign.center,
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

  Widget _buildLanguageSelector(FormantPhoneticTrainerState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SegmentedButton<PhoneticLanguage>(
        segments: PhoneticLanguage.values.map((lang) {
          return ButtonSegment<PhoneticLanguage>(
            value: lang,
            label: Text(
              lang.nameAr.split(' ').first,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
          );
        }).toList(),
        selected: {state.language},
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

/// Custom painter rendering the standard IPA F1 vs F2 Acoustic Vowel Space Plane
/// Note: In phonetic tradition, the origin is at the top-right:
/// X-axis is F2 (Frontness: high F2 on left, low F2 on right)
/// Y-axis is F1 (Openness: low F1 close vowels at top, high F1 open vowels at bottom)
class FormantVowelChartPainter extends CustomPainter {
  final FormantPhoneticTrainerState state;

  FormantVowelChartPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    const padding = 34.0;
    final chartWidth = width - (padding * 2);
    final chartHeight = height - (padding * 2);

    // Formant Bounds (in Hz):
    // F2: 500 Hz (back) to 2700 Hz (front) -> plotted inverted (left = 2700, right = 500)
    // F1: 200 Hz (close) to 900 Hz (open)  -> plotted inverted (top = 200, bottom = 900)
    const minF2 = 600.0;
    const maxF2 = 2700.0;
    const minF1 = 200.0;
    const maxF1 = 900.0;

    Offset project(double f1, double f2) {
      // High F2 is on the Left (Front vowels like /i/), Low F2 on Right (Back vowels like /u/)
      final normX = 1.0 - ((f2 - minF2) / (maxF2 - minF2)).clamp(0.0, 1.0);
      // Low F1 is at the Top (Close vowels like /i/, /u/), High F1 at Bottom (Open vowels like /a/)
      final normY = ((f1 - minF1) / (maxF1 - minF1)).clamp(0.0, 1.0);

      return Offset(
        padding + normX * chartWidth,
        padding + normY * chartHeight,
      );
    }

    // 1. Draw Grid Lines
    final gridPaint = Paint()
      ..color = Colors.white10
      ..strokeWidth = 1.0;

    for (double f1 = 300; f1 <= 900; f1 += 200) {
      final p1 = project(f1, minF2);
      final p2 = project(f1, maxF2);
      canvas.drawLine(p1, p2, gridPaint);
      _drawText(canvas, '${f1.toInt()}Hz', Offset(width - padding + 4, p1.dy - 6), Colors.white38, 8.0);
    }

    for (double f2 = 800; f2 <= 2600; f2 += 400) {
      final p1 = project(minF1, f2);
      final p2 = project(maxF1, f2);
      canvas.drawLine(p1, p2, gridPaint);
      _drawText(canvas, '${f2.toInt()}Hz', Offset(p1.dx - 12, height - padding + 4), Colors.white38, 8.0);
    }

    // 2. Draw Target Vowels for Current Minimal Pair
    final vA = state.selectedExercise.vowelA;
    final vB = state.selectedExercise.vowelB;

    final ptA = project(vA.f1Hz, vA.f2Hz);
    final ptB = project(vB.f1Hz, vB.f2Hz);

    // Target ellipses representing acoustic target zones
    void drawTargetZone(Offset pt, FormantVowel v, bool isTarget) {
      final fillPaint = Paint()
        ..color = isTarget
            ? Colors.greenAccent.withOpacity(0.35)
            : Colors.amber.withOpacity(0.2)
        ..style = PaintingStyle.fill;
      canvas.drawOval(Rect.fromCenter(center: pt, width: 45, height: 35), fillPaint);

      final outlinePaint = Paint()
        ..color = isTarget ? Colors.greenAccent : Colors.amber.shade300
        ..style = PaintingStyle.stroke
        ..strokeWidth = isTarget ? 2.5 : 1.5;
      canvas.drawOval(Rect.fromCenter(center: pt, width: 45, height: 35), outlinePaint);

      _drawText(canvas, v.ipaSymbol, Offset(pt.dx - 10, pt.dy - 8), Colors.white, 12.0);
      _drawText(canvas, v.exampleWord, Offset(pt.dx - 14, pt.dy + 20), isTarget ? Colors.greenAccent : Colors.amberAccent, 9.0);
    }

    drawTargetZone(ptA, vA, state.targetIsWordA);
    drawTargetZone(ptB, vB, !state.targetIsWordA);

    // Connection vector between the contrasting minimal pair vowels
    final contrastLine = Paint()
      ..color = Colors.white38
      ..strokeWidth = 1.2;
    _drawDashedLine(canvas, ptA, ptB, contrastLine);

    // 3. Draw User's Current Voice Coordinate Marker (Live F1 / F2 point)
    final userPt = project(state.userCurrentF1Hz, state.userCurrentF2Hz);

    final userDotPaint = Paint()
      ..color = Colors.cyanAccent
      ..style = PaintingStyle.fill;
    canvas.drawCircle(userPt, 7.0, userDotPaint);

    final userPulsePaint = Paint()
      ..color = Colors.cyanAccent.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawCircle(userPt, 14.0, userPulsePaint);

    // Distance vector from user point to target
    final targetPt = state.targetIsWordA ? ptA : ptB;
    final distPaint = Paint()
      ..color = Colors.redAccent.withOpacity(0.8)
      ..strokeWidth = 1.5;
    canvas.drawLine(userPt, targetPt, distPaint);

    // Labels & Axis Titles
    _drawText(canvas, 'أَمَامِيٌّ (Front: High F2)', const Offset(36, 16), Colors.amberAccent, 10.0);
    _drawText(canvas, 'خَلْفِيٌّ (Back: Low F2)', Offset(width - 120, 16), Colors.amberAccent, 10.0);
    _drawText(canvas, 'مُغْلَقٌ (Close: Low F1)', Offset(width - 90, 36), Colors.white70, 9.0);
    _drawText(canvas, 'مَفْتُوحٌ (Open: High F1)', Offset(width - 90, height - 36), Colors.white70, 9.0);
  }

  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    const dashWidth = 5.0;
    const dashSpace = 4.0;
    final distance = (p2 - p1).distance;
    double current = 0.0;
    final unitVector = (p2 - p1) / distance;
    while (current < distance) {
      final start = p1 + unitVector * current;
      final end = p1 + unitVector * math.min(current + dashWidth, distance);
      canvas.drawLine(start, end, paint);
      current += dashWidth + dashSpace;
    }
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
  bool shouldRepaint(covariant FormantVowelChartPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
