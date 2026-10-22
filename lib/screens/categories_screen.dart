import 'package:flutter/material.dart';
import '../repositories/content_repository.dart';
import 'category_detail_screen.dart';

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
            Text('A1 Foundation • 50 مفردة نشطة', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
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
                // 1. قسم العائلة النشط
                _buildCategoryCard(
                  titleAr: 'العائلة',
                  titleDe: 'Familie',
                  titleEn: 'Family',
                  concepts: _repository.getConcepts('family'),
                  icon: Icons.people_outline,
                  color: const Color(0xFF0284C7),
                ),
                const SizedBox(height: 12),
                // 2. قسم الطعام والشراب النشط الجديد
                _buildCategoryCard(
                  titleAr: 'الطعام والشراب',
                  titleDe: 'Essen & Trinken',
                  titleEn: 'Food & Drinks',
                  concepts: _repository.getConcepts('food'),
                  icon: Icons.restaurant_outlined,
                  color: const Color(0xFFEA580C),
                ),
                const SizedBox(height: 12),
                // الأقسام القادمة
                _buildLockedCard('المنزل', 'Zuhause', 'Home', 30),
                const SizedBox(height: 12),
                _buildLockedCard('الملابس', 'Kleidung', 'Clothes', 25),
                const SizedBox(height: 12),
                _buildLockedCard('الألوان والأرقام', 'Farben & Zahlen', 'Colors & Numbers', 30),
              ],
            ),
    );
  }

  Widget _buildCategoryCard({
    required String titleAr,
    required String titleDe,
    required String titleEn,
    required List concepts,
    required IconData icon,
    required Color color,
  }) {
    final String activeTitle = _targetLang == 'de' ? titleDe : titleEn;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryDetailScreen(
              categoryName: '$titleAr • $activeTitle',
              concepts: List.from(concepts),
              targetLang: _targetLang,
            ),
          ),
        );
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$titleAr • $activeTitle', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                  const SizedBox(height: 4),
                  Text('${concepts.length} مفردة واختبارات جاهزة', style: const TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                ],
              ),
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.lock_outline, color: Color(0xFF94A3B8), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text('$ar • ${_targetLang == 'de' ? de : en} ($count مفردة)', style: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8), fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
