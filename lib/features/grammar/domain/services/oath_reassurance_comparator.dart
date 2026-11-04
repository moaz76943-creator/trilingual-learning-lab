class OathRuleGuide {
  final String categoryTitle;
  final String arPattern;
  final String dePattern;
  final String enPattern;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const OathRuleGuide({
    required this.categoryTitle,
    required this.arPattern,
    required this.dePattern,
    required this.enPattern,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class OathReassuranceComparator {
  static List<OathRuleGuide> getRules() {
    return const [
      OathRuleGuide(
        categoryTitle: 'أسلوب القسم المقترن بنون التوكيد (Solemn Affirmation)',
        arPattern: 'واو القسم + المقسم به المجرور + لام القسم + الفعل المضارع المتصل بنون التوكيد',
        dePattern: 'Bekräftigungspartikeln: "wahrlich", "gewiss", "bei Gott"',
        enPattern: 'Solemn assurance: "by God", "truly", "most certainly"',
        exampleAr: 'وَاللهِ لَأُتْقِنَنَّ صِنَاعَةَ القِرْبَةِ لِتَحْفَظَ المَاءَ',
        exampleDe: 'Wahrlich, ich werde den Wasserschlauch gewissenhaft fertigen.',
        exampleEn: 'By God, I shall certainly craft the waterskin with utmost care.',
      ),
      OathRuleGuide(
        categoryTitle: 'التوكيد اللفظي بإنَّ واللام المزحلقة (Structural Emphatic Confirmation)',
        arPattern: 'إِنَّ (حرف ناسخ) + اسمها المنصوب + لام الابتداء المزحلقة في الخبر',
        dePattern: 'Fokusadverbien der Gewissheit: "in der Tat", "zweifellos"',
        enPattern: 'Emphatic assertions: "indeed", "undoubtedly"',
        exampleAr: 'إِنَّ المَاءَ البَارِدَ فِي السَّفَرِ لَنِعْمَةٌ عَظِيمَةٌ',
        exampleDe: 'In der Tat ist kühles Wasser auf der Reise ein wahrer Segen.',
        exampleEn: 'Indeed, cool water on a journey is a truly great blessing.',
      ),
    ];
  }
}
