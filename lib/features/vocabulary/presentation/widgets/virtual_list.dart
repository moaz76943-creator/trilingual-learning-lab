import 'package:flutter/material.dart';

/// قائمة افتراضية فائقة الأداء تعتمد على RepaintBoundary لمنع إجهاد معالج الرسوميات
class VirtualizedVocabList<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final double? itemExtent;
  final ScrollController? controller;

  const VirtualizedVocabList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.itemExtent,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: items.length,
      itemExtent: itemExtent,
      physics: const BouncingScrollPhysics(),
      addRepaintBoundaries: true,
      cacheExtent: 300.0,
      itemBuilder: (context, index) {
        return RepaintBoundary(
          child: itemBuilder(context, items[index], index),
        );
      },
    );
  }
}
