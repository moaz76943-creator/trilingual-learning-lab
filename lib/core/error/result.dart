import 'failures.dart';

sealed class Result<S, F extends Failure> {
  const Result();

  factory Result.success(S data) = Success<S, F>;
  factory Result.failure(F failure) = FailureResult<S, F>;

  bool get isSuccess => this is Success<S, F>;
  bool get isFailure => this is FailureResult<S, F>;

  S? get dataOrNull => switch (this) {
    Success<S, F>(:final data) => data,
    FailureResult<S, F>() => null,
  };

  F? get errorOrNull => switch (this) {
    Success<S, F>() => null,
    FailureResult<S, F>(:final failure) => failure,
  };

  R fold<R>(R Function(S data) onSuccess, R Function(F failure) onFailure) {
    return switch (this) {
      Success<S, F>(:final data) => onSuccess(data),
      FailureResult<S, F>(:final failure) => onFailure(failure),
    };
  }
}

final class Success<S, F extends Failure> extends Result<S, F> {
  final S data;
  const Success(this.data);
}

final class FailureResult<S, F extends Failure> extends Result<S, F> {
  final F failure;
  const FailureResult(this.failure);
}
