import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// Representation of a Cartesian 2D point.
class PatternPoint {
  final double x;
  final double y;
  const PatternPoint(this.x, this.y);
}

/// Geometric star pattern preset.
class StarPatternPreset {
  final int foldCount; // 6, 8, 10, 12
  final String nameAr;
  final String nameDe;
  final String nameEn;
  final double defaultInnerRatio;
  final String historicalContextAr;

  const StarPatternPreset({
    required this.foldCount,
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.defaultInnerRatio,
    required this.historicalContextAr,
  });
}

/// Controller governing dynamic Islamic geometric star polygon generation and construction stages.
class GeometricPatternController extends ChangeNotifier {
  int _activeFoldIndex = 1; // Default to 8-fold star (خاتم ثماني)
  double _innerRadiusRatio = 0.50; // Inner/outer radius ratio
  double _rotationAngleDegrees = 0.0;
  int _constructionStage = 3; // 0: Circle, 1: Division points, 2: Chords, 3: Full Interlacing

  GeometricPatternController({
    int initialFoldIndex = 1,
    double initialInnerRatio = 0.50,
    int initialStage = 3,
  })  : _activeFoldIndex = initialFoldIndex,
        _innerRadiusRatio = initialInnerRatio,
        _constructionStage = initialStage;

  int get activeFoldIndex => _activeFoldIndex;
  double get innerRadiusRatio => _innerRadiusRatio;
  double get rotationAngleDegrees => _rotationAngleDegrees;
  int get constructionStage => _constructionStage;

  StarPatternPreset get activePreset => presets[_activeFoldIndex];
  int get foldCount => activePreset.foldCount;

  static const List<StarPatternPreset> presets = [
    StarPatternPreset(
      foldCount: 6,
      nameAr: 'النَّجْمَةُ السُّدَاسِيَّةُ الزَّهْرِيَّةُ',
      nameDe: 'Das sechsstrahlige Rosettenmuster',
      nameEn: 'The 6-Fold Hexagram Rosette',
      defaultInnerRatio: 0.577,
      historicalContextAr: 'شَائِعَةٌ فِي نُقُوشِ المَمَالِيكِ وَمَنَابِرِ الجَوَامِعِ الخَشَبِيَّةِ.',
    ),
    StarPatternPreset(
      foldCount: 8,
      nameAr: 'الخَاتَمُ الثُّمَانِيُّ الأَنْدَلُسِيُّ',
      nameDe: 'Das achteckige andalusische Sternmuster',
      nameEn: 'The 8-Fold Andalusian Star (Khatam)',
      defaultInnerRatio: 0.541,
      historicalContextAr: 'أَسَاسُ زَخَارِفِ قَصْرِ الحَمْرَاءِ فِي غَرْنَاطَةَ وَالفُسَيْفِسَاءِ الزَّلِّيجِيَّةِ.',
    ),
    StarPatternPreset(
      foldCount: 10,
      nameAr: 'النَّجْمَةُ العَشَارِيَّةُ السَّلْجُوقِيَّةُ',
      nameDe: 'Das zehnstrahlige seldschukische Muster',
      nameEn: 'The 10-Fold Seljuk Decagram',
      defaultInnerRatio: 0.588,
      historicalContextAr: 'ابْتَكَرَهَا عُلَمَاءُ الرِّيَاضِيَّاتِ فِي مَرَاصِدِ مَرَاغَةَ وَإِصْفَهَانَ.',
    ),
    StarPatternPreset(
      foldCount: 12,
      nameAr: 'النَّجْمَةُ الِاثْنَا عَشَرِيَّةُ الكُبْرَى',
      nameDe: 'Das zwölfstrahlige Monumentalmuster',
      nameEn: 'The 12-Fold Monumental Dodecagram',
      defaultInnerRatio: 0.620,
      historicalContextAr: 'قِمَّةُ التَّعْقِيدِ الهَنْدَسِيِّ فِي مَسَاجِدِ سَمَرْقَنْدَ وَالقَاهِرَةِ.',
    ),
  ];

  /// Selects preset fold count.
  void selectPreset(int index) {
    if (index >= 0 && index < presets.length && _activeFoldIndex != index) {
      _activeFoldIndex = index;
      _innerRadiusRatio = presets[index].defaultInnerRatio;
      notifyListeners();
    }
  }

  /// Sets inner/outer radius ratio.
  void setInnerRadiusRatio(double ratio) {
    final clamped = ratio.clamp(0.20, 0.85);
    if (_innerRadiusRatio != clamped) {
      _innerRadiusRatio = clamped;
      notifyListeners();
    }
  }

  /// Sets pattern rotation.
  void setRotation(double degrees) {
    _rotationAngleDegrees = degrees % 360.0;
    notifyListeners();
  }

  /// Advances or retreats construction stages (0 to 3).
  void setConstructionStage(int stage) {
    final clamped = stage.clamp(0, 3);
    if (_constructionStage != clamped) {
      _constructionStage = clamped;
      notifyListeners();
    }
  }

  /// Computes vertices for star polygon points centered at (centerX, centerY).
  List<PatternPoint> calculateStarVertices(double centerX, double centerY, double outerRadius) {
    final points = <PatternPoint>[];
    final totalPoints = foldCount * 2;
    final angleStep = (math.pi * 2.0) / totalPoints;
    final rotationRad = _rotationAngleDegrees * (math.pi / 180.0);
    final innerRadius = outerRadius * _innerRadiusRatio;

    for (var i = 0; i < totalPoints; i++) {
      final angle = (i * angleStep) - (math.pi / 2.0) + rotationRad;
      final radius = (i % 2 == 0) ? outerRadius : innerRadius;
      final x = centerX + (radius * math.cos(angle));
      final y = centerY + (radius * math.sin(angle));
      points.add(PatternPoint(x, y));
    }

    return points;
  }

  /// Calculates the vertex tip angle in degrees.
  double get vertexTipAngleDegrees {
    return ((1.0 - (2.0 / foldCount)) * 180.0).clamp(0.0, 180.0);
  }

  /// Resets to baseline Andalusian 8-fold star.
  void reset() {
    _activeFoldIndex = 1;
    _innerRadiusRatio = presets[1].defaultInnerRatio;
    _rotationAngleDegrees = 0.0;
    _constructionStage = 3;
    notifyListeners();
  }
}
