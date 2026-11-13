import 'package:flutter/material.dart';
import '../controllers/discourse_connectives_controller.dart';

/// Screen presenting the Trilingual Academic Discourse Connectives Studio
class DiscourseConnectivesScreen extends StatefulWidget {
  final DiscourseConnectivesController? controller;

  const DiscourseConnectivesScreen({super.key, this.controller});

  @override
  State<DiscourseConnectivesScreen> createState() =>
      _DiscourseConnectivesScreenState();
}

class _DiscourseConnectivesScreenState extends State<DiscourseConnectivesScreen> {
  late final DiscourseConnectivesController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? DiscourseConnectivesController();
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
              'مُخْتَبَرُ رَوَابِطِ الخِطَابِ الأَكَادِيمِيِّ',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Text(
              'Trilingual Academic Discourse Connectives & Logic Studio',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_controller.state.isInteractiveSlotChallenge
                ? Icons.extension
                : Icons.extension_outlined),
            tooltip: 'تَحَدِّي الرَّابِطِ المَنْطِقِيِّ الأَنْسَبِ',
            onPressed: _controller.toggleSlotChallenge,
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
          final item = state.selectedConnective;

          return Column(
            children: [
              _buildLanguageSelector(state),

              // Visual Argumentation Flow Canvas (Premise -> Connective Bridge -> Conclusion)
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark logic slate
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
                      painter: ArgumentationFlowPainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Rhetorical Readout Card
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
                          labelAr: 'الرَّابِطُ الأَكَادِيمِيُّ',
                          labelEn: 'Discourse Marker',
                          value: item.connectiveText,
                          color: Colors.amberAccent,
                        ),
                        _buildMetric(
                          labelAr: 'العَلاقَةُ البَلاغِيَّةُ',
                          labelEn: 'Rhetorical Relation',
                          value: item.relation.nameAr.split(' ').first,
                          color: Color(item.relation.colorHex),
                        ),
                        _buildMetric(
                          labelAr: 'الأَثَرُ التَّرْكِيبِيُّ',
                          labelEn: 'Syntax Impact',
                          value: item.syntacticCategoryAr.split(' ').first,
                          color: Colors.cyanAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Interactive Connective Inspector & Challenge Controls
              Expanded(
                flex: 4,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  children: [
                    if (state.isInteractiveSlotChallenge) ...[
                      // Challenge Slot Selection
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: state.isSlotChallengeCorrect == true
                              ? const Color(0xFF065F46).withOpacity(0.4)
                              : const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: state.isSlotChallengeCorrect == true
                                ? Colors.greenAccent
                                : Colors.amberAccent,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              state.isSlotChallengeCorrect == true
                                  ? 'أَحْسَنْتَ! رَابِطٌ دَقِيقٌ يُحَقِّقُ السَّبَبِيَّةَ وَالمُلاءَمَةَ الأَكَادِيمِيَّةَ!'
                                  : 'اخْتَرْ أَدَاةَ الرَّبْطِ المَنْطِقِيَّةِ الأَنْسَبَ لِإِتْمَامِ المُحَاجَجَةِ:',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: state.isSlotChallengeCorrect == true
                                    ? Colors.greenAccent
                                    : Colors.amberAccent,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              children: [
                                for (final cand in DiscourseConnectiveItem.catalog
                                    .where((c) => c.language == state.selectedLanguage))
                                  ActionChip(
                                    label: Text(
                                      cand.connectiveText,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    backgroundColor: state.chosenSlotConnective == cand.connectiveText
                                        ? Colors.teal.shade700
                                        : const Color(0xFF334155),
                                    onPressed: () => _controller.evaluateSlotChoice(cand.connectiveText),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      // Rhetorical Relation Filter Chips
                      const Text(
                        'تَصْنِيفُ العَلاقَاتِ البَلاغِيَّةِ وَالمَنْطِقِيَّةِ:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: RhetoricalRelation.values.map((rel) {
                          final isSelected = state.selectedRelation == rel;
                          return ChoiceChip(
                            label: Text(
                              rel.nameAr.split(' ').first,
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                            selected: isSelected,
                            selectedColor: Color(rel.colorHex).withOpacity(0.35),
                            side: BorderSide(color: Color(rel.colorHex)),
                            onSelected: (_) => _controller.selectRelation(rel),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 8),

                      // Full Trilingual Syntactic Argument Display
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F2E3A).withOpacity(0.35),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.cyanAccent.shade700, width: 1.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AR: ${item.premiseClauseAr} [ ${item.connectiveText} ] ${item.conclusionClauseAr}',
                              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: Colors.white, height: 1.3),
                            ),
                            const SizedBox(height: 4),
                            Text('DE: ${item.premiseClauseDe} ${item.conclusionClauseDe}', style: TextStyle(fontSize: 11, color: Colors.grey.shade400)),
                            Text('EN: ${item.premiseClauseEn} ${item.conclusionClauseEn}', style: TextStyle(fontSize: 11, color: Colors.grey.shade400)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Usage Advice Callout
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF451A03).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.amber.shade700, width: 1.0),
                        ),
                        child: Text(
                          item.rhetoricalUsageAdviceAr,
                          style: const TextStyle(fontSize: 11, color: Colors.amberAccent, height: 1.3),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLanguageSelector(DiscourseConnectivesState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SegmentedButton<DiscourseLanguage>(
        segments: DiscourseLanguage.values.map((lang) {
          return ButtonSegment<DiscourseLanguage>(
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

/// Custom painter rendering the Academic Argumentation Flow Diagram (Premise -> Bridge -> Conclusion)
class ArgumentationFlowPainter extends CustomPainter {
  final DiscourseConnectivesState state;

  ArgumentationFlowPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final item = state.selectedConnective;

    // Header label
    _drawText(canvas, 'مُخَطَّطُ التَّدَفُّقِ البُرْهَانِيِّ لِلْخِطَابِ الأَكَادِيمِيِّ', const Offset(16, 12), Colors.amberAccent, 11.0);

    // 3 Sequential Stage Cards:
    // 1. Premise (المُقَدِّمَةُ / Prämisse) on Top
    // 2. Connective Bridge (رَابِطُ الاسْتِدْرَاكِ / Konnektor-Brücke) in Middle
    // 3. Conclusion (النَّتِيجَةُ / Konklusion) at Bottom
    final cardWidth = width - 40;
    const cardHeight = 44.0;
    final stage1Y = height * 0.22;
    final bridgeY = height * 0.50;
    final stage2Y = height * 0.78;

    // 1. Draw Premise Box
    final pRect = Rect.fromCenter(center: Offset(width * 0.5, stage1Y), width: cardWidth, height: cardHeight);
    final pPaint = Paint()
      ..color = const Color(0xFF1E3A8A).withOpacity(0.5)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(pRect, const Radius.circular(8)), pPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(pRect, const Radius.circular(8)), Paint()..color = Colors.lightBlueAccent..style = PaintingStyle.stroke..strokeWidth = 1.2);

    _drawText(canvas, 'المُقَدِّمَةُ: ${item.premiseClauseAr}', Offset(pRect.left + 12, pRect.center.dy - 6), Colors.white, 11.0);

    // 2. Draw Connective Bridge Hexagon / Diamond Box
    final bRect = Rect.fromCenter(center: Offset(width * 0.5, bridgeY), width: cardWidth * 0.55, height: 38);
    final bColor = Color(item.relation.colorHex);
    final bPaint = Paint()
      ..color = bColor.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(bRect, const Radius.circular(8)), bPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(bRect, const Radius.circular(8)), Paint()..color = bColor..style = PaintingStyle.stroke..strokeWidth = 2.0);

    _drawText(
      canvas,
      '[ ${item.connectiveText} ]',
      Offset(bRect.center.dx - (item.connectiveText.length * 4.5), bRect.center.dy - 7),
      Colors.amberAccent,
      14.0,
    );

    // Connecting Directional Arrows
    final arrowPaint = Paint()
      ..color = Colors.white54
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    // Arrow 1: Premise -> Bridge
    canvas.drawLine(Offset(width * 0.5, pRect.bottom), Offset(width * 0.5, bRect.top), arrowPaint);
    canvas.drawLine(Offset(width * 0.5, bRect.top), Offset(width * 0.5 - 5, bRect.top - 6), arrowPaint);
    canvas.drawLine(Offset(width * 0.5, bRect.top), Offset(width * 0.5 + 5, bRect.top - 6), arrowPaint);

    // Arrow 2: Bridge -> Conclusion
    canvas.drawLine(Offset(width * 0.5, bRect.bottom), Offset(width * 0.5, stage2Y - (cardHeight / 2)), arrowPaint);
    canvas.drawLine(Offset(width * 0.5, stage2Y - (cardHeight / 2)), Offset(width * 0.5 - 5, stage2Y - (cardHeight / 2) - 6), arrowPaint);
    canvas.drawLine(Offset(width * 0.5, stage2Y - (cardHeight / 2)), Offset(width * 0.5 + 5, stage2Y - (cardHeight / 2) - 6), arrowPaint);

    // 3. Draw Conclusion Box
    final cRect = Rect.fromCenter(center: Offset(width * 0.5, stage2Y), width: cardWidth, height: cardHeight);
    final cPaint = Paint()
      ..color = const Color(0xFF065F46).withOpacity(0.5)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(cRect, const Radius.circular(8)), cPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(cRect, const Radius.circular(8)), Paint()..color = Colors.greenAccent..style = PaintingStyle.stroke..strokeWidth = 1.2);

    _drawText(canvas, 'النَّتِيجَةُ / الاسْتِدْرَاكُ: ${item.conclusionClauseAr}', Offset(cRect.left + 12, cRect.center.dy - 6), Colors.white, 11.0);
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
  bool shouldRepaint(covariant ArgumentationFlowPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
