import 'package:flutter/material.dart';

class WordPair {
  final String arabic;
  final String translation;
  const WordPair({required this.arabic, required this.translation});
}

class WordMatchingQuizWidget extends StatefulWidget {
  final List<WordPair> pairs;
  final VoidCallback? onAllMatched;

  const WordMatchingQuizWidget({super.key, required this.pairs, this.onAllMatched});

  @override
  State<WordMatchingQuizWidget> createState() => _WordMatchingQuizWidgetState();
}

class _WordMatchingQuizWidgetState extends State<WordMatchingQuizWidget> {
  String? _selectedArabic;
  final Set<String> _matchedArabic = {};

  void _onArabicTap(String ar) {
    if (_matchedArabic.contains(ar)) return;
    setState(() => _selectedArabic = ar);
  }

  void _onTranslationTap(String tr) {
    if (_selectedArabic == null) return;
    final pair = widget.pairs.firstWhere((p) => p.arabic == _selectedArabic);
    if (pair.translation == tr) {
      setState(() {
        _matchedArabic.add(_selectedArabic!);
        _selectedArabic = null;
      });
      if (_matchedArabic.length == widget.pairs.length) {
        widget.onAllMatched?.call();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حاول مرة أخرى'), duration: Duration(milliseconds: 600)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Wrap(
            spacing: 8,
            children: widget.pairs.map((p) {
              final isMatched = _matchedArabic.contains(p.arabic);
              final isSelected = _selectedArabic == p.arabic;
              return ChoiceChip(
                label: Text(p.arabic),
                selected: isSelected,
                onSelected: isMatched ? null : (_) => _onArabicTap(p.arabic),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: widget.pairs.map((p) {
              return ActionChip(
                label: Text(p.translation),
                onPressed: () => _onTranslationTap(p.translation),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
