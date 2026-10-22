import 'concept.dart';
import 'verb_model.dart';

class SearchResultItem {
  final String id;
  final String type; // 'concept' or 'verb'
  final String imageId;
  final String titleTarget;
  final String titleAr;
  final String subtitle;
  final dynamic originalObject;

  SearchResultItem({
    required this.id,
    required this.type,
    required this.imageId,
    required this.titleTarget,
    required this.titleAr,
    required this.subtitle,
    required this.originalObject,
  });
}

class SearchEngine {
  // تطبيع العربية: إزالة التشكيل وتوحيد الهمزات والتاء المربوطة
  static String normalizeArabic(String text) {
    var s = text;
    // إزالة علامات التشكيل
    s = s.replaceAll(RegExp(r'[\u064B-\u0652\u0640]'), '');
    // توحيد الهمزات
    s = s.replaceAll(RegExp(r'[أإآ]'), 'ا');
    s = s.replaceAll('ة', 'ه');
    s = s.replaceAll('ى', 'ي');
    return s.trim().toLowerCase();
  }

  // تطبيع الألمانية والإنجليزية: إزالة الفروق وحروف الـ Umlauts
  static String normalizeLatin(String text) {
    var s = text.toLowerCase();
    s = s.replaceAll('ä', 'ae');
    s = s.replaceAll('ö', 'oe');
    s = s.replaceAll('ü', 'ue');
    s = s.replaceAll('ß', 'ss');
    return s.trim();
  }

  // تنفيذ البحث في المفاهيم والأفعال
  static List<SearchResultItem> search({
    required String query,
    required List<Concept> concepts,
    required List<VerbModel> verbs,
    required String targetLang, // 'de' or 'en'
    String filterType = 'all', // 'all', 'concept', 'verb'
  }) {
    if (query.trim().isEmpty) return [];

    final normQueryAr = normalizeArabic(query);
    final normQueryLat = normalizeLatin(query);
    final List<SearchResultItem> results = [];
    final bool isGerman = targetLang == 'de';

    // 1. البحث في المفردات
    if (filterType == 'all' || filterType == 'concept') {
      for (var c in concepts) {
        final arWord = normalizeArabic(c.ar.word);
        final arVoc = normalizeArabic(c.ar.vocalized);
        final targetWord = normalizeLatin(isGerman ? c.de.word : c.en.word);

        if (arWord.contains(normQueryAr) ||
            arVoc.contains(normQueryAr) ||
            targetWord.contains(normQueryLat)) {
          results.add(SearchResultItem(
            id: c.conceptId,
            type: 'concept',
            imageId: c.imageId,
            titleTarget: isGerman ? '${c.de.article}${c.de.word}' : c.en.word,
            titleAr: c.ar.vocalized,
            subtitle: 'مفردة • Plural: ${isGerman ? c.de.plural : c.en.plural}',
            originalObject: c,
          ));
        }
      }
    }

    // 2. البحث في الأفعال
    if (filterType == 'all' || filterType == 'verb') {
      for (var v in verbs) {
        final arInf = normalizeArabic(v.infinitive['ar'] ?? '');
        final arRoot = normalizeArabic(v.rootAr);
        final targetInf = normalizeLatin(isGerman ? v.infinitive['de'] ?? '' : v.infinitive['en'] ?? '');

        if (arInf.contains(normQueryAr) ||
            arRoot.contains(normQueryAr) ||
            targetInf.contains(normQueryLat)) {
          results.add(SearchResultItem(
            id: v.verbId,
            type: 'verb',
            imageId: v.imageId,
            titleTarget: isGerman ? v.infinitive['de'] ?? '' : v.infinitive['en'] ?? '',
            titleAr: v.infinitive['ar'] ?? '',
            subtitle: 'فعل • الجذر: ${v.rootAr}',
            originalObject: v,
          ));
        }
      }
    }

    return results;
  }
}
