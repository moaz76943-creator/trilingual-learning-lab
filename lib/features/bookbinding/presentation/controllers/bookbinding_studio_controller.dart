import 'package:flutter/foundation.dart';

/// Representation of a bookbinding stage in manuscript craft.
class BookbindingCraftStage {
  final int stageIndex;
  final String titleAr;
  final String titleDe;
  final String titleEn;
  final String descriptionAr;
  final String descriptionDe;
  final String descriptionEn;

  const BookbindingCraftStage({
    required this.stageIndex,
    required this.titleAr,
    required this.titleDe,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionDe,
    required this.descriptionEn,
  });
}

/// Controller governing the interactive Islamic manuscript bookbinding and flap mechanics studio.
class BookbindingStudioController extends ChangeNotifier {
  int _activeStageIndex = 0;
  double _flapFoldAngleDegrees = 0.0; // 0°: fully open, 180°: folded over and locked under front board
  bool _isBlindToolingActive = false;
  int _quireCount = 8; // Default 8 quires (كَرَارِيسُ)

  BookbindingStudioController({
    int initialStage = 0,
    double initialFoldAngle = 0.0,
    int quireCount = 8,
  })  : _activeStageIndex = initialStage,
        _flapFoldAngleDegrees = initialFoldAngle,
        _quireCount = quireCount;

  int get activeStageIndex => _activeStageIndex;
  double get flapFoldAngleDegrees => _flapFoldAngleDegrees;
  bool get isBlindToolingActive => _isBlindToolingActive;
  int get quireCount => _quireCount;

  bool get isFlapFullyLocked => _flapFoldAngleDegrees >= 170.0;
  BookbindingCraftStage get currentStage => craftStages[_activeStageIndex];

  static const List<BookbindingCraftStage> craftStages = [
    BookbindingCraftStage(
      stageIndex: 0,
      titleAr: 'خِيَاطَةُ الكَرَارِيسِ وَحَبْكَةُ الحَرِيرِ',
      titleDe: 'Lagenheftung und seidene Kapitalbänder',
      titleEn: 'Quire Sewing and Silk Endbands',
      descriptionAr: 'خِيَاطَةُ مَلاَزِمِ الوَرَقِ بِخُيُوطِ الحَرِيرِ الطَّبِيعِيِّ وَنَسْجُ الحَبْكَةِ عِنْدَ رَأْسِ الكَعْبِ وَذَيْلِهِ لِتَمَاسُكِ المَخْطُوطِ.',
      descriptionDe: 'Heften der Papierlagen mit Naturseidenfäden und Flechten des zweifarbigen Kapitalbandes an Kopf und Fuß.',
      descriptionEn: 'Sewing paper quires with natural silk thread and weaving two-color chevron endbands for structural durability.',
    ),
    BookbindingCraftStage(
      stageIndex: 1,
      titleAr: 'تَرْكِيبُ المِخْلاَفِ ذِي اللِّسَانِ الخُمَاسِيِّ',
      titleDe: 'Anpassen der fünfeckigen Klappe (Klappdeckel)',
      titleEn: 'Mounting the Pentagonal Envelope Flap',
      descriptionAr: 'تَرْكِيبُ لِسَانِ التَّجْلِيدِ الخُمَاسِيِّ المَفْصِلِيِّ لِيَحْمِيَ حَافَّةَ الأَوْرَاقِ مِنْ تَرَاكُمِ الغُبَارِ وَضَوْءِ الشَّمْسِ.',
      descriptionDe: 'Befestigen der fünfzackigen Schutzklappe, die den vorderen Buchschnitt vor Staub und Licht schützt.',
      descriptionEn: 'Fitting the flexible pentagonal envelope flap to protect the fore-edge from dust, moisture, and light.',
    ),
    BookbindingCraftStage(
      stageIndex: 2,
      titleAr: 'البَصْمُ الجَافُّ وَالتَّذْهِيبُ المَلَكِيُّ',
      titleDe: 'Blindprägung und Blattgold-Vergoldung',
      titleEn: 'Morocco Leather Blind-Tooling and Gilding',
      descriptionAr: 'نَقْشُ جِلْدِ المَرُوكِيِّ بِالقَوَالِبِ النُّحَاسِيَّةِ السَّاخِنَةِ، وَتَذْهِيبُ السُّرَّةِ المَرْكَزِيَّةِ وَالأَرْكَانِ بِذَهَبِ الحَلِّ.',
      descriptionDe: 'Prägen des Ziegenleders mit erhitzten Messingstempeln und Auslegen des zentralen Medaillons mit Muschelgold.',
      descriptionEn: 'Stamping the goatskin leather with heated brass irons and illuminating the central mandorla with shell gold.',
    ),
  ];

  /// Sets active craft stage (0 to 2).
  void selectStage(int index) {
    if (index >= 0 && index < craftStages.length && _activeStageIndex != index) {
      _activeStageIndex = index;
      notifyListeners();
    }
  }

  /// Sets envelope flap folding angle (0° to 180°).
  void setFlapFoldAngle(double angle) {
    final clamped = angle.clamp(0.0, 180.0);
    if (_flapFoldAngleDegrees != clamped) {
      _flapFoldAngleDegrees = clamped;
      notifyListeners();
    }
  }

  /// Toggles blind tooling stamp overlay on leather.
  void toggleBlindTooling() {
    _isBlindToolingActive = !_isBlindToolingActive;
    notifyListeners();
  }

  /// Sets manuscript quire count.
  void setQuireCount(int count) {
    final clamped = count.clamp(4, 20);
    if (_quireCount != clamped) {
      _quireCount = clamped;
      notifyListeners();
    }
  }

  /// Calculates spine thickness in millimeters based on quire count (approx 2.5mm per quire).
  double get spineThicknessMm => _quireCount * 2.5;

  /// Resets studio state.
  void reset() {
    _activeStageIndex = 0;
    _flapFoldAngleDegrees = 0.0;
    _isBlindToolingActive = false;
    _quireCount = 8;
    notifyListeners();
  }
}
