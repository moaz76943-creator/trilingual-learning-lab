import 'dart:convert';
import 'package:flutter/foundation.dart';

/// Exception thrown when a backup file fails cryptographic integrity verification.
class BackupTamperedException implements Exception {
  final String message;
  const BackupTamperedException([this.message = 'Backup checksum mismatch: File has been altered or corrupted.']);

  @override
  String toString() => 'BackupTamperedException: $message';
}

/// Exception thrown when the backup format version is incompatible.
class UnsupportedBackupVersionException implements Exception {
  final int foundVersion;
  final int supportedVersion;
  const UnsupportedBackupVersionException(this.foundVersion, this.supportedVersion);

  @override
  String toString() => 'UnsupportedBackupVersionException: Version $foundVersion is not supported (Expected $supportedVersion).';
}

/// Structured container holding verified restored data.
class SovereignBackupData {
  final int schemaVersion;
  final DateTime exportedAt;
  final Map<String, dynamic> progress;
  final List<Map<String, dynamic>> srsCards;
  final Map<String, dynamic> settings;

  const SovereignBackupData({
    required this.schemaVersion,
    required this.exportedAt,
    required this.progress,
    required this.srsCards,
    required this.settings,
  });
}

/// Service managing offline export, import, and cryptographic verification of user data.
class SovereignBackupService {
  static const int currentSchemaVersion = 1;

  /// Pure-Dart SHA-256 implementation ensuring zero external package lock-in.
  static String calculateSha256(String input) {
    final bytes = utf8.encode(input);
    final bitLength = bytes.length * 8;

    // Pre-processing: padding
    final paddedList = <int>[...bytes, 0x80];
    while ((paddedList.length % 64) != 56) {
      paddedList.add(0);
    }

    // Append length in bits as 64-bit big-endian integer
    for (var i = 7; i >= 0; i--) {
      paddedList.add((bitLength >> (i * 8)) & 0xFF);
    }

    // Initial hash values (first 32 bits of fractional parts of square roots of first 8 primes)
    var h0 = 0x6a09e667;
    var h1 = 0xbb67ae85;
    var h2 = 0x3c6ef372;
    var h3 = 0xa54ff53a;
    var h4 = 0x510e527f;
    var h5 = 0x9b05688c;
    var h6 = 0x1f83d9ab;
    var h7 = 0x5be0cd19;

    // Constants (first 32 bits of fractional parts of cube roots of first 64 primes)
    const k = <int>[
      0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
      0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
      0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
      0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
      0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
      0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
      0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
      0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
    ];

    int rotr(int x, int n) => ((x >> n) | (x << (32 - n))) & 0xFFFFFFFF;

    // Process the message in successive 512-bit (64-byte) chunks
    for (var chunkStart = 0; chunkStart < paddedList.length; chunkStart += 64) {
      final w = List<int>.filled(64, 0);
      for (var i = 0; i < 16; i++) {
        final bIndex = chunkStart + (i * 4);
        w[i] = ((paddedList[bIndex] << 24) |
                (paddedList[bIndex + 1] << 16) |
                (paddedList[bIndex + 2] << 8) |
                paddedList[bIndex + 3]) & 0xFFFFFFFF;
      }

      for (var i = 16; i < 64; i++) {
        final s0 = rotr(w[i - 15], 7) ^ rotr(w[i - 15], 18) ^ (w[i - 15] >> 3);
        final s1 = rotr(w[i - 2], 17) ^ rotr(w[i - 2], 19) ^ (w[i - 2] >> 10);
        w[i] = (w[i - 16] + s0 + w[i - 7] + s1) & 0xFFFFFFFF;
      }

      var a = h0;
      var b = h1;
      var c = h2;
      var d = h3;
      var e = h4;
      var f = h5;
      var g = h6;
      var h = h7;

      for (var i = 0; i < 64; i++) {
        final s1 = rotr(e, 6) ^ rotr(e, 11) ^ rotr(e, 25);
        final ch = (e & f) ^ ((~e) & g);
        final temp1 = (h + s1 + ch + k[i] + w[i]) & 0xFFFFFFFF;
        final s0 = rotr(a, 2) ^ rotr(a, 13) ^ rotr(a, 22);
        final maj = (a & b) ^ (a & c) ^ (b & c);
        final temp2 = (s0 + maj) & 0xFFFFFFFF;

        h = g;
        g = f;
        f = e;
        e = (d + temp1) & 0xFFFFFFFF;
        d = c;
        c = b;
        b = a;
        a = (temp1 + temp2) & 0xFFFFFFFF;
      }

      h0 = (h0 + a) & 0xFFFFFFFF;
      h1 = (h1 + b) & 0xFFFFFFFF;
      h2 = (h2 + c) & 0xFFFFFFFF;
      h3 = (h3 + d) & 0xFFFFFFFF;
      h4 = (h4 + e) & 0xFFFFFFFF;
      h5 = (h5 + f) & 0xFFFFFFFF;
      h6 = (h6 + g) & 0xFFFFFFFF;
      h7 = (h7 + h) & 0xFFFFFFFF;
    }

    String hex(int val) => val.toRadixString(16).padLeft(8, '0');
    return '${hex(h0)}${hex(h1)}${hex(h2)}${hex(h3)}${hex(h4)}${hex(h5)}${hex(h6)}${hex(h7)}';
  }

  /// Exports application state into a tamper-proof JSON string.
  static String exportToJson({
    required Map<String, dynamic> progress,
    required List<Map<String, dynamic>> srsCards,
    required Map<String, dynamic> settings,
    DateTime? timestamp,
  }) {
    final exportDate = timestamp ?? DateTime.now();
    final body = {
      'schema_version': currentSchemaVersion,
      'exported_at': exportDate.toIso8601String(),
      'payload': {
        'progress': progress,
        'srs_cards': srsCards,
        'settings': settings,
      },
    };

    final serializedBody = jsonEncode(body);
    final checksum = calculateSha256(serializedBody);

    final finalContainer = {
      'checksum': checksum,
      'data': body,
    };

    return const JsonEncoder.withIndent('  ').convert(finalContainer);
  }

  /// Validates integrity and decodes backup file content.
  static SovereignBackupData importFromJson(String rawJson) {
    final dynamic container = jsonDecode(rawJson);
    if (container is! Map<String, dynamic>) {
      throw const FormatException('Invalid backup structure: Root must be a JSON object.');
    }

    final recordedChecksum = container['checksum'] as String?;
    final body = container['data'] as Map<String, dynamic>?;

    if (recordedChecksum == null || body == null) {
      throw const FormatException('Corrupted backup: Missing cryptographic checksum or data body.');
    }

    // Verify SHA-256 Checksum
    final serializedBody = jsonEncode(body);
    final computedChecksum = calculateSha256(serializedBody);

    if (recordedChecksum.toLowerCase() != computedChecksum.toLowerCase()) {
      throw const BackupTamperedException();
    }

    // Verify Schema Version
    final schemaVersion = body['schema_version'] as int? ?? 0;
    if (schemaVersion != currentSchemaVersion) {
      throw UnsupportedBackupVersionException(schemaVersion, currentSchemaVersion);
    }

    final exportedAt = DateTime.parse(body['exported_at'] as String);
    final payload = body['payload'] as Map<String, dynamic>? ?? {};

    final progress = payload['progress'] as Map<String, dynamic>? ?? {};
    final rawCards = payload['srs_cards'] as List<dynamic>? ?? [];
    final srsCards = rawCards.map((c) => Map<String, dynamic>.from(c as Map)).toList();
    final settings = payload['settings'] as Map<String, dynamic>? ?? {};

    return SovereignBackupData(
      schemaVersion: schemaVersion,
      exportedAt: exportedAt,
      progress: progress,
      srsCards: srsCards,
      settings: settings,
    );
  }
}
