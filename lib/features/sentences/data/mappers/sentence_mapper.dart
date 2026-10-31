import '../../domain/entities/sentence_item.dart';
import '../models/sentence_model.dart';

extension SentenceModelMapper on SentenceModel {
  SentenceItem toDomain() => SentenceItem(
        id: id,
        arabic: arabic,
        german: german,
        english: english,
        level: level,
        conceptRefs: conceptRefs,
        grammarNote: grammarNote,
      );
}

extension SentenceItemMapper on SentenceItem {
  SentenceModel toModel() => SentenceModel(
        id: id,
        arabic: arabic,
        german: german,
        english: english,
        level: level,
        conceptRefs: conceptRefs,
        grammarNote: grammarNote,
      );
}
