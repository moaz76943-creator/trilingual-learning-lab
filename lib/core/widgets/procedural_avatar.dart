import 'dart:math';
import 'package:flutter/material.dart';

/// مولد الصور الرمزية الإجرائية Procedural Avatar Generator بحجم كود صفري
class ProceduralAvatar extends StatelessWidget {
  final String seed;
  final double size;

  const ProceduralAvatar({
    super.key,
    required this.seed,
    this.size = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: CustomPaint(
        size: Size(size, size),
        painter: _AvatarPainter(seed),
      ),
    );
  }
}

class _AvatarPainter extends CustomPainter {
  final String seed;

  _AvatarPainter(this.seed);

  @override
  void paint(Canvas canvas, Size size) {
    final hash = seed.hashCode.abs();
    final random = Random(hash);

    final hue1 = (random.nextDouble() * 360).roundToDouble();
    final hue2 = (hue1 + 45) % 360;

    final color1 = HSLColor.fromAHSL(1.0, hue1, 0.65, 0.85).toColor();
    final color2 = HSLColor.fromAHSL(1.0, hue2, 0.75, 0.45).toColor();

    final bgPaint = Paint()..color = color1;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final shapePaint = Paint()
      ..color = color2
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.3;

    canvas.drawCircle(center, radius, shapePaint);

    final innerPaint = Paint()..color = Colors.white.withOpacity(0.9);
    canvas.drawCircle(center, radius * 0.45, innerPaint);
  }

  @override
  bool shouldRepaint(covariant _AvatarPainter oldDelegate) =>
      oldDelegate.seed != seed;
}
