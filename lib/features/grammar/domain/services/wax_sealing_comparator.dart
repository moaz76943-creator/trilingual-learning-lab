// Task #855: Wax Sealing and Thermoplastic Adhesion Comparator
class WaxSealingEntry {
  final String arabicSealing;
  final String germanSealing;
  final String englishSealing;
  final String physicalDynamics;
  const WaxSealingEntry({
    required this.arabicSealing,
    required this.germanSealing,
    required this.englishSealing,
    required this.physicalDynamics,
  });
}

class WaxSealingComparator {
  static const List<WaxSealingEntry> seals = [
    WaxSealingEntry(
      arabicSealing: 'يَنْصَهِرُ شَمْعُ العَسَلِ مَعَ صَمْغِ الصَّنَوْبَرِ عِنْدَ أَدْنَى حَرَارَةٍ لِيَغْدُوَ سَائِلًا قَانِيًا يَحْفَظُ السِّرَّ',
      germanSealing: 'Das Bienenwachs schmilzt mit Kiefernharz bei milder Wärme zu einer tiefroten Siegelmasse, die das Geheimnis wahrt',
      englishSealing: 'The beeswax melts with pine resin at gentle warmth to become a deep-crimson sealant that guards the secret',
      physicalDynamics: 'Thermoplastic phase transition and surface wetting adhesion of natural resin sealants',
    ),
    WaxSealingEntry(
      arabicSealing: 'كُلَّمَا ضُغِطَ خَاتَمُ الفِضَّةِ البَارِدُ فَوْقَ الشَّمْعِ الدَّافِئِ، انْطَبَعَتْ حُرُوفُ النَّقْشِ بِلَا تَشَوُّهٍ',
      germanSealing: 'Je ruhiger das kalte Silbersiegel auf das warme Wachs gedrückt wird, desto makelloser prägen sich die Lettern ein',
      englishSealing: 'The more steadily the cold silver signet is pressed into warm wax, the more flawlessly the letters imprint',
      physicalDynamics: 'Rapid thermal quenching and micro-relief mold replication under static pressure',
    ),
  ];
}
