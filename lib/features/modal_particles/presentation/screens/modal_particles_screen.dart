import 'package:flutter/material.dart';
import '../controllers/modal_particles_controller.dart';

class ModalParticlesScreen extends StatefulWidget {
  final ModalParticlesController? controller;

  const ModalParticlesScreen({super.key, this.controller});

  @override
  State<ModalParticlesScreen> createState() => _ModalParticlesScreenState();
}

class _ModalParticlesScreenState extends State<ModalParticlesScreen> {
  late final ModalParticlesController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ModalParticlesController();
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
        title: const Text('مُخْتَبَرُ أَحْرُفِ المَعَانِي وَالمَحَطَّاتِ التَّدَاوُلِيَّةِ'),
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
              // بطاقة اختيار الوظيفة التداولية لحرف المعنى
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'الوِجْهَةُ التَّدَاوُلِيَّةُ لِحَرْفِ المَعْنَى (Pragmatic Stance):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildFunctionChip(
                            ParticleFunction.sharedPresupposition,
                            'تَذْكِيرٌ بِالمُسَلَّمَاتِ (ja)',
                            state.selectedFunction,
                          ),
                          _buildFunctionChip(
                            ParticleFunction.contradictionEmphasis,
                            'دَفْعُ التَّرَدُّدِ (doch)',
                            state.selectedFunction,
                          ),
                          _buildFunctionChip(
                            ParticleFunction.softenedUrgency,
                            'تَلْطِيفُ الأَمْرِ (mal)',
                            state.selectedFunction,
                          ),
                          _buildFunctionChip(
                            ParticleFunction.inevitableResignation,
                            'التَّسْلِيمُ بِالوَاقِعِ (halt/eben)',
                            state.selectedFunction,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              if (current != null) ...[
                // بطاقة المقارنة بين التعبير الجاف والتعبير المطعَّم بأحرف المعاني
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
                            const Icon(Icons.forum_outlined, color: Colors.deepOrange),
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

                        // الجملة الجافة الخالية من اللباقة الوجدانية
                        const Text(
                          'الصِّيَاغَةُ الجَافَّةُ غَيْرُ المُطَعَّمَةِ (Bare Utterance - بَارِدَةٌ شُعُورِيّاً):',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(current.bareSentenceAr, style: const TextStyle(fontSize: 15, color: Colors.black87)),
                        const SizedBox(height: 12),

                        // الجملة المطعمة بحرف المعنى الفصيح
                        const Text(
                          'الصِّيَاغَةُ المُفْعَمَةُ بِأَدَبِ البَيَانِ وَحُرُوفِ المَعَانِي:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.flavoredSentenceAr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Amiri',
                            color: Colors.brown,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // المقابل الإنجليزي المعبر
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'English Pragmatic Equivalence:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.flavoredSentenceEn,
                            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // المقابل الألماني بمطابقات Modalpartikeln
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'Deutsche Modalpartikel-Konstruktion:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.flavoredSentenceDe,
                            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // بطاقة أدوات التنبيه وحروف المعاني الموظفة
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
                            Icon(Icons.grain, color: Colors.amber),
                            SizedBox(width: 8),
                            Text(
                              'أَدَوَاتُ التَّلْطِيفِ وَأَحْرُفُ المَعَانِي المَوْظُوفَةِ:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.brown,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('• في اللسان العربي: ${current.particleAr}', style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 4),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text('• English Stance: ${current.particleEn}', style: const TextStyle(fontSize: 14)),
                        ),
                        const SizedBox(height: 4),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text('• Deutsche Partikel: ${current.particleDe}', style: const TextStyle(fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // التحليل التداولي ومؤشر الدفء التواصلي
                if (state.showAbtönungTips)
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
                              Icon(Icons.psychology, color: Colors.deepOrange),
                              SizedBox(width: 8),
                              Text(
                                'التَّحْلِيلُ التَّدَاوُلِيُّ وَالأَثَرُ النَّفْسِيُّ:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(current.pragmaticAnalysisAr, style: const TextStyle(fontSize: 14, height: 1.4)),
                          const SizedBox(height: 10),
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
                                  child: Text('• EN Analysis: ${current.pragmaticAnalysisEn}', style: const TextStyle(fontSize: 12)),
                                ),
                                const SizedBox(height: 4),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text('• DE Analyse: ${current.pragmaticAnalysisDe}', style: const TextStyle(fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // مؤشر الدفء التواصلي
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مُؤَشِّرُ الدِّفْءِ التَّوَاصُلِيِّ وَاللَّبَاقَةِ (Communicative Warmth): ${(current.emotionalWarmthIndex * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: current.emotionalWarmthIndex,
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

  Widget _buildFunctionChip(ParticleFunction func, String label, ParticleFunction selected) {
    final isSelected = func == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.amber.shade200,
      onSelected: (_) => _controller.selectFunction(func),
    );
  }
}
