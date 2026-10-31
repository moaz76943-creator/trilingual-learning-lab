/// الصنف الأساسي الموحد لجميع حالات الفشل في النظام
abstract class Failure {
  final String message;
  final int? code;
  final dynamic details;

  const Failure(this.message, {this.code, this.details});

  @override
  String toString() => '$runtimeType: $message${code != null ? ' (كود: $code)' : ''}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          code == other.code;

  @override
  int get hashCode => message.hashCode ^ (code?.hashCode ?? 0);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, {super.code, super.details});
}

class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.code, super.details});
}

class ParseFailure extends Failure {
  const ParseFailure(super.message, {super.code, super.details});
}

class AssetFailure extends Failure {
  const AssetFailure(super.message, {super.code, super.details});
}

class AudioFailure extends Failure {
  const AudioFailure(super.message, {super.code, super.details});
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.code, super.details});
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.code, super.details});
}
