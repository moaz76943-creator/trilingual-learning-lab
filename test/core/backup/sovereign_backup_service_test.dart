import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/backup/sovereign_backup_service.dart';

void main() {
  group('SovereignBackupService Cryptographic Export/Import', () {
    test('calculateSha256 produces deterministic standard SHA-256 hash', () {
      // Known test vectors:
      // sha256("") = e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
      expect(
        SovereignBackupService.calculateSha256(''),
        equals('e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
      );

      // sha256("Trilingual") = 5fcfbe46487e41ca3ee7fa0a54ffc93a0caec487bf58cf1ef453fc95eb561c28
      final hash = SovereignBackupService.calculateSha256('Trilingual');
      expect(hash.length, equals(64));
    });

    test('Exports data and successfully imports with verified checksum', () {
      final fixedDate = DateTime(2026, 11, 10, 12, 0, 0);
      final rawExport = SovereignBackupService.exportToJson(
        progress: {'completed_categories': ['cat_astrolabe_001'], 'streak': 15},
        srsCards: [
          {'id': 'card_001', 'ease_factor': 2.5, 'interval': 6, 'repetitions': 2}
        ],
        settings: {'daily_target': 20, 'theme': 'heritage_sepia'},
        timestamp: fixedDate,
      );

      expect(rawExport.contains('checksum'), isTrue);
      expect(rawExport.contains('cat_astrolabe_001'), isTrue);

      final restored = SovereignBackupService.importFromJson(rawExport);

      expect(restored.schemaVersion, equals(1));
      expect(restored.exportedAt, equals(fixedDate));
      expect(restored.progress['streak'], equals(15));
      expect(restored.srsCards.length, equals(1));
      expect(restored.srsCards.first['id'], equals('card_001'));
      expect(restored.settings['theme'], equals('heritage_sepia'));
    });

    test('Rejects tampered backup with BackupTamperedException', () {
      final rawExport = SovereignBackupService.exportToJson(
        progress: {'streak': 5},
        srsCards: [],
        settings: {},
      );

      // Modify the inner payload streak without recalculating checksum
      final parsed = jsonDecode(rawExport) as Map<String, dynamic>;
      final data = parsed['data'] as Map<String, dynamic>;
      final payload = data['payload'] as Map<String, dynamic>;
      payload['progress']['streak'] = 999; // Tampered value!

      final tamperedJson = jsonEncode(parsed);

      expect(
        () => SovereignBackupService.importFromJson(tamperedJson),
        throwsA(isA<BackupTamperedException>()),
      );
    });

    test('Rejects incompatible schema version with UnsupportedBackupVersionException', () {
      final fixedDate = DateTime(2026, 11, 10);
      final body = {
        'schema_version': 99, // Future unsupported version
        'exported_at': fixedDate.toIso8601String(),
        'payload': {},
      };
      final checksum = SovereignBackupService.calculateSha256(jsonEncode(body));
      final container = jsonEncode({'checksum': checksum, 'data': body});

      expect(
        () => SovereignBackupService.importFromJson(container),
        throwsA(isA<UnsupportedBackupVersionException>()),
      );
    });
  });
}
