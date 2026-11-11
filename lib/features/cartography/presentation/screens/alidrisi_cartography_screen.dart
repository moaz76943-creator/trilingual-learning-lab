import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../controllers/alidrisi_cartography_controller.dart';

/// Screen presenting Al-Idrisi's Cartography & Great-Circle Navigation
class AlIdrisiCartographyScreen extends StatefulWidget {
  final AlIdrisiCartographyController? controller;

  const AlIdrisiCartographyScreen({super.key, this.controller});

  @override
  State<AlIdrisiCartographyScreen> createState() =>
      _AlIdrisiCartographyScreenState();
}

class _AlIdrisiCartographyScreenState extends State<AlIdrisiCartographyScreen> {
  late final AlIdrisiCartographyController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? AlIdrisiCartographyController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'خَرِيطَةُ الشَّرِيفِ الإِدْرِيسِيِّ (1154م)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Al-Idrisi Tabula Rogeriana & Geodesic Navigation',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_controller.state.isSouthOrientedUp
                ? Icons.south
                : Icons.north),
            tooltip: _controller.state.isSouthOrientedUp
                ? 'التَّوْجِيهُ التَّقْلِيدِيُّ (الجَنُوبُ فِي الأَعْلَى)'
                : 'التَّوْجِيهُ الحَدِيثُ (الشَّمَالُ فِي الأَعْلَى)',
            onPressed: _controller.toggleOrientation,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'إِعَادَةُ الضَّبْطِ',
            onPressed: _controller.reset,
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final state = _controller.state;
          final distKm = state.greatCircleDistanceKm;
          final distMiles = state.distanceInArabMiles;
          final bearing = state.initialBearingDeg;
          final stages = state.caravanStagesCount;

          return Column(
            children: [
              // Canvas of Al-Idrisi's Map
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1917), // Antique parchment background
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amber.shade700, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CustomPaint(
                      painter: TabulaRogerianaMapPainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Navigational Readout Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: const Color(0xFF292524),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.amber.withOpacity(0.4)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMetric(
                          labelAr: 'المَسَافَةُ الكُرَوِيَّةُ',
                          labelEn: 'Distance (km)',
                          value: '${distKm.toStringAsFixed(0)} km',
                          color: Colors.cyanAccent,
                        ),
                        _buildMetric(
                          labelAr: 'الأَمْيَالُ العَرَبِيَّةُ',
                          labelEn: 'Arab Miles',
                          value: '${distMiles.toStringAsFixed(0)} مِيل',
                          color: Colors.amberAccent,
                        ),
                        _buildMetric(
                          labelAr: 'سَمْتُ القِبْلَةِ / الاِتِّجَاه',
                          labelEn: 'Bearing (Azimuth)',
                          value: '${bearing.toStringAsFixed(1)}°',
                          color: Colors.lightGreenAccent,
                        ),
                        _buildMetric(
                          labelAr: 'المَرَاحِلُ وَالقَوَافِلُ',
                          labelEn: 'Caravan Stages',
                          value: '${stages.toStringAsFixed(0)} يَوْم',
                          color: Colors.orangeAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Controls & City Selection
              Expanded(
                flex: 4,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  children: [
                    // City Selectors
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<HistoricalGeoCity>(
                            decoration: const InputDecoration(
                              labelText: 'نُقْطَةُ الاِنْطِلاقِ (Startpunkt)',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            ),
                            value: state.originCity,
                            items: HistoricalGeoCity.values.map((city) {
                              return DropdownMenuItem(
                                value: city,
                                child: Text(city.nameAr, style: const TextStyle(fontSize: 11)),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) _controller.setOriginCity(val);
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.swap_horiz),
                          tooltip: 'تَبْدِيلُ المَدِينَتَيْنِ',
                          onPressed: _controller.swapCities,
                        ),
                        Expanded(
                          child: DropdownButtonFormField<HistoricalGeoCity>(
                            decoration: const InputDecoration(
                              labelText: 'نُقْطَةُ الوُصُولِ (Zielort)',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            ),
                            value: state.destinationCity,
                            items: HistoricalGeoCity.values.map((city) {
                              return DropdownMenuItem(
                                value: city,
                                child: Text(city.nameAr, style: const TextStyle(fontSize: 11)),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) _controller.setDestinationCity(val);
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Toggles
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FilterChip(
                          label: const Text('الأَقَالِيمُ السَّبْعَةُ (7 Klimate)'),
                          selected: state.showClimaticZones,
                          onSelected: (_) => _controller.toggleClimaticZones(),
                        ),
                        FilterChip(
                          label: const Text('المَسَارُ الجِيُودِيسِيُّ (Geodäte)'),
                          selected: state.showGreatCirclePath,
                          onSelected: (_) => _controller.toggleGreatCirclePath(),
                        ),
                        FilterChip(
                          label: Text(state.isSouthOrientedUp ? 'الجَنُوبُ فِي الأَعْلَى' : 'الشَّمَالُ فِي الأَعْلَى'),
                          selected: state.isSouthOrientedUp,
                          onSelected: (_) => _controller.toggleOrientation(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Climatic Zone Information Box
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF44403C).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber.shade600, width: 1.0),
                      ),
                      child: Text(
                        'إِقْلِيمُ ${state.originCity.nameAr}: ${AlIdrisiClimateZone.allZones[state.originCity.climateZone - 1].nameAr}',
                        style: const TextStyle(fontSize: 11, color: Colors.amberAccent),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMetric({
    required String labelAr,
    required String labelEn,
    required String value,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(labelAr, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        Text(labelEn, style: TextStyle(fontSize: 9, color: Colors.grey.shade400)),
        const SizedBox(height: 3),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: color)),
      ],
    );
  }
}

/// Custom painter rendering Al-Idrisi's Mediterranean / Middle-East world projection
class TabulaRogerianaMapPainter extends CustomPainter {
  final AlIdrisiCartographyState state;

  TabulaRogerianaMapPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    // Mediterranean and Indian Ocean Cartographic Window:
    // Longitude from -10° (Atlantic) to +75° (Central Asia)
    // Latitude from 10° (Yemen/Nubia) to 55° (Central Europe)
    const minLon = -12.0;
    const maxLon = 72.0;
    const minLat = 10.0;
    const maxLat = 55.0;

    Offset project(double lat, double lon) {
      final normX = (lon - minLon) / (maxLon - minLon);
      double normY = (lat - minLat) / (maxLat - minLat);

      if (state.isSouthOrientedUp) {
        // In South-Up maps, lower latitude (South) is at the top of the canvas
        normY = normY; // lat 10 -> top, lat 55 -> bottom
      } else {
        // Modern North-Up
        normY = 1.0 - normY;
      }

      return Offset(
        16 + normX * (width - 32),
        16 + normY * (height - 32),
      );
    }

    // Draw Sea background (Al-Bahr al-Muheet & Mediterranean)
    final seaPaint = Paint()..color = const Color(0xFF0C4A6E).withOpacity(0.4);
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), seaPaint);

    // Draw Climatic Zone Bands (الأَقَالِيمُ السَّبْعَةُ)
    if (state.showClimaticZones) {
      final zonePaint = Paint()
        ..color = Colors.amber.withOpacity(0.12)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      for (final zone in AlIdrisiClimateZone.allZones) {
        if (zone.southLat >= minLat && zone.southLat <= maxLat) {
          final p1 = project(zone.southLat, minLon);
          final p2 = project(zone.southLat, maxLon);
          canvas.drawLine(p1, p2, zonePaint);

          _drawText(
            canvas,
            'الإِقْلِيمُ ${zone.zoneNumber}',
            Offset(width - 70, p1.dy - 12),
            Colors.amber.shade200,
            9.0,
          );
        }
      }
    }

    // Draw Great Circle Navigational Geodesic line between cities
    if (state.showGreatCirclePath) {
      final pOrigin = project(state.originCity.latitude, state.originCity.longitude);
      final pDest = project(state.destinationCity.latitude, state.destinationCity.longitude);

      // Interpolate 20 points along great circle for curve
      final path = Path();
      path.moveTo(pOrigin.dx, pOrigin.dy);

      for (int i = 1; i <= 20; i++) {
        final f = i / 20.0;
        final interLat = state.originCity.latitude + (state.destinationCity.latitude - state.originCity.latitude) * f;
        final interLon = state.originCity.longitude + (state.destinationCity.longitude - state.originCity.longitude) * f;
        final pt = project(interLat, interLon);
        path.lineTo(pt.dx, pt.dy);
      }

      final pathPaint = Paint()
        ..color = Colors.cyanAccent
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, pathPaint);
    }

    // Draw Cities / Ports
    for (final city in HistoricalGeoCity.values) {
      final pt = project(city.latitude, city.longitude);
      final isOrigin = city == state.originCity;
      final isDest = city == state.destinationCity;

      Color nodeColor;
      double radius;

      if (isOrigin) {
        nodeColor = Colors.greenAccent;
        radius = 7.0;
      } else if (isDest) {
        nodeColor = Colors.orangeAccent;
        radius = 7.0;
      } else {
        nodeColor = Colors.amber.shade300;
        radius = 4.0;
      }

      final pinPaint = Paint()..color = nodeColor..style = PaintingStyle.fill;
      canvas.drawCircle(pt, radius, pinPaint);

      final borderPaint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawCircle(pt, radius, borderPaint);

      // City Name Label
      _drawText(
        canvas,
        city.nameAr,
        Offset(pt.dx - 20, pt.dy + 8),
        isOrigin || isDest ? Colors.white : Colors.amber.shade100,
        10.0,
      );
    }

    // Directional Compass Rose / Orientation Indicator
    final compassX = width * 0.12;
    final compassY = height * 0.20;
    _drawCompassRose(canvas, Offset(compassX, compassY), state.isSouthOrientedUp);
  }

  void _drawCompassRose(Canvas canvas, Offset center, bool southUp) {
    final rosePaint = Paint()
      ..color = Colors.amber.shade700
      ..strokeWidth = 1.5;

    canvas.drawLine(Offset(center.dx, center.dy - 20), Offset(center.dx, center.dy + 20), rosePaint);
    canvas.drawLine(Offset(center.dx - 20, center.dy), Offset(center.dx + 20, center.dy), rosePaint);

    final topLabel = southUp ? 'الجَنُوبُ (S)' : 'الشَّمَالُ (N)';
    final bottomLabel = southUp ? 'الشَّمَالُ (N)' : 'الجَنُوبُ (S)';

    _drawText(canvas, topLabel, Offset(center.dx - 24, center.dy - 32), Colors.amberAccent, 9.0);
    _drawText(canvas, bottomLabel, Offset(center.dx - 24, center.dy + 22), Colors.amberAccent, 9.0);
  }

  void _drawText(Canvas canvas, String text, Offset offset, Color color, double fontSize) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.rtl,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant TabulaRogerianaMapPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
