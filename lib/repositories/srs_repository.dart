import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:trilingual_learning_lab/core/storage/atomic_file_writer.dart';
import 'package:trilingual_learning_lab/models/srs_card.dart';

/// Repository managing SM-2 Spaced Repetition Card lifecycle and atomic storage.
class SrsRepository {
  static final SrsRepository _instance = SrsRepository._internal();
  factory SrsRepository() => _instance;
  SrsRepository._internal();

  final Map<String, SrsCard> _cards = {};
  File? _dataFile;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  int get totalCardsCount => _cards.length;

  /// Initializes storage in app-private directory.
  Future<void> init([Directory? storageDir]) async {
    final Directory dir = storageDir ?? Directory('./.app_srs_store');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    _dataFile = File('${dir.path}/srs_review_cards.json');
    await loadCards();
    _isInitialized = true;
  }

  Future<void> loadCards() async {
    if (_dataFile == null) return;
    final content = await AtomicFileWriter.safeReadFile(_dataFile!);
    if (content != null && content.trim().isNotEmpty) {
      try {
        final decoded = json.decode(content);
        if (decoded is List) {
          _cards.clear();
          for (final item in decoded) {
            if (item is Map<String, dynamic>) {
              final card = SrsCard.fromJson(item);
              if (card.id.isNotEmpty) {
                _cards[card.id] = card;
              }
            }
          }
        }
      } catch (e) {
        debugPrint('Error parsing SRS cards file: $e');
      }
    }
  }

  /// Returns cards due for review as of [asOfDate] with strict full calendar matching.
  List<SrsCard> getDueCards({DateTime? asOfDate}) {
    final now = asOfDate ?? DateTime.now();
    return _cards.values.where((card) => card.isDue(now)).toList();
  }

  /// Submits review result and persists updated schedule atomically to disk.
  Future<bool> processReview({
    required String cardId,
    required int qualityScore,
    DateTime? reviewTime,
  }) async {
    if (!_isInitialized) await init();
    final card = _cards[cardId];
    if (card == null || _dataFile == null) return false;

    final effectiveTime = reviewTime ?? DateTime.now();
    final updatedCard = card.review(qualityScore, effectiveTime);

    // Prepare atomic update
    final candidateCards = Map<String, SrsCard>.from(_cards);
    candidateCards[cardId] = updatedCard;

    final jsonList = candidateCards.values.map((c) => c.toJson()).toList();
    final jsonString = json.encode(jsonList);

    final success = await AtomicFileWriter.safeWriteFile(
      targetFile: _dataFile!,
      content: jsonString,
    );

    if (success) {
      _cards[cardId] = updatedCard;
      return true;
    } else {
      debugPrint('Failed to atomically persist SRS review. In-memory state preserved.');
      return false;
    }
  }

  /// Adds a new card for study.
  Future<bool> registerNewCard(String conceptId) async {
    if (!_isInitialized) await init();
    if (_dataFile == null) return false;

    final cardId = 'srs_$conceptId';
    if (_cards.containsKey(cardId)) return true;

    final now = DateTime.now();
    final newCard = SrsCard(
      id: cardId,
      conceptId: conceptId,
      repetitions: 0,
      easeFactor: 2.5,
      intervalDays: 0,
      nextReviewDate: now,
      lastReviewedDate: now,
    );

    final candidateCards = Map<String, SrsCard>.from(_cards)..[cardId] = newCard;
    final jsonList = candidateCards.values.map((c) => c.toJson()).toList();
    final success = await AtomicFileWriter.safeWriteFile(
      targetFile: _dataFile!,
      content: json.encode(jsonList),
    );

    if (success) {
      _cards[cardId] = newCard;
      return true;
    }
    return false;
  }

  @visibleForTesting
  void clearForTesting() {
    _cards.clear();
    _isInitialized = false;
  }
}
