import 'package:flutter/material.dart';
import '../../../../data/adapters/content_schema_adapter.dart';
import '../controllers/category_detail_controller.dart';

/// Full interactive category detail and vocabulary studio screen.
class CategoryDetailScreen extends StatefulWidget {
  final CategoryDetailController controller;
  final VoidCallback? onStartQuiz;

  const CategoryDetailScreen({
    super.key,
    required this.controller,
    this.onStartQuiz,
  });

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;
        final cat = ctrl.category;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: Text(
              cat.title.ar,
              style: const TextStyle(fontFamily: 'Amiri', fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(
                  ctrl.viewMode == CategoryViewMode.listView ? Icons.view_carousel : Icons.view_list,
                ),
                tooltip: ctrl.viewMode == CategoryViewMode.listView ? 'عَرْضُ البِطَاقَاتِ' : 'عَرْضُ القَائِمَةِ',
                onPressed: () {
                  ctrl.setViewMode(
                    ctrl.viewMode == CategoryViewMode.listView
                        ? CategoryViewMode.cardSwiper
                        : CategoryViewMode.listView,
                  );
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Category Header Banner
                _buildHeaderBanner(cat, ctrl),
                // Main Content Area (List vs Swiper)
                Expanded(
                  child: ctrl.viewMode == CategoryViewMode.listView
                      ? _buildListView(ctrl)
                      : _buildSwiperView(ctrl),
                ),
              ],
            ),
          ),
          floatingActionButton: widget.onStartQuiz != null
              ? FloatingActionButton.extended(
                  backgroundColor: const Color(0xFF0D9488),
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.quiz),
                  label: const Text('اخْتِبَارُ التَّصْنِيفِ (Quiz)'),
                  onPressed: widget.onStartQuiz,
                )
              : null,
        );
      },
    );
  }

  Widget _buildHeaderBanner(CanonicalCategory cat, CategoryDetailController ctrl) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: Text(
                  cat.level,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1D4ED8), fontSize: 13),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '${cat.title.de} • ${cat.title.en}',
                  style: const TextStyle(fontSize: 13, color: Color(0xFF475569), fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${ctrl.masteredCount}/${ctrl.totalItems} مُتْقَنٌ',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF059669)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: ctrl.masteryPercentage / 100.0,
            backgroundColor: const Color(0xFFE2E8F0),
            valueColor: const AlwaysStoppedAnimation(Color(0xFF0D9488)),
            minHeight: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildListView(CategoryDetailController ctrl) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: ctrl.category.items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = ctrl.category.items[index];
        final phonetics = ctrl.getPhonetics(item);
        final isBookmarked = ctrl.isBookmarked(item.id);

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Row: Arabic Term & Bookmark
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked ? const Color(0xFFF59E0B) : const Color(0xFF94A3B8),
                    ),
                    onPressed: () => ctrl.toggleBookmark(item.id),
                  ),
                  Expanded(
                    child: Text(
                      item.ar,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Amiri',
                        color: Color(0xFF0F172A),
                      ),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_up, color: Color(0xFF0D9488)),
                    tooltip: 'نُطْقُ الكَلِمَةِ',
                    onPressed: () => ctrl.playItemAudio(item, 'ar'),
                  ),
                ],
              ),
              // IPA Phonetic Badge
              Padding(
                padding: const EdgeInsets.only(right: 48.0),
                child: Text(
                  'IPA: /${phonetics.arabic.ipa}/',
                  style: const TextStyle(fontSize: 11, fontFamily: 'monospace', color: Color(0xFF64748B)),
                  textAlign: TextAlign.right,
                ),
              ),
              const Divider(height: 20),
              // German and English Translations
              Row(
                children: [
                  const Text('DE: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F172A))),
                  Expanded(
                    child: Text(item.de, style: const TextStyle(fontSize: 14, color: Color(0xFF1E293B))),
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_mute, size: 18, color: Color(0xFF64748B)),
                    onPressed: () => ctrl.playItemAudio(item, 'de'),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('EN: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F172A))),
                  Expanded(
                    child: Text(item.en, style: const TextStyle(fontSize: 14, color: Color(0xFF475569))),
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_mute, size: 18, color: Color(0xFF64748B)),
                    onPressed: () => ctrl.playItemAudio(item, 'en'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSwiperView(CategoryDetailController ctrl) {
    if (ctrl.category.items.isEmpty) return const SizedBox.shrink();
    final item = ctrl.category.items[ctrl.activeSwiperIndex];
    final phonetics = ctrl.getPhonetics(item);
    final isBookmarked = ctrl.isBookmarked(item.id);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'البِطَاقَةُ ${ctrl.activeSwiperIndex + 1} مِنْ ${ctrl.totalItems}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF334155)),
              ),
              IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? const Color(0xFFF59E0B) : const Color(0xFF94A3B8),
                ),
                onPressed: () => ctrl.toggleBookmark(item.id),
              ),
            ],
          ),
          const Spacer(),
          // Central Flashcard
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.ar,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Amiri', color: Color(0xFF0F172A)),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 8),
                Text(
                  'IPA: /${phonetics.arabic.ipa}/',
                  style: const TextStyle(fontSize: 13, fontFamily: 'monospace', color: Color(0xFF0D9488)),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 12),
                Text(
                  item.de,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  item.en,
                  style: const TextStyle(fontSize: 18, color: Color(0xFF475569)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const Spacer(),
          // Swiper Navigation Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: ctrl.activeSwiperIndex > 0
                    ? () => ctrl.setSwiperIndex(ctrl.activeSwiperIndex - 1)
                    : null,
              ),
              IconButton(
                icon: const Icon(Icons.volume_up, size: 32, color: Color(0xFF0D9488)),
                onPressed: () => ctrl.playItemAudio(item, 'ar'),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: ctrl.activeSwiperIndex < ctrl.totalItems - 1
                    ? () => ctrl.setSwiperIndex(ctrl.activeSwiperIndex + 1)
                    : null,
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
