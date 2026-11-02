class ModalVerbMapping {
  final String modality;
  final String arExpression;
  final String deModal;
  final String enModal;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ModalVerbMapping({
    required this.modality,
    required this.arExpression,
    required this.deModal,
    required this.enModal,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ModalVerbsComparator {
  static List<ModalVerbMapping> getCoreModalMappings() {
    return const [
      ModalVerbMapping(
        modality: 'القدرة والاستطاعة (Ability)',
        arExpression: 'يَسْتَطِيعُ أَنْ / يَقْدِرُ عَلَى',
        deModal: 'können (kann)',
        enModal: 'can / be able to',
        exampleAr: 'أَسْتَطِيعُ قِرَاءَةَ المَخْطُوطِ',
        exampleDe: 'Ich kann das Manuskript lesen.',
        exampleEn: 'I can read the manuscript.',
      ),
      ModalVerbMapping(
        modality: 'الوجوب والمسؤولية (Obligation)',
        arExpression: 'يَجِبُ أَنْ / يَنْبَغِي لَهُ',
        deModal: 'müssen (muss) / sollen',
        enModal: 'must / have to / should',
        exampleAr: 'يَجِبُ أَنْ نُتْقِنَ العَمَلَ',
        exampleDe: 'Wir müssen die Arbeit gewissenhaft ausführen.',
        exampleEn: 'We must perform the work conscientiously.',
      ),
      ModalVerbMapping(
        modality: 'الإذن والجواز (Permission)',
        arExpression: 'يَجُوزُ / يُسْمَحُ لَهُ أَنْ',
        deModal: 'dürfen (darf)',
        enModal: 'may / be allowed to',
        exampleAr: 'يَجُوزُ لَكَ الدُّخُولُ بِلُطْفٍ',
        exampleDe: 'Sie dürfen eintreten.',
        exampleEn: 'You may enter politely.',
      ),
    ];
  }
}
