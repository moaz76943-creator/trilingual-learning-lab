import 'package:flutter/material.dart';
import '../controllers/bookbinding_studio_controller.dart';

/// Full interactive classical bookbinding and manuscript codicology screen.
class BookbindingStudioScreen extends StatefulWidget {
  final BookbindingStudioController controller;

  const BookbindingStudioScreen({
    super.key,
    required this.controller,
  });

  @override
  State<BookbindingStudioScreen> createState() => _BookbindingStudioScreenState();
}

class _BookbindingStudioScreenState extends State<BookbindingStudioScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;
        final stage = ctrl.currentStage;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: const Text('مَخْبَرُ صِنَاعَةِ الكِتَابِ وَتَجْلِيدِ المَخْطُوطَاتِ'),
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'إِعَادَةُ الضَّبْطِ',
                onPressed: ctrl.reset,
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Craft Stages Horizontal Chips
                  _buildStageChips(ctrl),
                  const SizedBox(height: 16),
                  // Manuscript 2D Binding Canvas
                  _buildManuscriptCanvas(ctrl),
                  const SizedBox(height: 16),
                  // Codicological Telemetry Card
                  _buildCodicologyTelemetry(ctrl),
                  const SizedBox(height: 16),
                  // Flap Folding Controls
                  _buildFlapControlCard(ctrl),
                  const SizedBox(height: 16),
                  // Craft Description Card
                  _buildStageDescription(stage),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStageChips(BookbindingStudioController ctrl) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(BookbindingStudioController.craftStages.length, (index) {
          final s = BookbindingStudioController.craftStages[index];
          final isSelected = index == ctrl.activeStageIndex;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(s.titleAr.split(' ').first),
              selected: isSelected,
              selectedColor: const Color(0xFF0F172A),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF334155),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              onSelected: (_) => ctrl.selectStage(index),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildManuscriptCanvas(BookbindingStudioController ctrl) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1B18), // Dark binder's bench
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Lower Board (الدَّفَّةُ السُّفْلِيَّةُ)
          Positioned(
            left: 50,
            child: Container(
              width: 140,
              height: 190,
              decoration: BoxDecoration(
                color: const Color(0xFF7F1D1D), // Crimson morocco leather
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 6)],
              ),
            ),
          ),
          // Quires Block (كَتْلَةُ الكَرَارِيسِ)
          Positioned(
            left: 55,
            child: Container(
              width: 130,
              height: 180,
              decoration: BoxDecoration(
                color: const Color(0xFFFDFBF7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  '${ctrl.quireCount} كَرَارِيسَ\n(${ctrl.spineThicknessMm.toStringAsFixed(1)} mm)',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF78350F)),
                ),
              ),
            ),
          ),
          // Envelope Flap Extension (المِخْلاَفُ ذُو اللِّسَانِ)
          Positioned(
            right: 50,
            child: Transform(
              alignment: Alignment.centerLeft,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(-ctrl.flapFoldAngleDegrees * (3.14159 / 180.0)),
              child: Container(
                width: 75,
                height: 190,
                decoration: const BoxDecoration(
                  color: Color(0xFF991B1B), // Slightly lighter crimson flap
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(35)),
                  boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 4)],
                ),
                child: Center(
                  child: Icon(
                    ctrl.isBlindToolingActive ? Icons.wb_sunny : Icons.shield_outlined,
                    color: ctrl.isBlindToolingActive ? const Color(0xFFF59E0B) : const Color(0xFFFCA5A5),
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodicologyTelemetry(BookbindingStudioController ctrl) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF99F6E4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMetric('سَمَاكَةُ الكَعْبِ', '${ctrl.spineThicknessMm.toStringAsFixed(1)} mm', const Color(0xFF0F766E)),
          Container(width: 1, height: 36, color: const Color(0xFF99F6E4)),
          _buildMetric('زَاوِيَةُ المِخْلاَفِ', '${ctrl.flapFoldAngleDegrees.toStringAsFixed(0)}°', const Color(0xFF0F766E)),
          Container(width: 1, height: 36, color: const Color(0xFF99F6E4)),
          _buildMetric('حَالَةُ الإِغْلاَقِ', ctrl.isFlapFullyLocked ? 'مَقْفُولٌ' : 'مَفْتُوحٌ', ctrl.isFlapFullyLocked ? const Color(0xFF059669) : const Color(0xFFD97706)),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
      ],
    );
  }

  Widget _buildFlapControlCard(BookbindingStudioController ctrl) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('طَيُّ لِسَانِ المِخْلاَفِ (Envelope Flap Folding)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text('${ctrl.flapFoldAngleDegrees.toStringAsFixed(0)}°', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D9488))),
            ],
          ),
          Slider(
            value: ctrl.flapFoldAngleDegrees,
            min: 0.0,
            max: 180.0,
            divisions: 36,
            activeColor: const Color(0xFF0D9488),
            onChanged: ctrl.setFlapFoldAngle,
          ),
          const Divider(height: 12),
          SwitchListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: const Text('تَذْهِيبُ السُّرَّةِ وَالبَصْمُ الجَافُّ (Blind Tooling)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            value: ctrl.isBlindToolingActive,
            activeColor: const Color(0xFFF59E0B),
            onChanged: (_) => ctrl.toggleBlindTooling(),
          ),
        ],
      ),
    );
  }

  Widget _buildStageDescription(BookbindingCraftStage stage) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            stage.titleAr,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, fontFamily: 'Amiri', color: Color(0xFF0F172A)),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 4),
          Text(
            '${stage.titleDe} • ${stage.titleEn}',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 10),
          Text(
            stage.descriptionAr,
            style: const TextStyle(fontSize: 14, color: Color(0xFF334155)),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}
