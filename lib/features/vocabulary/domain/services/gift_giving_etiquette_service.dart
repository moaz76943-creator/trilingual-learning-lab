class GiftEtiquettePhrase {
  final String occasion;
  final String arabic;
  final String german;
  final String english;
  final String socialWisdom;

  const GiftEtiquettePhrase({
    required this.occasion,
    required this.arabic,
    required this.german,
    required this.english,
    required this.socialWisdom,
  });
}

class GiftGivingEtiquetteService {
  static List<GiftEtiquettePhrase> getEtiquettePhrases() {
    return const [
      GiftEtiquettePhrase(
        occasion: 'تقديم الهدية بمحبة وتواضع (Presenting a Gift)',
        arabic: 'تَهَادَوْا تَحَابُّوا، هَذِهِ هَدِيَّةٌ يَسِيرَةٌ مِنْ صَمِيمِ القَلْبِ',
        german: 'Schenkt einander, so wächst die Zuneigung; dies ist eine herzliche Aufmerksamkeit.',
        english: 'Exchange gifts to foster mutual love; this is a modest gift from the heart.',
        socialWisdom: 'الهدية مفتاح القلوب وتزيل الكلفة وتوثق عرى الأخوة الصادقة.',
      ),
      GiftEtiquettePhrase(
        occasion: 'قبول الهدية بالدعاء الصالح (Accepting with Gratitude)',
        arabic: 'قَبِلَ اللهُ مِنْكُمْ، وَبَارَكَ لَكُمْ فِي رِزْقِكُمْ وَأَهْلِكُمْ',
        german: 'Möge Gott Ihre Güte annehmen und Ihr Haus und Wohl segnen.',
        english: 'May God accept your kindness and bless your livelihood and family.',
        socialWisdom: 'رد الإحسان بالدعاء الجميل والثناء الحسن من مكارم الشريعة.',
      ),
    ];
  }
}
