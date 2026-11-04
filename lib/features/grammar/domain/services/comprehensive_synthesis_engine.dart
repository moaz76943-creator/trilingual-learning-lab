class SynthesisSummary {
  final String linguisticPillar;
  final String arabicRule;
  final String germanRule;
  final String englishRule;

  const SynthesisSummary({
    required this.linguisticPillar,
    required this.arabicRule,
    required this.germanRule,
    required this.englishRule,
  });
}

class ComprehensiveSynthesisEngine {
  static List<SynthesisSummary> getCorePillars() {
    return const [
      SynthesisSummary(
        linguisticPillar: 'بنية الجملة وموقع الفعل (Sentence Structure & Verb Position)',
        arabicRule: 'الجملة الفعلية (فعل + فاعل + مفعول) أو اسمية (مبتدأ + خبر) بمرونة بلاغية.',
        germanRule: 'Hauptsatz: Verb auf Position 2 | Nebensatz: finites Verb zwingend am Satzende.',
        englishRule: 'Strict SVO order in standard declarative main and subordinate clauses.',
      ),
      SynthesisSummary(
        linguisticPillar: 'التوافق النعتي والإعرابي (Agreement & Declension)',
        arabicRule: 'النعت يتبع المنعوت في أربعة من عشرة: الإعراب، والتعريف، والتذكير، والعدد.',
        germanRule: 'Adjektivdeklination: Endung (-e, -en, -er, -es) nach Artikel und Kasus.',
        englishRule: 'Invariable adjectives preceding the modified noun regardless of case or gender.',
      ),
      SynthesisSummary(
        linguisticPillar: 'روح البلاغة والتهذيب (Rhetoric & Ethical Discourse)',
        arabicRule: 'البلاغة مطابقة الكلام لمقتضى الحال مع فصاحة اللفظ وحسن القصد.',
        germanRule: 'Höfliche Distanz und präzise Sachlichkeit durch Konjunktiv II und Respektformen.',
        englishRule: 'Polite indirectness and clear, encouraging diction fostering understanding.',
      ),
    ];
  }
}
