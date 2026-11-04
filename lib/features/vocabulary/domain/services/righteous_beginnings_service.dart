class BeginningsVirtueTerm {
  final String virtueName;
  final String arabic;
  final String german;
  final String english;
  final String moralGuideline;

  const BeginningsVirtueTerm({
    required this.virtueName,
    required this.arabic,
    required this.german,
    required this.english,
    required this.moralGuideline,
  });
}

class RighteousBeginningsService {
  static List<BeginningsVirtueTerm> getTerms() {
    return const [
      BeginningsVirtueTerm(
        virtueName: 'البداءة باسم الله في كل عمل نافع (Beginning with Divine Grace)',
        arabic: 'البِدَايَةُ بِاسْمِ اللهِ تُضْفِي البَرَكَةَ عَلَى كُلِّ صَنْعَةٍ',
        german: 'Der Beginn im Namen Gottes schenkt jedem nützlichen Werk reichen Segen.',
        english: 'Beginning in the name of God bestows blessing upon every beneficial craft.',
        moralGuideline: 'افتتاح المهام بذكر الله يطرد العجز والكسل ويبعث النشاط والعزم الصادق.',
      ),
      BeginningsVirtueTerm(
        virtueName: 'الثبات حتى التمام والكمال (Perseverance to Completion)',
        arabic: 'حُسْنُ الخِتَامِ ثَمَرَةُ الصِّدْقِ فِي الابْتِدَاءِ',
        german: 'Ein vollendeter Abschluss ist die reife Frucht aufrichtigen Beginns.',
        english: 'An excellent completion is the ripe fruit of a sincere beginning.',
        moralGuideline: 'المواصلة والصبر على مشاق الطريق تبلغ بالصانع غاية الإحسان.',
      ),
    ];
  }
}
