class RiverStewardshipTerm {
  final String domain;
  final String arabic;
  final String german;
  final String english;
  final String ecologicalJustice;

  const RiverStewardshipTerm({
    required this.domain,
    required this.arabic,
    required this.german,
    required this.english,
    required this.ecologicalJustice,
  });
}

class RiverStewardshipService {
  static List<RiverStewardshipTerm> getStewardshipTerms() {
    return const [
      RiverStewardshipTerm(
        domain: 'عدالة قسمة مياه النهر (Equitable Water Distribution)',
        arabic: 'قِسْمَةُ المِيَاهِ بِالقِسْطِ بَيْنَ أَعْلَى الوَادِي وَأَسْفَلِهِ',
        german: 'Gerechte Verteilung des Wassers zwischen Ober- und Unterlauf des Tals.',
        english: 'Equitable allocation of water between upstream and downstream farmers.',
        ecologicalJustice: 'يسقي الأعلى إلى الكعبين ثم يرسل الماء لمن يليه دون حبس أو استئثار.',
      ),
      RiverStewardshipTerm(
        domain: 'صون مجاري الأنهار (Stream Protection)',
        arabic: 'صِيَانَةُ ضِفَافِ الأَنْهَارِ وَتَشْجِيرُهَا لِمَنْعِ الانْجِرَافِ',
        german: 'Reinhaltung und Bepflanzung der Flussufer zum Schutz vor Erdrutsch.',
        english: 'Preserving and planting riverbanks to prevent soil erosion.',
        ecologicalJustice: 'جذور الأشجار تثبت ضفاف المجرى وتضمن بقاء الماء عذباً رقراقاً.',
      ),
    ];
  }
}
