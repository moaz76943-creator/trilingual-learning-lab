import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../controllers/optics_ray_tracer_controller.dart';

/// Screen presenting Ibn al-Haytham's Optics Laboratory
class OpticsRayTracerScreen extends StatefulWidget {
  final OpticsRayTracerController? controller;

  const OpticsRayTracerScreen({super.key, this.controller});

  @override
  State<OpticsRayTracerScreen> createState() => _OpticsRayTracerScreenState();
}

class _OpticsRayTracerScreenState extends State<OpticsRayTracerScreen> {
  late final OpticsRayTracerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? OpticsRayTracerController();
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مُخْتَبَرُ المَنَاظِرِ لِابْنِ الهَيْثَمِ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Alhazen Optical Studio & Camera Obscura',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'إِعَادَةُ الضَّبْطِ (Zurücksetzen)',
            onPressed: _controller.resetDefaults,
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final state = _controller.state;
          return Column(
            children: [
              _buildModeSelector(state),
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark night/chamber backdrop
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amber.withOpacity(0.4), width: 1.5),
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
                    child: state.mode == OpticsMode.refraction
                        ? CustomPaint(
                            painter: RefractionRayPainter(state: state),
                            size: Size.infinite,
                          )
                        : CustomPaint(
                            painter: CameraObscuraPainter(state: state),
                            size: Size.infinite,
                          ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: state.mode == OpticsMode.refraction
                    ? _buildRefractionControls(context, state)
                    : _buildCameraObscuraControls(context, state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildModeSelector(OpticsRayTracerState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SegmentedButton<OpticsMode>(
        segments: OpticsMode.values.map((mode) {
          return ButtonSegment<OpticsMode>(
            value: mode,
            label: Text(
              mode.titleAr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          );
        }).toList(),
        selected: {state.mode},
        onSelectionChanged: (newSelection) {
          _controller.setMode(newSelection.first);
        },
      ),
    );
  }

  Widget _buildRefractionControls(BuildContext context, OpticsRayTracerState state) {
    final refracted = state.refractedAngleDeg;
    final isTIR = state.isTotalInternalReflection;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      children: [
        // Metric readout card
        Card(
          color: isTIR ? Colors.red.shade900.withOpacity(0.25) : Colors.blueGrey.shade900.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isTIR ? Colors.redAccent : Colors.teal.shade400,
              width: 1.2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildReadoutColumn(
                  labelAr: 'زَاوِيَةُ السُّقُوطِ (θ₁)',
                  labelEn: 'Incident Angle',
                  value: '${state.incidentAngleDeg.toStringAsFixed(1)}°',
                  color: Colors.amberAccent,
                ),
                _buildReadoutColumn(
                  labelAr: isTIR ? 'انْعِكَاسٌ كُلِّيٌّ دَاخِلِيٌّ' : 'زَاوِيَةُ الانْكِسَارِ (θ₂)',
                  labelEn: isTIR ? 'Total Internal Refl.' : 'Refracted Angle',
                  value: isTIR ? 'T.I.R.' : '${refracted!.toStringAsFixed(1)}°',
                  color: isTIR ? Colors.redAccent : Colors.lightGreenAccent,
                ),
                if (state.criticalAngleDeg != null)
                  _buildReadoutColumn(
                    labelAr: 'الزَّاوِيَةُ الحَرِجَةُ (θc)',
                    labelEn: 'Critical Angle',
                    value: '${state.criticalAngleDeg!.toStringAsFixed(1)}°',
                    color: Colors.cyanAccent,
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Angle Slider
        Row(
          children: [
            const Text('زَاوِيَةُ السُّقُوطِ:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: Slider(
                value: state.incidentAngleDeg,
                min: 0.0,
                max: 89.9,
                divisions: 180,
                label: '${state.incidentAngleDeg.toStringAsFixed(1)}°',
                onChanged: _controller.setIncidentAngle,
              ),
            ),
            Text('${state.incidentAngleDeg.toStringAsFixed(1)}°',
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),

        // Medium selection dropdowns
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<OpticalMedium>(
                decoration: const InputDecoration(
                  labelText: 'الوَسَطُ الأَوَّلُ (السَّاقِطُ)',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                value: state.incidentMedium,
                items: OpticalMedium.values.map((med) {
                  return DropdownMenuItem(
                    value: med,
                    child: Text('${med.nameAr} (n=${med.refractiveIndex})',
                        style: const TextStyle(fontSize: 12)),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) _controller.setIncidentMedium(val);
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.swap_horiz),
              tooltip: 'تَبْدِيلُ الأَوْسَاطِ (Tauschen)',
              onPressed: _controller.swapMediums,
            ),
            Expanded(
              child: DropdownButtonFormField<OpticalMedium>(
                decoration: const InputDecoration(
                  labelText: 'الوَسَطُ الثَّانِي (المُنْكَسِرُ)',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                value: state.refractiveMedium,
                items: OpticalMedium.values.map((med) {
                  return DropdownMenuItem(
                    value: med,
                    child: Text('${med.nameAr} (n=${med.refractiveIndex})',
                        style: const TextStyle(fontSize: 12)),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) _controller.setRefractiveMedium(val);
                },
              ),
            ),
          ],
        ),

        // Toggles
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FilterChip(
              label: const Text('الخَطُّ العَمُودِيُّ (Normale)'),
              selected: state.showNormalLine,
              onSelected: (_) => _controller.toggleNormalLine(),
            ),
            FilterChip(
              label: const Text('الشُّعَاعُ المُنْعَكِسُ (Reflexion)'),
              selected: state.showReflectedRay,
              onSelected: (_) => _controller.toggleReflectedRay(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCameraObscuraControls(BuildContext context, OpticsRayTracerState state) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      children: [
        // Camera Obscura Readout
        Card(
          color: Colors.brown.shade900.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.orangeAccent, width: 1.2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildReadoutColumn(
                  labelAr: 'ارْتِفَاعُ الصُّورَةِ المَقْلُوبَةِ',
                  labelEn: 'Inverted Image Height',
                  value: '${state.pinholeImageHeightCm.toStringAsFixed(1)} cm',
                  color: Colors.orangeAccent,
                ),
                _buildReadoutColumn(
                  labelAr: 'قُطْرُ دَائِرَةِ الضَّبَابِيَّةِ',
                  labelEn: 'Blur Circle Diameter',
                  value: '${state.blurCircleDiameterMm.toStringAsFixed(2)} mm',
                  color: Colors.yellowAccent,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Aperture Diameter
        Row(
          children: [
            const SizedBox(width: 140, child: Text('قُطْرُ الثَّقْبِ (Apertur):')),
            Expanded(
              child: Slider(
                value: state.apertureDiameterMm,
                min: 0.5,
                max: 10.0,
                divisions: 95,
                label: '${state.apertureDiameterMm.toStringAsFixed(1)} mm',
                onChanged: _controller.setApertureDiameter,
              ),
            ),
            Text('${state.apertureDiameterMm.toStringAsFixed(1)} mm'),
          ],
        ),

        // Object Distance
        Row(
          children: [
            const SizedBox(width: 140, child: Text('بُعْدُ الجِسْمِ (Abstand):')),
            Expanded(
              child: Slider(
                value: state.objectDistanceCm,
                min: 10.0,
                max: 200.0,
                divisions: 190,
                label: '${state.objectDistanceCm.toStringAsFixed(0)} cm',
                onChanged: _controller.setObjectDistance,
              ),
            ),
            Text('${state.objectDistanceCm.toStringAsFixed(0)} cm'),
          ],
        ),

        // Chamber Depth
        Row(
          children: [
            const SizedBox(width: 140, child: Text('عُمْقُ البَيْتِ المُظْلِمِ:')),
            Expanded(
              child: Slider(
                value: state.chamberDepthCm,
                min: 10.0,
                max: 100.0,
                divisions: 90,
                label: '${state.chamberDepthCm.toStringAsFixed(0)} cm',
                onChanged: _controller.setChamberDepth,
              ),
            ),
            Text('${state.chamberDepthCm.toStringAsFixed(0)} cm'),
          ],
        ),
      ],
    );
  }

  Widget _buildReadoutColumn({
    required String labelAr,
    required String labelEn,
    required String value,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          labelAr,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text(
          labelEn,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
      ],
    );
  }
}

/// Custom painter for Alhazen's Light Refraction across two mediums
class RefractionRayPainter extends CustomPainter {
  final OpticsRayTracerState state;

  RefractionRayPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final interfaceY = height * 0.5;
    final centerX = width * 0.5;

    // Draw Upper Medium (Incident)
    final paintUpper = Paint()..color = const Color(0xFF1E293B);
    canvas.drawRect(Rect.fromLTRB(0, 0, width, interfaceY), paintUpper);

    // Draw Lower Medium (Refractive)
    final paintLower = Paint()..color = const Color(0xFF0F3B4C);
    canvas.drawRect(Rect.fromLTRB(0, interfaceY, width, height), paintLower);

    // Draw Interface Line
    final interfacePaint = Paint()
      ..color = Colors.tealAccent
      ..strokeWidth = 2.0;
    canvas.drawLine(Offset(0, interfaceY), Offset(width, interfaceY), interfacePaint);

    // Draw Normal Line
    if (state.showNormalLine) {
      final normalPaint = Paint()
        ..color = Colors.white54
        ..strokeWidth = 1.2
        ..style = PaintingStyle.stroke;
      _drawDashedLine(canvas, Offset(centerX, 20), Offset(centerX, height - 20), normalPaint);
    }

    // Incident Ray
    final rayLength = math.min(width, height) * 0.42;
    final theta1Rad = state.incidentAngleDeg * (math.pi / 180.0);

    // Incident ray arrives from upper left towards (centerX, interfaceY)
    final startX = centerX - (rayLength * math.sin(theta1Rad));
    final startY = interfaceY - (rayLength * math.cos(theta1Rad));

    final incidentPaint = Paint()
      ..color = Colors.amberAccent
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(startX, startY), Offset(centerX, interfaceY), incidentPaint);
    _drawArrowHead(canvas, Offset(startX, startY), Offset(centerX, interfaceY), Colors.amberAccent);

    // Reflected Ray (Angle of incidence = Angle of reflection)
    if (state.showReflectedRay || state.isTotalInternalReflection) {
      final reflectX = centerX + (rayLength * math.sin(theta1Rad));
      final reflectY = interfaceY - (rayLength * math.cos(theta1Rad));

      final reflectPaint = Paint()
        ..color = state.isTotalInternalReflection ? Colors.redAccent : Colors.amber.withOpacity(0.5)
        ..strokeWidth = state.isTotalInternalReflection ? 3.0 : 1.5;
      canvas.drawLine(Offset(centerX, interfaceY), Offset(reflectX, reflectY), reflectPaint);
      _drawArrowHead(canvas, Offset(centerX, interfaceY), Offset(reflectX, reflectY), reflectPaint.color);
    }

    // Refracted Ray (if not TIR)
    final refractedDeg = state.refractedAngleDeg;
    if (refractedDeg != null) {
      final theta2Rad = refractedDeg * (math.pi / 180.0);
      final refractX = centerX + (rayLength * math.sin(theta2Rad));
      final refractY = interfaceY + (rayLength * math.cos(theta2Rad));

      final refractPaint = Paint()
        ..color = Colors.lightGreenAccent
        ..strokeWidth = 3.0
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(Offset(centerX, interfaceY), Offset(refractX, refractY), refractPaint);
      _drawArrowHead(canvas, Offset(centerX, interfaceY), Offset(refractX, refractY), Colors.lightGreenAccent);
    }

    // Labels for mediums
    _drawText(
      canvas,
      '${state.incidentMedium.nameAr} (${state.incidentMedium.nameEn}) n₁=${state.incidentMedium.refractiveIndex}',
      const Offset(16, 16),
      Colors.white70,
    );
    _drawText(
      canvas,
      '${state.refractiveMedium.nameAr} (${state.refractiveMedium.nameEn}) n₂=${state.refractiveMedium.refractiveIndex}',
      Offset(16, interfaceY + 16),
      Colors.cyanAccent,
    );
  }

  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    const dashWidth = 5.0;
    const dashSpace = 4.0;
    double distance = (p2 - p1).distance;
    double current = 0.0;
    final unitVector = (p2 - p1) / distance;
    while (current < distance) {
      final start = p1 + unitVector * current;
      final end = p1 + unitVector * math.min(current + dashWidth, distance);
      canvas.drawLine(start, end, paint);
      current += dashWidth + dashSpace;
    }
  }

  void _drawArrowHead(Canvas canvas, Offset from, Offset to, Color color) {
    final mid = Offset((from.dx + to.dx) / 2, (from.dy + to.dy) / 2);
    final angle = math.atan2(to.dy - from.dy, to.dx - from.dx);
    final arrowPaint = Paint()
      ..color = color
      ..strokeWidth = 2.0;

    const arrowLength = 10.0;
    const arrowAngle = 0.5;

    final p1 = Offset(
      mid.dx - arrowLength * math.cos(angle - arrowAngle),
      mid.dy - arrowLength * math.sin(angle - arrowAngle),
    );
    final p2 = Offset(
      mid.dx - arrowLength * math.cos(angle + arrowAngle),
      mid.dy - arrowLength * math.sin(angle + arrowAngle),
    );

    canvas.drawLine(mid, p1, arrowPaint);
    canvas.drawLine(mid, p2, arrowPaint);
  }

  void _drawText(Canvas canvas, String text, Offset offset, Color color) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.rtl,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant RefractionRayPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}

/// Custom painter for Ibn al-Haytham's Camera Obscura (البَيْتُ المُظْلِمُ)
class CameraObscuraPainter extends CustomPainter {
  final OpticsRayTracerState state;

  CameraObscuraPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final pinholeX = width * 0.45;
    final pinholeY = height * 0.5;
    final apertureRadius = (state.apertureDiameterMm * 1.5).clamp(2.0, 15.0);

    // Dark chamber wall (Chamber is on the right side)
    final chamberPaint = Paint()..color = const Color(0xFF030712);
    canvas.drawRect(Rect.fromLTRB(pinholeX, 20, width - 20, height - 20), chamberPaint);

    // Wall with pinhole
    final wallPaint = Paint()
      ..color = Colors.brown.shade700
      ..strokeWidth = 6.0;
    canvas.drawLine(Offset(pinholeX, 20), Offset(pinholeX, pinholeY - apertureRadius), wallPaint);
    canvas.drawLine(Offset(pinholeX, pinholeY + apertureRadius), Offset(pinholeX, height - 20), wallPaint);

    // Outside Candle / Object (on the left side)
    final objectX = pinholeX - (state.objectDistanceCm * (pinholeX - 40) / 200.0);
    final objectHeightPx = (state.objectHeightCm * 3.0).clamp(20.0, 120.0);
    final objectTopY = pinholeY - objectHeightPx;
    final objectBottomY = pinholeY;

    // Draw Candle body
    final candlePaint = Paint()..color = Colors.white70..strokeWidth = 8.0;
    canvas.drawLine(Offset(objectX, objectBottomY), Offset(objectX, objectTopY + 12), candlePaint);

    // Draw Candle Flame (emitting light)
    final flamePaint = Paint()..color = Colors.orangeAccent..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(objectX, objectTopY), 6.0, flamePaint);

    // Inverted Projection screen inside the chamber
    final screenX = pinholeX + (state.chamberDepthCm * (width - pinholeX - 40) / 100.0);
    final screenPaint = Paint()
      ..color = Colors.white30
      ..strokeWidth = 4.0;
    canvas.drawLine(Offset(screenX, 30), Offset(screenX, height - 30), screenPaint);

    // Ray 1: Top of candle (Flame) through pinhole to screen
    final flameTargetY = pinholeY + (pinholeY - objectTopY) * ((screenX - pinholeX) / (pinholeX - objectX));
    final ray1Paint = Paint()
      ..color = Colors.amberAccent
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(objectX, objectTopY), Offset(screenX, flameTargetY), ray1Paint);

    // Ray 2: Bottom of candle through pinhole to screen
    final baseTargetY = pinholeY + (pinholeY - objectBottomY) * ((screenX - pinholeX) / (pinholeX - objectX));
    final ray2Paint = Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(objectX, objectBottomY), Offset(screenX, baseTargetY), ray2Paint);

    // Draw Inverted Image on screen
    final invertedFlamePaint = Paint()..color = Colors.orangeAccent..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(screenX, flameTargetY), 5.0, invertedFlamePaint);

    final invertedBodyPaint = Paint()..color = Colors.white54..strokeWidth = 6.0;
    canvas.drawLine(Offset(screenX, baseTargetY), Offset(screenX, flameTargetY - 10), invertedBodyPaint);

    // Draw blur circle indicator around inverted flame
    final blurRadius = (state.blurCircleDiameterMm * 2.0).clamp(2.0, 20.0);
    final blurPaint = Paint()
      ..color = Colors.yellow.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(Offset(screenX, flameTargetY), blurRadius, blurPaint);

    // Labels
    _drawText(canvas, 'الجِسْمُ (الشَّمْعَةُ)', Offset(objectX - 30, objectTopY - 20), Colors.amberAccent);
    _drawText(canvas, 'الثَّقْبُ (Pinhole)', Offset(pinholeX - 40, pinholeY - apertureRadius - 20), Colors.white70);
    _drawText(canvas, 'الصُّورَةُ المَقْلُوبَةُ', Offset(screenX - 40, flameTargetY + 12), Colors.orangeAccent);
    _drawText(canvas, 'البَيْتُ المُظْلِمُ (Camera Obscura)', Offset(pinholeX + 20, 28), Colors.grey);
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
  bool shouldRepaint(covariant CameraObscuraPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
