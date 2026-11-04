class WisdomInscriptionTerm {
  final String virtueName;
  final String arabic;
  final String german;
  final String english;
  final String moralImpact;

  const WisdomInscriptionTerm({
    required this.virtueName,
    required this.arabic,
    required this.german,
    required this.english,
    required this.moralImpact,
  });
}

class WisdomInscriptionsService {
  static List<WisdomInscriptionTerm> getTerms() {
    return const [
      WisdomInscriptionTerm(
        virtueName: 'الصدق منجاة وبركة (Truthfulness is Salvation)',
        arabic: 'عَلَيْكُمْ بِالصِّدْقِ؛ فَإِنَّ الصِّدْقَ يَهْدِي إِلَى البِرِّ',
        german: 'Haltet an der Wahrhaftigkeit fest; denn die Wahrheit führt zur Rechtschaffenheit.',
        english: 'Hold firmly to truthfulness; for truthfulness leads to righteousness.',
        moralImpact: 'تذكير الأسر والأجيال بأن النجاة والكرامة مقرونتان بالصدق في القول والعمل.',
      ),
      WisdomInscriptionTerm(
        virtueName: 'حفظ اللسان وطيب المعشر (Gentle Speech and Restraint)',
        arabic: 'مَنْ كَانَ يُؤْمِنُ بِاللهِ وَاليَوْمِ الآخِرِ فَلْيَقُلْ خَيْرًا أَوْ لِيَصْمُتْ',
        german: 'Wer an Gott glaubt, der spreche Gutes oder schweige.',
        english: 'Whoever believes in God should speak good or remain silent.',
        moralImpact: 'إشاعة السلام وطهارة الألسن عن اللغو وتغذية المجالس بالقول الهادف.',
      ),
    ];
  }
}
