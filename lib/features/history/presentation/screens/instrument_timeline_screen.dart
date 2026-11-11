import 'package:flutter/material.dart';
import '../controllers/instrument_timeline_controller.dart';

/// Full interactive historical instrument timeline and discovery screen.
class InstrumentTimelineScreen extends StatefulWidget {
  final InstrumentTimelineController controller;
  final void Function(TimelineInstrumentItem item)? onOpenInstrumentCategory;

  const InstrumentTimelineScreen({
    super.key,
    required this.controller,
    this.onOpenInstrumentCategory,
  });

  @override
  State<InstrumentTimelineScreen> createState() => _InstrumentTimelineScreenState();
}

class _InstrumentTimelineScreenState extends State<InstrumentTimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;
        final era = ctrl.activeEra;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: const Text('خَطُّ زَمَنِ الآلاَتِ العِلْمِيَّةِ (Timeline)'),
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Era Selector Horizontal Stepper
                _buildEraStepper(ctrl),
                // Era Details Banner
                if (era != null) _buildEraBanner(era),
                // Instruments List
                Expanded(
                  child: _buildInstrumentsList(ctrl),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEraStepper(InstrumentTimelineController ctrl) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: List.generate(ctrl.eras.length, (index) {
            final era = ctrl.eras[index];
            final isSelected = index == ctrl.activeEraIndex;

            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                selectedColor: const Color(0xFF0F172A),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF334155),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                label: Text(era.century),
                selected: isSelected,
                onSelected: (_) => ctrl.selectEra(index),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildEraBanner(dynamic era) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF1F5F9),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            era.nameAr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Amiri', color: Color(0xFF0F172A)),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 4),
          Text(
            '${era.nameDe} • ${era.nameEn}',
            style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6.0,
            runSpacing: 4.0,
            children: (era.primaryScholars as List<String>).map((scholar) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Text('عَالِمٌ: $scholar', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF0F766E))),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInstrumentsList(InstrumentTimelineController ctrl) {
    final instruments = ctrl.activeInstruments;

    if (instruments.isEmpty) {
      return const Center(child: Text('لاَ تُوجَدُ آلاَتٌ مُسَجَّلَةٌ فِي هَذَا العَصْرِ حَالِيًّا.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: instruments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final item = instruments[index];

        return Container(
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              Text(
                item.nameAr,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Amiri', color: Color(0xFF0F172A)),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 4),
              Text(
                '${item.nameDe} • ${item.nameEn}',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF475569)),
              ),
              const SizedBox(height: 10),
              // Historical Description
              Text(
                item.historicalNoteAr,
                style: const TextStyle(fontSize: 14, color: Color(0xFF334155)),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 14),
              // Action Button
              SizedBox(
                height: 40,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D9488),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    ctrl.markInstrumentExplored(item.id);
                    widget.onOpenInstrumentCategory?.call(item);
                  },
                  icon: const Icon(Icons.menu_book, size: 18),
                  label: const Text('ادْرُسِ الآلَةَ وَالمُصْطَلَحَاتِ (Study)'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
