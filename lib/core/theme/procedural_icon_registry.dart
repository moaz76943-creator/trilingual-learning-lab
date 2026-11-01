import 'package:flutter/material.dart';

enum ActionIconType {
  flashcard,
  audio,
  quiz,
  book,
  lightbulb,
  clock,
}

/// سجل الأيقونات الإجرائية العامة التي ترسم مباشرة على Canvas دون ملفات خارجية
class ProceduralIconRegistry {
  static Widget buildActionIcon(
    ActionIconType type, {
    double size = 24.0,
    Color color = const Color(0xFF2E7D32),
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ActionIconPainter(type, color),
      ),
    );
  }
}

class _ActionIconPainter extends CustomPainter {
  final ActionIconType type;
  final Color color;

  _ActionIconPainter(this.type, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.42;

    switch (type) {
      case ActionIconType.flashcard:
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: center, width: size.width * 0.8, height: size.height * 0.6),
            const Radius.circular(4),
          ),
          paint,
        );
        break;
      case ActionIconType.audio:
      case ActionIconType.quiz:
      case ActionIconType.book:
      case ActionIconType.lightbulb:
      case ActionIconType.clock:
        canvas.drawCircle(center, radius, paint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant _ActionIconPainter oldDelegate) =>
      oldDelegate.type != type || oldDelegate.color != color;
}
