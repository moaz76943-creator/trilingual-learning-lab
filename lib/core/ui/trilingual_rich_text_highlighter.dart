import 'package:flutter/foundation.dart';
import '../linguistics/arabic_diacritics_service.dart';

/// Represents a distinct segment of text with semantic highlighting attributes.
class HighlightedToken {
  final String text;
  final bool isTarget;
  final String tokenType; // 'target', 'standard', 'prefix'

  const HighlightedToken({
    required this.text,
    required this.isTarget,
    this.tokenType = 'standard',
  });
}

/// Utility parsing and highlighting text segments across Arabic, German, and English.
class TrilingualRichTextHighlighter {
  /// Tokenizes [sentence] and identifies spans matching any of [targetTerms].
  /// Matches diacritic-insensitively while preserving original vocalized characters.
  static List<HighlightedToken> highlightTerms({
    required String sentence,
    required List<String> targetTerms,
  }) {
    if (sentence.isEmpty) return const [];
    if (targetTerms.isEmpty) {
      return [HighlightedToken(text: sentence, isTarget: false)];
    }

    // Filter non-empty targets
    final validTargets = targetTerms.map((t) => t.trim()).where((t) => t.isNotEmpty).toList();
    if (validTargets.isEmpty) {
      return [HighlightedToken(text: sentence, isTarget: false)];
    }

    // Check if sentence is Arabic
    final isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(sentence);

    if (isArabic) {
      return _highlightArabicWithDiacritics(sentence, validTargets);
    } else {
      return _highlightStandard(sentence, validTargets);
    }
  }

  static List<HighlightedToken> _highlightArabicWithDiacritics(String sentence, List<String> targets) {
    // Map normalized unvocalized characters back to raw vocalized character indices
    final stripped = ArabicDiacriticsService.stripTashkeel(sentence);
    final normTargets = targets.map((t) => ArabicDiacriticsService.stripTashkeel(t)).toList();

    // Find match intervals in stripped string
    final intervals = <_MatchInterval>[];
    for (final target in normTargets) {
      if (target.isEmpty) continue;
      int startIdx = 0;
      while (true) {
        final matchIdx = stripped.indexOf(target, startIdx);
        if (matchIdx == -1) break;
        intervals.add(_MatchInterval(matchIdx, matchIdx + target.length));
        startIdx = matchIdx + target.length;
      }
    }

    if (intervals.isEmpty) {
      return [HighlightedToken(text: sentence, isTarget: false)];
    }

    // Sort intervals
    intervals.sort((a, b) => a.start.compareTo(b.start));

    // Map stripped indices to raw vocalized indices
    final rawIndexMap = <int>[];
    for (var i = 0; i < sentence.length; i++) {
      final char = sentence[i];
      if (!RegExp(r'[\u064B-\u0652\u0670\u0640]').hasMatch(char)) {
        rawIndexMap.add(i);
      }
    }

    final tokens = <HighlightedToken>[];
    int currentRaw = 0;

    for (final interval in intervals) {
      if (interval.start >= rawIndexMap.length) continue;
      final rawStart = rawIndexMap[interval.start];
      final rawEnd = (interval.end < rawIndexMap.length)
          ? rawIndexMap[interval.end]
          : sentence.length;

      if (rawStart > currentRaw) {
        tokens.add(HighlightedToken(
          text: sentence.substring(currentRaw, rawStart),
          isTarget: false,
        ));
      }

      tokens.add(HighlightedToken(
        text: sentence.substring(rawStart, rawEnd),
        isTarget: true,
        tokenType: 'target',
      ));

      currentRaw = rawEnd;
    }

    if (currentRaw < sentence.length) {
      tokens.add(HighlightedToken(
        text: sentence.substring(currentRaw),
        isTarget: false,
      ));
    }

    return tokens;
  }

  static List<HighlightedToken> _highlightStandard(String sentence, List<String> targets) {
    final lower = sentence.toLowerCase();
    final intervals = <_MatchInterval>[];

    for (final target in targets) {
      final normTarget = target.toLowerCase();
      int start = 0;
      while (true) {
        final idx = lower.indexOf(normTarget, start);
        if (idx == -1) break;
        intervals.add(_MatchInterval(idx, idx + normTarget.length));
        start = idx + normTarget.length;
      }
    }

    if (intervals.isEmpty) {
      return [HighlightedToken(text: sentence, isTarget: false)];
    }

    intervals.sort((a, b) => a.start.compareTo(b.start));

    final tokens = <HighlightedToken>[];
    int current = 0;

    for (final interval in intervals) {
      if (interval.start > current) {
        tokens.add(HighlightedToken(
          text: sentence.substring(current, interval.start),
          isTarget: false,
        ));
      }

      tokens.add(HighlightedToken(
        text: sentence.substring(interval.start, interval.end),
        isTarget: true,
        tokenType: 'target',
      ));

      current = interval.end;
    }

    if (current < sentence.length) {
      tokens.add(HighlightedToken(
        text: sentence.substring(current),
        isTarget: false,
      ));
    }

    return tokens;
  }
}

class _MatchInterval {
  final int start;
  final int end;
  _MatchInterval(this.start, this.end);
}
