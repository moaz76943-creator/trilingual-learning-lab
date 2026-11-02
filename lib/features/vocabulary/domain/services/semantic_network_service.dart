class SemanticCluster {
  final String rootAr;
  final String theme;
  final List<String> arDerivatives;
  final List<String> deEquivalents;
  final List<String> enEquivalents;

  const SemanticCluster({
    required this.rootAr,
    required this.theme,
    required this.arDerivatives,
    required this.deEquivalents,
    required this.enEquivalents,
  });
}

class SemanticNetworkService {
  static List<SemanticCluster> getFoundationalClusters() {
    return const [
      SemanticCluster(
        rootAr: 'ع-م-ل',
        theme: 'العمل والإتقان',
        arDerivatives: ['عَمَلٌ', 'عَامِلٌ', 'مَعْمَلٌ', 'عَمَلِيٌّ'],
        deEquivalents: ['die Arbeit', 'der Arbeiter', 'das Labor', 'praktisch'],
        enEquivalents: ['work', 'worker', 'workshop/lab', 'practical'],
      ),
      SemanticCluster(
        rootAr: 'ع-ل-م',
        theme: 'العلم والمعرفة',
        arDerivatives: ['عِلْمٌ', 'عَالِمٌ', 'مَعْلُومٌ', 'تَعَلَّمَ'],
        deEquivalents: ['das Wissen', 'der Gelehrte', 'bekannt', 'lernen'],
        enEquivalents: ['knowledge', 'scholar', 'known', 'to learn'],
      ),
    ];
  }
}
