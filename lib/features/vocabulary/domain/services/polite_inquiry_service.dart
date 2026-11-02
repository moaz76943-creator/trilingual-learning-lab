class PoliteClarificationItem {
  final String communicativeGoal;
  final String arabic;
  final String german;
  final String english;
  final String toneContext;

  const PoliteClarificationItem({
    required this.communicativeGoal,
    required this.arabic,
    required this.german,
    required this.english,
    required this.toneContext,
  });
}

class PoliteInquiryService {
  static List<PoliteClarificationItem> getInquiryPhrases() {
    return const [
      PoliteClarificationItem(
        communicativeGoal: 'طلب الإعادة بلطف (Polite Repetition)',
        arabic: 'عَفْوًا، هَلْ لَكَ أَنْ تُعِيدَ كَلَامَكَ بِلُطْفٍ؟',
        german: 'Verzeihung, könnten Sie das bitte noch einmal wiederholen?',
        english: 'Pardon me, could you please repeat that kindly?',
        toneContext: 'طلب مهذب دون إحراج المتكلم',
      ),
      PoliteClarificationItem(
        communicativeGoal: 'التأكد من الفهم الدقيق (Confirming Understanding)',
        arabic: 'إِذَنْ، المَقْصُودُ هُنَا هُوَ نَقْعُ الأَعْشَابِ فِي مَاءٍ سَاخِنٍ؟',
        german: 'Habe ich richtig verstanden, dass die Kräuter in heißem Wasser ziehen sollen?',
        english: 'If I understand correctly, the herbs should steep in hot water?',
        toneContext: 'تأكيد الخطوات العملية باحترام',
      ),
    ];
  }
}
