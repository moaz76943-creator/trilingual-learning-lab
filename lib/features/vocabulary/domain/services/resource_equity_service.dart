class ResourceEquityTerm {
  final String equityDomain;
  final String arabic;
  final String german;
  final String english;
  final String communityValue;

  const ResourceEquityTerm({
    required this.equityDomain,
    required this.arabic,
    required this.german,
    required this.english,
    required this.communityValue,
  });
}

class ResourceEquityService {
  static List<ResourceEquityTerm> getTerms() {
    return const [
      ResourceEquityTerm(
        equityDomain: 'قسمة الموارد المشتركة بالقسط (Fair Common Resource Allocation)',
        arabic: 'قِسْمَةُ المَوَارِدِ المُشْتَرَكَةِ بِالقِسْطِ دُونَ مُمَاكَسَةٍ أَوْ إِضْرَارٍ',
        german: 'Gerechte Zuteilung gemeinsamer Ressourcen ohne Benachteiligung oder Schaden.',
        english: 'Equitable allocation of shared resources without prejudice or harm.',
        communityValue: 'الماء والكلأ حق عام للمجتمع يجب تدبيره بأمانة ومسؤولية جماعية.',
      ),
      ResourceEquityTerm(
        equityDomain: 'التناوب التراحمي عند الشح (Compassionate Rationing)',
        arabic: 'التَّعَاوُنُ فِي تَوْزِيعِ النُّوَبِ عِنْدَ قِلَّةِ الصَّبِيبِ',
        german: 'Brüderliche Absprache der Bewässerungszeiten bei geringem Wasserstand.',
        english: 'Compassionate coordination of turns when water flow is scarce.',
        communityValue: 'إيثار المصلحة العامة وتقديم حاجات البساتين الأشد عطشاً.',
      ),
    ];
  }
}
