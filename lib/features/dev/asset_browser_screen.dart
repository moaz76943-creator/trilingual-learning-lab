import 'package:flutter/material.dart';
import '../../core/widgets/smart_vector_image.dart';

/// شاشة استعراض الأصول الرسومية للمطور والمدقق الداخلي
class AssetBrowserScreen extends StatefulWidget {
  const AssetBrowserScreen({super.key});

  @override
  State<AssetBrowserScreen> createState() => _AssetBrowserScreenState();
}

class _AssetBrowserScreenState extends State<AssetBrowserScreen> {
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    final allKeys = [
      'c152_001', 'c153_001', 'c154_001', 'c155_001', 'c156_001',
      'c157_001', 'c158_001', 'c159_001', 'c160_001', 'c161_001',
      'c162_001', 'c163_001', 'c164_001', 'c165_001', 'c166_001',
      'c167_001', 'c168_001', 'c169_001', 'c170_001', 'c171_001'
    ];
    final filtered = _filter.isEmpty
        ? allKeys
        : allKeys.where((k) => k.contains(_filter.toLowerCase())).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('مستعرض الأصول المتجهة (Dev)'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'تصفية حسب معرف الرسم...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() => _filter = val),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final key = filtered[index];
                return Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmartVectorImage(conceptId: key, width: 40, height: 40),
                      const SizedBox(height: 4),
                      Text(key, style: const TextStyle(fontSize: 10)),
                    ],
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
