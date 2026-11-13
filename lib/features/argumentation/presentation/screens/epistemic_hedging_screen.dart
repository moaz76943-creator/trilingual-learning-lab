import 'package:flutter/material.dart';
import '../controllers/epistemic_hedging_controller.dart';

class EpistemicHedgingScreen extends StatefulWidget {
  final EpistemicHedgingController? controller;

  const EpistemicHedgingScreen({super.key, this.controller});

  @override
  State<EpistemicHedgingScreen> createState() => _EpistemicHedgingScreenState();
}

class _EpistemicHedgingScreenState extends State<EpistemicHedgingScreen> {
  late final EpistemicHedgingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? EpistemicHedgingController();
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
        title: const Text('مُخْتَبَرُ التَّمَاسُكِ الحِجَاجِيِّ وَالتَّسْيِيجِ المَعْرِفِيِّ'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade900,
        foregroundColor: Colors.white,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // بطاقة اختيار درجة الجزم والتحوط المعرفي
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'دَرَجَةُ الجَزْمِ وَالتَّحَوُّطِ المَعْرِفِيِّ (Epistemic Modality):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildCertaintyChip(
                            EpistemicCertaintyLevel.cautiousTentative,
                            'تَحَفُّظٌ وَتَسْيِيجٌ (Hedging)',
                            state.selectedCertainty,
                          ),
                          _buildCertaintyChip(
                            EpistemicCertaintyLevel.probabilisticStrong,
                            'تَرْجِيحٌ قَوِيٌّ (Probability)',
                            state.selectedCertainty,
                          ),
                          _buildCertaintyChip(
                            EpistemicCertaintyLevel.concessiveHypothetical,
                            'تَسْلِيمٌ جَدَلِيٌّ (Concession)',
                            state.selectedCertainty,
                          ),
                          _buildCertaintyChip(
                            EpistemicCertaintyLevel.apodicticCategorical,
                            'بُرْهَانٌ قَاطِعٌ (Apodictic)',
                            state.selectedCertainty,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              if (current != null) ...[
                // بطاقة المقارنة بين الإطلاق الجذافي والصياغة المحترزة
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
                            const Icon(Icons.psychology_alt_outlined, color: Colors.blueGrey),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                current.titleAr,
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

                        // الإطلاق الجزافي غير المحترز
                        const Text(
                          'الإِطْلَاقُ الجَزَافِيُّ (Unhedged Overclaiming - ضَعِيفٌ مَنْهَجِيّاً):',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.unhedgedAssertionAr,
                          style: const TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                        const SizedBox(height: 12),

                        // الصياغة الأكاديمية الرصينة المحترزة بالعربية
                        const Text(
                          'الصِّيَاغَةُ الأَكَادِيمِيَّةُ المُحْتَرِزَةُ (Scholarly Hedged):',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.scholarlyHedgingAr,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Amiri',
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // الصياغة الإنجليزية الرصينة
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'English Scholarly Hedging:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.scholarlyHedgingEn,
                            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // الصياغة الألمانية الرصينة
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'Deutsche Wissenschaftliche Einschränkung:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.scholarlyHedgingDe,
                            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // أدوات التحوط الموظفة
                if (state.showContrastiveMarkers)
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
                              Icon(Icons.shield_outlined, color: Colors.teal),
                              SizedBox(width: 8),
                              Text(
                                'أَدَوَاتُ التَّحَوُّطِ وَالتَّسْيِيجِ المَوْظُوفَةِ:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('• العربي: ${current.hedgingMarkerAr}', style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• English: ${current.hedgingMarkerEn}', style: const TextStyle(fontSize: 14)),
                          ),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• Deutsch: ${current.hedgingMarkerDe}', style: const TextStyle(fontSize: 14)),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // بطاقة بنية تولمين الحجاجية ومؤشر الرصانة المنهجية
                if (state.showToulminBreakdown)
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
                              Icon(Icons.account_tree_outlined, color: Colors.deepPurple),
                              SizedBox(width: 8),
                              Text(
                                'وَظِيفَةُ التَّسْيِيجِ فِي مَصْفُوفَةِ تُولْمِين (Toulmin Schema):',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(current.toulminFunctionAr, style: const TextStyle(fontSize: 14, height: 1.4)),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text('• EN Toulmin: ${current.toulminFunctionEn}', style: const TextStyle(fontSize: 12)),
                                ),
                                const SizedBox(height: 4),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text('• DE Toulmin: ${current.toulminFunctionDe}', style: const TextStyle(fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // مؤشر الرصانة والضبط المعرفي
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مُؤَشِّرُ الرَّصَانَةِ المَنْهَجِيَّةِ (Epistemic Rigor Score): ${(current.epistemicScore * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: current.epistemicScore,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey.shade800),
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

  Widget _buildCertaintyChip(EpistemicCertaintyLevel certainty, String label, EpistemicCertaintyLevel selected) {
    final isSelected = certainty == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.blueGrey.shade200,
      onSelected: (_) => _controller.selectCertainty(certainty),
    );
  }
}
