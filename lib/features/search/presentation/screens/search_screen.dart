import 'package:flutter/material.dart';
import '../../domain/services/trilingual_search_indexer.dart';
import '../controllers/search_screen_controller.dart';

/// Full interactive search screen for trilingual vocabulary, verbs, and dialogues.
class SearchScreen extends StatefulWidget {
  final SearchScreenController controller;
  final void Function(SearchResultItem item)? onItemSelected;

  const SearchScreen({
    super.key,
    required this.controller,
    this.onItemSelected,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 0,
            title: TextField(
              controller: _textController,
              autofocus: true,
              style: const TextStyle(color: Colors.white, fontSize: 17),
              decoration: InputDecoration(
                hintText: 'ابْحَثْ بِالعَرَبِيَّةِ، الأَلْمَانِيَّةِ، الإِنْجِلِيزِيَّةِ...',
                hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                border: InputBorder.none,
                suffixIcon: _textController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white70),
                        onPressed: () {
                          _textController.clear();
                          ctrl.clearQuery();
                        },
                      )
                    : null,
              ),
              onChanged: ctrl.executeSearch,
            ),
          ),
          body: Column(
            children: [
              // Filter Chips Bar
              _buildFilterChips(ctrl),
              // Body Content
              Expanded(
                child: _buildBody(context, ctrl),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChips(SearchScreenController ctrl) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            FilterChip(
              label: const Text('الكُلُّ (All)'),
              selected: ctrl.selectedFilter == null,
              onSelected: (_) => ctrl.setFilter(null),
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: const Text('التَّصْنِيفَاتُ (Categories)'),
              selected: ctrl.selectedFilter == SearchEntityType.category,
              onSelected: (_) => ctrl.setFilter(SearchEntityType.category),
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: const Text('الأَفْعَالُ (Verbs)'),
              selected: ctrl.selectedFilter == SearchEntityType.verb,
              onSelected: (_) => ctrl.setFilter(SearchEntityType.verb),
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: const Text('الحِوَارَاتُ (Dialogues)'),
              selected: ctrl.selectedFilter == SearchEntityType.dialogue,
              onSelected: (_) => ctrl.setFilter(SearchEntityType.dialogue),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SearchScreenController ctrl) {
    switch (ctrl.state) {
      case SearchState.searching:
        return const Center(child: CircularProgressIndicator());

      case SearchState.empty:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.search_off, size: 64, color: Color(0xFF94A3B8)),
                const SizedBox(height: 12),
                Text(
                  'لَمْ نَعْثُرْ عَلَى نَتَائِجَ تُطَابِقُ "${ctrl.currentQuery}"',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF334155)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                const Text(
                  'جَرِّبِ البَحْثَ بِكَلِمَةٍ أُخْرَى أَوْ بِاللُّغَةِ الأَلْمَانِيَّةِ أَوِ الإِنْجِلِيزِيَّةِ.',
                  style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );

      case SearchState.success:
        return ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemCount: ctrl.results.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final item = ctrl.results[index];
            return _buildResultCard(item);
          },
        );

      case SearchState.idle:
      default:
        return _buildRecentSearches(ctrl);
    }
  }

  Widget _buildResultCard(SearchResultItem item) {
    IconData typeIcon;
    Color iconColor;
    String typeLabel;

    switch (item.entityType) {
      case SearchEntityType.category:
        typeIcon = Icons.folder_outlined;
        iconColor = const Color(0xFF0D9488);
        typeLabel = 'تَصْنِيفٌ';
        break;
      case SearchEntityType.verb:
        typeIcon = Icons.transform_outlined;
        iconColor = const Color(0xFF2563EB);
        typeLabel = 'فِعْلٌ';
        break;
      case SearchEntityType.dialogue:
        typeIcon = Icons.chat_bubble_outline;
        iconColor = const Color(0xFFD97706);
        typeLabel = 'حِوَارٌ';
        break;
      default:
        typeIcon = Icons.article_outlined;
        iconColor = const Color(0xFF64748B);
        typeLabel = 'مُفْرَدَةٌ';
    }

    return InkWell(
      onTap: () => widget.onItemSelected?.call(item),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(typeIcon, size: 18, color: iconColor),
                const SizedBox(width: 6),
                Text(
                  typeLabel,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: iconColor),
                ),
                const Spacer(),
                Text(
                  'تَطَابُقٌ: ${item.relevanceScore}',
                  style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Arabic Title
            Text(
              item.titleAr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Amiri', color: Color(0xFF0F172A)),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 4),
            // German and English Subtitles
            Text(
              '${item.titleDe} • ${item.titleEn}',
              style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
            ),
            if (item.matchedField.isNotEmpty && !item.matchedField.contains('title')) ...[
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'المُطَابَقَةُ فِي: "${item.matchedText}"',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearches(SearchScreenController ctrl) {
    if (ctrl.recentQueries.isEmpty) {
      return const Center(
        child: Text(
          'اكْتُبْ كَلِمَةً لِبَدْءِ البَحْثِ الشَّامِلِ.',
          style: TextStyle(color: Color(0xFF94A3B8)),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'عَمَلِيَّاتُ البَحْثِ الأَخِيرَةِ',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF334155)),
              ),
              TextButton(
                onPressed: ctrl.clearRecentQueries,
                child: const Text('مَسْحُ الكُلِّ', style: TextStyle(fontSize: 12, color: Color(0xFFE11D48))),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 6.0,
            children: ctrl.recentQueries.map((query) {
              return InputChip(
                label: Text(query),
                onDeleted: () => ctrl.removeRecentQuery(query),
                onPressed: () {
                  _textController.text = query;
                  ctrl.executeSearch(query);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
