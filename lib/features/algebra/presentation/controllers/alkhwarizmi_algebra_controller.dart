import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// The Six Canonical Equations formulated by Al-Khwarizmi in Al-Jabr wa'l-Muqabala (820 CE)
enum KhwarizmiEquationType {
  // Simple Equations (المُفْرَدَاتُ)
  squaresEqualRoots(
    typeNumber: 1,
    nameAr: 'أَمْوَالٌ تَعْدِلُ جُذُوراً (ax² = bx)',
    nameDe: 'Quadrate gleich Wurzeln (ax² = bx)',
    nameEn: 'Squares equal roots (ax² = bx)',
    formulaAr: 'مَالٌ يَعْدِلُ خَمْسَةَ أَجْذَارٍ',
  ),
  squaresEqualNumbers(
    typeNumber: 2,
    nameAr: 'أَمْوَالٌ تَعْدِلُ عَدَداً (ax² = c)',
    nameDe: 'Quadrate gleich Zahlen (ax² = c)',
    nameEn: 'Squares equal numbers (ax² = c)',
    formulaAr: 'مَالٌ يَعْدِلُ سِتَّةَ عَشَرَ',
  ),
  rootsEqualNumbers(
    typeNumber: 3,
    nameAr: 'جُذُورٌ تَعْدِلُ عَدَداً (bx = c)',
    nameDe: 'Wurzeln gleich Zahlen (bx = c)',
    nameEn: 'Roots equal numbers (bx = c)',
    formulaAr: 'أَرْبَعَةُ أَجْذَارٍ تَعْدِلُ عِشْرِينَ',
  ),
  // Composite Equations (المُقْتَرِنَاتُ)
  squaresAndRootsEqualNumbers(
    typeNumber: 4,
    nameAr: 'أَمْوَالٌ وَجُذُورٌ تَعْدِلُ عَدَداً (x² + bx = c)',
    nameDe: 'Quadrate und Wurzeln gleich Zahlen (x² + bx = c)',
    nameEn: 'Squares and roots equal numbers (x² + bx = c)',
    formulaAr: 'مَالٌ وَعَشَرَةُ أَجْذَارٍ تَعْدِلُ تِسْعَةً وَثَلاثِينَ (مِثَالُ الخُوَارِزْمِيِّ الشَّهِيرُ)',
  ),
  squaresAndNumbersEqualRoots(
    typeNumber: 5,
    nameAr: 'أَمْوَالٌ وَعَدَدٌ تَعْدِلُ جُذُوراً (x² + c = bx)',
    nameDe: 'Quadrate und Zahlen gleich Wurzeln (x² + c = bx)',
    nameEn: 'Squares and numbers equal roots (x² + c = bx)',
    formulaAr: 'مَالٌ وَوَاحِدٌ وَعِشْرُونَ يَعْدِلُ عَشَرَةَ أَجْذَارٍ',
  ),
  rootsAndNumbersEqualSquares(
    typeNumber: 6,
    nameAr: 'جُذُورٌ وَعَدَدٌ تَعْدِلُ أَمْوَالاً (bx + c = x²)',
    nameDe: 'Wurzeln und Zahlen gleich Quadraten (bx + c = x²)',
    nameEn: 'Roots and numbers equal squares (bx + c = x²)',
    formulaAr: 'ثَلاثَةُ أَجْذَارٍ وَأَرْبَعَةٌ تَعْدِلُ مَالاً',
  );

  final int typeNumber;
  final String nameAr;
  final String nameDe;
  final String nameEn;
  final String formulaAr;

  const KhwarizmiEquationType({
    required this.typeNumber,
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.formulaAr,
  });
}

/// Geometric Proof Method for Completing the Square
enum GeometricProofMethod {
  alKhwarizmiFourCorners(
    nameAr: 'طَرِيقَةُ الخُوَارِزْمِيِّ (الأَرْكَانُ الأَرْبَعَةُ - b/4)',
    nameDe: 'Al-Chwarizmis Methode der vier Eck-Rechtecke',
    nameEn: 'Al-Khwarizmi Four-Flank Dissection (b/4 method)',
    descriptionAr: 'تَوْزِيعُ الجُذُورِ عَلَى أَرْبَعَةِ أَضْلاعٍ لِلْمُرَبَّعِ مَعَ إِكْمَالِ الأَرْكَانِ الأَرْبَعَةِ.',
  ),
  twoRectanglesComposite(
    nameAr: 'طَرِيقَةُ النِّصْفَيْنِ (المُسْتَطِيلانِ - b/2)',
    nameDe: 'Zwei-Rechteck-Methode (Halbierung b/2)',
    nameEn: 'Two-Flank Half Rectangle Method (b/2 method)',
    descriptionAr: 'تَقْسِيمُ الجُذُورِ إِلَى نِصْفَيْنِ مُتَسَاوِيَيْنِ لِتَشْكِيلِ مُرَبَّعٍ مُرَكَّبٍ مُوَحَّدٍ.',
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;
  final String descriptionAr;

  const GeometricProofMethod({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.descriptionAr,
  });
}

/// State representation for Al-Khwarizmi Algebra Studio
class AlKhwarizmiAlgebraState {
  final KhwarizmiEquationType equationType;
  final GeometricProofMethod proofMethod;
  final double bCoefficient; // Number of roots (b)
  final double cConstant; // Given number/area (c)
  final bool showGeometricDissection;
  final bool showAlgebraicSteps;

  const AlKhwarizmiAlgebraState({
    required this.equationType,
    required this.proofMethod,
    required this.bCoefficient,
    required this.cConstant,
    required this.showGeometricDissection,
    required this.showAlgebraicSteps,
  });

  factory AlKhwarizmiAlgebraState.initial() {
    // Al-Khwarizmi's famous historic problem from Al-Kitab al-Mukhtasar:
    // "مَالٌ وَعَشَرَةُ أَجْذَارٍ تَعْدِلُ تِسْعَةً وَثَلاثِينَ" (x² + 10x = 39)
    // Root: x = 3, Area of square x² = 9, 10x = 30, Total = 39.
    return const AlKhwarizmiAlgebraState(
      equationType: KhwarizmiEquationType.squaresAndRootsEqualNumbers,
      proofMethod: GeometricProofMethod.alKhwarizmiFourCorners,
      bCoefficient: 10.0,
      cConstant: 39.0,
      showGeometricDissection: true,
      showAlgebraicSteps: true,
    );
  }

  /// Calculates the positive real root (x) according to Al-Khwarizmi's algorithmic rules
  double? get positiveRoot {
    final b = bCoefficient;
    final c = cConstant;

    switch (equationType) {
      case KhwarizmiEquationType.squaresEqualRoots:
        // x² = bx => x = b
        return b;

      case KhwarizmiEquationType.squaresEqualNumbers:
        // x² = c => x = sqrt(c)
        return c >= 0 ? math.sqrt(c) : null;

      case KhwarizmiEquationType.rootsEqualNumbers:
        // bx = c => x = c / b
        return b != 0 ? c / b : null;

      case KhwarizmiEquationType.squaresAndRootsEqualNumbers:
        // x² + bx = c
        // x = sqrt((b/2)² + c) - (b/2)
        final halfB = b / 2.0;
        final discriminant = (halfB * halfB) + c;
        if (discriminant < 0) return null;
        return math.sqrt(discriminant) - halfB;

      case KhwarizmiEquationType.squaresAndNumbersEqualRoots:
        // x² + c = bx => x² - bx + c = 0
        // x = (b/2) ± sqrt((b/2)² - c)
        final halfB = b / 2.0;
        final discriminant = (halfB * halfB) - c;
        if (discriminant < 0) return null; // No real root
        // In classical text, Al-Khwarizmi discusses both subtraction and addition
        return halfB + math.sqrt(discriminant);

      case KhwarizmiEquationType.rootsAndNumbersEqualSquares:
        // bx + c = x² => x² - bx - c = 0
        // x = (b/2) + sqrt((b/2)² + c)
        final halfB = b / 2.0;
        final discriminant = (halfB * halfB) + c;
        if (discriminant < 0) return null;
        return halfB + math.sqrt(discriminant);
    }
  }

  /// Discriminant (مُمَيِّزُ المُعَادَلَةِ): (b/2)² - c (for type 5) or (b/2)² + c (for type 4 & 6)
  double get discriminant {
    final halfB = bCoefficient / 2.0;
    if (equationType == KhwarizmiEquationType.squaresAndNumbersEqualRoots) {
      return (halfB * halfB) - cConstant;
    } else {
      return (halfB * halfB) + cConstant;
    }
  }

  /// Corner square area added to complete the composite square: (b/2)²
  double get completingSquareArea {
    final halfB = bCoefficient / 2.0;
    return halfB * halfB;
  }

  /// Total composite square area: c + (b/2)²
  double get compositeTotalArea {
    return cConstant + completingSquareArea;
  }

  /// Side of the large composite completed square: sqrt(compositeTotalArea)
  double get compositeSquareSide {
    return math.sqrt(compositeTotalArea);
  }

  AlKhwarizmiAlgebraState copyWith({
    KhwarizmiEquationType? equationType,
    GeometricProofMethod? proofMethod,
    double? bCoefficient,
    double? cConstant,
    bool? showGeometricDissection,
    bool? showAlgebraicSteps,
  }) {
    return AlKhwarizmiAlgebraState(
      equationType: equationType ?? this.equationType,
      proofMethod: proofMethod ?? this.proofMethod,
      bCoefficient: bCoefficient ?? this.bCoefficient,
      cConstant: cConstant ?? this.cConstant,
      showGeometricDissection:
          showGeometricDissection ?? this.showGeometricDissection,
      showAlgebraicSteps: showAlgebraicSteps ?? this.showAlgebraicSteps,
    );
  }
}

/// Controller orchestrating Al-Khwarizmi Geometric Algebra Studio
class AlKhwarizmiAlgebraController extends ChangeNotifier {
  AlKhwarizmiAlgebraState _state = AlKhwarizmiAlgebraState.initial();

  AlKhwarizmiAlgebraState get state => _state;

  void setEquationType(KhwarizmiEquationType type) {
    _state = _state.copyWith(equationType: type);
    notifyListeners();
  }

  void setProofMethod(GeometricProofMethod method) {
    _state = _state.copyWith(proofMethod: method);
    notifyListeners();
  }

  void setBCoefficient(double b) {
    final clamped = b.clamp(1.0, 50.0);
    _state = _state.copyWith(bCoefficient: clamped);
    notifyListeners();
  }

  void setCConstant(double c) {
    final clamped = c.clamp(1.0, 200.0);
    _state = _state.copyWith(cConstant: clamped);
    notifyListeners();
  }

  void toggleDissection() {
    _state = _state.copyWith(
      showGeometricDissection: !_state.showGeometricDissection,
    );
    notifyListeners();
  }

  void toggleAlgebraicSteps() {
    _state = _state.copyWith(
      showAlgebraicSteps: !_state.showAlgebraicSteps,
    );
    notifyListeners();
  }

  /// Load Al-Khwarizmi's canonical problem (x² + 10x = 39)
  void loadHistoricProblem39() {
    _state = _state.copyWith(
      equationType: KhwarizmiEquationType.squaresAndRootsEqualNumbers,
      proofMethod: GeometricProofMethod.alKhwarizmiFourCorners,
      bCoefficient: 10.0,
      cConstant: 39.0,
    );
    notifyListeners();
  }

  /// Load second canonical problem (x² + 21 = 10x)
  void loadHistoricProblem21() {
    _state = _state.copyWith(
      equationType: KhwarizmiEquationType.squaresAndNumbersEqualRoots,
      bCoefficient: 10.0,
      cConstant: 21.0,
    );
    notifyListeners();
  }

  void reset() {
    _state = AlKhwarizmiAlgebraState.initial();
    notifyListeners();
  }
}
