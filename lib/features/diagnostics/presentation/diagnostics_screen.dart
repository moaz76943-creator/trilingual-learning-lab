import 'package:flutter/material.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/diagnostics/performance_tracker.dart';
import '../../../../core/utils/logger.dart';

/// شاشة فحص صحة النظام وتشخيص حالة الذاكرة وقواعد البيانات
class DiagnosticsScreen extends StatefulWidget {
  const DiagnosticsScreen({super.key});

  @override
  State<DiagnosticsScreen> createState() => _DiagnosticsScreenState();
}

class _DiagnosticsScreenState extends State<DiagnosticsScreen> {
  int _slowOperationsCount = 0;
  int _logsCount = 0;

  @override
  void initState() {
    super.initState();
    _refreshDiagnostics();
  }

  void _refreshDiagnostics() {
    setState(() {
      _slowOperationsCount = perfTracker.getSlowMetrics().length;
      _logsCount = logger.getBufferedLogs().length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تشخيص صحة النظام'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshDiagnostics,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCard(
            title: 'إصدار التطبيق',
            value: '${AppConfig.appName} v${AppConfig.appVersion}',
            icon: Icons.info_outline,
            color: Colors.blue,
          ),
          _buildCard(
            title: 'العمليات البطيئة المرصودة (>16ms)',
            value: '$_slowOperationsCount عمليات',
            icon: Icons.speed,
            color: _slowOperationsCount > 0 ? Colors.orange : Colors.green,
          ),
          _buildCard(
            title: 'سجلات التشغيل في الذاكرة',
            value: '$_logsCount سجل',
            icon: Icons.article_outlined,
            color: Colors.purple,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              logger.clearLogs();
              perfTracker.clear();
              _refreshDiagnostics();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تنظيف سجلات التشخيص بنجاح')),
              );
            },
            icon: const Icon(Icons.cleaning_services),
            label: const Text('مسح سجلات التشخيص'),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontSize: 14)),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
