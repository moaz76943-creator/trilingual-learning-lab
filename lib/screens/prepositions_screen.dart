import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import '../models/preposition_model.dart';

class PrepositionsScreen extends StatefulWidget {
  final String targetLang;
  const PrepositionsScreen({super.key, required this.targetLang});

  @override
  State<PrepositionsScreen> createState() => _PrepositionsScreenState();
}

class _PrepositionsScreenState extends State<PrepositionsScreen> {
  List<PrepositionModel> _allPreps = [];
  String _activeFilter = 'all';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPrepositions();
  }

  Future<void> _loadPrepositions() async {
    try {
      final jsonString = await rootBundle.loadString('content/grammar/prepositions_a1.json');
      final Map<String, dynamic> data = jsonDecode(jsonString);
      final List list = data['prepositions'] ?? [];
      setState(() {
        _allPreps = list.map((item) => PrepositionModel.fromJson(item)).toList();
        _isLoading = false;
      });
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  List<PrepositionModel> get _filteredPreps {
    if (_activeFilter == 'all') return _allPreps;
    if (_activeFilter == 'wechsel') {
      return _allPreps.where((p) => p.caseRuleDe.contains('Wechsel')).toList();
    }
    if (_activeFilter == 'dativ') {
      return _allPreps.where((p) => p.caseRuleDe.contains('Dativ') && !p.caseRuleDe.contains('Wechsel')).toList();
    }
    if (_activeFilter == 'akkusativ') {
      return _allPreps.where((p) => p.caseRuleDe.contains('Akkusativ')).toList();
    }
    return _allPreps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('حروف الجر والقواعد (A1)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF0F172A),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // شريط الفلاتر النحوية
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      _buildFilterChip('all', 'الكل (20)'),
                      const SizedBox(width: 8),
                      _buildFilterChip('wechsel', 'مكانية ثنائية (Wechsel)'),
                      const SizedBox(width: 8),
                      _buildFilterChip('dativ', 'داتيف فقط (Dativ)'),
                      const SizedBox(width: 8),
                      _buildFilterChip('akkusativ', 'أكوزاتيف فقط (Akkusativ)'),
                    ],
                  ),
                ),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),

                // قائمة حروف الجر
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredPreps.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) => _buildPrepCard(_filteredPreps[index]),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildFilterChip(String filter, String label) {
    final bool isSelected = _activeFilter == filter;
    return ChoiceChip(
      label: Text(label, style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      selected: isSelected,
      selectedColor: const Color(0xFFEA580C).withOpacity(0.15),
      onSelected: (_) => setState(() => _activeFilter = filter),
    );
  }

  Widget _buildPrepCard(PrepositionModel p) {
    final bool isGerman = widget.targetLang == 'de';
    final String targetWord = isGerman ? p.wordDe : p.wordEn;
    final String targetExample = isGerman ? p.exampleDe : p.exampleEn;

    Color badgeColor = const Color(0xFF2563EB);
    if (p.caseRuleDe.contains('Wechsel')) badgeColor = const Color(0xFF0284C7);
    if (p.caseRuleDe.contains('Dativ') && !p.caseRuleDe.contains('Wechsel')) badgeColor = const Color(0xFF16A34A);
    if (p.caseRuleDe.contains('Akkusativ')) badgeColor = const Color(0xFFEA580C);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 56,
              height: 56,
              child: SvgPicture.asset('content/assets/svg/${p.imageId}.svg', fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(targetWord, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: badgeColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: Text(p.caseRuleDe, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: badgeColor)),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${p.wordAr} (${p.meaningAr})',
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(targetExample, style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                      Text(p.exampleAr, textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
