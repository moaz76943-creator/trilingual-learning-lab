class RuralHospitalityTerm {
  final String theme;
  final String arabic;
  final String german;
  final String english;
  final String societalRole;

  const RuralHospitalityTerm({
    required this.theme,
    required this.arabic,
    required this.german,
    required this.english,
    required this.societalRole,
  });
}

class RuralHospitalityService {
  static List<RuralHospitalityTerm> getHospitalityTerms() {
    return const [
      RuralHospitalityTerm(
        theme: 'إطعام الطعام بسماحة نفس (Joyful Sharing of Food)',
        arabic: 'إِطْعَامُ الطَّعَامِ عَنْ طِيبِ خَاطِرٍ وَسَخَاءِ نَفْسٍ',
        german: 'Gäste bewirten aus reiner Herzensfreude und wahrer Großmut.',
        english: 'Sharing food with genuine warmth and unpretentious generosity.',
        societalRole: 'بذل ثمار البساتين للزائر وعابر السبيل إكراماً وتفضلاً.',
      ),
      RuralHospitalityTerm(
        theme: 'حق الجوار في مواسم الخير (Neighborly Bounty)',
        arabic: 'إِهْدَاءُ الجِيرَانِ بَاكُورَةَ ثِمَارِ المَحْصُولِ',
        german: 'Den Nachbarn von den ersten und besten Früchten der Ernte schenken.',
        english: 'Gifting neighbors the earliest and finest fruits of the harvest.',
        societalRole: 'نشر المودة وتثبيت أواصر المحبة بين أهل القرية والحي.',
      ),
    ];
  }
}
