import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/result.dart';
import '../../../vocabulary/domain/repositories/content_repository.dart';
import '../entities/sentence_item.dart';

class GetConceptSentencesParams {
  final String conceptId;
  const GetConceptSentencesParams(this.conceptId);
}

/// حالة استخدام استرجاع الجمل السياقية المرتبطة بمفردة معينة
class GetConceptSentences implements UseCase<List<SentenceItem>, GetConceptSentencesParams> {
  final ContentRepository repository;

  GetConceptSentences(this.repository);

  @override
  Future<Result<List<SentenceItem>, Failure>> call(GetConceptSentencesParams params) async {
    if (params.conceptId.trim().isEmpty) {
      return Result.failure(const ValidationFailure('معرف المفردة لا يمكن أن يكون فارغاً'));
    }
    return await repository.getSentencesForConcept(params.conceptId);
  }
}
