import 'package:flutter/material.dart';
import '../controllers/conditional_mood_controller.dart';

class ConditionalMoodScreen extends StatefulWidget {
  final ConditionalMoodController? controller;

  const ConditionalMoodScreen({super.key, this.controller});

  @override
  State<ConditionalMoodScreen> createState() => _ConditionalMoodScreenState();
}

class _ConditionalMoodScreenState extends State<ConditionalMoodScreen> {
  late final ConditionalMoodController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ConditionalMoodController();
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
        title: const Text('مُخْتَبَرُ أَسَالِيبِ الشَّرْطِ وَالفَرْضِيَّاتِ الامْتِنَاعِيَّةِ'),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade900,
        foregroundColor: Colors.white,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // بطاقة اختيار نوع الشرط والاحتمال
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'نَمَطُ التَّعْلِيقِ الشَّرْطِيِّ وَالصِّيغَةُ المَنْطِقِيَّةُ:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildCategoryChip(
                            ConditionalCategory.realisPredictive,
                            'شَرْطٌ مُحَقَّقٌ (Realis / إِنْ)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            ConditionalCategory.counterfactualPast,
                            'امْتِنَاعٌ مَاضٍ (Irrealis / لَوْ)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            ConditionalCategory.presenceExclusion,
                            'امْتِنَاعٌ لِوُجُودٍ (لَوْلَا)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            ConditionalCategory.invertedSubjunctive,
                            'جَوَابُ الطَّلَبِ وَالتَّقْدِيمُ (V1)',
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
                // بطاقة العرض الثلاثي المقارن للشاهد الشرطي
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  color: Colors.cyan.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.alt_route_rounded, color: Colors.cyan),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                current.titleAr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.cyan.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),

                        // الجملة العربية الكاملة
                        const Text(
                          'التَّرْكِيبُ الشَّرْطِيُّ العَرَبِيُّ الفَصِيحُ:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan),
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
                            'English Conditional Counterpart:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
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
                            'Deutsche Konditionalkonstruktion:',
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

                // بطاقة تفكيك جملة الشرط وجوابه (Protasis vs Apodosis)
                if (state.showProtasisApodosisSplit)
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
                              Icon(Icons.call_split_rounded, color: Colors.teal),
                              SizedBox(width: 8),
                              Text(
                                'تَفْكِيكُ رُكْنَيِ الشَّرْطِ (Protasis & Apodosis):',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.teal.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('١. جُمْلَةُ الشَّرْطِ (Protasis / Bedingung): ${current.protasisAr}', style: const TextStyle(fontSize: 14)),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('٢. جَوَابُ الشَّرْطِ (Apodosis / Folge): ${current.apodosisAr}', style: const TextStyle(fontSize: 14)),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // بطاقة الميكانيكية الصرفية والأدوات الموظفة
                if (state.showMoodMechanics)
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
                              Icon(Icons.engineering, color: Colors.cyan),
                              SizedBox(width: 8),
                              Text(
                                'آلِيَّةُ الإِعْرَابِ وَالصِّيغَةِ المَنْطِقِيَّةِ:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.cyan,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('• الأداة والتركيب: ${current.operatorAnalysisAr}', style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 6),
                          Text('• العلة النحوية: ${current.moodMechanicsAr}', style: const TextStyle(fontSize: 14, height: 1.4)),
                          const SizedBox(height: 8),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• EN Mechanics: ${current.moodMechanicsEn}', style: const TextStyle(fontSize: 12, color: Colors.black87)),
                          ),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• DE Mechanik: ${current.moodMechanicsDe}', style: const TextStyle(fontSize: 12, color: Colors.black87)),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // مؤشر إمكانية التحقق الواقعي (Epistemic Likelihood)
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مُؤَشِّرُ احْتِمَالِ الوُقُوعِ الوَاقِعِيِّ (Epistemic Likelihood): ${(current.epistemicLikelihood * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: current.epistemicLikelihood,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan.shade800),
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

  Widget _buildCategoryChip(ConditionalCategory category, String label, ConditionalCategory selected) {
    final isSelected = category == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.cyan.shade200,
      onSelected: (_) => _controller.selectCategory(category),
    );
  }
}
