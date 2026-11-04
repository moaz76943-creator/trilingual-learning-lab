class TravelPreparednessValue {
  final String theme;
  final String arabic;
  final String german;
  final String english;
  final String ethicalVirtue;

  const TravelPreparednessValue({
    required this.theme,
    required this.arabic,
    required this.german,
    required this.english,
    required this.ethicalVirtue,
  });
}

class WayfarerPreparednessService {
  static List<TravelPreparednessValue> getPreparednessValues() {
    return const [
      TravelPreparednessValue(
        theme: 'إعداد الزاد والماء الكافي (Prudent Provisioning)',
        arabic: 'إِعْدَادُ القِرْبَةِ وَالتَّزَوُّدُ بِالمَاءِ الطَّهُورِ قَبْلَ المَسِيرِ',
        german: 'Die sorgfältige Vorbereitung des Wasserschlauchs mit reinem Trinkwasser vor der Reise.',
        english: 'Careful preparation of the waterskin with pure drinking water prior to departure.',
        ethicalVirtue: 'الأخذ بالأسباب والحيطة وحسن التدبير من كمال العقل والمسؤولية.',
      ),
      TravelPreparednessValue(
        theme: 'إيثار الرفيق وعابر السبيل (Altruistic Hydration)',
        arabic: 'سُقْيَا الرَّفِيقِ وَتَقْدِيمُ حَاجَةِ الضَّعِيفِ عَلَى النَّفْسِ',
        german: 'Dem Reisegefährten den Vortritt beim Trinken lassen und Schwache unterstützen.',
        english: 'Offering water first to companions and prioritizing the vulnerable over oneself.',
        ethicalVirtue: 'الإيثار والكرم في أوقات الشدة ذروة المروءة ومكارم الأخلاق.',
      ),
    ];
  }
}
