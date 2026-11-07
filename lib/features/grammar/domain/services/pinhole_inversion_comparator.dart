// Task #885: Pinhole Optics and Camera Obscura Inversion Comparator
class PinholeInversionEntry {
  final String arabicInversion;
  final String germanInversion;
  final String englishInversion;
  final String opticalPrinciple;
  const PinholeInversionEntry({
    required this.arabicInversion,
    required this.germanInversion,
    required this.englishInversion,
    required this.opticalPrinciple,
  });
}

class PinholeInversionComparator {
  static const List<PinholeInversionEntry> observations = [
    PinholeInversionEntry(
      arabicInversion: 'تَنْطَبِعُ صُورَةُ المَنَارَةِ فِي البَيْتِ المُظْلِمِ مَقْلُوبَةً عَبْرَ ثَقْبِ الإِبْرَةِ الضَّيِّقِ دُونَ اسْتِعْمَالِ أَيِّ عَدَسَةٍ',
      germanInversion: 'Das Bild des Leuchtturms zeichnet sich in der dunklen Kammer durch das feine Loch verkehrt herum ab, ganz ohne Linse',
      englishInversion: 'The image of the lighthouse imprints inverted inside the dark chamber through the narrow pinhole without any lens',
      opticalPrinciple: 'Rectilinear propagation of light rays through a tiny aperture creating an inverted projection',
    ),
    PinholeInversionEntry(
      arabicInversion: 'كُلَّمَا ضَاقَ قُطْرُ الثَّقْبِ فِي سِتَارِ الحُجْرَةِ، زَادَتْ حِدَّةُ التَّفَاصِيلِ وَقَلَّ تَدَاخُلُ الأَشِعَّةِ',
      germanInversion: 'Je enger der Durchmesser der Lochblende in der Kammerwand gewählt wird, desto schärfer zeichnen sich die Konturen ab',
      englishInversion: 'The narrower the aperture diameter in the chamber partition, the sharper the contours and the less ray interference',
      opticalPrinciple: 'Aperture-diameter optimization balancing geometric sharpness against diffraction blurring',
    ),
  ];
}
