import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/concept.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String categoryName;
  final List<Concept> concepts;
  final String targetLang;

  const CategoryDetailScreen({
    super.key,
    required this.categoryName,
    required this.concepts,
    required this.targetLang,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(categoryName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF0F172A),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: concepts.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final c = concepts[index];
          return _buildWordCard(c);
        },
      ),
    );
  }

  Widget _buildWordCard(Concept c) {
    final bool isGerman = targetLang == 'de';
    final String targetWord = isGerman ? '${c.de.article}${c.de.word}' : c.en.word;
    final String targetPlural = isGerman ? c.de.plural : c.en.plural;
    final String targetExample = isGerman ? c.de.example : c.en.example;

    // تلوين خفيف لأدوات التعريف الألمانية (der=أزرق، die=وردي، das=أخضر)
    Color articleColor = const Color(0xFF0284C7);
    if (isGerman) {
      if (c.de.article.toLowerCase() == 'die') articleColor = const Color(0xFFBE185D);
      if (c.de.article.toLowerCase() == 'das') articleColor = const Color(0xFF15803D);
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عرض صورة SVG المدمجة محلياً
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 64,
              height: 64,
              child: SvgPicture.asset(
                'content/assets/svg/${c.imageId}.svg',
                fit: BoxFit.cover,
                placeholderBuilder: (_) => Container(color: const Color(0xFFF1F5F9)),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // بيانات الكلمة
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الكلمة باللغة المستهدفة
                Text(
                  targetWord,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: isGerman ? articleColor : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                // الكلمة بالعربية مع التشكيل
                Text(
                  c.ar.vocalized,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontSize: 16, color: Color(0xFF334155), fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                // صيغة الجمع
                if (targetPlural.isNotEmpty)
                  Text(
                    'Plural: $targetPlural • جمع: ${c.ar.plural}',
                    style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                  ),
                const SizedBox(height: 6),
                // مثال توضيحي
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(6)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(targetExample, style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                      Text(c.ar.example, textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 12, color: Color(0xFF475569))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
