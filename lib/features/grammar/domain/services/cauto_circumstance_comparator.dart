class CausalCircumstanceGuide {
  final String relationType;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const CausalCircumstanceGuide({
    required this.relationType,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class CausalCircumstanceComparator {
  static List<CausalCircumstanceGuide> getRules() {
    return const [
      CausalCircumstanceGuide(
        relationType: 'التعليل بالظرف الدال على الدافع النبيل (Motivated Cause: ابتغاء / zwecks)',
        arConstruction: 'المصدر الصريح المنصوب على الظرفية أو السببية (حِرْصًا عَلَى / قَصْدَ)',
        deConstruction: 'Präposition "zwecks" / "zugunsten" (+ Genitiv)',
        enConstruction: 'For the purpose of / in the interest of + noun',
        exampleAr: 'ضَبَطَ الفَلَّاحُونَ فَتَحَاتِ المَاءِ حِرْصًا عَلَى العَدَالَةِ',
        exampleDe: 'Die Bauern stellten die Wasserschleusen zwecks gerechter Verteilung ein.',
        exampleEn: 'The farmers adjusted the water gates in the interest of fair distribution.',
      ),
      CausalCircumstanceGuide(
        relationType: 'التعليل بالواسطة والسبب الباعث (Instrumental Cause: نظراً لـ / angesichts)',
        arConstruction: 'نَظَرًا لِـ / بِمُقْتَضَى + الاسم المجرور المفسر للحال',
        deConstruction: 'Präposition "angesichts" / "in Anbetracht" (+ Genitiv)',
        enConstruction: 'In view of / in consideration of + noun',
        exampleAr: 'تَنَاوَبَ الجِيرَانُ السُّقْيَا نَظَرًا لِشُحِّ المَطَرِ',
        exampleDe: 'Die Nachbarn wechselten sich beim Gießen ab, angesichts des seltenen Regens.',
        exampleEn: 'The neighbors took turns irrigating, in view of the scarce rain.',
      ),
    ];
  }
}
