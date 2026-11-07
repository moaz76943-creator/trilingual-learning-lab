// Task #795: Torsion Resilience and Kinetic Elasticity Comparator
class TorsionResilienceEntry {
  final String arabicTorsion;
  final String germanTorsion;
  final String englishTorsion;
  final String kineticContext;
  const TorsionResilienceEntry({
    required this.arabicTorsion,
    required this.germanTorsion,
    required this.englishTorsion,
    required this.kineticContext,
  });
}

class TorsionResilienceComparator {
  static const List<TorsionResilienceEntry> mechanics = [
    TorsionResilienceEntry(
      arabicTorsion: 'بِمِقْدَارِ انْحِنَاءِ سِيَةِ القَوْسِ لِلْخَلْفِ، تَزْدَادُ طَاقَةُ الشَّدِّ الكَامِنَةُ فِي أَوْتَارِهِ',
      germanTorsion: 'Je stärker sich die Siyahs des Bogens zurückbiegen, desto höher wird die gespeicherte Spannenergie',
      englishTorsion: 'In proportion as the bow siyahs recurve, the greater the stored potential energy in its limbs',
      kineticContext: 'Dynamic lever mechanics of rigid recurve tips accelerating arrow release velocity',
    ),
    TorsionResilienceEntry(
      arabicTorsion: 'كُلَّمَا جَفَّتْ طَبَقَاتُ العَصَبِ مَعَ غِرَاءِ السَّمَكِ، اشْتَدَّتْ مُقَاوَمَةُ الخَشَبِ لِلانْكِسَارِ',
      germanTorsion: 'Je gründlicher die Sehnenschichten mit Fischleim aushärten, desto bruchfester wird das Holz',
      englishTorsion: 'The more thoroughly the sinew layers cure with isinglass glue, the more resilient the wood becomes',
      kineticContext: 'Composite tension-compression structural synergy preventing core fatigue',
    ),
  ];
}
