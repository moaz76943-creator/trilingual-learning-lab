import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// Historical latitude location preset for astrolabe tympans.
class AstrolabeTympanLocation {
  final String id;
  final String nameAr;
  final String nameDe;
  final String nameEn;
  final double latitudeDegrees;

  const AstrolabeTympanLocation({
    required this.id,
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.latitudeDegrees,
  });
}

/// Controller governing the interactive virtual astrolabe simulation and calculations.
class AstrolabeSimulatorController extends ChangeNotifier {
  double _alidadeAngleDegrees = 0.0; // 0° to 90° (solar altitude)
  double _reteAngleDegrees = 0.0;    // 0° to 360° (diurnal celestial rotation)
  int _activeLocationIndex = 0;
  bool _isChallengeCompleted = false;

  AstrolabeSimulatorController({
    double initialAlidadeAngle = 30.0,
    double initialReteAngle = 0.0,
    int initialLocationIndex = 0,
  })  : _alidadeAngleDegrees = initialAlidadeAngle,
        _reteAngleDegrees = initialReteAngle,
        _activeLocationIndex = initialLocationIndex;

  double get alidadeAngle => _alidadeAngleDegrees;
  double get reteAngle => _reteAngleDegrees;
  int get activeLocationIndex => _activeLocationIndex;
  bool get isChallengeCompleted => _isChallengeCompleted;

  AstrolabeTympanLocation get activeLocation => locations[_activeLocationIndex];

  static const List<AstrolabeTympanLocation> locations = [
    AstrolabeTympanLocation(
      id: 'loc_damascus',
      nameAr: 'دِمَشْقُ (صَفِيحَةُ عَرْضِ 33°)',
      nameDe: 'Damaskus (Breitengrad 33°)',
      nameEn: 'Damascus (Latitude 33°)',
      latitudeDegrees: 33.5,
    ),
    AstrolabeTympanLocation(
      id: 'loc_mecca',
      nameAr: 'مَكَّةُ المُكَرَّمَةُ (صَفِيحَةُ عَرْضِ 21°)',
      nameDe: 'Mekka (Breitengrad 21°)',
      nameEn: 'Mecca (Latitude 21°)',
      latitudeDegrees: 21.4,
    ),
    AstrolabeTympanLocation(
      id: 'loc_toledo',
      nameAr: 'طُلَيْطِلَةُ (صَفِيحَةُ عَرْضِ 40°)',
      nameDe: 'Toledo (Breitengrad 40°)',
      nameEn: 'Toledo (Latitude 40°)',
      latitudeDegrees: 39.8,
    ),
    AstrolabeTympanLocation(
      id: 'loc_cairo',
      nameAr: 'القَاهِرَةُ (صَفِيحَةُ عَرْضِ 30°)',
      nameDe: 'Kairo (Breitengrad 30°)',
      nameEn: 'Cairo (Latitude 30°)',
      latitudeDegrees: 30.0,
    ),
  ];

  /// Updates alidade angle (clamped between 0° and 90°).
  void setAlidadeAngle(double degrees) {
    final clamped = degrees.clamp(0.0, 90.0);
    if (_alidadeAngleDegrees != clamped) {
      _alidadeAngleDegrees = clamped;
      _checkChallenge();
      notifyListeners();
    }
  }

  /// Updates rete rotation angle (0° to 360°).
  void setReteAngle(double degrees) {
    final normalized = (degrees % 360.0 + 360.0) % 360.0;
    if (_reteAngleDegrees != normalized) {
      _reteAngleDegrees = normalized;
      notifyListeners();
    }
  }

  /// Selects the active tympan latitude plate.
  void selectLocation(int index) {
    if (index >= 0 && index < locations.length && _activeLocationIndex != index) {
      _activeLocationIndex = index;
      notifyListeners();
    }
  }

  /// Computes the shadow square ratio (المُرَبَّعُ الظِّلِّيُّ / Schattenquadrat)
  /// cot(theta) for horizontal shadow (الظِّلُّ المَبْسُوطُ) based on 12 units.
  double get horizontalShadowDigits {
    if (_alidadeAngleDegrees <= 0.5) return 99.0;
    final rad = _alidadeAngleDegrees * (math.pi / 180.0);
    return 12.0 / math.tan(rad);
  }

  /// Computes vertical shadow (الظِّلُّ المَنْكُوسُ) based on 12 units.
  double get verticalShadowDigits {
    if (_alidadeAngleDegrees >= 89.5) return 99.0;
    final rad = _alidadeAngleDegrees * (math.pi / 180.0);
    return 12.0 * math.tan(rad);
  }

  /// Evaluates learning challenge: align alidade to exactly 45° (shadow ratio 1:1, digits = 12).
  void _checkChallenge() {
    if ((_alidadeAngleDegrees - 45.0).abs() <= 1.0) {
      _isChallengeCompleted = true;
    }
  }

  /// Resets simulation parameters to baseline.
  void reset() {
    _alidadeAngleDegrees = 30.0;
    _reteAngleDegrees = 0.0;
    _activeLocationIndex = 0;
    _isChallengeCompleted = false;
    notifyListeners();
  }
}
