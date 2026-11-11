import 'package:flutter/material.dart';
import '../controllers/astrolabe_simulator_controller.dart';

/// Full interactive astrolabe simulation and solar elevation calculation screen.
class AstrolabeSimulatorScreen extends StatefulWidget {
  final AstrolabeSimulatorController controller;

  const AstrolabeSimulatorScreen({
    super.key,
    required this.controller,
  });

  @override
  State<AstrolabeSimulatorScreen> createState() => _AstrolabeSimulatorScreenState();
}

class _AstrolabeSimulatorScreenState extends State<AstrolabeSimulatorScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: const Text('مُحَاكِي الأَسْطُرْلاَبِ الفَلَكِيِّ (Simulator)'),
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
                  // Location Tympan Selector
                  _buildTympanSelector(ctrl),
                  const SizedBox(height: 16),
                  // Instrument Virtual Visualization Canvas
                  _buildInstrumentCanvas(ctrl),
                  const SizedBox(height: 16),
                  // Astronomical Readout Telemetry Box
                  _buildTelemetryReadout(ctrl),
                  const SizedBox(height: 16),
                  // Sighting Alidade Slider Controls
                  _buildControlSliders(ctrl),
                  const SizedBox(height: 16),
                  // Interactive Learning Challenge Card
                  _buildChallengeCard(ctrl),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTympanSelector(AstrolabeSimulatorController ctrl) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: ctrl.activeLocationIndex,
          isExpanded: true,
          items: List.generate(AstrolabeSimulatorController.locations.length, (index) {
            final loc = AstrolabeSimulatorController.locations[index];
            return DropdownMenuItem(
              value: index,
              child: Text(
                'صَفِيحَةُ: ${loc.nameAr}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F172A)),
                textDirection: TextDirection.rtl,
              ),
            );
          }),
          onChanged: (val) {
            if (val != null) ctrl.selectLocation(val);
          },
        ),
      ),
    );
  }

  Widget _buildInstrumentCanvas(AstrolabeSimulatorController ctrl) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
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
          // Outer Brass Limb (الـطَّوْقُ)
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFD97706), width: 6),
              color: const Color(0xFF1E293B),
            ),
          ),
          // Inner Tympan Grid & Horizon Lines
          Container(
            width: 170,
            height: 170,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF475569), width: 1.5),
            ),
            child: const Center(
              child: Text(
                'خَطُّ الأُفُقِ\nHorizon',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
              ),
            ),
          ),
          // Rotating Rete Simulation (الشَّبَكَةُ العَنْكَبُوتِيَّةُ)
          Transform.rotate(
            angle: ctrl.reteAngle * (3.14159 / 180.0),
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF5EEAD4).withOpacity(0.6), width: 2),
              ),
              child: const Align(
                alignment: Alignment.topCenter,
                child: Icon(Icons.star, size: 14, color: Color(0xFF5EEAD4)),
              ),
            ),
          ),
          // Sighting Alidade Rule (العِضَادَةُ)
          Transform.rotate(
            angle: -ctrl.alidadeAngle * (3.14159 / 180.0),
            child: Container(
              width: 190,
              height: 10,
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B),
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 4)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 8, height: 16, color: const Color(0xFFB45309)),
                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                  Container(width: 8, height: 16, color: const Color(0xFFB45309)),
                ],
              ),
            ),
          ),
          // Center Pivot Pin (القُطْبُ وَالفَرَسُ)
          Container(
            width: 14,
            height: 14,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 4)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTelemetryReadout(AstrolabeSimulatorController ctrl) {
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
          _buildTelemetryMetric(
            label: 'زَاوِيَةُ الِارتِفَاعِ',
            sublabel: 'Altitude (θ)',
            value: '${ctrl.alidadeAngle.toStringAsFixed(1)}°',
            color: const Color(0xFF0F766E),
          ),
          Container(width: 1, height: 40, color: const Color(0xFF99F6E4)),
          _buildTelemetryMetric(
            label: 'الظِّلُّ المَبْسُوطُ',
            sublabel: 'Umbra Recta',
            value: '${ctrl.horizontalShadowDigits.toStringAsFixed(1)} إِصْبَعًا',
            color: const Color(0xFF0F766E),
          ),
          Container(width: 1, height: 40, color: const Color(0xFF99F6E4)),
          _buildTelemetryMetric(
            label: 'دَوَرَانُ الفَلَكِ',
            sublabel: 'Diurnal Rete',
            value: '${ctrl.reteAngle.toStringAsFixed(0)}°',
            color: const Color(0xFF2563EB),
          ),
        ],
      ),
    );
  }

  Widget _buildTelemetryMetric({
    required String label,
    required String sublabel,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
        Text(sublabel, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
      ],
    );
  }

  Widget _buildControlSliders(AstrolabeSimulatorController ctrl) {
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
              const Text('تَصْوِيبُ العِضَادَةِ (Alidade Elevation)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text('${ctrl.alidadeAngle.toStringAsFixed(1)}°', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFD97706))),
            ],
          ),
          Slider(
            value: ctrl.alidadeAngle,
            min: 0.0,
            max: 90.0,
            divisions: 90,
            activeColor: const Color(0xFFD97706),
            onChanged: ctrl.setAlidadeAngle,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('تَدْوِيرُ الشَّبَكَةِ العَنْكَبُوتِيَّةِ (Rete Rotation)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text('${ctrl.reteAngle.toStringAsFixed(0)}°', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
            ],
          ),
          Slider(
            value: ctrl.reteAngle,
            min: 0.0,
            max: 360.0,
            divisions: 72,
            activeColor: const Color(0xFF2563EB),
            onChanged: ctrl.setReteAngle,
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard(AstrolabeSimulatorController ctrl) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ctrl.isChallengeCompleted ? const Color(0xFFECFDF5) : const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ctrl.isChallengeCompleted ? const Color(0xFF059669) : const Color(0xFFFDE68A),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            ctrl.isChallengeCompleted ? Icons.verified : Icons.help_outline,
            color: ctrl.isChallengeCompleted ? const Color(0xFF059669) : const Color(0xFFD97706),
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ctrl.isChallengeCompleted ? 'تَمَّ إِنْجَازُ التَّحَدِّي العِلْمِيِّ!' : 'تَحَدِّي الرَّصْدِ الفَلَكِيِّ:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: ctrl.isChallengeCompleted ? const Color(0xFF065F46) : const Color(0xFF92400E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  ctrl.isChallengeCompleted
                    ? 'عِنْدَ زَاوِيَةِ 45° يَتَسَاوَى ارْتِفَاعُ الشَّاخِصِ مَعَ ظِلِّهِ تَمَامًا (1:1).'
                    : 'اضْبِطِ العِضَادَةَ عَلَى زَاوِيَةِ 45° لِتُحَقِّقَ تَسَاوِيَ الظِّلِّ مَعَ الشَّاخِصِ.',
                  style: TextStyle(
                    fontSize: 12,
                    color: ctrl.isChallengeCompleted ? const Color(0xFF047857) : const Color(0xFF78350F),
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
