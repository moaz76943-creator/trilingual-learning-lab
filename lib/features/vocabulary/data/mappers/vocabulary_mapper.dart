import '../../domain/entities/vocabulary_concept.dart';
import '../models/vocabulary_model.dart';

extension VocabularyModelMapper on VocabularyModel {
  VocabularyConcept toDomain() => VocabularyConcept(
        id: id,
        categoryId: categoryId,
        arabic: arabic,
        german: german,
        english: english,
        germanArticle: germanArticle,
        germanPlural: germanPlural,
        partOfSpeech: partOfSpeech,
        cefrLevel: cefrLevel,
        tags: tags,
        imageRef: imageRef,
      );
}

extension VocabularyConceptMapper on VocabularyConcept {
  VocabularyModel toModel() => VocabularyModel(
        id: id,
        categoryId: categoryId,
        arabic: arabic,
        german: german,
        english: english,
        germanArticle: germanArticle,
        germanPlural: germanPlural,
        partOfSpeech: partOfSpeech,
        cefrLevel: cefrLevel,
        tags: tags,
        imageRef: imageRef,
      );
}
