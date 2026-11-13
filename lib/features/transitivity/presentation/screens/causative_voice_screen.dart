import 'package:flutter/material.dart';
import '../controllers/causative_voice_controller.dart';

class CausativeVoiceScreen extends StatefulWidget {
  final CausativeVoiceController? controller;

  const CausativeVoiceScreen({super.key, this.controller});

  @override
  State<CausativeVoiceScreen> createState() => _CausativeVoiceScreenState();
}

class _CausativeVoiceScreenState extends State<CausativeVoiceScreen> {
  late final CausativeVoiceController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? CausativeVoiceController();
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
    final current = state.currentPair;

    return Scaffold(
      appBar: AppBar(
        title: const Text('مُخْتَبَرُ السَّبَبِيَّةِ وَالتَّعَدِّي وَالمُطَاوَعَةِ'),
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
              // بطاقة اختيار نمط التعدية والمطاوعة
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'نَمَطُ التَّعَدِّي وَالتَّحْوِيلِ الصَّرْفِيِّ (Transitivity Architecture):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildPatternChip(
                            TransitivityPattern.causativeDerivation,
                            'تَعْدِيَةُ اللَّازِمِ (Causative)',
                            state.selectedPattern,
                          ),
                          _buildPatternChip(
                            TransitivityPattern.inchoativeAnticausative,
                            'أَفْعَالُ المُطَاوَعَةِ (Inchoative)',
                            state.selectedPattern,
                          ),
                          _buildPatternChip(
                            TransitivityPattern.ergativeLabileShift,
                            'التَّنَاوُبُ الإِرْغَاتِيُّ (Ergative)',
                            state.selectedPattern,
                          ),
                          _buildPatternChip(
                            TransitivityPattern.passiveVoiceNuance,
                            'المَبْنِيُّ لِلْمَجْهُولِ (Passive)',
                            state.selectedPattern,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              if (current != null) ...[
                // بطاقة المقارنة بين الصيغتين الأساسية والمشتقة
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
                            const Icon(Icons.transform_rounded, color: Colors.teal),
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

                        // الصيغة الأولى (الأساسية / اللازمة / المعلومة)
                        const Text(
                          'الصِّيغَةُ الأُولَى (Base / Intransitive / Active):',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.intransitiveOrBaseAr,
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, fontFamily: 'Amiri'),
                        ),
                        const SizedBox(height: 10),

                        // الصيغة الثانية (المعداة / المطاوعة / المجهولة)
                        const Text(
                          'الصِّيغَةُ المُحَوَّلَةُ (Derived / Causative / Passive):',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.causativeOrDerivedAr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Amiri',
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // المقابل الإنجليزي المقارن
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'English Transitivity Pair:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('• 1: ${current.intransitiveOrBaseEn}', style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
                              Text('• 2: ${current.causativeOrDerivedEn}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        // المقابل الألماني المقارن
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'Deutsche Kausativ-Antikausativ-Alternanz:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('• 1: ${current.intransitiveOrBaseDe}', style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
                              Text('• 2: ${current.causativeOrDerivedDe}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // بطاقة الآلية الصرفية والنحوية
                if (state.showMorphologicalDerivation)
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
                              Icon(Icons.tune_rounded, color: Colors.teal),
                              SizedBox(width: 8),
                              Text(
                                'الآلِيَّةُ الصَّرْفِيَّةُ وَتَوْزِيعُ الأَدْوَارِ الدَّلَالِيَّةِ:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(current.morphologicalMechanismAr, style: const TextStyle(fontSize: 14, height: 1.4)),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.teal.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'تَوْزِيعُ الأَدْوَارِ الدَّلَالِيَّةِ: ${current.semanticRoleDistributionAr}',
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // بطاقة مقياس السعة الإسنادية والتعدي (Valency Score)
                if (state.showValencyAnalysis)
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'مِقْيَاسُ السَّعَةِ الإِسْنَادِيَّةِ وَالتَّعَدِّي (Valency Index): ${current.transitivityValencyScore} / 3.0',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          LinearProgressIndicator(
                            value: current.transitivityValencyScore / 3.0,
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

  Widget _buildPatternChip(TransitivityPattern pattern, String label, TransitivityPattern selected) {
    final isSelected = pattern == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.teal.shade200,
      onSelected: (_) => _controller.selectPattern(pattern),
    );
  }
}
