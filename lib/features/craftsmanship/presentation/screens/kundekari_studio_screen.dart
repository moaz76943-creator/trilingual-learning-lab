import 'package:flutter/material.dart';
import '../controllers/kundekari_studio_controller.dart';

/// Full interactive Kundekari joinery and architectural woodworking screen.
class KundekariStudioScreen extends StatefulWidget {
  final KundekariStudioController controller;

  const KundekariStudioScreen({
    super.key,
    required this.controller,
  });

  @override
  State<KundekariStudioScreen> createState() => _KundekariStudioScreenState();
}

class _KundekariStudioScreenState extends State<KundekariStudioScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;
        final wood = ctrl.activeWood;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: const Text('مَخْبَرُ تَعْشِيقِ الكُنْدِكَارِيِّ الهَنْدَسِيِّ'),
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
                  // Wood Species Chips Selector
                  _buildWoodChips(ctrl),
                  const SizedBox(height: 16),
                  // Interlocking Joinery Canvas
                  _buildJoineryCanvas(ctrl),
                  const SizedBox(height: 16),
                  // Materials & Hygroscopic Telemetry Card
                  _buildMaterialsTelemetry(ctrl, wood),
                  const SizedBox(height: 16),
                  // Assembly Stepper Controls
                  _buildAssemblyStepper(ctrl),
                  const SizedBox(height: 16),
                  // Climate Humidity Simulation Slider
                  _buildHumidityCard(ctrl),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWoodChips(KundekariStudioController ctrl) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(KundekariStudioController.woodSpeciesList.length, (index) {
          final w = KundekariStudioController.woodSpeciesList[index];
          final isSelected = index == ctrl.activeWoodIndex;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(w.nameAr),
              selected: isSelected,
              selectedColor: const Color(0xFF0F172A),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF334155),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontFamily: 'Amiri',
              ),
              onSelected: (_) => ctrl.selectWood(index),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildJoineryCanvas(KundekariStudioController ctrl) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        color: const Color(0xFF2B2118), // Deep timber tone
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
          // Outer Wooden Frame (المَقَرُّ ذُو النَّقْرِ)
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF78350F), width: 14),
            ),
          ),
          // Slotted Battens (المَسَاطِرُ المَفْرُوزَةُ)
          if (ctrl.assemblyStage >= 1)
            Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFB45309), width: 6),
              ),
            ),
          // Interlocking Star Polygon (نَجْمَةُ الكُنْدِكَارِيِّ)
          if (ctrl.assemblyStage >= 2)
            Transform.rotate(
              angle: 45.0 * (3.14159 / 180.0),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFD97706),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 4)],
                ),
              ),
            ),
          // Central Locking Peg (مِسْمَارُ القَفْلِ الخَشَبِيُّ)
          if (ctrl.assemblyStage >= 2 && ctrl.isJointLocked)
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Color(0xFFFDE68A),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 4)],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMaterialsTelemetry(KundekariStudioController ctrl, WoodSpeciesPreset wood) {
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetric('كِثَافَةُ الخَشَبِ', '${wood.densityKgM3.toStringAsFixed(0)} kg/m³', const Color(0xFF0F766E)),
              Container(width: 1, height: 36, color: const Color(0xFF99F6E4)),
              _buildMetric('تَمَدُّدُ اللِّسَانِ', '${ctrl.dimensionalExpansionMm >= 0 ? "+" : ""}${ctrl.dimensionalExpansionMm.toStringAsFixed(2)} mm', ctrl.isExpansionSafe ? const Color(0xFF059669) : const Color(0xFFDC2626)),
              Container(width: 1, height: 36, color: const Color(0xFF99F6E4)),
              _buildMetric('حَالَةُ التَّعْشِيقِ', ctrl.isJointLocked ? 'مَقْفُولٌ' : 'حُرٌّ', const Color(0xFF2563EB)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'تَعْشِيقٌ نَقِيٌّ 100% بِلاَ مَسَامِيرَ أَوْ غِرَاءٍ؛ يَتَحَمَّلُ فُرُوقَاتِ الرُّطُوبَةِ عَبْرَ فُرَجِ التَّمَدُّدِ.',
            style: const TextStyle(fontSize: 12, color: Color(0xFF134E4A), fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
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

  Widget _buildAssemblyStepper(KundekariStudioController ctrl) {
    final stages = [
      '1. الإِطَارُ الخَارِجِيُّ\n(Mortise Frame)',
      '2. المَسَاطِرُ المَفْرُوزَةُ\n(Slotted Battens)',
      '3. النَّجْمَةُ وَالغَلْقُ\n(Interlocking Star)',
    ];

    return Container(
      padding: const EdgeInsets.all(14.0),
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
              const Text('مَرَاحِلُ التَّرْكِيبِ الهَنْدَسِيِّ:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              TextButton.icon(
                icon: Icon(ctrl.isJointLocked ? Icons.lock : Icons.lock_open, size: 16),
                label: Text(ctrl.isJointLocked ? 'مَفْصُولٌ (Locked)' : 'مَفْتُوحٌ (Unlocked)', style: const TextStyle(fontSize: 12)),
                onPressed: ctrl.toggleJointLock,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(3, (index) {
              final isCurrent = index <= ctrl.assemblyStage;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isCurrent ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                      foregroundColor: isCurrent ? Colors.white : const Color(0xFF64748B),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => ctrl.setAssemblyStage(index),
                    child: Text('${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 6),
          Text(
            stages[ctrl.assemblyStage],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0D9488)),
          ),
        ],
      ),
    );
  }

  Widget _buildHumidityCard(KundekariStudioController ctrl) {
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
              const Text('مُحَاكَاةُ رُطُوبَةِ الجَوِّ (Relative Humidity)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text('${ctrl.relativeHumidityPercent.toStringAsFixed(0)}% RH', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D9488))),
            ],
          ),
          Slider(
            value: ctrl.relativeHumidityPercent,
            min: 10.0,
            max: 90.0,
            divisions: 16,
            activeColor: const Color(0xFF0D9488),
            onChanged: ctrl.setRelativeHumidity,
          ),
        ],
      ),
    );
  }
}
