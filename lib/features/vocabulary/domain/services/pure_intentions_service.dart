class PureIntentionTerm {
  final String ethicalDomain;
  final String arabic;
  final String german;
  final String english;
  final String spiritualValue;

  const PureIntentionTerm({
    required this.ethicalDomain,
    required this.arabic,
    required this.german,
    required this.english,
    required this.spiritualValue,
  });
}

class PureIntentionsService {
  static List<PureIntentionTerm> getIntentionTerms() {
    return const [
      PureIntentionTerm(
        ethicalDomain: 'إخلاص القصد في العمل (Sincerity of Purpose)',
        arabic: 'ابْتِغَاءُ وَجْهِ اللهِ وَنَفْعُ النَّاسِ فِي كُلِّ صَنْعَةٍ',
        german: 'Reine Absicht um Gottes willen und der ehrliche Dienst am Nächsten in jedem Werk.',
        english: 'Seeking God\'s pleasure and honest benefit to humanity in every craft.',
        spiritualValue: 'النية الصادقة تحول العمل الحرفي المباح إلى عبادة وقربة مباركة.',
      ),
      PureIntentionTerm(
        ethicalDomain: 'سلامة الصدر من الرياء (Freedom from Pretense)',
        arabic: 'العَمَلُ بِإِتْقَانٍ خَالِصٍ بَعِيدًا عَنِ المُرَاءَاةِ وَالمُبَاهَاةِ',
        german: 'Vollendete Pflichterfüllung frei von Geltungsdrang und eitler Prahlerei.',
        english: 'Masterful duty carried out free from ostentation and vain boastfulness.',
        spiritualValue: 'استقرار النفس وطمأنينة الضمير حين يكون الدافع خالصاً لوجه الحق.',
      ),
    ];
  }
}
