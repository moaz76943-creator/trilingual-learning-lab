class SustainableMaterialTerm {
  final String materialName;
  final String arabic;
  final String german;
  final String english;
  final String ecologicalAdvantage;

  const SustainableMaterialTerm({
    required this.materialName,
    required this.arabic,
    required this.german,
    required this.english,
    required this.ecologicalAdvantage,
  });
}

class NaturalMaterialsService {
  static List<SustainableMaterialTerm> getTerms() {
    return const [
      SustainableMaterialTerm(
        materialName: 'ألياف الحلفاء البرية (Wild Esparto Fiber)',
        arabic: 'الحَلْفَاءُ البَرِّيَّةُ المَمْشُوطَةُ المَتِينَةُ',
        german: 'das gekämmte, reißfeste wilde Espartogras',
        english: 'combed, durable wild esparto grass fiber',
        ecologicalAdvantage: 'نبات بري متجدد لا يحتاج إلى ري صناعي ويحمي التربة من التصحر.',
      ),
      SustainableMaterialTerm(
        materialName: 'الأوعية القابلة للتحلل الطبيعي (Biodegradable Containers)',
        arabic: 'الأَوْعِيَةُ التُّرَاثِيَّةُ سَرِيعَةُ التَّحَلُّلِ الحَيَوِيِّ',
        german: 'Biologisch abbaubare traditionelle Naturbehälter',
        english: 'Biodegradable traditional natural storage containers',
        ecologicalAdvantage: 'تتحلل في التربة بشكل طبيعي عند انتهاء عمرها وتتحول إلى سماد عضوي نافع.',
      ),
    ];
  }
}
