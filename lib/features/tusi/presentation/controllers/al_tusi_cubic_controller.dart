import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// Cubic Equation Forms classified by Sharaf al-Din al-Tusi (1209 CE)
enum TusiCubicForm {
  cubesAndNumbersEqualRoots(
    typeNumber: 1,
    nameAr: 'مُكَعَّبٌ وَعَدَدٌ يَعْدِلانِ جُذُوراً (x³ + d = bx)',
    nameDe: 'Kubus und Zahl gleich Wurzeln (x³ + d = bx)',
    nameEn: 'Cube and Number equal Roots (x³ + d = bx)',
    formulaAr: 'x³ + d = bx  =>  bx - x³ = d',
    descriptionAr: 'قَامَ الطُّوسِيُّ بِإِيجَادِ النِّهَايَةِ العُظْمَى لِلدَّالَّةِ f(x)=bx-x³ عِنْدَ x=sqrt(b/3)؛ فَإِذَا كَانَتِ القِيمَةُ العُظْمَى أَكْبَرَ مِنْ d وُجِدَ حَلَّانِ مُوجَبَانِ.',
  ),
  cubesAndNumbersEqualSquares(
    typeNumber: 2,
    nameAr: 'مُكَعَّبٌ وَعَدَدٌ يَعْدِلانِ أَمْوَالاً (x³ + d = cx²)',
    nameDe: 'Kubus und Zahl gleich Quadraten (x³ + d = cx²)',
    nameEn: 'Cube and Number equal Squares (x³ + d = cx²)',
    formulaAr: 'x³ + d = cx²  =>  cx² - x³ = d',
    descriptionAr: 'النِّهَايَةُ العُظْمَى تَكُونُ عِنْدَ x = 2c/3 حَيْثُ تَبْلُغُ الدَّالَّةُ قِمَّتَهَا؛ وَتَحَدَّدَ شَرْطُ وُجُودِ الحُلُولِ بِمُقَارَنَتِهَا مَعَ d.',
  ),
  linearAstrolabeStaff(
    typeNumber: 3,
    nameAr: 'عَصَا الطُّوسِيِّ (الأَسْطُرْلابُ الخَطِّيُّ لِشَرَفِ الدِّينِ)',
    nameDe: 'Linear-Astrolab (Tusi-Stab)',
    nameEn: 'Linear Astrolabe (Staff of al-Tusi)',
    formulaAr: 'أَسْطُرْلابٌ خَطِّيٌّ مُدَرَّجٌ يُعَوِّضُ صَفَائِحَ الأَسْطُرْلابِ المُسَطَّحِ.',
    descriptionAr: 'قَضِيبٌ خَشَبِيٌّ مُدَرَّجٌ مُزَوَّدٌ بِخَيْطَيْنِ وَمِرْصَادَيْنِ لِحِسَابِ ارْتِفَاعِ الشَّمْسِ وَخُطُوطِ الزَّوَالِ دُونَ حَاجَةٍ لِصَفَائِحَ نُحَاسِيَّةٍ ثَقِيلَةٍ.',
  );

  final int typeNumber;
  final String nameAr;
  final String nameDe;
  final String nameEn;
  final String formulaAr;
  final String descriptionAr;

  const TusiCubicForm({
    required this.typeNumber,
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.formulaAr,
    required this.descriptionAr,
  });
}

/// State representation for Al-Tusi Cubic Analysis
class AlTusiCubicState {
  final TusiCubicForm form;
  final double bCoefficient; // Coefficient of roots (b) or squares (c)
  final double dConstant; // Constant term (d)
  final double selectedX; // Probe point x along the curve
  final double solarAltitudeDeg; // For Linear Astrolabe mode (0° to 90°)
  final bool showDerivativeExtremum; // Toggle highlighting local maximum
  final bool showGridLines;

  const AlTusiCubicState({
    required this.form,
    required this.bCoefficient,
    required this.dConstant,
    required this.selectedX,
    required this.solarAltitudeDeg,
    required this.showDerivativeExtremum,
    required this.showGridLines,
  });

  factory AlTusiCubicState.initial() {
    // Historic Al-Tusi problem from Al-Mu'adalat:
    // x³ + 16 = 12x  =>  12x - x³ = 16
    // Local maximum at x = sqrt(12/3) = sqrt(4) = 2.0
    // Max value: 12(2) - (2)³ = 24 - 8 = 16.
    // Since Max = 16 == d, there is a double root at x = 2 and a second positive root at x = 4!
    return const AlTusiCubicState(
      form: TusiCubicForm.cubesAndNumbersEqualRoots,
      bCoefficient: 12.0,
      dConstant: 16.0,
      selectedX: 2.0,
      solarAltitudeDeg: 48.5,
      showDerivativeExtremum: true,
      showGridLines: true,
    );
  }

  /// Calculates the function value f(x)
  double evaluateFunction(double x) {
    switch (form) {
      case TusiCubicForm.cubesAndNumbersEqualRoots:
        // f(x) = b*x - x^3
        return (bCoefficient * x) - (x * x * x);
      case TusiCubicForm.cubesAndNumbersEqualSquares:
        // f(x) = c*x^2 - x^3
        return (bCoefficient * x * x) - (x * x * x);
      case TusiCubicForm.linearAstrolabeStaff:
        // Sinusoidal elevation projection: L * sin(altitude)
        final rad = solarAltitudeDeg * (math.pi / 180.0);
        return 100.0 * math.sin(rad);
    }
  }

  /// The exact location of the local maximum (x_max) derived via Al-Tusi's rule
  double get extremumX {
    switch (form) {
      case TusiCubicForm.cubesAndNumbersEqualRoots:
        // Derivative of (bx - x^3) is b - 3x^2 = 0 => x_max = sqrt(b / 3)
        if (bCoefficient <= 0) return 0.0;
        return math.sqrt(bCoefficient / 3.0);
      case TusiCubicForm.cubesAndNumbersEqualSquares:
        // Derivative of (cx^2 - x^3) is 2cx - 3x^2 = 0 => x_max = 2c / 3
        return (2.0 * bCoefficient) / 3.0;
      case TusiCubicForm.linearAstrolabeStaff:
        return 90.0;
    }
  }

  /// The maximum value of the function at x_max: f(x_max)
  double get maximumValue {
    return evaluateFunction(extremumX);
  }

  /// Al-Tusi's condition for real positive roots:
  /// Does the maximum value f(x_max) >= d?
  bool get hasRealPositiveRoots {
    if (form == TusiCubicForm.linearAstrolabeStaff) return true;
    return maximumValue >= dConstant;
  }

  /// Calculates the real roots in the positive domain
  List<double> get positiveRoots {
    if (!hasRealPositiveRoots) return [];

    final roots = <double>[];
    final xMax = extremumX;

    // Numerical root search using bisection on [0, xMax] and [xMax, 2*xMax]
    double? r1 = _findRootInRange(0.001, xMax);
    if (r1 != null) roots.add(r1);

    double? r2 = _findRootInRange(xMax, xMax * 2.5);
    if (r2 != null && (r1 == null || (r2 - r1).abs() > 0.01)) {
      roots.add(r2);
    }

    return roots;
  }

  double? _findRootInRange(double low, double high) {
    double fLow = evaluateFunction(low) - dConstant;
    double fHigh = evaluateFunction(high) - dConstant;

    if (fLow * fHigh > 0) return null;

    double a = low;
    double b = high;
    for (int i = 0; i < 40; i++) {
      final mid = (a + b) / 2.0;
      final fMid = evaluateFunction(mid) - dConstant;
      if (fMid.abs() < 1e-5) return mid;
      if (fLow * fMid < 0) {
        b = mid;
        fHigh = fMid;
      } else {
        a = mid;
        fLow = fMid;
      }
    }
    return (a + b) / 2.0;
  }

  /// Linear Astrolabe: Zenith distance (90° - altitude)
  double get zenithDistanceDeg => 90.0 - solarAltitudeDeg;

  AlTusiCubicState copyWith({
    TusiCubicForm? form,
    double? bCoefficient,
    double? dConstant,
    double? selectedX,
    double? solarAltitudeDeg,
    bool? showDerivativeExtremum,
    bool? showGridLines,
  }) {
    return AlTusiCubicState(
      form: form ?? this.form,
      bCoefficient: bCoefficient ?? this.bCoefficient,
      dConstant: dConstant ?? this.dConstant,
      selectedX: selectedX ?? this.selectedX,
      solarAltitudeDeg: solarAltitudeDeg ?? this.solarAltitudeDeg,
      showDerivativeExtremum:
          showDerivativeExtremum ?? this.showDerivativeExtremum,
      showGridLines: showGridLines ?? this.showGridLines,
    );
  }
}

/// Controller managing Al-Tusi's Cubic Studio & Linear Astrolabe
class AlTusiCubicController extends ChangeNotifier {
  AlTusiCubicState _state = AlTusiCubicState.initial();

  AlTusiCubicState get state => _state;

  void setForm(TusiCubicForm form) {
    if (form == TusiCubicForm.cubesAndNumbersEqualSquares) {
      _state = _state.copyWith(
        form: form,
        bCoefficient: 6.0, // cx² with c=6
        dConstant: 16.0,
      );
    } else if (form == TusiCubicForm.cubesAndNumbersEqualRoots) {
      _state = _state.copyWith(
        form: form,
        bCoefficient: 12.0,
        dConstant: 16.0,
      );
    } else {
      _state = _state.copyWith(form: form);
    }
    notifyListeners();
  }

  void setBCoefficient(double val) {
    final clamped = val.clamp(1.0, 50.0);
    _state = _state.copyWith(bCoefficient: clamped);
    notifyListeners();
  }

  void setDConstant(double val) {
    final clamped = val.clamp(1.0, 100.0);
    _state = _state.copyWith(dConstant: clamped);
    notifyListeners();
  }

  void setSelectedX(double x) {
    _state = _state.copyWith(selectedX: x);
    notifyListeners();
  }

  void setSolarAltitude(double deg) {
    final clamped = deg.clamp(0.0, 90.0);
    _state = _state.copyWith(solarAltitudeDeg: clamped);
    notifyListeners();
  }

  void toggleExtremum() {
    _state = _state.copyWith(
      showDerivativeExtremum: !_state.showDerivativeExtremum,
    );
    notifyListeners();
  }

  /// Preset: Historic Al-Tusi problem x³ + 16 = 12x
  void loadHistoricAlTusi16() {
    _state = _state.copyWith(
      form: TusiCubicForm.cubesAndNumbersEqualRoots,
      bCoefficient: 12.0,
      dConstant: 16.0,
      selectedX: 2.0,
    );
    notifyListeners();
  }

  void reset() {
    _state = AlTusiCubicState.initial();
    notifyListeners();
  }
}
