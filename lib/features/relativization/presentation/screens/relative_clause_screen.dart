import 'package:flutter/material.dart';
import '../controllers/relative_clause_controller.dart';

class RelativeClauseScreen extends StatefulWidget {
  final RelativeClauseController? controller;

  const RelativeClauseScreen({super.key, this.controller});

  @override
  State<RelativeClauseScreen> createState() => _RelativeClauseScreenState();
}

class _RelativeClauseScreenState extends State<RelativeClauseScreen> {
  late final RelativeClauseController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? RelativeClauseController();
    _controller.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_onStateChanged);
    }
    super.dispose();
  }

  void _onStateChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.state;
    final current = state.currentScenario;

    return Scaffold(
      appBar: AppBar(
        title: const Text('مُخْتَبَرُ المَوْصُولَاتِ النَّحْوِيَّةِ وَعَائِدِ الصِّلَةِ'),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade900,
        foregroundColor: Colors.white,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // بطاقة اختيار نمط الموصولات النحوية
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'نَمَطُ المَوْصُولَاتِ وَالإِسْنَادِ الصِّلِيِّ (Relativization Topology):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildPatternChip(
                            RelativizationPattern.resumptivePronounBinding,
                            'عَائِدُ الصِّلَةِ (Resumptive)',
                            state.selectedPattern,
                          ),
                          _buildPatternChip(
                            RelativizationPattern.restrictiveVsAppositive,
                            'التَّقْيِيدِيُّ (Restrictive)',
                            state.selectedPattern,
                          ),
                          _buildPatternChip(
                            RelativizationPattern.prepositionStrandingPied,
                            'الجَرُّ بِالمَوْصُولِ (Pied-Piping)',
                            state.selectedPattern,
                          ),
                          _buildPatternChip(
                            RelativizationPattern.asyndeticZeroRelative,
                            'صِلَةُ النَّكِرَةِ (Zero Relative)',
                            state.selectedPattern,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              if (current != null) ...[
                // بطاقة الشاهد التركيبي ثلاثي اللغات
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  color: Colors.indigo.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.link_rounded, color: Colors.indigo),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                current.titleAr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.indigo.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),

                        // الجملة العربية الكاملة
                        const Text(
                          'التَّرْكِيبُ المَوْصُولِيُّ العَرَبِيُّ الفَصِيحُ:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.fullSentenceAr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Amiri',
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // المقابل الإنجليزي
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'English Relative Clause Equivalent:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.fullSentenceEn,
                            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // المقابل الألماني
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'Deutscher Relativsatz & Kommasetzung:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.fullSentenceDe,
                            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // بطاقة تفكيك عائد الصلة والرابط الإسنادي
                if (state.showResumptiveBinding)
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.hub_outlined, color: Colors.teal),
                              SizedBox(width: 8),
                              Text(
                                'تَفْكِيكُ أَرْكَانِ الإِسْنَادِ الصِّلِيِّ:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('• العَائِدُ عَلَيْهِ (المَوْصُوفُ): ${current.antecedentAr}', style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 4),
                          Text('• اسْمُ المَوْصُولِ / الأَدَاةُ: ${current.relativeMarkerAr}', style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 4),
                          Text('• الضَّمِيرُ العَائِدُ (الرَّابِطُ): ${current.resumptivePronounAr}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.indigo)),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'التَّعْلِيلُ الإِعْرَابِيُّ: ${current.syntacticAnalysisAr}',
                              style: const TextStyle(fontSize: 13, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // بطاقة التحذير من أخطاء النقل الترجمي الشائعة
                if (state.showTransferPitfall)
                  Card(
                    elevation: 3,
                    color: Colors.red.shade50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
                              SizedBox(width: 8),
                              Text(
                                'تَحْذِيرٌ مِنْ مَزَالِقِ النَّقْلِ التَّرْجَمِيِّ الخَاطِئِ:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(current.commonTransferError, style: const TextStyle(fontSize: 13, height: 1.4)),
                          const SizedBox(height: 6),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• EN Pitfall: ${current.syntacticAnalysisEn}', style: const TextStyle(fontSize: 12)),
                          ),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• DE Regel: ${current.syntacticAnalysisDe}', style: const TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // مؤشر التعقيد التركيبي
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مُؤَشِّرُ التَّعْقِيدِ التَّرْكِيبِيِّ لِلصِّلَةِ: ${(current.structuralComplexityScore * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: current.structuralComplexityScore,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo.shade800),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatternChip(RelativizationPattern pattern, String label, RelativizationPattern selected) {
    final isSelected = pattern == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.indigo.shade200,
      onSelected: (_) => _controller.selectPattern(pattern),
    );
  }
}
