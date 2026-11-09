import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/assets/heritage_asset_resolver.dart';

void main() {
  group('HeritageAssetResolver SVG Mapping & Safety', () {
    test('Resolves known historical instrument categories to specific SVG assets', () {
      expect(
        HeritageAssetResolver.resolveCategoryIcon('astronomy_astrolabe_001'),
        equals('assets/images/categories/astrolabe_brass_gear.svg'),
      );
      expect(
        HeritageAssetResolver.resolveCategoryIcon('clepsydra_float_valve'),
        equals('assets/images/categories/water_clepsydra_cylinder.svg'),
      );
      expect(
        HeritageAssetResolver.resolveCategoryIcon('samarkand_papermill_hammer'),
        equals('assets/images/categories/samarkand_trip_hammer.svg'),
      );
    });

    test('Falls back to default sovereign heritage seal for unmapped categories', () {
      final fallback = HeritageAssetResolver.resolveCategoryIcon('unknown_general_concept');
      expect(fallback, equals(HeritageAssetResolver.defaultHeritageSealAsset));
    });

    test('Validates SVG asset path conventions and extensions', () {
      expect(HeritageAssetResolver.isValidSvgAssetPath('assets/images/categories/dial.svg'), isTrue);
      expect(HeritageAssetResolver.isValidSvgAssetPath('assets/images/categories/dial.png'), isFalse);
      expect(HeritageAssetResolver.isValidSvgAssetPath('/tmp/dial.svg'), isFalse);
    });

    test('Enforces cultural sovereignty compliance on asset slugs', () {
      expect(HeritageAssetResolver.compliesWithCulturalSovereignty('astrolabe_brass'), isTrue);
      expect(HeritageAssetResolver.compliesWithCulturalSovereignty('hebrew_alphabet'), isFalse);
      expect(HeritageAssetResolver.compliesWithCulturalSovereignty('gambling_dice'), isFalse);
    });
  });
}
