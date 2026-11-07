// Task #819: Mirror Clarity and Specular Reflection Comparator
class MirrorClarityEntry {
  final String arabicClarity;
  final String germanClarity;
  final String englishClarity;
  final String opticalPrinciple;
  const MirrorClarityEntry({
    required this.arabicClarity,
    required this.germanClarity,
    required this.englishClarity,
    required this.opticalPrinciple,
  });
}

class MirrorClarityComparator {
  static const List<MirrorClarityEntry> reflections = [
    MirrorClarityEntry(
      arabicClarity: 'تَنْعَكِسُ مَلَامِحُ الوَجْهِ فِي المِرْآةِ جَلِيَّةً كَمَا هِيَ دُونَ اعْوِجَاجٍ أَوْ زَيْفٍ',
      germanClarity: 'Die Gesichtszüge spiegeln sich im Spiegel wahrhaftig und klar ohne jede Verzerrung wider',
      englishClarity: 'Facial features reflect in the mirror pristine and true without distortion or falsehood',
      opticalPrinciple: 'Specular planar reflection dependent upon optical flat surface polish',
    ),
    MirrorClarityEntry(
      arabicClarity: 'بِمِقْدَارِ اسْتِوَاءِ صَفِيحَةِ الزُّجَاجِ بِمَسْحُوقِ الخَفَّافِ، يَصْفُو شُعَاعُ النُّورِ المُرْتَدِّ',
      germanClarity: 'Im Maße wie die Glasplatte mit Bimssteinpulver poliert ist, klärt sich der reflektierte Lichtstrahl',
      englishClarity: 'In proportion as the glass plate is smoothed with pumice powder, the bouncing beam clarifies',
      opticalPrinciple: 'Micro-abrasive polishing eliminating surface wave refraction anomalies',
    ),
  ];
}
