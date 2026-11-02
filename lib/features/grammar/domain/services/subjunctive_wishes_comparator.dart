class WishStructureGuide {
  final String moodCategory;
  final String arFormula;
  final String deFormula;
  final String enFormula;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const WishStructureGuide({
    required this.moodCategory,
    required this.arFormula,
    required this.deFormula,
    required this.enFormula,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class SubjunctiveWishesComparator {
  static List<WishStructureGuide> getWishGuides() {
    return const [
      WishStructureGuide(
        moodCategory: 'الرجاء المؤدب والأمل الممكن (Hope & Polite Wish)',
        arFormula: 'أَرْجُو أَنْ / عَسَى أَنْ + الفِعْلُ المُضَارِعُ المَنْصُوبُ',
        deFormula: 'hoffen, dass... (Nebensatz: Verb am Ende) / möchten gern',
        enFormula: 'I hope that + Present Simple / would like to + base form',
        exampleAr: 'أَرْجُو أَنْ تَنْتَفِعَ بِهَذَا العِلْمِ',
        exampleDe: 'Ich hoffe, dass du von diesem Wissen profitierst.',
        exampleEn: 'I hope that you benefit from this knowledge.',
      ),
      WishStructureGuide(
        moodCategory: 'التمني غير المتحقق (Unreal Wish / Konjunktiv II)',
        arFormula: 'لَيْتَ (حرف تمنٍّ ناسخ ينصب الاسم)',
        deFormula: 'Wenn... doch nur + Konjunktiv II (hätte / wäre)',
        enFormula: 'I wish + Past Simple / Past Perfect',
        exampleAr: 'يَا لَيْتَ العَمَلَ يُنْجَزُ سَرِيعًا',
        exampleDe: 'Wenn die Arbeit doch nur vollendet wäre!',
        exampleEn: 'I wish the work were accomplished swiftly.',
      ),
    ];
  }
}
