import 'package:flutter/foundation.dart';

enum ArticulationDifficulty {
  standard,
  intermediate,
  challenging,
}

/// A specific phonetic guidance item for vocabulary study.
class PhoneticArticulatoryHint {
  final String sound;
  final String languageCode;
  final ArticulationDifficulty difficulty;
  final String phonemeDescription;
  final String vocalTipAr;
  final String vocalTipDe;
  final String vocalTipEn;

  const PhoneticArticulatoryHint({
    required this.sound,
    required this.languageCode,
    required this.difficulty,
    required this.phonemeDescription,
    required this.vocalTipAr,
    required this.vocalTipDe,
    required this.vocalTipEn,
  });
}

/// Engine generating acoustic articulation hints across Arabic, German, and English.
class PhoneticAlignmentEngine {
  /// Known Arabic phonological friction patterns.
  static final List<PhoneticArticulatoryHint> _arabicRules = [
    const PhoneticArticulatoryHint(
      sound: 'ق',
      languageCode: 'ar',
      difficulty: ArticulationDifficulty.challenging,
      phonemeDescription: 'Voiceless uvular stop /q/',
      vocalTipAr: 'صَوْتٌ لَهَوِيٌّ شَدِيدٌ يَخْرُجُ مِنْ أَقْصَى اللِّسَانِ مَعَ الحَنَكِ اللَّحْمِيِّ.',
      vocalTipDe: 'Stimmloser uvularer Verschlusslaut ganz hinten am weichen Gaumen.',
      vocalTipEn: 'Voiceless uvular stop produced far back at the uvula, deeper than /k/.',
    ),
    const PhoneticArticulatoryHint(
      sound: 'ع',
      languageCode: 'ar',
      difficulty: ArticulationDifficulty.challenging,
      phonemeDescription: 'Voiced pharyngeal fricative /ʕ/',
      vocalTipAr: 'صَوْتٌ حَلْقِيٌّ مُتَوَسِّطٌ يَخْرُجُ مِنْ وَسَطِ الحَلْقِ بِمُضَايَقَةِ المَجْرَى.',
      vocalTipDe: 'Stimmhafter pharyngealer Reibelaut mitten im Rachenraum.',
      vocalTipEn: 'Voiced pharyngeal sound produced by tightening the deep throat muscles.',
    ),
    const PhoneticArticulatoryHint(
      sound: 'ص',
      languageCode: 'ar',
      difficulty: ArticulationDifficulty.intermediate,
      phonemeDescription: 'Pharyngealized alveolar fricative /sˤ/ (Emphatic)',
      vocalTipAr: 'صَوْتٌ صَفِيرِيٌّ مُطْبَقٌ مَعَ اسْتِعْلاَءِ أَقْصَى اللِّسَانِ.',
      vocalTipDe: 'Emphatisches, dumpfes S mit Hebung der Zungenhinterseite.',
      vocalTipEn: 'Emphatic S sound pronounced with the back of the tongue raised.',
    ),
  ];

  /// Known German phonological friction patterns.
  static final List<PhoneticArticulatoryHint> _germanRules = [
    const PhoneticArticulatoryHint(
      sound: 'ch',
      languageCode: 'de',
      difficulty: ArticulationDifficulty.intermediate,
      phonemeDescription: 'Palatal or velar fricative (/ç/ or /x/)',
      vocalTipAr: 'يُنْطَقُ كَالشِّينِ المُرَقَّقَةِ بَعْدَ الكَسْرَةِ، أَوْ كَالخَاءِ بَعْدَ الضَّمَّةِ وَالفَتْحَةِ.',
      vocalTipDe: 'Ich-Laut nach vorderen Vokalen oder Ach-Laut nach hinteren Vokalen.',
      vocalTipEn: 'Soft palatal /ç/ after front vowels (ich), velar /x/ after back vowels (ach).',
    ),
    const PhoneticArticulatoryHint(
      sound: 'ü',
      languageCode: 'de',
      difficulty: ArticulationDifficulty.intermediate,
      phonemeDescription: 'Close front rounded vowel /y/',
      vocalTipAr: 'صَوْتُ الكَسْرَةِ الأَلْمَانِيَّةِ مَعَ ضَمِّ الشَّفَتَيْنِ كَحَرْفِ الوَاوِ.',
      vocalTipDe: 'Vorderer gerundeter Vokal (Zunge wie bei "i", Lippen wie bei "u").',
      vocalTipEn: 'Shape lips for "oo" while vocalizing an "ee" sound.',
    ),
  ];

  /// Analyzes a trilingual word entry and returns all applicable phonetic guidance hints.
  static List<PhoneticArticulatoryHint> analyzeTerm({
    required String arTerm,
    required String deTerm,
    required String enTerm,
  }) {
    final hints = <PhoneticArticulatoryHint>[];

    // Check Arabic phonemes
    for (final rule in _arabicRules) {
      if (arTerm.contains(rule.sound)) {
        hints.add(rule);
      }
    }

    // Check German phonemes
    final lowerDe = deTerm.toLowerCase();
    for (final rule in _germanRules) {
      if (lowerDe.contains(rule.sound)) {
        hints.add(rule);
      }
    }

    return hints;
  }
}
