import 'dart:async';

typedef FactoryFunc<T> = T Function();

/// حاوية حقن التبعيات المركزية ذات الأداء العالي والمستقلة عن الحزم الخارجية
class AppDI {
  static final AppDI _instance = AppDI._internal();
  factory AppDI() => _instance;
  AppDI._internal();

  final Map<Type, dynamic> _singletons = {};
  final Map<Type, FactoryFunc<dynamic>> _lazySingletons = {};
  final Map<Type, FactoryFunc<dynamic>> _factories = {};

  /// تسجيل كائن أحادي جاهز (Singleton)
  void registerSingleton<T>(T instance) {
    if (_singletons.containsKey(T)) {
      throw StateError('النوع $T مسجل بالفعل كـ Singleton');
    }
    _singletons[T] = instance;
  }

  /// تسجيل مصنع كسلان يتم إنشاؤه عند أول طلب فقط (Lazy Singleton)
  void registerLazySingleton<T>(FactoryFunc<T> factory) {
    if (_lazySingletons.containsKey(T) || _singletons.containsKey(T)) {
      throw StateError('النوع $T مسجل بالفعل');
    }
    _lazySingletons[T] = factory;
  }

  /// تسجيل مصنع يُنشئ كائناً جديداً في كل استدعاء (Factory)
  void registerFactory<T>(FactoryFunc<T> factory) {
    if (_factories.containsKey(T)) {
      throw StateError('النوع $T مسجل بالفعل كـ Factory');
    }
    _factories[T] = factory;
  }

  /// استرجاع النسخة المسجلة من النوع المطلوب
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

  /// التحقق من تسجيل نوع معين
  bool isRegistered<T>() {
    return _singletons.containsKey(T) ||
        _lazySingletons.containsKey(T) ||
        _factories.containsKey(T);
  }

  /// إعادة ضبط الحاوية لمسارات الاختبار
  void reset() {
    _singletons.clear();
    _lazySingletons.clear();
    _factories.clear();
  }
}

/// الاختصار العام للوصول لحاوية التبعيات
final di = AppDI();

/// نقطة تهيئة التبعيات النواتية للتطبيق
Future<void> initDependencies() async {
  // جاهز لتسجيل قواعد البيانات ومستودعات البيانات في المهام القادمة
}
