import 'package:flutter/material.dart';
import '../controllers/ebru_studio_controller.dart';

/// Full interactive Ebru paper marbling and fluid physics screen.
class EbruStudioScreen extends StatefulWidget {
  final EbruStudioController controller;

  const EbruStudioScreen({
    super.key,
    required this.controller,
  });

  @override
  State<EbruStudioScreen> createState() => _EbruStudioScreenState();
}

class _EbruStudioScreenState extends State<EbruStudioScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: const Text('مَخْبَرُ فَنِّ الإِبْرُو وَفِيزْيَاءِ المَوَائِعِ'),
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'تَجْدِيدُ الحَوْضِ',
                onPressed: ctrl.resetTray,
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Palette & Tool Bar
                  _buildToolAndPaletteBar(ctrl),
                  const SizedBox(height: 14),
                  // Fluid Tray Canvas
                  _buildTrayCanvas(ctrl),
                  const SizedBox(height: 14),
                  // Marbling Comb Actions Bar
                  _buildCombActionsBar(ctrl),
                  const SizedBox(height: 14),
                  // Physics Telemetry Card
                  _buildPhysicsCard(ctrl),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildToolAndPaletteBar(EbruStudioController ctrl) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          // Tools Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildToolButton(
                label: 'قَطَّارَةٌ (Drop)',
                icon: Icons.colorize,
                isSelected: ctrl.activeTool == EbruToolType.dropper,
                onTap: () => ctrl.setTool(EbruToolType.dropper),
              ),
              _buildToolButton(
                label: 'مِشْطٌ (Comb)',
                icon: Icons.waves,
                isSelected: ctrl.activeTool == EbruToolType.comb,
                onTap: () => ctrl.setTool(EbruToolType.comb),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D9488),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.print, size: 18),
                label: const Text('طَبْعُ الوَرَقِ'),
                onPressed: ctrl.dropCount > 0 ? ctrl.printPaper : null,
              ),
            ],
          ),
          const Divider(height: 20),
          // Pigments Selector Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(EbruStudioController.pigments.length, (index) {
                final p = EbruStudioController.pigments[index];
                final isSelected = index == ctrl.activePigmentIndex;

                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: () => ctrl.selectPigment(index),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFCBD5E1)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: Color(p.colorValue),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            p.nameAr,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.white : const Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0F172A) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: isSelected ? Colors.white : const Color(0xFF64748B)),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrayCanvas(EbruStudioController ctrl) {
    return GestureDetector(
      onTapUp: (details) {
        if (ctrl.activeTool == EbruToolType.dropper) {
          ctrl.addDrop(details.localPosition.dx, details.localPosition.dy);
        }
      },
      child: Container(
        height: 260,
        decoration: BoxDecoration(
          color: ctrl.isPaperPrinted ? const Color(0xFFFDFBF7) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: ctrl.isPaperPrinted ? const Color(0xFFD97706) : const Color(0xFF94A3B8),
            width: ctrl.isPaperPrinted ? 3.0 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            CustomPaint(
              size: const Size(double.infinity, 260),
              painter: _EbruTrayPainter(controller: ctrl),
            ),
            if (ctrl.drops.isEmpty)
              const Center(
                child: Text(
                  'انْقُرْ هُنَا لِإِسْقَاطِ قَطَرَاتِ الأَلْوَانِ عَلَى لُعَابِ الكَثِيرَاءِ',
                  style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8), fontWeight: FontWeight.bold),
                ),
              ),
            if (ctrl.isPaperPrinted)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD97706),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('وَرَقٌ مَرْخُومٌ مَطْبُوعٌ (Printed)', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCombActionsBar(EbruStudioController ctrl) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.sync_alt, size: 16),
            label: const Text('ذَهَابٌ وَإِيَابٌ (Gel-Git)'),
            onPressed: ctrl.dropCount > 0 && !ctrl.isPaperPrinted
                ? () => ctrl.applyCombPattern(EbruPatternStyle.gelGit)
                : null,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.view_headline, size: 16),
            label: const Text('تَسْرِيحٌ (Tarama)'),
            onPressed: ctrl.dropCount > 0 && !ctrl.isPaperPrinted
                ? () => ctrl.applyCombPattern(EbruPatternStyle.tarama)
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildPhysicsCard(EbruStudioController ctrl) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF99F6E4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('تَرْكِيزُ مَرَارَةِ الثَّوْرِ (Ox Gall Surfactant)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F766E))),
              Text('${ctrl.oxGallConcentration.toStringAsFixed(1)}x', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D9488))),
            ],
          ),
          Slider(
            value: ctrl.oxGallConcentration,
            min: 0.5,
            max: 2.5,
            divisions: 20,
            activeColor: const Color(0xFF0D9488),
            onChanged: ctrl.setOxGallConcentration,
          ),
          const SizedBox(height: 6),
          const Text(
            'تَقِلُّ لُزُوجَةُ السَّطْحِ بِفِعْلِ المَرَارَةِ؛ فَتَنْتَشِرُ النِّقَاطُ عَلَى سَطْحِ كَثِيرَاءِ النَّبَاتِ دُونَ أَنْ تَغُوصَ.',
            style: TextStyle(fontSize: 12, color: Color(0xFF134E4A)),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}

class _EbruTrayPainter extends CustomPainter {
  final EbruStudioController controller;

  _EbruTrayPainter({required this.controller});

  @override
  void paint(Canvas canvas, Size size) {
    for (final drop in controller.drops) {
      final paint = Paint()
        ..color = Color(drop.colorValue).withOpacity(controller.isPaperPrinted ? 0.95 : 0.85)
        ..style = PaintingStyle.fill;

      final borderPaint = Paint()
        ..color = Color(drop.colorValue)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;

      canvas.drawCircle(Offset(drop.x, drop.y), drop.radius, paint);
      canvas.drawCircle(Offset(drop.x, drop.y), drop.radius, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _EbruTrayPainter oldDelegate) => true;
}
