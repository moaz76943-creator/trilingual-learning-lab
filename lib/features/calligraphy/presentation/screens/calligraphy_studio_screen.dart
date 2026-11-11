import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../controllers/calligraphy_studio_controller.dart';

/// Full interactive Islamic proportioned script calligraphy studio screen.
class CalligraphyStudioScreen extends StatefulWidget {
  final CalligraphyStudioController controller;

  const CalligraphyStudioScreen({
    super.key,
    required this.controller,
  });

  @override
  State<CalligraphyStudioScreen> createState() => _CalligraphyStudioScreenState();
}

class _CalligraphyStudioScreenState extends State<CalligraphyStudioScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;
        final letter = ctrl.activeLetter;

        return Scaffold(
          backgroundColor: const Color(0xFFFDFBF7), // Parchment cream
          appBar: AppBar(
            title: const Text('مَخْبَرُ الخَطِّ المَنْسُوبِ (Calligraphy Studio)'),
            backgroundColor: const Color(0xFF1E1B18), // Ebony ink
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
                  // Letter Chips Selector
                  _buildLetterChips(ctrl),
                  const SizedBox(height: 16),
                  // Dynamic Proportioned Canvas
                  _buildCalligraphyCanvas(ctrl),
                  const SizedBox(height: 16),
                  // Proportional Telemetry Box
                  _buildProportionTelemetry(ctrl, letter),
                  const SizedBox(height: 16),
                  // View Toggles Card
                  _buildTogglesCard(ctrl),
                  const SizedBox(height: 16),
                  // Stroke Description Card
                  _buildStrokeCard(letter),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLetterChips(CalligraphyStudioController ctrl) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(CalligraphyStudioController.letters.length, (index) {
          final l = CalligraphyStudioController.letters[index];
          final isSelected = index == ctrl.activeLetterIndex;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text('${l.letterAr} (${l.nameAr.split(' ')[1]})', style: const TextStyle(fontSize: 16, fontFamily: 'Amiri')),
              selected: isSelected,
              selectedColor: const Color(0xFF1E1B18),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF334155),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              onSelected: (_) => ctrl.selectLetter(index),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCalligraphyCanvas(CalligraphyStudioController ctrl) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: const Color(0xFF2B2621), // Warm dark ink stone
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
          painter: _CalligraphyPainter(controller: ctrl),
          child: Container(),
        ),
      ),
    );
  }

  Widget _buildProportionTelemetry(CalligraphyStudioController ctrl, ProportionedLetterModel letter) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7).withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMetric('ارْتِفَاعُ النِّقَاطِ', '${letter.rhombicDotHeight} نِقَاطٍ', const Color(0xFF92400E)),
          Container(width: 1, height: 36, color: const Color(0xFFFCD34D)),
          _buildMetric('عَرْضُ القَاعِدَةِ', '${letter.rhombicDotWidth} نِقَاطٍ', const Color(0xFF92400E)),
          Container(width: 1, height: 36, color: const Color(0xFFFCD34D)),
          _buildMetric('زَاوِيَةُ القَطَّةِ', '${ctrl.nibSlantAngleDegrees.toStringAsFixed(0)}°', const Color(0xFF0F766E)),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF78350F))),
      ],
    );
  }

  Widget _buildTogglesCard(CalligraphyStudioController ctrl) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          SwitchListTile(
            dense: true,
            title: const Text('إِظْهَارُ النِّقَاطِ المَعِينِيَّةِ (Rhombic Dot Grid)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            value: ctrl.showRhombicGrid,
            activeColor: const Color(0xFFD97706),
            onChanged: (_) => ctrl.toggleRhombicGrid(),
          ),
          const Divider(height: 1),
          SwitchListTile(
            dense: true,
            title: const Text('دَائِرَةُ النِّسْبَةِ الأُمِّ (Proportion Circle)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            value: ctrl.showCircumscribedCircle,
            activeColor: const Color(0xFF0D9488),
            onChanged: (_) => ctrl.toggleCircumscribedCircle(),
          ),
        ],
      ),
    );
  }

  Widget _buildStrokeCard(ProportionedLetterModel letter) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: const [
              Icon(Icons.brush, color: Color(0xFFD97706), size: 18),
              SizedBox(width: 8),
              Text(
                'هَنْدَسَةُ مَسَارِ القَلَمِ (Stroke Anatomy):',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F172A)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            letter.strokeDescriptionAr,
            style: const TextStyle(fontSize: 15, fontFamily: 'Amiri', color: Color(0xFF1E293B)),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 6),
          Text(
            letter.strokeDescriptionDe,
            style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
          ),
          const SizedBox(height: 4),
          Text(
            letter.strokeDescriptionEn,
            style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }
}

class _CalligraphyPainter extends CustomPainter {
  final CalligraphyStudioController controller;

  _CalligraphyPainter({required this.controller});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2.0;
    final centerY = size.height / 2.0;

    final dotSize = 14.0;
    final dotPaint = Paint()
      ..color = const Color(0xFFF59E0B).withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final circlePaint = Paint()
      ..color = const Color(0xFF5EEAD4).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final strokePaint = Paint()
      ..color = const Color(0xFFFDFBF7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final letter = controller.activeLetter;

    // Draw Master Circle
    if (controller.showCircumscribedCircle) {
      canvas.drawCircle(Offset(centerX, centerY), 75.0 * letter.circleDiameterRatio, circlePaint);
    }

    // Draw Rhombic Dots Grid
    if (controller.showRhombicGrid) {
      final startY = centerY - (letter.rhombicDotHeight * dotSize) / 2.0;
      for (var i = 0; i < letter.rhombicDotHeight; i++) {
        _drawRhombicDot(canvas, centerX - 40, startY + (i * dotSize), dotSize * 0.7, dotPaint);
      }
    }

    // Draw Representative Proportioned Letter Stroke
    final path = Path();
    if (letter.letterId == 'letter_alef') {
      path.moveTo(centerX + 15, centerY - 60);
      path.lineTo(centerX + 15, centerY + 60);
    } else if (letter.letterId == 'letter_baa') {
      path.moveTo(centerX + 50, centerY - 10);
      path.lineTo(centerX + 50, centerY + 15);
      path.quadraticBezierTo(centerX, centerY + 30, centerX - 50, centerY + 15);
      path.lineTo(centerX - 50, centerY - 10);
    } else if (letter.letterId == 'letter_jeem') {
      path.moveTo(centerX - 30, centerY - 40);
      path.lineTo(centerX + 30, centerY - 40);
      path.quadraticBezierTo(centerX + 55, centerY + 10, centerX, centerY + 45);
      path.quadraticBezierTo(centerX - 45, centerY + 35, centerX - 40, centerY);
    } else {
      // Noon
      path.moveTo(centerX + 35, centerY - 15);
      path.quadraticBezierTo(centerX + 35, centerY + 40, centerX, centerY + 40);
      path.quadraticBezierTo(centerX - 35, centerY + 40, centerX - 35, centerY - 10);
    }

    canvas.drawPath(path, strokePaint);
  }

  void _drawRhombicDot(Canvas canvas, double cx, double cy, double radius, Paint paint) {
    final path = Path();
    path.moveTo(cx, cy - radius);
    path.lineTo(cx + radius, cy);
    path.lineTo(cx, cy + radius);
    path.lineTo(cx - radius, cy);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CalligraphyPainter oldDelegate) => true;
}
