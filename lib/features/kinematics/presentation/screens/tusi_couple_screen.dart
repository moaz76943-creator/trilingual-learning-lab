import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../controllers/tusi_couple_controller.dart';

/// Screen presenting Nasir al-Din al-Tusi Couple & Non-Ptolemaic Kinematics
class TusiCoupleScreen extends StatefulWidget {
  final TusiCoupleController? controller;

  const TusiCoupleScreen({super.key, this.controller});

  @override
  State<TusiCoupleScreen> createState() => _TusiCoupleScreenState();
}

class _TusiCoupleScreenState extends State<TusiCoupleScreen>
    with SingleTickerProviderStateMixin {
  late final TusiCoupleController _controller;
  late final Ticker _ticker;
  Duration _lastTick = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TusiCoupleController();
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
              'المُزْدَوِجَةُ الطُّوسِيَّةُ (مَرْصَدُ مَرَاغَة 1259م)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Tusi Couple & Maragha Planetary Kinematics Studio',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_controller.state.isSimulating ? Icons.pause_circle_filled : Icons.play_circle_filled),
            tooltip: 'تَشْغِيلُ / إِيقَافُ الدَّوَرَانِ',
            onPressed: _controller.toggleSimulation,
          ),
          IconButton(
            icon: const Icon(Icons.cleaning_services),
            tooltip: 'مَسْحُ المَسَارِ (Spur löschen)',
            onPressed: _controller.clearTrail,
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
          final pt = state.tracingPoint;
          final speed = state.speedMmSec;

          return Column(
            children: [
              _buildModeSelector(state),

              // Visual Kinematic Canvas
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark Maragha observatory slate
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
                      painter: TusiCoupleCanvasPainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Kinematic Metrics Readout
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
                          labelAr: 'الإِحْدَاثِيُّ السِّينِيُّ x(t)',
                          labelEn: 'X-Coordinate',
                          value: '${pt.dx.toStringAsFixed(1)} mm',
                          color: Colors.amberAccent,
                        ),
                        _buildMetric(
                          labelAr: 'الإِحْدَاثِيُّ الصَّادِيُّ y(t)',
                          labelEn: 'Y-Coordinate',
                          value: '${pt.dy.abs().toStringAsFixed(2)} mm',
                          color: pt.dy.abs() < 0.01 ? Colors.greenAccent : Colors.cyanAccent,
                        ),
                        _buildMetric(
                          labelAr: 'السُّرْعَةُ اللَّحْظِيَّةُ',
                          labelEn: 'Instant Speed',
                          value: '${speed.toStringAsFixed(1)} mm/s',
                          color: Colors.lightGreenAccent,
                        ),
                        _buildMetric(
                          labelAr: 'زَاوِيَةُ الدَّوَرَانِ (θ)',
                          labelEn: 'Rotation Angle',
                          value: '${state.rotationAngleThetaDeg.toStringAsFixed(0)}°',
                          color: Colors.orangeAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Controls & Parameters
              Expanded(
                flex: 4,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  children: [
                    // Point Offset Ratio (d/r) Slider
                    Row(
                      children: [
                        const SizedBox(
                          width: 140,
                          child: Text('مَوْقِعُ النُّقْطَةِ (d/r):'),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.pointOffsetRatio,
                            min: 0.0,
                            max: 1.5,
                            divisions: 30,
                            label: '${state.pointOffsetRatio.toStringAsFixed(2)}',
                            onChanged: _controller.setPointOffsetRatio,
                          ),
                        ),
                        Text(
                          state.pointOffsetRatio == 1.0 ? '1.0 (مُسْتَقِيمٌ)' : state.pointOffsetRatio.toStringAsFixed(2),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: state.pointOffsetRatio == 1.0 ? Colors.greenAccent : Colors.white,
                          ),
                        ),
                      ],
                    ),

                    // Rotation Speed Slider
                    Row(
                      children: [
                        const SizedBox(
                          width: 140,
                          child: Text('سُرْعَةُ الدَّوَرَانِ (RPM):'),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.angularSpeedRpm,
                            min: 2.0,
                            max: 40.0,
                            divisions: 38,
                            label: '${state.angularSpeedRpm.toStringAsFixed(0)} RPM',
                            onChanged: _controller.setAngularSpeedRpm,
                          ),
                        ),
                        Text('${state.angularSpeedRpm.toStringAsFixed(0)} د/د'),
                      ],
                    ),

                    // Toggles
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FilterChip(
                          label: const Text('سَهْمُ السُّرْعَةِ (Geschwindigkeit)'),
                          selected: state.showVelocityVector,
                          onSelected: (_) => _controller.toggleVelocityVector(),
                        ),
                        FilterChip(
                          label: const Text('المَسَارُ الجَيْبِيُّ (Harmonic Wave)'),
                          selected: state.showHarmonicWaveform,
                          onSelected: (_) => _controller.toggleHarmonicWaveform(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Historical Citation Box
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F2E3A).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.cyanAccent.shade700, width: 1.0),
                      ),
                      child: const Text(
                        '«بَرْهَنَ نَصِيرُ الدِّينِ الطُّوسِيُّ فِي التَّذْكِرَةِ (1259م) أَنَّ تَدَحْرُجَ دَائِرَةٍ دَاخِلَ أُخْرَى ضِعْفَ قُطْرِهَا يُوَلِّدُ حَرَكَةً مُسْتَقِيمَةً تَامَّةً؛ '
                        'وَهَذِهِ النَّظَرِيَّةُ هِيَ الَّتِي اعْتَمَدَ عَلَيْهَا كُوبِرْنِيكُوس فِي كِتَابِهِ حَوْلَ دَوَرَانِ الأَجْرَامِ السَّمَاوِيَّةِ!»',
                        style: TextStyle(fontSize: 11, color: Colors.white70, height: 1.3),
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

  Widget _buildModeSelector(TusiCoupleState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SegmentedButton<TusiCoupleMode>(
        segments: TusiCoupleMode.values.map((mode) {
          return ButtonSegment<TusiCoupleMode>(
            value: mode,
            label: Text(
              mode.nameAr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
          );
        }).toList(),
        selected: {state.mode},
        onSelectionChanged: (set) => _controller.setMode(set.first),
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

/// Custom painter rendering the Outer Circle, Rolling Inner Circle, and Linear Trajectory
class TusiCoupleCanvasPainter extends CustomPainter {
  final TusiCoupleState state;

  TusiCoupleCanvasPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final center = Offset(width * 0.5, height * 0.5);

    final R = state.outerRadiusR;
    final r = state.innerRadiusR;

    // 1. Draw Outer Stationary Circle (الدَّائِرَةُ الكُبْرَى الثَّابِتَةُ - قُطْرُهَا 2R)
    final outerCirclePaint = Paint()
      ..color = const Color(0xFFD97706).withOpacity(0.85) // Bronze ring
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawCircle(center, R, outerCirclePaint);

    // Diameter Line of Motion (Horizontal Axis where P oscillates)
    final axisPaint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 1.2;
    canvas.drawLine(Offset(center.dx - R - 15, center.dy), Offset(center.dx + R + 15, center.dy), axisPaint);
    canvas.drawLine(Offset(center.dx, center.dy - R - 15), Offset(center.dx, center.dy + R + 15), axisPaint);

    // 2. Trajectory Trail of Point P
    final trailPaint = Paint()
      ..color = Colors.cyanAccent.withOpacity(0.6)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final trailPath = Path();
    for (int i = 0; i < state.trajectoryHistory.length; i++) {
      final pt = state.trajectoryHistory[i];
      final canvasPt = Offset(center.dx + pt.dx, center.dy + pt.dy);
      if (i == 0) {
        trailPath.moveTo(canvasPt.dx, canvasPt.dy);
      } else {
        trailPath.lineTo(canvasPt.dx, canvasPt.dy);
      }
    }
    canvas.drawPath(trailPath, trailPaint);

    // 3. Draw Rolling Inner Circle (الدَّائِرَةُ الصُّغْرَى المُتَدَحْرِجَةُ - نِصْفُ قُطْرِهَا r = R/2)
    final innerCenterRel = state.innerCenter;
    final innerCenterCanvas = Offset(center.dx + innerCenterRel.dx, center.dy + innerCenterRel.dy);

    final innerCirclePaint = Paint()
      ..color = const Color(0xFF0284C7).withOpacity(0.35)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(innerCenterCanvas, r, innerCirclePaint);

    final innerStrokePaint = Paint()
      ..color = Colors.lightBlueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(innerCenterCanvas, r, innerStrokePaint);

    // Inner circle center dot
    canvas.drawCircle(innerCenterCanvas, 3.5, Paint()..color = Colors.white);

    // 4. Contact Point of Rolling (نُقْطَةُ التَّمَاسِّ مَعَ الدَّائِرَةِ الكُبْرَى)
    final contactAngle = state.thetaRad;
    final contactPoint = Offset(center.dx + R * math.cos(contactAngle), center.dy + R * math.sin(contactAngle));
    canvas.drawCircle(contactPoint, 4.0, Paint()..color = Colors.orangeAccent);

    // Spoke from inner center to point P
    final ptRel = state.tracingPoint;
    final ptCanvas = Offset(center.dx + ptRel.dx, center.dy + ptRel.dy);

    final spokePaint = Paint()
      ..color = Colors.amberAccent
      ..strokeWidth = 1.5;
    canvas.drawLine(innerCenterCanvas, ptCanvas, spokePaint);

    // 5. Tracing Point P (النُّقْطَةُ الرَّاسِمَةُ لِلْحَرَكَةِ الخَطِّيَّةِ)
    final pPaint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.fill;
    canvas.drawCircle(ptCanvas, 6.5, pPaint);

    final pOutline = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawCircle(ptCanvas, 6.5, pOutline);

    // 6. Instantaneous Velocity Vector
    if (state.showVelocityVector) {
      final v = state.velocityVector;
      final vScale = 0.4;
      final arrowEnd = Offset(ptCanvas.dx + (v.dx * vScale), ptCanvas.dy + (v.dy * vScale));

      final arrowPaint = Paint()
        ..color = Colors.redAccent
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(ptCanvas, arrowEnd, arrowPaint);

      // Arrow head
      final angle = math.atan2(v.dy, v.dx);
      const headLen = 8.0;
      final a1 = Offset(arrowEnd.dx - headLen * math.cos(angle - 0.4), arrowEnd.dy - headLen * math.sin(angle - 0.4));
      final a2 = Offset(arrowEnd.dx - headLen * math.cos(angle + 0.4), arrowEnd.dy - headLen * math.sin(angle + 0.4));
      canvas.drawLine(arrowEnd, a1, arrowPaint);
      canvas.drawLine(arrowEnd, a2, arrowPaint);
    }

    // Text Annotations & Labels
    _drawText(canvas, 'الدَّائِرَةُ الكُبْرَى (R = 2r)', Offset(center.dx - R, center.dy - R - 18), Colors.amberAccent, 11.0);
    _drawText(canvas, 'نُقْطَةُ الطُّوسِيِّ P (تَسِيرُ خَطِّيّاً)', Offset(ptCanvas.dx - 40, ptCanvas.dy + 12), Colors.greenAccent, 10.0);
    _drawText(canvas, 'نُقْطَةُ التَّمَاسِّ (Rollpunkt)', Offset(contactPoint.dx + 8, contactPoint.dy - 6), Colors.orangeAccent, 9.0);
    _drawText(canvas, 'المُزْدَوِجَةُ الطُّوسِيَّةُ (Tusi Couple)', const Offset(16, 16), Colors.tealAccent, 12.0);
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
  bool shouldRepaint(covariant TusiCoupleCanvasPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
