import 'package:flutter/material.dart';
import '../controllers/morphological_deconstruction_controller.dart';

/// Screen presenting the Trilingual Morphological Root & Compound Deconstruction Studio
class MorphologicalDeconstructionScreen extends StatefulWidget {
  final MorphologicalDeconstructionController? controller;

  const MorphologicalDeconstructionScreen({super.key, this.controller});

  @override
  State<MorphologicalDeconstructionScreen> createState() =>
      _MorphologicalDeconstructionScreenState();
}

class _MorphologicalDeconstructionScreenState
    extends State<MorphologicalDeconstructionScreen> {
  late final MorphologicalDeconstructionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? MorphologicalDeconstructionController();
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
              'مُخْتَبَرُ الاشْتِقَاقِ وَتَفْكِيكِ المُرَكَّبَاتِ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Morphological Roots & Compound Deconstruction Studio',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_controller.state.isAssemblyChallengeActive
                ? Icons.extension
                : Icons.extension_outlined),
            tooltip: 'تَحَدِّي التَّرْكِيبِ الصَّرْفِيِّ (Morphology Challenge)',
            onPressed: _controller.toggleChallenge,
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
          final word = state.selectedWord;

          return Column(
            children: [
              _buildLanguageSelector(state),

              // Visual Morphological Brick Canvas
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark morphological slate
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
                      painter: MorphologicalBrickPainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Morphological Metadata Readout Card
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
                          labelAr: 'الكَلِمَةُ المَفْحُوصَةُ',
                          labelEn: 'Target Word',
                          value: word.fullWord,
                          color: Colors.amberAccent,
                        ),
                        if (word.rootString != null)
                          _buildMetric(
                            labelAr: 'الجَذْرُ الأَصْلِيُّ',
                            labelEn: 'Core Root',
                            value: word.rootString!,
                            color: Colors.greenAccent,
                          ),
                        if (word.patternName != null)
                          _buildMetric(
                            labelAr: 'المِيزَانُ / النَّمَطُ',
                            labelEn: 'Pattern / Schema',
                            value: word.patternName!.split(' ').first,
                            color: Colors.cyanAccent,
                          ),
                        _buildMetric(
                          labelAr: 'عَدَدُ الأَجْزَاءِ',
                          labelEn: 'Segments Count',
                          value: '${word.segments.length}',
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Interactive Segment Inspector / Assembly Challenge
              Expanded(
                flex: 4,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  children: [
                    if (state.isAssemblyChallengeActive) ...[
                      // Reorder Assembly Challenge
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: state.challengeSolved
                              ? const Color(0xFF065F46).withOpacity(0.4)
                              : const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: state.challengeSolved ? Colors.greenAccent : Colors.amberAccent,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              state.challengeSolved
                                  ? 'أَحْسَنْتَ! تَمَّ تَرْكِيبُ البِنْيَةِ الصَّرْفِيَّةِ بِنَجَاحٍ تَامٍّ!'
                                  : 'أَعِدْ تَرْتِيبَ لَبِنَاتِ الكَلِمَةِ الصَّرْفِيَّةِ بِالشَّكْلِ الصَّحِيحِ:',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: state.challengeSolved ? Colors.greenAccent : Colors.amberAccent,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ReorderableListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                for (int i = 0; i < state.shuffledSegments.length; i++)
                                  ListTile(
                                    key: ValueKey('${state.shuffledSegments[i]}_$i'),
                                    tileColor: const Color(0xFF334155),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    title: Text(
                                      '${i + 1}. [ ${state.shuffledSegments[i]} ]',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                    trailing: const Icon(Icons.drag_handle, color: Colors.white54),
                                  ),
                              ],
                              onReorder: _controller.reorderSegments,
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      // Word Selection Dropdown
                      DropdownButtonFormField<MorphologicalWord>(
                        decoration: const InputDecoration(
                          labelText: 'اخْتِيَارُ النَّمُوذَجِ الصَّرْفِيِّ لِلتَّفْكِيكِ',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        ),
                        value: word,
                        items: MorphologicalWord.catalog
                            .where((w) => w.language == state.selectedLanguage)
                            .map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              '${item.fullWord} (${item.meaningAr})',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) _controller.selectWord(val);
                        },
                      ),

                      const SizedBox(height: 8),

                      // Segment Inspection Chips
                      const Text(
                        'لَبِنَاتُ التَّفْكِيكِ الصَّرْفِيِّ (بِالضَّغْطِ لِلْمُعَايَنَةِ):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          for (int i = 0; i < word.segments.length; i++)
                            ActionChip(
                              backgroundColor: Color(word.segments[i].colorHex).withOpacity(0.3),
                              side: BorderSide(
                                color: state.highlightedSegmentIndex == i ? Colors.white : Color(word.segments[i].colorHex),
                                width: state.highlightedSegmentIndex == i ? 2.0 : 1.0,
                              ),
                              label: Text(
                                word.segments[i].segmentText,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              onPressed: () => _controller.highlightSegment(i),
                            ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Morphological Rule Explanation Box
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F2E3A).withOpacity(0.35),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.cyanAccent.shade700, width: 1.0),
                        ),
                        child: Text(
                          word.morphologicalRuleExplanationAr,
                          style: const TextStyle(fontSize: 12, color: Colors.white, height: 1.4),
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

  Widget _buildLanguageSelector(MorphologicalDeconstructionState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SegmentedButton<MorphologicalLanguage>(
        segments: MorphologicalLanguage.values.map((lang) {
          return ButtonSegment<MorphologicalLanguage>(
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

/// Custom painter rendering the Morphological Building Blocks (Lego Bricks) Canvas
class MorphologicalBrickPainter extends CustomPainter {
  final MorphologicalDeconstructionState state;

  MorphologicalBrickPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final word = state.selectedWord;
    final numSegments = word.segments.length;

    // Header title
    _drawText(canvas, 'تَفْكِيكُ البِنْيَةِ الصَّرْفِيَّةِ لِلْكَلِمَةِ', const Offset(16, 14), Colors.amberAccent, 11.0);

    // 1. Draw Full Word Header
    final fullWordCenter = Offset(width * 0.5, height * 0.22);
    _drawText(
      canvas,
      word.fullWord,
      Offset(fullWordCenter.dx - (word.fullWord.length * 6.0), fullWordCenter.dy - 14),
      Colors.white,
      22.0,
    );

    // 2. Draw Deconstructed Bricks Tier
    final brickTierY = height * 0.50;
    const totalSpacing = 8.0;
    final availableWidth = width - 40;
    final brickWidth = (availableWidth - ((numSegments - 1) * totalSpacing)) / numSegments;
    const brickHeight = 44.0;

    for (int i = 0; i < numSegments; i++) {
      final seg = word.segments[i];
      final isHighlighted = (state.highlightedSegmentIndex == null || state.highlightedSegmentIndex == i);

      final brickLeft = 20 + (i * (brickWidth + totalSpacing));
      final rect = Rect.fromLTWH(brickLeft, brickTierY, brickWidth, brickHeight);

      // Color from segment definition
      final segColor = Color(seg.colorHex);

      // Draw Brick Background
      final fillPaint = Paint()
        ..color = isHighlighted ? segColor.withOpacity(0.40) : Colors.white10
        ..style = PaintingStyle.fill;
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)), fillPaint);

      // Brick Stroke
      final strokePaint = Paint()
        ..color = isHighlighted ? segColor : Colors.white24
        ..style = PaintingStyle.stroke
        ..strokeWidth = isHighlighted ? 2.0 : 1.0;
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)), strokePaint);

      // Top Connector Pegs (Lego style)
      final pegPaint = Paint()..color = isHighlighted ? segColor : Colors.white24;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(rect.center.dx - 10, rect.top - 4, 20, 5), const Radius.circular(2)),
        pegPaint,
      );

      // Segment Text
      _drawText(
        canvas,
        seg.segmentText,
        Offset(rect.center.dx - (seg.segmentText.length * 5.0), rect.center.dy - 8),
        isHighlighted ? Colors.white : Colors.white54,
        15.0,
      );

      // Grammatical Role Subtitle underneath brick
      final labelShort = seg.grammaticalLabelAr.split(' ').first;
      _drawText(
        canvas,
        labelShort,
        Offset(rect.center.dx - (labelShort.length * 3.0), rect.bottom + 6),
        isHighlighted ? segColor : Colors.white38,
        9.0,
      );
    }

    // 3. Detailed Inspector Box for Currently Highlighted Segment
    if (state.highlightedSegmentIndex != null) {
      final idx = state.highlightedSegmentIndex!;
      final activeSeg = word.segments[idx];
      final inspectorRect = Rect.fromLTWH(24, height * 0.72, width - 48, 48);

      final inspPaint = Paint()
        ..color = const Color(0xFF1E293B).withOpacity(0.8)
        ..style = PaintingStyle.fill;
      canvas.drawRRect(RRect.fromRectAndRadius(inspectorRect, const Radius.circular(8)), inspPaint);

      final inspBorder = Paint()
        ..color = Color(activeSeg.colorHex)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawRRect(RRect.fromRectAndRadius(inspectorRect, const Radius.circular(8)), inspBorder);

      _drawText(
        canvas,
        'اللَّبِنَةُ: [ ${activeSeg.segmentText} ] - ${activeSeg.grammaticalLabelAr}',
        Offset(inspectorRect.left + 12, inspectorRect.top + 8),
        Colors.amberAccent,
        11.0,
      );

      _drawText(
        canvas,
        'DE: ${activeSeg.grammaticalLabelDe} | EN: ${activeSeg.grammaticalLabelEn}',
        Offset(inspectorRect.left + 12, inspectorRect.top + 26),
        Colors.grey.shade400,
        9.5,
      );
    }
  }

  void _drawText(Canvas canvas, String text, Offset offset, Color color, double fontSize) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant MorphologicalBrickPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
