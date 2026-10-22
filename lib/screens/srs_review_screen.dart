import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/concept.dart';
import '../repositories/srs_repository.dart';

class SRSReviewScreen extends StatefulWidget {
  final List<Concept> dueConcepts;
  final String targetLang;

  const SRSReviewScreen({
    super.key,
    required this.dueConcepts,
    required this.targetLang,
  });

  @override
  State<SRSReviewScreen> createState() => _SRSReviewScreenState();
}

class _SRSReviewScreenState extends State<SRSReviewScreen> {
  final SRSRepository _srsRepo = SRSRepository();
  int _currentIndex = 0;
  bool _isFlipped = false;
  int _reviewedCount = 0;

  @override
  void initState() {
    super.initState();
    _srsRepo.init('.');
  }

  void _submitGrade(int quality) {
    if (_currentIndex >= widget.dueConcepts.length) return;
    final current = widget.dueConcepts[_currentIndex];
    _srsRepo.recordReview(current.conceptId, quality, '.');

    setState(() {
      _reviewedCount++;
      _isFlipped = false;
      if (_currentIndex < widget.dueConcepts.length - 1) {
        _currentIndex++;
      } else {
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('أحسنت! اكتملت مراجعة اليوم 🧠🎉', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text('راجعت $_reviewedCount بطاقة بنجاح، وتمت جدولتها تلقائيًا في الذاكرة طويلة المدى.'),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () { Navigator.pop(context); Navigator.pop(context); },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0284C7), foregroundColor: Colors.white),
              child: const Text('العودة للرئيسية'),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dueConcepts.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('المراجعة الذكية')),
        body: const Center(child: Text('لا توجد بطاقات مستحقة للمراجعة حاليًا، رائع! 🌟')),
      );
    }

    final current = widget.dueConcepts[_currentIndex];
    final bool isGerman = widget.targetLang == 'de';
    final String targetWord = isGerman ? '${current.de.article} ${current.de.word}' : current.en.word;
    final double progress = (_currentIndex + 1) / widget.dueConcepts.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('المراجعة التباعدية (SM-2)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF0F172A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            LinearProgressIndicator(value: progress, minHeight: 6, backgroundColor: const Color(0xFFE2E8F0), valueColor: const AlwaysStoppedAnimation(Color(0xFF0284C7))),
            const SizedBox(height: 8),
            Text('بطاقة ${_currentIndex + 1} من ${widget.dueConcepts.length}', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // البطاقة التفاعلية القابلة للقلب
            Expanded(
              child: InkWell(
                onTap: () => setState(() => _isFlipped = !_isFlipped),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(width: 80, height: 80, child: SvgPicture.asset('content/assets/svg/${current.imageId}.svg', fit: BoxFit.cover)),
                      ),
                      const SizedBox(height: 18),
                      Text(targetWord, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                      const SizedBox(height: 8),
                      Text(isGerman ? current.de.plural : current.en.plural, style: const TextStyle(fontSize: 14, color: Color(0xFF64748B))),
                      const SizedBox(height: 16),
                      const Divider(color: Color(0xFFE2E8F0)),
                      const SizedBox(height: 12),

                      if (_isFlipped) ...[
                        Text(current.ar.vocalized, textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0284C7))),
                        const SizedBox(height: 6),
                        Text('جمع: ${current.ar.plural}', textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 14, color: Color(0xFF475569))),
                        const SizedBox(height: 10),
                        Text(isGerman ? current.de.example : current.en.example, style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
                        Text(current.ar.example, textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                      ] else ...[
                        const Icon(Icons.touch_app_outlined, color: Color(0xFF94A3B8), size: 28),
                        const SizedBox(height: 6),
                        const Text('انقر لقلب البطاقة وكشف المعنى', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
                      ]
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // أزرار التقييم الذكي (SM-2 Quality Buttons)
            if (_isFlipped)
              Row(
                children: [
                  _buildGradeButton('❌ أعد', const Color(0xFFEF4444), () => _submitGrade(1)),
                  const SizedBox(width: 8),
                  _buildGradeButton('⚠️ صعب', const Color(0xFFF59E0B), () => _submitGrade(3)),
                  const SizedBox(width: 8),
                  _buildGradeButton('✅ جيد', const Color(0xFF10B981), () => _submitGrade(4)),
                  const SizedBox(width: 8),
                  _buildGradeButton('🌟 سهل', const Color(0xFF0284C7), () => _submitGrade(5)),
                ],
              )
            else
              ElevatedButton(
                onPressed: () => setState(() => _isFlipped = true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0284C7),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('إظهار الجواب 👁', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeButton(String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
