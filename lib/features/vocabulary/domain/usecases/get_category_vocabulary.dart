import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/vocabulary_concept.dart';
import '../repositories/content_repository.dart';

class GetCategoryVocabularyParams {
  final String categoryId;
  const GetCategoryVocabularyParams(this.categoryId);
}

/// حالة استخدام استرجاع مفردات تصنيف محدد
class GetCategoryVocabulary implements UseCase<List<VocabularyConcept>, GetCategoryVocabularyParams> {
  final ContentRepository repository;

  GetCategoryVocabulary(this.repository);

  @override
  Future<Result<List<VocabularyConcept>, Failure>> call(GetCategoryVocabularyParams params) async {
    if (params.categoryId.trim().isEmpty) {
      return Result.failure(const ValidationFailure('معرف التصنيف لا يمكن أن يكون فارغاً'));
    }
    return await repository.getVocabularyByCategory(params.categoryId);
  }
}
