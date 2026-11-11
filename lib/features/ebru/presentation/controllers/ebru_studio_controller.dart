import 'dart:math' as math;
import 'package:flutter/foundation.dart';

enum EbruToolType {
  dropper, // إِسْقَاطُ النِّقَاطِ
  stylus,  // تَحْرِيكُ المِرْوَدِ
  comb,    // التَّمْشِيطُ (Gel-Git)
}

enum EbruPatternStyle {
  battal,  // بَتَّالٌ (طَبِيعِيٌّ)
  gelGit,  // ذَهَابٌ وَإِيَابٌ
  tarama,  // تَسْرِيحٌ مُمَشَّطٌ
}

/// A floating pigment drop on the marbling tray.
class EbruPigmentDrop {
  final double x;
  final double y;
  final double radius;
  final int colorValue; // ARGB
  final String pigmentNameAr;

  const EbruPigmentDrop({
    required this.x,
    required this.y,
    required this.radius,
    required this.colorValue,
    required this.pigmentNameAr,
  });

  EbruPigmentDrop copyWith({double? x, double? y, double? radius}) {
    return EbruPigmentDrop(
      x: x ?? this.x,
      y: y ?? this.y,
      radius: radius ?? this.radius,
      colorValue: colorValue,
      pigmentNameAr: pigmentNameAr,
    );
  }
}

/// Mineral pigment preset model.
class MineralPigmentPreset {
  final String id;
  final String nameAr;
  final String nameDe;
  final String nameEn;
  final int colorValue;

  const MineralPigmentPreset({
    required this.id,
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.colorValue,
  });
}

/// Controller governing the interactive Ebru paper marbling fluid dynamics simulation.
class EbruStudioController extends ChangeNotifier {
  final List<EbruPigmentDrop> _drops = [];
  EbruToolType _activeTool = EbruToolType.dropper;
  int _activePigmentIndex = 0;
  double _oxGallConcentration = 1.2; // Multiplier expanding surface tension
  bool _isPaperPrinted = false;

  EbruStudioController({
    List<EbruPigmentDrop>? initialDrops,
  }) {
    if (initialDrops != null) _drops.addAll(initialDrops);
  }

  List<EbruPigmentDrop> get drops => List.unmodifiable(_drops);
  EbruToolType get activeTool => _activeTool;
  int get activePigmentIndex => _activePigmentIndex;
  double get oxGallConcentration => _oxGallConcentration;
  bool get isPaperPrinted => _isPaperPrinted;
  int get dropCount => _drops.length;

  MineralPigmentPreset get activePigment => pigments[_activePigmentIndex];

  static const List<MineralPigmentPreset> pigments = [
    MineralPigmentPreset(
      id: 'lapis_lazuli',
      nameAr: 'لاَزَوَرْدٌ فَلَكِيٌّ',
      nameDe: 'Lapislazuli-Blau',
      nameEn: 'Lapis Lazuli Ultramarine',
      colorValue: 0xFF1D4ED8,
    ),
    MineralPigmentPreset(
      id: 'cochineal_red',
      nameAr: 'قِرْمِزٌ أَنْدَلُسِيٌّ',
      nameDe: 'Karmesinrot',
      nameEn: 'Cochineal Carmine',
      colorValue: 0xFFDC2626,
    ),
    MineralPigmentPreset(
      id: 'malachite_green',
      nameAr: 'مَلاَكِيتٌ نُحَاسِيٌّ',
      nameDe: 'Malachitgrün',
      nameEn: 'Malachite Green',
      colorValue: 0xFF059669,
    ),
    MineralPigmentPreset(
      id: 'ochre_gold',
      nameAr: 'مَغْرَةٌ ذَهَبِيَّةٌ',
      nameDe: 'Goldocker',
      nameEn: 'Golden Ochre',
      colorValue: 0xFFD97706,
    ),
  ];

  /// Sets active tool.
  void setTool(EbruToolType tool) {
    if (_activeTool != tool) {
      _activeTool = tool;
      notifyListeners();
    }
  }

  /// Selects pigment from preset palette.
  void selectPigment(int index) {
    if (index >= 0 && index < pigments.length && _activePigmentIndex != index) {
      _activePigmentIndex = index;
      notifyListeners();
    }
  }

  /// Adjusts ox gall surfactant concentration.
  void setOxGallConcentration(double value) {
    _oxGallConcentration = value.clamp(0.5, 2.5);
    notifyListeners();
  }

  /// Adds a pigment drop at (x, y), computing expansion radius via surface tension.
  void addDrop(double x, double y) {
    if (_isPaperPrinted) return;

    final baseRadius = 18.0;
    final effectiveRadius = baseRadius * math.sqrt(_oxGallConcentration);

    final drop = EbruPigmentDrop(
      x: x,
      y: y,
      radius: effectiveRadius,
      colorValue: activePigment.colorValue,
      pigmentNameAr: activePigment.nameAr,
    );

    _drops.add(drop);
    notifyListeners();
  }

  /// Applies linear combing (Gel-Git: back-and-forth wave transformation).
  void applyCombPattern(EbruPatternStyle style) {
    if (_drops.isEmpty || _isPaperPrinted) return;

    for (var i = 0; i < _drops.length; i++) {
      final d = _drops[i];
      double newX = d.x;
      double newY = d.y;

      if (style == EbruPatternStyle.gelGit) {
        // Displace Y sinusoidally based on X coordinate
        final wave = math.sin(d.x * 0.05) * 22.0;
        newY = d.y + wave;
      } else if (style == EbruPatternStyle.tarama) {
        // Displace X horizontally based on Y index
        newX = d.x + (i % 2 == 0 ? 18.0 : -18.0);
      }

      _drops[i] = d.copyWith(x: newX, y: newY);
    }

    notifyListeners();
  }

  /// Simulates dipping paper and lifting the marbled transfer.
  void printPaper() {
    if (_drops.isEmpty) return;
    _isPaperPrinted = true;
    notifyListeners();
  }

  /// Clears tray and prepares new sizing bath.
  void resetTray() {
    _drops.clear();
    _isPaperPrinted = false;
    _activeTool = EbruToolType.dropper;
    notifyListeners();
  }
}
