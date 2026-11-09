import 'package:flutter/foundation.dart';
import '../../../../core/linguistics/arabic_diacritics_service.dart';

/// Structured historic cognate connection across Arabic, German, and English.
class CognateConnection {
  final String id;
  final String arabicRoot;
  final String arabicTerm;
  final String germanTerm;
  final String englishTerm;
  final String historicalEra;
  final String transmissionNote;

  const CognateConnection({
    required this.id,
    required this.arabicRoot,
    required this.arabicTerm,
    required this.germanTerm,
    required this.englishTerm,
    required this.historicalEra,
    required this.transmissionNote,
  });
}

/// Service managing cross-linguistic scientific cognates and mnemonic etymologies.
class EtymologicalCognateTracker {
  static final List<CognateConnection> _cognateCatalog = [
    const CognateConnection(
      id: 'cognate_alidade',
      arabicRoot: 'ع - ض - د',
      arabicTerm: 'العِضَادَةُ',
      germanTerm: 'Die Alhidade',
      englishTerm: 'The Alidade',
      historicalEra: '10th Century Islamic Astronomy (Al-Battani & Al-Sufi)',
      transmissionNote: 'Derived from Arabic al-ʿiḍādah (the revolving sighting rule of an astrolabe).',
    ),
    const CognateConnection(
      id: 'cognate_azimuth',
      arabicRoot: 'س - م - ت',
      arabicTerm: 'السَّمْتُ / السُّمُوتُ',
      germanTerm: 'Das Azimut',
      englishTerm: 'The Azimuth',
      historicalEra: '12th Century Toledan Translations',
      transmissionNote: 'From Arabic as-sumūt (plural of samt: direction, path), entering Latin as azimuth.',
    ),
    const CognateConnection(
      id: 'cognate_zenith',
      arabicRoot: 'س - م - ت',
      arabicTerm: 'سَمْتُ الرَّأْسِ',
      germanTerm: 'Der Zenit',
      englishTerm: 'The Zenith',
      historicalEra: 'Medieval Latin Translation Transmission',
      transmissionNote: 'Scribal transmission of samt ar-ra’s (overhead direction), misread in Gothic Latin as cenit.',
    ),
    const CognateConnection(
      id: 'cognate_nadir',
      arabicRoot: 'ن - ظ - ر',
      arabicTerm: 'النَّظِيرُ',
      germanTerm: 'Der Nadir',
      englishTerm: 'The Nadir',
      historicalEra: 'Classical Astronomical Optics',
      transmissionNote: 'From Arabic naẓīr as-samt (the point opposite the zenith directly below).',
    ),
    const CognateConnection(
      id: 'cognate_astrolabe',
      arabicRoot: 'أ - س - ط - ر - ل - ب',
      arabicTerm: 'الأَسْطُرْلاَبُ',
      germanTerm: 'Das Astrolabium',
      englishTerm: 'The Astrolabe',
      historicalEra: 'Greco-Arabic Scientific Renaissance',
      transmissionNote: 'From Arabic al-asṭurlāb, deeply refined in Islamic Baghdad and Andalusia before transmission to Europe.',
    ),
  ];

  /// Returns all registered cognate records.
  static List<CognateConnection> get allCognates => List.unmodifiable(_cognateCatalog);

  /// Finds cognate connections matching [queryTerm] in any of the three languages.
  static List<CognateConnection> findCognates(String queryTerm) {
    if (queryTerm.trim().isEmpty) return const [];

    final normQuery = ArabicDiacriticsService.normalizeForSearch(queryTerm);

    return _cognateCatalog.where((c) {
      final normAr = ArabicDiacriticsService.normalizeForSearch(c.arabicTerm);
      final normDe = ArabicDiacriticsService.normalizeForSearch(c.germanTerm);
      final normEn = ArabicDiacriticsService.normalizeForSearch(c.englishTerm);
      final normRoot = ArabicDiacriticsService.normalizeForSearch(c.arabicRoot);

      return normAr.contains(normQuery) ||
             normDe.contains(normQuery) ||
             normEn.contains(normQuery) ||
             normRoot.contains(normQuery);
    }).toList();
  }
}
