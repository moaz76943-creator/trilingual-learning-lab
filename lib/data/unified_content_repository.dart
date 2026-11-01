import '../core/errors/failures.dart';
import '../core/utils/result.dart';
import '../features/vocabulary/domain/entities/vocabulary_concept.dart';
import '../features/vocabulary/domain/repositories/content_repository.dart';
import '../features/sentences/domain/entities/sentence_item.dart';
import '../features/verbs/domain/entities/verb_conjugation.dart';

/// تنفيذ مستودع المحتوى التعليمي الموحد مع التخزين الذاكري والربط المتقاطع
class UnifiedContentRepository implements ContentRepository {
  final Map<String, List<VocabularyConcept>> _categoryCache = {};
  final Map<String, VocabularyConcept> _conceptCache = {};
  final List<SentenceItem> _sentenceCache = [];
  final Map<String, VerbConjugation> _verbCache = {};

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  /// تهيئة وتحميل الكاش السريع
  Future<void> preload() async {
    if (_isLoaded) return;
    _isLoaded = true;
  }

  @override
  Future<Result<List<VocabularyConcept>, Failure>> getVocabularyByCategory(String categoryId) async {
    try {
      if (_categoryCache.containsKey(categoryId)) {
        return Result.success(_categoryCache[categoryId]!);
      }
      return Result.success(const []);
    } catch (e) {
      return Result.failure(DatabaseFailure('فشل استرجاع مفردات التصنيف: $e'));
    }
  }

  @override
  Future<Result<VocabularyConcept, Failure>> getConceptById(String id) async {
    if (_conceptCache.containsKey(id)) {
      return Result.success(_conceptCache[id]!);
    }
    return Result.failure(ValidationFailure('المفردة $id غير موجودة'));
  }

  @override
  Future<Result<List<VocabularyConcept>, Failure>> searchVocabulary(String query) async {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return Result.success(const []);

    final matches = _conceptCache.values.where((c) {
      return c.german.toLowerCase().contains(q) ||
          c.english.toLowerCase().contains(q) ||
          c.arabic.contains(query.trim());
    }).toList();

    return Result.success(matches);
  }

  @override
  Future<Result<List<SentenceItem>, Failure>> getSentencesForConcept(String conceptId) async {
    final matches = _sentenceCache.where((s) => s.conceptRefs.contains(conceptId)).toList();
    return Result.success(matches);
  }

  @override
  Future<Result<List<SentenceItem>, Failure>> getSentencesByLevel(String level) async {
    final matches = _sentenceCache.where((s) => s.level.toLowerCase() == level.toLowerCase()).toList();
    return Result.success(matches);
  }

  @override
  Future<Result<VerbConjugation, Failure>> getVerbById(String id) async {
    if (_verbCache.containsKey(id)) {
      return Result.success(_verbCache[id]!);
    }
    return Result.failure(ValidationFailure('الفعل $id غير موجود'));
  }

  @override
  Future<Result<List<String>, Failure>> getAllCategoryIds() async {
    return Result.success(_categoryCache.keys.toList());
  }
}
