import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../controllers/alkindi_cryptanalysis_controller.dart';

/// Screen presenting Al-Kindi's Frequency Analysis Studio
class AlKindiCryptanalysisScreen extends StatefulWidget {
  final AlKindiCryptanalysisController? controller;

  const AlKindiCryptanalysisScreen({super.key, this.controller});

  @override
  State<AlKindiCryptanalysisScreen> createState() =>
      _AlKindiCryptanalysisScreenState();
}

class _AlKindiCryptanalysisScreenState
    extends State<AlKindiCryptanalysisScreen> {
  late final AlKindiCryptanalysisController _controller;
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? AlKindiCryptanalysisController();
    _textEditingController =
        TextEditingController(text: _controller.state.cipherText);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
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
              'اسْتِخْرَاجُ المُعَمَّى لِيَعْقُوبَ الكِنْدِيِّ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Al-Kindi Cryptanalysis & Frequency Analysis Studio',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome),
            tooltip: 'كَشْفُ المِفْتَاحِ تِلْقَائِيّاً (Auto-Decipher Chi²)',
            onPressed: () {
              final best = _controller.autoDetectBestShift();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تَمَّ كَشْفُ المِفْتَاحِ: إِزَاحَةٌ بِمِقْدَارِ ($best) حُرُوفٍ.'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'إِعَادَةُ الضَّبْطِ',
            onPressed: () {
              _controller.reset();
              _textEditingController.text = _controller.state.cipherText;
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final state = _controller.state;

          return Column(
            children: [
              _buildLanguageSelector(state),

              // Frequency Histogram Canvas
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark parchment slate
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
                      painter: FrequencyHistogramPainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Statistics Card
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
                          labelAr: 'مِفْتَاحُ الإِزَاحَةِ (Key)',
                          labelEn: 'Shift Key',
                          value: '${state.shiftKey}',
                          color: Colors.amberAccent,
                        ),
                        _buildMetric(
                          labelAr: 'مُؤَشِّرُ التَّطَابُقِ (IoC)',
                          labelEn: 'Coincidence Index',
                          value: state.indexOfCoincidence.toStringAsFixed(4),
                          color: Colors.cyanAccent,
                        ),
                        _buildMetric(
                          labelAr: 'اخْتِبَارُ كَايْ التَّرْبِيعِيِّ (χ²)',
                          labelEn: 'Chi-Squared',
                          value: state.chiSquaredStatistic.toStringAsFixed(1),
                          color: state.chiSquaredStatistic < 50 ? Colors.greenAccent : Colors.orangeAccent,
                        ),
                        _buildMetric(
                          labelAr: 'عَدَدُ الحُرُوفِ',
                          labelEn: 'Total Letters',
                          value: '${state.totalLettersCount}',
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Controls & Deciphered Text Box
              Expanded(
                flex: 4,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  children: [
                    // Shift Key Slider
                    Row(
                      children: [
                        const SizedBox(
                          width: 140,
                          child: Text('مِفْتَاحُ قَيْصَرَ (Caesar-Verschiebung):',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.shiftKey.toDouble(),
                            min: 0,
                            max: (state.language.alphabet.length - 1).toDouble(),
                            divisions: state.language.alphabet.length - 1,
                            label: '${state.shiftKey}',
                            onChanged: (val) => _controller.setShiftKey(val.round()),
                          ),
                        ),
                        Text('${state.shiftKey}',
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),

                    // Ciphertext Input
                    TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        labelText: 'النَّصُّ المُعَمَّى (Chiffrierter Text)',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                      maxLines: 2,
                      onChanged: _controller.setCipherText,
                    ),

                    const SizedBox(height: 8),

                    // Deciphered Plaintext Box
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF064E3B).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.greenAccent.shade400, width: 1.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.lock_open, color: Colors.greenAccent, size: 16),
                              SizedBox(width: 6),
                              Text(
                                'النَّصُّ المَفْكُوكُ تِلْقَائِيّاً (Entschlüsselter Klartext):',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.greenAccent,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          SelectableText(
                            state.decipheredText,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
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

  Widget _buildLanguageSelector(AlKindiCryptanalysisState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SegmentedButton<CryptoLanguage>(
        segments: CryptoLanguage.values.map((lang) {
          return ButtonSegment<CryptoLanguage>(
            value: lang,
            label: Text(
              lang.nameAr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
          );
        }).toList(),
        selected: {state.language},
        onSelectionChanged: (set) {
          _controller.setLanguage(set.first);
          _textEditingController.text = _controller.state.cipherText;
        },
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

/// Custom Painter rendering side-by-side Frequency Histogram (Observed vs Reference)
class FrequencyHistogramPainter extends CustomPainter {
  final AlKindiCryptanalysisState state;

  FrequencyHistogramPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final paddingBottom = 30.0;
    final chartHeight = height - paddingBottom - 20.0;

    final alphabet = state.language.alphabet.split('');
    final numBars = alphabet.length;
    final barSlotWidth = width / numBars;
    final barWidth = barSlotWidth * 0.40;

    final observedFreqs = state.empiricalFrequencies;
    final referenceFreqs = state.language.frequencies;

    // Max frequency for Y-scale
    const maxFreq = 20.0; // 20% max scale

    // Draw baseline
    final axisPaint = Paint()
      ..color = Colors.white30
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(0, height - paddingBottom),
      Offset(width, height - paddingBottom),
      axisPaint,
    );

    for (int i = 0; i < numBars; i++) {
      final char = alphabet[i];
      final obsVal = observedFreqs[char] ?? 0.0;
      final refVal = referenceFreqs[char] ?? 0.0;

      final slotX = i * barSlotWidth;

      // Draw Reference Bar (Yellow/Amber, outline/dashed)
      final refBarHeight = (refVal / maxFreq) * chartHeight;
      final refBarRect = Rect.fromLTWH(
        slotX + 2,
        height - paddingBottom - refBarHeight,
        barWidth,
        refBarHeight,
      );
      final refPaint = Paint()
        ..color = Colors.amber.withOpacity(0.35)
        ..style = PaintingStyle.fill;
      canvas.drawRect(refBarRect, refPaint);

      // Draw Observed Bar (Cyan)
      final obsBarHeight = (obsVal / maxFreq) * chartHeight;
      final obsBarRect = Rect.fromLTWH(
        slotX + 2 + barWidth,
        height - paddingBottom - obsBarHeight,
        barWidth,
        obsBarHeight,
      );
      final obsPaint = Paint()
        ..color = Colors.cyanAccent.withOpacity(0.85)
        ..style = PaintingStyle.fill;
      canvas.drawRect(obsBarRect, obsPaint);

      // Draw Character Label at the bottom
      _drawText(
        canvas,
        char,
        Offset(slotX + (barSlotWidth / 2) - 4, height - paddingBottom + 6),
        Colors.white70,
        10.0,
      );
    }

    // Legend
    _drawLegend(canvas, const Offset(16, 12));
  }

  void _drawLegend(Canvas canvas, Offset offset) {
    // Reference legend
    final refPaint = Paint()..color = Colors.amber.withOpacity(0.5);
    canvas.drawRect(Rect.fromLTWH(offset.dx, offset.dy, 12, 12), refPaint);
    _drawText(canvas, 'تَرَدُّدَاتُ اللُّغَةِ المِعْيَارِيَّةُ (Referenz)', Offset(offset.dx + 16, offset.dy), Colors.amberAccent, 10.0);

    // Observed legend
    final obsPaint = Paint()..color = Colors.cyanAccent;
    canvas.drawRect(Rect.fromLTWH(offset.dx + 180, offset.dy, 12, 12), obsPaint);
    _drawText(canvas, 'تَرَدُّدَاتُ النَّصِّ المُعَمَّى (Beobachtet)', Offset(offset.dx + 196, offset.dy), Colors.cyanAccent, 10.0);
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
  bool shouldRepaint(covariant FrequencyHistogramPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
