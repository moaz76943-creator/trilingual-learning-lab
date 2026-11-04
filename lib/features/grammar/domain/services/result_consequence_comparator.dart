class ResultConsequenceRule {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ResultConsequenceRule({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ResultConsequenceComparator {
  static List<ResultConsequenceRule> getRules() {
    return const [
      ResultConsequenceRule(
        categoryTitle: 'النتيجة المترتبة على شدة الصفة (Degree Consequence: لدرجة أن / so... dass)',
        arConstruction: 'بَلَغَ مِنَ الصِّفَةِ مَبْلَغًا + حَتَّى / لِدَرَجَةِ أَنَّ + جُمْلَةُ النَّتِيجَةِ',
        deConstruction: 'so + Adjektiv / Adverb (im Hauptsatz) ... dass (im Nebensatz: Verb am Ende)',
        enConstruction: 'so + adjective / adverb ... that + clause',
        exampleAr: 'طَمَرَ الصَّانِعُ المَفْحَمَةَ بِإِحْكَامٍ حَتَّى كَتَمَ اللَّهِيبَ تَمَامًا',
        exampleDe: 'Der Köhler deckte den Meiler so dicht ab, dass die Flammen erloschen.',
        exampleEn: 'The charcoal burner covered the mound so tightly that the flames were quelled.',
      ),
      ResultConsequenceRule(
        categoryTitle: 'النتيجة الحاصلة كأثر مباشر (Direct Consequence: فـ / sodass)',
        arConstruction: 'فِعْلٌ ... فَـ (السَّبَبِيَّةُ الرَّابِطَةُ) + نَتِيجَةٌ مَنْصُوبَةٌ أَوْ مُسْتَأْنَفَةٌ',
        deConstruction: 'sodass (als einteilige Subjunktion am Nebensatzanfang: Verb am Ende)',
        enConstruction: 'sodass / with the result that + clause',
        exampleAr: 'احْتَرَقَ الخَشَبُ بِبُطْءٍ دُونَ أُكْسِجِينٍ فَصَارَ فَحْمًا صُلْبًا نَقِيًّا',
        exampleDe: 'Das Holz glimmt ohne Sauerstoff, sodass es zu reiner Kohle wird.',
        exampleEn: 'The wood smolders without oxygen, so that it turns into pure charcoal.',
      ),
    ];
  }
}
