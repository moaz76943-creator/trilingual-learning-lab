class FrequencyAdverbItem {
  final String scalePercent;
  final String arabic;
  final String german;
  final String english;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const FrequencyAdverbItem({
    required this.scalePercent,
    required this.arabic,
    required this.german,
    required this.english,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class FrequencyAdverbsService {
  static List<FrequencyAdverbItem> getCoreFrequencyAdverbs() {
    return const [
      FrequencyAdverbItem(
        scalePercent: '100%',
        arabic: 'دَائِمًا / أَبَدًا',
        german: 'immer / stets',
        english: 'always',
        exampleAr: 'يَعْمَلُ الصَّانِعُ دَائِمًا بِأَمَانَةٍ',
        exampleDe: 'Der Handwerker arbeitet stets ehrlich.',
        exampleEn: 'The artisan always works honestly.',
      ),
      FrequencyAdverbItem(
        scalePercent: '75%',
        arabic: 'غَالِبًا / كَثِيرًا',
        german: 'oft / meistens',
        english: 'often / usually',
        exampleAr: 'نَلْتَقِي غَالِبًا فِي المَكْتَبَةِ',
        exampleDe: 'Wir treffen uns meistens in der Bibliothek.',
        exampleEn: 'We usually meet in the library.',
      ),
      FrequencyAdverbItem(
        scalePercent: '50%',
        arabic: 'أَحْيَانًا / تَارَةً',
        german: 'manchmal',
        english: 'sometimes',
        exampleAr: 'يَسْتَرِيحُ العَامِلُ أَحْيَانًا',
        exampleDe: 'Manchmal ruht sich der Arbeiter aus.',
        exampleEn: 'The worker sometimes takes a rest.',
      ),
    ];
  }
}
