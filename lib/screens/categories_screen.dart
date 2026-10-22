import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../repositories/content_repository.dart';
import '../repositories/srs_repository.dart';
import '../models/concept.dart';
import '../models/verb_model.dart';
import 'category_detail_screen.dart';
import 'verbs_screen.dart';
import 'sentence_builder_screen.dart';
import 'prepositions_screen.dart';
import 'dialogues_screen.dart';
import 'srs_review_screen.dart';
import 'search_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final ContentRepository _repository = ContentRepository();
  final SRSRepository _srsRepo = SRSRepository();
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
    await _srsRepo.init('.');
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
      ..._repository.getConcepts('colors_numbers'),
      ..._repository.getConcepts('time_calendar'),
      ..._repository.getConcepts('body_health'),
      ..._repository.getConcepts('city_transport'),
      ..._repository.getConcepts('nature_animals'),
      ..._repository.getConcepts('work_study'),
      ..._repository.getConcepts('feelings_adjectives'),
      ..._repository.getConcepts('travel_hotel'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<Concept> dueCards = _srsRepo.getDueConcepts(_allConcepts);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Trilingual Lab', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
            Text('A1 Foundation • 305 مفردات + خوارزمية SM-2', style: TextStyle(color: Color(0xFF64748B), fontSize: 11)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF0F172A)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen(concepts: _allConcepts, verbs: _verbs, targetLang: _targetLang)));
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: SegmentedButton<String>(
              segments: const [ButtonSegment(value: 'de', label: Text('DE')), ButtonSegment(value: 'en', label: Text('EN'))],
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
                // 🌟 بطاقة المراجعة اليومية الذكية (SRS Banner) في قمة الشاشة
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => SRSReviewScreen(dueConcepts: dueCards, targetLang: _targetLang))).then((_) => setState(() {}));
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF0284C7), Color(0xFF0369A1)]),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: const Color(0xFF0284C7).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: Row(
                      children: [
                        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.psychology, color: Colors.white, size: 28)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('المراجعة الذكية التباعدية (SRS) 🧠', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                              const SizedBox(height: 2),
                              Text('${dueCards.length} بطاقات مستحقة للمراجعة والتثبيت اليوم', style: const TextStyle(fontSize: 12, color: Color(0xFFE0F2FE))),
                            ],
                          ),
                        ),
                        const Icon(Icons.play_circle_fill, size: 24, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // المحادثات والمواقف
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DialoguesScreen(targetLang: _targetLang))),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)]), borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.forum_outlined, color: Colors.white, size: 22)),
                        const SizedBox(width: 12),
                        const Expanded(child: Text('المحادثات وحوارات المواقف 💬 (5 مواقف)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white))),
                        const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // تمرين تركيب الجمل
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SentenceBuilderScreen(targetLang: _targetLang))),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF059669), Color(0xFF047857)]), borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.extension, color: Colors.white, size: 22)),
                        const SizedBox(width: 12),
                        const Expanded(child: Text('تمرين تركيب الجمل 🧩 (20 تدريب)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white))),
                        const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // الأفعال والتصريفات
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VerbsScreen(targetLang: _targetLang))),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)]), borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.flash_on, color: Colors.white, size: 22)),
                        const SizedBox(width: 12),
                        const Expanded(child: Text('الأفعال والتصريفات ⚡ (15 فعلًا)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white))),
                        const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // حروف الجر
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PrepositionsScreen(targetLang: _targetLang))),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFEA580C), Color(0xFFC2410C)]), borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.near_me_outlined, color: Colors.white, size: 22)),
                        const SizedBox(width: 12),
                        const Expanded(child: Text('حروف الجر والقواعد المكانية 📍 (20 حرفًا)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white))),
                        const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // الأقسام الـ 12 النشطة للمفردات
                _buildCategoryCard('العائلة', 'Familie', 'Family', _repository.getConcepts('family'), Icons.people_outline, const Color(0xFF0284C7)),
                const SizedBox(height: 8),
                _buildCategoryCard('الطعام والشراب', 'Essen & Trinken', 'Food & Drinks', _repository.getConcepts('food'), Icons.restaurant_outlined, const Color(0xFFEA580C)),
                const SizedBox(height: 8),
                _buildCategoryCard('المنزل والأثاث', 'Zuhause & Möbel', 'Home & Furniture', _repository.getConcepts('home'), Icons.home_outlined, const Color(0xFF7C3AED)),
                const SizedBox(height: 8),
                _buildCategoryCard('الملابس والمظهر', 'Kleidung & Aussehen', 'Clothes & Appearance', _repository.getConcepts('clothes'), Icons.checkroom_outlined, const Color(0xFFE11D48)),
                const SizedBox(height: 8),
                _buildCategoryCard('الألوان والأرقام', 'Farben & Zahlen', 'Colors & Numbers', _repository.getConcepts('colors_numbers'), Icons.palette_outlined, const Color(0xFFD97706)),
                const SizedBox(height: 8),
                _buildCategoryCard('الوقت والتقويم', 'Zeit & Kalender', 'Time & Calendar', _repository.getConcepts('time_calendar'), Icons.access_time_outlined, const Color(0xFF0891B2)),
                const SizedBox(height: 8),
                _buildCategoryCard('الجسم والصحة', 'Körper & Gesundheit', 'Body & Health', _repository.getConcepts('body_health'), Icons.favorite_border, const Color(0xFF059669)),
                const SizedBox(height: 8),
                _buildCategoryCard('المدينة والمواصلات', 'Stadt & Verkehr', 'City & Transport', _repository.getConcepts('city_transport'), Icons.directions_bus_outlined, const Color(0xFF1E3A8A)),
                const SizedBox(height: 8),
                _buildCategoryCard('الطبيعة والحيوانات', 'Natur & Tiere', 'Nature & Animals', _repository.getConcepts('nature_animals'), Icons.eco_outlined, const Color(0xFF15803D)),
                const SizedBox(height: 8),
                _buildCategoryCard('العمل والمهن', 'Arbeit & Berufe', 'Work & Jobs', _repository.getConcepts('work_study'), Icons.work_outline, const Color(0xFF6B21A8)),
                const SizedBox(height: 8),
                _buildCategoryCard('المشاعر والصفات', 'Gefühle & Adjektive', 'Feelings & Adjectives', _repository.getConcepts('feelings_adjectives'), Icons.sentiment_satisfied_alt_outlined, const Color(0xFFB45309)),
                const SizedBox(height: 8),
                _buildCategoryCard('السفر والفندق', 'Reisen & Hotel', 'Travel & Hotel', _repository.getConcepts('travel_hotel'), Icons.flight_takeoff_outlined, const Color(0xFF0D9488)),
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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.3), width: 1.5)),
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color, size: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('$ar • $active', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                Text('${concepts.length} مفردة واختبارات جاهزة', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
              ]),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }
}
