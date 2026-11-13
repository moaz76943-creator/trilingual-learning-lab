import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// Target language for phonetic acoustic analysis
enum PhoneticLanguage {
  arabic(
    nameAr: 'العَرَبِيَّةُ الفُصْحَى (مَخَارِجُ الحُرُوفِ)',
    nameDe: 'Klassisches Arabisch (Artikulation)',
    nameEn: 'Vocalized Arabic (Phonetics)',
  ),
  german(
    nameAr: 'الأَلْمَانِيَّةُ (حُرُوفُ الإِمَالَةِ Umlaute)',
    nameDe: 'Standarddeutsch (Umlaute & Vokale)',
    nameEn: 'Standard German (Vowel Contrasts)',
  ),
  english(
    nameAr: 'الإِنْجِلِيزِيَّةُ (أَصْوَاتُ العِلَّةِ المَرْخِيَّةِ)',
    nameDe: 'Englisch (Vokalpaare & Diphthonge)',
    nameEn: 'Academic English (Tense/Lax Vowels)',
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;

  const PhoneticLanguage({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
  });
}

/// Acoustic Vowel Landmark defined by Formant F1 (openness) and Formant F2 (frontness)
class FormantVowel {
  final String ipaSymbol;
  final String arabicLabel;
  final String exampleWord;
  final double f1Hz; // First formant (typically 250 - 900 Hz)
  final double f2Hz; // Second formant (typically 700 - 2600 Hz)

  const FormantVowel({
    required this.ipaSymbol,
    required this.arabicLabel,
    required this.exampleWord,
    required this.f1Hz,
    required this.f2Hz,
  });

  /// Convert frequency in Hz to Bark scale:
  /// Bark = 13 * atan(0.00076 * f) + 3.5 * atan((f / 7500)^2)
  double get f1Bark => _hzToBark(f1Hz);
  double get f2Bark => _hzToBark(f2Hz);

  static double _hzToBark(double f) {
    return 13.0 * math.atan(0.00076 * f) + 3.5 * math.atan(math.pow(f / 7500.0, 2).toDouble());
  }
}

/// Trilingual Minimal Pair for Auditory & Pronunciation Discrimination
class MinimalPairExercise {
  final String id;
  final PhoneticLanguage language;
  final String wordA;
  final String wordB;
  final String ipaA;
  final String ipaB;
  final String meaningArA;
  final String meaningArB;
  final String contrastingFeatureAr;
  final FormantVowel vowelA;
  final FormantVowel vowelB;

  const MinimalPairExercise({
    required this.id,
    required this.language,
    required this.wordA,
    required this.wordB,
    required this.ipaA,
    required this.ipaB,
    required this.meaningArA,
    required this.meaningArB,
    required this.contrastingFeatureAr,
    required this.vowelA,
    required this.vowelB,
  });

  static const List<MinimalPairExercise> catalog = [
    // Arabic Minimal Pairs
    MinimalPairExercise(
      id: 'ar_qalb_kalb',
      language: PhoneticLanguage.arabic,
      wordA: 'قَلْبٌ',
      wordB: 'كَلْبٌ',
      ipaA: '/qalb/',
      ipaB: '/kalb/',
      meaningArA: 'عُضْوُ الفُؤَادِ',
      meaningArB: 'الحَيَوَانُ الأَلِيفُ',
      contrastingFeatureAr: 'القَافُ اللَّهَوِيَّةُ /q/ مُقَابِلَ الكَافِ الشَّجَرِيَّةِ /k/',
      vowelA: FormantVowel(ipaSymbol: '/a/', arabicLabel: 'فَتْحَةٌ مُفَخَّمَةٌ', exampleWord: 'قَلْبٌ', f1Hz: 750, f2Hz: 1200),
      vowelB: FormantVowel(ipaSymbol: '/æ/', arabicLabel: 'فَتْحَةٌ مُرَقَّقَةٌ', exampleWord: 'كَلْبٌ', f1Hz: 700, f2Hz: 1650),
    ),
    MinimalPairExercise(
      id: 'ar_sar_saar',
      language: PhoneticLanguage.arabic,
      wordA: 'صَارَ',
      wordB: 'سَارَ',
      ipaA: '/sˤaːr/',
      ipaB: '/saːr/',
      meaningArA: 'تَحَوَّلَ وَأَصْبَحَ',
      meaningArB: 'مَشَى وَانْطَلَقَ',
      contrastingFeatureAr: 'الصَّادُ المُطْبَقَةُ المُفَخَّمَةُ /sˤ/ مُقَابِلَ السِّينِ المَهْمُوسَةِ /s/',
      vowelA: FormantVowel(ipaSymbol: '/ɑː/', arabicLabel: 'أَلِفُ إِطْبَاقٍ', exampleWord: 'صَارَ', f1Hz: 780, f2Hz: 1150),
      vowelB: FormantVowel(ipaSymbol: '/aː/', arabicLabel: 'أَلِفُ تَرْقِيقٍ', exampleWord: 'سَارَ', f1Hz: 680, f2Hz: 1700),
    ),
    // German Minimal Pairs
    MinimalPairExercise(
      id: 'de_schon_schoen',
      language: PhoneticLanguage.german,
      wordA: 'schon',
      wordB: 'schön',
      ipaA: '/ʃoːn/',
      ipaB: '/ʃøːn/',
      meaningArA: 'بِالفِعْلِ / سَابِقاً (already)',
      meaningArB: 'جَمِيلٌ / حَسَنٌ (beautiful)',
      contrastingFeatureAr: 'حَرْفُ العِلَّةِ الخَلْفِيُّ /oː/ مُقَابِلَ المُمَالِ المُدَوَّرِ /øː/',
      vowelA: FormantVowel(ipaSymbol: '/oː/', arabicLabel: 'واوٌ مَضْمُومَةٌ خَلْفِيَّةٌ', exampleWord: 'schon', f1Hz: 400, f2Hz: 850),
      vowelB: FormantVowel(ipaSymbol: '/øː/', arabicLabel: 'أُومْلاوت ö أَمَامِيٌّ مُدَوَّرٌ', exampleWord: 'schön', f1Hz: 380, f2Hz: 1600),
    ),
    MinimalPairExercise(
      id: 'de_mutter_muetter',
      language: PhoneticLanguage.german,
      wordA: 'Mutter',
      wordB: 'Mütter',
      ipaA: '/ˈmʊtɐ/',
      ipaB: '/ˈmʏtɐ/',
      meaningArA: 'أُمٌّ (singular)',
      meaningArB: 'أُمَّهَاتٌ (plural)',
      contrastingFeatureAr: 'الضَّمَّةُ القَصِيرَةُ /ʊ/ مُقَابِلَ أُومْلاوت ü المُرَقَّقَةِ /ʏ/',
      vowelA: FormantVowel(ipaSymbol: '/ʊ/', arabicLabel: 'ضَمَّةٌ مُرْتَخِيَةٌ', exampleWord: 'Mutter', f1Hz: 460, f2Hz: 1050),
      vowelB: FormantVowel(ipaSymbol: '/ʏ/', arabicLabel: 'ضَمَّةٌ مُمَالَةٌ أَمَامِيَّةٌ', exampleWord: 'Mütter', f1Hz: 420, f2Hz: 1750),
    ),
    // English Minimal Pairs
    MinimalPairExercise(
      id: 'en_ship_sheep',
      language: PhoneticLanguage.english,
      wordA: 'ship',
      wordB: 'sheep',
      ipaA: '/ʃɪp/',
      ipaB: '/ʃiːp/',
      meaningArA: 'سَفِينَةٌ بَحْرِيَّةٌ',
      meaningArB: 'خَرُوفٌ / شَاةٌ',
      contrastingFeatureAr: 'الكَسْرَةُ المُرْتَخِيَةُ القَصِيرَةُ /ɪ/ مُقَابِلَ الكَسْرَةِ المَشْدُودَةِ الطَّوِيلَةِ /iː/',
      vowelA: FormantVowel(ipaSymbol: '/ɪ/', arabicLabel: 'كَسْرَةٌ مُرْتَخِيَةٌ (lax)', exampleWord: 'ship', f1Hz: 430, f2Hz: 1950),
      vowelB: FormantVowel(ipaSymbol: '/iː/', arabicLabel: 'يَاءُ مَدٍّ مَشْدُودَةٌ (tense)', exampleWord: 'sheep', f1Hz: 290, f2Hz: 2350),
    ),
    MinimalPairExercise(
      id: 'en_think_sink',
      language: PhoneticLanguage.english,
      wordA: 'think',
      wordB: 'sink',
      ipaA: '/θɪŋk/',
      ipaB: '/sɪŋk/',
      meaningArA: 'يُفَكِّرُ / يَعْتَقِدُ',
      meaningArB: 'يَغْرَقُ / مَغْسَلَةٌ',
      contrastingFeatureAr: 'الثَّاءُ اللِّثَوِيَّةُ /θ/ مُقَابِلَ السِّينِ الصَّفِيرِيَّةِ /s/',
      vowelA: FormantVowel(ipaSymbol: '/θ/', arabicLabel: 'ثَاءٌ لِثَوِيَّةٌ', exampleWord: 'think', f1Hz: 450, f2Hz: 1900),
      vowelB: FormantVowel(ipaSymbol: '/s/', arabicLabel: 'سِينٌ لِثَوِيَّةٌ صَفِيرِيَّةٌ', exampleWord: 'sink', f1Hz: 450, f2Hz: 1900),
    ),
  ];
}

/// State representation for Formant Phonetic Trainer
class FormantPhoneticTrainerState {
  final PhoneticLanguage language;
  final MinimalPairExercise selectedExercise;
  final bool targetIsWordA; // true if target is Word A, false if Word B
  final double userCurrentF1Hz; // Real-time user voiced F1 (jaw/openness)
  final double userCurrentF2Hz; // Real-time user voiced F2 (tongue position)
  final double fundamentalPitchF0Hz; // Fundamental pitch frequency (80 to 400 Hz)
  final bool isMicrophoneActive;
  final double acousticClosenessScore; // 0.0 to 100.0% match with target
  final int correctDiscriminationsCount;
  final int totalAttemptsCount;

  const FormantPhoneticTrainerState({
    required this.language,
    required this.selectedExercise,
    required this.targetIsWordA,
    required this.userCurrentF1Hz,
    required this.userCurrentF2Hz,
    required this.fundamentalPitchF0Hz,
    required this.isMicrophoneActive,
    required this.acousticClosenessScore,
    required this.correctDiscriminationsCount,
    required this.totalAttemptsCount,
  });

  factory FormantPhoneticTrainerState.initial() {
    final firstExercise = MinimalPairExercise.catalog.first;
    return FormantPhoneticTrainerState(
      language: PhoneticLanguage.arabic,
      selectedExercise: firstExercise,
      targetIsWordA: true,
      userCurrentF1Hz: 740.0,
      userCurrentF2Hz: 1220.0,
      fundamentalPitchF0Hz: 135.0,
      isMicrophoneActive: true,
      acousticClosenessScore: 94.5,
      correctDiscriminationsCount: 8,
      totalAttemptsCount: 9,
    );
  }

  FormantVowel get targetVowel =>
      targetIsWordA ? selectedExercise.vowelA : selectedExercise.vowelB;

  String get targetWord =>
      targetIsWordA ? selectedExercise.wordA : selectedExercise.wordB;

  String get targetIpa =>
      targetIsWordA ? selectedExercise.ipaA : selectedExercise.ipaB;

  /// Calculate Euclidean distance in Bark space between user formants and target
  double get barkEuclideanDistance {
    final targetF1Bark = targetVowel.f1Bark;
    final targetF2Bark = targetVowel.f2Bark;
    final userF1Bark = FormantVowel._hzToBark(userCurrentF1Hz);
    final userF2Bark = FormantVowel._hzToBark(userCurrentF2Hz);

    final d1 = userF1Bark - targetF1Bark;
    final d2 = userF2Bark - targetF2Bark;
    return math.sqrt(d1 * d1 + d2 * d2);
  }

  FormantPhoneticTrainerState copyWith({
    PhoneticLanguage? language,
    MinimalPairExercise? selectedExercise,
    bool? targetIsWordA,
    double? userCurrentF1Hz,
    double? userCurrentF2Hz,
    double? fundamentalPitchF0Hz,
    bool? isMicrophoneActive,
    double? acousticClosenessScore,
    int? correctDiscriminationsCount,
    int? totalAttemptsCount,
  }) {
    return FormantPhoneticTrainerState(
      language: language ?? this.language,
      selectedExercise: selectedExercise ?? this.selectedExercise,
      targetIsWordA: targetIsWordA ?? this.targetIsWordA,
      userCurrentF1Hz: userCurrentF1Hz ?? this.userCurrentF1Hz,
      userCurrentF2Hz: userCurrentF2Hz ?? this.userCurrentF2Hz,
      fundamentalPitchF0Hz:
          fundamentalPitchF0Hz ?? this.fundamentalPitchF0Hz,
      isMicrophoneActive: isMicrophoneActive ?? this.isMicrophoneActive,
      acousticClosenessScore:
          acousticClosenessScore ?? this.acousticClosenessScore,
      correctDiscriminationsCount:
          correctDiscriminationsCount ?? this.correctDiscriminationsCount,
      totalAttemptsCount: totalAttemptsCount ?? this.totalAttemptsCount,
    );
  }
}

/// Controller managing Formant Analysis and Minimal Pair Training
class FormantPhoneticTrainerController extends ChangeNotifier {
  FormantPhoneticTrainerState _state = FormantPhoneticTrainerState.initial();

  FormantPhoneticTrainerState get state => _state;

  void setLanguage(PhoneticLanguage lang) {
    final available = MinimalPairExercise.catalog
        .where((e) => e.language == lang)
        .toList();
    final first = available.isNotEmpty ? available.first : MinimalPairExercise.catalog.first;

    _state = _state.copyWith(
      language: lang,
      selectedExercise: first,
      targetIsWordA: true,
      userCurrentF1Hz: first.vowelA.f1Hz,
      userCurrentF2Hz: first.vowelA.f2Hz,
    );
    _recalculateScore();
    notifyListeners();
  }

  void selectExercise(MinimalPairExercise exercise) {
    _state = _state.copyWith(
      selectedExercise: exercise,
      language: exercise.language,
      targetIsWordA: true,
      userCurrentF1Hz: exercise.vowelA.f1Hz,
      userCurrentF2Hz: exercise.vowelA.f2Hz,
    );
    _recalculateScore();
    notifyListeners();
  }

  void switchTargetWord(bool isWordA) {
    _state = _state.copyWith(targetIsWordA: isWordA);
    _recalculateScore();
    notifyListeners();
  }

  void updateUserFormants({required double f1Hz, required double f2Hz}) {
    final clampedF1 = f1Hz.clamp(200.0, 1000.0);
    final clampedF2 = f2Hz.clamp(600.0, 3000.0);
    _state = _state.copyWith(
      userCurrentF1Hz: clampedF1,
      userCurrentF2Hz: clampedF2,
    );
    _recalculateScore();
    notifyListeners();
  }

  void toggleMicrophone() {
    _state = _state.copyWith(isMicrophoneActive: !_state.isMicrophoneActive);
    notifyListeners();
  }

  /// Simulate acoustic discrimination attempt
  bool submitDiscriminationGuess(bool guessedWordA) {
    final isCorrect = (guessedWordA == _state.targetIsWordA);
    final attempts = _state.totalAttemptsCount + 1;
    final correct = _state.correctDiscriminationsCount + (isCorrect ? 1 : 0);

    _state = _state.copyWith(
      totalAttemptsCount: attempts,
      correctDiscriminationsCount: correct,
    );
    notifyListeners();
    return isCorrect;
  }

  void _recalculateScore() {
    final distBark = _state.barkEuclideanDistance;
    // Bark distance < 1.0 is near native, > 4.0 is distinct mismatch
    final score = ((1.0 - (distBark / 4.0)).clamp(0.0, 1.0)) * 100.0;
    _state = _state.copyWith(acousticClosenessScore: score);
  }

  void reset() {
    _state = FormantPhoneticTrainerState.initial();
    notifyListeners();
  }
}
