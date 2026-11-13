import 'package:flutter/material.dart';
import '../controllers/numerical_agreement_controller.dart';

class NumericalAgreementScreen extends StatefulWidget {
  final NumericalAgreementController? controller;

  const NumericalAgreementScreen({super.key, this.controller});

  @override
  State<NumericalAgreementScreen> createState() => _NumericalAgreementScreenState();
}

class _NumericalAgreementScreenState extends State<NumericalAgreementScreen> {
  late final NumericalAgreementController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? NumericalAgreementController();
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
        title: const Text('مُخْتَبَرُ أَحْكَامِ العَدَدِ وَالمَعْدُودِ وَالمُطَابَقَةِ'),
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
              // بطاقة اختيار تصنيف القاعدة العددية
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'بَابُ العَدَدِ وَالمُطَابَقَةِ الكَمِّيَّةِ (Quantification Typology):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildCategoryChip(
                            QuantificationCategory.inverseAgreement3to10,
                            'المُخَالَفَةُ (٣ - ١٠)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            QuantificationCategory.compoundTeens11to19,
                            'المُرَكَّبُ (١١ - ١٩)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            QuantificationCategory.partitiveMeasureUnits,
                            'المَقَادِيرُ وَغَيْرُ المَعْدُودِ',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            QuantificationCategory.vagueQuantifiers,
                            'كِنَايَاتُ العَدَدِ (كَمْ/بِضْعٌ)',
                            state.selectedCategory,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // محاكي التطابق العددي التفاعلي المباشر
              Card(
                elevation: 3,
                color: Colors.amber.shade50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'المُحَاكِي التَّفَاعُلِيُّ لِلْمُطَابَقَةِ وَالإِعْرَابِ:',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.brown),
                          ),
                          Switch(
                            value: state.isFeminineCountedNoun,
                            activeColor: Colors.teal,
                            onChanged: (_) => _controller.toggleCountedNounGender(),
                          ),
                        ],
                      ),
                      Text(
                        'جِنْسُ المَعْدُودِ: ${state.isFeminineCountedNoun ? "مُؤَنَّثٌ (آيَةٌ)" : "مُذَكَّرٌ (كِتَابٌ)"}  |  العَدَدُ: ${state.interactiveCount}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      Slider(
                        value: state.interactiveCount.toDouble(),
                        min: 3,
                        max: 19,
                        divisions: 16,
                        activeColor: Colors.teal.shade700,
                        label: '${state.interactiveCount}',
                        onChanged: (val) => _controller.updateInteractiveCount(val.round()),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.amber.shade300),
                        ),
                        child: Text(
                          state.dynamicArabicPreview,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Amiri',
                            color: Colors.teal,
                          ),
                        ),
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
                            const Icon(Icons.calculate_outlined, color: Colors.teal),
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

                        // المثال العربي
                        const Text(
                          'الشَّاهِدُ العَرَبِيُّ المَضْبُوطُ:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.expressionAr,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Amiri'),
                        ),
                        const SizedBox(height: 12),

                        // المقابل الإنجليزي
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'English Quantification Parallel:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.expressionEn,
                            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // المقابل الألماني
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'Deutsche Quantifizierungsstruktur:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.expressionDe,
                            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // بطاقة الضوابط النحوية في اللغات الثلاث
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
                              'القَاعِدَةُ النَّحْوِيَّةُ الحَاكِمَةُ:',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(current.grammaticalRuleAr, style: const TextStyle(fontSize: 14, height: 1.4)),
                        const SizedBox(height: 8),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text('• EN Rule: ${current.grammaticalRuleEn}', style: const TextStyle(fontSize: 12)),
                        ),
                        const SizedBox(height: 4),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text('• DE Regel: ${current.grammaticalRuleDe}', style: const TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // بطاقة الأخطاء الشائعة والتحذير من اللحن
                if (state.showCommonPitfalls)
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
                              Icon(Icons.error_outline, color: Colors.redAccent),
                              SizedBox(width: 8),
                              Text(
                                'مَزَالِقُ اللَّحْنِ وَالأَخْطَاءُ الشَّائِعَةُ (Pitfalls):',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.redAccent),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('• في العربية: ${current.commonPitfallAr}', style: const TextStyle(fontSize: 13)),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• EN Pitfall: ${current.commonPitfallEn}', style: const TextStyle(fontSize: 12)),
                          ),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• DE Fehlerquelle: ${current.commonPitfallDe}', style: const TextStyle(fontSize: 12)),
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

  Widget _buildCategoryChip(QuantificationCategory category, String label, QuantificationCategory selected) {
    final isSelected = category == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.teal.shade200,
      onSelected: (_) => _controller.selectCategory(category),
    );
  }
}
