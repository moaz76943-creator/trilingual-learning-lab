import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/concept.dart';

class CategoryDetailScreen extends StatefulWidget {
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
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  // حالة الذاكرة المؤقتة التفاعلية للشاشة
  final Set<String> _favs = {};
  final Set<String> _learned = {};

  void _toggleFav(String id) {
    setState(() {
      if (_favs.contains(id)) _favs.remove(id);
      else _favs.add(id);
    });
  }

  void _toggleLearned(String id) {
    setState(() {
      if (_learned.contains(id)) _learned.remove(id);
      else _learned.add(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(widget.categoryName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF0F172A),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: widget.concepts.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final c = widget.concepts[index];
          final isFav = _favs.contains(c.conceptId);
          final isLearned = _learned.contains(c.conceptId);
          return _buildWordCard(c, isFav, isLearned);
        },
      ),
    );
  }

  Widget _buildWordCard(Concept c, bool isFav, bool isLearned) {
    final bool isGerman = widget.targetLang == 'de';
    final String targetWord = isGerman ? '${c.de.article}${c.de.word}' : c.en.word;
    final String targetPlural = isGerman ? c.de.plural : c.en.plural;
    final String targetExample = isGerman ? c.de.example : c.en.example;

    Color articleColor = const Color(0xFF0284C7);
    if (isGerman) {
      if (c.de.article.toLowerCase() == 'die') articleColor = const Color(0xFFBE185D);
      if (c.de.article.toLowerCase() == 'das') articleColor = const Color(0xFF15803D);
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isLearned ? const Color(0xFFF0FDF4) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isLearned ? const Color(0xFF86EFAC) : const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: SvgPicture.asset(
                    'content/assets/svg/${c.imageId}.svg',
                    fit: BoxFit.cover,
                    placeholderBuilder: (_) => Container(color: const Color(0xFFF1F5F9)),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      targetWord,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: isGerman ? articleColor : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      c.ar.vocalized,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(fontSize: 16, color: Color(0xFF334155), fontWeight: FontWeight.w600),
                    ),
                    if (targetPlural.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'Plural: $targetPlural • جمع: ${c.ar.plural}',
                          style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(isFav ? Icons.star : Icons.star_border, color: isFav ? const Color(0xFFEAB308) : const Color(0xFF94A3B8)),
                onPressed: () => _toggleFav(c.conceptId),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(targetExample, style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                      Text(c.ar.example, textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 12, color: Color(0xFF475569))),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _toggleLearned(c.conceptId),
                  icon: Icon(isLearned ? Icons.check_circle : Icons.check_circle_outline, size: 16, color: isLearned ? const Color(0xFF16A34A) : const Color(0xFF94A3B8)),
                  label: Text(isLearned ? 'أتقنتها' : 'تحديد كمتقنة', style: TextStyle(fontSize: 11, color: isLearned ? const Color(0xFF16A34A) : const Color(0xFF64748B))),
                  style: const ButtonStyle(visualDensity: VisualDensity.compact),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
