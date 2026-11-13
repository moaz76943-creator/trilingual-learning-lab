import 'package:flutter/material.dart';
import '../controllers/pragmatic_register_controller.dart';

class PragmaticRegisterScreen extends StatefulWidget {
  final PragmaticRegisterController? controller;

  const PragmaticRegisterScreen({super.key, this.controller});

  @override
  State<PragmaticRegisterScreen> createState() => _PragmaticRegisterScreenState();
}

class _PragmaticRegisterScreenState extends State<PragmaticRegisterScreen> {
  late final PragmaticRegisterController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? PragmaticRegisterController();
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
        title: const Text('مُخْتَبَرُ السِّيَاقَاتِ التَّخَاطُبِيَّةِ وَأَدَبِ الحِوَارِ'),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // بطاقة اختيار مستوى الخطاب
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'مُسْتَوَى المَقَامِ وَالخِطَابِ الاجْتِمَاعِيِّ:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildLevelChip(
                            PragmaticRegisterLevel.diwanicFormal,
                            'رَسْمِيٌّ مُبَجَّلٌ (Diwanic)',
                            state.selectedLevel,
                          ),
                          _buildLevelChip(
                            PragmaticRegisterLevel.academicScholarly,
                            'أَكَادِيمِيٌّ رَصِينٌ (Scholarly)',
                            state.selectedLevel,
                          ),
                          _buildLevelChip(
                            PragmaticRegisterLevel.professionalCorporate,
                            'مِهْنِيٌّ تَنْفِيذِيٌّ (Corporate)',
                            state.selectedLevel,
                          ),
                          _buildLevelChip(
                            PragmaticRegisterLevel.familiarSolidarity,
                            'أَخَوِيٌّ تَرَاحُمِيٌّ (Solidarity)',
                            state.selectedLevel,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              if (current != null) ...[
                // بطاقة الشاهد الخطابي الثلاثي
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  color: Colors.indigo.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.forum_outlined, color: Colors.indigo),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                current.titleAr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.indigo.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),

                        // الصيغة العربية
                        const Text(
                          'الصِّيغَةُ العَرَبِيَّةُ الفَصِيحَةُ (أَدَبُ التَّخَاطُبِ):',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.utteranceAr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Amiri',
                          ),
                        ),
                        const SizedBox(height: 12),

                        // الصيغة الإنجليزية
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'English Pragmatic Counterpart:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.utteranceEn,
                            style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // الصيغة الألمانية
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'Deutsches Höflichkeitsäquivalent:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.utteranceDe,
                            style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // أدوات التلطيف والتهذيب اللفظي
                if (state.showMitigationMarkers)
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
                              Icon(Icons.verified, color: Colors.teal),
                              SizedBox(width: 8),
                              Text(
                                'أَدَوَاتُ التَّلْطِيفِ وَالمُجَامَلَةِ المَرْصُودَةِ:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('• العربي: ${current.politenessMarkerAr}', style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• English: ${current.politenessMarkerEn}', style: const TextStyle(fontSize: 14)),
                          ),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text('• Deutsch: ${current.politenessMarkerDe}', style: const TextStyle(fontSize: 14)),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // التحليل التداولي ومؤشر صون ماء الوجه
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مُؤَشِّرُ صَوْنِ الكَرَامَةِ وَمَاءِ الوَجْهِ (Face-Saving Metric): ${(current.faceSavingScore * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: current.faceSavingScore,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo.shade600),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          current.pragmaticAnalysisAr,
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

  Widget _buildLevelChip(PragmaticRegisterLevel level, String label, PragmaticRegisterLevel selected) {
    final isSelected = level == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.indigo.shade200,
      onSelected: (_) => _controller.selectLevel(level),
    );
  }
}
