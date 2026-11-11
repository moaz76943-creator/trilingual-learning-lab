import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../controllers/geometric_pattern_controller.dart';

/// Full interactive Islamic geometric star pattern and mathematical studio screen.
class GeometricPatternScreen extends StatefulWidget {
  final GeometricPatternController controller;

  const GeometricPatternScreen({
    super.key,
    required this.controller,
  });

  @override
  State<GeometricPatternScreen> createState() => _GeometricPatternScreenState();
}

class _GeometricPatternScreenState extends State<GeometricPatternScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;
        final preset = ctrl.activePreset;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: const Text('مَخْبَرُ الهَنْدَسَةِ الإِسْلاَمِيَّةِ وَالتَّنَاظُرِ'),
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'إِعَادَةُ الضَّبْطِ',
                onPressed: ctrl.reset,
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Preset Selector Tabs
                  _buildPresetChips(ctrl),
                  const SizedBox(height: 16),
                  // Dynamic Vector Canvas
                  _buildPatternCanvas(ctrl),
                  const SizedBox(height: 16),
                  // Mathematical Telemetry Box
                  _buildMathTelemetry(ctrl, preset),
                  const SizedBox(height: 16),
                  // Construction Stage Stepper Controls
                  _buildConstructionStepper(ctrl),
                  const SizedBox(height: 16),
                  // Interactive Parameter Sliders
                  _buildSlidersCard(ctrl),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPresetChips(GeometricPatternController ctrl) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(GeometricPatternController.presets.length, (index) {
          final p = GeometricPatternController.presets[index];
          final isSelected = index == ctrl.activeFoldIndex;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text('${p.foldCount}-Fold (${p.nameAr.split(' ').first})'),
              selected: isSelected,
              selectedColor: const Color(0xFF0F172A),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF334155),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              onSelected: (_) => ctrl.selectPreset(index),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPatternCanvas(GeometricPatternController ctrl) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CustomPaint(
          painter: _StarPatternPainter(controller: ctrl),
          child: Container(),
        ),
      ),
    );
  }

  Widget _buildMathTelemetry(GeometricPatternController ctrl, StarPatternPreset preset) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF99F6E4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetric('زُمْرَةُ التَّنَاظُرِ', 'D_${ctrl.foldCount}', const Color(0xFF0F766E)),
              Container(width: 1, height: 36, color: const Color(0xFF99F6E4)),
              _buildMetric('زَاوِيَةُ الرَّأْسِ', '${ctrl.vertexTipAngleDegrees.toStringAsFixed(1)}°', const Color(0xFF0F766E)),
              Container(width: 1, height: 36, color: const Color(0xFF99F6E4)),
              _buildMetric('نِسْبَةُ القُطْرَيْنِ', ctrl.innerRadiusRatio.toStringAsFixed(3), const Color(0xFF2563EB)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            preset.historicalContextAr,
            style: const TextStyle(fontSize: 12, color: Color(0xFF134E4A), fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
      ],
    );
  }

  Widget _buildConstructionStepper(GeometricPatternController ctrl) {
    final stageNames = [
      'الدَّائِرَةُ الأُمُّ\n(Circumcircle)',
      'نِقَاطُ التَّقْسِيمِ\n(Division Points)',
      'شَبَكَةُ الأَوْتَارِ\n(Chords Grid)',
      'النَّجْمَةُ المُتَدَاخِلَةُ\n(Star Interlace)',
    ];

    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'مَرَاحِلُ البِنَاءِ بِالبِرْكَارِ وَالمِسْطَرَةِ (Construction Stages):',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F172A)),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(4, (index) {
              final isCurrent = index <= ctrl.constructionStage;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isCurrent ? const Color(0xFF0D9488) : const Color(0xFFF1F5F9),
                      foregroundColor: isCurrent ? Colors.white : const Color(0xFF64748B),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => ctrl.setConstructionStage(index),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 6),
          Text(
            stageNames[ctrl.constructionStage],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0D9488)),
          ),
        ],
      ),
    );
  }

  Widget _buildSlidersCard(GeometricPatternController ctrl) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('عُمْقُ النِّسْبَةِ الدَّاخِلِيَّةِ (Star Depth)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text(ctrl.innerRadiusRatio.toStringAsFixed(2), style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D9488))),
            ],
          ),
          Slider(
            value: ctrl.innerRadiusRatio,
            min: 0.20,
            max: 0.85,
            divisions: 65,
            activeColor: const Color(0xFF0D9488),
            onChanged: ctrl.setInnerRadiusRatio,
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('زَاوِيَةُ التَّدْوِيرِ (Rotation Angle)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text('${ctrl.rotationAngleDegrees.toStringAsFixed(0)}°', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
            ],
          ),
          Slider(
            value: ctrl.rotationAngleDegrees,
            min: 0.0,
            max: 360.0,
            divisions: 72,
            activeColor: const Color(0xFF2563EB),
            onChanged: ctrl.setRotation,
          ),
        ],
      ),
    );
  }
}

class _StarPatternPainter extends CustomPainter {
  final GeometricPatternController controller;

  _StarPatternPainter({required this.controller});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2.0;
    final centerY = size.height / 2.0;
    final outerRadius = math.min(centerX, centerY) * 0.82;

    final circlePaint = Paint()
      ..color = const Color(0xFF334155).withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final axisPaint = Paint()
      ..color = const Color(0xFF475569).withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final starPaint = Paint()
      ..color = const Color(0xFFF59E0B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final starFillPaint = Paint()
      ..color = const Color(0xFFF59E0B).withOpacity(0.12)
      ..style = PaintingStyle.fill;

    // Stage 0: Circumcircles
    if (controller.constructionStage >= 0) {
      canvas.drawCircle(Offset(centerX, centerY), outerRadius, circlePaint);
      canvas.drawCircle(Offset(centerX, centerY), outerRadius * controller.innerRadiusRatio, circlePaint);
      canvas.drawLine(Offset(centerX - outerRadius, centerY), Offset(centerX + outerRadius, centerY), axisPaint);
      canvas.drawLine(Offset(centerX, centerY - outerRadius), Offset(centerX, centerY + outerRadius), axisPaint);
    }

    final points = controller.calculateStarVertices(centerX, centerY, outerRadius);

    // Stage 1: Division points
    if (controller.constructionStage == 1) {
      final pointPaint = Paint()
        ..color = const Color(0xFF5EEAD4)
        ..style = PaintingStyle.fill;
      for (final pt in points) {
        canvas.drawCircle(Offset(pt.x, pt.y), 3.5, pointPaint);
      }
    }

    // Stage 2 & 3: Star polygon lines
    if (controller.constructionStage >= 2 && points.isNotEmpty) {
      final path = Path();
      path.moveTo(points.first.x, points.first.y);

      for (var i = 1; i < points.length; i++) {
        path.lineTo(points[i].x, points[i].y);
      }
      path.close();

      if (controller.constructionStage == 3) {
        canvas.drawPath(path, starFillPaint);
      }
      canvas.drawPath(path, starPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarPatternPainter oldDelegate) => true;
}
