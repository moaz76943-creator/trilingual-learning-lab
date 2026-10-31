import '../../domain/entities/verb_conjugation.dart';
import '../models/verb_model.dart';

extension VerbModelMapper on VerbModel {
  VerbConjugation toDomain() => VerbConjugation(
        id: id,
        infinitiveGerman: infinitiveGerman,
        rootArabic: rootArabic,
        infinitiveEnglish: infinitiveEnglish,
        presentGerman: presentGerman,
        pastGerman: pastGerman,
        perfectGerman: perfectGerman,
        level: level,
      );
}

extension VerbConjugationMapper on VerbConjugation {
  VerbModel toModel() => VerbModel(
        id: id,
        infinitiveGerman: infinitiveGerman,
        rootArabic: rootArabic,
        infinitiveEnglish: infinitiveEnglish,
        presentGerman: presentGerman,
        pastGerman: pastGerman,
        perfectGerman: perfectGerman,
        level: level,
      );
}
