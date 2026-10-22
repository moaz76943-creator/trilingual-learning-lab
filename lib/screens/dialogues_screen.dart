import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import '../models/dialogue_model.dart';

class DialoguesScreen extends StatefulWidget {
  final String targetLang;
  const DialoguesScreen({super.key, required this.targetLang});

  @override
  State<DialoguesScreen> createState() => _DialoguesScreenState();
}

class _DialoguesScreenState extends State<DialoguesScreen> {
  List<DialogueModel> _dialogues = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDialogues();
  }

  Future<void> _loadDialogues() async {
    try {
      final jsonString = await rootBundle.loadString('content/dialogues/dialogues_a1.json');
      final Map<String, dynamic> data = jsonDecode(jsonString);
      final List list = data['dialogues'] ?? [];
      setState(() {
        _dialogues = list.map((item) => DialogueModel.fromJson(item)).toList();
        _isLoading = false;
      });
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isGerman = widget.targetLang == 'de';
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('المحادثات والمواقف (A1)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF0F172A),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _dialogues.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final d = _dialogues[index];
                final String title = isGerman ? d.titleDe : d.titleEn;
                final String situation = isGerman ? d.situationDe : d.situationEn;
                return InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DialogueDetailScreen(dialogue: d, targetLang: widget.targetLang))),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2))],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(width: 54, height: 54, child: SvgPicture.asset('content/assets/svg/${d.imageId}.svg', fit: BoxFit.cover)),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('$title • ${d.titleAr}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                              const SizedBox(height: 4),
                              Text(situation, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)), maxLines: 2, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Text('${d.lines.length} جُمَل حوارية تفاعلية', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF059669))),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF94A3B8)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class DialogueDetailScreen extends StatefulWidget {
  final DialogueModel dialogue;
  final String targetLang;
  const DialogueDetailScreen({super.key, required this.dialogue, required this.targetLang});

  @override
  State<DialogueDetailScreen> createState() => _DialogueDetailScreenState();
}

class _DialogueDetailScreenState extends State<DialogueDetailScreen> {
  // تخزين أرقام الأسطر التي تم النقر عليها لإظهار الترجمة
  final Set<int> _revealedLines = {};

  void _toggleReveal(int idx) {
    setState(() {
      if (_revealedLines.contains(idx)) _revealedLines.remove(idx);
      else _revealedLines.add(idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isGerman = widget.targetLang == 'de';
    final d = widget.dialogue;
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(isGerman ? d.titleDe : d.titleEn, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF0F172A),
      ),
      body: Column(
        children: [
          // شريط الموقف التعليمي
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: const Color(0xFFEFF6FF),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Color(0xFF2563EB), size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'الموقف: ${d.situationAr}\n💡 انقر على أي فقاعة لإظهار الترجمة والتشكيل',
                    style: const TextStyle(fontSize: 12, color: Color(0xFF1E40AF), height: 1.3),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // قائمة فقاعات الحوار (Chat Bubbles)
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: d.lines.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, idx) {
                final line = d.lines[idx];
                final bool isSpeakerA = line.speaker == 'A';
                final bool isRevealed = _revealedLines.contains(idx);
                final String targetText = isGerman ? line.textDe : line.textEn;

                return Align(
                  alignment: isSpeakerA ? Alignment.centerLeft : Alignment.centerRight,
                  child: InkWell(
                    onTap: () => _toggleReveal(idx),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSpeakerA ? Colors.white : const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: Radius.circular(isSpeakerA ? 2 : 16),
                          bottomRight: Radius.circular(isSpeakerA ? 16 : 2),
                        ),
                        border: Border.all(color: isSpeakerA ? const Color(0xFFCBD5E1) : const Color(0xFFA7F3D0)),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: isSpeakerA ? const Color(0xFF2563EB) : const Color(0xFF059669),
                                child: Text(line.speaker, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(width: 6),
                              Text(line.name, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isSpeakerA ? const Color(0xFF2563EB) : const Color(0xFF059669))),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(targetText, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
                          if (isRevealed) ...[
                            const SizedBox(height: 6),
                            const Divider(height: 1, color: Color(0xFFE2E8F0)),
                            const SizedBox(height: 6),
                            Text(line.textAr, textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 14, color: Color(0xFF334155), fontWeight: FontWeight.w500)),
                          ] else ...[
                            const SizedBox(height: 4),
                            const Text('👁 انقر لإظهار المعنى', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
