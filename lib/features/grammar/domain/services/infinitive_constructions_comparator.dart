class InfinitiveStructureRule {
  final String categoryName;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const InfinitiveStructureRule({
    required this.categoryName,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class InfinitiveConstructionsComparator {
  static List<InfinitiveStructureRule> getRules() {
    return const [
      InfinitiveStructureRule(
        categoryName: 'المصدر المؤول بعد أفعال القصد والرغبة (Intent & Wish)',
        arConstruction: 'أَنْ المَصْدَرِيَّةُ + الفِعْلُ المُضَارِعُ المَنْصُوبُ (= المَصْدَرُ الصَّرِيحُ)',
        deConstruction: 'Infinitiv mit "zu" am Satzende nach Verben der Absicht (beabsichtigen, hoffen)',
        enConstruction: 'To-infinitive following verbs of intention (intend to, plan to)',
        exampleAr: 'أَنْوِي أَنْ أَبْنِيَ صَوْمَعَةً لِلْقَمْحِ',
        exampleDe: 'Ich beabsichtige, einen Getreidespeicher zu erbauen.',
        exampleEn: 'I intend to build a grain granary.',
      ),
      InfinitiveStructureRule(
        categoryName: 'التركيب المصدري بعد الصفات التقييمية (Evaluation with Adjectives)',
        arConstruction: 'مِنَ + صِفَةٌ + أَنْ + فِعْلٌ مُضَارِعٌ (مِنَ المُهِمِّ أَنْ نُهَوِّيَ المَكَانَ)',
        deConstruction: 'Es ist + Adjektiv + ... zu + Infinitiv (es ist wichtig, zu lüften)',
        enConstruction: 'It is + adjective + to-infinitive (it is important to ventilate)',
        exampleAr: 'مِنَ الضَّرُورِيِّ أَنْ نَحْفَظَ الغِلَالَ فِي مَكَانٍ جَافٍّ',
        exampleDe: 'Es ist notwendig, das Getreide an einem trockenen Ort zu lagern.',
        exampleEn: 'It is necessary to store the grain in a dry place.',
      ),
    ];
  }
}
