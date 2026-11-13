import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// Historical Horological Mechanisms in Islamic Astronomy
enum HorologyMechanismType {
  ibnYunusHarmonicPendulum(
    nameAr: 'نُوَّاسُ ابْنِ يُونُسَ المِصْرِيِّ (الرَّقَّاصُ الفَلَكِيُّ)',
    nameDe: 'Ibn-Yunus-Pendel (Astronomische Schwingungsmessung)',
    nameEn: 'Ibn Yunus Harmonic Pendulum (Astronomical Timer, Cairo 1000 CE)',
    descriptionAr: 'اسْتِخْدَامُ ذَبْذَبَةِ النُّوَّاسِ لِقِيَاسِ كُسُوفِ الشَّمْسِ وَرَصْدِ الكَوَاكِبِ قَبْلَ غَالِيلْيُو بِقُرُونٍ.',
  ),
  taqiyyAlDinVergeEscapement(
    nameAr: 'مِفْلاتُ تَقِيِّ الدِّينِ ذُو الإِكْلِيلِ وَالعَارِضَةِ (1577م)',
    nameDe: 'Taqi al-Din Spindelhemmung mit Foliot',
    nameEn: 'Taqi al-Din Verge & Foliot Mechanical Escapement (Istanbul 1577 CE)',
    descriptionAr: 'أَوَّلُ سَاعَةٍ مِيكَانِيكِيَّةٍ فَلَكِيَّةٍ تَقِيسُ الدَّقَائِقَ وَالثَّوَانِي بِاسْتِعْمَالِ دُولابِ الإِكْلِيلِ وَمِفْلاتِ الشَّوْكَةِ.',
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;
  final String descriptionAr;

  const HorologyMechanismType({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.descriptionAr,
  });
}

/// State representation for the Astronomical Horology Simulation
class IbnYunusPendulumState {
  final HorologyMechanismType mechanismType;
  final double pendulumLengthMeters; // Pendulum length L in meters (0.2 m to 2.5 m)
  final double initialAngleDeg; // Initial release amplitude theta_0 (5° to 45°)
  final double currentAngleDeg; // Instantaneous angle theta(t)
  final double angularVelocityDegSec; // Instantaneous angular velocity omega(t)
  final double elapsedSeconds; // Simulation time elapsed
  final int totalOscillationCount; // Full cycles completed
  final bool isSimulating; // Active running flag
  final double simulationTimeScale; // Speed multiplier (1x to 5x)
  final double gravityMps2; // Local gravitational acceleration (9.80665 m/s²)
  final bool showPhaseSpacePlot; // Toggle phase space portrait (theta vs omega)
  final int crownWheelTeethCount; // Number of teeth in verge escapement wheel (e.g. 15 or 21)

  const IbnYunusPendulumState({
    required this.mechanismType,
    required this.pendulumLengthMeters,
    required this.initialAngleDeg,
    required this.currentAngleDeg,
    required this.angularVelocityDegSec,
    required this.elapsedSeconds,
    required this.totalOscillationCount,
    required this.isSimulating,
    required this.simulationTimeScale,
    required this.gravityMps2,
    required this.showPhaseSpacePlot,
    required this.crownWheelTeethCount,
  });

  factory IbnYunusPendulumState.initial() {
    // 0.994 meters gives a seconds pendulum (Half-period = 1.0 second, Full Period = 2.0 s)
    return const IbnYunusPendulumState(
      mechanismType: HorologyMechanismType.ibnYunusHarmonicPendulum,
      pendulumLengthMeters: 0.994,
      initialAngleDeg: 15.0,
      currentAngleDeg: 15.0,
      angularVelocityDegSec: 0.0,
      elapsedSeconds: 0.0,
      totalOscillationCount: 0,
      isSimulating: true,
      simulationTimeScale: 1.0,
      gravityMps2: 9.80665,
      showPhaseSpacePlot: true,
      crownWheelTeethCount: 15,
    );
  }

  /// Small-angle theoretical natural period: T0 = 2 * pi * sqrt(L / g)
  double get smallAnglePeriodSec {
    return 2.0 * math.pi * math.sqrt(pendulumLengthMeters / gravityMps2);
  }

  /// Borda-Ibn Yunus finite amplitude correction for Period:
  /// T = T0 * (1 + 1/16 * theta0^2 + 11/3072 * theta0^4)
  double get exactPeriodSec {
    final thetaRad = initialAngleDeg * (math.pi / 180.0);
    final correction = 1.0 + (1.0 / 16.0) * math.pow(thetaRad, 2);
    return smallAnglePeriodSec * correction;
  }

  /// Natural angular frequency: omega0 = sqrt(g / L) in rad/s
  double get naturalFrequencyRadSec {
    return math.sqrt(gravityMps2 / pendulumLengthMeters);
  }

  /// Escapement Beat Frequency (Ticks per minute)
  double get beatsPerMinute {
    final period = exactPeriodSec;
    if (period <= 0) return 0.0;
    // Each half-period produces one tick (beat) of the verge escapement
    return (2.0 / period) * 60.0;
  }

  /// Linear displacement of the pendulum bob in centimeters
  double get bobDisplacementCm {
    final thetaRad = currentAngleDeg * (math.pi / 180.0);
    return (pendulumLengthMeters * math.sin(thetaRad)) * 100.0;
  }

  /// Escapement crown wheel rotation angle in degrees
  double get crownWheelRotationDeg {
    // Each full oscillation advances the crown wheel by 2 teeth
    final fraction = (elapsedSeconds / exactPeriodSec) % 1.0;
    final totalSteps = (totalOscillationCount * 2) + (fraction * 2);
    return (totalSteps * (360.0 / crownWheelTeethCount)) % 360.0;
  }

  IbnYunusPendulumState copyWith({
    HorologyMechanismType? mechanismType,
    double? pendulumLengthMeters,
    double? initialAngleDeg,
    double? currentAngleDeg,
    double? angularVelocityDegSec,
    double? elapsedSeconds,
    int? totalOscillationCount,
    bool? isSimulating,
    double? simulationTimeScale,
    double? gravityMps2,
    bool? showPhaseSpacePlot,
    int? crownWheelTeethCount,
  }) {
    return IbnYunusPendulumState(
      mechanismType: mechanismType ?? this.mechanismType,
      pendulumLengthMeters: pendulumLengthMeters ?? this.pendulumLengthMeters,
      initialAngleDeg: initialAngleDeg ?? this.initialAngleDeg,
      currentAngleDeg: currentAngleDeg ?? this.currentAngleDeg,
      angularVelocityDegSec:
          angularVelocityDegSec ?? this.angularVelocityDegSec,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      totalOscillationCount:
          totalOscillationCount ?? this.totalOscillationCount,
      isSimulating: isSimulating ?? this.isSimulating,
      simulationTimeScale: simulationTimeScale ?? this.simulationTimeScale,
      gravityMps2: gravityMps2 ?? this.gravityMps2,
      showPhaseSpacePlot: showPhaseSpacePlot ?? this.showPhaseSpacePlot,
      crownWheelTeethCount: crownWheelTeethCount ?? this.crownWheelTeethCount,
    );
  }
}

/// Controller managing Ibn Yunus & Taqi al-Din Horology Simulation
class IbnYunusPendulumController extends ChangeNotifier {
  IbnYunusPendulumState _state = IbnYunusPendulumState.initial();

  IbnYunusPendulumState get state => _state;

  void setMechanismType(HorologyMechanismType type) {
    _state = _state.copyWith(mechanismType: type);
    notifyListeners();
  }

  void setPendulumLength(double meters) {
    final clamped = meters.clamp(0.1, 3.0);
    _state = _state.copyWith(pendulumLengthMeters: clamped);
    notifyListeners();
  }

  void setInitialAngle(double degrees) {
    final clamped = degrees.clamp(2.0, 45.0);
    _state = _state.copyWith(
      initialAngleDeg: clamped,
      currentAngleDeg: clamped,
      angularVelocityDegSec: 0.0,
    );
    notifyListeners();
  }

  void toggleSimulation() {
    _state = _state.copyWith(isSimulating: !_state.isSimulating);
    notifyListeners();
  }

  void setTimeScale(double scale) {
    final clamped = scale.clamp(0.2, 5.0);
    _state = _state.copyWith(simulationTimeScale: clamped);
    notifyListeners();
  }

  void togglePhaseSpace() {
    _state = _state.copyWith(showPhaseSpacePlot: !_state.showPhaseSpacePlot);
    notifyListeners();
  }

  /// Preset: Seconds Pendulum (بَنْدُولُ الثَّوَانِي - نِصْفُ الدَّوْرَةِ ثَانِيَةٌ وَاحِدَةٌ)
  void loadSecondsPendulumPreset() {
    // Length = 0.994 meters gives T = 2.000 s
    _state = _state.copyWith(
      pendulumLengthMeters: 0.994,
      initialAngleDeg: 10.0,
      currentAngleDeg: 10.0,
      angularVelocityDegSec: 0.0,
      elapsedSeconds: 0.0,
      totalOscillationCount: 0,
    );
    notifyListeners();
  }

  /// Numerical physics integration tick via Verlet/RK4 approximation
  void tick(double dtSeconds) {
    if (!_state.isSimulating) return;

    final dt = dtSeconds * _state.simulationTimeScale;
    final l = _state.pendulumLengthMeters;
    final g = _state.gravityMps2;

    // Current states in radians
    double thetaRad = _state.currentAngleDeg * (math.pi / 180.0);
    double omegaRad = _state.angularVelocityDegSec * (math.pi / 180.0);

    // Angular acceleration: alpha = - (g / L) * sin(theta)
    final alpha = - (g / l) * math.sin(thetaRad);

    // Semi-implicit Euler integration
    omegaRad += alpha * dt;
    thetaRad += omegaRad * dt;

    final newAngleDeg = thetaRad * (180.0 / math.pi);
    final newOmegaDeg = omegaRad * (180.0 / math.pi);
    final newElapsed = _state.elapsedSeconds + dt;

    // Detect zero-crossing / cycle count
    final period = _state.exactPeriodSec;
    final cycles = (newElapsed / period).floor();

    _state = _state.copyWith(
      currentAngleDeg: newAngleDeg,
      angularVelocityDegSec: newOmegaDeg,
      elapsedSeconds: newElapsed,
      totalOscillationCount: cycles,
    );
    notifyListeners();
  }

  void reset() {
    _state = IbnYunusPendulumState.initial();
    notifyListeners();
  }
}
