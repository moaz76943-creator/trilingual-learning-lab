import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../controllers/alkhazini_balance_controller.dart';

/// Screen presenting Al-Khazini's Balance of Wisdom (Mizan al-Hikma)
class AlKhaziniBalanceScreen extends StatefulWidget {
  final AlKhaziniBalanceController? controller;

  const AlKhaziniBalanceScreen({super.key, this.controller});

  @override
  State<AlKhaziniBalanceScreen> createState() => _AlKhaziniBalanceScreenState();
}

class _AlKhaziniBalanceScreenState extends State<AlKhaziniBalanceScreen> {
  late final AlKhaziniBalanceController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? AlKhaziniBalanceController();
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
              'مِيزَانُ الحِكْمَةِ لِلْخَازِنِيِّ (1121م)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Al-Khazini Hydrostatic Balance & Specific Gravity Studio',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shield_outlined),
            tooltip: 'كَشْفُ غِشِّ إِكْلِيلِ المَلِكِ (Legierungsanalyse)',
            onPressed: _controller.loadCrownAdulterationMystery,
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
          final sg = state.calculatedSpecificGravity;
          final goldGrams = state.calculatedGoldMassGrams;
          final silverGrams = state.calculatedSilverMassGrams;

          return Column(
            children: [
              _buildModeSelector(state),

              // Visual Hydrostatic Balance Canvas
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
                      painter: MizanAlHikmaPainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Hydrostatic Readout Card
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
                          labelAr: 'الوَزْنُ فِي الهَوَاءِ (W₁)',
                          labelEn: 'Weight in Air',
                          value: '${state.massInAirGrams.toStringAsFixed(1)} g',
                          color: Colors.amberAccent,
                        ),
                        _buildMetric(
                          labelAr: 'الوَزْنُ فِي المَاءِ (W₂)',
                          labelEn: 'Weight in Water',
                          value: '${state.massInWaterGrams.toStringAsFixed(1)} g',
                          color: Colors.cyanAccent,
                        ),
                        _buildMetric(
                          labelAr: 'الكَثَافَةُ النَّوْعِيَّةُ (SG)',
                          labelEn: 'Specific Gravity',
                          value: '${sg.toStringAsFixed(2)} g/cm³',
                          color: Colors.lightGreenAccent,
                        ),
                        if (state.mode == BalanceMode.alloyFraudDetection)
                          _buildMetric(
                            labelAr: 'نَقَاوَةُ الذَّهَبِ',
                            labelEn: 'Gold Purity',
                            value: '${state.goldPercentageInAlloy.toStringAsFixed(0)}%',
                            color: state.goldPercentageInAlloy > 90 ? Colors.greenAccent : Colors.orangeAccent,
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
                    if (state.mode == BalanceMode.alloyFraudDetection) ...[
                      // Gold Percentage Slider
                      Row(
                        children: [
                          const SizedBox(
                            width: 140,
                            child: Text('نِسْبَةُ الذَّهَبِ فِي السَّبِيكَةِ:'),
                          ),
                          Expanded(
                            child: Slider(
                              value: state.goldPercentageInAlloy,
                              min: 0.0,
                              max: 100.0,
                              divisions: 100,
                              label: '${state.goldPercentageInAlloy.toStringAsFixed(0)}%',
                              onChanged: _controller.setGoldPercentage,
                            ),
                          ),
                          Text('${state.goldPercentageInAlloy.toStringAsFixed(0)}% ذَهَب'),
                        ],
                      ),

                      // Adulteration Quantitative Verdict
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF451A03).withOpacity(0.35),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.amber.shade600, width: 1.0),
                        ),
                        child: Text(
                          'تَحْلِيلُ سَبِيكَةِ الخَازِنِيِّ: ذَهَبٌ خَالِصٌ = ${goldGrams.toStringAsFixed(1)} غِرَام | فِضَّةٌ مُضَافَةٌ = ${silverGrams.toStringAsFixed(1)} غِرَام',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.amberAccent),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ] else ...[
                      // Material Selector
                      DropdownButtonFormField<MetrologyMaterial>(
                        decoration: const InputDecoration(
                          labelText: 'المَعْدِنُ أَوِ الحَجَرُ الكَرِيمُ المَفْحُوصُ',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        ),
                        value: state.selectedMaterial,
                        items: MetrologyMaterial.values.map((mat) {
                          return DropdownMenuItem(
                            value: mat,
                            child: Text(
                              '${mat.nameAr} (${mat.historicalDensity} g/cm³)',
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) _controller.setMaterial(val);
                        },
                      ),
                    ],

                    const SizedBox(height: 6),

                    // Toggles
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FilterChip(
                          label: Text(state.isImmersedInWater ? 'المَعْدِنُ مَغْمُورٌ فِي المَاءِ' : 'المَعْدِنُ فِي الهَوَاءِ'),
                          selected: state.isImmersedInWater,
                          onSelected: (_) => _controller.toggleWaterImmersion(),
                        ),
                        FilterChip(
                          label: const Text('أَسْهُمُ قُوَّةِ الطَّفْوِ (Auftrieb)'),
                          selected: state.showBuoyancyVectors,
                          onSelected: (_) => _controller.toggleVectors(),
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
                        '«قَالَ الخَازِنِيُّ فِي كِتَابِ مِيزَانِ الحِكْمَةِ (1121م): إِنَّ الجِسْمَ المَغْمُورَ فِي المَاءِ يَنْقُصُ مِنْ وَزْنِهِ بِقَدْرِ وَزْنِ المَاءِ الَّذِي يُعَادِلُ حَجْمَهُ؛ وَبِذَلِكَ نَفْصِلُ بَيْنَ الذَّهَبِ الخَالِصِ وَالمَغْشُوشِ دُونَ حَرْقٍ أَوْ إِتْلافٍ!»',
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

  Widget _buildModeSelector(AlKhaziniBalanceState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SegmentedButton<BalanceMode>(
        segments: BalanceMode.values.map((mode) {
          return ButtonSegment<BalanceMode>(
            value: mode,
            label: Text(
              mode.nameAr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
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

/// Custom painter rendering Al-Khazini's Five-Pan Hydrostatic Balance (مِيزَانُ الحِكْمَةِ)
class MizanAlHikmaPainter extends CustomPainter {
  final AlKhaziniBalanceState state;

  MizanAlHikmaPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final fulcrum = Offset(width * 0.5, height * 0.28);

    // 1. Central Pillar and Fulcrum Stand (العَمُودُ وَالمِحْوَرُ الرَّئِيسِيُّ)
    final pillarPaint = Paint()
      ..color = const Color(0xFFD97706) // Golden bronze
      ..strokeWidth = 6.0;
    canvas.drawLine(Offset(fulcrum.dx, fulcrum.dy - 20), Offset(fulcrum.dx, height - 30), pillarPaint);

    final basePaint = Paint()..color = const Color(0xFF92400E);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(fulcrum.dx - 60, height - 30, 120, 16), const Radius.circular(6)),
      basePaint,
    );

    // Fulcrum Pivot Ring
    final pivotPaint = Paint()..color = Colors.amberAccent..style = PaintingStyle.fill;
    canvas.drawCircle(fulcrum, 8.0, pivotPaint);

    // 2. Calibrated Equal-Arm Beam (الشَّاهِينُ المُرَقَّمُ)
    const beamHalfLength = 135.0;
    final tiltRad = state.beamTiltAngleDeg * (math.pi / 180.0);

    final leftBeamEnd = Offset(
      fulcrum.dx - beamHalfLength * math.cos(tiltRad),
      fulcrum.dy - beamHalfLength * math.sin(tiltRad),
    );
    final rightBeamEnd = Offset(
      fulcrum.dx + beamHalfLength * math.cos(tiltRad),
      fulcrum.dy + beamHalfLength * math.sin(tiltRad),
    );

    final beamPaint = Paint()
      ..color = const Color(0xFFF59E0B)
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(leftBeamEnd, rightBeamEnd, beamPaint);

    // 3. Left Side: Counterweight Rider & Standard Weights Pan (كَفَّةُ الأَوْزَانِ الحِسِّيَّةِ)
    final cordPaint = Paint()..color = Colors.white70..strokeWidth = 1.2;
    final leftPanCenter = Offset(leftBeamEnd.dx, leftBeamEnd.dy + 80);

    canvas.drawLine(leftBeamEnd, Offset(leftPanCenter.dx - 18, leftPanCenter.dy), cordPaint);
    canvas.drawLine(leftBeamEnd, Offset(leftPanCenter.dx + 18, leftPanCenter.dy), cordPaint);

    // Left Pan Plate
    final panPaint = Paint()..color = const Color(0xFFB45309)..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(center: leftPanCenter, radius: 24.0),
      0,
      math.pi,
      true,
      panPaint,
    );

    // Counterweight placed on left pan
    final weightPaint = Paint()..color = Colors.amberAccent..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(leftPanCenter.dx - 10, leftPanCenter.dy - 16, 20, 16), weightPaint);

    // 4. Right Side: Specimen Pan & Water Vessel (كَفَّةُ المَاءِ المَغْمُورَةُ)
    final rightPanCenter = Offset(rightBeamEnd.dx, rightBeamEnd.dy + 80);

    canvas.drawLine(rightBeamEnd, Offset(rightPanCenter.dx - 18, rightPanCenter.dy), cordPaint);
    canvas.drawLine(rightBeamEnd, Offset(rightPanCenter.dx + 18, rightPanCenter.dy), cordPaint);

    // Glass/Bronze Water Vessel beneath right pan
    const vesselWidth = 70.0;
    const vesselHeight = 65.0;
    final vesselRect = Rect.fromLTWH(
      rightPanCenter.dx - (vesselWidth / 2),
      rightPanCenter.dy - 20,
      vesselWidth,
      vesselHeight,
    );

    if (state.isImmersedInWater) {
      final waterPaint = Paint()..color = const Color(0xFF0284C7).withOpacity(0.5);
      canvas.drawRect(vesselRect, waterPaint);

      final vesselOutline = Paint()
        ..color = Colors.cyanAccent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawRect(vesselRect, vesselOutline);
    }

    // Right Pan Plate
    canvas.drawArc(
      Rect.fromCircle(center: rightPanCenter, radius: 22.0),
      0,
      math.pi,
      true,
      panPaint,
    );

    // Specimen (Gold Bar / Crown / Gemstone) on right pan
    final specimenColor = (state.mode == BalanceMode.alloyFraudDetection)
        ? (state.goldPercentageInAlloy > 80 ? Colors.amberAccent : Colors.grey.shade300)
        : (state.selectedMaterial == MetrologyMaterial.ruby ? Colors.redAccent : Colors.amberAccent);

    final specimenPaint = Paint()..color = specimenColor..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(rightPanCenter.dx, rightPanCenter.dy - 10), 12.0, specimenPaint);

    // 5. Buoyancy Vector Arrows
    if (state.showBuoyancyVectors && state.isImmersedInWater) {
      // Gravity downwards (W_air)
      _drawVectorArrow(
        canvas,
        Offset(rightPanCenter.dx + 25, rightPanCenter.dy - 10),
        Offset(rightPanCenter.dx + 25, rightPanCenter.dy + 25),
        Colors.amberAccent,
        'W₁',
      );

      // Buoyancy upwards (F_buoyant)
      _drawVectorArrow(
        canvas,
        Offset(rightPanCenter.dx - 25, rightPanCenter.dy + 20),
        Offset(rightPanCenter.dx - 25, rightPanCenter.dy - 15),
        Colors.cyanAccent,
        'F_b',
      );
    }

    // Labels & Text Annotations
    _drawText(canvas, 'شَاهِينُ المِيزَانِ (Wagebalken)', Offset(fulcrum.dx - 55, fulcrum.dy - 28), Colors.amberAccent, 11.0);
    _drawText(canvas, 'كَفَّةُ الأَوْزَانِ (Air Pan)', Offset(leftPanCenter.dx - 35, leftPanCenter.dy + 12), Colors.white70, 9.0);
    _drawText(canvas, 'كَفَّةُ المَاءِ (Water Pan)', Offset(rightPanCenter.dx - 35, rightPanCenter.dy + 35), Colors.cyanAccent, 9.0);
    _drawText(canvas, 'مِيزَانُ الحِكْمَةِ لِلْخَازِنِيِّ (Al-Khazini Balance)', const Offset(16, 16), Colors.amberAccent, 12.0);
  }

  void _drawVectorArrow(Canvas canvas, Offset from, Offset to, Color color, String label) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(from, to, paint);

    final angle = math.atan2(to.dy - from.dy, to.dx - from.dx);
    const arrowLength = 7.0;
    const arrowAngle = 0.5;

    final p1 = Offset(
      to.dx - arrowLength * math.cos(angle - arrowAngle),
      to.dy - arrowLength * math.sin(angle - arrowAngle),
    );
    final p2 = Offset(
      to.dx - arrowLength * math.cos(angle + arrowAngle),
      to.dy - arrowLength * math.sin(angle + arrowAngle),
    );

    canvas.drawLine(to, p1, paint);
    canvas.drawLine(to, p2, paint);

    _drawText(canvas, label, Offset(to.dx + 6, to.dy - 6), color, 9.0);
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
  bool shouldRepaint(covariant MizanAlHikmaPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
