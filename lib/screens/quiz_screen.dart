import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/concept.dart';
import '../models/quiz_engine.dart';

class QuizScreen extends StatefulWidget {
  final List<Concept> concepts;
  final String targetLang;
  final String categoryTitle;

  const QuizScreen({
    super.key,
    required this.concepts,
    required this.targetLang,
    required this.categoryTitle,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<QuizQuestion> _questions;
  int _currentIndex = 0;
  int _score = 0;
  String? _selectedOption;
  bool _isAnswered = false;

  @override
  void initState() {
    super.initState();
    _questions = QuizEngine.generateSession(
      pool: widget.concepts,
      targetLang: widget.targetLang,
      count: 10,
    );
  }

  void _handleAnswer(String option) {
    if (_isAnswered) return;

    final currentQ = _questions[_currentIndex];
    final bool isCorrect = option == currentQ.correctAnswer;

    setState(() {
      _selectedOption = option;
      _isAnswered = true;
      if (isCorrect) _score++;
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _isAnswered = false;
      });
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('اكتمل الاختبار! 🎉', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('نتيجتك: $_score من ${_questions.length}', style: const TextStyle(fontSize: 20, color: Color(0xFF0284C7), fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(_score >= 7 ? 'أداء ممتاز، مفرداتك راسخة!' : 'تدريب جيد، أعد المحاولة لتثبيت المعاني.'),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // إغلاق الحوار
                Navigator.pop(context); // العودة للقائمة
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0284C7), foregroundColor: Colors.white),
              child: const Text('العودة للمفردات'),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('اختبار')),
        body: const Center(child: Text('لا توجد مفردات كافية لبدء الاختبار')),
      );
    }

    final currentQ = _questions[_currentIndex];
    final double progress = (_currentIndex + 1) / _questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text('اختبار: ${widget.categoryTitle}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF0F172A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // شريط التقدم
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: const Color(0xFFE2E8F0),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0284C7)),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'السؤال ${_currentIndex + 1} من ${_questions.length}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // بطاقة السؤال الرئيسية
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: 72,
                    height: 72,
                    child: SvgPicture.asset(
                      'content/assets/svg/${currentQ.targetConcept.imageId}.svg',
                      placeholderBuilder: (_) => const Icon(Icons.image, size: 40, color: Color(0xFFCBD5E1)),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    currentQ.questionText,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 6),
                  const Text('ما المعنى العربي الصحيح؟', style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // الخيارات الأربعة
            Expanded(
              child: ListView.separated(
                itemCount: currentQ.options.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, idx) {
                  final opt = currentQ.options[idx];
                  Color btnColor = Colors.white;
                  Color borderColor = const Color(0xFFE2E8F0);
                  Color textColor = const Color(0xFF1E293B);

                  if (_isAnswered) {
                    if (opt == currentQ.correctAnswer) {
                      btnColor = const Color(0xFFDCFCE7);
                      borderColor = const Color(0xFF22C55E);
                      textColor = const Color(0xFF15803D);
                    } else if (opt == _selectedOption) {
                      btnColor = const Color(0xFFFEE2E2);
                      borderColor = const Color(0xFFEF4444);
                      textColor = const Color(0xFFB91C1C);
                    }
                  }

                  return InkWell(
                    onTap: () => _handleAnswer(opt),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: btnColor,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: borderColor, width: 1.5),
                      ),
                      child: Text(
                        opt,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
                      ),
                    ),
                  );
                },
              ),
            ),

            // زر المتابعة بعد الإجابة
            if (_isAnswered)
              ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0284C7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(_currentIndex < _questions.length - 1 ? 'السؤال التالي ➔' : 'عرض النتيجة 🏁', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
          ],
        ),
      ),
    );
  }
}
