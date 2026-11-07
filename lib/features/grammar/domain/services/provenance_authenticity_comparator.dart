// Task #615: Provenance Authenticity and Forensic Craftsmanship Comparator
class ProvenanceAuthenticityEntry {
  final String arabicProvenance;
  final String germanProvenance;
  final String englishProvenance;
  final String forensicDomain;
  const ProvenanceAuthenticityEntry({
    required this.arabicProvenance,
    required this.germanProvenance,
    required this.englishProvenance,
    required this.forensicDomain,
  });
}

class ProvenanceAuthenticityComparator {
  static const List<ProvenanceAuthenticityEntry> entries = [
    ProvenanceAuthenticityEntry(
      arabicProvenance: 'يَنْتَسِبُ نَحْتُ هَذَا القَتَبِ إِلَى صُنَّاعِ بَادِيَةِ الحِجَازِ بِعَيْنِ الإِتْقَانِ',
      germanProvenance: 'Die Schnitzkunst dieses Sattelbaums lässt sich eindeutig auf die Wüstenmeister des Hedschas zurückführen',
      englishProvenance: 'The carving of this pack-saddle tree traces its provenance undeniably to master artisans of the Hijaz',
      forensicDomain: 'Attribution of regional woodworking techniques and saddle ergonomics',
    ),
    ProvenanceAuthenticityEntry(
      arabicProvenance: 'تَشْهَدُ دِبَاغَةُ الجِلْدِ بِالقَرَظِ عَلَى عَرَاقَةِ الصَّانِعِ وَأَمَانَتِهِ',
      germanProvenance: 'Die Gerbung des Leders mit Akazienhülsen zeugt von traditioneller Meisterschaft und Redlichkeit',
      englishProvenance: 'The tanning of the leather with acacia pods attests to the artisan heritage and uncompromised integrity',
      forensicDomain: 'Botanical tanning analysis verifying zero synthetic chemical residues',
    ),
  ];
}
