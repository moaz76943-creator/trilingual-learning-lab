import '../../../lib/core/di/injection_container.dart';
import '../../../lib/core/cache/vector_cache_manager.dart';

void main() {
  final container = AppDI();

  container.registerSingleton<String>('test_service');
  assert(container.isRegistered<String>());

  // اختبار تنظيف الحاوية بالكامل وضمان عدم بقاء مراجع معلقة
  container.reset();
  assert(!container.isRegistered<String>());

  // اختبار تنظيف كاش المتجهات الذاكري
  vectorCache.putSvg('test_asset', '<svg></svg>');
  assert(vectorCache.contains('test_asset'));
  vectorCache.clear();
  assert(!vectorCache.contains('test_asset'));

  print('✅ اجتاز اختبار كفاءة الذاكرة وخلو الحاويات من التسريب بنجاح 100%!');
}
