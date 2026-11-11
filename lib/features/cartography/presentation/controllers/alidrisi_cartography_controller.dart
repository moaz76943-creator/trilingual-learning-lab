import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// Historical Cartographic Center / City in the Medieval Islamic & Mediterranean World
enum HistoricalGeoCity {
  cordoba(
    nameAr: 'قُرْطُبَةُ (الأَنْدَلُس)',
    nameDe: 'Córdoba (Al-Andalus)',
    nameEn: 'Cordoba (Al-Andalus)',
    latitude: 37.8882,
    longitude: -4.7794,
    climateZone: 4,
  ),
  palermo(
    nameAr: 'بَلَرْمُ (صِقِلِّيَةُ - مَقَرُّ الإِدْرِيسِيِّ)',
    nameDe: 'Palermo (Sizilien - Al-Idrisi)',
    nameEn: 'Palermo (Sicily - Al-Idrisi\'s Court)',
    latitude: 38.1157,
    longitude: 13.3615,
    climateZone: 4,
  ),
  cairo(
    nameAr: 'القَاهِرَةُ وَالفُسْطَاطُ (مِصْرُ)',
    nameDe: 'Kairo (Ägypten)',
    nameEn: 'Cairo (Egypt)',
    latitude: 30.0444,
    longitude: 31.2357,
    climateZone: 3,
  ),
  damascus(
    nameAr: 'دِمَشْقُ الشَّامِ',
    nameDe: 'Damaskus (Syrien)',
    nameEn: 'Damascus (Syria)',
    latitude: 33.5138,
    longitude: 36.2765,
    climateZone: 4,
  ),
  baghdad(
    nameAr: 'بَغْدَادُ (دَارُ السَّلامِ - بَيْتُ الحِكْمَةِ)',
    nameDe: 'Bagdad (Haus der Weisheit)',
    nameEn: 'Baghdad (House of Wisdom)',
    latitude: 33.3152,
    longitude: 44.3661,
    climateZone: 4,
  ),
  samarkand(
    nameAr: 'سَمَرْقَنْدُ (بِلادُ مَا وَرَاءَ النَّهْرِ)',
    nameDe: 'Samarkand (Transoxanien)',
    nameEn: 'Samarkand (Transoxiana)',
    latitude: 39.6542,
    longitude: 66.9597,
    climateZone: 5,
  ),
  mecca(
    nameAr: 'مَكَّةُ المُكَرَّمَةُ (القِبْلَةُ)',
    nameDe: 'Mekka (Qibla)',
    nameEn: 'Mecca (The Holy City)',
    latitude: 21.3891,
    longitude: 39.8579,
    climateZone: 2,
  ),
  toledo(
    nameAr: 'طُلَيْطِلَةُ (مَدْرَسَةُ التَّرْجَمَةِ)',
    nameDe: 'Toledo (Übersetzerschule)',
    nameEn: 'Toledo (Translation Center)',
    latitude: 39.8628,
    longitude: -4.0273,
    climateZone: 4,
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;
  final double latitude; // in degrees (-90 to +90)
  final double longitude; // in degrees (-180 to +180)
  final int climateZone; // 1 to 7 in Al-Idrisi's system

  const HistoricalGeoCity({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.latitude,
    required this.longitude,
    required this.climateZone,
  });
}

/// Al-Idrisi's Seven Climates (الأَقَالِيمُ السَّبْعَةُ)
class AlIdrisiClimateZone {
  final int zoneNumber;
  final String nameAr;
  final String nameDe;
  final String nameEn;
  final double southLat;
  final double northLat;

  const AlIdrisiClimateZone({
    required this.zoneNumber,
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.southLat,
    required this.northLat,
  });

  static const List<AlIdrisiClimateZone> allZones = [
    AlIdrisiClimateZone(
      zoneNumber: 1,
      nameAr: 'الإِقْلِيمُ الأَوَّلُ (خَطُّ الاسْتِوَاءِ وَبِلادُ السُّودَانِ)',
      nameDe: 'Klima 1: Äquatorial & Südsudan',
      nameEn: 'Climate 1: Equatorial Zone',
      southLat: 0.0,
      northLat: 16.5,
    ),
    AlIdrisiClimateZone(
      zoneNumber: 2,
      nameAr: 'الإِقْلِيمُ الثَّانِي (الحِجَازُ وَاليَمَنُ وَجَنُوبُ مِصْرَ)',
      nameDe: 'Klima 2: Hedschas, Jemen, Oberägypten',
      nameEn: 'Climate 2: Hejaz, Yemen & Nubia',
      southLat: 16.5,
      northLat: 27.5,
    ),
    AlIdrisiClimateZone(
      zoneNumber: 3,
      nameAr: 'الإِقْلِيمُ الثَّالِثُ (مِصْرُ وَبِلادُ فَارِسَ وَالمَغْرِبُ الأَقْصَى)',
      nameDe: 'Klima 3: Ägypten, Persien, Maghreb',
      nameEn: 'Climate 3: Lower Egypt, Persia, Maghreb',
      southLat: 27.5,
      northLat: 34.0,
    ),
    AlIdrisiClimateZone(
      zoneNumber: 4,
      nameAr: 'الإِقْلِيمُ الرَّابِعُ (الأَنْدَلُسُ وَالشَّامُ وَبَغْدَادُ - مُعْتَدِلٌ)',
      nameDe: 'Klima 4: Al-Andalus, Levante, Bagdad (Gemäßigt)',
      nameEn: 'Climate 4: Al-Andalus, Levant, Baghdad (Temperate Core)',
      southLat: 34.0,
      northLat: 39.0,
    ),
    AlIdrisiClimateZone(
      zoneNumber: 5,
      nameAr: 'الإِقْلِيمُ الخَامِسُ (رُومِيَةُ وَالقُسْطَنْطِينِيَّةُ وَخُرَاسَانُ)',
      nameDe: 'Klima 5: Rom, Konstantinopel, Chorasan',
      nameEn: 'Climate 5: Rome, Constantinople, Khorasan',
      southLat: 39.0,
      northLat: 45.0,
    ),
    AlIdrisiClimateZone(
      zoneNumber: 6,
      nameAr: 'الإِقْلِيمُ السَّادِسُ (شَمَالُ أُورُوبَّا وَبِلادُ الصَّقَالِبَةِ)',
      nameDe: 'Klima 6: Mitteleuropa & Slawenlande',
      nameEn: 'Climate 6: Central Europe & Slavic Lands',
      southLat: 45.0,
      northLat: 50.5,
    ),
    AlIdrisiClimateZone(
      zoneNumber: 7,
      nameAr: 'الإِقْلِيمُ السَّابِعُ (أَقْصَى الشَّمَالِ المَسْكُونِ)',
      nameDe: 'Klima 7: Hoher Norden & Polargrenze',
      nameEn: 'Climate 7: Far Northern Inhabited Boundary',
      southLat: 50.5,
      northLat: 64.0,
    ),
  ];
}

/// State representation for Al-Idrisi Cartography & Navigation
class AlIdrisiCartographyState {
  final HistoricalGeoCity originCity;
  final HistoricalGeoCity destinationCity;
  final bool isSouthOrientedUp; // Classical Islamic maps were South-Up (الجنوب في الأعلى)
  final bool showClimaticZones;
  final bool showGreatCirclePath;
  final int selectedClimateFilter; // 0 for all, 1-7 for specific zone

  const AlIdrisiCartographyState({
    required this.originCity,
    required this.destinationCity,
    required this.isSouthOrientedUp,
    required this.showClimaticZones,
    required this.showGreatCirclePath,
    required this.selectedClimateFilter,
  });

  factory AlIdrisiCartographyState.initial() {
    return const AlIdrisiCartographyState(
      originCity: HistoricalGeoCity.palermo, // Al-Idrisi's court
      destinationCity: HistoricalGeoCity.baghdad, // Center of learning
      isSouthOrientedUp: true, // Classical Islamic orientation
      showClimaticZones: true,
      showGreatCirclePath: true,
      selectedClimateFilter: 0,
    );
  }

  /// Earth Mean Radius in Kilometers (Al-Biruni / WGS-84 mean)
  static const double earthRadiusKm = 6371.0;

  /// Great-Circle Distance using the Haversine formula (المَسَافَةُ الكُرَوِيَّةُ)
  double get greatCircleDistanceKm {
    final lat1Rad = originCity.latitude * (math.pi / 180.0);
    final lon1Rad = originCity.longitude * (math.pi / 180.0);
    final lat2Rad = destinationCity.latitude * (math.pi / 180.0);
    final lon2Rad = destinationCity.longitude * (math.pi / 180.0);

    final dLat = lat2Rad - lat1Rad;
    final dLon = lon2Rad - lon1Rad;

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1Rad) * math.cos(lat2Rad) * math.sin(dLon / 2) * math.sin(dLon / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusKm * c;
  }

  /// Initial Forward Bearing (Azimuth / الاِتِّجَاهُ الفَلَكِيُّ) in degrees (0° to 360°)
  double get initialBearingDeg {
    final lat1 = originCity.latitude * (math.pi / 180.0);
    final lon1 = originCity.longitude * (math.pi / 180.0);
    final lat2 = destinationCity.latitude * (math.pi / 180.0);
    final lon2 = destinationCity.longitude * (math.pi / 180.0);

    final dLon = lon2 - lon1;

    final y = math.sin(dLon) * math.cos(lat2);
    final x = math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(dLon);

    final initialRad = math.atan2(y, x);
    final initialDeg = initialRad * (180.0 / math.pi);
    return (initialDeg + 360.0) % 360.0;
  }

  /// Distance in Classical Arab Miles (المِيلُ العَرَبِيُّ ~ 1.9735 km)
  double get distanceInArabMiles => greatCircleDistanceKm / 1.9735;

  /// Travel time estimate in medieval caravan stages (مَرْحَلَةٌ ~ 40 km / day)
  double get caravanStagesCount => greatCircleDistanceKm / 40.0;

  AlIdrisiCartographyState copyWith({
    HistoricalGeoCity? originCity,
    HistoricalGeoCity? destinationCity,
    bool? isSouthOrientedUp,
    bool? showClimaticZones,
    bool? showGreatCirclePath,
    int? selectedClimateFilter,
  }) {
    return AlIdrisiCartographyState(
      originCity: originCity ?? this.originCity,
      destinationCity: destinationCity ?? this.destinationCity,
      isSouthOrientedUp: isSouthOrientedUp ?? this.isSouthOrientedUp,
      showClimaticZones: showClimaticZones ?? this.showClimaticZones,
      showGreatCirclePath: showGreatCirclePath ?? this.showGreatCirclePath,
      selectedClimateFilter: selectedClimateFilter ?? this.selectedClimateFilter,
    );
  }
}

/// Controller managing Al-Idrisi Cartography and Navigation Studio
class AlIdrisiCartographyController extends ChangeNotifier {
  AlIdrisiCartographyState _state = AlIdrisiCartographyState.initial();

  AlIdrisiCartographyState get state => _state;

  void setOriginCity(HistoricalGeoCity city) {
    _state = _state.copyWith(originCity: city);
    notifyListeners();
  }

  void setDestinationCity(HistoricalGeoCity city) {
    _state = _state.copyWith(destinationCity: city);
    notifyListeners();
  }

  void toggleOrientation() {
    _state = _state.copyWith(isSouthOrientedUp: !_state.isSouthOrientedUp);
    notifyListeners();
  }

  void toggleClimaticZones() {
    _state = _state.copyWith(showClimaticZones: !_state.showClimaticZones);
    notifyListeners();
  }

  void toggleGreatCirclePath() {
    _state = _state.copyWith(showGreatCirclePath: !_state.showGreatCirclePath);
    notifyListeners();
  }

  void selectClimateFilter(int zoneNumber) {
    _state = _state.copyWith(selectedClimateFilter: zoneNumber);
    notifyListeners();
  }

  void swapCities() {
    final temp = _state.originCity;
    _state = _state.copyWith(
      originCity: _state.destinationCity,
      destinationCity: temp,
    );
    notifyListeners();
  }

  void reset() {
    _state = AlIdrisiCartographyState.initial();
    notifyListeners();
  }
}
