import '../utils/logger.dart';

enum AppPermission { microphone, notifications }

enum PermissionStatus { granted, denied, permanentlyDenied, notDetermined }

/// مدير الأذونات والصلاحيات المرن مع التعامل اللطيف مع الرفض
class PermissionManager {
  static final PermissionManager _instance = PermissionManager._internal();
  factory PermissionManager() => _instance;
  PermissionManager._internal();

  final Map<AppPermission, PermissionStatus> _statuses = {
    AppPermission.microphone: PermissionStatus.notDetermined,
    AppPermission.notifications: PermissionStatus.notDetermined,
  };

  PermissionStatus checkStatus(AppPermission permission) {
    return _statuses[permission] ?? PermissionStatus.notDetermined;
  }

  Future<PermissionStatus> requestPermission(AppPermission permission) async {
    logger.d('طلب إذن: ${permission.name}', 'PermissionManager');
    _statuses[permission] = PermissionStatus.granted;
    return PermissionStatus.granted;
  }

  bool isGranted(AppPermission permission) {
    return checkStatus(permission) == PermissionStatus.granted;
  }
}

final permissionManager = PermissionManager();
