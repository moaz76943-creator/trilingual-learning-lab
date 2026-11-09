import 'package:flutter/foundation.dart';

/// Conjugation model for Arabic morphological patterns.
class ArabicConjugation {
  final String past;        // المَاضِي (e.g. كَبَّرَ)
  final String present;     // المُضَارِعُ (e.g. يُكَبِّرُ)
  final String imperative;  // الأَمْرُ (e.g. كَبِّرْ)
  final String verbalNoun;  // المَصْدَرُ (e.g. تَكْبِيرٌ)
  final Map<String, String> pronounForms; // أنا، أنتَ، هو، هي، نحن، إلخ

  const ArabicConjugation({
    required this.past,
    required this.present,
    required this.imperative,
    required this.verbalNoun,
    this.pronounForms = const {},
  });

  bool get isValid =>
      past.trim().isNotEmpty &&
      present.trim().isNotEmpty &&
      imperative.trim().isNotEmpty &&
      verbalNoun.trim().isNotEmpty;
}

/// Conjugation model for German verb tenses.
class GermanConjugation {
  final String infinitive;   // vergrößern
  final String preterite;    // vergrößerte
  final String participleII; // vergrößert
  final Map<String, String> presentForms; // ich, du, er/sie/es, wir, ihr, sie

  const GermanConjugation({
    required this.infinitive,
    required this.preterite,
    required this.participleII,
    this.presentForms = const {},
  });

  bool get isValid =>
      infinitive.trim().isNotEmpty &&
      preterite.trim().isNotEmpty &&
      participleII.trim().isNotEmpty;
}

/// Conjugation model for English verb tenses.
class EnglishConjugation {
  final String infinitive;     // to magnify
  final String simplePresent;  // magnifies
  final String simplePast;     // magnified
  final String pastParticiple; // magnified
  final Map<String, String> presentForms; // I, you, he/she/it, we, they

  const EnglishConjugation({
    required this.infinitive,
    required this.simplePresent,
    required this.simplePast,
    required this.pastParticiple,
    this.presentForms = const {},
  });

  bool get isValid =>
      infinitive.trim().isNotEmpty &&
      simplePresent.trim().isNotEmpty &&
      simplePast.trim().isNotEmpty &&
      pastParticiple.trim().isNotEmpty;
}

/// Complete trilingual verb paradigm entity.
class TrilingualVerbParadigm {
  final String verbId;
  final String rootAr; // e.g. ك - ب - ر
  final ArabicConjugation arabic;
  final GermanConjugation german;
  final EnglishConjugation english;

  const TrilingualVerbParadigm({
    required this.verbId,
    required this.rootAr,
    required this.arabic,
    required this.german,
    required this.english,
  });

  bool get isComplete => arabic.isValid && german.isValid && english.isValid;

  /// Canonical factory producing the historical applied-optics verb: to magnify
  factory TrilingualVerbParadigm.magnify() {
    return const TrilingualVerbParadigm(
      verbId: 'verb_optics_magnify_001',
      rootAr: 'ك - ب - ر',
      arabic: ArabicConjugation(
        past: 'كَبَّرَ',
        present: 'يُكَبِّرُ',
        imperative: 'كَبِّرْ',
        verbalNoun: 'تَكْبِيرٌ',
        pronounForms: {
          'ana': 'كَبَّرْتُ',
          'anta': 'كَبَّرْتَ',
          'huwa': 'كَبَّرَ',
          'hiya': 'كَبَّرَتْ',
          'nahnu': 'كَبَّرْنَا',
        },
      ),
      german: GermanConjugation(
        infinitive: 'vergrößern',
        preterite: 'vergrößerte',
        participleII: 'vergrößert',
        presentForms: {
          'ich': 'vergrößere',
          'du': 'vergrößerst',
          'er_sie_es': 'vergrößert',
          'wir': 'vergrößern',
        },
      ),
      english: EnglishConjugation(
        infinitive: 'to magnify',
        simplePresent: 'magnifies',
        simplePast: 'magnified',
        pastParticiple: 'magnified',
        presentForms: {
          'I': 'magnify',
          'he_she_it': 'magnifies',
          'we': 'magnify',
        },
      ),
    );
  }
}

/// Domain engine evaluating and resolving trilingual verb conjugations.
class VerbConjugationEngine {
  /// Validates whether a verb paradigm adheres to all trilingual integrity constraints.
  static bool validate(TrilingualVerbParadigm paradigm) {
    return paradigm.isComplete && paradigm.rootAr.trim().isNotEmpty;
  }

  /// Resolves the specific conjugated form for a given language, tense, and optional person.
  static String resolveForm(
    TrilingualVerbParadigm paradigm, {
    required String language,
    required String tense,
    String? person,
  }) {
    switch (language.toLowerCase()) {
      case 'ar':
        if (person != null && paradigm.arabic.pronounForms.containsKey(person)) {
          return paradigm.arabic.pronounForms[person]!;
        }
        if (tense == 'present') return paradigm.arabic.present;
        if (tense == 'imperative') return paradigm.arabic.imperative;
        if (tense == 'masdar') return paradigm.arabic.verbalNoun;
        return paradigm.arabic.past;

      case 'de':
        if (person != null && paradigm.german.presentForms.containsKey(person)) {
          return paradigm.german.presentForms[person]!;
        }
        if (tense == 'preterite') return paradigm.german.preterite;
        if (tense == 'participle') return paradigm.german.participleII;
        return paradigm.german.infinitive;

      case 'en':
        if (person != null && paradigm.english.presentForms.containsKey(person)) {
          return paradigm.english.presentForms[person]!;
        }
        if (tense == 'past') return paradigm.english.simplePast;
        if (tense == 'participle') return paradigm.english.pastParticiple;
        if (tense == 'present_3rd') return paradigm.english.simplePresent;
        return paradigm.english.infinitive;

      default:
        return '';
    }
  }
}
