import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/navigation/deep_link_navigator.dart';

void main() {
  group('DeepLinkNavigator Route Resolution', () {
    test('Parses category detail deep link with custom scheme', () {
      const uri = 'trilingual://categories/category_172_astrolabe_retes';
      final target = DeepLinkNavigator.parse(uri);

      expect(target.isValid, isTrue);
      expect(target.type, equals(NavigationTargetType.categoryDetail));
      expect(target.entityId, equals('category_172_astrolabe_retes'));
    });

    test('Parses dialogue detail with query parameters', () {
      const uri = 'route:/dialogues/dialogue_168_astrolabe_alidade_observation?turn=1&mode=rolePlay';
      final target = DeepLinkNavigator.parse(uri);

      expect(target.isValid, isTrue);
      expect(target.type, equals(NavigationTargetType.dialogueDetail));
      expect(target.entityId, equals('dialogue_168_astrolabe_alidade_observation'));
      expect(target.params['turn'], equals('1'));
      expect(target.params['mode'], equals('rolePlay'));
    });

    test('Parses review session route', () {
      const uri = '/review?limit=20';
      final target = DeepLinkNavigator.parse(uri);

      expect(target.isValid, isTrue);
      expect(target.type, equals(NavigationTargetType.reviewSession));
      expect(target.params['limit'], equals('20'));
    });

    test('Handles malformed or unknown routes returning safe unknown target', () {
      final target = DeepLinkNavigator.parse('trilingual://non_existent_module/xyz');
      expect(target.isValid, isFalse);
      expect(target.type, equals(NavigationTargetType.unknown));

      final emptyTarget = DeepLinkNavigator.parse('   ');
      expect(emptyTarget.isValid, isFalse);
    });
  });
}
