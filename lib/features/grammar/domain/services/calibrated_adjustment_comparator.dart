// Task #561: Calibrated Adjustment and Conditional Precision Comparator
class CalibratedAdjustmentEntry {
  final String arabicConditional;
  final String germanConditional;
  final String englishConditional;
  final String metrologicalContext;
  const CalibratedAdjustmentEntry({
    required this.arabicConditional,
    required this.germanConditional,
    required this.englishConditional,
    required this.metrologicalContext,
  });
}

class CalibratedAdjustmentComparator {
  static const List<CalibratedAdjustmentEntry> conditions = [
    CalibratedAdjustmentEntry(
      arabicConditional: 'إِنْ رَجَحَتْ إِحْدَى الكِفَّتَيْنِ، لَزِمَ مُعَايَرَةُ خَيْطِ الشَّاقُولِ',
      germanConditional: 'Sollte eine der Waagschalen sinken, so bedarf das Lotkabel einer Justierung',
      englishConditional: 'Should one of the scale pans tilt, calibrating the plumb line becomes necessary',
      metrologicalContext: 'Conditional correction applied during precision instrument balance',
    ),
    CalibratedAdjustmentEntry(
      arabicConditional: 'لَوْ أَنَّ الصَّنْجَةَ تَآكَلَتْ، لَوَجَبَ اسْتِبْدَالُهَا بِمِعْيَارٍ صَحِيحٍ',
      germanConditional: 'Wäre das Messgewicht abgenutzt, müsste es durch ein genormtes Eichmaß ersetzt werden',
      englishConditional: 'Were the standard weight worn, it would be mandatory to replace it with a certified reference',
      metrologicalContext: 'Hypothetical safeguard against inaccurate commercial transactions',
    ),
  ];
}
