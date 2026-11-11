import 'package:flutter/material.dart';
import '../controllers/analytics_dashboard_controller.dart';

/// Full interactive user study analytics, streaks, and scholar milestones dashboard.
class AnalyticsDashboardScreen extends StatefulWidget {
  final AnalyticsDashboardController controller;

  const AnalyticsDashboardScreen({
    super.key,
    required this.controller,
  });

  @override
  State<AnalyticsDashboardScreen> createState() => _AnalyticsDashboardScreenState();
}

class _AnalyticsDashboardScreenState extends State<AnalyticsDashboardScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.controller.summary == null) {
      widget.controller.loadAnalytics();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: const Text('لَوْحَةُ الإِنْجَازِ وَعَادَاتِ التَّعَلُّمِ'),
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'تَحْدِيثُ الإِحْصَائِيَّاتِ',
                onPressed: ctrl.loadAnalytics,
              ),
            ],
          ),
          body: SafeArea(
            child: ctrl.isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildBody(context, ctrl),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, AnalyticsDashboardController ctrl) {
    final summary = ctrl.summary;
    if (summary == null) return const SizedBox.shrink();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero Streak Banner
          _buildStreakHeroBanner(summary),
          const SizedBox(height: 16),
          // Metric Scorecards Grid
          _buildMetricsGrid(summary),
          const SizedBox(height: 20),
          // Scholar Milestone Badges
          _buildMilestoneBadgesSection(summary),
        ],
      ),
    );
  }

  Widget _buildStreakHeroBanner(UserAnalyticsSummary summary) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.local_fire_department, size: 44, color: Color(0xFFF59E0B)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${summary.currentStreak} أَيَّامٍ مُتَتَابِعَةٍ!',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Amiri'),
                ),
                const SizedBox(height: 4),
                Text(
                  'أَطْوَلُ سِلْسِلَةٍ: ${summary.longestStreak} أَيَّامٍ | مَجْمُوعُ الأَيَّامِ: ${summary.totalStudyDays}',
                  style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(UserAnalyticsSummary summary) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            label: 'نِسْبَةُ التَّذَكُّرِ',
            value: '${summary.retentionRate.toStringAsFixed(0)}%',
            icon: Icons.psychology,
            iconColor: const Color(0xFF059669),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildMetricCard(
            label: 'المُفْرَدَاتُ المُتْقَنَةُ',
            value: '${summary.totalCardsMastered}',
            icon: Icons.check_circle_outline,
            iconColor: const Color(0xFF0D9488),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildMetricCard(
            label: 'التَّصْنِيفَاتُ المُتَمَّةُ',
            value: '${summary.completedCategories}',
            icon: Icons.folder_special,
            iconColor: const Color(0xFF2563EB),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String label,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: iconColor),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneBadgesSection(UserAnalyticsSummary summary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'أَوْسِمَةُ العُلَمَاءِ وَالمَحَطَّاتِ العِلْمِيَّةِ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: summary.badges.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final badge = summary.badges[index];
            return Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: badge.isUnlocked ? const Color(0xFFFDE68A) : const Color(0xFFE2E8F0),
                  width: badge.isUnlocked ? 1.5 : 1.0,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: badge.isUnlocked ? const Color(0xFFFEF3C7) : const Color(0xFFF1F5F9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      badge.isUnlocked ? Icons.workspace_premium : Icons.lock_outline,
                      color: badge.isUnlocked ? const Color(0xFFD97706) : const Color(0xFF94A3B8),
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          badge.titleAr,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: badge.isUnlocked ? const Color(0xFF0F172A) : const Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          badge.scholarName,
                          style: const TextStyle(fontSize: 11, color: Color(0xFF0D9488), fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          badge.requirementDescription,
                          style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
