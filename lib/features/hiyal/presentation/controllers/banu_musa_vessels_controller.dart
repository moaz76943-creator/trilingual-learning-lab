import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// The Classical Banu Musa Hydro-Mechanical Vessel Mechanism
enum BanuMusaVesselType {
  cupOfJustice(
    nameAr: 'كَأْسُ العَدْلِ (كَأْسُ فِيثَاغُورُس ذَاتُ السَّيْفُونِ المَرْكَزِيِّ)',
    nameDe: 'Becher der Gerechtigkeit (Zentraler Heberbecher)',
    nameEn: 'Cup of Justice (Greed Siphon Cup)',
    descriptionAr: 'كَأْسٌ تَحْتَفِظُ بِالشَّرَابِ مَا لَمْ يَتَجَاوَزْ حَدَّ الكَفَافِ؛ فَإِذَا زَادَ عَنْهُ مَلأَ السَّيْفُونَ وَفَرَّغَ الكَأْسَ كُلَّهَا.',
  ),
  concentricFloatValve(
    nameAr: 'صَمَّامُ الطَّفْوِ المُزْدَوَجِ (الإِنَاءُ دَائِمُ الامْتِلاءِ)',
    nameDe: 'Schwimmerventil-Gefäß (Selbstregulierend)',
    nameEn: 'Concentric Float Valve (Self-Regulating Basin)',
    descriptionAr: 'صَمَّامٌ يَعْتَمِدُ عَلَى طَوْفَانِ كُرَةٍ نُحَاسِيَّةٍ تُغْلِقُ مَجْرَى التَّدَفُّقِ عِنْدَ بُلُوغِ الحَدِّ المَطْلُوبِ.',
  ),
  alternatingLiquidDispenser(
    nameAr: 'إِنَاءُ الصَّبِّ المُتَنَاوِبِ (الهَوَاءُ وَالضَّغْطُ الجَوِّيُّ)',
    nameDe: 'Alternierendes Doppelgefäß (Pneumatische Sperre)',
    nameEn: 'Alternating Dispenser (Atmospheric Air-Lock)',
    descriptionAr: 'إِنَاءٌ يَسْكُبُ سَائِلَيْنِ مُخْتَلِفَيْنِ بِالتَّنَاوُبِ عَبْرَ سَدَّادَاتِ التَّنْفِيسِ الهَوَائِيِّ الدَّقِيقَةِ.',
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;
  final String descriptionAr;

  const BanuMusaVesselType({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.descriptionAr,
  });
}

/// Simulation State for Banu Musa Trick Vessels
class BanuMusaVesselsState {
  final BanuMusaVesselType vesselType;
  final double currentLiquidVolumeMl; // Current volume of liquid in the vessel (0 to 600 ml)
  final double maxCapacityMl; // Total vessel volumetric capacity (e.g. 500 ml)
  final double siphonThresholdVolumeMl; // Volume at which siphon apex is breached (e.g. 350 ml)
  final double siphonDiameterMm; // Diameter of central concentric siphon tube (2.0 to 10.0 mm)
  final double vesselHeightCm; // Height of the cup (e.g. 15.0 cm)
  final bool isSiphonActive; // Flag indicating whether siphon flow has triggered and is draining
  final bool isPouringIn; // External inflow toggle
  final double inflowRateMlSec; // Inflow rate when pouring (e.g. 25 ml/s)
  final int totalDrainsTriggered; // Number of times greed/overflow triggered complete draining

  const BanuMusaVesselsState({
    required this.vesselType,
    required this.currentLiquidVolumeMl,
    required this.maxCapacityMl,
    required this.siphonThresholdVolumeMl,
    required this.siphonDiameterMm,
    required this.vesselHeightCm,
    required this.isSiphonActive,
    required this.isPouringIn,
    required this.inflowRateMlSec,
    required this.totalDrainsTriggered,
  });

  factory BanuMusaVesselsState.initial() {
    return const BanuMusaVesselsState(
      vesselType: BanuMusaVesselType.cupOfJustice,
      currentLiquidVolumeMl: 250.0, // starts well below siphon threshold (safe)
      maxCapacityMl: 500.0,
      siphonThresholdVolumeMl: 350.0,
      siphonDiameterMm: 6.0,
      vesselHeightCm: 16.0,
      isSiphonActive: false,
      isPouringIn: false,
      inflowRateMlSec: 35.0,
      totalDrainsTriggered: 0,
    );
  }

  /// Percentage of cup filled (0% to 100%)
  double get fillPercentage =>
      (currentLiquidVolumeMl / maxCapacityMl).clamp(0.0, 1.0) * 100.0;

  /// Height of liquid column in centimeters inside the cup
  double get liquidHeightCm {
    if (maxCapacityMl <= 0) return 0.0;
    return (currentLiquidVolumeMl / maxCapacityMl) * vesselHeightCm;
  }

  /// Height of the siphon apex in centimeters
  double get siphonApexHeightCm {
    return (siphonThresholdVolumeMl / maxCapacityMl) * vesselHeightCm;
  }

  /// Hydrostatic Pressure at the bottom of the cup in Pascals:
  /// P = rho * g * h
  /// rho_water ~ 1000 kg/m^3, g = 9.80665 m/s^2, h in meters
  double get hydrostaticPressurePascal {
    const rho = 1000.0;
    const g = 9.80665;
    final hMeters = liquidHeightCm / 100.0;
    return rho * g * hMeters;
  }

  /// Cross-sectional area of the siphon tube in square meters:
  /// A = pi * (d / 2000)^2
  double get siphonAreaM2 {
    final radiusM = (siphonDiameterMm / 2000.0);
    return math.pi * radiusM * radiusM;
  }

  /// Siphon discharge flow rate in ml/s via Torricelli's Law:
  /// Q = Cd * A * sqrt(2 * g * h_effective)
  /// Cd ~ 0.85 for smooth siphon pipe
  double get siphonDischargeRateMlSec {
    if (!isSiphonActive || currentLiquidVolumeMl <= 0) return 0.0;

    const cd = 0.85;
    const g = 9.80665;
    // Effective head is the height from liquid surface to bottom outlet
    final effectiveHeadM = (liquidHeightCm + 4.0) / 100.0; // plus outlet stem drop
    final velocity = math.sqrt(2 * g * math.max(0.01, effectiveHeadM));
    final qM3Sec = cd * siphonAreaM2 * velocity;
    return qM3Sec * 1000000.0; // convert m^3/s to ml/s
  }

  /// Indicates if liquid is in the "Justice" (Safe) zone
  bool get isSafeZone => currentLiquidVolumeMl <= siphonThresholdVolumeMl;

  BanuMusaVesselsState copyWith({
    BanuMusaVesselType? vesselType,
    double? currentLiquidVolumeMl,
    double? maxCapacityMl,
    double? siphonThresholdVolumeMl,
    double? siphonDiameterMm,
    double? vesselHeightCm,
    bool? isSiphonActive,
    bool? isPouringIn,
    double? inflowRateMlSec,
    int? totalDrainsTriggered,
  }) {
    return BanuMusaVesselsState(
      vesselType: vesselType ?? this.vesselType,
      currentLiquidVolumeMl:
          currentLiquidVolumeMl ?? this.currentLiquidVolumeMl,
      maxCapacityMl: maxCapacityMl ?? this.maxCapacityMl,
      siphonThresholdVolumeMl:
          siphonThresholdVolumeMl ?? this.siphonThresholdVolumeMl,
      siphonDiameterMm: siphonDiameterMm ?? this.siphonDiameterMm,
      vesselHeightCm: vesselHeightCm ?? this.vesselHeightCm,
      isSiphonActive: isSiphonActive ?? this.isSiphonActive,
      isPouringIn: isPouringIn ?? this.isPouringIn,
      inflowRateMlSec: inflowRateMlSec ?? this.inflowRateMlSec,
      totalDrainsTriggered: totalDrainsTriggered ?? this.totalDrainsTriggered,
    );
  }
}

/// Controller managing Banu Musa Trick Vessels & Siphon Simulation
class BanuMusaVesselsController extends ChangeNotifier {
  BanuMusaVesselsState _state = BanuMusaVesselsState.initial();

  BanuMusaVesselsState get state => _state;

  void setVesselType(BanuMusaVesselType type) {
    _state = _state.copyWith(
      vesselType: type,
      currentLiquidVolumeMl: 250.0,
      isSiphonActive: false,
      isPouringIn: false,
    );
    notifyListeners();
  }

  void setLiquidVolume(double ml) {
    final clamped = ml.clamp(0.0, _state.maxCapacityMl);
    final triggered = clamped > _state.siphonThresholdVolumeMl;
    _state = _state.copyWith(
      currentLiquidVolumeMl: clamped,
      isSiphonActive: triggered || _state.isSiphonActive,
    );
    notifyListeners();
  }

  void setSiphonThreshold(double ml) {
    final clamped = ml.clamp(100.0, _state.maxCapacityMl - 50.0);
    _state = _state.copyWith(siphonThresholdVolumeMl: clamped);
    notifyListeners();
  }

  void setSiphonDiameter(double mm) {
    final clamped = mm.clamp(2.0, 12.0);
    _state = _state.copyWith(siphonDiameterMm: clamped);
    notifyListeners();
  }

  void togglePouring() {
    _state = _state.copyWith(isPouringIn: !_state.isPouringIn);
    notifyListeners();
  }

  /// Simulation physics tick (e.g. 60 FPS delta)
  void tick(double dtSeconds) {
    double vol = _state.currentLiquidVolumeMl;
    bool active = _state.isSiphonActive;
    int drains = _state.totalDrainsTriggered;

    // 1. Handle Inflow if pouring
    if (_state.isPouringIn) {
      vol += _state.inflowRateMlSec * dtSeconds;
      if (vol >= _state.maxCapacityMl) {
        vol = _state.maxCapacityMl;
      }
    }

    // 2. Check Siphon Trigger Threshold
    if (!active && vol > _state.siphonThresholdVolumeMl) {
      active = true;
      drains++;
    }

    // 3. Handle Siphon Outflow if active
    if (active) {
      final outflow = _state.siphonDischargeRateMlSec * dtSeconds;
      vol -= outflow;
      if (vol <= 2.0) {
        // Siphon breaks when bottom air enters
        vol = 0.0;
        active = false;
      }
    }

    _state = _state.copyWith(
      currentLiquidVolumeMl: vol,
      isSiphonActive: active,
      totalDrainsTriggered: drains,
    );
    notifyListeners();
  }

  void fillToSafeLimit() {
    _state = _state.copyWith(
      currentLiquidVolumeMl: _state.siphonThresholdVolumeMl - 30.0,
      isSiphonActive: false,
    );
    notifyListeners();
  }

  void triggerGreedOverflow() {
    _state = _state.copyWith(
      currentLiquidVolumeMl: _state.siphonThresholdVolumeMl + 20.0,
      isSiphonActive: true,
      totalDrainsTriggered: _state.totalDrainsTriggered + 1,
    );
    notifyListeners();
  }

  void reset() {
    _state = BanuMusaVesselsState.initial();
    notifyListeners();
  }
}
