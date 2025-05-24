
class PermissionDeSerializing{
  int? po;
  int? report;
  int? contact;
  int? gr;
  int? dp;
  int? ap;
  int? manual;
  int? statics;
  int? visualizations;
  int? apo;
  int? epo;
  int? goodrec;
  int? plant;

  PermissionDeSerializing(
  {required this.po,
    required this.report,
    required this.contact,
    required this.gr,
    required this.dp,
    required this.ap,
    required this.manual,
    required this.statics,
    required this.visualizations,
    required this.apo,
    required this.epo,
    required this.goodrec,
    required this.plant});


  factory PermissionDeSerializing.fromJson(Map<String, dynamic> json) {
    return PermissionDeSerializing(
        po:json['po'],
        report:json['report'],
        contact:json['contact'],
        gr:json['gr'],
        dp:json['dp'],
        ap:json['ap'],
        manual:json['manual'],
        statics:json['statics'],
        visualizations:json['visualizations'],
        apo:json['apo'],
        epo:json['epo'],
        goodrec:json['goodrec'],
        plant:json['plant']
    );
  }
}