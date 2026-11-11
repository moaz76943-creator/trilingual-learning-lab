import 'package:flutter/foundation.dart';
import '../../../../core/audio/phonetic_synthesis_engine.dart';

/// Minimal acoustic pair model testing phonetic discrimination.
class PhoneticMinimalPair {
  final String id;
  final String categoryName;
  final String wordA;
  final String ipaA;
  final String meaningA;
  final String wordB;
  final String ipaB;
  final String meaningB;
  final String targetWord; // The word played during auditory test
  final String articulatoryTipAr;
  final String articulatoryTipDe;
  final String articulatoryTipEn;

  const PhoneticMinimalPair({
    required this.id,
    required this.categoryName,
    required this.wordA,
    required this.ipaA,
    required this.meaningA,
    required this.wordB,
    required this.ipaB,
    required this.meaningB,
    required this.targetWord,
    required this.articulatoryTipAr,
    required this.articulatoryTipDe,
    required this.articulatoryTipEn,
  });

  bool isWordACorrect => targetWord == wordA;
}

/// Controller governing the interactive phonetics laboratory and auditory discernment tests.
class PhoneticStudioController extends ChangeNotifier {
  final List<PhoneticMinimalPair> _pairs;
  int _activePairIndex = 0;
  String? _selectedWord;
  bool? _isCorrect;
  int _score = 0;
  int _totalAttempts = 0;

  PhoneticStudioController({
    List<PhoneticMinimalPair>? pairs,
  }) : _pairs = pairs ?? _defaultMinimalPairs;

  List<PhoneticMinimalPair> get pairs => List.unmodifiable(_pairs);
  int get activePairIndex => _activePairIndex;
  int get totalPairs => _pairs.length;
  String? get selectedWord => _selectedWord;
  bool? get isCorrect => _isCorrect;
  int get score => _score;
  int get totalAttempts => _totalAttempts;

  PhoneticMinimalPair? get currentPair {
    if (_pairs.isEmpty || _activePairIndex >= _pairs.length) return null;
    return _pairs[_activePairIndex];
  }

  double get accuracyPercentage {
    if (_totalAttempts == 0) return 0.0;
    return (_score / _totalAttempts) * 100.0;
  }

  /// Sets the active minimal pair by index.
  void selectPair(int index) {
    if (index >= 0 && index < _pairs.length && _activePairIndex != index) {
      _activePairIndex = index;
      _selectedWord = null;
      _isCorrect = null;
      notifyListeners();
    }
  }

  /// Evaluates user's auditory choice against the target word.
  void submitChoice(String chosenWord) {
    if (currentPair == null || _isCorrect != null) return;

    _selectedWord = chosenWord;
    final correct = chosenWord == currentPair!.targetWord;
    _isCorrect = correct;
    _totalAttempts++;
    if (correct) _score++;

    notifyListeners();
  }

  /// Advances to the next minimal pair test.
  void nextPair() {
    if (_activePairIndex < _pairs.length - 1) {
      _activePairIndex++;
      _selectedWord = null;
      _isCorrect = null;
      notifyListeners();
    }
  }

  /// Resets testing session.
  void reset() {
    _activePairIndex = 0;
    _selectedWord = null;
    _isCorrect = null;
    _score = 0;
    _totalAttempts = 0;
    notifyListeners();
  }

  static final List<PhoneticMinimalPair> _defaultMinimalPairs = [
    const PhoneticMinimalPair(
      id: 'pair_sad_seen',
      categoryName: 'الحُرُوفُ المُفَخَّمَةُ (Emphatics)',
      wordA: 'صَيْفٌ',
      ipaA: 'sˤajf',
      meaningA: 'Sommer / Summer',
      wordB: 'سَيْفٌ',
      ipaB: 'sajf',
      meaningB: 'Schwert / Sword',
      targetWord: 'صَيْفٌ',
      articulatoryTipAr: 'حَرْفُ الصَّادِ صَوْتٌ صَفِيرِيٌّ مُطْبَقٌ يَسْتَعْلِي فِيهِ أَقْصَى اللِّسَانِ، بِخِلاَفِ السِّينِ المُرَقَّقَةِ.',
      articulatoryTipDe: 'Das emphatische /sˤ/ wird mit angehobener Zungenhinterseite gebildet, wodurch der Vokal dunkler klingt.',
      articulatoryTipEn: 'The emphatic /sˤ/ elevates the back of the tongue toward the soft palate, darkening the vowel.',
    ),
    const PhoneticMinimalPair(
      id: 'pair_taa_taa',
      categoryName: 'الحُرُوفُ المُفَخَّمَةُ (Emphatics)',
      wordA: 'طَابَ',
      ipaA: 'tˤaːba',
      meaningA: 'angenehm sein / to be pleasant',
      wordB: 'تَابَ',
      ipaB: 'taːba',
      meaningB: 'bereuen / to repent',
      targetWord: 'طَابَ',
      articulatoryTipAr: 'حَرْفُ الطَّاءِ شَدِيدٌ مُفَخَّمٌ يُطْبِقُ اللِّسَانَ، أَمَّا التَّاءُ فَمَهْمُوسَةٌ مُرَقَّقَةٌ.',
      articulatoryTipDe: 'Das /tˤ/ ist ein velarisierter Verschlusslaut mit starkem Gaumendruck, das /t/ ist hell und behaucht.',
      articulatoryTipEn: 'The /tˤ/ is heavily pharyngealized with tongue contact, while /t/ is a light dental stop.',
    ),
    const PhoneticMinimalPair(
      id: 'pair_german_umlaut_u',
      categoryName: 'الأَصْوَاتُ المُمَالَةُ الأَلْمَانِيَّةُ (Umlaute)',
      wordA: 'fühlen',
      ipaA: 'fyːlən',
      meaningA: 'شَعَرَ / to feel',
      wordB: 'faulen',
      ipaB: 'faʊlən',
      meaningB: 'تَعَفَّنَ / to rot',
      targetWord: 'fühlen',
      articulatoryTipAr: 'صَوْتُ (ü) يُنْطَقُ بِتَثْبِيتِ اللِّسَانِ كَحَرْفِ اليَاءِ مَعَ ضَمِّ الشَّفَتَيْنِ كَحَرْفِ الوَاوِ.',
      articulatoryTipDe: 'Zunge in i-Position, während die Lippen wie beim u gerundet werden.',
      articulatoryTipEn: 'Hold tongue in "ee" position while rounding lips into "oo".',
    ),
  ];
}
