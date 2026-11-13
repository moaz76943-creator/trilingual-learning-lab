import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../controllers/ibn_yunus_pendulum_controller.dart';

/// Screen presenting Ibn Yunus's Astronomical Pendulum & Taqi al-Din's Escapement
class IbnYunusPendulumScreen extends StatefulWidget {
  final IbnYunusPendulumController? controller;

  const IbnYunusPendulumScreen({super.key, this.controller});

  @override
  State<IbnYunusPendulumScreen> createState() => _IbnYunusPendulumScreenState();
}

class _IbnYunusPendulumScreenState extends State<IbnYunusPendulumScreen>
    with SingleTickerProviderStateMixin {
  late final IbnYunusPendulumController _controller;
  late final Ticker _ticker;
  Duration _lastTick = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? IbnYunusPendulumController();
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
              'نُوَّاسُ ابْنِ يُونُسَ وَمِفْلاتُ تَقِيِّ الدِّينِ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Ibn Yunus Astronomical Pendulum & Escapement Studio',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.timer_outlined),
            tooltip: 'بَنْدُولُ الثَّوَانِي المِعْيَارِيُّ (L = 0.994m)',
            onPressed: _controller.loadSecondsPendulumPreset,
          ),
          IconButton(
            icon: Icon(_controller.state.isSimulating ? Icons.pause_circle_filled : Icons.play_circle_filled),
            tooltip: 'تَشْغِيلُ / إِيقَافُ النُّوَّاسِ',
            onPressed: _controller.toggleSimulation,
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
          final period = state.exactPeriodSec;
          final bpm = state.beatsPerMinute;

          return Column(
            children: [
              _buildMechanismSelector(state),

              // Visual Horology Canvas
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark observatory slate
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
                      painter: AstronomicalPendulumPainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Horological Readout Card
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
                          labelAr: 'زَمَنُ الدَّوْرَةِ (T)',
                          labelEn: 'Period (sec)',
                          value: '${period.toStringAsFixed(3)} s',
                          color: Colors.cyanAccent,
                        ),
                        _buildMetric(
                          labelAr: 'دَقَّاتُ المِفْلاتِ/دَقِيقَة',
                          labelEn: 'Beats / Minute',
                          value: '${bpm.toStringAsFixed(1)} bpm',
                          color: Colors.amberAccent,
                        ),
                        _buildMetric(
                          labelAr: 'الزَّاوِيَةُ اللَّحْظِيَّةُ',
                          labelEn: 'Angle (θ)',
                          value: '${state.currentAngleDeg.toStringAsFixed(1)}°',
                          color: Colors.lightGreenAccent,
                        ),
                        _buildMetric(
                          labelAr: 'الدَّوْرَاتُ الكَامِلَةُ',
                          labelEn: 'Full Cycles',
                          value: '${state.totalOscillationCount}',
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
                    // Length Slider
                    Row(
                      children: [
                        const SizedBox(
                          width: 140,
                          child: Text('طُولُ النُّوَّاسِ الفَلَكِيِّ (L):'),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.pendulumLengthMeters,
                            min: 0.2,
                            max: 2.0,
                            divisions: 90,
                            label: '${state.pendulumLengthMeters.toStringAsFixed(3)} m',
                            onChanged: _controller.setPendulumLength,
                          ),
                        ),
                        Text('${state.pendulumLengthMeters.toStringAsFixed(2)} م'),
                      ],
                    ),

                    // Initial Amplitude Slider
                    Row(
                      children: [
                        const SizedBox(
                          width: 140,
                          child: Text('سِعَةُ الاِهْتِزَازِ البِدَائِيَّةِ (θ₀):'),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.initialAngleDeg,
                            min: 2.0,
                            max: 45.0,
                            divisions: 43,
                            label: '${state.initialAngleDeg.toStringAsFixed(0)}°',
                            onChanged: _controller.setInitialAngle,
                          ),
                        ),
                        Text('${state.initialAngleDeg.toStringAsFixed(0)}°'),
                      ],
                    ),

                    // Simulation Speed
                    Row(
                      children: [
                        const SizedBox(
                          width: 140,
                          child: Text('سُرْعَةُ المُحَاكَاةِ:'),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.simulationTimeScale,
                            min: 0.2,
                            max: 3.0,
                            divisions: 28,
                            label: '${state.simulationTimeScale.toStringAsFixed(1)}x',
                            onChanged: _controller.setTimeScale,
                          ),
                        ),
                        Text('${state.simulationTimeScale.toStringAsFixed(1)}x'),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Historical Citation Box
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F2E3A).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.cyanAccent.shade700, width: 1.0),
                      ),
                      child: const Text(
                        '«أَشَارَ المُؤَرِّخُونَ إِلَى أَنَّ الفَلَكِيَّ ابْنَ يُونُسَ المِصْرِيَّ (ت 1009م) كَانَ أَوَّلَ مَنِ اسْتَعْمَلَ حَرَكَةَ النُّوَّاسِ لِقِيَاسِ الأَزْمَانِ فِي المَرْصَدِ الحَاكِمِيِّ بِالقَاهِرَةِ، '
                        'وَتَبِعَهُ تَقِيُّ الدِّينِ (1577م) فِي اسْتِخْدَامِ المِفْلاتِ المِيكَانِيكِيِّ لِتَسْجِيلِ حَرَكَةِ الشَّمْسِ وَالقَمَرِ بِالدَّقَائِقِ وَالثَّوَانِي!»',
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

  Widget _buildMechanismSelector(IbnYunusPendulumState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SegmentedButton<HorologyMechanismType>(
        segments: HorologyMechanismType.values.map((type) {
          return ButtonSegment<HorologyMechanismType>(
            value: type,
            label: Text(
              type.nameAr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
          );
        }).toList(),
        selected: {state.mechanismType},
        onSelectionChanged: (set) => _controller.setMechanismType(set.first),
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

/// Custom painter rendering the harmonic pendulum, suspension bracket, and crown verge wheel
class AstronomicalPendulumPainter extends CustomPainter {
  final IbnYunusPendulumState state;

  AstronomicalPendulumPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final pivot = Offset(width * 0.5, height * 0.18);

    // 1. Suspension Bracket & Escapement Mount (المِحْوَرُ وَقَاعِدَةُ التَّثْبِيتِ)
    final bracketPaint = Paint()..color = const Color(0xFFD97706)..strokeWidth = 5.0;
    canvas.drawLine(Offset(pivot.dx - 30, pivot.dy), Offset(pivot.dx + 30, pivot.dy), bracketPaint);

    final pivotPinPaint = Paint()..color = Colors.amberAccent..style = PaintingStyle.fill;
    canvas.drawCircle(pivot, 7.0, pivotPinPaint);

    // 2. Crown Wheel (دُولابُ الإِكْلِيلِ - Verge Escapement) mounted above pivot
    final crownCenter = Offset(width * 0.5, height * 0.09);
    const crownRadius = 24.0;

    final crownWheelPaint = Paint()
      ..color = const Color(0xFFB45309)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawCircle(crownCenter, crownRadius, crownWheelPaint);

    // Rotating Crown Teeth
    final teethCount = state.crownWheelTeethCount;
    final rotRad = state.crownWheelRotationDeg * (math.pi / 180.0);
    final teethPaint = Paint()..color = Colors.amber.shade300..strokeWidth = 2.0;

    for (int i = 0; i < teethCount; i++) {
      final angle = rotRad + (i * 2 * math.pi / teethCount);
      final p1 = Offset(crownCenter.dx + crownRadius * math.cos(angle), crownCenter.dy + crownRadius * math.sin(angle));
      final p2 = Offset(crownCenter.dx + (crownRadius + 6) * math.cos(angle + 0.15), crownCenter.dy + (crownRadius + 6) * math.sin(angle + 0.15));
      canvas.drawLine(p1, p2, teethPaint);
    }

    // 3. Pendulum Rod & Bob (قَضِيبُ الرَّقَّاصِ وَالثِّقَلُ النُّحَاسِيُّ)
    final thetaRad = state.currentAngleDeg * (math.pi / 180.0);
    final visualLength = (state.pendulumLengthMeters / 2.0 * 180.0).clamp(80.0, 200.0);

    final bobX = pivot.dx + visualLength * math.sin(thetaRad);
    final bobY = pivot.dy + visualLength * math.cos(thetaRad);

    // Pendulum Rod
    final rodPaint = Paint()
      ..color = Colors.amber.shade200
      ..strokeWidth = 2.5;
    canvas.drawLine(pivot, Offset(bobX, bobY), rodPaint);

    // Pendulum Brass Bob
    final bobPaint = Paint()..color = const Color(0xFFF59E0B)..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(bobX, bobY), 16.0, bobPaint);

    final bobOutline = Paint()
      ..color = Colors.white70
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(Offset(bobX, bobY), 16.0, bobOutline);

    // 4. Equilibrium Vertical Line & Arc of Swing
    final normalPaint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 1.0;
    _drawDashedLine(canvas, pivot, Offset(pivot.dx, pivot.dy + visualLength + 20), normalPaint);

    // Arc of motion
    final arcPaint = Paint()
      ..color = Colors.cyanAccent.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final maxThetaRad = state.initialAngleDeg * (math.pi / 180.0);
    canvas.drawArc(
      Rect.fromCircle(center: pivot, radius: visualLength),
      (math.pi / 2.0) - maxThetaRad,
      2 * maxThetaRad,
      false,
      arcPaint,
    );

    // Labels & Text Annotations
    _drawText(canvas, 'دُولابُ الإِكْلِيلِ (Kronrad)', Offset(crownCenter.dx + crownRadius + 8, crownCenter.dy - 6), Colors.amberAccent, 10.0);
    _drawText(canvas, 'نُقْطَةُ التَّعْلِيقِ (Drehpunkt)', Offset(pivot.dx + 16, pivot.dy - 12), Colors.white70, 9.0);
    _drawText(canvas, 'ثِقَلُ النُّوَّاسِ النُّحَاسِيُّ', Offset(bobX + 20, bobY - 8), Colors.amberAccent, 10.0);
    _drawText(canvas, 'نُوَّاسُ ابْنِ يُونُسَ المِصْرِيِّ (Ibn Yunus Pendulum)', const Offset(16, 16), Colors.tealAccent, 12.0);
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
  bool shouldRepaint(covariant AstronomicalPendulumPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
