import 'package:flutter/material.dart';
import '../repositories/content_repository.dart';
import 'category_detail_screen.dart';
import 'verbs_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final ContentRepository _repository = ContentRepository();
  bool _isLoading = true;
  String _targetLang = 'de';

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    await _repository.loadAllActiveCategories();
    if (mounted) setState(() => _isLoading = false);
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
            Text('A1 Foundation • 50 مفردة + 15 فعلًا', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                // بطاقة مميزة للأفعال والتصريفات
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
                              Text('الأفعال اليومية والتصريفات ⚡', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                              SizedBox(height: 4),
                              Text('15 فعلًا مع جداول التصريف الثلاثية', style: TextStyle(fontSize: 13, color: Color(0xFFDBEAFE))),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // قسم العائلة
                _buildCategoryCard('العائلة', 'Familie', 'Family', _repository.getConcepts('family'), Icons.people_outline, const Color(0xFF0284C7)),
                const SizedBox(height: 12),

                // قسم الطعام
                _buildCategoryCard('الطعام والشراب', 'Essen & Trinken', 'Food & Drinks', _repository.getConcepts('food'), Icons.restaurant_outlined, const Color(0xFFEA580C)),
                const SizedBox(height: 12),

                // أقسام قادمة
                _buildLockedCard('المنزل', 'Zuhause', 'Home', 30),
                const SizedBox(height: 12),
                _buildLockedCard('الملابس', 'Kleidung', 'Clothes', 25),
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
