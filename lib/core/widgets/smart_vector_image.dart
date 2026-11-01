import 'package:flutter/material.dart';
import '../assets/asset_resolver.dart';
import '../cache/vector_cache_manager.dart';

/// مكون العرض المتجهي الذكي SmartVectorImage مع دعم الكاش والبدائل التلقائية
class SmartVectorImage extends StatelessWidget {
  final String conceptId;
  final String? categoryId;
  final double width;
  final double height;
  final Color? color;

  const SmartVectorImage({
    super.key,
    required this.conceptId,
    this.categoryId,
    this.width = 48.0,
    this.height = 48.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final assetPath = assetResolver.resolvePath(conceptId, categoryId: categoryId);
    final cachedSvg = vectorCache.getSvg(assetPath);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: cachedSvg != null
            ? Icon(Icons.image, size: width * 0.6, color: color ?? const Color(0xFF2E7D32))
            : Icon(Icons.auto_awesome, size: width * 0.5, color: const Color(0xFF757575)),
      ),
    );
  }
}
