import 'package:flutter/material.dart';
import '../../domain/services/verb_conjugation_engine.dart';
import '../controllers/verb_conjugation_controller.dart';

/// Full interactive verb conjugation and morphology studio screen.
class VerbConjugatorScreen extends StatefulWidget {
  final VerbConjugationController controller;

  const VerbConjugatorScreen({
    super.key,
    required this.controller,
  });

  @override
  State<VerbConjugatorScreen> createState() => _VerbConjugatorScreenState();
}

class _VerbConjugatorScreenState extends State<VerbConjugatorScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: const Text('مَخْبَرُ التَّصْرِيفِ وَالصَّرْفِ (Conjugator)'),
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(
                  ctrl.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: ctrl.isBookmarked ? const Color(0xFFF59E0B) : Colors.white,
                ),
                tooltip: 'حِفْظُ الفِعْلِ فِي المَرْجِعِ',
                onPressed: ctrl.toggleBookmark,
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Verb Header Card
                  _buildVerbHeader(ctrl),
                  const SizedBox(height: 16),
                  // Tense Selector Tabs
                  _buildTenseTabs(ctrl),
                  const SizedBox(height: 16),
                  // Active Primary Tense Display Card
                  _buildActiveTenseCard(ctrl),
                  const SizedBox(height: 20),
                  // Trilingual Declension Table
                  _buildDeclensionTable(ctrl),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildVerbHeader(VerbConjugationController ctrl) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Root Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFBFDBFE)),
            ),
            child: Text(
              'الجَذْرُ: ${ctrl.rootAr}',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1D4ED8), fontSize: 15),
            ),
          ),
          const SizedBox(height: 14),
          // Infinitives comparison
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text('Deutsch', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                  const SizedBox(height: 2),
                  Text(ctrl.infinitiveDe, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              Container(width: 1, height: 32, color: const Color(0xFFCBD5E1)),
              Column(
                children: [
                  const Text('English', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                  const SizedBox(height: 2),
                  Text(ctrl.infinitiveEn, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTenseTabs(VerbConjugationController ctrl) {
    return Row(
      children: [
        _buildTabButton(ctrl, VerbTenseTab.past, 'المَاضِي\n(Past)'),
        const SizedBox(width: 6),
        _buildTabButton(ctrl, VerbTenseTab.present, 'المُضَارِعُ\n(Present)'),
        const SizedBox(width: 6),
        _buildTabButton(ctrl, VerbTenseTab.imperative, 'الأَمْرُ\n(Imperative)'),
        const SizedBox(width: 6),
        _buildTabButton(ctrl, VerbTenseTab.verbalNoun, 'المَصْدَرُ\n(Masdar)'),
      ],
    );
  }

  Widget _buildTabButton(VerbConjugationController ctrl, VerbTenseTab tab, String label) {
    final isSelected = ctrl.activeTab == tab;
    return Expanded(
      child: InkWell(
        onTap: () => ctrl.selectTab(tab),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0F172A) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFCBD5E1)),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : const Color(0xFF334155),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveTenseCard(VerbConjugationController ctrl) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF5EEAD4), width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            ctrl.activeArabicForm,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'Amiri',
              color: Color(0xFF0F766E),
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(ctrl.activeGermanForm, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF134E4A))),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('•', style: TextStyle(color: Color(0xFF99F6E4))),
              ),
              Text(ctrl.activeEnglishForm, style: const TextStyle(fontSize: 16, color: Color(0xFF134E4A))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeclensionTable(VerbConjugationController ctrl) {
    final rows = ctrl.declensionRows;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: const Text(
              'جَدْوَلُ تَصْرِيفِ الضَّمَائِرِ التَّفَاعُلِيِّ',
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF334155)),
              textAlign: TextAlign.center,
            ),
          ),
          ...rows.map((row) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
              ),
              child: Row(
                children: [
                  // Arabic
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(row['pronounAr']!, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                        Text(
                          row['formAr']!,
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, fontFamily: 'Amiri'),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // German & English
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${row['pronounDe']} ${row['formDe']}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        Text('${row['pronounEn']} ${row['formEn']}', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
