import 'package:flutter/foundation.dart';

enum NavigationTargetType {
  home,
  categories,
  categoryDetail,
  verbs,
  verbDetail,
  dialogues,
  dialogueDetail,
  reviewSession,
  search,
  unknown,
}

/// Structured navigation target resulting from deep link parsing.
class NavigationTarget {
  final NavigationTargetType type;
  final String? entityId;
  final Map<String, String> params;
  final String rawUri;
  final bool isValid;

  const NavigationTarget({
    required this.type,
    this.entityId,
    this.params = const {},
    required this.rawUri,
    this.isValid = true,
  });

  factory NavigationTarget.unknown(String rawUri) {
    return NavigationTarget(
      type: NavigationTargetType.unknown,
      rawUri: rawUri,
      isValid: false,
    );
  }
}

/// Service parsing and validating deep link routing targets offline.
class DeepLinkNavigator {
  /// Parses an arbitrary [uriString] into a strongly typed [NavigationTarget].
  static NavigationTarget parse(String uriString) {
    final clean = uriString.trim();
    if (clean.isEmpty) {
      return NavigationTarget.unknown(uriString);
    }

    try {
      // Normalize custom scheme prefixes
      var normalized = clean;
      if (normalized.startsWith('trilingual://')) {
        normalized = normalized.substring('trilingual://'.length);
      } else if (normalized.startsWith('route:')) {
        normalized = normalized.substring('route:'.length);
      }

      if (!normalized.startsWith('/')) {
        normalized = '/$normalized';
      }

      final uri = Uri.parse(normalized);
      final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
      final queryParams = uri.queryParameters;

      if (segments.isEmpty) {
        return NavigationTarget(
          type: NavigationTargetType.home,
          rawUri: uriString,
        );
      }

      final rootSegment = segments.first.toLowerCase();

      switch (rootSegment) {
        case 'home':
          return NavigationTarget(
            type: NavigationTargetType.home,
            rawUri: uriString,
            params: queryParams,
          );

        case 'categories':
        case 'category':
          if (segments.length > 1) {
            return NavigationTarget(
              type: NavigationTargetType.categoryDetail,
              entityId: segments[1],
              params: queryParams,
              rawUri: uriString,
            );
          }
          return NavigationTarget(
            type: NavigationTargetType.categories,
            rawUri: uriString,
            params: queryParams,
          );

        case 'verbs':
        case 'verb':
          if (segments.length > 1) {
            return NavigationTarget(
              type: NavigationTargetType.verbDetail,
              entityId: segments[1],
              params: queryParams,
              rawUri: uriString,
            );
          }
          return NavigationTarget(
            type: NavigationTargetType.verbs,
            rawUri: uriString,
            params: queryParams,
          );

        case 'dialogues':
        case 'dialogue':
          if (segments.length > 1) {
            return NavigationTarget(
              type: NavigationTargetType.dialogueDetail,
              entityId: segments[1],
              params: queryParams,
              rawUri: uriString,
            );
          }
          return NavigationTarget(
            type: NavigationTargetType.dialogues,
            rawUri: uriString,
            params: queryParams,
          );

        case 'review':
        case 'srs':
          return NavigationTarget(
            type: NavigationTargetType.reviewSession,
            rawUri: uriString,
            params: queryParams,
          );

        case 'search':
          return NavigationTarget(
            type: NavigationTargetType.search,
            rawUri: uriString,
            params: queryParams,
          );

        default:
          return NavigationTarget.unknown(uriString);
      }
    } catch (_) {
      return NavigationTarget.unknown(uriString);
    }
  }
}
