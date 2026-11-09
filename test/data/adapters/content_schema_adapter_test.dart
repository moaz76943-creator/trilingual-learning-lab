import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/data/adapters/content_schema_adapter.dart';

void main() {
  group('ContentSchemaAdapter Multi-Generation Normalization', () {
    test('Normalizes nested title and vocabulary array correctly', () {
      final raw = {
        'category_id': 'astronomy_astrolabe_001',
        'level': 'B1',
        'title': {
          'ar': 'صِنَاعَةُ الأَسْطُرْلاَبِ النُّحَاسِيِّ',
          'de': 'Bau des Messingastrolabiums',
          'en': 'Brass Astrolabe Construction'
        },
        'vocabulary': [
          {
            'id': 'item_1',
            'ar': 'حُجْرَةُ الصَّفَائِحِ',
            'de': 'Mutter / Ansa',
            'en': 'Mater'
          },
          {
            'id': 'item_2',
            'ar': 'الشَّبَكَةُ العَنْكَبُوتِيَّةُ',
            'de': 'Rete',
            'en': 'Rete'
          }
        ]
      };

      final normalized = ContentSchemaAdapter.normalizeCategory(raw);

      expect(normalized.id, equals('astronomy_astrolabe_001'));
      expect(normalized.level, equals('B1'));
      expect(normalized.title.ar, contains('الأَسْطُرْلاَبِ'));
      expect(normalized.title.de, equals('Bau des Messingastrolabiums'));
      expect(normalized.title.en, equals('Brass Astrolabe Construction'));
      expect(normalized.items.length, equals(2));
      expect(normalized.items.first.ar, equals('حُجْرَةُ الصَّفَائِحِ'));
      expect(normalized.items.first.de, equals('Mutter / Ansa'));
    });

    test('Normalizes flat title_ar/de/en and items array correctly', () {
      final raw = {
        'concept_id': 'horology_clepsydra_002',
        'cefr_level': 'A2',
        'title_ar': 'السَّاعَاتُ المَائِيَّةُ وَالمُعَدِّلاَتُ',
        'title_de': 'Wasseruhren und Strömungsregler',
        'title_en': 'Water Clocks and Flow Regulators',
        'items': [
          {
            'id': 'fl_1',
            'ar': 'عَوَّامَةٌ بَرُونْزِيَّةٌ',
            'de': 'Bronzeschwimmer',
            'en': 'Bronze Float'
          }
        ]
      };

      final normalized = ContentSchemaAdapter.normalizeCategory(raw);

      expect(normalized.id, equals('horology_clepsydra_002'));
      expect(normalized.level, equals('A2'));
      expect(normalized.title.ar, contains('السَّاعَاتُ المَائِيَّةُ'));
      expect(normalized.title.de, equals('Wasseruhren und Strömungsregler'));
      expect(normalized.items.length, equals(1));
      expect(normalized.items.first.en, equals('Bronze Float'));
    });

    test('Normalizes dialogue with nested turns and speaker maps', () {
      final raw = {
        'dialogue_id': 'dial_050_water_wheel',
        'title': {
          'ar': 'نَاعُورَةُ العَاصِي',
          'de': 'Wasserrad am Orontes',
          'en': 'Waterwheel on the Orontes'
        },
        'context': {
          'ar': 'حِوَارٌ هَنْدَسِيٌّ عِنْدَ قَنَاطِرِ حَمَاةَ.',
          'de': 'Ein Ingenieursgespräch an den Aquädukten von Hama.',
          'en': 'An engineering dialogue at the Hama aqueducts.'
        },
        'turns': [
          {
            'speaker': {
              'ar': 'المُهَنْدِسُ سَعِيدٌ',
              'de': 'Ingenieur Said',
              'en': 'Engineer Said'
            },
            'ar': 'كَيْفَ يَنْتَقِلُ عَزْمُ الدَّوَرَانِ إِلَى الصَّنَادِيقِ؟',
            'de': 'Wie überträgt sich das Drehmoment auf die Schöpfeimer?',
            'en': 'How does the torque transfer to the lifting buckets?'
          }
        ]
      };

      final dialogue = ContentSchemaAdapter.normalizeDialogue(raw);

      expect(dialogue.id, equals('dial_050_water_wheel'));
      expect(dialogue.title.ar, contains('نَاعُورَةُ'));
      expect(dialogue.context, isNotNull);
      expect(dialogue.context!.de, contains('Hama'));
      expect(dialogue.turns.length, equals(1));
      expect(dialogue.turns.first.speaker.ar, equals('المُهَنْدِسُ سَعِيدٌ'));
      expect(dialogue.turns.first.speech.en, contains('torque'));
    });

    test('Normalizes dialogue with flat lines and string speaker', () {
      final raw = {
        'id': 'dial_051_paper_mill',
        'title_ar': 'طَاحُونَةُ الوَرَقِ فِي سَمَرْقَنْدَ',
        'title_de': 'Papiermühle in Samarkand',
        'title_en': 'Paper Mill in Samarkand',
        'lines': [
          {
            'speaker': 'Yusuf',
            'ar': 'هَلْ هَرَسْتُمْ أَلْيَافَ القَتَاتِ جَيِّدًا؟',
            'de': 'Habt ihr die Flachsfasern gründlich gestampft?',
            'en': 'Did you crush the flax fibers thoroughly?'
          }
        ]
      };

      final dialogue = ContentSchemaAdapter.normalizeDialogue(raw);

      expect(dialogue.id, equals('dial_051_paper_mill'));
      expect(dialogue.turns.length, equals(1));
      expect(dialogue.turns.first.speaker.ar, equals('Yusuf'));
      expect(dialogue.turns.first.speech.ar, contains('أَلْيَافَ'));
    });

    test('Throws FormatException if no identifier can be resolved', () {
      final emptyJson = <String, dynamic>{'foo': 'bar'};
      expect(
        () => ContentSchemaAdapter.normalizeCategory(emptyJson),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
