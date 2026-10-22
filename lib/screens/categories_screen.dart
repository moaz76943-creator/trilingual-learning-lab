import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../repositories/content_repository.dart';
import '../models/concept.dart';
import '../models/verb_model.dart';
import 'category_detail_screen.dart';
import 'verbs_screen.dart';
import 'sentence_builder_screen.dart';
import 'search_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final ContentRepository _repository = ContentRepository();
  List<VerbModel> _verbs = [];
  bool _isLoading = true;
  String _targetLang = 'de';

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    await _repository.loadAllActiveCategories();
    try {
      final vString = await rootBundle.loadString('content/verbs/verbs_a1.json');
      final Map<String, dynamic> vData = jsonDecode(vString);
      final List vList = vData['verbs'] ?? [];
      _verbs = vList.map((i) => VerbModel.fromJson(i)).toList();
    } catch (_) {}
    if (mounted) setState(() => _isLoading = false);
  }

  List<Concept> get _allConcepts {
    return [
      ..._repository.getConcepts('family'),
      ..._repository.getConcepts('food'),
      ..._repository.getConcepts('home'),
      ..._repository.getConcepts('clothes'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Trilingual Lab', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
            Text('A1 Foundation • 100 مفردة + 15 فعلًا + 20 جملة', style: TextStyle(color: Color(0xFF64748B), fontSize: 11)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF0F172A)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SearchScreen(
                    concepts: _allConcepts,
                    verbs: _verbs,
                    targetLang: _targetLang,
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'de', label: Text('DE')),
                ButtonSegment(value: 'en', label: Text('EN')),
              ],
              selected: {_targetLang},
              onSelectionChanged: (val) => setState(() => _targetLang = val.first),
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // 1. تمرين بناء الجمل
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => SentenceBuilderScreen(targetLang: _targetLang)));
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF059669), Color(0xFF047857)]),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: const Color(0xFF059669).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.extension, color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('تمرين تركيب الجمل 🧩', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                              SizedBox(height: 4),
                              Text('20 تدريب تفاعلي لترتيب الكلمات وقواعد الجمل', style: TextStyle(fontSize: 12, color: Color(0xFFD1FAE5))),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // 2. بطاقة الأفعال
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => VerbsScreen(targetLang: _targetLang)));
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)]),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: const Color(0xFF2563EB).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.flash_on, color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('الأفعال والتصريفات ⚡', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                              SizedBox(height: 4),
                              Text('15 فعلًا مع جداول التصريف في الحاضر', style: TextStyle(fontSize: 12, color: Color(0xFFDBEAFE))),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // الأقسام الأربعة النشطة
                _buildCategoryCard('العائلة', 'Familie', 'Family', _repository.getConcepts('family'), Icons.people_outline, const Color(0xFF0284C7)),
                const SizedBox(height: 12),
                _buildCategoryCard('الطعام والشراب', 'Essen & Trinken', 'Food & Drinks', _repository.getConcepts('food'), Icons.restaurant_outlined, const Color(0xFFEA580C)),
                const SizedBox(height: 12),
                _buildCategoryCard('المنزل والأثاث', 'Zuhause & Möbel', 'Home & Furniture', _repository.getConcepts('home'), Icons.home_outlined, const Color(0xFF7C3AED)),
                const SizedBox(height: 12),
                _buildCategoryCard('الملابس والمظهر', 'Kleidung & Aussehen', 'Clothes & Appearance', _repository.getConcepts('clothes'), Icons.checkroom_outlined, const Color(0xFFE11D48)),
                const SizedBox(height: 12),

                // أقسام قادمة
                _buildLockedCard('الألوان والأرقام', 'Farben & Zahlen', 'Colors & Numbers', 30),
                const SizedBox(height: 12),
                _buildLockedCard('الوقت والتقويم', 'Zeit & Kalender', 'Time & Calendar', 25),
              ],
            ),
    );
  }

  Widget _buildCategoryCard(String ar, String de, String en, List concepts, IconData icon, Color color) {
    final String active = _targetLang == 'de' ? de : en;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryDetailScreen(categoryName: '$ar • $active', concepts: List.from(concepts), targetLang: _targetLang)));
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          boxShadow: [BoxShadow(color: color.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color, size: 28)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('$ar • $active', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                const SizedBox(height: 4),
                Text('${concepts.length} مفردة واختبارات جاهزة', style: const TextStyle(fontSize: 13, color: Color(0xFF64748B))),
              ]),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }

  Widget _buildLockedCard(String ar, String de, String en, int count) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.6), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.lock_outline, color: Color(0xFF94A3B8), size: 24)),
          const SizedBox(width: 16),
          Expanded(child: Text('$ar • ${_targetLang == 'de' ? de : en} ($count مفردة)', style: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8), fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}
