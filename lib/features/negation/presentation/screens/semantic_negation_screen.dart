import 'package:flutter/material.dart';
import '../controllers/semantic_negation_controller.dart';

class SemanticNegationScreen extends StatefulWidget {
  final SemanticNegationController? controller;

  const SemanticNegationScreen({super.key, this.controller});

  @override
  State<SemanticNegationScreen> createState() => _SemanticNegationScreenState();
}

class _SemanticNegationScreenState extends State<SemanticNegationScreen> {
  late final SemanticNegationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? SemanticNegationController();
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
        title: const Text('مُخْتَبَرُ النَّفْيِ الدَّلَالِيِّ وَالقُطْبِيَّةِ السَّالِبَةِ'),
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
              // بطاقة اختيار تصنيف النفي
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'صِنْفُ النَّفْيِ وَالسَّلْبِ الدَّلَالِيِّ (Negation Architecture):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildCategoryChip(
                            NegationCategory.temporalAspectual,
                            'نَفْيٌ زَمَنِيٌّ (Aspectual)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            NegationCategory.litotesDoubleNeg,
                            'تَهْوِينٌ وَنَفْيٌ مُضَاعَفٌ (Litotes)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            NegationCategory.negativePolarity,
                            'قُطْبِيَّةٌ سَالِبَةٌ (NPIs)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            NegationCategory.negationScopeAmbiguity,
                            'حَيِّزُ النَّفْيِ (Scope)',
                            state.selectedCategory,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              if (current != null) ...[
                // بطاقة المقارنة بين الإثبات والنفي المحكم
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
                            const Icon(Icons.remove_circle_outline, color: Colors.indigo),
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

                        // الجملة المثبتة
                        const Text(
                          'الجُمْلَةُ المُثْبَتَةُ الأَصْلِيَّةُ (Positive Baseline):',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(current.positiveBaseAr, style: const TextStyle(fontSize: 16, color: Colors.black87)),
                        const SizedBox(height: 12),

                        // الجملة المنفية البليغة
                        const Text(
                          'الصِّيَاغَةُ المَنْفِيَّةُ الدَّقِيقَةُ (Syntactically Negated Form):',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.negatedSentenceAr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Amiri',
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // المقابل الإنجليزي المنفي
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'English Negated Counterpart:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.negatedSentenceEn,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // المقابل الألماني المنفي
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'Deutsche Negationsstruktur:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.negatedSentenceDe,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // بطاقة أدوات النفي والترخيص القطي
                if (state.showPolarityConstraints)
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
                              Icon(Icons.rule, color: Colors.teal),
                              SizedBox(width: 8),
                              Text(
                                'أَدَاةُ السَّلْبِ وَشُرُوطُ التَّرْخِيصِ السِّيَاقِيِّ:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('• الأداة العربية: ${current.negativeOperatorAr}', style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• English Operator: ${current.negativeOperatorEn}', style: const TextStyle(fontSize: 14)),
                          ),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• Deutsche Negation: ${current.negativeOperatorDe}', style: const TextStyle(fontSize: 14)),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // بطاقة التحليل الدلالي وحيز النفي
                if (state.showScopeVisualizer)
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
                              Icon(Icons.psychology, color: Colors.indigo),
                              SizedBox(width: 8),
                              Text(
                                'التَّحْلِيلُ الدَّلَالِيُّ وَحَيِّزُ انْطِبَاقِ النَّفْيِ (Scope):',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.indigo,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(current.semanticAnalysisAr, style: const TextStyle(fontSize: 14, height: 1.4)),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text('• EN Scope: ${current.semanticAnalysisEn}', style: const TextStyle(fontSize: 12)),
                                ),
                                const SizedBox(height: 4),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text('• DE Skopus: ${current.semanticAnalysisDe}', style: const TextStyle(fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // مؤشر الرصانة والبلاغة
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مُؤَشِّرُ الدِّقَّةِ الدَّلَالِيَّةِ وَالبَلَاغِيَّةِ: ${(current.rhetoricalSubtletyIndex * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: current.rhetoricalSubtletyIndex,
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

  Widget _buildCategoryChip(NegationCategory category, String label, NegationCategory selected) {
    final isSelected = category == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.indigo.shade200,
      onSelected: (_) => _controller.selectCategory(category),
    );
  }
}
