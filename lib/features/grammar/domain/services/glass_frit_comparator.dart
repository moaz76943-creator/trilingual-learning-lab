// Task #873: Mineral Granulation and Faience Sintering Comparator
class GlassFritEntry {
  final String arabicSintering;
  final String germanSintering;
  final String englishSintering;
  final String mineralPhysics;
  const GlassFritEntry({
    required this.arabicSintering,
    required this.germanSintering,
    required this.englishSintering,
    required this.mineralPhysics,
  });
}

class GlassFritComparator {
  static const List<GlassFritEntry> sinteringRules = [
    GlassFritEntry(
      arabicSintering: 'يَتَلَازُّ مَسْحُوقُ الكُوَارْتْزِ مَعَ أَمْلَاحِ النَّطْرُونِ لِيَتَكَوَّنَ جِسْمٌ خَزَفِيٌّ شَدِيدُ الصَّلَابَةِ',
      germanSintering: 'Das Quarzpulver sintert mit Natronsalzen zusammen und bildet einen äußerst widerstandsfähigen Scherben',
      englishSintering: 'Quartz powder sinters with natron salts to form an exceptionally durable vitreous ceramic body',
      mineralPhysics: 'Solid-state pyrochemical sintering and self-glazing flux migration in Egyptian faience',
    ),
    GlassFritEntry(
      arabicSintering: 'كُلَّمَا هَاجَرَتْ أَمْلَاحُ النُّحَاسِ نَحْوَ السَّطْحِ أَثْنَاءَ الجَفَافِ، اكْتَسَتِ القِطْعَةُ لَوْنًا فَيْرُوزِيًّا بَرَّاقًا',
      germanSintering: 'Je stärker die Kupfersalze beim Trocknen an die Oberfläche wandern, desto leuchtender färbt sich der Türkiston',
      englishSintering: 'The more copper salts migrate toward the surface during drying, the more luminous the turquoise hue becomes',
      mineralPhysics: 'Efflorescence glazing mechanism creating a glossy quartz-copper glaze shell upon firing',
    ),
  ];
}
