class KnowledgeVirtueTerm {
  final String virtueTheme;
  final String arabic;
  final String german;
  final String english;
  final String moralGuideline;

  const KnowledgeVirtueTerm({
    required this.virtueTheme,
    required this.arabic,
    required this.german,
    required this.english,
    required this.moralGuideline,
  });
}

class KnowledgeVenerationService {
  static List<KnowledgeVirtueTerm> getVirtues() {
    return const [
      KnowledgeVirtueTerm(
        virtueTheme: 'توقير العلماء وحملة المعرفة (Veneration of Scholars)',
        arabic: 'تَوْقِيرُ أَهْلِ العِلْمِ وَالأَدَبِ عِنْدَ مُجَالَسَتِهِمْ وَمُحَاوَرَتِهِمْ',
        german: 'Ehrfurcht vor den Gelehrten und Meistern im Gespräch und Miteinander.',
        english: 'Veneration of scholars and masters of knowledge in discourse and presence.',
        moralGuideline: 'حسن الاستماع والتواضع للمعلم مفتاح الفتح والفهم الدقيق.',
      ),
      KnowledgeVirtueTerm(
        virtueTheme: 'بذل الكتاب وإعارة المعرفة (Generosity with Books)',
        arabic: 'زَكَاةُ العِلْمِ نَشْرُهُ، وَكَرَمُ الوَرَّاقِ إِعَارَةُ الكِتَابِ لِطَالِبِهِ',
        german: 'Die Frucht des Wissens ist seine Verbreitung, und Edelsinn zeigt sich im Verleihen des Buches.',
        english: 'The charity of knowledge is its dissemination, and nobility lies in sharing books with seekers.',
        moralGuideline: 'عدم احتكار العلم أو حبسه عن الراغبين في النفع والبناء.',
      ),
    ];
  }
}
