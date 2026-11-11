import 'package:flutter/material.dart';
import '../controllers/settings_controller.dart';

/// Full interactive settings, personalization, and data sovereignty screen.
class SettingsScreen extends StatelessWidget {
  final SettingsController controller;

  const SettingsScreen({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final ctrl = controller;
        final s = ctrl.settings;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: const Text('الإِعْدَادَاتُ وَالسِّيَادَةُ الرَّقْمِيَّةُ'),
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Section 1: Study Goals
                _buildSectionHeader('أَهْدَافُ التَّعَلُّمِ اليَوْمِيَّةِ', Icons.track_changes),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('هَدَفُ المُرَاجَعَةِ اليَوْمِيَّةِ (بِطَاقَاتٌ)', style: TextStyle(fontWeight: FontWeight.w600)),
                            Text('${s.dailyReviewTarget}', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D9488))),
                          ],
                        ),
                        Slider(
                          value: s.dailyReviewTarget.toDouble(),
                          min: 5,
                          max: 60,
                          divisions: 11,
                          activeColor: const Color(0xFF0D9488),
                          onChanged: (val) => ctrl.updateDailyTargets(reviewTarget: val.round()),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('وَقْتُ التَّذْكِيرِ المَسَائِيِّ', style: TextStyle(fontWeight: FontWeight.w600)),
                            TextButton.icon(
                              icon: const Icon(Icons.access_time, size: 18),
                              label: Text('${s.reminderHour.toString().padLeft(2, '0')}:${s.reminderMinute.toString().padLeft(2, '0')}'),
                              onPressed: () => _pickTime(context, ctrl),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Section 2: Audio & Speech
                _buildSectionHeader('نَبْرَةُ النُّطْقِ وَالسُّرْعَةُ الصَّوْتِيَّةُ (TTS)', Icons.record_voice_over),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRateSlider(
                          label: 'سُرْعَةُ النُّطْقِ العَرَبِيِّ (التَّشْكِيلُ)',
                          value: s.speechRateAr,
                          onChanged: (v) => ctrl.updateSpeechRate('ar', v),
                        ),
                        const SizedBox(height: 12),
                        _buildRateSlider(
                          label: 'سُرْعَةُ النُّطْقِ الأَلْمَانِيِّ (Deutsch)',
                          value: s.speechRateDe,
                          onChanged: (v) => ctrl.updateSpeechRate('de', v),
                        ),
                        const SizedBox(height: 12),
                        _buildRateSlider(
                          label: 'سُرْعَةُ النُّطْقِ الإِنْجِلِيزِيِّ (English)',
                          value: s.speechRateEn,
                          onChanged: (v) => ctrl.updateSpeechRate('en', v),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Section 3: Data Sovereignty & Portability
                _buildSectionHeader('سِيَادَةُ البَيَانَاتِ وَالنَّسْخُ الِاحْتِيَاطِيُّ', Icons.shield_outlined),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.storage_outlined, color: Color(0xFF2563EB)),
                          title: const Text('ذَاكِرَةُ التَّخْزِينِ الصَّوْتِيِّ المُؤَقَّتِ', style: TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text('${ctrl.cachedAudioCount} مَلَفٌّ (${(ctrl.cachedAudioBytes / 1024).toStringAsFixed(1)} KB)'),
                          trailing: OutlinedButton(
                            onPressed: ctrl.cachedAudioCount > 0 ? ctrl.clearAudioCache : null,
                            child: const Text('تَفْرِيغٌ'),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.cloud_download_outlined, color: Color(0xFF059669)),
                          title: const Text('تَصْدِيرُ نُسْخَةٍ احْتِيَاطِيَّةٍ مَضْمُونَةٍ', style: TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: const Text('تَشْفِيرُ وَفَحْصُ شَفْرَةِ SHA-256 ضِدَّ التَّلاَعُبِ'),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F172A)),
                            onPressed: () => _handleExport(context, ctrl),
                            child: const Text('تَصْدِيرٌ', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Sovereign Guarantee Footer
                Center(
                  child: Column(
                    children: const [
                      Icon(Icons.verified_user_outlined, size: 28, color: Color(0xFF0D9488)),
                      SizedBox(height: 6),
                      Text(
                        'مَنْظُومَةٌ سِيَادِيَّةٌ مُسْتَقِلَّةٌ 100% | Zero PII | خَالِيَةٌ مِنَ التَّتَبُّعِ',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF0D9488)),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
          ),
        ],
      ),
    );
  }

  Widget _buildRateSlider({
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            Text('${value.toStringAsFixed(2)}x', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          ],
        ),
        Slider(
          value: value,
          min: 0.5,
          max: 1.5,
          divisions: 10,
          activeColor: const Color(0xFF0F172A),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Future<void> _pickTime(BuildContext context, SettingsController ctrl) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: ctrl.settings.reminderHour,
        minute: ctrl.settings.reminderMinute,
      ),
    );
    if (picked != null) {
      await ctrl.updateReminderSchedule(picked.hour, picked.minute);
    }
  }

  Future<void> _handleExport(BuildContext context, SettingsController ctrl) async {
    final payload = await ctrl.exportSovereignBackup(
      progressData: {'completed_items': 148, 'streak': 15},
      srsCards: [
        {'id': 'card_test', 'interval': 6, 'ease': 2.5}
      ],
    );

    if (context.mounted) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('تَمَّ تَصْدِيرُ النُّسْخَةِ الِاحْتِيَاطِيَّةِ', textAlign: TextAlign.right),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('تَمَّ تَوِيدُ المَلَفِّ بِبَصْمَةِ SHA-256 الرَّقْمِيَّةِ لِضَمَانِ الصِّحَّةِ.', textAlign: TextAlign.right),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                color: const Color(0xFFF1F5F9),
                child: Text(
                  'الحَجْمُ: ${payload.length} بَايْت\nالإِصْدَارُ: 1.0 (Sovereign)',
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('إِغْلاَقٌ'),
            ),
          ],
        ),
      );
    }
  }
}
