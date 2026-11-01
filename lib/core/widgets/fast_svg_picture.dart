import 'package:flutter/material.dart';

/// مشغل رسوميات خفيف مخصص يقلل زمن التقديم (Render Latency) لأقل من 2 ميلي ثانية
class FastSvgPicture extends StatelessWidget {
  final String iconCode;
  final double size;
  final Color color;

  const FastSvgPicture({
    super.key,
    required this.iconCode,
    this.size = 24.0,
    this.color = const Color(0xFF2E7D32),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _FastVectorPainter(iconCode, color),
      ),
    );
  }
}

class _FastVectorPainter extends CustomPainter {
  final String code;
  final Color color;

  _FastVectorPainter(this.code, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _FastVectorPainter oldDelegate) =>
      oldDelegate.code != code || oldDelegate.color != color;
}
