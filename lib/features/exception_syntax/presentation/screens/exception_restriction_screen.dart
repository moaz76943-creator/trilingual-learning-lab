import 'package:flutter/material.dart';
import '../controllers/exception_restriction_controller.dart';

class ExceptionRestrictionScreen extends StatefulWidget {
  final ExceptionRestrictionController? controller;

  const ExceptionRestrictionScreen({super.key, this.controller});

  @override
  State<ExceptionRestrictionScreen> createState() => _ExceptionRestrictionScreenState();
}

class _ExceptionRestrictionScreenState extends State<ExceptionRestrictionScreen> {
  late final ExceptionRestrictionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ExceptionRestrictionController();
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
        title: const Text('مُخْتَبَرُ أَسَالِيبِ الاسْتِثْنَاءِ وَالحَصْرِ وَالقَصْرِ'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade900,
        foregroundColor: Colors.white,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // بطاقة اختيار نوع الاستثناء
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'بَابُ الاسْتِثْنَاءِ وَالحَصْرِ (Exception Typology):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildTypologyChip(
                            ExceptionTypology.completeAffirmative,
                            'تَامٌّ مُثْبَتٌ (Obligatory)',
                            state.selectedTypology,
                          ),
                          _buildTypologyChip(
                            ExceptionTypology.completeNegative,
                            'تَامٌّ مَنْفِيٌّ (Appositive)',
                            state.selectedTypology,
                          ),
                          _buildTypologyChip(
                            ExceptionTypology.hollowedRestrictive,
                            'مُفَرَّغٌ لِلْقَصْرِ (Only / Nur)',
                            state.selectedTypology,
                          ),
                          _buildTypologyChip(
                            ExceptionTypology.nominalPrepositional,
                            'غَيْرُ وَسِوَى (Nominal)',
                            state.selectedTypology,
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
                  color: Colors.deepPurple.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.filter_list_alt, color: Colors.deepPurple),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                current.titleAr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.deepPurple.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),

                        // الجملة العربية
                        const Text(
                          'التَّرْكِيبُ الاسْتِثْنَائِيُّ الفَصِيحُ:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
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
                            'English Exception & Focus Parallel:',
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
                            'Deutsche Ausnahme- und Fokuskonstruktion:',
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

                // بطاقة تفكيك أركان الاستثناء
                if (state.showConstituentSplit)
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
                              Icon(Icons.account_tree_outlined, color: Colors.teal),
                              SizedBox(width: 8),
                              Text(
                                'أَرْكَانُ جُمْلَةِ الاسْتِثْنَاءِ وَإِعْرَابُهَا:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('• المُسْتَثْنَى مِنْهُ: ${current.mustathnaMinhuAr}', style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 4),
                          Text('• الأَدَاةُ الرَّابِطَةُ: ${current.exceptionMarkerAr}', style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 4),
                          Text('• المُسْتَثْنَى وَحُكْمُهُ: ${current.mustathnaAr}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                          const SizedBox(height: 8),
                          Text(current.syntacticRuleAr, style: const TextStyle(fontSize: 13, height: 1.4)),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // بطاقة التنبيه الدلالي ومزالق الترجمة
                if (state.showSemanticTraps)
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
                              Icon(Icons.lightbulb_outline, color: Colors.amber),
                              SizedBox(width: 8),
                              Text(
                                'تَنْبِيهَاتٌ دَلَالِيَّةٌ وَقَوَاعِدُ النَّقْلِ التَّرْجَمِيِّ:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.brown,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(current.semanticTrapNote, style: const TextStyle(fontSize: 13, height: 1.4, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• EN Rule: ${current.syntacticRuleEn}', style: const TextStyle(fontSize: 12)),
                          ),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• DE Regel: ${current.syntacticRuleDe}', style: const TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // مؤشر الدقة القصرية
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مُؤَشِّرُ الدِّقَّةِ القَصْرِيَّةِ وَالإِخْرَاجِ: ${(current.restrictivePrecisionScore * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: current.restrictivePrecisionScore,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple.shade700),
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

  Widget _buildTypologyChip(ExceptionTypology typology, String label, ExceptionTypology selected) {
    final isSelected = typology == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.deepPurple.shade200,
      onSelected: (_) => _controller.selectTypology(typology),
    );
  }
}
