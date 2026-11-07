// Task #825: Acoustic Resonance and String Frequency Tuning Comparator
class AcousticResonanceEntry {
  final String arabicResonance;
  final String germanResonance;
  final String englishResonance;
  final String harmonicPrinciple;
  const AcousticResonanceEntry({
    required this.arabicResonance,
    required this.germanResonance,
    required this.englishResonance,
    required this.harmonicPrinciple,
  });
}

class AcousticResonanceComparator {
  static const List<AcousticResonanceEntry> harmonics = [
    AcousticResonanceEntry(
      arabicResonance: 'كُلَّمَا لَطُفَتْ سَمَاكَةُ صَفِيحَةِ الشُّوحِ، ازْدَادَتْ قَصْعَةُ العُودِ رَنِينًا وَصَفَاءً',
      germanResonance: 'Je feiner die Fichtenholzdecke gehobelt ist, desto reiner und voller schwingt der Resonanzkörper der Laute',
      englishResonance: 'The more delicately the spruce soundboard is planed, the purer and richer the lute body resonates',
      harmonicPrinciple: 'Sympathetic acoustic vibration dependent upon wood grain uniformity and low damping',
    ),
    AcousticResonanceEntry(
      arabicResonance: 'بِمِقْدَارِ دِقَّةِ فَتْلِ أَوْتَارِ الحَرِيرِ، تَتَوَافَقُ النَّغَمَاتُ دُونَ نُشُوزٍ أَوْ تَفَاوُتٍ',
      germanResonance: 'Im Maße wie die Seidensaiten gleichförmig gezwirnt sind, stimmen die Obertöne ohne jede Dissonanz',
      englishResonance: 'In proportion as the silk strings are uniformly twisted, the overtones align without any dissonance',
      harmonicPrinciple: 'Consistent linear mass density across vibrating string lengths ensuring true pitch intonation',
    ),
  ];
}
