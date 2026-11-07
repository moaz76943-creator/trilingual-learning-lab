// Task #723: Complementary Interdependence and Hydraulic Synergy Comparator
class ComplementaryInterdependenceEntry {
  final String arabicSynergy;
  final String germanSynergy;
  final String englishSynergy;
  final String hydraulicContext;
  const ComplementaryInterdependenceEntry({
    required this.arabicSynergy,
    required this.germanSynergy,
    required this.englishSynergy,
    required this.hydraulicContext,
  });
}

class ComplementaryInterdependenceComparator {
  static const List<ComplementaryInterdependenceEntry> synergies = [
    ComplementaryInterdependenceEntry(
      arabicSynergy: 'يَتَسَانَدُ ثِقَلُ حَجَرِ المِيزَانِ مَعَ جَرَيَانِ المَاءِ فِي تَحْرِيكِ ذِرَاعِ الشَّادُوفِ بِيُسْرٍ',
      germanSynergy: 'Das Gewicht des Ausgleichssteins wirkt mit der Wasserkraft zusammen, um den Schöpfbalken mühelos zu heben',
      englishSynergy: 'The counterweight of the stone cooperates with water buoyancy to lift the shaduf beam with ease',
      hydraulicContext: 'Synergistic lever counterbalancing in traditional irrigation shadufs',
    ),
    ComplementaryInterdependenceEntry(
      arabicSynergy: 'كُلَّمَا انْحَنَى الرَّاعِي بِالدَّلْوِ، ارْتَفَعَ الثِّقَلُ الحَجَرِيُّ لِيُعِينَ عَلَى رَفْعِ المَاءِ',
      germanSynergy: 'Je tiefer der Schöpfer den Eimer senkt, desto höher steigt das Steingewicht, um das Heben zu erleichtern',
      englishSynergy: 'The lower the irrigator dips the bucket, the higher the stone counterweight rises to assist lifting',
      hydraulicContext: 'Reciprocal potential energy storage aiding continuous manual well-drawing',
    ),
  ];
}
