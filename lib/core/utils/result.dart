import '../errors/failures.dart';

/// نوع نتيجة وظيفي آمن وخالٍ من الاستثناءات المفاجئة
class Result<S, F extends Failure> {
  final S? _success;
  final F? _failure;
  final bool isSuccess;

  const Result._(this._success, this._failure, this.isSuccess);

  /// إنشاء نتيجة ناجحة تحتوي على البيانات
  factory Result.success(S data) => Result._(data, null, true);

  /// إنشاء نتيجة فاشلة تحتوي على كائن الفشل
  factory Result.failure(F failure) => Result._(null, failure, false);

  bool get isFailure => !isSuccess;

  S get data {
    if (isSuccess) return _success as S;
    throw StateError('لا يمكن استخراج البيانات من نتيجة فاشلة: $_failure');
  }

  F get failure {
    if (isFailure) return _failure as F;
    throw StateError('لا يمكن استخراج الفشل من نتيجة ناجحة: $_success');
  }

  S getOrElse(S fallback) => isSuccess ? (_success as S) : fallback;

  S? get dataOrNull => _success;
  F? get failureOrNull => _failure;

  /// معالجة وظيفية موحدة لحالتي النجاح والفشل
  R fold<R>(R Function(F failure) onFailure, R Function(S data) onSuccess) {
    if (isSuccess) {
      return onSuccess(_success as S);
    } else {
      return onFailure(_failure as F);
    }
  }

  /// تحويل البيانات في حال النجاح مع الإبقاء على الفشل دون تغيير
  Result<R, F> map<R>(R Function(S data) transform) {
    if (isSuccess) {
      return Result.success(transform(_success as S));
    } else {
      return Result.failure(_failure as F);
    }
  }

  /// تحويل كائن الفشل في حال حدوثه
  Result<S, R> mapFailure<R extends Failure>(R Function(F failure) transform) {
    if (isFailure) {
      return Result.failure(transform(_failure as F));
    } else {
      return Result.success(_success as S);
    }
  }

  @override
  String toString() => isSuccess ? 'Result.success($_success)' : 'Result.failure($_failure)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Result &&
          runtimeType == other.runtimeType &&
          isSuccess == other.isSuccess &&
          _success == other._success &&
          _failure == other._failure;

  @override
  int get hashCode => (_success?.hashCode ?? 0) ^ (_failure?.hashCode ?? 0) ^ isSuccess.hashCode;
}
