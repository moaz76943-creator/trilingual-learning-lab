class NuancedSynonymGroup {
  final String generalConcept;
  final List<String> arNuances;
  final List<String> deNuances;
  final List<String> enNuances;
  final String usageGuidanceAr;

  const NuancedSynonymGroup({
    required this.generalConcept,
    required this.arNuances,
    required this.deNuances,
    required this.enNuances,
    required this.usageGuidanceAr,
  });
}

class SynonymDisambiguationService {
  static List<NuancedSynonymGroup> getDisambiguations() {
    return const [
      NuancedSynonymGroup(
        generalConcept: 'الماء النازل من السماء (Rain Variations)',
        arNuances: ['مَطَرٌ (عَامٌّ)', 'غَيْثٌ (مُنْقِذٌ نَافِعٌ لِلْجَدْبِ)', 'وَدْقٌ (قَطَرَاتٌ لَطِيفَةٌ)'],
        deNuances: ['der Regen (allgemein)', 'der Landregen / Segensregen (anhaltend fruchtbringend)', 'der Nieselregen (fein)'],
        enNuances: ['rain (general)', 'beneficial bounty rain', 'gentle drizzle'],
        usageGuidanceAr: 'الغيث يُستعمل دائماً في سياق الخير والإنقاذ وسقيا الأرض العطشى، بخلاف المطر الذي قد يكون عاماً.',
      ),
    ];
  }
}
