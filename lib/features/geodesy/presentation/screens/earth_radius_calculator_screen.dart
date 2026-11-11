import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../controllers/earth_radius_calculator_controller.dart';

/// Screen visualizing Al-Biruni's Earth Circumference and Horizon Dip method
class EarthRadiusCalculatorScreen extends StatefulWidget {
  final EarthRadiusCalculatorController? controller;

  const EarthRadiusCalculatorScreen({super.key, this.controller});

  @override
  State<EarthRadiusCalculatorScreen> createState() =>
      _EarthRadiusCalculatorScreenState();
}

class _EarthRadiusCalculatorScreenState extends State<EarthRadiusCalculatorScreen> {
  late final EarthRadiusCalculatorController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? EarthRadiusCalculatorController();
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
              'قِيَاسُ مُحِيطِ الأَرْضِ لِلْبِيرُونِيِّ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Al-Biruni Horizon Dip Geodesy Studio',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_edu),
            tooltip: 'تَحْمِيلُ بَيَانَاتِ نَنْدَنَة التَّارِيخِيَّةِ (1017م)',
            onPressed: _controller.loadNandanaHistorical,
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
          final radius = state.calculatedRadiusKm;
          final circumference = state.calculatedCircumferenceKm;
          final error = state.errorPercentageVsModern;

          return Column(
            children: [
              // Visual Canvas of Earth Curvature, Mountain Peak, Horizon Line
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B132B), // Deep atmospheric navy
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.amber.withOpacity(0.5),
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
                      painter: AlBiruniGeodesyPainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Readout Metrics Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: const Color(0xFF1C2541),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: error.abs() < 1.0 ? Colors.greenAccent : Colors.amberAccent,
                      width: 1.2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMetric(
                          labelAr: 'نِصْفُ القُطْرِ (R)',
                          labelEn: 'Radius',
                          value: '${radius.toStringAsFixed(1)} km',
                          color: Colors.cyanAccent,
                        ),
                        _buildMetric(
                          labelAr: 'مُحِيطُ الأَرْضِ (C)',
                          labelEn: 'Circumference',
                          value: '${circumference.toStringAsFixed(0)} km',
                          color: Colors.amberAccent,
                        ),
                        _buildMetric(
                          labelAr: 'الفَرْقُ عَنْ WGS-84',
                          labelEn: 'Error vs Modern',
                          value: '${error >= 0 ? "+" : ""}${error.toStringAsFixed(2)}%',
                          color: error.abs() < 1.0 ? Colors.lightGreenAccent : Colors.orangeAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Controls & Historical Benchmark Comparison
              Expanded(
                flex: 4,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  children: [
                    // Mountain Height (h) Slider
                    Row(
                      children: [
                        const SizedBox(
                          width: 130,
                          child: Text(
                            'ارْتِفَاعُ الجَبَلِ (h):',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.mountainHeightMeters,
                            min: 100.0,
                            max: 3000.0,
                            divisions: 290,
                            label: '${state.mountainHeightMeters.toStringAsFixed(1)} m',
                            onChanged: _controller.setMountainHeight,
                          ),
                        ),
                        Text(
                          '${state.mountainHeightMeters.toStringAsFixed(1)} م',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    // Horizon Dip Angle (alpha) Slider
                    Row(
                      children: [
                        const SizedBox(
                          width: 130,
                          child: Text(
                            'زَاوِيَةُ الانْحِطَاطِ (α):',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.dipAngleMinutes,
                            min: 10.0,
                            max: 60.0,
                            divisions: 100,
                            label: "${state.dipAngleMinutes.toStringAsFixed(1)}' (${state.dipAngleDegrees.toStringAsFixed(3)}°)",
                            onChanged: _controller.setDipAngleMinutes,
                          ),
                        ),
                        Text(
                          "${state.dipAngleMinutes.toStringAsFixed(1)} دقيقة",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const Divider(),

                    // Historical Benchmark Selector
                    const Text(
                      'مُقَارَنَةُ المَقَايِيسِ التَّارِيخِيَّةِ (Historischer Vergleich):',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: GeodeticBenchmark.values.map((bench) {
                        final isSelected = state.selectedBenchmark == bench;
                        return ChoiceChip(
                          label: Text(
                            bench.nameAr,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (_) => _controller.selectBenchmark(bench),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      state.selectedBenchmark.historicalContextAr,
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade400, fontStyle: FontStyle.italic),
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

  Widget _buildMetric({
    required String labelAr,
    required String labelEn,
    required String value,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(labelAr, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Text(labelEn, style: TextStyle(fontSize: 10, color: Colors.grey.shade400)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: color),
        ),
      ],
    );
  }
}

/// Custom painter illustrating Al-Biruni's geometric sight line from peak to horizon
class AlBiruniGeodesyPainter extends CustomPainter {
  final GeodesyCalculationState state;

  AlBiruniGeodesyPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    // Atmospheric gradient
    final skyRect = Rect.fromLTRB(0, 0, width, height);
    final skyPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF334155)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(skyRect);
    canvas.drawRect(skyRect, skyPaint);

    // Earth Sphere representation:
    // Earth center is positioned far below the screen to show realistic curvature
    final earthCenter = Offset(width * 0.5, height * 2.2);
    final earthRadiusPx = height * 1.6;

    // Draw Earth curved surface (Land and Sea)
    final earthPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, -0.6),
        radius: 1.2,
        colors: [const Color(0xFF1E40AF), const Color(0xFF065F46), const Color(0xFF064E3B)],
      ).createShader(Rect.fromCircle(center: earthCenter, radius: earthRadiusPx));

    canvas.drawCircle(earthCenter, earthRadiusPx, earthPaint);

    // Mountain peak located on the left side of Earth's crown
    const mountainAngle = -math.pi * 0.58; // slightly to the left of zenith
    final mountainBaseX = earthCenter.dx + earthRadiusPx * math.cos(mountainAngle);
    final mountainBaseY = earthCenter.dy + earthRadiusPx * math.sin(mountainAngle);

    // Mountain height in visual pixels (scaled representation)
    final mountainPeakPx = (state.mountainHeightMeters / 3000.0 * 60.0).clamp(25.0, 75.0);
    final peakX = mountainBaseX + mountainPeakPx * math.cos(mountainAngle);
    final peakY = mountainBaseY + mountainPeakPx * math.sin(mountainAngle);

    // Draw Mountain Silhouette
    final mountainPath = Path();
    mountainPath.moveTo(mountainBaseX - 35, mountainBaseY + 10);
    mountainPath.lineTo(peakX, peakY);
    mountainPath.lineTo(mountainBaseX + 35, mountainBaseY + 10);
    mountainPath.close();

    final mountainPaint = Paint()..color = const Color(0xFF78350F);
    canvas.drawPath(mountainPath, mountainPaint);

    final mountainOutline = Paint()
      ..color = Colors.amber.shade300
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawPath(mountainPath, mountainOutline);

    // Astrolabe / Al-Biruni figure at peak
    final observerPaint = Paint()..color = Colors.yellowAccent..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(peakX, peakY - 4), 4.0, observerPaint);

    // Horizontal reference line from peak (tangent to local zenith)
    final horizonRefPaint = Paint()
      ..color = Colors.white54
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final horizEndX = peakX + 220;
    final horizEndY = peakY;
    _drawDashedLine(canvas, Offset(peakX, peakY), Offset(horizEndX, horizEndY), horizonRefPaint);

    // Sight line dipped by angle alpha towards true sea horizon
    final dipRad = state.dipAngleRadians * 6.0; // Enhanced visual inclination for educational clarity
    final sightEndX = peakX + 260 * math.cos(dipRad);
    final sightEndY = peakY + 260 * math.sin(dipRad);

    final sightLinePaint = Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(peakX, peakY), Offset(sightEndX, sightEndY), sightLinePaint);

    // Horizon tangent point on Earth curvature
    final tangentPoint = Offset(peakX + 180, peakY + 180 * math.sin(dipRad) + 12);
    final tangentPaint = Paint()..color = Colors.redAccent..style = PaintingStyle.fill;
    canvas.drawCircle(tangentPoint, 5.0, tangentPaint);

    // Draw arc for angle alpha
    final arcPaint = Paint()
      ..color = Colors.amberAccent
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(peakX, peakY), radius: 50.0),
      0,
      dipRad,
      false,
      arcPaint,
    );

    // Annotations & Text Labels
    _drawText(canvas, 'قِمَّةُ الجَبَلِ (ذُرْوَة نَنْدَنَة)', Offset(peakX - 80, peakY - 24), Colors.amberAccent);
    _drawText(canvas, 'الأُفُقُ الحِسِّيُّ (Horizont)', Offset(horizEndX - 40, horizEndY - 16), Colors.white70);
    _drawText(canvas, 'خَطُّ النَّظَرِ المُنْحَطُّ (α)', Offset(peakX + 70, peakY + 12), Colors.cyanAccent);
    _drawText(canvas, 'نُقْطَةُ المُمَاسِّ لِلأُفُقِ الحَقِيقِيِّ', Offset(tangentPoint.dx - 40, tangentPoint.dy + 12), Colors.orangeAccent);
    _drawText(canvas, 'مُحِيطُ كُرَةِ الأَرْضِ (Al-Biruni Geodesy)', const Offset(20, 20), Colors.tealAccent);
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
  bool shouldRepaint(covariant AlBiruniGeodesyPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
