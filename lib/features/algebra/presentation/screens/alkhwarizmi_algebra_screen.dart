import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../controllers/alkhwarizmi_algebra_controller.dart';

/// Screen presenting Al-Khwarizmi's Geometric Algebra Studio
class AlKhwarizmiAlgebraScreen extends StatefulWidget {
  final AlKhwarizmiAlgebraController? controller;

  const AlKhwarizmiAlgebraScreen({super.key, this.controller});

  @override
  State<AlKhwarizmiAlgebraScreen> createState() =>
      _AlKhwarizmiAlgebraScreenState();
}

class _AlKhwarizmiAlgebraScreenState extends State<AlKhwarizmiAlgebraScreen> {
  late final AlKhwarizmiAlgebraController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? AlKhwarizmiAlgebraController();
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
              'الجَبْرُ وَالمُقَابَلَةُ لِلْخُوَارِزْمِيِّ (820م)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Al-Khwarizmi Geometric Algebra & Completing the Square',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_edu),
            tooltip: 'مَسْأَلَةُ الخُوَارِزْمِيِّ التَّارِيخِيَّةُ (x² + 10x = 39)',
            onPressed: _controller.loadHistoricProblem39,
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
          final root = state.positiveRoot;

          return Column(
            children: [
              _buildEquationSelector(state),

              // Visual Geometric Canvas (Completing the Square)
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
                      painter: KhwarizmiGeometricSquarePainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Solution Readout Card
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
                          labelAr: 'الجَذْرُ / الشَّيْءُ (x)',
                          labelEn: 'Root (Shay)',
                          value: root != null ? root.toStringAsFixed(2) : 'لا يُوجَد',
                          color: Colors.greenAccent,
                        ),
                        _buildMetric(
                          labelAr: 'مِسَاحَةُ المَالِ (x²)',
                          labelEn: 'Square Area (Mal)',
                          value: root != null ? (root * root).toStringAsFixed(1) : '-',
                          color: Colors.amberAccent,
                        ),
                        _buildMetric(
                          labelAr: 'إِكْمَالُ المُرَبَّعِ (b/2)²',
                          labelEn: 'Added Area',
                          value: '${state.completingSquareArea.toStringAsFixed(2)}',
                          color: Colors.cyanAccent,
                        ),
                        _buildMetric(
                          labelAr: 'المُرَبَّعُ المُرَكَّبُ',
                          labelEn: 'Composite Area',
                          value: '${state.compositeTotalArea.toStringAsFixed(1)}',
                          color: Colors.orangeAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Controls & Classical Algebraic Steps
              Expanded(
                flex: 4,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  children: [
                    // Coefficient b Slider (Number of roots)
                    Row(
                      children: [
                        const SizedBox(
                          width: 140,
                          child: Text('عَدَدُ الأَجْذَارِ (الأَشْيَاء b):',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.bCoefficient,
                            min: 1.0,
                            max: 30.0,
                            divisions: 29,
                            label: '${state.bCoefficient.toStringAsFixed(0)}',
                            onChanged: _controller.setBCoefficient,
                          ),
                        ),
                        Text('${state.bCoefficient.toStringAsFixed(0)} جُذُور'),
                      ],
                    ),

                    // Constant c Slider (Number/area)
                    Row(
                      children: [
                        const SizedBox(
                          width: 140,
                          child: Text('العَدَدُ المُعْطَى (الدَّرَاهِم c):',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                        Expanded(
                          child: Slider(
                            value: state.cConstant,
                            min: 1.0,
                            max: 100.0,
                            divisions: 99,
                            label: '${state.cConstant.toStringAsFixed(0)}',
                            onChanged: _controller.setCConstant,
                          ),
                        ),
                        Text('${state.cConstant.toStringAsFixed(0)} دِرْهَماً'),
                      ],
                    ),

                    // Proof Method Selection
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: GeometricProofMethod.values.map((method) {
                        final isSelected = state.proofMethod == method;
                        return ChoiceChip(
                          label: Text(method.nameAr, style: const TextStyle(fontSize: 10)),
                          selected: isSelected,
                          onSelected: (_) => _controller.setProofMethod(method),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 6),

                    // Al-Khwarizmi's Classical Derivation Text Box
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF065F46).withOpacity(0.25),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.greenAccent.shade400, width: 1.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'نَصُّ قَاعِدَةِ الخُوَارِزْمِيِّ فِي الحِلِّ:',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.greenAccent),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '«نَصِّفِ الأَجْذَارَ (فَتَكُونُ ${state.bCoefficient / 2})، وَاضْرِبْهَا فِي مِثْلِهَا (تَصِيرُ ${state.completingSquareArea})، '
                            'فَزِدْهَا عَلَى العَدَدِ (${state.cConstant})، تَكُنْ (${state.compositeTotalArea})؛ فَخُذْ جَذْرَهَا (${state.compositeSquareSide.toStringAsFixed(2)})، '
                            'فَانْقُصْ مِنْهُ نِصْفَ الأَجْذَارِ (${state.bCoefficient / 2})، فَيَبْقَى (${root?.toStringAsFixed(2)}) وَهُوَ الشَّيْءُ المَطْلُوبُ!»',
                            style: const TextStyle(fontSize: 12, color: Colors.white70, height: 1.4),
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

  Widget _buildEquationSelector(AlKhwarizmiAlgebraState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: DropdownButtonFormField<KhwarizmiEquationType>(
        decoration: const InputDecoration(
          labelText: 'الصِّيَغُ السِّتُّ المُعْتَمَدَةُ عِنْدَ الخُوَارِزْمِيِّ',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        ),
        value: state.equationType,
        items: KhwarizmiEquationType.values.map((type) {
          return DropdownMenuItem(
            value: type,
            child: Text('${type.typeNumber}. ${type.nameAr}',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          );
        }).toList>,
        onChanged: (val) {
          if (val != null) _controller.setEquationType(val);
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
        Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: color)),
      ],
    );
  }
}

/// Custom painter rendering Al-Khwarizmi's geometric square dissection
class KhwarizmiGeometricSquarePainter extends CustomPainter {
  final AlKhwarizmiAlgebraState state;

  KhwarizmiGeometricSquarePainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final center = Offset(width * 0.5, height * 0.5);

    final root = state.positiveRoot ?? 3.0;
    final b = state.bCoefficient;

    // Visual scale factor to fit comfortably inside the canvas
    const maxDimensionPx = 180.0;
    final totalCompositeSide = root + (b / 2.0);
    final scale = maxDimensionPx / math.max(totalCompositeSide, 1.0);

    final xPx = (root * scale).clamp(40.0, 100.0);
    final flankPx = ((b / 4.0) * scale).clamp(15.0, 45.0);

    final halfComposite = (xPx + 2 * flankPx) / 2.0;
    final origin = Offset(center.dx - halfComposite, center.dy - halfComposite);

    if (state.proofMethod == GeometricProofMethod.alKhwarizmiFourCorners) {
      // 1. Central Square (المَالُ x²)
      final centralSquareRect = Rect.fromLTWH(origin.dx + flankPx, origin.dy + flankPx, xPx, xPx);
      final centralPaint = Paint()..color = const Color(0xFFD97706); // Golden Amber
      canvas.drawRect(centralSquareRect, centralPaint);

      // Outline
      final strokePaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      canvas.drawRect(centralSquareRect, strokePaint);

      _drawText(canvas, 'المَالُ\n(x²)', Offset(centralSquareRect.center.dx - 16, centralSquareRect.center.dy - 12), Colors.black, 11.0);

      // 2. Four Flank Rectangles (الأَشْيَاءُ / الجُذُورُ - x * (b/4))
      final flankPaint = Paint()..color = const Color(0xFF0284C7); // Sky Blue

      // Top flank
      final topRect = Rect.fromLTWH(origin.dx + flankPx, origin.dy, xPx, flankPx);
      canvas.drawRect(topRect, flankPaint);
      canvas.drawRect(topRect, strokePaint);

      // Bottom flank
      final bottomRect = Rect.fromLTWH(origin.dx + flankPx, origin.dy + flankPx + xPx, xPx, flankPx);
      canvas.drawRect(bottomRect, flankPaint);
      canvas.drawRect(bottomRect, strokePaint);

      // Left flank
      final leftRect = Rect.fromLTWH(origin.dx, origin.dy + flankPx, flankPx, xPx);
      canvas.drawRect(leftRect, flankPaint);
      canvas.drawRect(leftRect, strokePaint);

      // Right flank
      final rightRect = Rect.fromLTWH(origin.dx + flankPx + xPx, origin.dy + flankPx, flankPx, xPx);
      canvas.drawRect(rightRect, flankPaint);
      canvas.drawRect(rightRect, strokePaint);

      // 3. Four Corner Squares (إِكْمَالُ الأَرْكَانِ - (b/4)²)
      final cornerPaint = Paint()..color = const Color(0xFF10B981); // Emerald Green
      final cornerFillPaint = Paint()..color = const Color(0xFF059669);

      // Top-Left corner
      final c1 = Rect.fromLTWH(origin.dx, origin.dy, flankPx, flankPx);
      canvas.drawRect(c1, cornerFillPaint);
      canvas.drawRect(c1, strokePaint);

      // Top-Right corner
      final c2 = Rect.fromLTWH(origin.dx + flankPx + xPx, origin.dy, flankPx, flankPx);
      canvas.drawRect(c2, cornerFillPaint);
      canvas.drawRect(c2, strokePaint);

      // Bottom-Left corner
      final c3 = Rect.fromLTWH(origin.dx, origin.dy + flankPx + xPx, flankPx, flankPx);
      canvas.drawRect(c3, cornerFillPaint);
      canvas.drawRect(c3, strokePaint);

      // Bottom-Right corner
      final c4 = Rect.fromLTWH(origin.dx + flankPx + xPx, origin.dy + flankPx + xPx, flankPx, flankPx);
      canvas.drawRect(c4, cornerFillPaint);
      canvas.drawRect(c4, strokePaint);

      // Labels
      _drawText(canvas, 'رُكْنٌ (${(b/4).toStringAsFixed(1)})²', Offset(c1.center.dx - 18, c1.center.dy - 6), Colors.white, 8.0);
    } else {
      // Two-Flank Method (b/2)
      final flank2Px = ((b / 2.0) * scale).clamp(20.0, 70.0);
      final o2 = Offset(center.dx - (xPx + flank2Px) / 2.0, center.dy - (xPx + flank2Px) / 2.0);

      // Main Square x²
      final rMain = Rect.fromLTWH(o2.dx, o2.dy, xPx, xPx);
      canvas.drawRect(rMain, Paint()..color = const Color(0xFFD97706));
      _drawText(canvas, 'المَالُ (x²)', Offset(rMain.center.dx - 20, rMain.center.dy - 8), Colors.black, 11.0);

      // Right Flank Rectangle: x * (b/2)
      final rRight = Rect.fromLTWH(o2.dx + xPx, o2.dy, flank2Px, xPx);
      canvas.drawRect(rRight, Paint()..color = const Color(0xFF0284C7));
      _drawText(canvas, 'نِصْفُ الأَجْذَارِ\nx·(b/2)', Offset(rRight.center.dx - 22, rRight.center.dy - 12), Colors.white, 9.0);

      // Bottom Flank Rectangle: (b/2) * x
      final rBottom = Rect.fromLTWH(o2.dx, o2.dy + xPx, xPx, flank2Px);
      canvas.drawRect(rBottom, Paint()..color = const Color(0xFF0284C7));
      _drawText(canvas, 'نِصْفُ الأَجْذَارِ\n(b/2)·x', Offset(rBottom.center.dx - 22, rBottom.center.dy - 12), Colors.white, 9.0);

      // Corner Complement: (b/2)²
      final rCorner = Rect.fromLTWH(o2.dx + xPx, o2.dy + xPx, flank2Px, flank2Px);
      canvas.drawRect(rCorner, Paint()..color = const Color(0xFF10B981));
      _drawText(canvas, 'المُرَبَّعُ المُتَمِّمُ\n(b/2)²', Offset(rCorner.center.dx - 24, rCorner.center.dy - 12), Colors.white, 9.0);

      final p = Paint()..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = 1.5;
      canvas.drawRect(rMain, p);
      canvas.drawRect(rRight, p);
      canvas.drawRect(rBottom, p);
      canvas.drawRect(rCorner, p);
    }

    _drawText(canvas, 'المُرَبَّعُ الأَعْظَمُ المُكْتَمِلُ (Al-Khwarizmi Completing-the-Square)', const Offset(16, 16), Colors.amberAccent, 11.0);
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
  bool shouldRepaint(covariant KhwarizmiGeometricSquarePainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
