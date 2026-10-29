import 'package:flutter/material.dart';
import '../engine/srs_service.dart';

class MasteryDashboardScreen extends StatelessWidget {
  const MasteryDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة الإتقان اللغوي الشاملة | Dashboard'),
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMilestoneBanner(),
            const SizedBox(height: 16),
            _buildMetricsGrid(),
            const SizedBox(height: 16),
            _buildMasteryLevelsBreakdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildMilestoneBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade700, Colors.amber.shade900],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(Icons.emoji_events, size: 48, color: Colors.white),
          SizedBox(height: 8),
          Text(
            'CYCLE 150: الإطلاق الذهبي الشامل',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'منظومة متكاملة لتعلم العربية والألمانية والإنجليزية بوضع Offline 100%',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _metricCard('90 فئة', 'مفردات أكاديمية وتخصصية', Icons.menu_book, Colors.blue),
        _metricCard('24 محركاً', 'أفعال B2/C1 وتصريفات', Icons.psychology, Colors.purple),
        _metricCard('375 جملة', 'بناء تراكيب تفاعلية', Icons.create, Colors.teal),
        _metricCard('1,031+ أيقونة', 'أصول SVG مدمجة', Icons.palette, Colors.orange),
      ],
    );
  }

  Widget _metricCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
          const SizedBox(height: 2),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildMasteryLevelsBreakdown() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('مستويات الذاكرة (خوارزمية SM-2)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Divider(),
            ListTile(leading: Text('🌱'), title: Text('مبتدئ (Novice)'), subtitle: Text('كلمات مستوردة حديثاً')),
            ListTile(leading: Text('⭐'), title: Text('متمكن (Proficient)'), subtitle: Text('استرجاع بعد 6 أيام')),
            ListTile(leading: Text('🔥'), title: Text('معجم دائم (Permanent Lexicon)'), subtitle: Text('تثبيت مطلق دون نسيان')),
          ],
        ),
      ),
    );
  }
}
