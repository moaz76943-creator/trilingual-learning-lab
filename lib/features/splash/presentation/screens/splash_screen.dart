import 'package:flutter/material.dart';
import '../../../../core/routing/route_guards.dart';

class SplashScreen extends StatefulWidget {
  final Future<void> Function()? onInitialize;
  final VoidCallback onReady;

  const SplashScreen({
    super.key,
    this.onInitialize,
    required this.onReady,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.1;
  String _statusMessage = 'جاري تهيئة بيئة اللغات الثلاث...';

  @override
  void initState() {
    super.initState();
    _startInitialization();
  }

  Future<void> _startInitialization() async {
    try {
      setState(() {
        _progress = 0.3;
        _statusMessage = 'تحميل المفردات والأفعال الحياتية...';
      });

      if (widget.onInitialize != null) {
        await widget.onInitialize!();
      } else {
        await Future.delayed(const Duration(milliseconds: 600));
      }

      setState(() {
        _progress = 0.8;
        _statusMessage = 'فهرسة الجمل التفاعلية والمتجهات...';
      });

      await Future.delayed(const Duration(milliseconds: 300));

      setState(() {
        _progress = 1.0;
        _statusMessage = 'اكتملت الجاهزية!';
      });

      ContentReadyGuard.markContentReady();
      await Future.delayed(const Duration(milliseconds: 200));

      if (mounted) {
        widget.onReady();
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'حدث خطأ أثناء التهيئة: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B5E20), // أخضر غابي وقور ومريح
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.translate_rounded,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 24),
                const Text(
                  'المختبر اللغوي الثلاثي',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'العربية • Deutsch • English',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 48),
                LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF81C784)),
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
                const SizedBox(height: 16),
                Text(
                  _statusMessage,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
