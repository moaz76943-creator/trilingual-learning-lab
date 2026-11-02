class ConditionalStructureGuide {
  final String conditionType;
  final String arFormula;
  final String deFormula;
  final String enFormula;
  final String example;

  const ConditionalStructureGuide({
    required this.conditionType,
    required this.arFormula,
    required this.deFormula,
    required this.enFormula,
    required this.example,
  });
}

class ConditionalSentenceComparator {
  static List<ConditionalStructureGuide> getConditionalGuides() {
    return const [
      ConditionalStructureGuide(
        conditionType: 'الشرط الواقعي الممكن (Real Condition)',
        arFormula: 'إِذَا / إِنْ + فِعْلُ الشَّرْطِ + جَوَابُ الشَّرْطِ',
        deFormula: 'Konditionalsatz mit "wenn/falls" (Verb am Ende) + Hauptsatz (Inversion)',
        enFormula: 'First Conditional: If + Present Simple, will + base form',
        example: 'إِذَا اجْتَهَدْتَ نَجَحْتَ | Wenn du dich anstrengst, wirst du Erfolg haben | If you strive, you will succeed',
      ),
      ConditionalStructureGuide(
        conditionType: 'الشرط الافتراضي غير المتحقق (Hypothetical Condition)',
        arFormula: 'لَوْ + فِعْلٌ مَاضٍ + لَـ (جَوَابُ الشَّرْطِ)',
        deFormula: 'Irrealer Konditionalsatz mit Konjunktiv II: Wenn + hätte/wäre..., würde...',
        enFormula: 'Second Conditional: If + Past Simple, would + base form',
        example: 'لَوْ مَلَكْتُ وَقْتًا لَسَاعَدْتُكَ | Wenn ich Zeit hätte, würde ich dir helfen | If I had time, I would help you',
      ),
    ];
  }
}
