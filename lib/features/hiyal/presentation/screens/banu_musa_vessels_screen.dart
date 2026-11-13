import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../controllers/banu_musa_vessels_controller.dart';

/// Screen presenting Banu Musa's Trick Vessels & Cup of Justice
class BanuMusaVesselsScreen extends StatefulWidget {
  final BanuMusaVesselsController? controller;

  const BanuMusaVesselsScreen({super.key, this.controller});

  @override
  State<BanuMusaVesselsScreen> createState() => _BanuMusaVesselsScreenState();
}

class _BanuMusaVesselsScreenState extends State<BanuMusaVesselsScreen>
    with SingleTickerProviderStateMixin {
  late final BanuMusaVesselsController _controller;
  late final Ticker _ticker;
  Duration _lastTick = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? BanuMusaVesselsController();
    _ticker = createTicker((elapsed) {
      if (_lastTick != Duration.zero) {
        final dt = (elapsed - _lastTick).inMilliseconds / 1000.0;
        _controller.tick(dt);
      }
      _lastTick = elapsed;
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
              'حِيَلُ بَنِي مُوسَى: كَأْسُ العَدْلِ (850م)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Banu Musa Trick Vessels & Siphon Mechanics',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_controller.state.isPouringIn ? Icons.water_drop : Icons.water_drop_outlined),
            tooltip: 'صَبُّ الشَّرَابِ (Eingießen)',
            onPressed: _controller.togglePouring,
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
          final isDraining = state.isSiphonActive;

          return Column(
            children: [
              _buildVesselSelector(state),

              // Visual Siphon Canvas
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark Islamic brass workshop background
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDraining ? Colors.redAccent : Colors.amber.shade700,
                      width: 1.5,
                    ),
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
                      painter: CupOfJusticePainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Hydrostatic Readout Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: isDraining
                      ? Colors.red.shade900.withOpacity(0.35)
                      : const Color(0xFF1E293B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isDraining ? Colors.redAccent : Colors.amber.withOpacity(0.4),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMetric(
                          labelAr: 'حَجْمُ السَّائِلِ',
                          labelEn: 'Volume (ml)',
                          value: '${state.currentLiquidVolumeMl.toStringAsFixed(0)} ml',
                          color: state.isSafeZone ? Colors.cyanAccent : Colors.redAccent,
                        ),
                        _buildMetric(
                          labelAr: 'الحَالَةُ الهَيْدْرُولِيكِيَّةُ',
                          labelEn: 'Hydrostatic State',
                          value: isDraining ? 'تَفْرِيغٌ كُلِّيٌّ (Siphon)' : (state.isSafeZone ? 'حَدُّ العَدْلِ (Safe)' : 'فَيْضٌ جَشِعٌ'),
                          color: isDraining ? Colors.redAccent : (state.isSafeZone ? Colors.greenAccent : Colors.orangeAccent),
                        ),
                        _buildMetric(
                          labelAr: 'الضَّغْطُ فِي القَاعِ',
                          labelEn: 'Pressure (Pa)',
                          value: '${state.hydrostaticPressurePascal.toStringAsFixed(0)} Pa',
                          color: Colors.amberAccent,
                        ),
                        _buildMetric(
                          labelAr: 'مَرَّاتُ التَّفْرِيغِ',
                          labelEn: 'Total Drains',
                          value: '${state.totalDrainsTriggered}',
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Controls & Classical Lessons
              Expanded(
                flex: 4,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  children: [
                    // Volume Slider
                    Row(
                      children: [
                        const SizedBox(
                          width: 140,
                          child: Text('مَنْسُوبُ الشَّرَابِ فِي الكَأْسِ:'),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.currentLiquidVolumeMl,
                            min: 0.0,
                            max: state.maxCapacityMl,
                            divisions: 50,
                            label: '${state.currentLiquidVolumeMl.toStringAsFixed(0)} ml',
                            onChanged: _controller.setLiquidVolume,
                          ),
                        ),
                        Text('${state.currentLiquidVolumeMl.toStringAsFixed(0)} مل'),
                      ],
                    ),

                    // Siphon Threshold Slider
                    Row(
                      children: [
                        const SizedBox(
                          width: 140,
                          child: Text('حَدُّ عَتَبَةِ السَّيْفُونِ (العَدْل):'),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.siphonThresholdVolumeMl,
                            min: 150.0,
                            max: 450.0,
                            divisions: 30,
                            label: '${state.siphonThresholdVolumeMl.toStringAsFixed(0)} ml',
                            onChanged: _controller.setSiphonThreshold,
                          ),
                        ),
                        Text('${state.siphonThresholdVolumeMl.toStringAsFixed(0)} مل'),
                      ],
                    ),

                    // Quick Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.check_circle_outline, size: 16),
                          label: const Text('مِلْءٌ آمِنٌ (حَدُّ العَدْل)'),
                          onPressed: _controller.fillToSafeLimit,
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade900),
                          icon: const Icon(Icons.warning_amber, size: 16),
                          label: const Text('تَجَاوُزُ الحَدِّ (فَيْضُ الجَشَع)'),
                          onPressed: _controller.triggerGreedOverflow,
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Trilingual Classical Description Box
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF451A03).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.amber.shade700, width: 1.0),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'الحِكْمَةُ الهَنْدَسِيَّةُ مِنْ كِتَابِ الحِيَلِ لِبَنِي مُوسَى (850م):',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amberAccent),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '«إِذَا صَبَبْتَ فِي هَذَا الإِنَاءِ مِقْدَاراً مَعْلُوماً ثَبَتَ المَاءُ وَلَمْ يَخْرُجْ مِنْهُ شَيْءٌ؛ '
                            'فَإِذَا زِدْتَ عَلَيْهِ وَلَوْ قَطْرَةً وَاحِدَةً جَرَى المَاءُ كُلُّهُ مِنْ أَسْفَلِهِ حَتَّى لا يَبْقَى فِيهِ شَيْءٌ أَلْبَتَّةَ!»',
                            style: TextStyle(fontSize: 12, color: Colors.white70, height: 1.4),
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

  Widget _buildVesselSelector(BanuMusaVesselsState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SegmentedButton<BanuMusaVesselType>(
        segments: BanuMusaVesselType.values.map((type) {
          return ButtonSegment<BanuMusaVesselType>(
            value: type,
            label: Text(
              type.nameAr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
          );
        }).toList(),
        selected: {state.vesselType},
        onSelectionChanged: (set) => _controller.setVesselType(set.first),
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

/// Custom painter rendering Banu Musa's Cup of Justice with central concentric siphon
class CupOfJusticePainter extends CustomPainter {
  final BanuMusaVesselsState state;

  CupOfJusticePainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final center = Offset(width * 0.5, height * 0.48);

    // Cup dimensions
    const cupTopWidth = 180.0;
    const cupBottomWidth = 100.0;
    const cupHeight = 160.0;

    final cupTopY = center.dy - (cupHeight / 2);
    final cupBottomY = center.dy + (cupHeight / 2);

    // 1. Draw Cup Body (Chalice outline)
    final cupPath = Path();
    cupPath.moveTo(center.dx - (cupTopWidth / 2), cupTopY);
    cupPath.lineTo(center.dx - (cupBottomWidth / 2), cupBottomY);
    cupPath.lineTo(center.dx + (cupBottomWidth / 2), cupBottomY);
    cupPath.lineTo(center.dx + (cupTopWidth / 2), cupTopY);

    final cupPaint = Paint()
      ..color = const Color(0xFF78350F).withOpacity(0.4) // Antique bronze/glass
      ..style = PaintingStyle.fill;
    canvas.drawPath(cupPath, cupPaint);

    // Cup Pedestal and Base
    final basePaint = Paint()..color = const Color(0xFFD97706); // Golden brass
    canvas.drawRect(Rect.fromLTWH(center.dx - 18, cupBottomY, 36, 30), basePaint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(center.dx - 45, cupBottomY + 30, 90, 12), const Radius.circular(6)),
      basePaint,
    );

    // 2. Draw Liquid inside the Cup
    final liquidRatio = (state.currentLiquidVolumeMl / state.maxCapacityMl).clamp(0.0, 1.0);
    final liquidHeightPx = liquidRatio * cupHeight;
    final liquidTopY = cupBottomY - liquidHeightPx;

    if (liquidHeightPx > 0) {
      final liquidTopWidth = cupBottomWidth + (cupTopWidth - cupBottomWidth) * liquidRatio;
      final liquidPath = Path();
      liquidPath.moveTo(center.dx - (liquidTopWidth / 2), liquidTopY);
      liquidPath.lineTo(center.dx - (cupBottomWidth / 2), cupBottomY);
      liquidPath.lineTo(center.dx + (cupBottomWidth / 2), cupBottomY);
      liquidPath.lineTo(center.dx + (liquidTopWidth / 2), liquidTopY);
      liquidPath.close();

      final liquidPaint = Paint()
        ..color = state.isSiphonActive
            ? Colors.redAccent.withOpacity(0.7)
            : const Color(0xFF0284C7).withOpacity(0.75); // Blue water or red overflow
      canvas.drawPath(liquidPath, liquidPaint);
    }

    // 3. Central Siphon Column (القَصَبَةُ المَرْكَزِيَّةُ وَالغِطَاءُ المَقْلُوبُ)
    // Siphon apex height
    final thresholdRatio = (state.siphonThresholdVolumeMl / state.maxCapacityMl).clamp(0.0, 1.0);
    final siphonApexY = cupBottomY - (thresholdRatio * cupHeight);

    // Outer Siphon Cap (Closed at top, open at bottom)
    const capWidth = 32.0;
    final capRect = Rect.fromLTWH(center.dx - (capWidth / 2), siphonApexY - 8, capWidth, cupBottomY - siphonApexY + 4);
    final capPaint = Paint()
      ..color = const Color(0xFFB45309).withOpacity(0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawRect(capRect, capPaint);

    // Inner Pipe (Open at top and discharges out the bottom hole)
    const innerPipeWidth = 14.0;
    final innerPipeRect = Rect.fromLTWH(center.dx - (innerPipeWidth / 2), siphonApexY, innerPipeWidth, cupBottomY - siphonApexY + 40);
    final innerPaint = Paint()
      ..color = Colors.amberAccent
      ..style = PaintingStyle.fill;
    canvas.drawRect(innerPipeRect, innerPaint);

    // Discharge stream through bottom stem if siphon is active
    if (state.isSiphonActive) {
      final streamPaint = Paint()
        ..color = Colors.redAccent
        ..strokeWidth = 6.0
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(
        Offset(center.dx, cupBottomY + 40),
        Offset(center.dx, cupBottomY + 80),
        streamPaint,
      );
    }

    // 4. Threshold Calibration Mark (خَطُّ الكَفَافِ / العَدْلِ)
    final markPaint = Paint()
      ..color = Colors.yellowAccent
      ..strokeWidth = 2.0;
    _drawDashedLine(
      canvas,
      Offset(center.dx - (cupTopWidth / 2) + 10, siphonApexY),
      Offset(center.dx + (cupTopWidth / 2) - 10, siphonApexY),
      markPaint,
    );

    // 5. Cup Outline Frame
    final outlinePaint = Paint()
      ..color = const Color(0xFFF59E0B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawPath(cupPath, outlinePaint);

    // Labels & Annotations
    _drawText(canvas, 'حَدُّ العَدْلِ (Siphon Apex)', Offset(center.dx + (cupTopWidth / 2) - 15, siphonApexY - 14), Colors.yellowAccent, 10.0);
    _drawText(canvas, 'قَصَبَةُ السَّيْفُونِ المَرْكَزِيِّ', Offset(center.dx - 55, siphonApexY - 24), Colors.amberAccent, 10.0);
    _drawText(canvas, 'مَخْرَجُ التَّفْرِيغِ (Auslass)', Offset(center.dx + 25, cupBottomY + 50), Colors.redAccent, 10.0);
    _drawText(canvas, 'كَأْسُ العَدْلِ لِبَنِي مُوسَى (Banu Musa Cup)', const Offset(16, 16), Colors.amberAccent, 12.0);
  }

  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    const dashWidth = 6.0;
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
  bool shouldRepaint(covariant CupOfJusticePainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
