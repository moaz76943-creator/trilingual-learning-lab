import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/concept.dart';
import '../models/verb_model.dart';
import '../models/search_engine.dart';

class SearchScreen extends StatefulWidget {
  final List<Concept> concepts;
  final List<VerbModel> verbs;
  final String targetLang;

  const SearchScreen({
    super.key,
    required this.concepts,
    required this.verbs,
    required this.targetLang,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<SearchResultItem> _results = [];
  String _activeFilter = 'all';

  void _onSearch(String query) {
    setState(() {
      _results = SearchEngine.search(
        query: query,
        concepts: widget.concepts,
        verbs: widget.verbs,
        targetLang: widget.targetLang,
        filterType: _activeFilter,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF0F172A),
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'ابحث بالعربية، الألمانية، أو الإنجليزية...',
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
          ),
          onChanged: _onSearch,
        ),
        actions: [
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                _onSearch('');
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // شريط الفلاتر السريعة
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.white,
            child: Row(
              children: [
                _buildFilterChip('all', 'الكل'),
                const SizedBox(width: 8),
                _buildFilterChip('concept', 'المفردات'),
                const SizedBox(width: 8),
                _buildFilterChip('verb', 'الأفعال'),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // قائمة النتائج
          Expanded(
            child: _results.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 48, color: Colors.grey.shade300),
                        const SizedBox(height: 8),
                        Text(
                          _controller.text.isEmpty
                              ? 'اكتب للبحث في 50 مفردة و 15 فعلًا'
                              : 'لا توجد نتائج تطابق بحثك',
                          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _results.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = _results[index];
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                width: 48,
                                height: 48,
                                child: SvgPicture.asset(
                                  'content/assets/svg/${item.imageId}.svg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.titleTarget,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                                  ),
                                  Text(
                                    item.titleAr,
                                    textDirection: TextDirection.rtl,
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                                  ),
                                  Text(item.subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: item.type == 'verb' ? const Color(0xFFDBEAFE) : const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                item.type == 'verb' ? 'فعل' : 'مفردة',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: item.type == 'verb' ? const Color(0xFF1D4ED8) : const Color(0xFF475569),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String type, String label) {
    final isSelected = _activeFilter == type;
    return ChoiceChip(
      label: Text(label, style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      selected: isSelected,
      selectedColor: const Color(0xFF0284C7).withOpacity(0.15),
      onSelected: (_) {
        setState(() => _activeFilter = type);
        _onSearch(_controller.text);
      },
    );
  }
}
