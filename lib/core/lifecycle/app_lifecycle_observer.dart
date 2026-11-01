import 'package:flutter/widgets.dart';
import '../logging/app_logger.dart';

class AppLifecycleObserver with WidgetsBindingObserver {
  final Future<void> Function()? onPauseOrBackground;
  final VoidCallback? onResume;

  AppLifecycleObserver({this.onPauseOrBackground, this.onResume});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    AppLogger.info('AppLifecycle changed to: $state', tag: 'LIFECYCLE');
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      onPauseOrBackground?.call();
    } else if (state == AppLifecycleState.resumed) {
      onResume?.call();
    }
  }
}
