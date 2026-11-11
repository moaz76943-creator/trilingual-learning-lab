import 'package:flutter/foundation.dart';

/// Wood species characteristics for architectural joinery.
class WoodSpeciesPreset {
  final String id;
  final String nameAr;
  final String nameDe;
  final String nameEn;
  final double densityKgM3;
  final double expansionCoefficient; // % dimension change per % humidity change

  const WoodSpeciesPreset({
    required this.id,
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.densityKgM3,
    required this.expansionCoefficient,
  });
}

/// Controller governing the interactive Kundekari joinery and hygroscopic physics simulation.
class KundekariStudioController extends ChangeNotifier {
  int _activeWoodIndex = 0; // Default to Walnut (الجوز)
  double _relativeHumidityPercent = 45.0; // Standard 45% relative humidity
  int _assemblyStage = 2; // 0: Frame, 1: Slotted battens, 2: Complete interlocking panel
  bool _isJointLocked = true;

  KundekariStudioController({
    int initialWoodIndex = 0,
    double initialHumidity = 45.0,
    int initialStage = 2,
  })  : _activeWoodIndex = initialWoodIndex,
        _relativeHumidityPercent = initialHumidity,
        _assemblyStage = initialStage;

  int get activeWoodIndex => _activeWoodIndex;
  double get relativeHumidityPercent => _relativeHumidityPercent;
  int get assemblyStage => _assemblyStage;
  bool get isJointLocked => _isJointLocked;

  WoodSpeciesPreset get activeWood => woodSpeciesList[_activeWoodIndex];

  static const List<WoodSpeciesPreset> woodSpeciesList = [
    WoodSpeciesPreset(
      id: 'wood_walnut',
      nameAr: 'خَشَبُ الجَوْزِ المَلَكِيِّ',
      nameDe: 'Königs-Walnussholz',
      nameEn: 'Royal Walnut Wood',
      densityKgM3: 650.0,
      expansionCoefficient: 0.0022,
    ),
    WoodSpeciesPreset(
      id: 'wood_cedar',
      nameAr: 'خَشَبُ الأَرْزِ العَطِرِ',
      nameDe: 'Aromatisches Zedernholz',
      nameEn: 'Aromatic Atlas Cedar',
      densityKgM3: 520.0,
      expansionCoefficient: 0.0016,
    ),
    WoodSpeciesPreset(
      id: 'wood_ebony',
      nameAr: 'خَشَبُ الآبَنُوسِ الصَّلْدِ',
      nameDe: 'Schwarzes Ebenholz',
      nameEn: 'Dense Black Ebony',
      densityKgM3: 1100.0,
      expansionCoefficient: 0.0028,
    ),
  ];

  /// Selects active wood species.
  void selectWood(int index) {
    if (index >= 0 && index < woodSpeciesList.length && _activeWoodIndex != index) {
      _activeWoodIndex = index;
      notifyListeners();
    }
  }

  /// Sets environmental relative humidity (10% to 90%).
  void setRelativeHumidity(double humidity) {
    final clamped = humidity.clamp(10.0, 90.0);
    if (_relativeHumidityPercent != clamped) {
      _relativeHumidityPercent = clamped;
      notifyListeners();
    }
  }

  /// Sets assembly progression stage (0 to 2).
  void setAssemblyStage(int stage) {
    final clamped = stage.clamp(0, 2);
    if (_assemblyStage != clamped) {
      _assemblyStage = clamped;
      notifyListeners();
    }
  }

  /// Toggles central locking key peg.
  void toggleJointLock() {
    _isJointLocked = !_isJointLocked;
    notifyListeners();
  }

  /// Computes hygroscopic dimensional expansion in millimeters for a 200mm Kundekari tongue.
  double get dimensionalExpansionMm {
    const baseLengthMm = 200.0;
    const baseHumidity = 45.0;
    final deltaHumidity = _relativeHumidityPercent - baseHumidity;
    return baseLengthMm * activeWood.expansionCoefficient * (deltaHumidity / 100.0);
  }

  /// Computes seam safety clearance (Kundekari tongue tolerance is ~1.5mm).
  bool get isExpansionSafe {
    return dimensionalExpansionMm.abs() < 1.4;
  }

  /// Resets simulation to baseline conditions.
  void reset() {
    _activeWoodIndex = 0;
    _relativeHumidityPercent = 45.0;
    _assemblyStage = 2;
    _isJointLocked = true;
    notifyListeners();
  }
}
