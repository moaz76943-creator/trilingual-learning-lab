import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/vocabulary_concept.dart';
import '../../../sentences/domain/entities/sentence_item.dart';
import '../../../verbs/domain/entities/verb_conjugation.dart';

/// العقد المعماري الموحد لمستودع المحتوى التعليمي الثلاثي
abstract class ContentRepository {
  /// استرجاع مفردات تصنيف معين
  Future<Result<List<VocabularyConcept>, Failure>> getVocabularyByCategory(String categoryId);

  /// استرجاع مفهوم لغوي محدد بالمعرف
  Future<Result<VocabularyConcept, Failure>> getConceptById(String id);

  /// البحث الفوري في المفردات باللغات الثلاث
  Future<Result<List<VocabularyConcept>, Failure>> searchVocabulary(String query);

  /// استرجاع الجمل السياقية المرتبطة بمفردة معينة
  Future<Result<List<SentenceItem>, Failure>> getSentencesForConcept(String conceptId);

  /// استرجاع الجمل بحسب المستوى الإطاري (A1, A2, B1)
  Future<Result<List<SentenceItem>, Failure>> getSentencesByLevel(String level);

  /// استرجاع تصريفات فعل محدد
  Future<Result<VerbConjugation, Failure>> getVerbById(String id);

  /// استرجاع قائمة جميع التصنيفات المعتمدة
  Future<Result<List<String>, Failure>> getAllCategoryIds();
}
