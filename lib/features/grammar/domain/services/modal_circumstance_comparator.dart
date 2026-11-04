class ModalCircumstanceGuide {
  final String circumstanceType;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ModalCircumstanceGuide({
    required this.circumstanceType,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ModalCircumstanceComparator {
  static List<ModalCircumstanceGuide> getRules() {
    return const [
      ModalCircumstanceGuide(
        circumstanceType: 'التدرج الكيفي والتؤدة (Gradual Progression: رويداً / schrittweise)',
        arConstruction: 'المصدر النائب عن المفعول المطلق أو الحال (رُوَيْدًا رُوَيْدًا / خُطْوَةً فَخُطْوَةً)',
        deConstruction: 'Modale Adverbien: schrittweise / allmählich / nach und nach',
        enConstruction: 'Step by step / gradually / little by little',
        exampleAr: 'يَفْتِلُ الصَّانِعُ حَبْلَ الحَلْفَاءِ رُوَيْدًا رُوَيْدًا حَتَّى يَشْتَدَّ',
        exampleDe: 'Der Handwerker dreht das Seil schrittweise, bis es fest wird.',
        exampleEn: 'The artisan twists the rope step by step until it grows strong.',
      ),
      ModalCircumstanceGuide(
        circumstanceType: 'الهيئة المصاحبة بالسكينة (Calm Demeanor: هوينا / gemächlich)',
        arConstruction: 'الحال الدالة على الهدوء والوقار (يَمْشِي هُوَيْنَا / رِفْقًا)',
        deConstruction: 'Adverbien der Ruhe: gemächlich / bedächtig / gelassen',
        enConstruction: 'Leisurely / composedly / with gentle care',
        exampleAr: 'تَحْمِلُ الفَتَاةُ سَلَّةَ الثِّمَارِ هُوَيْنَا خَوْفَ أَنْ تَنْفَرِطَ',
        exampleDe: 'Das Mädchen trägt den Korb gemächlich, damit nichts herausfällt.',
        exampleEn: 'The girl carries the basket gently lest any fruit should spill.',
      ),
    ];
  }
}
