import 'package:flutter/material.dart';
import '../controllers/temporal_aspect_controller.dart';

class TemporalAspectScreen extends StatefulWidget {
  final TemporalAspectController? controller;

  const TemporalAspectScreen({super.key, this.controller});

  @override
  State<TemporalAspectScreen> createState() => _TemporalAspectScreenState();
}

class _TemporalAspectScreenState extends State<TemporalAspectScreen> {
  late final TemporalAspectController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TemporalAspectController();
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
        title: const Text('مُخْتَبَرُ الأَوْجُهِ الحَدَثِيَّةِ وَالتَّطَابُقِ الزَّمَنِيِّ'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange.shade900,
        foregroundColor: Colors.white,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // بطاقة اختيار نوع الوجه الحدثي
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'صِنْفُ الوَجْهِ الحَدَثِيِّ (Aktionsart & Aspectual Typology):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildCategoryChip(
                            AspectualCategory.telicVsAtelic,
                            'تَامٌّ غَائِيٌّ (Telic)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            AspectualCategory.habitualIterative,
                            'عَادِيٌّ مُتَكَرِّرٌ (Habitual)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            AspectualCategory.inchoativeIngressive,
                            'شُرُوعٌ وَابْتِدَاءٌ (Ingressive)',
                            state.selectedCategory,
                          ),
                          _buildCategoryChip(
                            AspectualCategory.anterioritySequence,
                            'أَسْبَقِيَّةٌ زَمَنِيَّةٌ (Anteriority)',
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
                // بطاقة الشاهد الزمني الثلاثي
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  color: Colors.deepOrange.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.schedule_rounded, color: Colors.deepOrange),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                current.titleAr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.deepOrange.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),

                        // الشاهد العربي
                        const Text(
                          'الصِّيَاغَةُ العَرَبِيَّةُ الضَّابِطَةُ لِلْوَجْهِ الحَدَثِيِّ:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
                        ),
                        const SizedBox(height: 4),
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
                            'English Aspectual Counterpart:',
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
                            'Deutsche Aktionsart-Konstruktion:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
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

                // بطاقة علامات الوجه الحدثي الموظفة
                if (state.showAspectualContrast)
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
                              Icon(Icons.timeline_rounded, color: Colors.teal),
                              SizedBox(width: 8),
                              Text(
                                'عَلَامَاتُ الوَجْهِ الحَدَثِيِّ وَالقَرَائِنُ الصَّرْفِيَّةُ:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('• القرينة العربية: ${current.aspectualMarkerAr}', style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• English Marker: ${current.aspectualMarkerEn}', style: const TextStyle(fontSize: 14)),
                          ),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• Deutscher Aspektmarker: ${current.aspectualMarkerDe}', style: const TextStyle(fontSize: 14)),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // بطاقة التحليل الصرفي والدلالي للمدى الحدثي
                if (state.showAktionsartTimeline)
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
                              Icon(Icons.hourglass_bottom_rounded, color: Colors.deepOrange),
                              SizedBox(width: 8),
                              Text(
                                'التَّحْلِيلُ الزَّمَنِيُّ لِمَسَارِ الحَدَثِ (Aktionsart):',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(current.aktionsartAnalysisAr, style: const TextStyle(fontSize: 14, height: 1.4)),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text('• EN Analysis: ${current.aktionsartAnalysisEn}', style: const TextStyle(fontSize: 12)),
                                ),
                                const SizedBox(height: 4),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text('• DE Analyse: ${current.aktionsartAnalysisDe}', style: const TextStyle(fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // مؤشر إنجاز الحدث والتطابق الزمني
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مُؤَشِّرُ انْقِضَاءِ الحَدَثِ وَتَمَامِهِ (Telic Completion Index): ${(current.completionPercentage * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: current.completionPercentage,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange.shade800),
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

  Widget _buildCategoryChip(AspectualCategory category, String label, AspectualCategory selected) {
    final isSelected = category == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.deepOrange.shade200,
      onSelected: (_) => _controller.selectCategory(category),
    );
  }
}
