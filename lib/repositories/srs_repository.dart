import 'dart:convert';
import 'dart:io';
import '../models/srs_card.dart';
import '../models/concept.dart';

class SRSRepository {
  final Map<String, SRSCard> _cards = {};
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;
  int get totalTracked => _cards.length;

  Future<void> init(String storagePath) async {
    final file = File('$storagePath/user_srs_data.json');
    if (await file.exists()) {
      try {
        final content = await file.readAsString();
        final Map<String, dynamic> data = jsonDecode(content);
        final List list = data['cards'] ?? [];
        _cards.clear();
        for (var item in list) {
          final c = SRSCard.fromJson(item);
          _cards[c.conceptId] = c;
        }
      } catch (_) {}
    }
    _isLoaded = true;
  }

  // استخراج البطاقات المستحقة للمراجعة اليوم
  List<Concept> getDueConcepts(List<Concept> allConcepts) {
    final now = DateTime.now();
    final List<Concept> due = [];

    for (var concept in allConcepts) {
      final card = _cards[concept.conceptId];
      if (card == null) {
        // بطاقة جديدة لم تدرس بعد، تدخل ضمن المستحق اليوم
        due.add(concept);
      } else if (card.nextReviewDate.isBefore(now) || card.nextReviewDate.day == now.day) {
        due.add(concept);
      }
    }
    return due;
  }

  // تسجيل نتيجة المراجعة وحفظها ذرياً
  Future<bool> recordReview(String conceptId, int quality, String storagePath) async {
    var card = _cards[conceptId];
    if (card == null) {
      card = SRSCard(conceptId: conceptId, nextReviewDate: DateTime.now());
      _cards[conceptId] = card;
    }
    card.applyReview(quality);
    return await _saveSafely(storagePath);
  }

  Future<bool> _saveSafely(String storagePath) async {
    try {
      final target = File('$storagePath/user_srs_data.json');
      final temp = File('$storagePath/user_srs_data.tmp');

      final data = {
        'version': 1,
        'updated_at': DateTime.now().toIso8601String(),
        'cards': _cards.values.map((c) => c.toJson()).toList(),
      };

      await temp.writeAsString(jsonEncode(data), flush: true);
      if (await target.exists()) await target.delete();
      await temp.rename(target.path);
      return true;
    } catch (_) {
      return false;
    }
  }
}
