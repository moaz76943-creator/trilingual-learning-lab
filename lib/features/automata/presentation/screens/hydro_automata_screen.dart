import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../controllers/hydro_automata_controller.dart';

/// Screen presenting Al-Jazari's Water Clock & Automata Escapement
class HydroAutomataScreen extends StatefulWidget {
  final HydroAutomataController? controller;

  const HydroAutomataScreen({super.key, this.controller});

  @override
  State<HydroAutomataScreen> createState() => _HydroAutomataScreenState();
}

class _HydroAutomataScreenState extends State<HydroAutomataScreen>
    with SingleTickerProviderStateMixin {
  late final HydroAutomataController _controller;
  late final Ticker _ticker;
  Duration _lastElapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? HydroAutomataController();
    _ticker = createTicker((elapsed) {
      if (_lastElapsed != Duration.zero) {
        final dt = (elapsed - _lastElapsed).inMilliseconds / 1000.0;
        _controller.tick(dt);
      }
      _lastElapsed = elapsed;
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
              'آلَاتُ الحِيَلِ الهَيْدْرُولِيكِيَّةِ لِلْجَزَرِيِّ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Al-Jazari Hydro-Mechanical Automata Studio',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_controller.state.isSimulating
                ? Icons.pause_circle_filled
                : Icons.play_circle_filled),
            tooltip: 'تَشْغِيلُ / إِيقَافُ المُحَاكَاةِ',
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

          return Column(
            children: [
              _buildMechanismSelector(state),

              // Visual Simulation Canvas
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark Islamic brass workshop background
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amber.shade600, width: 1.5),
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
                      painter: AlJazariWaterClockPainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Status Bar
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
                          labelAr: 'امْتِلاءُ الطَّرْجَهَارَةِ',
                          labelEn: 'Fill Progress',
                          value: '${state.sinkProgressPercent.toStringAsFixed(1)}%',
                          color: Colors.cyanAccent,
                        ),
                        _buildMetric(
                          labelAr: 'دَوْرَاتُ التَّفْرِيغِ',
                          labelEn: 'Cycles Completed',
                          value: '${state.totalCyclesCompleted}',
                          color: Colors.amberAccent,
                        ),
                        _buildMetric(
                          labelAr: 'مُعَدَّلُ التَّدَفُّقِ (Q)',
                          labelEn: 'Inflow Rate',
                          value: '${state.inflowRateMlPerSec.toStringAsFixed(2)} ml/s',
                          color: Colors.lightGreenAccent,
                        ),
                        _buildMetric(
                          labelAr: 'سُرْعَةُ المُحَاكَاةِ',
                          labelEn: 'Speed Multiplier',
                          value: '${state.simulationSpeedMultiplier.toStringAsFixed(0)}x',
                          color: Colors.orangeAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Interactive Controls
              Expanded(
                flex: 4,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  children: [
                    // Orifice Diameter Slider
                    Row(
                      children: [
                        const SizedBox(
                          width: 140,
                          child: Text('قُطْرُ ثَقْبِ الطَّرْجَهَارَةِ:'),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.orificeDiameterMm,
                            min: 1.0,
                            max: 10.0,
                            divisions: 90,
                            label: '${state.orificeDiameterMm.toStringAsFixed(2)} mm',
                            onChanged: _controller.setOrificeDiameter,
                          ),
                        ),
                        Text('${state.orificeDiameterMm.toStringAsFixed(2)} ملم',
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),

                    // Bowl Volume Slider
                    Row(
                      children: [
                        const SizedBox(
                          width: 140,
                          child: Text('حَجْمُ الوِعَاءِ الطَّافِي:'),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.bowlVolumeMl,
                            min: 200.0,
                            max: 2000.0,
                            divisions: 90,
                            label: '${state.bowlVolumeMl.toStringAsFixed(0)} ml',
                            onChanged: _controller.setBowlVolume,
                          ),
                        ),
                        Text('${state.bowlVolumeMl.toStringAsFixed(0)} مل',
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),

                    // Speed Multiplier Slider
                    Row(
                      children: [
                        const SizedBox(
                          width: 140,
                          child: Text('مُضَاعَفَةُ الزَّمَنِ:'),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.simulationSpeedMultiplier,
                            min: 1.0,
                            max: 60.0,
                            divisions: 59,
                            label: '${state.simulationSpeedMultiplier.toStringAsFixed(0)}x',
                            onChanged: _controller.setSimulationSpeed,
                          ),
                        ),
                        Text('${state.simulationSpeedMultiplier.toStringAsFixed(0)}x'),
                      ],
                    ),

                    // Calibration Quick Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.timer_outlined, size: 16),
                          label: const Text('مُعَايَرَةُ نِصْفِ السَّاعَةِ (30 دَقِيقَة)'),
                          onPressed: () => _controller.autoCalibrateForTargetMinutes(30.0),
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.timer, size: 16),
                          label: const Text('مُعَايَرَةُ السَّاعَةِ (60 دَقِيقَة)'),
                          onPressed: () => _controller.autoCalibrateForTargetMinutes(60.0),
                        ),
                      ],
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

  Widget _buildMechanismSelector(HydroAutomataState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: SegmentedButton<AutomataMechanismType>(
        segments: AutomataMechanismType.values.map((type) {
          return ButtonSegment<AutomataMechanismType>(
            value: type,
            label: Text(
              type.nameAr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
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

/// Custom painter rendering Al-Jazari's Tarjahar reservoir, sinking bowl, pulley, and bird automaton
class AlJazariWaterClockPainter extends CustomPainter {
  final HydroAutomataState state;

  AlJazariWaterClockPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    // Workshop Background
    final bgPaint = Paint()..color = const Color(0xFF0F172A);
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), bgPaint);

    // Main Reservoir Tank (Left side of canvas)
    final tankX = width * 0.10;
    final tankY = height * 0.35;
    final tankWidth = width * 0.40;
    final tankHeight = height * 0.55;

    // Tank outline and water
    final tankOutline = Paint()
      ..color = Colors.amber.shade700
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;
    canvas.drawRect(Rect.fromLTWH(tankX, tankY, tankWidth, tankHeight), tankOutline);

    // Water level in tank
    final waterY = tankY + 30; // constant main head
    final waterPaint = Paint()..color = const Color(0xFF1E3A8A).withOpacity(0.7);
    canvas.drawRect(
      Rect.fromLTRB(tankX + 2, waterY, tankX + tankWidth - 2, tankY + tankHeight - 2),
      waterPaint,
    );

    // Floating Bowl (الطَّرْجَهَارَةُ)
    final bowlWidth = tankWidth * 0.65;
    final bowlHeight = 40.0;
    final bowlCenterX = tankX + (tankWidth / 2);

    // As bowl fills, it sinks down into the water
    final sinkOffset = state.fillFraction * (tankHeight - bowlHeight - 40);
    final bowlY = waterY + sinkOffset;

    // Draw Bowl Path (Archimedean hemisphere)
    final bowlPath = Path();
    bowlPath.moveTo(bowlCenterX - (bowlWidth / 2), bowlY);
    bowlPath.quadraticBezierTo(
      bowlCenterX,
      bowlY + bowlHeight + 10,
      bowlCenterX + (bowlWidth / 2),
      bowlY,
    );
    bowlPath.close();

    final bowlPaint = Paint()..color = const Color(0xFFD97706); // Golden brass
    canvas.drawPath(bowlPath, bowlPaint);

    // Water inside the bowl
    final internalWaterLevel = bowlY + bowlHeight - (state.fillFraction * bowlHeight);
    final insideWaterPaint = Paint()..color = Colors.cyanAccent.withOpacity(0.5);
    canvas.save();
    canvas.clipPath(bowlPath);
    canvas.drawRect(
      Rect.fromLTRB(bowlCenterX - bowlWidth, internalWaterLevel, bowlCenterX + bowlWidth, bowlY + bowlHeight + 20),
      insideWaterPaint,
    );
    canvas.restore();

    // Orifice jet stream at the bottom of the bowl
    final orificePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0;
    canvas.drawCircle(Offset(bowlCenterX, bowlY + bowlHeight), 2.5, orificePaint);
    if (state.fillFraction < 1.0) {
      canvas.drawLine(
        Offset(bowlCenterX, bowlY + bowlHeight),
        Offset(bowlCenterX, bowlY + bowlHeight - 8),
        orificePaint,
      );
    }

    // Pulley overhead and cord
    final pulleyX = bowlCenterX;
    final pulleyY = tankY - 30;
    final pulleyPaint = Paint()
      ..color = Colors.amberAccent
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(pulleyX, pulleyY), 12.0, pulleyPaint);

    // Cord from bowl center, over pulley, to bird/falcon automata on the right
    final cordPaint = Paint()
      ..color = Colors.white70
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(bowlCenterX, bowlY), Offset(pulleyX, pulleyY), cordPaint);

    // Escapement Gear / Dial on the right
    final dialCenterX = width * 0.75;
    final dialCenterY = height * 0.45;
    final dialRadius = 55.0;

    canvas.drawLine(Offset(pulleyX, pulleyY), Offset(dialCenterX, dialCenterY - dialRadius), cordPaint);

    // Draw Escapement Gear
    final gearPaint = Paint()
      ..color = const Color(0xFFB45309)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    canvas.drawCircle(Offset(dialCenterX, dialCenterY), dialRadius, gearPaint);

    // Rotating Escapement Pointer
    final rotRad = state.escapementRotationDeg * (math.pi / 180.0);
    final pointerX = dialCenterX + dialRadius * math.cos(rotRad);
    final pointerY = dialCenterY + dialRadius * math.sin(rotRad);
    final pointerPaint = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 3.0;
    canvas.drawLine(Offset(dialCenterX, dialCenterY), Offset(pointerX, pointerY), pointerPaint);

    // Falcon / Automaton releasing brass sphere at cycle trigger
    final falconX = width * 0.75;
    final falconY = height * 0.20;
    final falconPaint = Paint()..color = Colors.amber.shade300..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(falconX, falconY), 16.0, falconPaint);

    // Falling brass ball when cycle completes
    if (state.fillFraction > 0.90) {
      final ballY = falconY + (state.fillFraction - 0.90) * 400.0;
      final ballPaint = Paint()..color = Colors.yellowAccent..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(falconX, ballY), 6.0, ballPaint);
    }

    // Labels & Text
    _drawText(canvas, 'الطَّرْجَهَارَةُ الغَاطِسَةُ (Tarjahar)', Offset(bowlCenterX - 60, tankY + tankHeight + 8), Colors.amberAccent);
    _drawText(canvas, 'خَزَّانُ المَاءِ الرَّئِيسِيُّ (Wassertank)', Offset(tankX, tankY - 18), Colors.white70);
    _drawText(canvas, 'عَجَلَةُ المِفْلاتِ (Hemmungsrad)', Offset(dialCenterX - 50, dialCenterY + dialRadius + 8), Colors.cyanAccent);
    _drawText(canvas, 'دُمْيَةُ الصَّقْرِ لِقَذْفِ الكُرَاتِ', Offset(falconX - 45, falconY - 24), Colors.orangeAccent);
  }

  void _drawText(Canvas canvas, String text, Offset offset, Color color) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.rtl,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant AlJazariWaterClockPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
