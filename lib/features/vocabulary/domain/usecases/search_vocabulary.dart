import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/vocabulary_concept.dart';
import '../repositories/content_repository.dart';

class SearchVocabularyParams {
  final String query;
  const SearchVocabularyParams(this.query);
}

/// حالة استخدام البحث الفوري في المفردات
class SearchVocabulary implements UseCase<List<VocabularyConcept>, SearchVocabularyParams> {
  final ContentRepository repository;

  SearchVocabulary(this.repository);

  @override
  Future<Result<List<VocabularyConcept>, Failure>> call(SearchVocabularyParams params) async {
    final cleanQuery = params.query.trim();
    if (cleanQuery.isEmpty) {
      return Result.success(const []);
    }
    return await repository.searchVocabulary(cleanQuery);
  }
}
