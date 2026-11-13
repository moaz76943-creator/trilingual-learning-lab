import 'package:flutter/material.dart';
import '../controllers/hal_tamyiz_controller.dart';

class HalTamyizScreen extends StatefulWidget {
  final HalTamyizController? controller;

  const HalTamyizScreen({super.key, this.controller});

  @override
  State<HalTamyizScreen> createState() => _HalTamyizScreenState();
}

class _HalTamyizScreenState extends State<HalTamyizScreen> {
  late final HalTamyizController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? HalTamyizController();
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
        title: const Text('مُخْتَبَرُ أَسَالِيبِ الحَالِ وَالتَّمْيِيزِ وَالنَّعْتِ'),
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
              // بطاقة اختيار التصنيف النحوي
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'بَابُ المَنْصُوبَاتِ الوَصْفِيَّةِ وَالتَّمْيِيزِ (Depictive Topology):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildCategoryChip(
                            DepictiveCategory.singularDepictiveHal,
                            'الحَالُ المُفْرَدَةُ (Depictive)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            DepictiveCategory.clausalHalWithWaw,
                            'جُمْلَةُ الحَالِ وَوَاوُهُ',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            DepictiveCategory.specificationTamyiz,
                            'تَمْيِيزُ النِّسْبَةِ (Tamyiz)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            DepictiveCategory.halVsNatDistinction,
                            'الحَالُ مُقَابِلَ النَّعْتِ',
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
                // بطاقة الشاهد الثلاثي اللغات
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
                            const Icon(Icons.layers_outlined, color: Colors.indigo),
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

                        // الكلمة أو الجملة المحللة
                        Text(
                          'مَوْضِعُ الشَّاهِدِ: ${current.salientTargetAr}',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 16),
                        ),
                        const SizedBox(height: 8),

                        // الجملة العربية
                        Text(
                          current.sentenceAr,
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
                            'English Secondary Predication:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.sentenceEn,
                            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // المقابل الألماني
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'Deutsche Prädikativ- & Partizipialkonstruktion:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.sentenceDe,
                            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // بطاقة التشخيص النحوي المقارن
                if (state.showDetailedDiagnosis)
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
                              Icon(Icons.fact_check_outlined, color: Colors.teal),
                              SizedBox(width: 8),
                              Text(
                                'التَّشْخِيصُ النَّحْوِيُّ وَالتَّحْلِيلُ التَّرْكِيبِيُّ:',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(current.grammaticalDiagnosisAr, style: const TextStyle(fontSize: 14, height: 1.4)),
                          const SizedBox(height: 8),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• EN Rule: ${current.grammaticalDiagnosisEn}', style: const TextStyle(fontSize: 12)),
                          ),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• DE Regel: ${current.grammaticalDiagnosisDe}', style: const TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // بطاقة القاعدة الذهبية الفارقة
                if (state.showContrastRule)
                  Card(
                    elevation: 3,
                    color: Colors.amber.shade50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.verified_outlined, color: Colors.amber),
                              SizedBox(width: 8),
                              Text(
                                'القَاعِدَةُ الذَّهَبِيَّةُ الفَارِقَةُ:',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.brown),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            current.keyContrastRule,
                            style: const TextStyle(fontSize: 14, height: 1.4, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // مؤشر الدقة التركيبية
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مُؤَشِّرُ الدِّقَّةِ الإِسْنَادِيَّةِ لِلْحَالِ وَالتَّمْيِيزِ: ${(current.syntacticPrecisionScore * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: current.syntacticPrecisionScore,
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

  Widget _buildCategoryChip(DepictiveCategory category, String label, DepictiveCategory selected) {
    final isSelected = category == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.indigo.shade200,
      onSelected: (_) => _controller.selectCategory(category),
    );
  }
}
