import 'dart:collection';

/// كاش ذاكرة عشوائي مقيد السعة (Least Recently Used) مع طرد تلقائي للعناصر الأقدم
class LRUCache<K, V> {
  final int capacity;
  final LinkedHashMap<K, V> _map = LinkedHashMap<K, V>();

  LRUCache({this.capacity = 200}) {
    if (capacity <= 0) {
      throw ArgumentError('يجب أن تكون سعة كاش LRU أكبر من الصفر');
    }
  }

  /// استرجاع القيمة مع تحديث ترتيب استخدامها للأحدث
  V? get(K key) {
    if (!_map.containsKey(key)) return null;
    final value = _map.remove(key) as V;
    _map[key] = value;
    return value;
  }

  /// إدراج أو تحديث قيمة مع طرد العنصر الأقدم عند تجاوز السعة
  void put(K key, V value) {
    if (_map.containsKey(key)) {
      _map.remove(key);
    } else if (_map.length >= capacity) {
      final oldestKey = _map.keys.first;
      _map.remove(oldestKey);
    }
    _map[key] = value;
  }

  bool containsKey(K key) => _map.containsKey(key);

  V? remove(K key) => _map.remove(key);

  void clear() => _map.clear();

  int get size => _map.length;

  bool get isEmpty => _map.isEmpty;

  List<K> get keys => _map.keys.toList();

  List<V> get values => _map.values.toList();
}
