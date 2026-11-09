import 'package:flutter/material.dart';
import 'package:trilingual_learning_lab/core/router/app_router.dart';
import 'package:trilingual_learning_lab/core/storage/secure_storage_service.dart';
import 'package:trilingual_learning_lab/data/unified_content_repository.dart';
import 'package:trilingual_learning_lab/repositories/progress_repository.dart';
import 'package:trilingual_learning_lab/repositories/srs_repository.dart';

/// State of the initial application bootstrap gate.
enum BootstrapStatus {
  initializing,
  ready,
  failed,
}

/// Verifiable Splash Screen checking real repository and persistence health
/// before navigating to home, preventing blank screens or unmounted setState calls.
class SplashScreen extends StatefulWidget {
  final Future<bool> Function()? customInitializer;

  const SplashScreen({
    super.key,
    this.customInitializer,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  BootstrapStatus _status = BootstrapStatus.initializing;
  String _statusMessage = 'جاري تهيئة بيئة التعلم الثلاثية...';

  @override
  void initState() {
    super.initState();
    _runRealBootstrap();
  }

  Future<void> _runRealBootstrap() async {
    if (!mounted) return;
    setState(() {
      _status = BootstrapStatus.initializing;
      _statusMessage = 'جاري تحميل المعاجم والقواعد والتقدم...';
    });

    try {
      if (widget.customInitializer != null) {
        final success = await widget.customInitializer!();
        if (!mounted) return;
        if (success) {
          _navigateToHome();
        } else {
          _handleFailure('فشل التحقق من صحة المكونات المخصصة.');
        }
        return;
      }

      // Real health gate: parallel verification of content repository and persistence stores
      final results = await Future.wait([
        UnifiedContentRepository().preload(),
        ProgressRepository().init().then((_) => true).catchError((_) => false),
        SrsRepository().init().then((_) => true).catchError((_) => false),
        SecureStorageService().init().then((_) => true).catchError((_) => false),
      ]);

      if (!mounted) return;

      final allHealthy = results.every((r) => r == true);
      if (allHealthy) {
        _status = BootstrapStatus.ready;
        _navigateToHome();
      } else {
        _handleFailure('تعذر تحميل بعض ملفات المحتوى أو قواعد التخزين المحلية.');
      }
    } catch (e) {
      if (!mounted) return;
      _handleFailure('حدث خطأ أثناء التهيئة: $e');
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  void _handleFailure(String error) {
    setState(() {
      _status = BootstrapStatus.failed;
      _statusMessage = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E293B),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or App Emblem
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: Colors.amber.shade700,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  size: 54,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'مختبر اللغات الثلاث',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Trilingual Learning Lab • Arabisch, Deutsch, Englisch',
                style: TextStyle(fontSize: 13, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              if (_status == BootstrapStatus.initializing) ...[
                const CircularProgressIndicator(color: Colors.amber),
                const SizedBox(height: 20),
                Text(
                  _statusMessage,
                  style: const TextStyle(fontSize: 14, color: Colors.white60),
                  textAlign: TextAlign.center,
                ),
              ] else if (_status == BootstrapStatus.failed) ...[
                const Icon(Icons.warning_amber_rounded, size: 48, color: Colors.redAccent),
                const SizedBox(height: 16),
                Text(
                  _statusMessage,
                  style: const TextStyle(fontSize: 14, color: Colors.redAccent),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _runRealBootstrap,
                  icon: const Icon(Icons.refresh),
                  label: const Text('إعادة المحاولة'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade700,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
