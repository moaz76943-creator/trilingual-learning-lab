import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/sentence_model.dart';

class SentenceBuilderScreen extends StatefulWidget {
  final String targetLang;
  const SentenceBuilderScreen({super.key, required this.targetLang});

  @override
  State<SentenceBuilderScreen> createState() => _SentenceBuilderScreenState();
}

class _SentenceBuilderScreenState extends State<SentenceBuilderScreen> {
  List<SentenceModel> _sentences = [];
  int _currentIndex = 0;
  bool _isLoading = true;

  List<String> _poolWords = [];
  final List<String> _selectedWords = [];
  bool? _isCorrect;

  @override
  void initState() {
    super.initState();
    _loadSentences();
  }

  Future<void> _loadSentences() async {
    try {
      final jsonString = await rootBundle.loadString('content/grammar/sentences_a1.json');
      final Map<String, dynamic> data = jsonDecode(jsonString);
      final List list = data['sentences'] ?? [];
      _sentences = list.map((i) => SentenceModel.fromJson(i)).toList();
      _initCurrentQuestion();
    } catch (_) {}
    if (mounted) setState(() => _isLoading = false);
  }

  void _initCurrentQuestion() {
    if (_sentences.isEmpty) return;
    final s = _sentences[_currentIndex];
    final original = widget.targetLang == 'de' ? s.tokensDe : s.tokensEn;
    _poolWords = List.from(original)..shuffle();
    _selectedWords.clear();
    _isCorrect = null;
  }

  void _selectWord(String word) {
    setState(() {
      _poolWords.remove(word);
      _selectedWords.add(word);
      _isCorrect = null;
    });
  }

  void _unselectWord(String word) {
    setState(() {
      _selectedWords.remove(word);
      _poolWords.add(word);
      _isCorrect = null;
    });
  }

  void _checkSolution() {
    final s = _sentences[_currentIndex];
    final targetFull = widget.targetLang == 'de' ? s.fullDe : s.fullEn;
    final userFull = _selectedWords.join(' ');

    setState(() {
      _isCorrect = userFull.trim() == targetFull.trim();
    });
  }

  void _nextSentence() {
    if (_currentIndex < _sentences.length - 1) {
      setState(() {
        _currentIndex++;
        _initCurrentQuestion();
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('أحسنت! 🏆', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('أتممت جميع تدريبات بناء الجمل بنجاح واكتسبت قواعد ترتيب الكلمات.'),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () { Navigator.pop(context); Navigator.pop(context); },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF059669), foregroundColor: Colors.white),
                child: const Text('العودة للرئيسية'),
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final current = _sentences[_currentIndex];
    final double progress = (_currentIndex + 1) / _sentences.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('تركيب وبناء الجمل (A1)', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF0F172A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(value: progress, minHeight: 6, backgroundColor: const Color(0xFFE2E8F0), valueColor: const AlwaysStoppedAnimation(Color(0xFF059669))),
            const SizedBox(height: 10),
            Text('الجملة ${_currentIndex + 1} من ${_sentences.length}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // الجملة العربية المستهدفة
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6)]),
              child: Column(
                children: [
                  const Text('رتّب الكلمات لتطابق المعنى:', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                  const SizedBox(height: 6),
                  Text(current.fullAr, textDirection: TextDirection.rtl, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // منطقة البناء (الكلمات المجمعة)
            Container(
              constraints: const BoxConstraints(minHeight: 80),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _isCorrect == true ? const Color(0xFFDCFCE7) : (_isCorrect == false ? const Color(0xFFFEE2E2) : Colors.white),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _isCorrect == true ? const Color(0xFF22C55E) : (_isCorrect == false ? const Color(0xFFEF4444) : const Color(0xFFCBD5E1)), width: 1.5),
              ),
              child: _selectedWords.isEmpty
                  ? const Center(child: Text('اضغط على الكلمات بالأسفل لتركيبها هنا بالترتيب', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13)))
                  : Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _selectedWords.map((w) {
                        return ActionChip(
                          label: Text(w, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFF059669)),
                          onPressed: () => _unselectWord(w),
                        );
                      }).toList(),
                    ),
            ),
            const SizedBox(height: 24),

            // بنك الكلمات المتاحة للاختيار
            const Text('بنك الكلمات المبعثرة:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _poolWords.map((w) {
                return ActionChip(
                  label: Text(w, style: const TextStyle(fontSize: 15)),
                  backgroundColor: const Color(0xFFF1F5F9),
                  onPressed: () => _selectWord(w),
                );
              }).toList(),
            ),
            const Spacer(),

            // أزرار التحقق والمتابعة
            if (_isCorrect == null)
              ElevatedButton(
                onPressed: _selectedWords.isNotEmpty ? _checkSolution : null,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF059669), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('تحقق من الترتيب الصحيح ✔', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              )
            else if (_isCorrect == true)
              ElevatedButton(
                onPressed: _nextSentence,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF16A34A), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('صحيح ممتاز! الجملة التالية ➔', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _initCurrentQuestion,
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      child: const Text('إعادة المحاولة ↺'),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
