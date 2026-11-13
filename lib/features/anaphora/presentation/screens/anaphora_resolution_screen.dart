import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../controllers/anaphora_resolution_controller.dart';

/// Screen presenting the Interactive Trilingual Anaphora Resolution Studio
class AnaphoraResolutionScreen extends StatefulWidget {
  final AnaphoraResolutionController? controller;

  const AnaphoraResolutionScreen({super.key, this.controller});

  @override
  State<AnaphoraResolutionScreen> createState() =>
      _AnaphoraResolutionScreenState();
}

class _AnaphoraResolutionScreenState extends State<AnaphoraResolutionScreen> {
  late final AnaphoraResolutionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? AnaphoraResolutionController();
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
              'مُحَلِّلُ إِحَالَةِ الضَّمَائِرِ وَعَوْدِ المَرْجِعِ',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Text(
              'Trilingual Anaphora Resolution & Participial Unfolding',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
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
          final passage = state.selectedPassage;
          final activeToken = state.activeToken;
          final antecedent = state.activeAntecedent;

          return Column(
            children: [
              _buildLanguageSelector(state),

              // Visual Coreference Arcs Canvas
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark manuscript slate
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
                      painter: CoreferenceArcPainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Coreference Readout Card
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
                          labelAr: 'اللَّفْظَةُ المُخْتَارَةُ',
                          labelEn: 'Selected Token',
                          value: activeToken != null ? activeToken.wordText : 'اضْغَطْ كَلِمَةً',
                          color: Colors.amberAccent,
                        ),
                        _buildMetric(
                          labelAr: 'المَرْجِعُ العَائِدُ إِلَيْهِ',
                          labelEn: 'Resolved Antecedent',
                          value: antecedent != null ? antecedent.wordText : 'ـ',
                          color: Colors.greenAccent,
                        ),
                        _buildMetric(
                          labelAr: 'نَوْعُ الإِحَالَةِ',
                          labelEn: 'Coreference Type',
                          value: activeToken?.isPronounOrParticiple == true ? 'ضَمِيرٌ / نَعْتٌ' : 'اسْمٌ ظَاهِرٌ',
                          color: Colors.cyanAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Interactive Token Flow & German Participial Unfolding Controls
              Expanded(
                flex: 4,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  children: [
                    // German Unfolding Switch (if available)
                    if (passage.unfoldedAlternativeText != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.pinkAccent.shade400, width: 1.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'تَفْكِيكُ النَّعْتِ المَمْدُودِ إِلَى جُمْلَةِ صِلَةٍ (Relativsatz):',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                            Switch(
                              value: state.isUnfoldedViewActive,
                              activeColor: Colors.pinkAccent,
                              onChanged: (_) => _controller.toggleUnfoldedView(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],

                    // Token Word Chips (Interactive click to highlight antecedent)
                    const Text(
                      'شَرِيطُ كَلِمَاتِ النَّصِّ (انْقُرْ عَلَى الضَّمِيرِ لِرُؤْيَةِ مَرْجِعِهِ):',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (int i = 0; i < passage.tokens.length; i++)
                          ActionChip(
                            backgroundColor: state.activeSelectedTokenIndex == i
                                ? Color(passage.tokens[i].highlightColorHex).withOpacity(0.4)
                                : const Color(0xFF1E293B),
                            side: BorderSide(
                              color: state.activeSelectedTokenIndex == i
                                  ? Colors.white
                                  : Color(passage.tokens[i].highlightColorHex),
                              width: state.activeSelectedTokenIndex == i ? 2.0 : 1.0,
                            ),
                            label: Text(
                              passage.tokens[i].wordText,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: passage.tokens[i].isPronounOrParticiple
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            onPressed: () => _controller.selectToken(i),
                          ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Grammatical & Agreement Explanation Box
                    if (activeToken != null && activeToken.agreementExplanationAr != null)
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
                            Text(
                              'التَّوْضِيحُ الإِعْرَابِيُّ: ${activeToken.grammaticalRoleAr ?? ""}',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.cyanAccent),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'عَوْدُ المَرْجِعِ: ${activeToken.agreementExplanationAr!}',
                              style: const TextStyle(fontSize: 12, color: Colors.white, height: 1.3),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 6),

                    // Pedagogy Callout Box
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF334155).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber.shade700, width: 1.0),
                      ),
                      child: Text(
                        passage.syntacticPedagogyExplanationAr,
                        style: const TextStyle(fontSize: 11, color: Colors.amberAccent, height: 1.3),
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

  Widget _buildLanguageSelector(AnaphoraResolutionState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SegmentedButton<AnaphoraLanguage>(
        segments: AnaphoraLanguage.values.map((lang) {
          return ButtonSegment<AnaphoraLanguage>(
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

/// Custom painter rendering the visual Coreference Vector Arcs linking pronouns to antecedents
class CoreferenceArcPainter extends CustomPainter {
  final AnaphoraResolutionState state;

  CoreferenceArcPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final passage = state.selectedPassage;
    final isRtl = passage.language == AnaphoraLanguage.arabic;

    // Header label
    _drawText(canvas, 'مُخَطَّطُ أَقْوَاسِ الإِحَالَةِ وَعَوْدِ الضَّمَائِرِ', const Offset(16, 12), Colors.amberAccent, 11.0);

    // 1. Draw Linear Token Sequence Nodes at Baseline Y
    final baselineY = height * 0.70;
    final tokens = passage.tokens;
    final numTokens = tokens.length;
    final slotWidth = (width - 40) / numTokens;

    final tokenCenters = <int, Offset>{};

    for (int i = 0; i < numTokens; i++) {
      final token = tokens[i];
      double x;
      if (isRtl) {
        x = width - 20 - ((i + 0.5) * slotWidth);
      } else {
        x = 20 + ((i + 0.5) * slotWidth);
      }

      final center = Offset(x, baselineY);
      tokenCenters[i] = center;

      final isSelected = state.activeSelectedTokenIndex == i;
      final isAntecedent = state.activeToken?.antecedentTokenIndex == i;

      Color circleColor = Color(token.highlightColorHex);
      if (!token.isPronounOrParticiple && !isAntecedent) {
        circleColor = Colors.white24;
      }

      final circlePaint = Paint()
        ..color = (isSelected || isAntecedent) ? circleColor : circleColor.withOpacity(0.5)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, (isSelected || isAntecedent) ? 7.0 : 4.0, circlePaint);

      // Token word text label vertically rotated/staggered
      _drawText(
        canvas,
        token.wordText,
        Offset(center.dx - (token.wordText.length * 3.0), center.dy + 12),
        (isSelected || isAntecedent) ? Colors.white : Colors.white60,
        9.0,
      );
    }

    // 2. Draw Curved Coreference Arcs linking pronouns to antecedents
    for (int i = 0; i < numTokens; i++) {
      final token = tokens[i];
      if (token.antecedentTokenIndex != null) {
        final pCenter = tokenCenters[i]!;
        final aCenter = tokenCenters[token.antecedentTokenIndex!]!;

        final isCurrentActivePair = (state.activeSelectedTokenIndex == i) ||
            (state.activeToken?.antecedentTokenIndex == token.antecedentTokenIndex);

        final arcHeight = (pCenter.dx - aCenter.dx).abs() * 0.45;
        final controlY = baselineY - math.max(40.0, arcHeight);

        final arcPath = Path();
        arcPath.moveTo(pCenter.dx, pCenter.dy - 6);
        arcPath.quadraticBezierTo(
          (pCenter.dx + aCenter.dx) / 2.0,
          controlY,
          aCenter.dx,
          aCenter.dy - 6,
        );

        final arcPaint = Paint()
          ..color = isCurrentActivePair
              ? Color(token.highlightColorHex)
              : Color(token.highlightColorHex).withOpacity(0.25)
          ..style = PaintingStyle.stroke
          ..strokeWidth = isCurrentActivePair ? 2.5 : 1.2;

        canvas.drawPath(arcPath, arcPaint);

        // Arrowhead on Antecedent target
        if (isCurrentActivePair) {
          canvas.drawCircle(Offset(aCenter.dx, aCenter.dy - 6), 4.0, Paint()..color = Colors.greenAccent);
        }
      }
    }

    // 3. Unfolded View Box for German (if active)
    if (state.isUnfoldedViewActive && passage.unfoldedAlternativeText != null) {
      final unfoldRect = Rect.fromLTWH(20, height * 0.22, width - 40, 50);
      final unfoldPaint = Paint()..color = const Color(0xFF1E293B).withOpacity(0.9);
      canvas.drawRRect(RRect.fromRectAndRadius(unfoldRect, const Radius.circular(8)), unfoldPaint);

      final unfoldBorder = Paint()
        ..color = Colors.pinkAccent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawRRect(RRect.fromRectAndRadius(unfoldRect, const Radius.circular(8)), unfoldBorder);

      _drawText(canvas, 'الصِّيغَةُ المَفْكُوكَةُ (Entfalteter Relativsatz):', Offset(unfoldRect.left + 10, unfoldRect.top + 6), Colors.pinkAccent, 10.0);
      _drawText(canvas, passage.unfoldedAlternativeText!, Offset(unfoldRect.left + 10, unfoldRect.top + 24), Colors.white, 11.0);
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
  bool shouldRepaint(covariant CoreferenceArcPainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
