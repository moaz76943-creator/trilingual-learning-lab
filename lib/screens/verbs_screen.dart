import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import '../models/verb_model.dart';

class VerbsScreen extends StatefulWidget {
  final String targetLang;
  const VerbsScreen({super.key, required this.targetLang});

  @override
  State<VerbsScreen> createState() => _VerbsScreenState();
}

class _VerbsScreenState extends State<VerbsScreen> {
  List<VerbModel> _verbs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVerbs();
  }

  Future<void> _loadVerbs() async {
    try {
      final jsonString = await rootBundle.loadString('content/verbs/verbs_a1.json');
      final Map<String, dynamic> data = jsonDecode(jsonString);
      final List list = data['verbs'] ?? [];
      setState(() {
        _verbs = list.map((item) => VerbModel.fromJson(item)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('الأفعال والتصريفات (A1)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF0F172A),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _verbs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) => _buildVerbCard(_verbs[index]),
            ),
    );
  }

  Widget _buildVerbCard(VerbModel v) {
    final bool isGerman = widget.targetLang == 'de';
    final String targetInf = isGerman ? v.infinitive['de'] ?? '' : v.infinitive['en'] ?? '';
    final String arInf = v.infinitive['ar'] ?? '';
    final Map<String, String> activeConj = isGerman ? v.conjugationsDe : v.conjugationsEn;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 54,
                  height: 54,
                  child: SvgPicture.asset('content/assets/svg/${v.imageId}.svg', fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(targetInf, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0284C7))),
                        if (isGerman && v.typeDe == 'irregular') ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: const Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(6)),
                            child: const Text('شاذ', style: TextStyle(fontSize: 10, color: Color(0xFFDC2626), fontWeight: FontWeight.bold)),
                          ),
                        ]
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(arInf, textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                    Text('الجذر: ${v.rootAr}', style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 10),

          // شبكة التصريف المصغرة
          const Text('التصريف في المضارع (Präsens):', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: activeConj.entries.map((e) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(8)),
                child: Text('${e.key}: ${e.value}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
              );
            }).toList(),
          ),

          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isGerman ? v.examples['de'] ?? '' : v.examples['en'] ?? '', style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                Text(v.examples['ar'] ?? '', textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 12, color: Color(0xFF475569))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
