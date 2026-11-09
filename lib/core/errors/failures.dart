import 'package:flutter/foundation.dart';

/// Base class for all domain and platform failures in Trilingual Learning Lab.
abstract class Failure {
  final String code;
  final String messageAr;
  final String messageDe;
  final String messageEn;
  final Object? originalError;
  final StackTrace? stackTrace;

  const Failure({
    required this.code,
    required this.messageAr,
    required this.messageDe,
    required this.messageEn,
    this.originalError,
    this.stackTrace,
  });

  /// Resolves the localized error message based on the specified language code ('ar', 'de', 'en').
  String getLocalizedMessage(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar':
        return messageAr;
      case 'de':
        return messageDe;
      case 'en':
      default:
        return messageEn;
    }
  }

  @override
  String toString() => 'Failure[$code]: $messageEn (AR: $messageAr | DE: $messageDe)';
}

/// Thrown when local persistent storage operations fail.
class StorageFailure extends Failure {
  const StorageFailure({
    String? messageAr,
    String? messageDe,
    String? messageEn,
    Object? originalError,
    StackTrace? stackTrace,
  }) : super(
          code: 'STORAGE_FAILURE',
          messageAr: messageAr ?? 'تَعَذَّرَ حِفْظُ البَيَانَاتِ فِي القُرْصِ المَحَلِّيِّ.',
          messageDe: messageDe ?? 'Fehler beim Speichern der Daten auf dem lokalen Speicher.',
          messageEn: messageEn ?? 'Failed to persist data to local storage.',
          originalError: originalError,
          stackTrace: stackTrace,
        );
}

/// Thrown when a requested learning entity (Category, Verb, Dialogue) is not found.
class ContentNotFoundFailure extends Failure {
  final String entityId;

  ContentNotFoundFailure({
    required this.entityId,
    Object? originalError,
    StackTrace? stackTrace,
  }) : super(
          code: 'CONTENT_NOT_FOUND',
          messageAr: 'لَمْ يَتِمَّ العُثُورُ عَلَى المَحْتَوَى المَطْلُوبِ ($entityId).',
          messageDe: 'Der angeforderte Inhalt ($entityId) konnte nicht gefunden werden.',
          messageEn: 'The requested learning content ($entityId) was not found.',
          originalError: originalError,
          stackTrace: stackTrace,
        );
}

/// Thrown when content or backup files fail checksum or schema validation.
class CorruptedDataFailure extends Failure {
  const CorruptedDataFailure({
    String? messageAr,
    String? messageDe,
    String? messageEn,
    Object? originalError,
    StackTrace? stackTrace,
  }) : super(
          code: 'CORRUPTED_DATA',
          messageAr: messageAr ?? 'المَلَفُ المَحَلِّيُّ تَالِفٌ أَوْ لَمْ يَجْتَزْ فَحْصَ التَّحَقُّقِ.',
          messageDe: messageDe ?? 'Die lokale Datei ist beschädigt oder hat die Integritätsprüfung nicht bestanden.',
          messageEn: messageEn ?? 'The local data file is corrupted or failed integrity validation.',
          originalError: originalError,
          stackTrace: stackTrace,
        );
}

/// Thrown when TTS synthesis or audio playback is unavailable.
class AudioPlaybackFailure extends Failure {
  final String languageCode;

  AudioPlaybackFailure({
    required this.languageCode,
    Object? originalError,
    StackTrace? stackTrace,
  }) : super(
          code: 'AUDIO_UNAVAILABLE',
          messageAr: 'صَوْتُ النُّطْقِ غَيْرُ مُتَاحٍ حَالِيًّا لِهَذِهِ اللُّغَةِ ($languageCode).',
          messageDe: 'Die Audioausgabe ist für diese Sprache ($languageCode) derzeit nicht verfügbar.',
          messageEn: 'Audio speech playback is currently unavailable for language ($languageCode).',
          originalError: originalError,
          stackTrace: stackTrace,
        );
}

/// Thrown when a unit-of-work transaction fails and needs rollback.
class DatabaseTransactionFailure extends Failure {
  const DatabaseTransactionFailure({
    required String reason,
    Object? originalError,
    StackTrace? stackTrace,
  }) : super(
          code: 'TRANSACTION_FAILED',
          messageAr: 'فَشَلَتْ عَمَلِيَّةُ الحِفْظِ التَّرَاكُمِيَّةِ: $reason.',
          messageDe: 'Datenbank-Transaktion fehlgeschlagen: $reason.',
          messageEn: 'Database transaction failed: $reason.',
          originalError: originalError,
          stackTrace: stackTrace,
        );
}

/// Thrown when user input fails strict validation rules.
class ValidationFailure extends Failure {
  final String fieldName;

  ValidationFailure({
    required this.fieldName,
    required String detailAr,
    required String detailDe,
    required String detailEn,
  }) : super(
          code: 'VALIDATION_FAILED',
          messageAr: 'قِيمَةُ الحَقْلِ ($fieldName) غَيْرُ صَالِحَةٍ: $detailAr',
          messageDe: 'Ungültiger Wert für ($fieldName): $detailDe',
          messageEn: 'Invalid value for field ($fieldName): $detailEn',
        );
}
