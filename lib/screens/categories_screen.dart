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
  String _targetLang = 'de'; // 'de' = Deutsch, 'en' = English

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _repository.loadCategory('content/vocabulary/family_a1.json');
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Trilingual Lab',
              style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'A1 Foundation • الأساسيات',
              style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
            ),
          ],
        ),
        actions: [
          // شريط اختيار لغة التعلم المستهدفة
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
                _buildActiveCategoryCard(
                  titleAr: 'العائلة',
                  titleDe: 'Familie',
                  titleEn: 'Family',
                  conceptCount: _repository.concepts.length,
                  icon: Icons.people_outline,
                  color: const Color(0xFF0284C7),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryDetailScreen(
                          categoryName: _targetLang == 'de' ? 'Familie' : 'Family',
                          concepts: _repository.concepts,
                          targetLang: _targetLang,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _buildLockedCategoryCard(titleAr: 'المنزل', titleDe: 'Zuhause', titleEn: 'Home', count: 30),
                const SizedBox(height: 12),
                _buildLockedCategoryCard(titleAr: 'الطعام والشراب', titleDe: 'Essen & Trinken', titleEn: 'Food', count: 35),
                const SizedBox(height: 12),
                _buildLockedCategoryCard(titleAr: 'الملابس', titleDe: 'Kleidung', titleEn: 'Clothes', count: 25),
              ],
            ),
    );
  }

  Widget _buildActiveCategoryCard({
    required String titleAr,
    required String titleDe,
    required String titleEn,
    required int conceptCount,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4)),
          ],
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
                  Text(
                    '$titleAr • ${_targetLang == 'de' ? titleDe : titleEn}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$conceptCount مفردة جاهزة للتعلم',
                    style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }

  Widget _buildLockedCategoryCard({
    required String titleAr,
    required String titleDe,
    required String titleEn,
    required int count,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.lock_outline, color: Color(0xFF94A3B8), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$titleAr • ${_targetLang == 'de' ? titleDe : titleEn}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8)),
                ),
                const SizedBox(height: 4),
                Text(
                  '$count مفردة (المرحلة القادمة)',
                  style: const TextStyle(fontSize: 12, color: Color(0xFFCBD5E1)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
