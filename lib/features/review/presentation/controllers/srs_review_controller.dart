import 'package:flutter/foundation.dart';
import '../../../../models/srs_card.dart';
import '../../domain/services/srs_review_queue_builder.dart';

enum SrsReviewState {
  initial,
  loading,
  reviewing,
  sessionCompleted,
  emptyQueue,
}

/// Controller governing the interactive SRS flashcard review session state.
class SrsReviewController extends ChangeNotifier {
  final List<SrsCard> _allCards;
  List<SrsCard> _queue = [];
  int _currentIndex = 0;
  bool _isFlipped = false;
  int _completedCount = 0;
  int _lapsedCount = 0;
  SrsReviewState _state = SrsReviewState.initial;

  SrsReviewController({List<SrsCard> allCards = const []}) : _allCards = allCards;

  SrsReviewState get state => _state;
  bool get isFlipped => _isFlipped;
  int get currentIndex => _currentIndex;
  int get totalInSession => _queue.length;
  int get completedCount => _completedCount;
  int get lapsedCount => _lapsedCount;

  SrsCard? get currentCard {
    if (_queue.isEmpty || _currentIndex >= _queue.length) return null;
    return _queue[_currentIndex];
  }

  double get progressPercentage {
    if (_queue.isEmpty) return 0.0;
    return (_completedCount / _queue.length) * 100.0;
  }

  double get retentionRate {
    if (_completedCount == 0) return 100.0;
    final successfulCount = _completedCount - _lapsedCount;
    return (successfulCount / _completedCount) * 100.0;
  }

  /// Starts or restarts a review session with prioritized candidate cards.
  void startSession({DateTime? now, int maxDue = 20, int maxNew = 10}) {
    _state = SrsReviewState.loading;
    notifyListeners();

    final plan = SrsReviewQueueBuilder.buildSessionQueue(
      allCards: _allCards,
      now: now,
      maxDueReviews: maxDue,
      maxNewCards: maxNew,
    );

    _queue = plan.queue;
    _currentIndex = 0;
    _completedCount = 0;
    _lapsedCount = 0;
    _isFlipped = false;

    if (_queue.isEmpty) {
      _state = SrsReviewState.emptyQueue;
    } else {
      _state = SrsReviewState.reviewing;
    }
    notifyListeners();
  }

  /// Toggles between question (front) and answer (back) presentation.
  void flipCard() {
    if (_state != SrsReviewState.reviewing) return;
    _isFlipped = !_isFlipped;
    notifyListeners();
  }

  /// Rates current card with an SM-2 rating:
  /// - 0: Again (Lapse: reset interval to 1 day)
  /// - 3: Hard (Maintain repetition, small interval bump)
  /// - 4: Good (Standard SM-2 interval progression)
  /// - 5: Easy (Accelerated ease factor boost)
  void answerCard(int rating, {DateTime? now}) {
    if (_state != SrsReviewState.reviewing || currentCard == null) return;

    final card = currentCard!;
    final refTime = now ?? DateTime.now();

    int newReps = card.repetitions;
    int newInterval = card.interval;
    double newEase = card.easeFactor;

    if (rating < 3) {
      // Lapsed recall: reset interval to 1 day
      newReps = 0;
      newInterval = 1;
      _lapsedCount++;
    } else {
      newReps += 1;
      if (newReps == 1) {
        newInterval = 1;
      } else if (newReps == 2) {
        newInterval = 6;
      } else {
        newInterval = (card.interval * card.easeFactor).round();
      }
    }

    // SM-2 Ease Factor recalculation: EF' = EF + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
    newEase = newEase + (0.1 - (5 - rating) * (0.08 + (5 - rating) * 0.02));
    if (newEase < 1.3) newEase = 1.3;

    final nextReviewDate = refTime.add(Duration(days: newInterval));

    final updatedCard = SrsCard(
      id: card.id,
      frontAr: card.frontAr,
      frontDe: card.frontDe,
      frontEn: card.frontEn,
      repetitions: newReps,
      interval: newInterval,
      easeFactor: newEase,
      nextReview: nextReviewDate,
    );

    _queue[_currentIndex] = updatedCard;
    _completedCount++;
    _isFlipped = false;

    if (_currentIndex < _queue.length - 1) {
      _currentIndex++;
    } else {
      _state = SrsReviewState.sessionCompleted;
    }

    notifyListeners();
  }
}
