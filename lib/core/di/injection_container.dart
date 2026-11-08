import 'dart:async';
import '../storage/secure_storage_service.dart';
import '../assets/asset_index_database.dart';
import '../../data/unified_content_repository.dart';
import '../../features/settings/presentation/language_controller.dart';
import '../../features/search/presentation/controllers/search_controller.dart';
import '../../features/home/presentation/controllers/home_controller.dart';

typedef FactoryFunc<T> = T Function();

/// حاوية حقن التبعيات المركزية ذات الأداء العالي والمستقلة عن الحزم الخارجية
class AppDI {
  static final AppDI _instance = AppDI._internal();
  factory AppDI() => _instance;
  AppDI._internal();

  final Map<Type, dynamic> _singletons = {};
  final Map<Type, FactoryFunc<dynamic>> _lazySingletons = {};
  final Map<Type, FactoryFunc<dynamic>> _factories = {};

  void registerSingleton<T>(T instance) {
    _singletons[T] = instance;
  }

  void registerLazySingleton<T>(FactoryFunc<T> factory) {
    _lazySingletons[T] = factory;
  }

  void registerFactory<T>(FactoryFunc<T> factory) {
    _factories[T] = factory;
  }

  T get<T>() {
    if (_singletons.containsKey(T)) {
      return _singletons[T] as T;
    }
    if (_lazySingletons.containsKey(T)) {
      final instance = _lazySingletons[T]!();
      _singletons[T] = instance;
      _lazySingletons.remove(T);
      return instance as T;
    }
    if (_factories.containsKey(T)) {
      return _factories[T]!() as T;
    }
    throw StateError('النوع $T غير مسجل في حاوية حقن التبعيات AppDI');
  }

  bool isRegistered<T>() {
    return _singletons.containsKey(T) ||
        _lazySingletons.containsKey(T) ||
        _factories.containsKey(T);
  }

  void reset() {
    _singletons.clear();
    _lazySingletons.clear();
    _factories.clear();
  }
}

final di = AppDI();

/// نقطة تهيئة وربط كافة التبعيات النواتية للتطبيق
Future<void> initDependencies() async {
  // 1. خدمات التخزين الآمن
  final storage = SecureStorageService();
  di.registerSingleton<SecureStorageService>(storage);

  // تهيئة فهرس الأصول المضمّنة قبل بدء عرض الواجهة
  await assetIndexDb.initialize();

  // 2. مستودع المحتوى التعليمي الموحد
  final contentRepo = UnifiedContentRepository();
  await contentRepo.preload();
  di.registerSingleton<UnifiedContentRepository>(contentRepo);

  // 3. متحكم اللغة والإعدادات
  final langController = LanguageController(storage);
  await langController.init();
  di.registerSingleton<LanguageController>(langController);

  // 4. متحكمات الواجهة التفاعلية (Search & Home)
  di.registerFactory<TrilingualSearchController>(
    () => TrilingualSearchController(contentRepo),
  );
  di.registerFactory<HomeController>(
    () => HomeController(storage),
  );
}
