import 'package:flutter/material.dart';
import '../controllers/proverbial_wisdom_controller.dart';

class ProverbialWisdomScreen extends StatefulWidget {
  final ProverbialWisdomController? controller;

  const ProverbialWisdomScreen({super.key, this.controller});

  @override
  State<ProverbialWisdomScreen> createState() => _ProverbialWisdomScreenState();
}

class _ProverbialWisdomScreenState extends State<ProverbialWisdomScreen> {
  late final ProverbialWisdomController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ProverbialWisdomController();
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
        title: const Text('مُخْتَبَرُ أَمْثَالِ الشُّعُوبِ وَالتَّكَافُؤِ الحِكْمِيِّ'),
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
              // بطاقة اختيار المحور الحكمي والموضوعي
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'المِحْوَرُ الحِكْمِيُّ وَالقِيَمِيُّ (Paremiological Theme):',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildThemeChip(
                            WisdomTheme.patiencePerseverance,
                            'الصَّبْرُ وَالمُثَابَرَةُ (Patience)',
                            state.selectedTheme,
                          ),
                          _buildThemeChip(
                            WisdomTheme.justiceRetribution,
                            'عَاقِبَةُ المَكْرِ (Justice)',
                            state.selectedTheme,
                          ),
                          _buildThemeChip(
                            WisdomTheme.adversityBenefit,
                            'المِنْحَةُ فِي المِحْنَةِ (Silver Lining)',
                            state.selectedTheme,
                          ),
                          _buildThemeChip(
                            WisdomTheme.cautionHumility,
                            'التَّوَاضُعُ وَالحَذَرُ (Humility)',
                            state.selectedTheme,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              if (current != null) ...[
                // بطاقة المثل العربي ومقابلاته اللغوية
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
                            const Icon(Icons.menu_book, color: Colors.brown),
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

                        // المثل العربي الفصيح
                        const Text(
                          'المَثَلُ العَرَبِيُّ الأَصِيلُ:',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current.canonicalProverbAr,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Amiri',
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // المقابل الإنجليزي الحِكمي
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'English Proverbial Equivalent:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.canonicalProverbEn,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // المقابل الألماني الحِكمي
                        const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            'Deutsches Sprichwort-Äquivalent:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            current.canonicalProverbDe,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // بطاقة التفكيك: المعنى الحرفي مقابل المغزى الحكيم
                if (state.showLiteralVsFigurative)
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
                              Icon(Icons.compare_arrows_rounded, color: Colors.teal),
                              SizedBox(width: 8),
                              Text(
                                'التَّفْكِيكُ: المَعْنَى الحَرْفِيُّ مُقَابِلَ الجَوْهَرِ الحِكْمِيِّ:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('• الشَّرْحُ اللَّفْظِيُّ: ${current.literalMeaningAr}', style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.teal.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'جَوْهَرُ الحِكْمَةِ العَالَمِيَّةِ: ${current.universalWisdomAr}',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // بطاقة الشاهد والمضرب والمورد
                if (state.showCulturalOrigins)
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
                              Icon(Icons.history_edu, color: Colors.brown),
                              SizedBox(width: 8),
                              Text(
                                'مَوْرِدُ المَثَلِ وَمَضْرِبُهُ السِّيَاقِيُّ:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.brown,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(current.culturalOriginAr, style: const TextStyle(fontSize: 14, height: 1.4)),
                          const SizedBox(height: 8),
                          const Text(
                            'مِثَالٌ عَلَى التَّوْظِيفِ السِّيَاقِيِّ الرَّفِيعِ:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            current.contextualExampleAr,
                            style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic, fontFamily: 'Amiri'),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // مؤشر التكافؤ الحكمي
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مُؤَشِّرُ التَّكَافُؤِ الحِكْمِيِّ الثُّلاثِيِّ: ${(current.paremiologicalEquivalence * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: current.paremiologicalEquivalence,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.brown.shade700),
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

  Widget _buildThemeChip(WisdomTheme theme, String label, WisdomTheme selected) {
    final isSelected = theme == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.brown.shade200,
      onSelected: (_) => _controller.selectTheme(theme),
    );
  }
}
