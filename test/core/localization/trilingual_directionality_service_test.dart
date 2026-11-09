import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/localization/trilingual_directionality_service.dart';

void main() {
  group('TrilingualDirectionalityService RTL/LTR Resolution', () {
    test('Identifies Arabic script accurately', () {
      expect(TrilingualDirectionalityService.isArabicScript('صِنَاعَةُ الوَرَقِ'), isTrue);
      expect(TrilingualDirectionalityService.isArabicScript('Papiermühle'), isFalse);
      expect(TrilingualDirectionalityService.isArabicScript('Paper mill'), isFalse);
      expect(TrilingualDirectionalityService.isArabicScript(''), isFalse);
    });

    test('Resolves TextDirection based on language code and script content', () {
      expect(TrilingualDirectionalityService.resolveDirection('ar'), equals(TextDirection.rtl));
      expect(TrilingualDirectionalityService.resolveDirection('ar-EG'), equals(TextDirection.rtl));
      expect(TrilingualDirectionalityService.resolveDirection('de'), equals(TextDirection.ltr));
      expect(TrilingualDirectionalityService.resolveDirection('en'), equals(TextDirection.ltr));
      expect(TrilingualDirectionalityService.resolveDirection('الأَسْطُرْلاَبُ'), equals(TextDirection.rtl));
    });

    test('Resolves absolute padding correctly when direction is RTL vs LTR', () {
      final ltrPadding = TrilingualDirectionalityService.resolveAbsolutePadding(
        direction: TextDirection.ltr,
        start: 16.0,
        end: 8.0,
        top: 4.0,
        bottom: 4.0,
      );
      expect(ltrPadding.left, equals(16.0));
      expect(ltrPadding.right, equals(8.0));

      final rtlPadding = TrilingualDirectionalityService.resolveAbsolutePadding(
        direction: TextDirection.rtl,
        start: 16.0,
        end: 8.0,
        top: 4.0,
        bottom: 4.0,
      );
      // In RTL, start is right, end is left
      expect(rtlPadding.right, equals(16.0));
      expect(rtlPadding.left, equals(8.0));
    });

    test('Resolves horizontal alignment dynamically', () {
      final ltrStart = TrilingualDirectionalityService.resolveAlignment(
        direction: TextDirection.ltr,
        alignStart: true,
      );
      expect(ltrStart, equals(Alignment.centerLeft));

      final rtlStart = TrilingualDirectionalityService.resolveAlignment(
        direction: TextDirection.rtl,
        alignStart: true,
      );
      expect(rtlStart, equals(Alignment.centerRight));
    });

    test('Determines directional icon mirroring correctly for RTL', () {
      expect(
        TrilingualDirectionalityService.shouldMirrorIcon('arrow_forward', TextDirection.rtl),
        isTrue,
      );
      expect(
        TrilingualDirectionalityService.shouldMirrorIcon('chevron_right', TextDirection.rtl),
        isTrue,
      );
      expect(
        TrilingualDirectionalityService.shouldMirrorIcon('arrow_forward', TextDirection.ltr),
        isFalse,
      );
      expect(
        TrilingualDirectionalityService.shouldMirrorIcon('settings', TextDirection.rtl),
        isFalse,
      );
    });
  });
}
