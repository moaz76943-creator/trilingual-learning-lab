class PhoneticGuide {
  final String phoneme;
  final String language;
  final String articulationPointAr;
  final String guideNoteDe;
  final String guideNoteEn;

  const PhoneticGuide({
    required this.phoneme,
    required this.language,
    required this.articulationPointAr,
    required this.guideNoteDe,
    required this.guideNoteEn,
  });
}

class PhoneticComparisonService {
  static List<PhoneticGuide> getCorePhoneticGuides() {
    return const [
      PhoneticGuide(
        phoneme: 'ح',
        language: 'ar',
        articulationPointAr: 'وَسَطُ الحَلْقِ',
        guideNoteDe: 'Stimmhafter pharyngealer Reibelaut, tiefer im Hals als das deutsche "ch".',
        guideNoteEn: 'Voiceless pharyngeal fricative, articulated deeper in the throat than "h".',
      ),
      PhoneticGuide(
        phoneme: 'ö',
        language: 'de',
        articulationPointAr: 'إِطْبَاقُ الشَّفَتَيْنِ مَعَ نُطْقِ الكَسْرَةِ المُمَالَةِ',
        guideNoteDe: 'Gerundeter halboffener Vorderzungenvokal (wie in "schön").',
        guideNoteEn: 'Rounded mid-front vowel, shaped like "e" while rounding lips like "o".',
      ),
      PhoneticGuide(
        phoneme: 'th',
        language: 'en',
        articulationPointAr: 'طَرَفُ اللِّسَانِ مَعَ أَطْرَافِ الثَّنَايَا العُلْيَا',
        guideNoteDe: 'Dentaler Frikativ, ähnlich dem arabischen Buchstaben (ث) oder (ذ).',
        guideNoteEn: 'Dental fricative, placing the tongue tip between the upper front teeth.',
      ),
    ];
  }
}
