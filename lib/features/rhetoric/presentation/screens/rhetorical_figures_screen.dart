import 'package:flutter/material.dart';
import '../controllers/rhetorical_figures_controller.dart';

class RhetoricalFiguresScreen extends StatefulWidget {
  final RhetoricalFiguresController? controller;

  const RhetoricalFiguresScreen({super.key, this.controller});

  @override
  State<RhetoricalFiguresScreen> createState() => _RhetoricalFiguresScreenState();
}

class _RhetoricalFiguresScreenState extends State<RhetoricalFiguresScreen> {
  late final RhetoricalFiguresController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? RhetoricalFiguresController();
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
    final current = state.currentExample;

    return Scaffold(
      appBar: AppBar(
        title: const Text('مُخْتَبَرُ البَلاغَةِ وَالاسْتِعَارَاتِ الإِدْرَاكِيَّةِ'),
        centerTitle: true,
        backgroundColor: Colors.teal.shade800,
        foregroundColor: Colors.white,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // بطاقة اختيار المحور البلاغي
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'الفَنُّ البَلاغِيُّ وَالأُسْلُوبِيُّ:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildDomainChip(
                            RhetoricalDomain.metaphor,
                            'الاسْتِعَارَةُ وَالتَّشْبِيهُ (Metaphor)',
                            state.selectedDomain,
                          ),
                          _buildDomainChip(
                            RhetoricalDomain.chiasmusAntithesis,
                            'الطِّبَاقُ وَالمُقَابَلَةُ (Antithesis)',
                            state.selectedDomain,
                          ),
                          _buildDomainChip(
                            RhetoricalDomain.paronomasiaAssonance,
                            'الجِنَاسُ وَالسَّجْعُ (Paronomasia)',
                            state.selectedDomain,
                          ),
                          _buildDomainChip(
                            RhetoricalDomain.metonymyLitotes,
                            'الكِنَايَةُ وَالتَّهْوِينُ (Metonymy)',
                            state.selectedDomain,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              if (current != null) ...[
                // بطاقة الشاهد الأدبي باللغات الثلاث
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
                            const Icon(Icons.auto_stories, color: Colors.teal),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                current.deviceNameAr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),

                        // الشاهد العربي
                        const Text(
                          'الشَّاهِدُ البَلاغِيُّ العَرَبِيُّ:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.textAr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Amiri',
                          ),
                        ),
                        const SizedBox(height: 12),

                        // المقابل الإنجليزي
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'English Literary Parallel:',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.textEn,
                            style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // المقابل الألماني
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'Deutsches Stilmittel-Äquivalent:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.textDe,
                            style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // بطاقة التخطيط الإدراكي والاستعاري
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
                            Icon(Icons.psychology, color: Colors.deepPurple),
                            SizedBox(width: 8),
                            Text(
                              'التَّخْطِيطُ الإِدْرَاكِيُّ وَالتَّحْلِيلُ البَيَانِيُّ:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            current.conceptualMapping,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          current.explanationAr,
                          style: const TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // مؤشر الأثر الأسلوبي والجمالي
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مُؤَشِّرُ الأَثَرِ البَيَانِيِّ وَالجَمَالِيِّ: ${(state.stylisticImpactScore * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Slider(
                          value: state.stylisticImpactScore,
                          min: 0.1,
                          max: 1.0,
                          activeColor: Colors.teal,
                          onChanged: (val) => _controller.adjustStylisticImpact(val),
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

  Widget _buildDomainChip(RhetoricalDomain domain, String label, RhetoricalDomain selected) {
    final isSelected = domain == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.teal.shade200,
      onSelected: (_) => _controller.selectDomain(domain),
    );
  }
}
