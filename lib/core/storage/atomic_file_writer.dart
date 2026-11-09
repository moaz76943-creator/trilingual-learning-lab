import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

/// Utility providing atomic write operations and automatic backup recovery
/// preventing zero-byte corruption or data loss during system crashes.
class AtomicFileWriter {
  /// Safely writes content to target file via atomic rename and backup protection.
  static Future<bool> safeWriteFile({
    required File targetFile,
    required String content,
  }) async {
    final parentDir = targetFile.parent;
    if (!await parentDir.exists()) {
      await parentDir.create(recursive: true);
    }

    final tempFile = File('${targetFile.path}.tmp');
    final backupFile = File('${targetFile.path}.bak');

    try {
      // 1. Write content to temporary file with strict OS flush
      await tempFile.writeAsString(content, flush: true);

      // 2. If target already exists, create safety backup before replacement
      if (await targetFile.exists()) {
        try {
          if (await backupFile.exists()) {
            await backupFile.delete();
          }
          await targetFile.copy(backupFile.path);
        } catch (e) {
          debugPrint('Notice during backup creation: $e');
        }
      }

      // 3. Atomically rename temp file over target file
      // In Dart VM on POSIX/Android, rename() onto an existing file atomically replaces it
      // For cross-platform safety where rename can fail on Windows:
      if (Platform.isWindows && await targetFile.exists()) {
        await targetFile.delete();
      }
      await tempFile.rename(targetFile.path);

      return true;
    } catch (e) {
      debugPrint('Fatal error during safeWriteFile: $e');
      // Emergency rollback from backup if target was corrupted or missing
      if (await backupFile.exists() && (!await targetFile.exists() || await targetFile.length() == 0)) {
        try {
          await backupFile.copy(targetFile.path);
          debugPrint('Successfully recovered target file from backup.');
        } catch (recoverErr) {
          debugPrint('Failed to recover from backup: $recoverErr');
        }
      }
      return false;
    }
  }

  /// Safely reads string content from target file with automatic fallback to backup.
  static Future<String?> safeReadFile(File targetFile) async {
    final backupFile = File('${targetFile.path}.bak');

    if (await targetFile.exists()) {
      try {
        final content = await targetFile.readAsString();
        if (content.trim().isNotEmpty) {
          return content;
        }
      } catch (e) {
        debugPrint('Error reading target file: $e. Checking backup...');
      }
    }

    // Fallback to backup if target is unreadable or empty
    if (await backupFile.exists()) {
      try {
        debugPrint('Recovering from backup file: ${backupFile.path}');
        return await backupFile.readAsString();
      } catch (e) {
        debugPrint('Failed to read backup file: $e');
      }
    }

    return null;
  }
}
