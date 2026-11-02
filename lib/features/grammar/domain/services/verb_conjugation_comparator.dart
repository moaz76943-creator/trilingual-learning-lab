class ConjugationComparison {
  final String pronoun;
  final String arForm;
  final String deForm;
  final String enForm;

  const ConjugationComparison({
    required this.pronoun,
    required this.arForm,
    required this.deForm,
    required this.enForm,
  });
}

class VerbConjugationComparator {
  static List<ConjugationComparison> comparePresentTenseLearn() {
    return const [
      ConjugationComparison(
        pronoun: 'المتكلم / Ich / I',
        arForm: 'أَنَا أَتَعَلَّمُ',
        deForm: 'ich lerne',
        enForm: 'I learn',
      ),
      ConjugationComparison(
        pronoun: 'المخاطب / Du / You',
        arForm: 'أَنْتَ تَتَعَلَّمُ',
        deForm: 'du lernst',
        enForm: 'you learn',
      ),
      ConjugationComparison(
        pronoun: 'الغائب / Er / He',
        arForm: 'هُوَ يَتَعَلَّمُ',
        deForm: 'er lernt',
        enForm: 'he learns',
      ),
    ];
  }
}
