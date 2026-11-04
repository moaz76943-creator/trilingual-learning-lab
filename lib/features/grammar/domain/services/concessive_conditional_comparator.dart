class ConcessiveConditionalGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ConcessiveConditionalGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ConcessiveConditionalComparator {
  static List<ConcessiveConditionalGuide> getRules() {
    return const [
      ConcessiveConditionalGuide(
        categoryTitle: 'الشرط التنازلي الافتراضي (Concessive Conditional: وإن / selbst wenn)',
        arConstruction: 'وَاوُ الحَالِ + إِنْ / لَوْ الشَّرْطِيَّةُ + فِعْلٌ مَاضٍ أَوْ مُضَارِعٌ',
        deConstruction: 'selbst wenn / auch wenn (Subjunktion: Verb am Nebensatzende)',
        enConstruction: 'even if / even though + clause',
        exampleAr: 'يَشْرَبُ المُسَافِرُ هَنِيئًا وَإِنْ قَلَّ المَاءُ فِي القَدَحِ',
        exampleDe: 'Der Wanderer trinkt dankbar, selbst wenn wenig Wasser im Becher ist.',
        exampleEn: 'The traveler drinks gratefully, even if there is little water in the cup.',
      ),
      ConcessiveConditionalGuide(
        categoryTitle: 'التسوية بين بديلين مشروطين (Alternative Indifference: سواء ... أم)',
        arConstruction: 'سَوَاءٌ + فِعْلٌ ... أَمْ + فِعْلٌ آخَرُ (تفيد استواء النتيجة)',
        deConstruction: 'egal ob ... oder ... / sei es, dass ... oder ...',
        enConstruction: 'whether ... or ... (it makes no difference)',
        exampleAr: 'سَوَاءٌ صَنَعْتَ القَدَحَ مِنْ خَشَبِ الجَوْزِ أَمِ الزَّانِ فَأَحْسِنْ صَقْلَهُ',
        exampleDe: 'Egal ob du den Becher aus Walnuss oder Buche fertigst, poliere ihn gut.',
        exampleEn: 'Whether you craft the cup from walnut or beech, polish it well.',
      ),
    ];
  }
}
