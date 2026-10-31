import '../errors/failures.dart';
import '../utils/result.dart';

/// العقد المعماري الأساسي لجميع حالات الاستخدام في طبقة Domain
abstract class UseCase<Type, Params> {
  Future<Result<Type, Failure>> call(Params params);
}

/// كائن المعاملات الافتراضي للعمليات التي لا تتطلب مدخلات
class NoParams {
  const NoParams();
}
