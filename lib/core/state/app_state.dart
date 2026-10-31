import '../errors/failures.dart';

/// حالات الشاشات والعمليات غير المتزامنة
enum Status { initial, loading, success, failure }

/// غلاف حالة مناعي وثابت (Immutable) يدعم كافة الشاشات والميزات
class AppState<T> {
  final Status status;
  final T? data;
  final Failure? failure;
  final String? message;

  const AppState._({
    required this.status,
    this.data,
    this.failure,
    this.message,
  });

  factory AppState.initial([T? initialData]) => AppState._(
        status: Status.initial,
        data: initialData,
      );

  factory AppState.loading([T? currentData]) => AppState._(
        status: Status.loading,
        data: currentData,
      );

  factory AppState.success(T data, [String? message]) => AppState._(
        status: Status.success,
        data: data,
        message: message,
      );

  factory AppState.failure(Failure failure, [T? fallbackData]) => AppState._(
        status: Status.failure,
        failure: failure,
        data: fallbackData,
        message: failure.message,
      );

  bool get isInitial => status == Status.initial;
  bool get isLoading => status == Status.loading;
  bool get isSuccess => status == Status.success;
  bool get isFailure => status == Status.failure;

  AppState<T> copyWith({
    Status? status,
    T? data,
    Failure? failure,
    String? message,
  }) {
    return AppState._(
      status: status ?? this.status,
      data: data ?? this.data,
      failure: failure ?? this.failure,
      message: message ?? this.message,
    );
  }

  @override
  String toString() => 'AppState<$T>(status: $status, data: $data, failure: $failure)';
}
