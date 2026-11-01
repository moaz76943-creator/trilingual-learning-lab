import 'package:flutter/material.dart';

/// ويدجت أيقونة منضبط الأبعاد لمنع أي اهتزاز أو إعادة حساب للأبعاد أثناء التمرير السريع
class FittedSvgIcon extends StatelessWidget {
  final Widget child;
  final double size;
  final EdgeInsetsGeometry padding;

  const FittedSvgIcon({
    super.key,
    required this.child,
    this.size = 24.0,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: size,
        height: size,
        child: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
