import 'package:flutter/foundation.dart';

/// Representation of a letter's proportioned anatomical geometry based on Ibn Muqla's canon.
class ProportionedLetterModel {
  final String letterId;
  final String letterAr;
  final String nameAr;
  final String nameDe;
  final String nameEn;
  final int rhombicDotHeight;
  final int rhombicDotWidth;
  final double circleDiameterRatio;
  final String strokeDescriptionAr;
  final String strokeDescriptionDe;
  final String strokeDescriptionEn;

  const ProportionedLetterModel({
    required this.letterId,
    required this.letterAr,
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.rhombicDotHeight,
    required this.rhombicDotWidth,
    required this.circleDiameterRatio,
    required this.strokeDescriptionAr,
    required this.strokeDescriptionDe,
    required this.strokeDescriptionEn,
  });
}

/// Controller governing the interactive calligraphy studio, rhombic dot grid, and stroke builder.
class CalligraphyStudioController extends ChangeNotifier {
  int _activeLetterIndex = 0; // Default to Alef (الألف)
  double _nibSlantAngleDegrees = 45.0; // Standard 45° Thuluth/Naskh nib cut
  bool _showRhombicGrid = true;
  bool _showCircumscribedCircle = true;
  int _strokeStage = 2; // 0: Head (الرأس), 1: Body (الصدر), 2: Complete (العجز)

  CalligraphyStudioController({
    int initialLetterIndex = 0,
    double initialNibAngle = 45.0,
    bool showGrid = true,
  })  : _activeLetterIndex = initialLetterIndex,
        _nibSlantAngleDegrees = initialNibAngle,
        _showRhombicGrid = showGrid;

  int get activeLetterIndex => _activeLetterIndex;
  double get nibSlantAngleDegrees => _nibSlantAngleDegrees;
  bool get showRhombicGrid => _showRhombicGrid;
  bool get showCircumscribedCircle => _showCircumscribedCircle;
  int get strokeStage => _strokeStage;

  ProportionedLetterModel get activeLetter => letters[_activeLetterIndex];

  static const List<ProportionedLetterModel> letters = [
    ProportionedLetterModel(
      letterId: 'letter_alef',
      letterAr: 'ا',
      nameAr: 'حَرْفُ الأَلِفِ المَنْسُوبُ',
      nameDe: 'Der proportionierte Alif',
      nameEn: 'The Proportioned Alef',
      rhombicDotHeight: 7,
      rhombicDotWidth: 1,
      circleDiameterRatio: 1.0,
      strokeDescriptionAr: 'يَبْدَأُ بِتَرْوِيسَةٍ مَائِلَةٍ، وَيَهْبِطُ مُسْتَقِيمًا بِارْتِفَاعِ سَبْعِ نِقَاطٍ مَعِينِيَّةٍ.',
      strokeDescriptionDe: 'Beginnt mit einem leichten Häkchen und fällt senkrecht über sieben Rautenpunkte ab.',
      strokeDescriptionEn: 'Begins with an oblique serif, descending vertically across seven rhombic pen dots.',
    ),
    ProportionedLetterModel(
      letterId: 'letter_baa',
      letterAr: 'ب',
      nameAr: 'حَرْفُ البَاءِ الهَنْدَسِيُّ',
      nameDe: 'Das geometrische Ba',
      nameEn: 'The Geometric Baa',
      rhombicDotHeight: 2,
      rhombicDotWidth: 6,
      circleDiameterRatio: 0.85,
      strokeDescriptionAr: 'يَسْتَقِرُّ عَلَى قَاعِدَةٍ أُفُقِيَّةٍ بِمِقْدَارِ سِتِّ نِقَاطٍ مَعِينِيَّةٍ كَسَفِينَةٍ مَوْزُونَةٍ.',
      strokeDescriptionDe: 'Ruht auf einer horizontalen Basis von sechs Rautenpunkten wie ein wohlbalanciertes Schiff.',
      strokeDescriptionEn: 'Rests on a horizontal baseline of six rhombic dots resembling a poised vessel.',
    ),
    ProportionedLetterModel(
      letterId: 'letter_jeem',
      letterAr: 'ج',
      nameAr: 'حَرْفُ الجِيمِ الدَّائِرِيُّ',
      nameDe: 'Das kreisförmige Dschim',
      nameEn: 'The Circular Jeem',
      rhombicDotHeight: 5,
      rhombicDotWidth: 5,
      circleDiameterRatio: 0.75,
      strokeDescriptionAr: 'رَأْسُهُ يَمْتَدُّ أَرْبَعَ نِقَاطٍ، وَبَطْنُهُ يَدُورُ فِي نِصْفِ دَائِرَةٍ مُنْتَظِمَةٍ.',
      strokeDescriptionDe: 'Der Kopf erstreckt sich über vier Punkte, der Bogen bildet einen präzisen Halbkreis.',
      strokeDescriptionEn: 'Its head spans four points, sweeping into a precisely proportioned semicircular bowl.',
    ),
    ProportionedLetterModel(
      letterId: 'letter_noon',
      letterAr: 'ن',
      nameAr: 'حَرْفُ النُّونِ الكَأْسِيُّ',
      nameDe: 'Das schalenförmige Nun',
      nameEn: 'The Bowl-Shaped Noon',
      rhombicDotHeight: 4,
      rhombicDotWidth: 5,
      circleDiameterRatio: 0.70,
      strokeDescriptionAr: 'يَهْبِطُ كَأْسُ النُّونِ فِي دَائِرَةٍ مُحْكَمَةٍ تُوَازِي قُطْرَ الدَّائِرَةِ الأُمِّ.',
      strokeDescriptionDe: 'Die Rundung des Nun folgt einem exakten Kreisbogen unterhalb der Grundlinie.',
      strokeDescriptionEn: 'The bowl of the Noon dips below the baseline in a curvature matching the master circle.',
    ),
  ];

  /// Selects the active letter model.
  void selectLetter(int index) {
    if (index >= 0 && index < letters.length && _activeLetterIndex != index) {
      _activeLetterIndex = index;
      notifyListeners();
    }
  }

  /// Toggles visibility of rhombic dots grid.
  void toggleRhombicGrid() {
    _showRhombicGrid = !_showRhombicGrid;
    notifyListeners();
  }

  /// Toggles visibility of the circumscribed proportioned circle.
  void toggleCircumscribedCircle() {
    _showCircumscribedCircle = !_showCircumscribedCircle;
    notifyListeners();
  }

  /// Sets pen nib slant angle.
  void setNibAngle(double angle) {
    final clamped = angle.clamp(30.0, 75.0);
    if (_nibSlantAngleDegrees != clamped) {
      _nibSlantAngleDegrees = clamped;
      notifyListeners();
    }
  }

  /// Sets stroke progression stage (0 to 2).
  void setStrokeStage(int stage) {
    final clamped = stage.clamp(0, 2);
    if (_strokeStage != clamped) {
      _strokeStage = clamped;
      notifyListeners();
    }
  }

  /// Resets to Ibn Muqla's master canon baseline.
  void reset() {
    _activeLetterIndex = 0;
    _nibSlantAngleDegrees = 45.0;
    _showRhombicGrid = true;
    _showCircumscribedCircle = true;
    _strokeStage = 2;
    notifyListeners();
  }
}
