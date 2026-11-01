import 'dart:math' as math;
import 'package:flutter/material.dart';

class GeometricPatternBackground extends StatelessWidget {
  final Widget child;
  final Color? patternColor;

  const GeometricPatternBackground({
    super.key,
    required this.child,
    this.patternColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = patternColor ?? (isDark ? Colors.white.withOpacity(0.04) : Colors.teal.withOpacity(0.05));

    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _IslamicGeometricPainter(patternColor: color),
          ),
        ),
        child,
      ],
    );
  }
}

class _IslamicGeometricPainter extends CustomPainter {
  final Color patternColor;
  _IslamicGeometricPainter({required this.patternColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = patternColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const tileSize = 60.0;
    for (double x = 0; x < size.width + tileSize; x += tileSize) {
      for (double y = 0; y < size.height + tileSize; y += tileSize) {
        _drawOctagram(canvas, Offset(x, y), tileSize * 0.45, paint);
      }
    }
  }

  void _drawOctagram(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (int i = 0; i < 8; i++) {
      final angle = i * math.pi / 4;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _IslamicGeometricPainter oldDelegate) => false;
}
