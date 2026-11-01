import 'package:flutter/material.dart';
import '../../../vocabulary/domain/entities/vocabulary_concept.dart';
import '../../../sentences/domain/entities/sentence_item.dart';

/// مصنع بطاقات التعلم الموحد CardFactory لإنشاء البطاقة المناسبة حسب نوع المحتوى
class LearningCardFactory {
  /// بناء بطاقة المفردة اللغوية
  static Widget createVocabularyCard({
    required VocabularyConcept concept,
    VoidCallback? onTap,
    VoidCallback? onAudioTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      concept.cefrLevel,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  if (onAudioTap != null)
                    IconButton(
                      icon: const Icon(Icons.volume_up, color: Color(0xFF2E7D32)),
                      onPressed: onAudioTap,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                concept.arabic,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                concept.germanArticle != null
                    ? '${concept.germanArticle} ${concept.german}'
                    : concept.german,
                style: const TextStyle(fontSize: 18, color: Color(0xFF1565C0)),
              ),
              const SizedBox(height: 4),
              Text(
                concept.english,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// بناء بطاقة الجملة السياقية
  static Widget createSentenceCard({
    required SentenceItem sentence,
    VoidCallback? onAudioTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sentence.arabic,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              sentence.german,
              style: const TextStyle(fontSize: 16, color: Color(0xFF2E7D32)),
            ),
            const SizedBox(height: 4),
            Text(
              sentence.english,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
