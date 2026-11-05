// Task #531: Epistemic Modality and Empirical Observation Comparator
class EpistemicObservationEntry {
  final String arabicModality;
  final String germanModality;
  final String englishModality;
  final String degreeOfCertainty;
  const EpistemicObservationEntry({
    required this.arabicModality,
    required this.germanModality,
    required this.englishModality,
    required this.degreeOfCertainty,
  });
}

class EmpiricalObservationComparator {
  static const List<EpistemicObservationEntry> entries = [
    EpistemicObservationEntry(
      arabicModality: 'يَبْدُو جَلِيًّا أَنَّ البُخَارَ تَصَاعَدَ إِلَى عُنُقِ الإِنْبِيقِ',
      germanModality: 'Augenscheinlich ist der Dampf in den Schwanenhals des Helms aufgestiegen',
      englishModality: 'Evidently the vapor has ascended into the alembic swan neck',
      degreeOfCertainty: 'High sensory verification from direct empirical observation',
    ),
    EpistemicObservationEntry(
      arabicModality: 'يَغْلِبُ عَلَى الظَّنِّ أَنَّ المَاءَ المَقْطُورَ وَصَلَ إِلَى كَمَالِ صَفَائِهِ',
      germanModality: 'Allem Anschein nach hat das Destillat seine vollkommene Reinheit erreicht',
      englishModality: 'In all likelihood the distillate has attained full clarity',
      degreeOfCertainty: 'Inference based on steady aromatic condensation rate',
    ),
  ];
}
