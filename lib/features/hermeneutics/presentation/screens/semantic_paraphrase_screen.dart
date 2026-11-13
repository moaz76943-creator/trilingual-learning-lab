import 'package:flutter/material.dart';
import '../controllers/semantic_paraphrase_controller.dart';

class SemanticParaphraseScreen extends StatefulWidget {
  final SemanticParaphraseController? controller;

  const SemanticParaphraseScreen({super.key, this.controller});

  @override
  State<SemanticParaphraseScreen> createState() => _SemanticParaphraseScreenState();
}

class _SemanticParaphraseScreenState extends State<SemanticParaphraseScreen> {
  late final SemanticParaphraseController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? SemanticParaphraseController();
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
        title: const Text('مُخْتَبَرُ التَّأْوِيلِ وَالتَّرْجَمَةِ التَّفْسِيرِيَّةِ'),
        centerTitle: true,
        backgroundColor: Colors.brown.shade800,
        foregroundColor: Colors.white,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // اختيار نمط التكافؤ الترجمي والتفسيري
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'نَوْعُ التَّكَافُؤِ التَّأْوِيلِيِّ (Equivalence Paradigm):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildEquivalenceChip(
                            EquivalenceType.dynamicExegetical,
                            'تَفْسِيرِيٌّ دِينَامِيكِيٌّ (Dynamic)',
                            state.selectedEquivalence,
                          ),
                          _buildEquivalenceChip(
                            EquivalenceType.formalStructural,
                            'شَكْلِيٌّ بِنَائِيٌّ (Formal)',
                            state.selectedEquivalence,
                          ),
                          _buildEquivalenceChip(
                            EquivalenceType.conceptualVoid,
                            'فَجَوَاتٌ دَلالِيَّةٌ (Voids)',
                            state.selectedEquivalence,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              if (current != null) ...[
                // بطاقة الشاهد والمسألة الدلالية
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
                            const Icon(Icons.menu_book_rounded, color: Colors.brown),
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

                        // اللفظ والأصل
                        const Text(
                          'اللَّفْظُ وَالمَفْهُومُ الأَصِيلُ:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.originalTermAr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Amiri',
                          ),
                        ),
                        const SizedBox(height: 10),

                        // إعادة الصياغة التفسيرية بالعربية
                        const Text(
                          'إِعَادَةُ الصِّيَاغَةِ التَّفْسِيرِيَّةِ (Hermeneutic Exegesis):',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.exegeticalParaphraseAr,
                          style: const TextStyle(fontSize: 15, height: 1.4),
                        ),
                        const SizedBox(height: 12),

                        // المقابل الإنجليزي التفسيري
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'English Exegetical Paraphrase:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.exegeticalParaphraseEn,
                            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // المقابل الألماني التفسيري
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'Deutsche Hermeneutische Paraphrase:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.exegeticalParaphraseDe,
                            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // بطاقة الفروق الدقيقة (Nuance Breakdown)
                if (state.showNuanceBreakdown)
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
                              Icon(Icons.compare_arrows_rounded, color: Colors.deepOrange),
                              SizedBox(width: 8),
                              Text(
                                'تَفْكِيكُ الفُرُوقِ اللَّفْظِيَّةِ الدَّقِيقَةِ:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          for (final nuance in current.fineGrainNuancesAr)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text('• $nuance', style: const TextStyle(fontSize: 14)),
                            ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'تَنْبِيهُ التَّعْذِيرِ التَّرْجَمِيِّ: ${current.conceptualVoidExplanation}',
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // مؤشر الحفاظ على جوهر المعنى الدلالي
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مُؤَشِّرُ التَّطَابُقِ التَّأْوِيلِيِّ (Semantic Invariance): ${(current.semanticInvarianceScore * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: current.semanticInvarianceScore,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.brown.shade600),
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

  Widget _buildEquivalenceChip(EquivalenceType type, String label, EquivalenceType selected) {
    final isSelected = type == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.brown.shade200,
      onSelected: (_) => _controller.selectEquivalence(type),
    );
  }
}
