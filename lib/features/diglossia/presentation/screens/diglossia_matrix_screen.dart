import 'package:flutter/material.dart';
import '../controllers/diglossia_matrix_controller.dart';

class DiglossiaMatrixScreen extends StatefulWidget {
  final DiglossiaMatrixController? controller;

  const DiglossiaMatrixScreen({super.key, this.controller});

  @override
  State<DiglossiaMatrixScreen> createState() => _DiglossiaMatrixScreenState();
}

class _DiglossiaMatrixScreenState extends State<DiglossiaMatrixScreen> {
  late final DiglossiaMatrixController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? DiglossiaMatrixController();
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
        title: const Text('مُخْتَبَرُ الازْدِوَاجِيَّةِ وَالتَّنَوُّعِ اللَّهَجِيِّ'),
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
              // بطاقة اختيار السياق المقامي والاجتماعي
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'السِّيَاقُ المَقَامِيُّ وَالاجْتِمَاعِيُّ (Situational Domain):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildContextChip(
                            SituationalContext.academicConference,
                            'مَحْفَلٌ أَكَادِيمِيٌّ (Academic)',
                            state.selectedContext,
                          ),
                          _buildContextChip(
                            SituationalContext.dailyMarketplace,
                            'مُعَامَلَاتٌ يَوْمِيَّةٌ (Marketplace)',
                            state.selectedContext,
                          ),
                          _buildContextChip(
                            SituationalContext.intimateFamilyHome,
                            'حِوَارٌ أُسَرِيٌّ (Family)',
                            state.selectedContext,
                          ),
                          _buildContextChip(
                            SituationalContext.diplomaticOfficial,
                            'خِطَابٌ دِبْلُومَاسِيٌّ (Diplomatic)',
                            state.selectedContext,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              if (current != null) ...[
                // بطاقة المقارنة بين الفصيح والمعياري مقابل الدارج التلقائي
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
                            const Icon(Icons.record_voice_over_outlined, color: Colors.teal),
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

                        // المستوى الفصيح العربي
                        const Text(
                          'اللِّسَانُ الفَصِيحُ المُنْضَبِطُ (High Standard Arabic):',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.standardFormalAr,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Amiri',
                          ),
                        ),
                        const SizedBox(height: 10),

                        // المستوى الدارج العربي الحي
                        const Text(
                          'التَّعْبِيرُ الدَّارِجُ الحَضَرِيُّ (Spoken Colloquial):',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.colloquialSpokenAr,
                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        const SizedBox(height: 12),

                        // المقارنة بالإنجليزية
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('English High Formal:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                            ],
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(current.standardFormalEn, style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                        ),
                        const SizedBox(height: 6),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text('English Colloquial: "${current.colloquialSpokenEn}"', style: const TextStyle(fontSize: 13, color: Colors.black87)),
                        ),
                        const SizedBox(height: 12),

                        // المقارنة بالألمانية
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Standarddeutsch (Hochdeutsch):', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                              Text(current.standardHochdeutschDe, style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                              const SizedBox(height: 4),
                              Text('Umgangssprachlich: "${current.umgangssprachlichDe}"', style: const TextStyle(fontSize: 13, color: Colors.black87)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // بطاقة القاعدة اللغوية الاجتماعية والملاءمة المقامية
                if (state.showPragmaticSuitability)
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
                              Icon(Icons.rule_folder_rounded, color: Colors.blueGrey),
                              SizedBox(width: 8),
                              Text(
                                'قَاعِدَةُ المُلَاءَمَةِ السِّيَاقِيَّةِ (Sociolinguistic Appropriateness):',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(current.sociolinguisticRuleAr, style: const TextStyle(fontSize: 14, height: 1.4)),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.teal.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text('• EN Rule: ${current.sociolinguisticRuleEn}', style: const TextStyle(fontSize: 12)),
                                ),
                                const SizedBox(height: 4),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text('• DE Regel: ${current.sociolinguisticRuleDe}', style: const TextStyle(fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // مؤشر الملاءمة المقامية
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مُؤَشِّرُ انْضِبَاطِ المَقَامِ اللُّغَوِيِّ (Appropriateness Index): ${(current.appropriatenessIndex * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: current.appropriatenessIndex,
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

  Widget _buildContextChip(SituationalContext context, String label, SituationalContext selected) {
    final isSelected = context == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.teal.shade200,
      onSelected: (_) => _controller.selectContext(context),
    );
  }
}
