import 'dart:math' as math;
import 'package:flutter/material.dart';

class TrilingualFlipCard extends StatefulWidget {
  final String arabic;
  final String german;
  final String english;
  final String? article; // der, die, das
  final VoidCallback? onPronounce;

  const TrilingualFlipCard({
    super.key,
    required this.arabic,
    required this.german,
    required this.english,
    this.article,
    this.onPronounce,
  });

  @override
  State<TrilingualFlipCard> createState() => _TrilingualFlipCardState();
}

class _TrilingualFlipCardState extends State<TrilingualFlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isBack = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flip() {
    if (_isBack) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    _isBack = !_isBack;
  }

  Color _getArticleColor() {
    switch (widget.article?.toLowerCase()) {
      case 'der': return Colors.blue.shade700;
      case 'die': return Colors.red.shade700;
      case 'das': return Colors.green.shade700;
      default: return Colors.teal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * math.pi;
          final isUnder = angle > (math.pi / 2);
          return Transform(
            transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(angle),
            alignment: Alignment.center,
            child: Container(
              height: 180,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _getArticleColor().withOpacity(0.3), width: 1.5),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: isUnder
                  ? Transform(
                      transform: Matrix4.identity()..rotateY(math.pi),
                      alignment: Alignment.center,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.german, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _getArticleColor())),
                            const SizedBox(height: 8),
                            Text(widget.english, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.arabic, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          if (widget.onPronounce != null)
                            IconButton(icon: const Icon(Icons.volume_up, color: Colors.teal), onPressed: widget.onPronounce),
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
