import 'package:flutter/material.dart';
import '../controllers/comparative_superlative_controller.dart';

class ComparativeSuperlativeScreen extends StatefulWidget {
  final ComparativeSuperlativeController? controller;

  const ComparativeSuperlativeScreen({super.key, this.controller});

  @override
  State<ComparativeSuperlativeScreen> createState() => _ComparativeSuperlativeScreenState();
}

class _ComparativeSuperlativeScreenState extends State<ComparativeSuperlativeScreen> {
  late final ComparativeSuperlativeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ComparativeSuperlativeController();
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
        title: const Text('مُخْتَبَرُ أَسَالِيبِ التَّفْضِيلِ وَالمُفَاضَلَةِ وَالتَّدَرُّجِ'),
        centerTitle: true,
        backgroundColor: Colors.teal.shade900,
        foregroundColor: Colors.white,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // بطاقة اختيار نوع التدرج التفضيلي
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'صُورَةُ التَّفْضِيلِ وَالتَّدَرُّجِ الصِّفَاتِيِّ (Gradation Topology):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildPatternChip(
                            GradationPattern.comparativeDifferential,
                            'المُفَاضَلَةُ (أَفْعَلُ مِنْ)',
                            state.selectedPattern,
                          ),
                          _buildPatternChip(
                            GradationPattern.superlativeDefinite,
                            'التَّفْضِيلُ بِـ (أَلْ) والمُطَابَقَةُ',
                            state.selectedPattern,
                          ),
                          _buildPatternChip(
                            GradationPattern.periphrasticIndirect,
                            'التَّفْضِيلُ غَيْرُ المُبَاشِرِ',
                            state.selectedPattern,
                          ),
                          _buildPatternChip(
                            GradationPattern.correlativeProportional,
                            'التَّنَاسُبُ (كُلَّمَا / Je...desto)',
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
                // بطاقة الشاهد الثلاثي اللغات
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  color: Colors.teal.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.trending_up_rounded, color: Colors.teal),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                current.titleAr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.teal.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),

                        // الجذر والصفة الأصلية
                        Text(
                          'الأَصْلُ الصِّفَاتِيُّ: ${current.positiveBaseAr}',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                        ),
                        const SizedBox(height: 8),

                        // الجملة العربية
                        const Text(
                          'الشَّاهِدُ العَرَبِيُّ الفَصِيحُ:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.gradedSentenceAr,
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
                            'English Comparative / Superlative:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.gradedSentenceEn,
                            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // المقابل الألماني
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'Deutsche Steigerungsform:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.gradedSentenceDe,
                            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // بطاقة القواعد الصرفية والنحوية الحاكمة
                if (state.showMorphologicalRules)
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
                              Icon(Icons.menu_book_rounded, color: Colors.teal),
                              SizedBox(width: 8),
                              Text(
                                'القَاعِدَةُ الصَّرْفِيَّةُ وَالنَّحْوِيَّةُ:',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(current.morphologicalRuleAr, style: const TextStyle(fontSize: 14, height: 1.4)),
                          const SizedBox(height: 8),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• EN Rule: ${current.morphologicalRuleEn}', style: const TextStyle(fontSize: 12)),
                          ),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• DE Regel: ${current.morphologicalRuleDe}', style: const TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // بطاقة التحذير من الأخطاء الشائعة
                if (state.showCommonErrors)
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
                                'مَزَالِقُ التَّفْضِيلِ وَالأَخْطَاءُ الشَّائِعَةُ:',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.redAccent),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(current.commonErrorWarning, style: const TextStyle(fontSize: 13, height: 1.4, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // مؤشر الدرجة السلمية للتفضيل
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مُؤَشِّرُ السُّلَّمِ التَّفْضِيلِيِّ (Scalar Intensity Index): ${(current.scalarIntensityIndex * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: current.scalarIntensityIndex,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.teal.shade700),
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

  Widget _buildPatternChip(GradationPattern pattern, String label, GradationPattern selected) {
    final isSelected = pattern == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.teal.shade200,
      onSelected: (_) => _controller.selectPattern(pattern),
    );
  }
}
