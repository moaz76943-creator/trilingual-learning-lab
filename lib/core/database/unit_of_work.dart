import '../errors/failures.dart';
import '../utils/result.dart';

typedef AtomicOperation = Future<Result<void, Failure>> Function();

/// نمط Unit of Work لإدارة عمليات حفظ نتائج جلسات التعلم والمراجعة بصفقات ذرية متكاملة
class UnitOfWork {
  final List<AtomicOperation> _operations = [];
  bool _isCommitted = false;

  /// إضافة عملية ذرية إلى رتل المعاملات
  void registerOperation(AtomicOperation operation) {
    if (_isCommitted) {
      throw StateError('لا يمكن إضافة عمليات إلى صفقة تم تثبيتها بالفعل');
    }
    _operations.add(operation);
  }

  /// تنفيذ كافة العمليات ضمن صفقة واحدة متصلة مع التراجع عند حدوث أي خطأ
  Future<Result<void, Failure>> commit() async {
    if (_operations.isEmpty) {
      return Result.success(null);
    }

    try {
      for (final op in _operations) {
        final result = await op();
        if (result.isFailure) {
          _operations.clear();
          return Result.failure(result.failure);
        }
      }

      _isCommitted = true;
      _operations.clear();
      return Result.success(null);
    } catch (e) {
      _operations.clear();
      return Result.failure(DatabaseFailure('فشل تنفيذ صفقة Unit of Work الذرية: $e'));
    }
  }

  void rollback() {
    _operations.clear();
  }

  int get pendingOperationsCount => _operations.length;
}
