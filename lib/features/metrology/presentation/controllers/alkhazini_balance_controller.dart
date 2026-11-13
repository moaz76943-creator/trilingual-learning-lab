import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// Precious Metals and Gemstones with historical Specific Gravity measured by Al-Khazini (1121 CE)
enum MetrologyMaterial {
  pureGold(
    nameAr: 'الذَّهَبُ الإِبْرِيزُ الخَالِصُ',
    nameDe: 'Reines Feingold',
    nameEn: 'Pure Gold',
    historicalDensity: 19.05, // Al-Khazini's measurement in 1121 CE (Modern: 19.32)
    modernDensity: 19.32,
  ),
  pureSilver(
    nameAr: 'الفِضَّةُ الخَالِصَةُ (اللُّجَيْنُ)',
    nameDe: 'Reines Feinsilber',
    nameEn: 'Pure Silver',
    historicalDensity: 10.30, // Al-Khazini: 10.30 (Modern: 10.49)
    modernDensity: 10.49,
  ),
  copper(
    nameAr: 'النُّحَاسُ الأَحْمَرُ',
    nameDe: 'Kupfer',
    nameEn: 'Copper',
    historicalDensity: 8.66, // Al-Khazini: 8.66 (Modern: 8.96)
    modernDensity: 8.96,
  ),
  tin(
    nameAr: 'القَصْدِيرُ (الرَّصَاصُ الأَبْيَضُ)',
    nameDe: 'Zinn',
    nameEn: 'Tin',
    historicalDensity: 7.15, // Al-Khazini: 7.15 (Modern: 7.31)
    modernDensity: 7.31,
  ),
  ruby(
    nameAr: 'اليَاقُوتُ الأَحْمَرُ البَدَخْشِيُّ',
    nameDe: 'Roter Rubin',
    nameEn: 'Ruby',
    historicalDensity: 3.91, // Al-Khazini: 3.91 (Modern: 4.00)
    modernDensity: 4.00,
  ),
  emerald(
    nameAr: 'الزُّمُرُّدُ الأَخْضَرُ المِصْرِيُّ',
    nameDe: 'Grüner Smaragd',
    nameEn: 'Emerald',
    historicalDensity: 2.75, // Al-Khazini: 2.75 (Modern: 2.76)
    modernDensity: 2.76,
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;
  final double historicalDensity; // g/cm³ (Al-Khazini 1121 CE)
  final double modernDensity; // g/cm³

  const MetrologyMaterial({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.historicalDensity,
    required this.modernDensity,
  });
}

/// Simulation Mode for the Balance of Wisdom
enum BalanceMode {
  specificGravityMeasurement(
    nameAr: 'تَعْيِينُ الوَزْنِ النَّوْعِيِّ لِمَعْدِنٍ نَقِيٍّ',
    nameDe: 'Bestimmung des spezifischen Gewichts',
    nameEn: 'Pure Material Specific Gravity Measurement',
  ),
  alloyFraudDetection(
    nameAr: 'كَشْفُ الغِشِّ فِي سَبِيكَةِ الذَّهَبِ وَالفِضَّةِ',
    nameDe: 'Legierungsanalyse & Betrugserkennung (Gold/Silber)',
    nameEn: 'Gold-Silver Alloy Analysis & Adulteration Detection',
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;

  const BalanceMode({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
  });
}

/// State representation for Al-Khazini Hydrostatic Balance
class AlKhaziniBalanceState {
  final BalanceMode mode;
  final MetrologyMaterial selectedMaterial;
  final double massInAirGrams; // Weight in air W_air (e.g. 100.0 g)
  final double goldPercentageInAlloy; // 0% to 100% for alloy mode
  final bool isImmersedInWater; // Flag for whether the water pan is submerged
  final double beamTiltAngleDeg; // Deflection of the scale beam (-15° to +15°)
  final double riderPositionCm; // Position of counterweight rider on beam
  final bool showBuoyancyVectors;

  const AlKhaziniBalanceState({
    required this.mode,
    required this.selectedMaterial,
    required this.massInAirGrams,
    required this.goldPercentageInAlloy,
    required this.isImmersedInWater,
    required this.beamTiltAngleDeg,
    required this.riderPositionCm,
    required this.showBuoyancyVectors,
  });

  factory AlKhaziniBalanceState.initial() {
    return const AlKhaziniBalanceState(
      mode: BalanceMode.alloyFraudDetection,
      selectedMaterial: MetrologyMaterial.pureGold,
      massInAirGrams: 100.0,
      goldPercentageInAlloy: 70.0, // 70% Gold, 30% Silver alloy
      isImmersedInWater: true,
      beamTiltAngleDeg: 0.0,
      riderPositionCm: 14.2,
      showBuoyancyVectors: true,
    );
  }

  /// Density of pure water at reference temperature (g/cm³)
  static const double waterDensity = 1.00;

  /// Effective density of the specimen in g/cm³
  double get effectiveDensity {
    if (mode == BalanceMode.specificGravityMeasurement) {
      return selectedMaterial.historicalDensity;
    } else {
      // Alloy of Gold and Silver:
      // 1 / rho_alloy = (f_gold / rho_gold) + ((1 - f_gold) / rho_silver)
      final fGold = goldPercentageInAlloy / 100.0;
      final fSilver = 1.0 - fGold;
      final rhoGold = MetrologyMaterial.pureGold.historicalDensity;
      final rhoSilver = MetrologyMaterial.pureSilver.historicalDensity;

      final recip = (fGold / rhoGold) + (fSilver / rhoSilver);
      return 1.0 / recip;
    }
  }

  /// Total physical volume of specimen in cm³: V = m / rho
  double get specimenVolumeCm3 {
    if (effectiveDensity <= 0) return 0.0;
    return massInAirGrams / effectiveDensity;
  }

  /// Apparent mass when submerged in water:
  /// W_water = W_air - (rho_water * V)
  double get massInWaterGrams {
    if (!isImmersedInWater) return massInAirGrams;
    final buoyantMassLoss = waterDensity * specimenVolumeCm3;
    return math.max(0.0, massInAirGrams - buoyantMassLoss);
  }

  /// Apparent loss of weight (Buoyant force in grams-force):
  /// F_buoyant = W_air - W_water
  double get buoyantMassLossGrams {
    return massInAirGrams - massInWaterGrams;
  }

  /// Calculated Specific Gravity (الوَزْنُ النَّوْعِيُّ) via Al-Khazini's formula:
  /// SG = W_air / (W_air - W_water)
  double get calculatedSpecificGravity {
    final loss = buoyantMassLossGrams;
    if (loss <= 1e-6) return 0.0;
    return massInAirGrams / loss;
  }

  /// Discovered Gold mass in alloy (in grams):
  /// m_gold = ( (1/rho_alloy - 1/rho_silver) / (1/rho_gold - 1/rho_silver) ) * m_total
  double get calculatedGoldMassGrams {
    if (mode != BalanceMode.alloyFraudDetection) return massInAirGrams;
    final rhoAlloy = calculatedSpecificGravity;
    final rhoGold = MetrologyMaterial.pureGold.historicalDensity;
    final rhoSilver = MetrologyMaterial.pureSilver.historicalDensity;

    final numerator = (1.0 / rhoAlloy) - (1.0 / rhoSilver);
    final denominator = (1.0 / rhoGold) - (1.0 / rhoSilver);
    if (denominator.abs() < 1e-9) return 0.0;

    final fGold = (numerator / denominator).clamp(0.0, 1.0);
    return fGold * massInAirGrams;
  }

  /// Discovered Silver mass in alloy
  double get calculatedSilverMassGrams {
    return math.max(0.0, massInAirGrams - calculatedGoldMassGrams);
  }

  /// Percentage error vs modern value
  double get errorVsModernPercentage {
    final modern = selectedMaterial.modernDensity;
    final hist = selectedMaterial.historicalDensity;
    return ((hist - modern) / modern) * 100.0;
  }

  AlKhaziniBalanceState copyWith({
    BalanceMode? mode,
    MetrologyMaterial? selectedMaterial,
    double? massInAirGrams,
    double? goldPercentageInAlloy,
    bool? isImmersedInWater,
    double? beamTiltAngleDeg,
    double? riderPositionCm,
    bool? showBuoyancyVectors,
  }) {
    return AlKhaziniBalanceState(
      mode: mode ?? this.mode,
      selectedMaterial: selectedMaterial ?? this.selectedMaterial,
      massInAirGrams: massInAirGrams ?? this.massInAirGrams,
      goldPercentageInAlloy:
          goldPercentageInAlloy ?? this.goldPercentageInAlloy,
      isImmersedInWater: isImmersedInWater ?? this.isImmersedInWater,
      beamTiltAngleDeg: beamTiltAngleDeg ?? this.beamTiltAngleDeg,
      riderPositionCm: riderPositionCm ?? this.riderPositionCm,
      showBuoyancyVectors: showBuoyancyVectors ?? this.showBuoyancyVectors,
    );
  }
}

/// Controller managing Al-Khazini Balance of Wisdom simulation
class AlKhaziniBalanceController extends ChangeNotifier {
  AlKhaziniBalanceState _state = AlKhaziniBalanceState.initial();

  AlKhaziniBalanceState get state => _state;

  void setMode(BalanceMode mode) {
    _state = _state.copyWith(mode: mode);
    notifyListeners();
  }

  void setMaterial(MetrologyMaterial material) {
    _state = _state.copyWith(selectedMaterial: material);
    notifyListeners();
  }

  void setMassInAir(double grams) {
    final clamped = grams.clamp(10.0, 500.0);
    _state = _state.copyWith(massInAirGrams: clamped);
    notifyListeners();
  }

  void setGoldPercentage(double pct) {
    final clamped = pct.clamp(0.0, 100.0);
    _state = _state.copyWith(goldPercentageInAlloy: clamped);
    notifyListeners();
  }

  void toggleWaterImmersion() {
    _state = _state.copyWith(isImmersedInWater: !_state.isImmersedInWater);
    notifyListeners();
  }

  void setRiderPosition(double cm) {
    final clamped = cm.clamp(0.0, 30.0);
    _state = _state.copyWith(riderPositionCm: clamped);
    notifyListeners();
  }

  void toggleVectors() {
    _state = _state.copyWith(showBuoyancyVectors: !_state.showBuoyancyVectors);
    notifyListeners();
  }

  /// Preset: King's Crown Adulteration Mystery
  void loadCrownAdulterationMystery() {
    _state = _state.copyWith(
      mode: BalanceMode.alloyFraudDetection,
      massInAirGrams: 200.0,
      goldPercentageInAlloy: 65.0, // Crown has 35% adulterated silver
      isImmersedInWater: true,
    );
    notifyListeners();
  }

  void reset() {
    _state = AlKhaziniBalanceState.initial();
    notifyListeners();
  }
}
