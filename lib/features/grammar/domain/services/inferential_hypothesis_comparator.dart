// Task #675: Inferential Hypothesis and Empirical Deduction Comparator
class InferentialHypothesisEntry {
  final String arabicInference;
  final String germanInference;
  final String englishInference;
  final String nauticalContext;
  const InferentialHypothesisEntry({
    required this.arabicInference,
    required this.germanInference,
    required this.englishInference,
    required this.nauticalContext,
  });
}

class InferentialHypothesisComparator {
  static const List<InferentialHypothesisEntry> deductions = [
    InferentialHypothesisEntry(
      arabicInference: 'يُسْتَدَلُّ مِنْ سُكُونِ الرِّيحِ عِنْدَ الغُرُوبِ عَلَى هُدُوءِ أَمْوَاجِ السَّاحِلِ غَدًا',
      germanInference: 'Aus dem Abflauen des Windes bei Sonnenuntergang lässt sich auf ruhige Küstenwellen morgen schließen',
      englishInference: 'From the dying of the wind at sunset, calm coastal waters tomorrow can be inferred',
      nauticalContext: 'Observational maritime meteorology guiding traditional wooden dhow departures',
    ),
    InferentialHypothesisEntry(
      arabicInference: 'مَا مِنْ شَكٍّ فِي أَنَّ دَهْنَ الجِلْفَاطَةِ بِالشَّحْمِ الحُرِّ يَمْنَعُ نُشُوفَ مَاءِ البَحْرِ',
      germanInference: 'Es steht außer Zweifel, dass das Kalfatern mit reinem Fett das Eindringen des Meerwassers verhindert',
      englishInference: 'There is no doubt that caulking with pure tallow prevents seawater seepage between hull planks',
      nauticalContext: 'Material guarantee in traditional dhow shipwright caulking and waterproofing',
    ),
  ];
}
