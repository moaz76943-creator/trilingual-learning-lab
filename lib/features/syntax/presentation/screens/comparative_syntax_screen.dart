import 'package:flutter/material.dart';
import '../controllers/comparative_syntax_controller.dart';

/// Screen presenting the Comparative Trilingual Syntax Tree & Clause Topology Studio
class ComparativeSyntaxScreen extends StatefulWidget {
  final ComparativeSyntaxController? controller;

  const ComparativeSyntaxScreen({super.key, this.controller});

  @override
  State<ComparativeSyntaxScreen> createState() => _ComparativeSyntaxScreenState();
}

class _ComparativeSyntaxScreenState extends State<ComparativeSyntaxScreen> {
  late final ComparativeSyntaxController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ComparativeSyntaxController();
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
              'مُحَلِّلُ التَّرَاكِيبِ النَّحْوِيَّةِ التَّقَابُلِيِّ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Comparative Trilingual Syntax Tree (VSO - V2 - SVO)',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_controller.state.isWordOrderChallengeActive
                ? Icons.extension
                : Icons.extension_outlined),
            tooltip: 'تَحَدِّي تَرْتِيبِ الكَلِمَاتِ (V2-Word Order Challenge)',
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
          final sentence = state.selectedSentence;

          return Column(
            children: [
              _buildSentenceSelector(state),

              // Visual Comparative Syntax Canvas
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark syntax tree background
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
                      painter: SyntaxAlignmentPainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Topology & Case Readout Card
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
                        _buildTopologyBadge(
                          lang: 'العَرَبِيَّةُ',
                          pattern: 'VSO / SVO',
                          desc: 'فِعْلٌ ثُمَّ فَاعِلٌ',
                          color: Colors.greenAccent,
                        ),
                        _buildTopologyBadge(
                          lang: 'Deutsch',
                          pattern: 'V2 / Verbletzt',
                          desc: 'Verb an Position 2',
                          color: Colors.blueAccent,
                        ),
                        _buildTopologyBadge(
                          lang: 'English',
                          pattern: 'Rigid SVO',
                          desc: 'Subject-Verb-Object',
                          color: Colors.amberAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Interactive Token Explorer / V2 Order Challenge
              Expanded(
                flex: 4,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  children: [
                    if (state.isWordOrderChallengeActive) ...[
                      // Interactive Reorder Challenge Box
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
                                  ? 'أَحْسَنْتَ! تَرْتِيبٌ صَحِيحٌ يُطَابِقُ قَاعِدَةَ الفِعْلِ الثَّانِي (V2-Regel)!'
                                  : 'رَتِّبِ الكَلِمَاتِ لِتَحْقِيقِ قَاعِدَةِ الفِعْلِ فِي المَوْقِعِ الثَّانِي (V2):',
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
                                for (int i = 0; i < state.shuffledGermanTokens.length; i++)
                                  ListTile(
                                    key: ValueKey(state.shuffledGermanTokens[i]),
                                    tileColor: const Color(0xFF334155),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    title: Text(
                                      '${i + 1}. ${state.shuffledGermanTokens[i]}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    trailing: const Icon(Icons.drag_handle, color: Colors.white54),
                                  ),
                              ],
                              onReorder: _controller.reorderGermanTokens,
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      // Constituent Role Filter Chips
                      const Text(
                        'إِبْرَازُ الأَدْوَارِ التَّرْكِيبِيَّةِ التَّقَابُلِيَّةِ (Rollen hervorheben):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: ConstituentRole.values.map((role) {
                          final isSelected = state.highlightedRole == role;
                          return ChoiceChip(
                            label: Text(
                              role.nameAr.split(' ').first,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: Color(role.colorHex).withOpacity(0.4),
                            onSelected: (_) => _controller.highlightConstituent(role),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 8),

                      // Comparative Linguistic Insight Box
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F2E3A).withOpacity(0.35),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.cyanAccent.shade700, width: 1.0),
                        ),
                        child: Text(
                          sentence.comparativeInsightAr,
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

  Widget _buildSentenceSelector(ComparativeSyntaxState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: DropdownButtonFormField<ParallelSentence>(
        decoration: const InputDecoration(
          labelText: 'الجُمْلَةُ التَّقَابُلِيَّةُ المَدْرُوسَةُ',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        ),
        value: state.selectedSentence,
        items: ParallelSentence.corpus.map((s) {
          return DropdownMenuItem(
            value: s,
            child: Text(s.titleAr, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          );
        }).toList(),
        onChanged: (val) {
          if (val != null) _controller.selectSentence(val);
        },
      ),
    );
  }

  Widget _buildTopologyBadge({
    required String lang,
    required String pattern,
    required String desc,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(lang, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color, width: 1.0),
          ),
          child: Text(pattern, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
        ),
        const SizedBox(height: 2),
        Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey.shade400)),
      ],
    );
  }
}

/// Custom painter rendering aligned parallel clause tiers with colored syntax connecting beams
class SyntaxAlignmentPainter extends CustomPainter {
  final ComparativeSyntaxState state;

  SyntaxAlignmentPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    // 3 Tiers:
    // Tier 1 (Top): Arabic (RTL)
    // Tier 2 (Middle): German (LTR)
    // Tier 3 (Bottom): English (LTR)
    final tier1Y = height * 0.20;
    final tier2Y = height * 0.50;
    final tier3Y = height * 0.80;

    _drawSentenceTier(
      canvas: canvas,
      y: tier1Y,
      tokens: state.selectedSentence.tokensAr,
      isRtl: true,
      label: 'العَرَبِيَّةُ (VSO):',
      width: width,
    );

    _drawSentenceTier(
      canvas: canvas,
      y: tier2Y,
      tokens: state.selectedSentence.tokensDe,
      isRtl: false,
      label: 'Deutsch (V2):',
      width: width,
    );

    _drawSentenceTier(
      canvas: canvas,
      y: tier3Y,
      tokens: state.selectedSentence.tokensEn,
      isRtl: false,
      label: 'English (SVO):',
      width: width,
    );

    // Header label
    _drawText(canvas, 'شَجَرَةُ التَّرَاكِيبِ النَّحْوِيَّةِ التَّقَابُلِيَّةِ (Syntax Alignment)', const Offset(16, 12), Colors.amberAccent, 11.0);
  }

  void _drawSentenceTier({
    required Canvas canvas,
    required double y,
    required List<SyntaxToken> tokens,
    required bool isRtl,
    required String label,
    required double width,
  }) {
    // Label
    _drawText(canvas, label, Offset(16, y - 18), Colors.white70, 10.0);

    final numTokens = tokens.length;
    final slotWidth = (width - 32) / numTokens;

    for (int i = 0; i < numTokens; i++) {
      final token = tokens[i];
      final isHighlighted = (state.highlightedRole == null) || (state.highlightedRole == token.role);

      double x;
      if (isRtl) {
        x = width - 16 - ((i + 1) * slotWidth);
      } else {
        x = 16 + (i * slotWidth);
      }

      final rect = Rect.fromLTWH(x + 3, y - 2, slotWidth - 6, 32);

      // Box fill and outline matching constituent color
      final roleColor = Color(token.role.colorHex);
      final fillPaint = Paint()
        ..color = isHighlighted ? roleColor.withOpacity(0.35) : Colors.white10
        ..style = PaintingStyle.fill;
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(6)), fillPaint);

      final strokePaint = Paint()
        ..color = isHighlighted ? roleColor : Colors.white24
        ..style = PaintingStyle.stroke
        ..strokeWidth = isHighlighted ? 1.5 : 1.0;
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(6)), strokePaint);

      // Token text
      _drawText(
        canvas,
        token.text,
        Offset(rect.center.dx - (token.text.length * 3.2), rect.center.dy - 6),
        isHighlighted ? Colors.white : Colors.white54,
        10.5,
      );

      // Sub-label (Topological Field / Case)
      _drawText(
        canvas,
        token.topologicalField.split(' ').first,
        Offset(rect.center.dx - 18, rect.bottom + 3),
        isHighlighted ? roleColor : Colors.white38,
        8.0,
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
  bool shouldRepaint(covariant SyntaxAlignmentPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
