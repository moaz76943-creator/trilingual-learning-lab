import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// Historical Geodetic Models for comparison with Al-Biruni
enum GeodeticBenchmark {
  eratosthenes(
    nameAr: 'إِيرَاتُوسْثِينِس (مِصْرُ القَدِيمَةُ)',
    nameDe: 'Eratosthenes (ca. 240 v. Chr.)',
    nameEn: 'Eratosthenes (Syene - Alexandria)',
    radiusKm: 6366.0,
    circumferenceKm: 40000.0,
    historicalContextAr: 'قِيَاسُ مُحِيطِ الأَرْضِ عَبْرَ ظِلِّ الشَّمْسِ بَيْنَ أُسْوَانَ وَالإِسْكَنْدَرِيَّةِ.',
  ),
  alBiruniNandana(
    nameAr: 'أَبُو الرَّيْحَانِ البِيرُونِيُّ (قَلْعَةُ نَنْدَنَة 1017م)',
    nameDe: 'Al-Biruni (Festung Nandana, 1017 n. Chr.)',
    nameEn: 'Al-Biruni (Fort Nandana, Punjab, 1017 CE)',
    radiusKm: 6339.6,
    circumferenceKm: 39833.0,
    historicalContextAr: 'طَرِيقَةُ انْحِطَاطِ الأُفُقِ مِنْ قِمَّةِ الجَبَلِ بِاسْتِعْمَالِ الأَسْطُرْلابِ وَحِسَابِ المُثَلَّثَاتِ.',
  ),
  alMamunCaliphate(
    nameAr: 'فَرِيقُ الخَلِيفَةِ المَأْمُونِ (سَنْجَار وَتَدْمُر 820م)',
    nameDe: 'Al-Ma\'mun-Expedition (Sindschar, 820 n. Chr.)',
    nameEn: 'Caliph Al-Ma\'mun Geodetic Survey (Sinjar, 820 CE)',
    radiusKm: 6314.5,
    circumferenceKm: 39675.0,
    historicalContextAr: 'قِيَاسُ مِيلِ الدَّرَجَةِ الوَاحِدَةِ مِنَ القَوْسِ الفَلَكِيِّ عَبْرَ الحِبَالِ وَالمَسْحِ الأَرْضِيِّ.',
  ),
  wgs84Modern(
    nameAr: 'المَرْجِعُ العَالَمِيُّ الحَدِيثُ (WGS-84)',
    nameDe: 'Modernes Referenzellipsoid (WGS-84)',
    nameEn: 'Modern WGS-84 Mean Spherical Radius',
    radiusKm: 6371.0,
    circumferenceKm: 40075.0,
    historicalContextAr: 'المُعَدَّلُ المِعْيَارِيُّ لِنِصْفِ قُطْرِ كُرَةِ الأَرْضِ بِالأَقْمَارِ الاصْطِنَاعِيَّةِ.',
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;
  final double radiusKm;
  final double circumferenceKm;
  final String historicalContextAr;

  const GeodeticBenchmark({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.radiusKm,
    required this.circumferenceKm,
    required this.historicalContextAr,
  });
}

/// State representation for Al-Biruni's Geodesy computation
class GeodesyCalculationState {
  final double mountainHeightMeters; // Mountain height 'h' in meters (e.g. 651.5 m at Nandana)
  final double dipAngleMinutes; // Horizon dip angle 'alpha' in arcminutes (typically 20' to 45')
  final GeodeticBenchmark selectedBenchmark;
  final bool showTrigRayDiagram;
  final bool showHistoricalComparison;

  const GeodesyCalculationState({
    required this.mountainHeightMeters,
    required this.dipAngleMinutes,
    required this.selectedBenchmark,
    required this.showTrigRayDiagram,
    required this.showHistoricalComparison,
  });

  factory GeodesyCalculationState.initial() {
    // Al-Biruni's historic measurements at Mount Nandana (Punjab):
    // Mountain height h ~ 651.5 meters (approx. 900+ royal cubits / ذِرَاعٌ مَلَكِيٌّ)
    // Dip angle alpha ~ 34 arcminutes (34' = 0.5667 degrees)
    return const GeodesyCalculationState(
      mountainHeightMeters: 651.5,
      dipAngleMinutes: 34.0,
      selectedBenchmark: GeodeticBenchmark.alBiruniNandana,
      showTrigRayDiagram: true,
      showHistoricalComparison: true,
    );
  }

  /// Dip angle in decimal degrees
  double get dipAngleDegrees => dipAngleMinutes / 60.0;

  /// Dip angle in radians
  double get dipAngleRadians => dipAngleDegrees * (math.pi / 180.0);

  /// Al-Biruni's formula for Earth Radius:
  /// R = (h * cos(alpha)) / (1 - cos(alpha))
  /// Where h is mountain height in kilometers.
  double get calculatedRadiusKm {
    final hKm = mountainHeightMeters / 1000.0;
    final cosAlpha = math.cos(dipAngleRadians);
    final denom = 1.0 - cosAlpha;
    if (denom.abs() < 1e-9) return 0.0;
    return (hKm * cosAlpha) / denom;
  }

  /// Calculated Earth Circumference: C = 2 * pi * R
  double get calculatedCircumferenceKm {
    return 2.0 * math.pi * calculatedRadiusKm;
  }

  /// Distance to the horizon tangent point from the mountain peak:
  /// d = R * tan(alpha)
  double get horizonDistanceKm {
    return calculatedRadiusKm * math.tan(dipAngleRadians);
  }

  /// Percentage error compared to modern WGS-84 spherical radius (6371.0 km)
  double get errorPercentageVsModern {
    const modern = 6371.0;
    final r = calculatedRadiusKm;
    if (r == 0) return 0.0;
    return ((r - modern) / modern) * 100.0;
  }

  GeodesyCalculationState copyWith({
    double? mountainHeightMeters,
    double? dipAngleMinutes,
    GeodeticBenchmark? selectedBenchmark,
    bool? showTrigRayDiagram,
    bool? showHistoricalComparison,
  }) {
    return GeodesyCalculationState(
      mountainHeightMeters: mountainHeightMeters ?? this.mountainHeightMeters,
      dipAngleMinutes: dipAngleMinutes ?? this.dipAngleMinutes,
      selectedBenchmark: selectedBenchmark ?? this.selectedBenchmark,
      showTrigRayDiagram: showTrigRayDiagram ?? this.showTrigRayDiagram,
      showHistoricalComparison:
          showHistoricalComparison ?? this.showHistoricalComparison,
    );
  }
}

/// Controller managing Al-Biruni Geodesy Studio
class EarthRadiusCalculatorController extends ChangeNotifier {
  GeodesyCalculationState _state = GeodesyCalculationState.initial();

  GeodesyCalculationState get state => _state;

  void setMountainHeight(double meters) {
    final clamped = meters.clamp(50.0, 5000.0);
    _state = _state.copyWith(mountainHeightMeters: clamped);
    notifyListeners();
  }

  void setDipAngleMinutes(double minutes) {
    final clamped = minutes.clamp(5.0, 90.0);
    _state = _state.copyWith(dipAngleMinutes: clamped);
    notifyListeners();
  }

  void selectBenchmark(GeodeticBenchmark benchmark) {
    _state = _state.copyWith(selectedBenchmark: benchmark);
    notifyListeners();
  }

  void toggleDiagram() {
    _state = _state.copyWith(showTrigRayDiagram: !_state.showTrigRayDiagram);
    notifyListeners();
  }

  void toggleHistoricalComparison() {
    _state = _state.copyWith(
      showHistoricalComparison: !_state.showHistoricalComparison,
    );
    notifyListeners();
  }

  /// Load exact historical Nandana parameters recorded by Al-Biruni
  void loadNandanaHistorical() {
    _state = _state.copyWith(
      mountainHeightMeters: 651.5,
      dipAngleMinutes: 34.0,
      selectedBenchmark: GeodeticBenchmark.alBiruniNandana,
    );
    notifyListeners();
  }

  void reset() {
    _state = GeodesyCalculationState.initial();
    notifyListeners();
  }
}
