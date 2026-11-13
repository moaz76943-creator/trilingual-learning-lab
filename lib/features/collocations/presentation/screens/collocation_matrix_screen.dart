import 'package:flutter/material.dart';
import '../controllers/collocation_matrix_controller.dart';

class CollocationMatrixScreen extends StatefulWidget {
  final CollocationMatrixController? controller;

  const CollocationMatrixScreen({super.key, this.controller});

  @override
  State<CollocationMatrixScreen> createState() => _CollocationMatrixScreenState();
}

class _CollocationMatrixScreenState extends State<CollocationMatrixScreen> {
  late final CollocationMatrixController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? CollocationMatrixController();
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
    final current = state.currentEntry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('مُخْتَبَرُ التَّلَازُمِ اللَّفْظِيِّ وَالتَّضَامِّ المُعْجَمِيِّ'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade800,
        foregroundColor: Colors.white,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // اختيار صنف المتلازمة المعجمية
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'صِنْفُ التَّلَازُمِ اللَّفْظِيِّ (Collocation Typology):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildCategoryChip(
                            CollocationCategory.adjectiveNoun,
                            'صِفَةٌ وَمَوْصُوفٌ (Adj + Noun)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            CollocationCategory.verbNounSupport,
                            'فِعْلٌ إِسْنَادِيٌّ (Support Verb)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            CollocationCategory.verbPrepositional,
                            'فِعْلٌ وَجَارٌّ (Prepositional)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            CollocationCategory.adverbialIntensifier,
                            'ظَرْفٌ مُؤَكِّدٌ (Adv + Verb)',
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
                // بطاقة المقارنة الثلاثية للمتلازمة الفصيحة
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  color: Colors.blueGrey.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.hub_outlined, color: Colors.blueGrey),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                current.baseConcept,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.blueGrey.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),

                        // المتلازمة العربية الصحيحة
                        const Text(
                          'المُتَلَازِمَةُ العَرَبِيَّةُ الأَصِيلَةُ:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.canonicalCollocationAr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Amiri',
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // المتلازمة الإنجليزية
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'English Canonical Collocation:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.canonicalCollocationEn,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.indigo),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // المتلازمة الألمانية
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'Deutsche Feste Wortverbindung:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.canonicalCollocationDe,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.brown),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // بطاقة التحذير من التداخل السلبي والترجمة الحرفية المعيبة
                if (state.showNegativeTransferAlerts)
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    color: Colors.red.shade50,
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
                                'تَحْذِيرٌ مِنَ التَّدَاخُلِ اللُّغَوِيِّ السَّلْبِيِّ (Negative Transfer):',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('• الخطأ الشائع بالعربية: ${current.literalMisleadingAr}', style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• False Calque (EN): ${current.literalMisleadingEn}', style: const TextStyle(fontSize: 14)),
                          ),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• Unüblich (DE): ${current.literalMisleadingDe}', style: const TextStyle(fontSize: 14)),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // الشواهد الحية وسياقات التضام (Concordance Examples)
                if (state.showCorpusConcordance)
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
                              Icon(Icons.format_quote_rounded, color: Colors.blueGrey),
                              SizedBox(width: 8),
                              Text(
                                'شَوَاهِدُ التَّوَارُدِ السِّيَاقِيِّ فِي المَدَوَّنَاتِ:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(current.contextualExampleAr, style: const TextStyle(fontSize: 15, height: 1.4)),
                          const SizedBox(height: 6),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(current.contextualExampleEn, style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                          ),
                          const SizedBox(height: 6),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(current.contextualExampleDe, style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // مؤشر قوة الارتباط الإحصائي PMI
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مِقْيَاسُ قُوَّةِ التَّلَازُمِ الإِحْصَائِيِّ (PMI Score): ${current.mutualInformationScore} / 10.0',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: current.mutualInformationScore / 10.0,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey.shade700),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          current.linguisticRationaleAr,
                          style: const TextStyle(fontSize: 14, height: 1.4),
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

  Widget _buildCategoryChip(CollocationCategory category, String label, CollocationCategory selected) {
    final isSelected = category == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.blueGrey.shade200,
      onSelected: (_) => _controller.selectCategory(category),
    );
  }
}
