import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/reader/presentation/controllers/reader_session_controller.dart';

void main() {
  group('ReaderSessionController Trilingual Reading Studio Tests', () {
    late List<ReaderSentenceChunk> sampleSentences;
    late ReaderSessionController controller;

    setUp(() {
      sampleSentences = [
        const ReaderSentenceChunk(
          index: 0,
          textAr: 'صَنَعَ الفَلَكِيُّ الأَسْطُرْلاَبَ النُّحَاسِيَّ بِدِقَّةٍ.',
          textDe: 'Der Astronom baute das Messingastrolabium mit Präzision.',
          textEn: 'The astronomer built the brass astrolabe with precision.',
        ),
        const ReaderSentenceChunk(
          index: 1,
          textAr: 'وَسَدَّدَ خَطَّ البَصَرِ عَبْرَ ثَقْبَيِ العِضَادَةِ.',
          textDe: 'Und visierte die Sichtlinie durch die Löcher der Alhidade an.',
          textEn: 'And collimated the line of sight through the alidade holes.',
        ),
      ];

      controller = ReaderSessionController(
        articleId: 'article_astrolabe_history',
        titleAr: 'تَارِيخُ صِنَاعَةِ الأَسْطُرْلاَبِ',
        titleDe: 'Geschichte des Astrolabienbaus',
        titleEn: 'History of Astrolabe Construction',
        sentences: sampleSentences,
      );
    });

    test('Initializes with first sentence and parchment theme', () {
      expect(controller.totalSentences, equals(2));
      expect(controller.activeSentenceIndex, equals(0));
      expect(controller.themeMode, equals(ReaderThemeMode.parchment));
      expect(controller.fontScale, equals(1.0));
      expect(controller.isNarrationPlaying, isFalse);
      expect(controller.activeWordGloss, isNull);
    });

    test('Advances and retreats sentences updating reading progress percentage', () {
      expect(controller.readingProgressPercentage, equals(50.0)); // 1 of 2

      final advanced = controller.nextSentence();
      expect(advanced, isTrue);
      expect(controller.activeSentenceIndex, equals(1));
      expect(controller.readingProgressPercentage, equals(100.0)); // 2 of 2

      controller.previousSentence();
      expect(controller.activeSentenceIndex, equals(0));
    });

    test('Looks up instant word gloss with IPA transcription', () {
      controller.lookupWordGloss('الأَسْطُرْلاَبَ', 'ar');

      expect(controller.activeWordGloss, isNotNull);
      final gloss = controller.activeWordGloss!;
      expect(gloss.tappedWord, equals('الأَسْطُرْلاَبَ'));
      expect(gloss.ipaPhonetics.isNotEmpty, isTrue);

      controller.clearGloss();
      expect(controller.activeWordGloss, isNull);
    });

    test('Adjusts theme and clamps font scale safely', () {
      controller.setThemeMode(ReaderThemeMode.darkSlate);
      expect(controller.themeMode, equals(ReaderThemeMode.darkSlate));

      controller.setFontScale(1.8); // Above 1.5 max -> clamped
      expect(controller.fontScale, equals(1.5));

      controller.setFontScale(0.5); // Below 0.8 min -> clamped
      expect(controller.fontScale, equals(0.8));
    });
  });
}
