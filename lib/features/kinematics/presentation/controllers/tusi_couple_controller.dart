import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// Kinematic Mode of the Tusi Couple Device
enum TusiCoupleMode {
  pureLinearOscillation(
    nameAr: 'الحَرَكَةُ المُسْتَقِيمَةُ التَّامَّةُ (نُقْطَةُ المُحِيطِ d = r)',
    nameDe: 'Exakte lineare Oszillation (Umfangspunkt d = r)',
    nameEn: 'Pure Rectilinear Motion (Perimeter Point d = r)',
    descriptionAr: 'نُقْطَةٌ عَلَى مُحِيطِ الدَّائِرَةِ الصُّغْرَى تَتَحَرَّكُ حَرَكَةً خَطِّيَّةً مُسْتَقِيمَةً تَامَّةً عَلَى قُطْرِ الدَّائِرَةِ الكُبْرَى.',
  ),
  ellipticalTrajectory(
    nameAr: 'المَسَارُ الإِهْلِيلَجِيُّ (نُقْطَةٌ دَاخِلِيَّةٌ d ≠ r)',
    nameDe: 'Elliptische Bahn (Innen-/Außenpunkt d ≠ r)',
    nameEn: 'Elliptic Trammel Trajectory (Generalized d ≠ r)',
    descriptionAr: 'إِذَا كَانَتِ النُّقْطَةُ عَلَى بُعْدٍ مُخْتَلِفٍ عَنْ مَرْكَزِ الدَّائِرَةِ الصُّغْرَى، يَتَحَوَّلُ المَسَارُ إِلَى قَطْعٍ نَاقِصٍ (إِهْلِيلَج).',
  ),
  copernicanMercuryModel(
    nameAr: 'نَمُوذَجُ مَرَاغَة وَكُوبِرْنِيكُوس لِعُطَارِدَ وَالقَمَرِ',
    nameDe: 'Kopernikanisch-Maragha-Modell für Merkur',
    nameEn: 'Maragha-Copernican Planetary Model for Mercury & Moon',
    descriptionAr: 'اسْتَخْدَمَ كُوبِرْنِيكُوس مُزْدَوِجَةَ الطُّوسِيِّ حَرْفِيّاً لِتَفْسِيرِ تَرَاجُعِ حَرَكَةِ عُطَارِدَ دُونَ الحَاجَةِ لِمُعَدِّلِ المَسِيرِ البَطْلِيمُوسِيِّ.',
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;
  final String descriptionAr;

  const TusiCoupleMode({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.descriptionAr,
  });
}

/// State representation for the Tusi Couple Kinematic Simulation
class TusiCoupleState {
  final TusiCoupleMode mode;
  final double outerRadiusR; // Radius of outer stationary circle (e.g. 100.0 mm)
  final double pointOffsetRatio; // Distance of tracing point P from inner center as fraction of r (d / r)
  final double rotationAngleThetaDeg; // Orbit angle theta of inner circle center (0° to 360°)
  final double angularSpeedRpm; // Rotation speed in RPM (e.g. 15 RPM)
  final bool isSimulating; // Running toggle
  final bool showVelocityVector; // Show instantaneous velocity arrow
  final bool showHarmonicWaveform; // Show real-time x(t) wave
  final List<Offset> trajectoryHistory; // Traced points for trail visualization

  const TusiCoupleState({
    required this.mode,
    required this.outerRadiusR,
    required this.pointOffsetRatio,
    required this.rotationAngleThetaDeg,
    required this.angularSpeedRpm,
    required this.isSimulating,
    required this.showVelocityVector,
    required this.showHarmonicWaveform,
    required this.trajectoryHistory,
  });

  factory TusiCoupleState.initial() {
    return const TusiCoupleState(
      mode: TusiCoupleMode.pureLinearOscillation,
      outerRadiusR: 120.0,
      pointOffsetRatio: 1.0, // d = r for exact straight line
      rotationAngleThetaDeg: 0.0,
      angularSpeedRpm: 12.0,
      isSimulating: true,
      showVelocityVector: true,
      showHarmonicWaveform: true,
      trajectoryHistory: [],
    );
  }

  /// Radius of the rolling inner circle: r = R / 2
  double get innerRadiusR => outerRadiusR / 2.0;

  /// Distance d of the traced point from inner circle center: d = pointOffsetRatio * r
  double get tracingPointDistance => pointOffsetRatio * innerRadiusR;

  /// Angle theta in radians
  double get thetaRad => rotationAngleThetaDeg * (math.pi / 180.0);

  /// Center coordinates of the rolling inner circle:
  /// C_inner = (r * cos(theta), r * sin(theta))
  Offset get innerCenter {
    final r = innerRadiusR;
    return Offset(r * math.cos(thetaRad), r * math.sin(thetaRad));
  }

  /// Coordinates of the traced point P:
  /// By Al-Tusi's theorem, the inner circle rotates by -2*theta around its center.
  /// x = r * cos(theta) + d * cos(-theta) = (r + d) * cos(theta)
  /// y = r * sin(theta) + d * sin(-theta) = (r - d) * sin(theta)
  Offset get tracingPoint {
    final r = innerRadiusR;
    final d = tracingPointDistance;
    final x = (r + d) * math.cos(thetaRad);
    final y = (r - d) * math.sin(thetaRad);
    return Offset(x, y);
  }

  /// Instantaneous velocity vector v = dP/dt
  /// vx = -(r + d) * omega * sin(theta)
  /// vy = (r - d) * omega * cos(theta)
  Offset get velocityVector {
    final omega = (angularSpeedRpm * 2 * math.pi) / 60.0; // rad/s
    final r = innerRadiusR;
    final d = tracingPointDistance;
    final vx = -(r + d) * omega * math.sin(thetaRad);
    final vy = (r - d) * omega * math.cos(thetaRad);
    return Offset(vx, vy);
  }

  /// Linear velocity magnitude in mm/s
  double get speedMmSec => velocityVector.distance;

  /// Semi-major axis of the generated ellipse: a = r + d
  double get semiMajorAxis => innerRadiusR + tracingPointDistance;

  /// Semi-minor axis of the generated ellipse: b = |r - d|
  double get semiMinorAxis => (innerRadiusR - tracingPointDistance).abs();

  /// Oscillation frequency in Hertz (Hz)
  double get frequencyHz => angularSpeedRpm / 60.0;

  TusiCoupleState copyWith({
    TusiCoupleMode? mode,
    double? outerRadiusR,
    double? pointOffsetRatio,
    double? rotationAngleThetaDeg,
    double? angularSpeedRpm,
    bool? isSimulating,
    bool? showVelocityVector,
    bool? showHarmonicWaveform,
    List<Offset>? trajectoryHistory,
  }) {
    return TusiCoupleState(
      mode: mode ?? this.mode,
      outerRadiusR: outerRadiusR ?? this.outerRadiusR,
      pointOffsetRatio: pointOffsetRatio ?? this.pointOffsetRatio,
      rotationAngleThetaDeg:
          rotationAngleThetaDeg ?? this.rotationAngleThetaDeg,
      angularSpeedRpm: angularSpeedRpm ?? this.angularSpeedRpm,
      isSimulating: isSimulating ?? this.isSimulating,
      showVelocityVector: showVelocityVector ?? this.showVelocityVector,
      showHarmonicWaveform: showHarmonicWaveform ?? this.showHarmonicWaveform,
      trajectoryHistory: trajectoryHistory ?? this.trajectoryHistory,
    );
  }
}

/// Controller managing Nasir al-Din al-Tusi Couple Kinematics
class TusiCoupleController extends ChangeNotifier {
  TusiCoupleState _state = TusiCoupleState.initial();

  TusiCoupleState get state => _state;

  void setMode(TusiCoupleMode mode) {
    double ratio = 1.0;
    if (mode == TusiCoupleMode.ellipticalTrajectory) {
      ratio = 0.55; // Inner point producing clear ellipse
    } else if (mode == TusiCoupleMode.copernicanMercuryModel) {
      ratio = 1.0;
    }
    _state = _state.copyWith(
      mode: mode,
      pointOffsetRatio: ratio,
      trajectoryHistory: [],
    );
    notifyListeners();
  }

  void setPointOffsetRatio(double ratio) {
    final clamped = ratio.clamp(0.0, 2.0);
    _state = _state.copyWith(
      pointOffsetRatio: clamped,
      trajectoryHistory: [],
    );
    notifyListeners();
  }

  void setAngularSpeedRpm(double rpm) {
    final clamped = rpm.clamp(2.0, 60.0);
    _state = _state.copyWith(angularSpeedRpm: clamped);
    notifyListeners();
  }

  void toggleSimulation() {
    _state = _state.copyWith(isSimulating: !_state.isSimulating);
    notifyListeners();
  }

  void toggleVelocityVector() {
    _state = _state.copyWith(showVelocityVector: !_state.showVelocityVector);
    notifyListeners();
  }

  void toggleHarmonicWaveform() {
    _state = _state.copyWith(showHarmonicWaveform: !_state.showHarmonicWaveform);
    notifyListeners();
  }

  void clearTrail() {
    _state = _state.copyWith(trajectoryHistory: []);
    notifyListeners();
  }

  /// Simulation physics tick
  void tick(double dtSeconds) {
    if (!_state.isSimulating) return;

    final dThetaDeg = (_state.angularSpeedRpm * 360.0 / 60.0) * dtSeconds;
    final newAngle = (_state.rotationAngleThetaDeg + dThetaDeg) % 360.0;

    // Record trajectory point
    final pt = _state.tracingPoint;
    final history = List<Offset>.from(_state.trajectoryHistory);
    history.add(pt);
    if (history.length > 200) {
      history.removeAt(0);
    }

    _state = _state.copyWith(
      rotationAngleThetaDeg: newAngle,
      trajectoryHistory: history,
    );
    notifyListeners();
  }

  void reset() {
    _state = TusiCoupleState.initial();
    notifyListeners();
  }
}
