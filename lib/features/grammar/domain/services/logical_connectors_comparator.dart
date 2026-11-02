class ConnectorRule {
  final String relation;
  final String arConnector;
  final String deConnector;
  final String deWordOrderImpact;
  final String enConnector;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ConnectorRule({
    required this.relation,
    required this.arConnector,
    required this.deConnector,
    required this.deWordOrderImpact,
    required this.enConnector,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class LogicalConnectorsComparator {
  static List<ConnectorRule> getConnectors() {
    return const [
      ConnectorRule(
        relation: 'السببية والتعليل (Causality)',
        arConnector: 'لِأَنَّ (حرف ناسخ ينصب الاسم)',
        deConnector: 'weil (Subjunktion)',
        deWordOrderImpact: 'ينقل الفعل المصرف إجبارياً إلى نهاية الجملة (Verb-Ende)',
        enConnector: 'because',
        exampleAr: 'نَجَحَ لِأَنَّهُ اجْتَهَدَ',
        exampleDe: 'Er hatte Erfolg, weil er fleißig lernte.',
        exampleEn: 'He succeeded because he studied diligently.',
      ),
      ConnectorRule(
        relation: 'الاستدراك والتعارض (Contradiction)',
        arConnector: 'لَكِنْ / غَيْرَ أَنَّ',
        deConnector: 'aber (Konjunktion Position 0)',
        deWordOrderImpact: 'لا يغير موقع الفعل، يبقى الفعل في الموقع الثاني',
        enConnector: 'but / however',
        exampleAr: 'العَمَلُ شَاقٌّ لَكِنَّهُ نَافِعٌ',
        exampleDe: 'Die Arbeit ist anstrengend, aber sie ist nützlich.',
        exampleEn: 'The work is demanding, but it is beneficial.',
      ),
    ];
  }
}
