import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:trilingual_learning_lab/core/storage/atomic_file_writer.dart';

/// Domain model representing persistent learner progress metrics.
class UserProgressModel {
  int wordsLearned;
  int streakDays;
  int dailyGoal;
  int todayReviewsCount;
  DateTime lastActiveDate;
  Set<String> masteredConceptIds;

  UserProgressModel({
    this.wordsLearned = 0,
    this.streakDays = 1,
    this.dailyGoal = 20,
    this.todayReviewsCount = 0,
    DateTime? lastActiveDate,
    Set<String>? masteredConceptIds,
  })  : lastActiveDate = lastActiveDate ?? DateTime.now(),
        masteredConceptIds = masteredConceptIds ?? {};

  Map<String, dynamic> toJson() => {
        'wordsLearned': wordsLearned,
        'streakDays': streakDays,
        'dailyGoal': dailyGoal,
        'todayReviewsCount': todayReviewsCount,
        'lastActiveDate': lastActiveDate.toIso8601String(),
        'masteredConceptIds': masteredConceptIds.toList(),
      };

  factory UserProgressModel.fromJson(Map<String, dynamic> json) {
    return UserProgressModel(
      wordsLearned: json['wordsLearned'] as int? ?? 0,
      streakDays: json['streakDays'] as int? ?? 1,
      dailyGoal: json['dailyGoal'] as int? ?? 20,
      todayReviewsCount: json['todayReviewsCount'] as int? ?? 0,
      lastActiveDate: json['lastActiveDate'] != null
          ? DateTime.tryParse(json['lastActiveDate'] as String) ?? DateTime.now()
          : DateTime.now(),
      masteredConceptIds: (json['masteredConceptIds'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toSet() ??
          {},
    );
  }
}

/// Durable Progress Repository enforcing atomic file persistence without data loss gaps.
class ProgressRepository {
  static final ProgressRepository _instance = ProgressRepository._internal();
  factory ProgressRepository() => _instance;
  ProgressRepository._internal();

  UserProgressModel _currentProgress = UserProgressModel();
  File? _dataFile;
  bool _isInitialized = false;

  UserProgressModel get currentProgress => _currentProgress;

  Future<void> init([Directory? baseDir]) async {
    final Directory dir = baseDir ?? Directory('./.app_progress_store');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    _dataFile = File('${dir.path}/learner_progress.json');
    await loadProgress();
    _isInitialized = true;
  }

  Future<void> loadProgress() async {
    if (_dataFile == null) return;
    final content = await AtomicFileWriter.safeReadFile(_dataFile!);
    if (content != null && content.trim().isNotEmpty) {
      try {
        final decoded = json.decode(content);
        if (decoded is Map<String, dynamic>) {
          _currentProgress = UserProgressModel.fromJson(decoded);
        }
      } catch (e) {
        debugPrint('Failed to parse progress file: $e');
      }
    }
  }

  /// Records review completion atomically. Updates in-memory state ONLY if disk write succeeds.
  Future<bool> recordConceptMastered(String conceptId) async {
    if (!_isInitialized) await init();
    if (_dataFile == null) return false;

    // Create candidate state
    final updatedMastered = Set<String>.from(_currentProgress.masteredConceptIds)..add(conceptId);
    final candidateProgress = UserProgressModel(
      wordsLearned: updatedMastered.length,
      streakDays: _currentProgress.streakDays,
      dailyGoal: _currentProgress.dailyGoal,
      todayReviewsCount: _currentProgress.todayReviewsCount + 1,
      lastActiveDate: DateTime.now(),
      masteredConceptIds: updatedMastered,
    );

    final jsonString = json.encode(candidateProgress.toJson());
    final success = await AtomicFileWriter.safeWriteFile(
      targetFile: _dataFile!,
      content: jsonString,
    );

    if (success) {
      // Memory state updated strictly after durable persistence confirmed
      _currentProgress = candidateProgress;
      return true;
    } else {
      debugPrint('Atomic progress write failed; in-memory state protected from divergence.');
      return false;
    }
  }
}
