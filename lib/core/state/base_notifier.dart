import 'dart:async';
import '../errors/failures.dart';
import 'app_state.dart';

/// منسق الحالة التفاعلي الصافي الخالي من الاعتماديات الخارجية
class BaseNotifier<T> {
  AppState<T> _state;
  final StreamController<AppState<T>> _controller = StreamController<AppState<T>>.broadcast();

  BaseNotifier([T? initialData]) : _state = AppState.initial(initialData);

  AppState<T> get state => _state;
  Stream<AppState<T>> get stream => _controller.stream;

  void emit(AppState<T> newState) {
    if (_controller.isClosed) return;
    _state = newState;
    _controller.add(_state);
  }

  void setLoading() => emit(AppState.loading(_state.data));
  void setSuccess(T data, [String? message]) => emit(AppState.success(data, message));
  void setFailure(Failure failure, [T? fallback]) =>
      emit(AppState.failure(failure, fallback ?? _state.data));

  void dispose() {
    _controller.close();
  }
}
