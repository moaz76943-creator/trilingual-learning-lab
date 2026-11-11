import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// Enumeration of optical mediums known in classical and modern optics.
enum OpticalMedium {
  air(
    nameAr: 'الهَوَاءُ',
    nameDe: 'Luft',
    nameEn: 'Air',
    refractiveIndex: 1.0003,
  ),
  water(
    nameAr: 'المَاءُ العَذْبُ',
    nameDe: 'Wasser',
    nameEn: 'Water',
    refractiveIndex: 1.3330,
  ),
  glassCrown(
    nameAr: 'زُجَاجُ التَّاجِ',
    nameDe: 'Kronglas',
    nameEn: 'Crown Glass',
    refractiveIndex: 1.5200,
  ),
  flintGlass(
    nameAr: 'زُجَاجُ الصَّوَّانِ',
    nameDe: 'Flintglas',
    nameEn: 'Flint Glass',
    refractiveIndex: 1.6200,
  ),
  rockCrystal(
    nameAr: 'بَلُّوْرُ المَهَا (الكُوارتز)',
    nameDe: 'Bergkristall (Quarz)',
    nameEn: 'Rock Crystal (Quartz)',
    refractiveIndex: 1.5440,
  ),
  diamond(
    nameAr: 'المَاسُ الطَّبِيعِيُّ',
    nameDe: 'Diamant',
    nameEn: 'Diamond',
    refractiveIndex: 2.4170,
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;
  final double refractiveIndex;

  const OpticalMedium({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.refractiveIndex,
  });
}

/// Simulation mode in the Optics Studio
enum OpticsMode {
  refraction(
    titleAr: 'انْكِسَارُ الضَّوْءِ (ابْنُ الهَيْثَمِ)',
    titleDe: 'Lichtbrechung (Alhazen-Gesetz)',
    titleEn: 'Light Refraction (Snell-Alhazen)',
  ),
  cameraObscura(
    titleAr: 'البَيْتُ المُظْلِمُ وَالثَّقْبُ (القَمْرَة)',
    titleDe: 'Camera Obscura (Lochkamera)',
    titleEn: 'Camera Obscura (Pinhole Chamber)',
  );

  final String titleAr;
  final String titleDe;
  final String titleEn;

  const OpticsMode({
    required this.titleAr,
    required this.titleDe,
    required this.titleEn,
  });
}

/// State representation for the Optics Ray Tracer simulation
class OpticsRayTracerState {
  final OpticsMode mode;
  final OpticalMedium incidentMedium;
  final OpticalMedium refractiveMedium;
  final double incidentAngleDeg; // 0° to 89.9° relative to normal
  final double apertureDiameterMm; // 0.5mm to 10mm for camera obscura
  final double objectDistanceCm; // 10cm to 200cm
  final double chamberDepthCm; // 10cm to 100cm
  final double objectHeightCm; // 5cm to 50cm
  final bool showNormalLine;
  final bool showReflectedRay;
  final bool showCriticalAngleWarning;

  const OpticsRayTracerState({
    required this.mode,
    required this.incidentMedium,
    required this.refractiveMedium,
    required this.incidentAngleDeg,
    required this.apertureDiameterMm,
    required this.objectDistanceCm,
    required this.chamberDepthCm,
    required this.objectHeightCm,
    required this.showNormalLine,
    required this.showReflectedRay,
    required this.showCriticalAngleWarning,
  });

  factory OpticsRayTracerState.initial() {
    return const OpticsRayTracerState(
      mode: OpticsMode.refraction,
      incidentMedium: OpticalMedium.air,
      refractiveMedium: OpticalMedium.glassCrown,
      incidentAngleDeg: 30.0,
      apertureDiameterMm: 2.5,
      objectDistanceCm: 50.0,
      chamberDepthCm: 30.0,
      objectHeightCm: 20.0,
      showNormalLine: true,
      showReflectedRay: true,
      showCriticalAngleWarning: false,
    );
  }

  /// Calculates the angle of refraction in degrees using Snell-Alhazen Law:
  /// n1 * sin(theta1) = n2 * sin(theta2)
  /// Returns null if total internal reflection occurs.
  double? get refractedAngleDeg {
    final n1 = incidentMedium.refractiveIndex;
    final n2 = refractiveMedium.refractiveIndex;
    final theta1Rad = incidentAngleDeg * (math.pi / 180.0);
    final sinTheta2 = (n1 / n2) * math.sin(theta1Rad);

    if (sinTheta2.abs() > 1.0) {
      return null; // Total internal reflection (الانعكاس الكلي الداخلي)
    }

    final theta2Rad = math.asin(sinTheta2);
    return theta2Rad * (180.0 / math.pi);
  }

  /// Calculates critical angle in degrees if n1 > n2, otherwise null
  double? get criticalAngleDeg {
    final n1 = incidentMedium.refractiveIndex;
    final n2 = refractiveMedium.refractiveIndex;
    if (n1 <= n2) return null;
    final sinCrit = n2 / n1;
    return math.asin(sinCrit) * (180.0 / math.pi);
  }

  /// Indicates if total internal reflection is active
  bool get isTotalInternalReflection => refractedAngleDeg == null;

  /// Calculates the inverted image height inside the Camera Obscura
  /// Magnification m = - (chamberDepth / objectDistance)
  /// image_height = object_height * (chamberDepth / objectDistance)
  double get pinholeImageHeightCm {
    if (objectDistanceCm <= 0) return 0.0;
    return objectHeightCm * (chamberDepthCm / objectDistanceCm);
  }

  /// Optical blur spot diameter calculated from pinhole aperture:
  /// blur_spot ~ aperture_diameter * (1 + chamberDepth / objectDistance)
  double get blurCircleDiameterMm {
    if (objectDistanceCm <= 0) return apertureDiameterMm;
    return apertureDiameterMm * (1.0 + (chamberDepthCm / objectDistanceCm));
  }

  OpticsRayTracerState copyWith({
    OpticsMode? mode,
    OpticalMedium? incidentMedium,
    OpticalMedium? refractiveMedium,
    double? incidentAngleDeg,
    double? apertureDiameterMm,
    double? objectDistanceCm,
    double? chamberDepthCm,
    double? objectHeightCm,
    bool? showNormalLine,
    bool? showReflectedRay,
    bool? showCriticalAngleWarning,
  }) {
    return OpticsRayTracerState(
      mode: mode ?? this.mode,
      incidentMedium: incidentMedium ?? this.incidentMedium,
      refractiveMedium: refractiveMedium ?? this.refractiveMedium,
      incidentAngleDeg: incidentAngleDeg ?? this.incidentAngleDeg,
      apertureDiameterMm: apertureDiameterMm ?? this.apertureDiameterMm,
      objectDistanceCm: objectDistanceCm ?? this.objectDistanceCm,
      chamberDepthCm: chamberDepthCm ?? this.chamberDepthCm,
      objectHeightCm: objectHeightCm ?? this.objectHeightCm,
      showNormalLine: showNormalLine ?? this.showNormalLine,
      showReflectedRay: showReflectedRay ?? this.showReflectedRay,
      showCriticalAngleWarning:
          showCriticalAngleWarning ?? this.showCriticalAngleWarning,
    );
  }
}

/// Controller orchestrating the optical ray tracing simulation
class OpticsRayTracerController extends ChangeNotifier {
  OpticsRayTracerState _state = OpticsRayTracerState.initial();

  OpticsRayTracerState get state => _state;

  void setMode(OpticsMode mode) {
    _state = _state.copyWith(mode: mode);
    notifyListeners();
  }

  void setIncidentMedium(OpticalMedium medium) {
    _state = _state.copyWith(incidentMedium: medium);
    _checkCriticalAngle();
    notifyListeners();
  }

  void setRefractiveMedium(OpticalMedium medium) {
    _state = _state.copyWith(refractiveMedium: medium);
    _checkCriticalAngle();
    notifyListeners();
  }

  void setIncidentAngle(double angleDeg) {
    final clamped = angleDeg.clamp(0.0, 89.9);
    _state = _state.copyWith(incidentAngleDeg: clamped);
    _checkCriticalAngle();
    notifyListeners();
  }

  void setApertureDiameter(double mm) {
    final clamped = mm.clamp(0.5, 10.0);
    _state = _state.copyWith(apertureDiameterMm: clamped);
    notifyListeners();
  }

  void setObjectDistance(double cm) {
    final clamped = cm.clamp(10.0, 200.0);
    _state = _state.copyWith(objectDistanceCm: clamped);
    notifyListeners();
  }

  void setChamberDepth(double cm) {
    final clamped = cm.clamp(10.0, 100.0);
    _state = _state.copyWith(chamberDepthCm: clamped);
    notifyListeners();
  }

  void setObjectHeight(double cm) {
    final clamped = cm.clamp(5.0, 50.0);
    _state = _state.copyWith(objectHeightCm: clamped);
    notifyListeners();
  }

  void toggleNormalLine() {
    _state = _state.copyWith(showNormalLine: !_state.showNormalLine);
    notifyListeners();
  }

  void toggleReflectedRay() {
    _state = _state.copyWith(showReflectedRay: !_state.showReflectedRay);
    notifyListeners();
  }

  void swapMediums() {
    final temp = _state.incidentMedium;
    _state = _state.copyWith(
      incidentMedium: _state.refractiveMedium,
      refractiveMedium: temp,
    );
    _checkCriticalAngle();
    notifyListeners();
  }

  void resetDefaults() {
    _state = OpticsRayTracerState.initial();
    notifyListeners();
  }

  void _checkCriticalAngle() {
    final isTIR = _state.isTotalInternalReflection;
    _state = _state.copyWith(showCriticalAngleWarning: isTIR);
  }
}
