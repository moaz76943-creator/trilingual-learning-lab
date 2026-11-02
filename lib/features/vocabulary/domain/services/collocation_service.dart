class TrilingualCollocation {
  final String arCollocation;
  final String deCollocation;
  final String enCollocation;
  final String functionalDomain;

  const TrilingualCollocation({
    required this.arCollocation,
    required this.deCollocation,
    required this.enCollocation,
    required this.functionalDomain,
  });
}

class CollocationService {
  static List<TrilingualCollocation> getCoreCollocations() {
    return const [
      TrilingualCollocation(
        arCollocation: 'بَذَلَ قُصَارَى جُهْدِهِ',
        deCollocation: 'sein Bestes geben / sich große Mühe geben',
        enCollocation: 'to do one\'s utmost / make every effort',
        functionalDomain: 'السعي والعمل الدؤوب',
      ),
      TrilingualCollocation(
        arCollocation: 'أَوْفَى بِالعَهْدِ وَالوَعْدِ',
        deCollocation: 'ein Versprechen treu halten',
        enCollocation: 'to keep a promise faithfully',
        functionalDomain: 'الأمانة ومكارم الأخلاق',
      ),
      TrilingualCollocation(
        arCollocation: 'ضَرَبَ مَثَلًا حَسَنًا',
        deCollocation: 'ein gutes Vorbild sein',
        enCollocation: 'to set a good example',
        functionalDomain: 'التربية والسلوك القويم',
      ),
    ];
  }
}
