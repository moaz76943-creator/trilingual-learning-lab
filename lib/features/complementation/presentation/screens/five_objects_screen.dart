import 'package:flutter/material.dart';
import '../controllers/five_objects_controller.dart';

class FiveObjectsScreen extends StatefulWidget {
  final FiveObjectsController? controller;

  const FiveObjectsScreen({super.key, this.controller});

  @override
  State<FiveObjectsScreen> createState() => _FiveObjectsScreenState();
}

class _FiveObjectsScreenState extends State<FiveObjectsScreen> {
  late final FiveObjectsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FiveObjectsController();
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
        title: const Text('مُخْتَبَرُ المَفَاعِيلِ الخَمْسَةِ وَالمُتَمِّمَاتِ'),
        centerTitle: true,
        backgroundColor: Colors.brown.shade900,
        foregroundColor: Colors.white,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // بطاقة اختيار المفعول من المفاعيل الخمسة
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'أَبْوَابُ المَفَاعِيلِ الخَمْسَةِ فِي اللِّسَانِ العَرَبِيِّ:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildCategoryChip(
                            ComplementCategory.directObjectBihi,
                            'المَفْعُولُ بِهِ',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            ComplementCategory.absoluteCognateMutlaq,
                            'المَفْعُولُ المُطْلَقُ',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            ComplementCategory.causalPurposiveLiAjlihi,
                            'المَفْعُولُ لِأَجْلِهِ',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            ComplementCategory.comitativeMaahu,
                            'المَفْعُولُ مَعَهُ',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            ComplementCategory.locativeTemporalFihi,
                            'المَفْعُولُ فِيهِ (الظَّرْفُ)',
                            state.selectedCategory,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // بطاقة الشاهد الجامع للمفاعيل الخمسة معاً
              if (state.showUnifiedVerseDemo)
                Card(
                  elevation: 4,
                  color: Colors.amber.shade50,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.stars_rounded, color: Colors.amber),
                            SizedBox(width: 8),
                            Text(
                              'الجُمْلَةُ التَّعْلِيمِيَّةُ الجَامِعَةُ لِلْمَفَاعِيلِ الخَمْسَةِ مَعاً:',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.brown),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          FiveObjectsState.comprehensiveMasterSentenceAr,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Amiri',
                            color: Colors.brown,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            FiveObjectsState.comprehensiveMasterSentenceEn,
                            style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 12),

              if (current != null) ...[
                // بطاقة الشاهد التخصصي المفصل
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  color: Colors.brown.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.menu_book, color: Colors.brown),
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

                        // موضع الشاهد
                        Row(
                          children: [
                            const Text('المَوْضِعُ المَنْصُوبُ:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                            const SizedBox(width: 8),
                            Text(
                              current.complementWordAr,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                fontFamily: 'Amiri',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // الجملة العربية الكاملة
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
                            'English Adverbial / Object Equivalent:',
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
                            'Deutsche Entsprechung & Adverbialsyntax:',
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

                // بطاقة الإعراب والتحليل التركيبي
                if (state.showSyntacticParsing)
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
                              Icon(Icons.assignment_turned_in_outlined, color: Colors.teal),
                              SizedBox(width: 8),
                              Text(
                                'التَّوْجِيهُ الإِعْرَابِيُّ وَالتَّحْلِيلُ التَّدَاوُلِيُّ:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(current.syntacticRoleAr, style: const TextStyle(fontSize: 14, height: 1.4)),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.brown.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'فَائِدَةٌ بَيَانِيَّةٌ وَمُقَارَنَةٌ تَرْجَمِيَّةٌ: ${current.crossLinguisticTransferNote}',
                              style: const TextStyle(fontSize: 13, height: 1.4, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• EN Role: ${current.syntacticRoleEn}', style: const TextStyle(fontSize: 12)),
                          ),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• DE Funktion: ${current.syntacticRoleDe}', style: const TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // مؤشر الأهمية الدلالية
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مُؤَشِّرُ الأَهَمِّيَّةِ الإِسْنَادِيَّةِ وَالدَّلَالِيَّةِ: ${(current.semanticSalienceScore * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: current.semanticSalienceScore,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.brown.shade800),
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

  Widget _buildCategoryChip(ComplementCategory category, String label, ComplementCategory selected) {
    final isSelected = category == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.brown.shade200,
      onSelected: (_) => _controller.selectCategory(category),
    );
  }
}
