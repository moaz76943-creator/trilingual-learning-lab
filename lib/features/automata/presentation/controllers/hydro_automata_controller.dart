import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// Historical Al-Jazari Hydro-Mechanical Mechanism Type
enum AutomataMechanismType {
  tarjaharSinkingFloat(
    nameAr: 'الطَّرْجَهَارَةُ (الإِنَاءُ الطَّافِي المُنْخَرِقُ)',
    nameDe: 'Tarjahar (Versinkendes Schwimmergefäß)',
    nameEn: 'Tarjahar (Sinking Perforated Floating Bowl)',
    descriptionAr: 'وِعَاءٌ طَافٍ مُعَايَرُ الثَّقْبِ فِي قَاعِهِ، يَمْتَلِئُ تَدْرِيجِيّاً لِيُسْقِطَ الكُرَةَ كُلَّ نِصْفِ سَاعَةٍ.',
  ),
  tippingSiphonBucket(
    nameAr: 'القَلَّابُ الهَيْدْرُولِيكِيُّ (المِغْرَفَةُ ذَاتُ السَّيْفُون)',
    nameDe: 'Kippbecher-Mechanismus mit Heber',
    nameEn: 'Tipping Siphon Bucket & Counterweight Trip',
    descriptionAr: 'مِغْرَفَةٌ مُعَلَّقَةٌ بِمِحْوَرٍ لا مَرْكَزِيٍّ تَنْقَلِبُ عِنْدَ امْتِلائِهَا وَتُفْرِغُ حَمُولَتَهَا دَفْعَةً وَاحِدَةً.',
  ),
  camshaftAutomataDriver(
    nameAr: 'عَمُودُ الحَدَبَاتِ وَالمُحَاكَاةُ الحَرَكِيَّةُ',
    nameDe: 'Nockenwellen-Antrieb für Automaten',
    nameEn: 'Camshaft & Segmental Gear Automata Driver',
    descriptionAr: 'تَحْوِيلُ الحَرَكَةِ الدَّوَرَانِيَّةِ لِعَجَلَةِ المَاءِ إِلَى حَرَكَاتٍ تَرَدُّدِيَّةٍ لِتَشْغِيلِ الدُّمَى الآلِيَّةِ.',
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;
  final String descriptionAr;

  const AutomataMechanismType({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.descriptionAr,
  });
}

/// State of the Hydro-Mechanical Simulation
class HydroAutomataState {
  final AutomataMechanismType mechanismType;
  final double tankWaterLevelCm; // Water depth in main reservoir (0 to 100 cm)
  final double orificeDiameterMm; // Diameter of the calibrated hole in bowl (1.0 to 10.0 mm)
  final double floatBowlMassGrams; // Mass of the floating bowl (50 to 500 g)
  final double bowlVolumeMl; // Volume of the bowl (200 to 2000 ml)
  final double elapsedSeconds; // Current cycle elapsed time in seconds
  final double targetCycleMinutes; // Target time for full sink / tip (e.g. 30.0 min = half hour)
  final int totalCyclesCompleted; // Number of completed release cycles (ball drops)
  final bool isSimulating; // Running flag
  final double simulationSpeedMultiplier; // 1x to 60x speed for testing

  const HydroAutomataState({
    required this.mechanismType,
    required this.tankWaterLevelCm,
    required this.orificeDiameterMm,
    required this.floatBowlMassGrams,
    required this.bowlVolumeMl,
    required this.elapsedSeconds,
    required this.targetCycleMinutes,
    required this.totalCyclesCompleted,
    required this.isSimulating,
    required this.simulationSpeedMultiplier,
  });

  factory HydroAutomataState.initial() {
    return const HydroAutomataState(
      mechanismType: AutomataMechanismType.tarjaharSinkingFloat,
      tankWaterLevelCm: 60.0,
      orificeDiameterMm: 2.4, // Calibrated orifice for ~30 min sink
      floatBowlMassGrams: 180.0,
      bowlVolumeMl: 850.0,
      elapsedSeconds: 0.0,
      targetCycleMinutes: 30.0,
      totalCyclesCompleted: 0,
      isSimulating: true,
      simulationSpeedMultiplier: 10.0,
    );
  }

  /// Cross-sectional area of the submerged orifice: A = pi * (d/2)^2 in m^2
  double get orificeAreaM2 {
    final radiusM = (orificeDiameterMm / 2000.0);
    return math.pi * radiusM * radiusM;
  }

  /// Volumetric inflow rate via Torricelli's Law:
  /// Q = Cd * A * sqrt(2 * g * h_submerged)
  /// Using discharge coefficient Cd ~ 0.62 for sharp-edged classical orifice
  double get inflowRateMlPerSec {
    const cd = 0.62;
    const g = 9.80665;
    // Submerged depth estimated from bowl draft: h ~ 0.04 m average
    const hSubmerged = 0.04;
    final velocity = math.sqrt(2 * g * hSubmerged);
    final qM3PerSec = cd * orificeAreaM2 * velocity;
    return qM3PerSec * 1000000.0; // convert m^3/s to ml/s
  }

  /// Current water volume inside the bowl in ml
  double get currentBowlWaterMl {
    final filled = inflowRateMlPerSec * elapsedSeconds;
    return filled.clamp(0.0, bowlVolumeMl);
  }

  /// Fraction of bowl filled (0.0 = buoyant, 1.0 = submerged/sunk)
  double get fillFraction {
    if (bowlVolumeMl <= 0) return 1.0;
    return (currentBowlWaterMl / bowlVolumeMl).clamp(0.0, 1.0);
  }

  /// Sinking progress percentage (0% to 100%)
  double get sinkProgressPercent => fillFraction * 100.0;

  /// Theoretical seconds needed to fill bowl and trigger escapement
  double get theoreticalFillTimeSec {
    final rate = inflowRateMlPerSec;
    if (rate <= 0) return 0.0;
    return bowlVolumeMl / rate;
  }

  /// Pulley displacement in centimeters as bowl descends
  double get pulleyDisplacementCm {
    return fillFraction * 15.0; // 15 cm total stroke
  }

  /// Escapement wheel rotation angle in degrees
  double get escapementRotationDeg {
    return (fillFraction * 360.0) % 360.0;
  }

  HydroAutomataState copyWith({
    AutomataMechanismType? mechanismType,
    double? tankWaterLevelCm,
    double? orificeDiameterMm,
    double? floatBowlMassGrams,
    double? bowlVolumeMl,
    double? elapsedSeconds,
    double? targetCycleMinutes,
    int? totalCyclesCompleted,
    bool? isSimulating,
    double? simulationSpeedMultiplier,
  }) {
    return HydroAutomataState(
      mechanismType: mechanismType ?? this.mechanismType,
      tankWaterLevelCm: tankWaterLevelCm ?? this.tankWaterLevelCm,
      orificeDiameterMm: orificeDiameterMm ?? this.orificeDiameterMm,
      floatBowlMassGrams: floatBowlMassGrams ?? this.floatBowlMassGrams,
      bowlVolumeMl: bowlVolumeMl ?? this.bowlVolumeMl,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      targetCycleMinutes: targetCycleMinutes ?? this.targetCycleMinutes,
      totalCyclesCompleted: totalCyclesCompleted ?? this.totalCyclesCompleted,
      isSimulating: isSimulating ?? this.isSimulating,
      simulationSpeedMultiplier:
          simulationSpeedMultiplier ?? this.simulationSpeedMultiplier,
    );
  }
}

/// Controller managing Al-Jazari Hydro-Mechanical Automata Simulation
class HydroAutomataController extends ChangeNotifier {
  HydroAutomataState _state = HydroAutomataState.initial();

  HydroAutomataState get state => _state;

  void setMechanismType(AutomataMechanismType type) {
    _state = _state.copyWith(mechanismType: type, elapsedSeconds: 0.0);
    notifyListeners();
  }

  void setOrificeDiameter(double mm) {
    final clamped = mm.clamp(1.0, 10.0);
    _state = _state.copyWith(orificeDiameterMm: clamped);
    notifyListeners();
  }

  void setBowlVolume(double ml) {
    final clamped = ml.clamp(200.0, 2000.0);
    _state = _state.copyWith(bowlVolumeMl: clamped);
    notifyListeners();
  }

  void setSimulationSpeed(double multiplier) {
    final clamped = multiplier.clamp(1.0, 60.0);
    _state = _state.copyWith(simulationSpeedMultiplier: clamped);
    notifyListeners();
  }

  void toggleSimulation() {
    _state = _state.copyWith(isSimulating: !_state.isSimulating);
    notifyListeners();
  }

  /// Advance simulation by deltaTimeSeconds
  void tick(double deltaTimeSeconds) {
    if (!_state.isSimulating) return;

    final advance = deltaTimeSeconds * _state.simulationSpeedMultiplier;
    final newElapsed = _state.elapsedSeconds + advance;
    final maxSec = _state.theoreticalFillTimeSec;

    if (newElapsed >= maxSec && maxSec > 0) {
      // Trigger cycle completion (ball release and bowl reset via siphon/clearing)
      _state = _state.copyWith(
        elapsedSeconds: 0.0,
        totalCyclesCompleted: _state.totalCyclesCompleted + 1,
      );
    } else {
      _state = _state.copyWith(elapsedSeconds: newElapsed);
    }
    notifyListeners();
  }

  /// Calibrate orifice diameter to match target cycle (e.g. 30 minutes)
  void autoCalibrateForTargetMinutes(double targetMinutes) {
    // We want theoreticalFillTimeSec = targetMinutes * 60
    // bowlVolumeMl / inflowRate = targetSec
    // inflowRate = bowlVolumeMl / targetSec
    // Cd * A * sqrt(2gh) * 1e6 = targetRate
    // A = targetRate / (Cd * sqrt(2gh) * 1e6)
    // d = 2 * sqrt(A / pi) * 1000 in mm
    final targetSec = targetMinutes * 60.0;
    if (targetSec <= 0) return;

    final targetRateMlPerSec = _state.bowlVolumeMl / targetSec;
    const cd = 0.62;
    const g = 9.80665;
    const h = 0.04;
    final velocity = math.sqrt(2 * g * h);
    final targetAreaM2 = (targetRateMlPerSec / 1000000.0) / (cd * velocity);
    final targetRadiusM = math.sqrt(targetAreaM2 / math.pi);
    final targetDiameterMm = targetRadiusM * 2000.0;

    setOrificeDiameter(targetDiameterMm);
    _state = _state.copyWith(targetCycleMinutes: targetMinutes);
    notifyListeners();
  }

  void reset() {
    _state = HydroAutomataState.initial();
    notifyListeners();
  }
}
