import 'package:flutter/material.dart';
import '../controllers/exclamative_emphasis_controller.dart';

class ExclamativeEmphasisScreen extends StatefulWidget {
  final ExclamativeEmphasisController? controller;

  const ExclamativeEmphasisScreen({super.key, this.controller});

  @override
  State<ExclamativeEmphasisScreen> createState() => _ExclamativeEmphasisScreenState();
}

class _ExclamativeEmphasisScreenState extends State<ExclamativeEmphasisScreen> {
  late final ExclamativeEmphasisController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ExclamativeEmphasisController();
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
        title: const Text('مُخْتَبَرُ أَسَالِيبِ التَّعَجُّبِ وَالمَدْحِ وَالتَّوْكِيدِ'),
        centerTitle: true,
        backgroundColor: Colors.amber.shade900,
        foregroundColor: Colors.white,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // بطاقة اختيار الصنف الإنشائي والانفعالي
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'بَابُ الإِنْشَاءِ التَّعَجُّبِيِّ وَالتَّوْكِيدِ (Exclamative Typology):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildCategoryChip(
                            ExclamativeCategory.standardExclamationMaAfala,
                            'مَا أَفْعَلَهُ! / أَفْعِلْ بِهِ!',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            ExclamativeCategory.evaluativePraiseBlame,
                            'المَدْحُ وَالذَّمُّ (نِعْمَ/بِئْسَ)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            ExclamativeCategory.emphaticCorroboration,
                            'التَّوْكِيدُ وَالقَسَمُ',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            ExclamativeCategory.frontedInversionExclaim,
                            'التَّقْدِيمُ الانْفِعَالِيُّ',
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
                // بطاقة المقارنة بين الخبر الحيادي والتعجب البليغ
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  color: Colors.amber.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.bolt_rounded, color: Colors.deepOrange),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                current.titleAr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.brown.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),

                        // الجملة الخبرية الحيادية
                        if (state.showNeutralComparison) ...[
                          const Text(
                            'الأَصْلُ الخَبَرِيُّ الحِيَادِيُّ (Neutral Statement):',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(current.neutralBaseAr, style: const TextStyle(fontSize: 15, color: Colors.black87)),
                          const SizedBox(height: 12),
                        ],

                        // الصيغة التعجبية أو التوكيدية بالعربية
                        const Text(
                          'الصِّيغَةُ الإِنْشَائِيَّةُ البَلِيغَةُ:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.exclamativeAr,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Amiri',
                            color: Colors.brown,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // المقابل الإنجليزي
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'English Exclamative / Emphatic Form:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.exclamativeEn,
                            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // المقابل الألماني
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'Deutscher Ausrufesatz / Emphase:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.exclamativeDe,
                            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // بطاقة القالب البنيوي والشروط الصرفية
                if (state.showStructuralFormula)
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
                              Icon(Icons.architecture_rounded, color: Colors.brown),
                              SizedBox(width: 8),
                              Text(
                                'القَالَبُ النَّحْوِيُّ وَضَوَابِطُ الصِّيَاغَةِ:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.brown,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('• الصيغة العربية: ${current.structuralFormulaAr}', style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 6),
                          Text('• الشروط والضوابط: ${current.grammaticalNotesAr}', style: const TextStyle(fontSize: 13, height: 1.4)),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text('• EN Formula: ${current.structuralFormulaEn}', style: const TextStyle(fontSize: 12)),
                                ),
                                const SizedBox(height: 4),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text('• DE Formel: ${current.structuralFormulaDe}', style: const TextStyle(fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // مؤشر الشدة الانفعالية والتوكيدية
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مُؤَشِّرُ الشِّدَّةِ التَّعْبِيرِيَّةِ وَالتَّوْكِيدِ: ${(current.expressiveIntensityScore * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: current.expressiveIntensityScore,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.amber.shade800),
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

  Widget _buildCategoryChip(ExclamativeCategory category, String label, ExclamativeCategory selected) {
    final isSelected = category == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.amber.shade200,
      onSelected: (_) => _controller.selectCategory(category),
    );
  }
}
