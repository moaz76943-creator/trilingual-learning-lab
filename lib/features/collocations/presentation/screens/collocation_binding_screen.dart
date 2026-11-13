import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../controllers/collocation_binding_controller.dart';

/// Screen presenting the Trilingual Prepositional Verb Collocations Studio
class CollocationBindingScreen extends StatefulWidget {
  final CollocationBindingController? controller;

  const CollocationBindingScreen({super.key, this.controller});

  @override
  State<CollocationBindingScreen> createState() =>
      _CollocationBindingScreenState();
}

class _CollocationBindingScreenState extends State<CollocationBindingScreen> {
  late final CollocationBindingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? CollocationBindingController();
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
              'مُحَلِّلُ أَفْعَالِ الصِّلَةِ وَالمُتَصَاحِبَاتِ اللَّفْظِيَّةِ',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Text(
              'Trilingual Prepositional Verbs & Case Binding Studio',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_controller.state.isQuizModeActive
                ? Icons.quiz
                : Icons.quiz_outlined),
            tooltip: 'اخْتِبَارُ انْزِلاقِ المَعْنَى وَحُرُوفِ الجَرِّ',
            onPressed: _controller.toggleQuizMode,
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
          final verb = state.selectedVerb;
          final variant = state.activeVariant;

          return Column(
            children: [
              _buildLanguageSelector(state),

              // Visual Semantic Shift Canvas (Verb Stem + Preposition Socket)
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark linguistic lab slate
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
                      painter: PrepositionSocketPainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Governance Readout Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: const Color(0xFF1E293B),
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
                          labelAr: 'الفِعْلُ الرَّئِيسِيُّ',
                          labelEn: 'Base Verb',
                          value: verb.baseVerb,
                          color: Colors.amberAccent,
                        ),
                        _buildMetric(
                          labelAr: 'حَرْفُ الجَرِّ المُلْزَمُ',
                          labelEn: 'Bound Preposition',
                          value: variant.preposition,
                          color: Colors.cyanAccent,
                        ),
                        _buildMetric(
                          labelAr: 'حَالَةُ الإِعْرَابِ',
                          labelEn: 'Governed Case',
                          value: variant.governedCaseAr.split(' ').first,
                          color: Colors.lightGreenAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Interactive Preposition Socket Selector & Examples
              Expanded(
                flex: 4,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  children: [
                    // Verb Selector Dropdown
                    DropdownButtonFormField<PrepositionalVerb>(
                      decoration: const InputDecoration(
                        labelText: 'اخْتِيَارُ الفِعْلِ المُرْتَبِطِ بِحُرُوفِ الجَرِّ',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      ),
                      value: verb,
                      items: PrepositionalVerb.catalog
                          .where((v) => v.language == state.selectedLanguage)
                          .map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            '${item.baseVerb} (${item.baseMeaningAr})',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) _controller.selectVerb(val);
                      },
                    ),

                    const SizedBox(height: 8),

                    // Preposition Attachment Sockets (Chips)
                    Row(
                      children: [
                        const Text('انْزِلاقُ المَعْنَى بحَسَبِ الحَرْفِ: ',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        const SizedBox(width: 8),
                        for (int i = 0; i < verb.variants.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ChoiceChip(
                              label: Text(
                                '+ ${verb.variants[i].preposition}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              selected: state.selectedVariantIndex == i,
                              selectedColor: Colors.teal.shade700,
                              onSelected: (_) => _controller.selectVariant(i),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Meaning and Example Sentence Container
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F2E3A).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.cyanAccent.shade700, width: 1.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.psychology, color: Colors.cyanAccent, size: 16),
                              const SizedBox(width: 6),
                              Text(
                                'المَعْنَى الدِّلالِيُّ: ${variant.meaningAr}',
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text('مِثَالٌ: ${variant.exampleSentenceAr}', style: const TextStyle(fontSize: 12, height: 1.3)),
                          Text('DE: ${variant.exampleSentenceDe}', style: TextStyle(fontSize: 10.5, color: Colors.grey.shade400)),
                          Text('EN: ${variant.exampleSentenceEn}', style: TextStyle(fontSize: 10.5, color: Colors.grey.shade400)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 6),

                    // False Friend / Semantic Drift Warning Callout
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF451A03).withOpacity(0.35),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber.shade700, width: 1.0),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.warning_amber_rounded, color: Colors.amberAccent, size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              variant.falseFriendWarningAr,
                              style: const TextStyle(fontSize: 11, color: Colors.amberAccent),
                            ),
                          ),
                        ],
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

  Widget _buildLanguageSelector(CollocationBindingState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SegmentedButton<CollocationLanguage>(
        segments: CollocationLanguage.values.map((lang) {
          return ButtonSegment<CollocationLanguage>(
            value: lang,
            label: Text(
              lang.nameAr.split(' ').first,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
          );
        }).toList(),
        selected: {state.selectedLanguage},
        onSelectionChanged: (set) => _controller.setLanguage(set.first),
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

/// Custom painter rendering the Verb Stem, the Preposition Socket, and the Dynamic Semantic Vector
class PrepositionSocketPainter extends CustomPainter {
  final CollocationBindingState state;

  PrepositionSocketPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final center = Offset(width * 0.5, height * 0.45);

    // Header label
    _drawText(canvas, 'مُوَازَنَةُ التَّرَابُطِ بَيْنَ الفِعْلِ وَحَرْفِ الجَرِّ', const Offset(16, 12), Colors.amberAccent, 11.0);

    // 1. Draw Verb Stem Block (Left side / Core)
    final verbBoxRect = Rect.fromCenter(center: Offset(center.dx - 65, center.dy), width: 110, height: 60);

    final verbPaint = Paint()
      ..color = const Color(0xFF1E3A8A).withOpacity(0.6)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(verbBoxRect, const Radius.circular(10)), verbPaint);

    final verbBorder = Paint()
      ..color = Colors.lightBlueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRRect(RRect.fromRectAndRadius(verbBoxRect, const Radius.circular(10)), verbBorder);

    _drawText(
      canvas,
      state.selectedVerb.baseVerb,
      Offset(verbBoxRect.center.dx - (state.selectedVerb.baseVerb.length * 6.0), verbBoxRect.center.dy - 10),
      Colors.white,
      18.0,
    );
    _drawText(canvas, 'الفِعْلُ الأَصْلُ', Offset(verbBoxRect.center.dx - 22, verbBoxRect.bottom + 6), Colors.white54, 9.0);

    // 2. Draw Connector Coupling Link (Magnetic socket)
    final linkPaint = Paint()
      ..color = Colors.amberAccent
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(verbBoxRect.right, center.dy), Offset(verbBoxRect.right + 25, center.dy), linkPaint);

    // 3. Draw Preposition Socket Block (Right side / Preposition)
    final prepBoxRect = Rect.fromCenter(center: Offset(center.dx + 65, center.dy), width: 100, height: 60);

    final prepPaint = Paint()
      ..color = const Color(0xFF065F46).withOpacity(0.6)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(prepBoxRect, const Radius.circular(10)), prepPaint);

    final prepBorder = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRRect(RRect.fromRectAndRadius(prepBoxRect, const Radius.circular(10)), prepBorder);

    _drawText(
      canvas,
      state.activeVariant.preposition,
      Offset(prepBoxRect.center.dx - (state.activeVariant.preposition.length * 5.0), prepBoxRect.center.dy - 10),
      Colors.greenAccent,
      17.0,
    );
    _drawText(canvas, 'حَرْفُ الجَرِّ المُتَّصِلُ', Offset(prepBoxRect.center.dx - 32, prepBoxRect.bottom + 6), Colors.white54, 9.0);

    // 4. Dynamic Semantic Vector Arrow (Directing towards meaning outcome)
    final vectorStartX = center.dx;
    final vectorStartY = center.dy + 45;
    final vectorEndY = height - 25;

    final arrowPaint = Paint()
      ..color = Colors.orangeAccent
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(vectorStartX, vectorStartY), Offset(vectorStartX, vectorEndY), arrowPaint);

    // Arrowhead
    canvas.drawLine(Offset(vectorStartX, vectorEndY), Offset(vectorStartX - 6, vectorEndY - 8), arrowPaint);
    canvas.drawLine(Offset(vectorStartX, vectorEndY), Offset(vectorStartX + 6, vectorEndY - 8), arrowPaint);

    // Semantic Meaning Result Tag
    final meaningText = state.activeVariant.meaningAr.split('(').first.trim();
    _drawText(
      canvas,
      'المُحَصِّلَةُ الدِّلالِيَّةُ: $meaningText',
      Offset(vectorStartX - (meaningText.length * 3.5) - 30, vectorEndY - 20),
      Colors.amberAccent,
      11.0,
    );
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
  bool shouldRepaint(covariant PrepositionSocketPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
