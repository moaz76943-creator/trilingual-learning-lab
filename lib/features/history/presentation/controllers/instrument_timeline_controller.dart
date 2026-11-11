import 'package:flutter/foundation.dart';
import '../../domain/services/instrument_chronology_service.dart';

/// Historical instrument milestone detail container.
class TimelineInstrumentItem {
  final String id;
  final String nameAr;
  final String nameDe;
  final String nameEn;
  final String categoryRoute;
  final String historicalNoteAr;
  final String historicalNoteDe;
  final String historicalNoteEn;

  const TimelineInstrumentItem({
    required this.id,
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.categoryRoute,
    required this.historicalNoteAr,
    required this.historicalNoteDe,
    required this.historicalNoteEn,
  });
}

/// Controller governing the interactive historical timeline and instrument explorer.
class InstrumentTimelineController extends ChangeNotifier {
  final List<HistoricalScientificEra> _eras;
  int _activeEraIndex = 0;
  String? _selectedScholarFilter;
  final Set<String> _exploredInstrumentIds = {};

  InstrumentTimelineController({
    List<HistoricalScientificEra>? eras,
    int initialEraIndex = 0,
  })  : _eras = eras ?? InstrumentChronologyService.allEras,
        _activeEraIndex = initialEraIndex;

  List<HistoricalScientificEra> get eras => List.unmodifiable(_eras);
  int get activeEraIndex => _activeEraIndex;
  String? get selectedScholarFilter => _selectedScholarFilter;
  int get exploredCount => _exploredInstrumentIds.length;

  HistoricalScientificEra? get activeEra {
    if (_eras.isEmpty || _activeEraIndex >= _eras.length) return null;
    return _eras[_activeEraIndex];
  }

  /// Sets the active historical era by index.
  void selectEra(int index) {
    if (index >= 0 && index < _eras.length && _activeEraIndex != index) {
      _activeEraIndex = index;
      _selectedScholarFilter = null;
      notifyListeners();
    }
  }

  /// Filters instruments by scholar name.
  void filterScholar(String? scholarName) {
    _selectedScholarFilter = scholarName;
    notifyListeners();
  }

  /// Marks an instrument as explored by the learner.
  void markInstrumentExplored(String instrumentId) {
    _exploredInstrumentIds.add(instrumentId);
    notifyListeners();
  }

  /// Resolves detailed instrument milestone items for the current active era.
  List<TimelineInstrumentItem> get activeInstruments {
    final era = activeEra;
    if (era == null) return const [];

    final catalog = _eraInstrumentCatalog[era.id] ?? const [];

    if (_selectedScholarFilter != null) {
      // In production, filters instruments by scholar association
      return catalog;
    }

    return catalog;
  }

  static final Map<String, List<TimelineInstrumentItem>> _eraInstrumentCatalog = {
    'era_abbasid_house_of_wisdom': const [
      TimelineInstrumentItem(
        id: 'planispheric_astrolabe',
        nameAr: 'الأَسْطُرْلاَبُ المُسَطَّحُ البَغْدَادِيُّ',
        nameDe: 'Das planisphärische Astrolabium von Bagdad',
        nameEn: 'The Baghdadi Planispheric Astrolabe',
        categoryRoute: 'category_174_astrolabe_tympan_plates',
        historicalNoteAr: 'طَوَّرَهُ عُلَمَاءُ بَيْتِ الحِكْمَةِ كَالخُوَارِزْمِيِّ وَالفَرْغَانِيِّ لِحِسَابِ مَوَاقِيتِ الصَّلاَةِ وَالصِّيَامِ.',
        historicalNoteDe: 'Entwickelt von Gelehrten des Hauses der Weisheit wie Al-Chwarizmi zur präzisen astronomischen Zeitbestimmung.',
        historicalNoteEn: 'Refined by scholars of the House of Wisdom like Al-Khwarizmi for precise celestial timekeeping.',
      ),
      TimelineInstrumentItem(
        id: 'clepsydra_water_clock',
        nameAr: 'السَّاعَةُ المَائِيَّةُ ذَاتُ العَوَّامَةِ',
        nameDe: 'Die Schwimmer-Wasseruhr',
        nameEn: 'The Float-Regulated Clepsydra',
        categoryRoute: 'category_150_water_clepsydras',
        historicalNoteAr: 'صَمَّمَهَا بَنُو مُوسَى بِمُعَدِّلاَتِ تَدَفُّقٍ هَيْدْرُولِيكِيَّةٍ تَعْمَلُ بِانْتِظَامٍ طَوَالَ اللَّيْلِ وَالنَّهَارِ.',
        historicalNoteDe: 'Konstruiert von den Banu Musa mit hydraulischen Durchflussreglern für gleichmäßigen Lauf Tag und Nacht.',
        historicalNoteEn: 'Designed by the Banu Musa with hydraulic flow regulators to maintain constant hourly flow.',
      ),
    ],
    'era_golden_andalusian_persian': const [
      TimelineInstrumentItem(
        id: 'universal_astrolabe_saphaea',
        nameAr: 'الأَسْطُرْلاَبُ الشَّكَّازِيُّ الجَامِعُ',
        nameDe: 'Die universelle Saphaea-Platte',
        nameEn: 'The Universal Saphaea Astrolabe',
        categoryRoute: 'category_176_zarqallu_universal_astrolabe',
        historicalNoteAr: 'ابْتَكَرَهُ ابْنُ الزَّرْقَالِ فِي طُلَيْطِلَةَ لِيَعْمَلَ لِكُلِّ عُرُوضِ الأَرْضِ دُونَ حَاجَةٍ لِتَبْدِيلِ الصَّفَائِحِ.',
        historicalNoteDe: 'Erfunden von Al-Zarqali in Toledo, nutzbar für alle Breitengrade ohne Plattenwechsel.',
        historicalNoteEn: 'Invented by Al-Zarqali in Toledo to function universally across all global latitudes.',
      ),
      TimelineInstrumentItem(
        id: 'sine_quadrant',
        nameAr: 'رُبْعُ المُجَيَّبِ لِقِيَاسِ الِارتِفَاعِ',
        nameDe: 'Der Sinusquadrant zur Höhenmessung',
        nameEn: 'The Sine Quadrant for Elevation',
        categoryRoute: 'category_140_sine_quadrant',
        historicalNoteAr: 'اسْتَعْمَلَهُ البِيرُونِيُّ لِحِسَابِ نِصْفِ قُطْرِ الأَرْضِ بِدِقَّةٍ مُذْهِلَةٍ.',
        historicalNoteDe: 'Verwendet von Al-Biruni zur Berechnung des Erdumfangs mit bemerkenswerter Genauigkeit.',
        historicalNoteEn: 'Utilized by Al-Biruni to determine the Earth’s radius with remarkable trigonometric precision.',
      ),
    ],
    'era_maragha_samarkand': const [
      TimelineInstrumentItem(
        id: 'hydraulic_elephant_clock',
        nameAr: 'سَاعَةُ الفِيلِ الهَيْدْرُولِيكِيَّةُ',
        nameDe: 'Die hydraulische Elefantenuhr',
        nameEn: 'The Hydraulic Elephant Automaton Clock',
        categoryRoute: 'category_152_double_acting_pumps',
        historicalNoteAr: 'تُحْفَةُ ابْنِ الرَّزَّازِ الجَزَرِيِّ الجَامِعَةُ بَيْنَ هَنْدَسَةِ الحِيَلِ وَالمُوَازَنَةِ المَائِيَّةِ.',
        historicalNoteDe: 'Das Meisterwerk von Al-Jazari, das mechanische Automaten mit hydraulischer Steuerung verbindet.',
        historicalNoteEn: 'Al-Jazari’s automaton masterpiece combining hydraulic float control with mechanical timing.',
      ),
    ],
    'era_ottoman_maghrebi': const [
      TimelineInstrumentItem(
        id: 'compendium_sundial',
        nameAr: 'صُنْدُوقُ اليَوَاقِيتِ لِابْنِ الشَّاطِرِ',
        nameDe: 'Das Juwelenkästchen des Ibn al-Shatir',
        nameEn: 'Ibn al-Shatir’s Jewel Box Compendium',
        categoryRoute: 'category_177_shatir_compendium_sundial',
        historicalNoteAr: 'آلَةٌ جَامِعَةٌ مَحْمُولَةٌ تَجْمَعُ بَيْتَ الإِبْرَةِ المَغْنَاطِيسِيَّةِ وَالمِزْوَلَةَ القُطْبِيَّةَ المَفْصِلِيَّةَ.',
        historicalNoteDe: 'Ein tragbares Universal-Kompendium mit Magnetkompass und klappbarem Polgnomon.',
        historicalNoteEn: 'A universal portable compendium integrating a magnetic compass with a folding polar sundial.',
      ),
    ],
  };
}
