class PastTenseRuleNote {
  final String language;
  final String structureName;
  final String formula;
  final String example;
  final String explanation;

  const PastTenseRuleNote({
    required this.language,
    required this.structureName,
    required this.formula,
    required this.example,
    required this.explanation,
  });
}

class PastTenseComparator {
  static List<PastTenseRuleNote> comparePastTenses() {
    return const [
      PastTenseRuleNote(
        language: 'ar',
        structureName: 'الفِعْلُ المَاضِي',
        formula: 'فَعَلَ + ضَمَائِرُ الرَّفْعِ المُتَّصِلَةِ (تُ، نَا، تَ...)',
        example: 'سَافَرْتُ صَبَاحًا',
        explanation: 'يدل على حدث وقع وانتهى في الزمن الماضي بصيغة مباشرة وموجزة.',
      ),
      PastTenseRuleNote(
        language: 'de',
        structureName: 'Das Perfekt (Gesprochene Vergangenheit)',
        formula: 'Hilfsverb (haben / sein) + Partizip II am Satzende',
        example: 'Ich bin am Morgen gereist.',
        explanation: 'الزمن الأكثر استخداماً في الحديث اليومي، مع وضع اسم المفعول في نهاية الجملة.',
      ),
      PastTenseRuleNote(
        language: 'en',
        structureName: 'Simple Past',
        formula: 'Subject + Verb-ed (or Irregular 2nd form)',
        example: 'I traveled in the morning.',
        explanation: 'الزمن المباشر للتعبير عن أفعال اكتملت في وقت محدد في الماضي.',
      ),
    ];
  }
}
