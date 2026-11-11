import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'state_persistence_engine.dart';

/// Abstract base class for hydrated controllers that automatically persist and resurrect state.
abstract class HydratedStateController<T> extends ChangeNotifier {
  final String storageKey;
  final StatePersistenceEngine persistenceEngine;
  final int schemaVersion;

  T _state;
  bool _isHydrated = false;
  Timer? _debounceTimer;

  HydratedStateController({
    required this.storageKey,
    required T defaultState,
    required this.persistenceEngine,
    this.schemaVersion = 1,
  }) : _state = defaultState;

  T get state => _state;
  bool get isHydrated => _isHydrated;

  /// Serializes state [T] into JSON map.
  Map<String, dynamic> toJson(T state);

  /// Deserializes state [T] from JSON map.
  T fromJson(Map<String, dynamic> json);

  /// Emits new state and schedules debounced persistence.
  void emit(T newState) {
    if (_state != newState) {
      _state = newState;
      notifyListeners();
      _scheduleSave();
    }
  }

  /// Rehydrates state from persistent storage.
  Future<void> rehydrate() async {
    try {
      final raw = await persistenceEngine.read(storageKey);
      if (raw != null && raw.isNotEmpty) {
        final decoded = jsonDecode(raw) as Map<String, dynamic>;
        final storedVersion = decoded['_schema_version'] as int? ?? 1;

        if (storedVersion == schemaVersion) {
          final payload = decoded['data'] as Map<String, dynamic>;
          _state = fromJson(payload);
        }
      }
    } catch (_) {
      // On deserialization error or corrupted data, retain default state safely
    } finally {
      _isHydrated = true;
      notifyListeners();
    }
  }

  void _scheduleSave() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 50), () async {
      await saveNow();
    });
  }

  /// Immediately commits active state to persistence engine.
  Future<void> saveNow() async {
    try {
      final data = {
        '_schema_version': schemaVersion,
        'data': toJson(_state),
      };
      final serialized = jsonEncode(data);
      await persistenceEngine.write(storageKey, serialized);
    } catch (_) {}
  }

  /// Clears stored state and resets to default.
  Future<void> clearPersistedState(T defaultState) async {
    _debounceTimer?.cancel();
    await persistenceEngine.delete(storageKey);
    _state = defaultState;
    notifyListeners();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
