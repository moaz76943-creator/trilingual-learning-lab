import 'package:flutter/material.dart';
import '../controllers/bookmarks_controller.dart';

/// Full interactive bookmarks and saved heritage study hub screen.
class BookmarksScreen extends StatefulWidget {
  final BookmarksController controller;
  final void Function(UserBookmarkItem item)? onOpenItem;
  final VoidCallback? onReviewAllSaved;

  const BookmarksScreen({
    super.key,
    required this.controller,
    this.onOpenItem,
    this.onReviewAllSaved,
  });

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: const Text('المَحْفُوظَاتُ وَالمَرْجِعُ الشَّخْصِيُّ'),
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              if (ctrl.totalBookmarks > 0)
                TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: const Color(0xFF5EEAD4)),
                  icon: const Icon(Icons.school, size: 18),
                  label: const Text('مُرَاجَعَةٌ (Review)'),
                  onPressed: widget.onReviewAllSaved,
                ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Filter Tabs
                _buildFilterChips(ctrl),
                // Main Content List
                Expanded(
                  child: _buildBody(context, ctrl),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterChips(BookmarksController ctrl) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            FilterChip(
              label: Text('الكُلُّ (${ctrl.totalBookmarks})'),
              selected: ctrl.activeFilter == BookmarkFilterType.all,
              onSelected: (_) => ctrl.setFilter(BookmarkFilterType.all),
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: const Text('المُفْرَدَاتُ (Vocab)'),
              selected: ctrl.activeFilter == BookmarkFilterType.vocabulary,
              onSelected: (_) => ctrl.setFilter(BookmarkFilterType.vocabulary),
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: const Text('الأَفْعَالُ (Verbs)'),
              selected: ctrl.activeFilter == BookmarkFilterType.verb,
              onSelected: (_) => ctrl.setFilter(BookmarkFilterType.verb),
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: const Text('الحِوَارَاتُ (Dialogues)'),
              selected: ctrl.activeFilter == BookmarkFilterType.dialogue,
              onSelected: (_) => ctrl.setFilter(BookmarkFilterType.dialogue),
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: const Text('القَوَاعِدُ (Grammar)'),
              selected: ctrl.activeFilter == BookmarkFilterType.grammar,
              onSelected: (_) => ctrl.setFilter(BookmarkFilterType.grammar),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BookmarksController ctrl) {
    if (ctrl.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final items = ctrl.filteredBookmarks;

    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.bookmark_border, size: 68, color: Color(0xFF94A3B8)),
              SizedBox(height: 14),
              Text(
                'لاَ تُوجَدُ مَحْفُوظَاتٌ فِي هَذَا القِسْمِ حَالِيًّا.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF334155)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6),
              Text(
                'انْقُرْ عَلَى أَيْقُونَةِ الحِفْظِ أَثْنَاءَ الدِّرَاسَةِ لِتَجِدَهَا هُنَا دَوْمًا.',
                style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildBookmarkCard(context, item, ctrl);
      },
    );
  }

  Widget _buildBookmarkCard(BuildContext context, UserBookmarkItem item, BookmarksController ctrl) {
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  item.entityType.toUpperCase(),
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20, color: Color(0xFFEF4444)),
                tooltip: 'إِزَالَةُ المَحْفُوظَةِ',
                onPressed: () => ctrl.removeBookmark(item.id),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Arabic Title
          Text(
            item.titleAr,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Amiri', color: Color(0xFF0F172A)),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 4),
          // German & English
          Text(
            '${item.titleDe} • ${item.titleEn}',
            style: const TextStyle(fontSize: 13, color: Color(0xFF475569), fontWeight: FontWeight.w500),
          ),
          // User Study Note (if present)
          if (item.note.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.edit_note, size: 18, color: Color(0xFF92400E)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      item.note,
                      style: const TextStyle(fontSize: 12, color: Color(0xFF78350F)),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.add_comment_outlined, size: 16),
                label: Text(item.note.isEmpty ? 'إِضَافَةُ مُلاَحَظَةٍ' : 'تَعْدِيلُ المُلاَحَظَةِ', style: const TextStyle(fontSize: 12)),
                onPressed: () => _showNoteDialog(context, item, ctrl),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F172A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onPressed: () => widget.onOpenItem?.call(item),
                icon: const Icon(Icons.arrow_forward, size: 16),
                label: const Text('فَتْحٌ (Open)', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showNoteDialog(BuildContext context, UserBookmarkItem item, BookmarksController ctrl) {
    final textController = TextEditingController(text: item.note);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('مُلاَحَظَةُ الدِّرَاسَةِ الشَّخْصِيَّةِ', textAlign: TextAlign.right),
        content: TextField(
          controller: textController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'اكْتُبْ مُلاَحَظَتَكَ أَوْ فَائِدَتَكَ هُنَا...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إِلْغَاءٌ'),
          ),
          ElevatedButton(
            onPressed: () {
              ctrl.updateNote(item.id, textController.text.trim());
              Navigator.pop(ctx);
            },
            child: const Text('حِفْظٌ'),
          ),
        ],
      ),
    );
  }
}
