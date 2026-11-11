import 'package:flutter/material.dart';
import '../../domain/services/etymological_cognate_tracker.dart';
import '../controllers/cognates_studio_controller.dart';

/// Full interactive etymological loanword and cognates transmission screen.
class CognatesStudioScreen extends StatefulWidget {
  final CognatesStudioController controller;

  const CognatesStudioScreen({
    super.key,
    required this.controller,
  });

  @override
  State<CognatesStudioScreen> createState() => _CognatesStudioScreenState();
}

class _CognatesStudioScreenState extends State<CognatesStudioScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
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
            title: const Text('جُسُورُ الكَلِمَاتِ وَالأُصُولُ التَّارِيخِيَّةُ'),
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'ابْحَثْ عَنْ كَلِمَةٍ أَوْ جَذْرٍ (عضادة، Azimut، Zenith)...',
                    hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
                    filled: true,
                    fillColor: const Color(0xFF1E293B),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.white70),
                            onPressed: () {
                              _searchController.clear();
                              ctrl.filterCognates(query: '');
                            },
                          )
                        : null,
                  ),
                  onChanged: (val) => ctrl.filterCognates(query: val),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Historical Era Chips
                _buildEraChips(ctrl),
                // Cognate Cards List
                Expanded(
                  child: _buildCognatesList(ctrl),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEraChips(CognatesStudioController ctrl) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            FilterChip(
              label: Text('الكُلُّ (${ctrl.totalCognates})'),
              selected: ctrl.selectedEraFilter == null,
              onSelected: (_) => ctrl.filterCognates(era: ''),
            ),
            const SizedBox(width: 8),
            ...ctrl.availableEras.map((era) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FilterChip(
                  label: Text(era.split('(').first.trim()),
                  selected: ctrl.selectedEraFilter == era,
                  onSelected: (_) => ctrl.filterCognates(era: era),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCognatesList(CognatesStudioController ctrl) {
    if (ctrl.cognates.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.history_edu, size: 68, color: Color(0xFF94A3B8)),
              SizedBox(height: 14),
              Text(
                'لَمْ نَعْثُرْ عَلَى رَوَابِطَ لُغَوِيَّةٍ تُطَابِقُ بَحْثَكَ.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF334155)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: ctrl.cognates.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final cognate = ctrl.cognates[index];
        final isBookmarked = ctrl.isBookmarked(cognate.id);

        return Container(
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Row: Root Badge & Bookmark
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
                      'الجَذْرُ: ${cognate.arabicRoot}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1D4ED8), fontSize: 13),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked ? const Color(0xFFF59E0B) : const Color(0xFF94A3B8),
                    ),
                    onPressed: () => ctrl.toggleBookmark(cognate.id),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Trilingual Transmission Pathway
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDFA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF99F6E4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text('الأَصْلُ العَرَبِيُّ', style: TextStyle(fontSize: 10, color: Color(0xFF0F766E), fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text(
                          cognate.arabicTerm,
                          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, fontFamily: 'Amiri', color: Color(0xFF134E4A)),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward, size: 16, color: Color(0xFF0D9488)),
                    Column(
                      children: [
                        const Text('الأَلْمَانِيَّةُ (Deutsch)', style: TextStyle(fontSize: 10, color: Color(0xFF0F766E), fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text(
                          cognate.germanTerm,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward, size: 16, color: Color(0xFF0D9488)),
                    Column(
                      children: [
                        const Text('الإِنْجِلِيزِيَّةُ (English)', style: TextStyle(fontSize: 10, color: Color(0xFF0F766E), fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text(
                          cognate.englishTerm,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF334155)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Historical Transmission Narrative
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.menu_book_outlined, size: 16, color: Color(0xFFD97706)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      cognate.transmissionNote,
                      style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'عَصْرُ الِانْتِقَالِ: ${cognate.historicalEra}',
                style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8), fontStyle: FontStyle.italic),
              ),
            ],
          ),
        );
      },
    );
  }
}
