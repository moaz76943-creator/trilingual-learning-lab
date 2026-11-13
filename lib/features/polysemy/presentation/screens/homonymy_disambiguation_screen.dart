import 'package:flutter/material.dart';
import '../controllers/homonymy_disambiguation_controller.dart';

class HomonymyDisambiguationScreen extends StatefulWidget {
  final HomonymyDisambiguationController? controller;

  const HomonymyDisambiguationScreen({super.key, this.controller});

  @override
  State<HomonymyDisambiguationScreen> createState() => _HomonymyDisambiguationScreenState();
}

class _HomonymyDisambiguationScreenState extends State<HomonymyDisambiguationScreen> {
  late final HomonymyDisambiguationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? HomonymyDisambiguationController();
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
    final current = state.currentUnit;

    return Scaffold(
      appBar: AppBar(
        title: const Text('مُخْتَبَرُ المُشْتَرَكِ اللَّفْظِيِّ وَالتَّمْيِيزِ الدَّلَالِيِّ'),
        centerTitle: true,
        backgroundColor: Colors.teal.shade800,
        foregroundColor: Colors.white,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // اختيار نمط الاشتراك اللفظي والغموض الدلالي
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'نَمَطُ الاِشْتِرَاكِ اللَّفْظِيِّ (Ambiguity Typology):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildCategoryChip(
                            AmbiguityCategory.homonymicPolysemy,
                            'مُشْتَرَكٌ لَفْظِيٌّ (Polysemy)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            AmbiguityCategory.rhetoricalTawriya,
                            'تَوْرِيَةٌ بَدِيعِيَّةٌ (Tawriya)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            AmbiguityCategory.paronomasiaJinan,
                            'جِنَاسٌ تَامٌّ (Paronomasia)',
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
                // بطاقة اللفظ المحوري المشترك
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
                            const Icon(Icons.auto_stories, color: Colors.teal),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('اللَّفْظُ المَرْكَزِيُّ:', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                                Text(
                                  current.targetLemmaAr,
                                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Amiri', color: Colors.teal),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text('EN: ${current.targetLemmaEn}', style: const TextStyle(fontWeight: FontWeight.w600)),
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text('DE: ${current.targetLemmaDe}', style: const TextStyle(fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ألسنة التبديل بين المعاني المختلفة للفظ
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'المَعَانِي السِّيَاقِيَّةُ المَرْصُودَةُ (Divergent Senses):',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: List.generate(current.senses.length, (index) {
                            final sense = current.senses[index];
                            final isSelected = state.activeSenseIndex == index;
                            return ChoiceChip(
                              label: Text('المَعْنَى ${index + 1}: ${sense.senseNameAr}'),
                              selected: isSelected,
                              selectedColor: Colors.teal.shade200,
                              onSelected: (_) => _controller.setActiveSense(index),
                            );
                          }),
                        ),
                        const Divider(height: 18),

                        // تفاصيل المعنى النشط
                        if (state.activeSenseIndex < current.senses.length) ...[
                          Builder(builder: (context) {
                            final activeSense = current.senses[state.activeSenseIndex];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('الشَّاهِدُ السِّيَاقِيُّ المُحَقَّقُ:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                                const SizedBox(height: 4),
                                Text(
                                  activeSense.contextSentenceAr,
                                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, fontFamily: 'Amiri'),
                                ),
                                const SizedBox(height: 10),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text('EN: ${activeSense.contextSentenceEn}', style: const TextStyle(fontStyle: FontStyle.italic)),
                                ),
                                const SizedBox(height: 4),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text('DE: ${activeSense.contextSentenceDe}', style: const TextStyle(fontStyle: FontStyle.italic)),
                                ),
                                const SizedBox(height: 10),

                                // القرينة الدالة
                                if (state.showSelectionalCues)
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.amber.shade300),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.lightbulb_outline, color: Colors.amber, size: 20),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            'القَرِينَةُ الدَّالَّةُ عَلَى المَعْنَى: ${activeSense.selectionalCue}',
                                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            );
                          }),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // التحليل البلاغي واللساني
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'التَّحْلِيلُ البَيَانِيُّ وَالدَّلَالِيُّ المَقَارَنُ:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(height: 6),
                        Text(current.linguisticAnalysisAr, style: const TextStyle(fontSize: 14, height: 1.4)),
                        const SizedBox(height: 8),
                        Text(
                          'مُؤَشِّرُ عُمْقِ التَّمْيِيزِ الدَّلَالِيِّ: ${(current.disambiguationComplexity * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                        ),
                        const SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: current.disambiguationComplexity,
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

  Widget _buildCategoryChip(AmbiguityCategory category, String label, AmbiguityCategory selected) {
    final isSelected = category == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.teal.shade200,
      onSelected: (_) => _controller.selectCategory(category),
    );
  }
}
