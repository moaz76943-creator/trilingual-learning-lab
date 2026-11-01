import '../cache/vector_cache_manager.dart';
import 'asset_index_database.dart';
import '../utils/logger.dart';

/// موزع الأصول الذكي On-Demand Asset Resolver مع كاش ديناميكي وحماية من الأخطاء
class AssetResolver {
  static final AssetResolver _instance = AssetResolver._internal();
  factory AssetResolver() => _instance;
  AssetResolver._internal();

  static const String fallbackIcon =
      '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="40" fill="#E0E0E0"/><text x="50" y="55" font-size="20" text-anchor="middle" fill="#757575">✦</text></svg>';

  /// حل مسار الرسم بناءً على معرف الكلمة مع فحص الكاش والبدائل
  String resolvePath(String conceptId, {String? categoryId}) {
    if (assetIndexDb.contains(conceptId)) {
      return assetIndexDb.resolvePath(conceptId);
    }

    if (categoryId != null && assetIndexDb.contains(categoryId)) {
      logger.d('استخدام أيقونة التصنيف البديلة للمفهوم: $conceptId', 'AssetResolver');
      return assetIndexDb.resolvePath(categoryId);
    }

    return 'content/assets/images/placeholder.svg';
  }

  /// جلب محتوى كود SVG مباشرة من الذاكرة أو إرجاع بديل فوري
  String getOrFallbackSvg(String path) {
    final cached = vectorCache.getSvg(path);
    if (cached != null) {
      return cached;
    }
    return fallbackIcon;
  }
}

final assetResolver = AssetResolver();
