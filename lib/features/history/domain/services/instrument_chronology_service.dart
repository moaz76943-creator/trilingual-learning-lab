import 'package:flutter/foundation.dart';

/// Representation of a major historical era in Islamic and comparative science.
class HistoricalScientificEra {
  final String id;
  final String nameAr;
  final String nameDe;
  final String nameEn;
  final String century;
  final List<String> primaryScholars;
  final List<String> primaryInstruments;

  const HistoricalScientificEra({
    required this.id,
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.century,
    required this.primaryScholars,
    required this.primaryInstruments,
  });
}

/// Service governing historical chronologies, scholars, and scientific milestone sequences.
class InstrumentChronologyService {
  static final List<HistoricalScientificEra> _eras = [
    const HistoricalScientificEra(
      id: 'era_abbasid_house_of_wisdom',
      nameAr: 'عَصْرُ بَيْتِ الحِكْمَةِ العَبَّاسِيِّ',
      nameDe: 'Die Epoche des Hauses der Weisheit in Bagdad',
      nameEn: 'The Abbasid House of Wisdom Era',
      century: '8th - 10th Century CE',
      primaryScholars: ['Al-Khwarizmi', 'Al-Farghani', 'Banu Musa'],
      primaryInstruments: [
        'planispheric_astrolabe',
        'pneumatic_flute',
        'clepsydra_water_clock',
      ],
    ),
    const HistoricalScientificEra(
      id: 'era_golden_andalusian_persian',
      nameAr: 'العَصْرُ الذَّهَبِيُّ الأَنْدَلُسِيُّ وَالمَشْرِقِيُّ',
      nameDe: 'Die andalusische und persische Blütezeit',
      nameEn: 'The Andalusian and Eastern Islamic Golden Age',
      century: '10th - 12th Century CE',
      primaryScholars: ['Al-Biruni', 'Al-Zarqali', 'Ibn al-Haytham'],
      primaryInstruments: [
        'universal_astrolabe_saphaea',
        'camera_obscura',
        'sine_quadrant',
      ],
    ),
    const HistoricalScientificEra(
      id: 'era_maragha_samarkand',
      nameAr: 'عَصْرُ مَرَاصِدِ مَرَاغَةَ وَسَمَرْقَنْدَ',
      nameDe: 'Die Epoche der Observatorien von Maragha und Samarkand',
      nameEn: 'The Observatories of Maragha and Samarkand',
      century: '13th - 15th Century CE',
      primaryScholars: ['Nasir al-Din al-Tusi', 'Al-Jazari', 'Ulugh Beg'],
      primaryInstruments: [
        'hydraulic_elephant_clock',
        'giant_mural_sextant',
        'torquetum',
      ],
    ),
    const HistoricalScientificEra(
      id: 'era_ottoman_maghrebi',
      nameAr: 'عَصْرُ المَرَاكِزِ العُثْمَانِيَّةِ وَالمَغْرِبِيَّةِ',
      nameDe: 'Die osmanische und maghrebinische Blüte',
      nameEn: 'The Ottoman and Maghrebi Renaissance',
      century: '15th - 17th Century CE',
      primaryScholars: ['Taqi al-Din', 'Ibn al-Shatir'],
      primaryInstruments: [
        'mechanical_escapement_clock',
        'compendium_sundial',
        'proportional_armillary_sphere',
      ],
    ),
  ];

  static List<HistoricalScientificEra> get allEras => List.unmodifiable(_eras);

  static HistoricalScientificEra? getEraById(String eraId) {
    for (final era in _eras) {
      if (era.id == eraId) return era;
    }
    return null;
  }

  static List<HistoricalScientificEra> findErasForScholar(String scholar) {
    final clean = scholar.toLowerCase();
    return _eras.where((era) {
      return era.primaryScholars.any((s) => s.toLowerCase().contains(clean));
    }).toList();
  }

  static bool isInstrumentInEra(String instrumentId, String eraId) {
    final era = getEraById(eraId);
    if (era == null) return false;
    return era.primaryInstruments.contains(instrumentId);
  }
}
