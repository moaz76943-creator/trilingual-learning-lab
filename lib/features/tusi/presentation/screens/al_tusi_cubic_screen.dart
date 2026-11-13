import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../controllers/al_tusi_cubic_controller.dart';

/// Screen presenting Sharaf al-Din al-Tusi's Cubic Equations & Linear Astrolabe
class AlTusiCubicScreen extends StatefulWidget {
  final AlTusiCubicController? controller;

  const AlTusiCubicScreen({super.key, this.controller});

  @override
  State<AlTusiCubicScreen> createState() => _AlTusiCubicScreenState();
}

class _AlTusiCubicScreenState extends State<AlTusiCubicScreen> {
  late final AlTusiCubicController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? AlTusiCubicController();
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
              'مُعَادَلاتُ الطُّوسِيِّ التَّكْعِيبِيَّةُ (1209م)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Sharaf al-Din al-Tusi Cubic Extrema & Linear Astrolabe',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.functions),
            tooltip: 'مَسْأَلَةُ الطُّوسِيِّ التَّارِيخِيَّةُ (x³ + 16 = 12x)',
            onPressed: _controller.loadHistoricAlTusi16,
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
          final xMax = state.extremumX;
          final yMax = state.maximumValue;
          final hasRoots = state.hasRealPositiveRoots;
          final roots = state.positiveRoots;

          return Column(
            children: [
              _buildFormSelector(state),

              // Visual Cubic Plot / Staff Canvas
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark Islamic academy slate
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
                      painter: TusiCubicCurvePainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Extremum Readout Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: const Color(0xFF1E293B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: hasRoots ? Colors.greenAccent : Colors.redAccent,
                      width: 1.2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMetric(
                          labelAr: 'مَوْضِعُ الذِّرْوَةِ (x_max)',
                          labelEn: 'Extremum Point',
                          value: state.form == TusiCubicForm.linearAstrolabeStaff
                              ? '${state.solarAltitudeDeg.toStringAsFixed(1)}°'
                              : xMax.toStringAsFixed(2),
                          color: Colors.amberAccent,
                        ),
                        _buildMetric(
                          labelAr: 'القِيمَةُ العُظْمَى (f_max)',
                          labelEn: 'Maximum Value',
                          value: yMax.toStringAsFixed(2),
                          color: Colors.cyanAccent,
                        ),
                        _buildMetric(
                          labelAr: 'شَرْطُ الطُّوسِيِّ (f_max ≥ d)',
                          labelEn: 'Al-Tusi Condition',
                          value: hasRoots ? 'مُتَحَقِّقٌ (يُوجَدُ حَلٌّ)' : 'مُسْتَحِيلٌ (لا جُذُور)',
                          color: hasRoots ? Colors.greenAccent : Colors.redAccent,
                        ),
                        _buildMetric(
                          labelAr: 'الجُذُورُ المُوجَبَةُ',
                          labelEn: 'Positive Roots',
                          value: roots.isNotEmpty
                              ? roots.map((r) => r.toStringAsFixed(2)).join(', ')
                              : 'لا يُوجَد',
                          color: Colors.orangeAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Controls & Analysis View
              Expanded(
                flex: 4,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  children: [
                    if (state.form != TusiCubicForm.linearAstrolabeStaff) ...[
                      // Parameter b/c Slider
                      Row(
                        children: [
                          SizedBox(
                            width: 140,
                            child: Text(
                              state.form == TusiCubicForm.cubesAndNumbersEqualRoots
                                  ? 'مُعَامِلُ الأَجْذَارِ (b):'
                                  : 'مُعَامِلُ الأَمْوَالِ (c):',
                            ),
                          ),
                          Expanded(
                            child: Slider(
                              value: state.bCoefficient,
                              min: 2.0,
                              max: 30.0,
                              divisions: 28,
                              label: '${state.bCoefficient.toStringAsFixed(1)}',
                              onChanged: _controller.setBCoefficient,
                            ),
                          ),
                          Text('${state.bCoefficient.toStringAsFixed(1)}'),
                        ],
                      ),

                      // Parameter d Constant Slider
                      Row(
                        children: [
                          const SizedBox(
                            width: 140,
                            child: Text('العَدَدُ الثَّابِتُ (d):'),
                          ),
                          Expanded(
                            child: Slider(
                              value: state.dConstant,
                              min: 1.0,
                              max: 40.0,
                              divisions: 39,
                              label: '${state.dConstant.toStringAsFixed(1)}',
                              onChanged: _controller.setDConstant,
                            ),
                          ),
                          Text('${state.dConstant.toStringAsFixed(1)}'),
                        ],
                      ),
                    ] else ...[
                      // Solar Altitude Slider for Linear Astrolabe
                      Row(
                        children: [
                          const SizedBox(
                            width: 140,
                            child: Text('ارْتِفَاعُ الشَّمْسِ (θ):'),
                          ),
                          Expanded(
                            child: Slider(
                              value: state.solarAltitudeDeg,
                              min: 0.0,
                              max: 90.0,
                              divisions: 90,
                              label: '${state.solarAltitudeDeg.toStringAsFixed(1)}°',
                              onChanged: _controller.setSolarAltitude,
                            ),
                          ),
                          Text('${state.solarAltitudeDeg.toStringAsFixed(1)}°'),
                        ],
                      ),
                    ],

                    const SizedBox(height: 6),

                    // Toggles
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FilterChip(
                          label: const Text('إِبْرَازُ النِّهَايَةِ العُظْمَى (Extremum)'),
                          selected: state.showDerivativeExtremum,
                          onSelected: (_) => _controller.toggleExtremum(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Historical Citation Box
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF065F46).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.greenAccent.shade400, width: 1.0),
                      ),
                      child: Text(
                        '«قَالَ شَرَفُ الدِّينِ الطُّوسِيُّ (ت 1209م): إِذَا كَانَتْ غَايَةُ مَا يَبْلُغُهُ ضَرْبُ المَالِ فِي الشَّيْءِ مَعَ العَدَدِ أَصْغَرَ مِنْ كَعْبِهِ اسْتَحَالَ الجَبْرُ؛ '
                        'فَإِنْ سَاوَاهَا فَالجَذْرُ وَاحِدٌ، وَإِنْ زَادَ عَلَيْهَا فَلِلْمُعَادَلَةِ جَذْرَانِ مُوجَبَانِ!»',
                        style: const TextStyle(fontSize: 11, color: Colors.white70, height: 1.3),
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

  Widget _buildFormSelector(AlTusiCubicState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: DropdownButtonFormField<TusiCubicForm>(
        decoration: const InputDecoration(
          labelText: 'صِيغَةُ مُعَادَلَةِ الطُّوسِيِّ التَّكْعِيبِيَّةِ',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        ),
        value: state.form,
        items: TusiCubicForm.values.map((f) {
          return DropdownMenuItem(
            value: f,
            child: Text(
              '${f.typeNumber}. ${f.nameAr}',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
        onChanged: (val) {
          if (val != null) _controller.setForm(val);
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

/// Custom painter rendering Al-Tusi's cubic curve, local maximum, and root intersections
class TusiCubicCurvePainter extends CustomPainter {
  final AlTusiCubicState state;

  TusiCubicCurvePainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    if (state.form == TusiCubicForm.linearAstrolabeStaff) {
      _paintLinearAstrolabe(canvas, size);
      return;
    }

    final padding = 36.0;
    final chartWidth = width - (padding * 2);
    final chartHeight = height - (padding * 2);

    final xMax = state.extremumX;
    final maxXDomain = math.max(xMax * 2.5, 6.0);
    final maxYDomain = math.max(state.maximumValue * 1.3, state.dConstant * 1.3);

    Offset project(double x, double y) {
      final normX = (x / maxXDomain).clamp(0.0, 1.0);
      final normY = (y / maxYDomain).clamp(-0.2, 1.2);
      return Offset(
        padding + normX * chartWidth,
        height - padding - (normY * chartHeight),
      );
    }

    // 1. Coordinate Axes
    final axisPaint = Paint()
      ..color = Colors.white38
      ..strokeWidth = 1.5;

    final origin = project(0, 0);
    canvas.drawLine(Offset(origin.dx, padding), Offset(origin.dx, height - padding), axisPaint);
    canvas.drawLine(Offset(padding, origin.dy), Offset(width - padding, origin.dy), axisPaint);

    // 2. Horizontal Constant Line y = d (العَدَدُ الثَّابِتُ d)
    final dLinePaint = Paint()
      ..color = Colors.orangeAccent
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final dLeft = project(0, state.dConstant);
    final dRight = project(maxXDomain, state.dConstant);
    _drawDashedLine(canvas, dLeft, dRight, dLinePaint);
    _drawText(canvas, 'd = ${state.dConstant.toStringAsFixed(0)}', Offset(width - 55, dRight.dy - 12), Colors.orangeAccent, 10.0);

    // 3. Plot Cubic Curve f(x)
    final curvePath = Path();
    const steps = 120;
    for (int i = 0; i <= steps; i++) {
      final x = (i / steps) * maxXDomain;
      final y = state.evaluateFunction(x);
      final pt = project(x, y);
      if (i == 0) {
        curvePath.moveTo(pt.dx, pt.dy);
      } else {
        curvePath.lineTo(pt.dx, pt.dy);
      }
    }

    final curvePaint = Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    canvas.drawPath(curvePath, curvePaint);

    // 4. Highlight Al-Tusi's Local Extremum (الذِّرْوَةُ / النِّهَايَةُ العُظْمَى)
    if (state.showDerivativeExtremum) {
      final extremumPt = project(xMax, state.maximumValue);

      final extremumPaint = Paint()
        ..color = Colors.greenAccent
        ..style = PaintingStyle.fill;
      canvas.drawCircle(extremumPt, 6.0, extremumPaint);

      // Dropped vertical coordinate line to x-axis
      final dropPaint = Paint()
        ..color = Colors.greenAccent.withOpacity(0.5)
        ..strokeWidth = 1.0;
      _drawDashedLine(canvas, extremumPt, Offset(extremumPt.dx, origin.dy), dropPaint);

      _drawText(canvas, 'ذِرْوَةُ الطُّوسِيِّ (${xMax.toStringAsFixed(2)}, ${state.maximumValue.toStringAsFixed(1)})', Offset(extremumPt.dx - 40, extremumPt.dy - 16), Colors.greenAccent, 10.0);
    }

    // 5. Highlight Positive Roots (Intersecting Points)
    final roots = state.positiveRoots;
    for (final r in roots) {
      final rootPt = project(r, state.dConstant);
      final rootPaint = Paint()..color = Colors.amberAccent..style = PaintingStyle.fill;
      canvas.drawCircle(rootPt, 5.0, rootPaint);

      _drawText(canvas, 'جَذْرٌ: ${r.toStringAsFixed(2)}', Offset(rootPt.dx - 18, rootPt.dy + 8), Colors.amberAccent, 9.0);
    }

    _drawText(canvas, 'مُنْحَنَى دَالَّةِ الطُّوسِيِّ f(x)', const Offset(16, 16), Colors.amberAccent, 11.0);
  }

  void _paintLinearAstrolabe(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final center = Offset(width * 0.5, height * 0.5);

    // Draw Linear Astrolabe (عَصَا الطُّوسِيِّ - Staff of Al-Tusi)
    const staffLength = 260.0;
    const staffHeight = 16.0;
    final staffRect = Rect.fromLTWH(center.dx - (staffLength / 2), center.dy - (staffHeight / 2), staffLength, staffHeight);

    // Polished hardwood staff
    final woodPaint = Paint()..color = const Color(0xFF78350F)..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(staffRect, const Radius.circular(4)), woodPaint);

    // Brass graduations along the staff (تَقْسِيمَاتُ الدَّرَجَاتِ)
    final gradPaint = Paint()..color = Colors.amberAccent..strokeWidth = 1.0;
    for (int i = 0; i <= 26; i++) {
      final gx = staffRect.left + (i * 10);
      final gHeight = (i % 5 == 0) ? 10.0 : 5.0;
      canvas.drawLine(Offset(gx, staffRect.top), Offset(gx, staffRect.top + gHeight), gradPaint);
    }

    // Sighting Ring & Plumb Cord (خَيْطُ الشَّاقُولِ)
    final cordPivot = Offset(center.dx - 80, staffRect.bottom);
    final altRad = state.solarAltitudeDeg * (math.pi / 180.0);

    // Sightline directed at the sun
    final sightPaint = Paint()..color = Colors.yellowAccent..strokeWidth = 2.0;
    final sightEnd = Offset(cordPivot.dx + 120 * math.cos(altRad), cordPivot.dy - 120 * math.sin(altRad));
    canvas.drawLine(cordPivot, sightEnd, sightPaint);

    // Sun Icon at sightline tip
    final sunPaint = Paint()..color = Colors.orangeAccent..style = PaintingStyle.fill;
    canvas.drawCircle(sightEnd, 8.0, sunPaint);

    // Plumb bob hanging vertically downwards
    final plumbPaint = Paint()..color = Colors.cyanAccent..strokeWidth = 1.5;
    final plumbBob = Offset(cordPivot.dx, cordPivot.dy + 60);
    canvas.drawLine(cordPivot, plumbBob, plumbPaint);
    canvas.drawCircle(plumbBob, 5.0, Paint()..color = Colors.cyanAccent);

    // Labels
    _drawText(canvas, 'عَصَا الطُّوسِيِّ (الأَسْطُرْلابُ الخَطِّيّ)', Offset(staffRect.left, staffRect.top - 20), Colors.amberAccent, 12.0);
    _drawText(canvas, 'زَاوِيَةُ الِارتِفَاعِ: ${state.solarAltitudeDeg.toStringAsFixed(1)}°', Offset(cordPivot.dx + 25, cordPivot.dy - 35), Colors.yellowAccent, 10.0);
    _drawText(canvas, 'خَيْطُ الشَّاقُولِ', Offset(plumbBob.dx + 8, plumbBob.dy - 4), Colors.cyanAccent, 9.0);
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
  bool shouldRepaint(covariant TusiCubicCurvePainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
