import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/typography/arabic_typography_kerning_guard.dart';
import 'package:trilingual_learning_lab/core/typography/font_metric_resolver.dart';

void main() {
  group('ArabicTypographyKerningGuard & FontMetricResolver Critical Tests', () {
    test('Calculates Tashkeel density accurately', () {
      const vocalized = 'الأَسْطُرْلاَبُ النُّحَاسِيُّ';
      const plain = 'الاسطرلاب النحاسي';

      final vocalizedDensity = ArabicTypographyKerningGuard.calculateTashkeelDensity(vocalized);
      final plainDensity = ArabicTypographyKerningGuard.calculateTashkeelDensity(plain);

      expect(vocalizedDensity, greaterThan(0.20));
      expect(plainDensity, equals(0.0));
      expect(ArabicTypographyKerningGuard.requiresDiacriticClippingProtection(vocalized), isTrue);
      expect(ArabicTypographyKerningGuard.requiresDiacriticClippingProtection(plain), isFalse);
    });

    test('FontMetricResolver strictly enforces zero letter-spacing on Arabic cursive', () {
      final arMetrics = FontMetricResolver.resolve(
        languageCode: 'ar',
        baseFontSize: 16.0,
        hasTashkeel: true,
      );

      // Letter spacing MUST be 0.0 to prevent cursive disjoining
      expect(arMetrics.letterSpacing, equals(0.0));
      expect(arMetrics.fontFamily, equals('Amiri'));
      expect(arMetrics.lineHeightMultiplier, greaterThanOrEqualTo(1.80)); // Accommodates stacked Tashkeel
      expect(arMetrics.textDirection, equals(TextDirection.rtl));
    });

    test('FontMetricResolver resolves Latin metrics for German and English', () {
      final deMetrics = FontMetricResolver.resolve(
        languageCode: 'de',
        baseFontSize: 16.0,
      );

      expect(deMetrics.fontFamily, equals('Inter'));
      expect(deMetrics.textDirection, equals(TextDirection.ltr));
      expect(deMetrics.letterSpacing, equals(-0.2));
    });

    test('Inserts soft hyphens into long German compound words', () {
      const compound = 'Das Schattenquadrat zur Messung';
      final formatted = ArabicTypographyKerningGuard.formatGermanCompounds(compound);

      // Should insert \u00AD before "quadrat"
      expect(formatted.contains('\u00AD'), isTrue);
    });
  });
}
