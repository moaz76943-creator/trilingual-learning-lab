import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/models/concept.dart';
import 'package:trilingual_learning_lab/repositories/srs_repository.dart';

void main() {
  test('a review scheduled on the same day next year is not due today', () async {
    final temp = await Directory.systemTemp.createTemp('trilingual-srs-');
    addTearDown(() async => temp.delete(recursive: true));
    final now = DateTime.now();
    final future = DateTime(now.year + 1, now.month, now.day);
    final fixture = {
      'cards': [
        {
          'concept_id': 'concept-future',
          'repetitions': 1,
          'interval_days': 365,
          'ease_factor': 2.5,
          'next_review': future.toIso8601String(),
          'last_reviewed': null,
        }
      ]
    };
    await File('${temp.path}/user_srs_data.json')
        .writeAsString(jsonEncode(fixture));
    final repository = SRSRepository();
    await repository.init(temp.path);
    final concept = Concept(
      conceptId: 'concept-future',
      imageId: '',
      ar: ArabicLexeme(
        word: 'كِتَابٌ', vocalized: 'كِتَابٌ',
        gender: 'm', plural: 'كُتُبٌ', example: 'كِتَابٌ',
      ),
      de: GermanLexeme(
        article: 'das', word: 'Buch', plural: 'Bücher', example: 'Das Buch',
      ),
      en: EnglishLexeme(
        word: 'book', plural: 'books', example: 'a book',
      ),
    );
    expect(repository.getDueConcepts([concept]), isEmpty);
  });
}
