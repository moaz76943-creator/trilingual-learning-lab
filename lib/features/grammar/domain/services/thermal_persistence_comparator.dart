// Task #843: Thermal Persistence and Clay Oven Retentivity Comparator
class ThermalPersistenceEntry {
  final String arabicPersistence;
  final String germanPersistence;
  final String englishPersistence;
  final String bakingDynamics;
  const ThermalPersistenceEntry({
    required this.arabicPersistence,
    required this.germanPersistence,
    required this.englishPersistence,
    required this.bakingDynamics,
  });
}

class ThermalPersistenceComparator {
  static const List<ThermalPersistenceEntry> thermodynamics = [
    ThermalPersistenceEntry(
      arabicPersistence: 'تَحْتَبِسُ جُدْرَانُ التَّنُّورِ الطِّينِيِّ حَرَارَةَ الجَمْرِ لِتَنْضَجَ أَرْغِفَةُ الخُبْزِ نُضْجًا مُتَوَازِنًا بِلَا احْتِرَاقٍ',
      germanPersistence: 'Die Wände des Lehmofens speichern die Glutwärme, sodass die Brotlaibe gleichmäßig ohne Verbrennen backen',
      englishPersistence: 'The walls of the clay tannur oven retain ember heat so bread loaves bake uniformly without scorching',
      bakingDynamics: 'Radiative and conductive heat transfer from thick thermal mass earthenware walls',
    ),
    ThermalPersistenceEntry(
      arabicPersistence: 'كُلَّمَا رَصَّ الخَبَّازُ عَجِينَةَ القَمْحِ عَلَى مِخْبَزَةِ القُمَاشِ، سَهُلَ لَصْقُهَا فِي جِدَارِ التَّنُّورِ السَّاخِنِ',
      germanPersistence: 'Je sorgfältiger der Bäcker den Weizenteig auf dem Stoffkissen formt, desto müheloser haftet er an der heißen Ofenwand',
      englishPersistence: 'The more neatly the baker stretches the wheat dough upon the cloth peel cushion, the more smoothly it adheres to the hot oven wall',
      bakingDynamics: 'Surface adhesion dynamics and rapid steam crust formation on vertical earthenware surfaces',
    ),
  ];
}
