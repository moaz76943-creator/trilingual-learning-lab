import '../models/comprehension_cloze_models.dart';

class ComprehensionClozeRepository {
  const ComprehensionClozeRepository();

  List<TrilingualReadingPassage> getPassages() {
    return const [
      TrilingualReadingPassage(
        id: 'cc_01',
        domain: PassageDomain.scientificHeritage,
        levelBadge: 'B1–B2',
        titleAr: 'بَدَايَةُ الْمَنْهَجِ التَّجْرِيبِيِّ عِنْدَ ابْنِ الْهَيْثَمِ',
        titleEn: 'Ibn al-Haytham and the Foundations of Experimental Optics',
        titleDe: 'Ibn al-Haitham und die Grundlagen der experimentellen Optik',
        bodyAr:
            'أَسَّسَ الْعَالِمُ الْحَسَنُ بْنُ الْهَيْثَمِ مَنْهَجًا عِلْمِيًّا صَارِمًا يَعْتَمِدُ عَلَى الْمُلَاحَظَةِ وَالتَّجْرِبَةِ الْمُتَكَرِّرَةِ. لَمْ يَكْتَفِ بِالنَّظَرِيَّاتِ السَّابِقَةِ، بَلْ فَحَصَ سُلُوكَ الضَّوْءِ فِي الْحُجْرَةِ الْمُظْلِمَةِ حَتَّى أَثْبَتَ أَنَّ الرُّؤْيَةَ تَحْدُثُ بِدُخُولِ الضَّوْءِ إِلَى الْعَيْنِ.',
        bodyEn:
            'The scholar Ibn al-Haytham established a rigorous scientific method grounded in observation and repeatable experimentation. Rather than accepting earlier theories uncritically, he examined how light behaves inside a darkened chamber and demonstrated that vision occurs when light enters the eye.',
        bodyDe:
            'Der Gelehrte Ibn al-Haitham begründete eine strenge wissenschaftliche Methode, die auf Beobachtung und wiederholbaren Experimenten beruht. Statt frühere Theorien ungeprüft zu übernehmen, untersuchte er das Licht in einer dunklen Kammer und bewies, dass das Sehen durch in das Auge eintretendes Licht entsteht.',
        keyTermsSummary: [
          'مَنْهَجٌ صَارِمٌ = rigorous method = strenge Methode',
          'الْمُلَاحَظَةُ وَالتَّجْرِبَةُ = observation & experiment = Beobachtung & Experiment',
        ],
      ),
      TrilingualReadingPassage(
        id: 'cc_02',
        domain: PassageDomain.ethicalLeadership,
        levelBadge: 'B1',
        titleAr: 'الْإِتْقَانُ وَالْأَمَانَةُ فِي الْعَمَلِ الْجَمَاعِيِّ',
        titleEn: 'Excellence and Trustworthiness in Collaborative Work',
        titleDe: 'Sorgfalt und Verlässlichkeit in der Teamarbeit',
        bodyAr:
            'يَتَحَقَّقُ النَّجَاحُ الْمُسْتَدَامُ حِينَ يَلْتَزِمُ كُلُّ فَرْدٍ بِالْأَمَانَةِ وَإِتْقَانِ مَا أُسْنِدَ إِلَيْهِ. فَالْوُضُوحُ فِي التَّوَاصُلِ وَالْوَفَاءُ بِالْمَوَاعِيدِ يَبْنِيَانِ الثِّقَةَ بَيْنَ أَعْضَاءِ الْفَرِيقِ، وَيَجْعَلَانِ الْعَمَلَ مُثْمِرًا وَمُبَارَكًا.',
        bodyEn:
            'Sustainable success is achieved when every member upholds integrity and excels in their assigned responsibilities. Clear communication and keeping commitments build mutual trust across the team, making the collective effort fruitful.',
        bodyDe:
            'Nachhaltiger Erfolg entsteht, wenn jedes Teammitglied Aufrichtigkeit wahrt und seine Aufgaben sorgfältig erfüllt. Klare Kommunikation sowie Termintreue stärken das Vertrauen und führen zu verlässlichen Ergebnissen.',
        keyTermsSummary: [
          'الْوَفَاءُ بِالْمَوَاعِيدِ = keeping commitments = die Termintreue',
          'الثِّقَةُ الْمُتَبَادَلَةُ = mutual trust = gegenseitiges Vertrauen',
        ],
      ),
      TrilingualReadingPassage(
        id: 'cc_03',
        domain: PassageDomain.linguisticsAndTranslation,
        levelBadge: 'B2–C1',
        titleAr: 'بَيْنَ التَّرْجَمَةِ الْحَرْفِيَّةِ وَالْأَمَانَةِ السِّيَاقِيَّةِ',
        titleEn: 'Between Literal Rendering and Contextual Fidelity',
        titleDe: 'Zwischen wörtlicher Wiedergabe und Kontexttreue',
        bodyAr:
            'لَا تَقْتَصِرُ التَّرْجَمَةُ الدَّقِيقَةُ عَلَى اسْتِبْدَالِ مُفْرَدَةٍ بِأُخْرَى؛ إِذْ قَدْ يَخْتَلِفُ الْمَقْصِدُ التَّدَاوُلِيُّ مِنْ لُغَةٍ إِلَى أُخْرَى. لِذَلِكَ يَنْبَغِي لِلْمُتَرْجِمِ أَنْ يُرَاعِيَ السِّيَاقَ وَرُتْبَةَ الْجُمْلَةِ وَمُسْتَوَى الْخِطَابِ قَبْلَ اخْتِيَارِ الصِّيغَةِ النِّهَائِيَّةِ.',
        bodyEn:
            'Accurate translation is never limited to swapping one word for another, because pragmatic intent often shifts across languages. Therefore, a translator must weigh context, clause structure, and register before settling on the final phrasing.',
        bodyDe:
            'Eine präzise Übersetzung beschränkt sich nicht auf den Austausch einzelner Wörter, da die pragmatische Absicht je nach Sprache variiert. Deshalb muss man Kontext, Satzbau und Sprachregister sorgfältig abwägen.',
        keyTermsSummary: [
          'الْمَقْصِدُ التَّدَاوُلِيُّ = pragmatic intent = pragmatische Absicht',
          'مُسْتَوَى الْخِطَابِ = register = das Sprachregister',
        ],
      ),
      TrilingualReadingPassage(
        id: 'cc_04',
        domain: PassageDomain.sustainableEngineering,
        levelBadge: 'B1–B2',
        titleAr: 'الِاقْتِصَادُ فِي الْمِيَاهِ وَتَصْمِيمُ الْمَدُنِ الذَّكِيَّةِ',
        titleEn: 'Water Conservation and Resource-Aware Urban Design',
        titleDe: 'Wassersparen und nachhaltige Stadtplanung',
        bodyAr:
            'تُوَاجِهُ الْمُدُنُ الْحَدِيثَةُ تَحَدِّيًا مُتَزَايِدًا فِي حِفْظِ الْمَوَارِدِ الْمَائِيَّةِ. وَتُسْهِمُ شَبَكَاتُ الِاسْتِشْعَارِ الذَّكِيَّةُ وَإِعَادَةُ تَدْوِيرِ الْمِيَاهِ الرَّمَادِيَّةِ فِي تَقْلِيلِ الْهَدْرِ، تَحْقِيقًا لِمَبْدَأِ عَدَمِ الْإِسْرَافِ وَحِمَايَةِ الْبِيئَةِ.',
        bodyEn:
            'Modern cities face a growing challenge in preserving water resources. Smart sensor networks and greywater recycling help minimize waste, aligning engineering efficiency with responsible stewardship of the environment.',
        bodyDe:
            'Moderne Städte stehen vor der wachsenden Herausforderung, Wasserressourcen zu schonen. Intelligente Sensornetze und Grauwasserrecycling reduzieren Verluste und verbinden Effizienz mit Umweltschutz.',
        keyTermsSummary: [
          'تَقْلِيلُ الْهَدْرِ = minimize waste = Verluste reduzieren',
          'حِفْظُ الْمَوَارِدِ = preserve resources = Ressourcen schonen',
        ],
      ),
      TrilingualReadingPassage(
        id: 'cc_05',
        domain: PassageDomain.travelAndCulture,
        levelBadge: 'A2–B1',
        titleAr: 'التَّأَمُّلُ فِي الْمَكْتَبَاتِ التَّارِيخِيَّةِ عَبْرَ السَّفَرِ',
        titleEn: 'Exploring Historic Libraries Through Purposeful Travel',
        titleDe: 'Historische Bibliotheken auf Bildungsreisen entdecken',
        bodyAr:
            'تُعَدُّ زِيَارَةُ الْمَكْتَبَاتِ الْقَدِيمَةِ فِي الْمُدُنِ الْعَرِيقَةِ نَافِذَةً عَلَى تَارِيخِ الْعِلْمِ وَالْخَطِّ. حِينَ يَتَجَوَّلُ الزَّائِرُ بَيْنَ الرُّفُوفِ الْخَشَبِيَّةِ، يُدْرِكُ كَيْفَ انْتَقَلَتِ الْمَعْرِفَةُ عَبْرَ الْأَجْيَالِ بِالصَّبْرِ وَالتَّدْوِينِ.',
        bodyEn:
            'Visiting historic libraries in heritage cities opens a window into the history of scholarship and calligraphy. As a visitor walks along the wooden shelves, it becomes clear how knowledge traveled across generations through patience and careful documentation.',
        bodyDe:
            'Der Besuch historischer Bibliotheken in alten Kulturstädten eröffnet einen Einblick in die Geschichte der Wissenschaft und Schreibkunst. Zwischen den Holzregalen erkennt man, wie Wissen durch Geduld und Dokumentation über Generationen weitergegeben wurde.',
        keyTermsSummary: [
          'التَّدْوِينُ = documentation = die Dokumentation',
          'عَبْرَ الْأَجْيَالِ = across generations = über Generationen',
        ],
      ),
      TrilingualReadingPassage(
        id: 'cc_06',
        domain: PassageDomain.digitalCraftsmanship,
        levelBadge: 'B2',
        titleAr: 'أَهَمِّيَّةُ الِاخْتِبَارَاتِ الْآلِيَّةِ قَبْلَ نَشْرِ التَّطْبِيقِ',
        titleEn: 'Why Automated Tests Matter Before Every Release',
        titleDe: 'Warum automatisierte Tests vor jeder Veröffentlichung unverzichtbar sind',
        bodyAr:
            'لَا يَنْبَغِي نَشْرُ أَيِّ تَحْدِيثٍ بَرْمَجِيٍّ قَبْلَ التَّحَقُّقِ مِنْ سَلَامَةِ الْوَظَائِفِ الْأَسَاسِيَّةِ. فَالِاخْتِبَارَاتُ الْآلِيَّةُ تَكْشِفُ الْأَعْطَالَ مُبَكِّرًا، وَتَمْنَعُ تَرَاجُعَ الْأَدَاءِ، وَتَمْنَحُ الْمُطَوِّرَ ثِقَةً عَالِيَةً عِنْدَ إِضَافَةِ مَزَايَا جَدِيدَةٍ.',
        bodyEn:
            'No software update should be shipped before verifying core functionality. Automated tests catch regressions early, prevent silent failures, and give engineers confidence when introducing new capabilities.',
        bodyDe:
            'Kein Software-Update sollte veröffentlicht werden, bevor die Kernfunktionen geprüft wurden. Automatisierte Tests decken Fehler frühzeitig auf, verhindern Rückschritte und schaffen Sicherheit bei neuen Funktionen.',
        keyTermsSummary: [
          'تَرَاجُعُ الْأَدَاءِ = regression = der Rückschritt',
          'مُبَكِّرًا = early = frühzeitig',
        ],
      ),
    ];
  }

  List<ClozeBlankItem> getClozeDrills() {
    return const [
      ClozeBlankItem(
        id: 'ccd_01',
        domain: PassageDomain.scientificHeritage,
        targetLanguage: 'German',
        sentenceWithBlankAr: 'أَكْمِلِ الْجُمْلَةَ الْأَلْمَانِيَّةَ: «Ibn al-Haitham begründete eine Methode, ... auf Beobachtung beruht.»',
        sentenceWithBlankEn: 'Complete the German relative clause referring to feminine "eine Methode":',
        sentenceWithBlankDe: 'Ergänzen Sie das passende Relativpronomen: „eine Methode, ... auf Beobachtung beruht“.',
        options: [
          'der',
          'die',
          'das',
        ],
        correctIndex: 1,
        grammarReasonAr: 'كَلِمَةُ «die Methode» مُؤَنَّثَةٌ وَمَوْقِعُهَا فِي الْجُمْلَةِ الصِّلَةِ فَاعِلٌ (Nominativ)، فَالضَّمِيرُ الْمَوْصُولُ هُوَ «die».',
      ),
      ClozeBlankItem(
        id: 'ccd_02',
        domain: PassageDomain.ethicalLeadership,
        targetLanguage: 'Arabic',
        sentenceWithBlankAr: 'اخْتَرِ الضَّبْطَ الصَّحِيحَ لِلْفَرَاغِ: «يَلْتَزِمُ كُلُّ فَرْدٍ بِإِتْقَانِ مَا أُسْنِدَ ...»',
        sentenceWithBlankEn: 'Select the accurate prepositional pronoun for "assigned to him":',
        sentenceWithBlankDe: 'Wählen Sie die korrekte Präpositionalform:',
        options: [
          'إِلَيْهِ',
          'عَنْهُ',
          'فَوْقَهُ',
        ],
        correctIndex: 0,
        grammarReasonAr: 'الْفِعْلُ «أُسْنِدَ» يَتَعَدَّى إِلَى الْمُكَلَّفِ بِحَرْفِ «إِلَى»: «أُسْنِدَ إِلَيْهِ».',
      ),
      ClozeBlankItem(
        id: 'ccd_03',
        domain: PassageDomain.linguisticsAndTranslation,
        targetLanguage: 'German',
        sentenceWithBlankAr: 'أَكْمِلِ الرَّابِطَ التَّعْلِيلِيَّ فِي: «... die Absicht variiert, muss man den Kontext abwägen.»',
        sentenceWithBlankEn: 'Choose the German causal subordinator appropriate at sentence start:',
        sentenceWithBlankDe: 'Welcher Kausalkonnektor passt am Satzanfang?',
        options: [
          'Denn',
          'Da',
          'Deshalb',
        ],
        correctIndex: 1,
        grammarReasonAr: '«Da» تَقَعُ فِي صَدْرِ الْجُمْلَةِ التَّابِعَةِ (Verbletzt: variiert) لِذِكْرِ السَّبَبِ الْمَعْلُومِ.',
      ),
      ClozeBlankItem(
        id: 'ccd_04',
        domain: PassageDomain.sustainableEngineering,
        targetLanguage: 'German',
        sentenceWithBlankAr: 'اخْتَرِ الْمَصْدَرَ الْمُتَعَدِّيَ بِالْحَرْفِ الصَّحِيحِ: «Sensoren tragen ... bei, Verluste zu reduzieren.»',
        sentenceWithBlankEn: 'Select the correct pronominal adverb with "beitragen zu":',
        sentenceWithBlankDe: 'Welches Korrelat verlangt das Verb „beitragen zu“?',
        options: [
          'darüber',
          'dazu',
          'damit',
        ],
        correctIndex: 1,
        grammarReasonAr: 'الْفِعْلُ «beitragen» يَلْزَمُهُ حَرْفُ «zu»، فَتُصْبِحُ صِيغَةُ التَّمَهيدِ لِلْمَصْدَرِ «dazu».',
      ),
      ClozeBlankItem(
        id: 'ccd_05',
        domain: PassageDomain.travelAndCulture,
        targetLanguage: 'English',
        sentenceWithBlankAr: 'أَكْمِلِ الْجُمْلَةَ الْإِنْجِلِيزِيَّةَ: «Visiting historic libraries ... a window into the history of scholarship.»',
        sentenceWithBlankEn: 'Select the correct singular verb agreement for the gerund subject:',
        sentenceWithBlankDe: 'Wählen Sie das passende Verb für das Gerundium als Subjekt:',
        options: [
          'open',
          'opens',
          'are opening',
        ],
        correctIndex: 1,
        grammarReasonAr: 'الْمَصْدَرُ الْجِرَانْدِيُّ «Visiting historic libraries» يُعَامَلُ مُعَامَلَةَ الْمُفْرَدِ، فَيَأْخُذُ «opens».',
      ),
      ClozeBlankItem(
        id: 'ccd_06',
        domain: PassageDomain.digitalCraftsmanship,
        targetLanguage: 'German',
        sentenceWithBlankAr: 'أَكْمِلْ جُمْلَةَ الْمَبْنِيِّ لِلْمَجْهُولِ مَعَ «sollen»: «Kein Update sollte veröffentlicht ..., bevor es geprüft wurde.»',
        sentenceWithBlankEn: 'Complete the German passive infinitive after modal "sollte":',
        sentenceWithBlankDe: 'Ergänzen Sie den Passiv-Infinitiv nach „sollte“:',
        options: [
          'sein',
          'werden',
          'haben',
        ],
        correctIndex: 1,
        grammarReasonAr: 'الْمَبْنِيُّ لِلْمَجْهُولِ الْحَدَثِيُّ (Vorgangspassiv) مَعَ الْفِعْلِ النَّاقِصِ يَنْتَهِي بِـ «Partizip II + werden».',
      ),
    ];
  }
}
