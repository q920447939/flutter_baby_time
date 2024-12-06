class BabyHeightRecordStandardRelationRespVo {
  BabyHeightRecordStandardRelationRespVo({
    required this.id,
    required this.countryCode,
    required this.babySex,
    required this.standardHeight,
    required this.standardMonth,
    required this.standardMonthDescribe,
    required this.creator,
    required this.relationTime,
    required this.createTime,
    required this.updater,
    required this.updateTime,
  });

  final int? id;
  final String? countryCode;
  final int? babySex;
  final double? standardHeight;
  final int? standardMonth;
  final String? standardMonthDescribe;
  final String? creator;
  final DateTime? relationTime;
  final DateTime? createTime;
  final String? updater;
  final DateTime? updateTime;

  factory BabyHeightRecordStandardRelationRespVo.fromJson(
      Map<String, dynamic> json) {
    return BabyHeightRecordStandardRelationRespVo(
      id: json["id"],
      countryCode: json["countryCode"],
      babySex: json["babySex"],
      standardHeight: json["standardHeight"],
      standardMonth: json["standardMonth"],
      standardMonthDescribe: json["standardMonthDescribe"],
      creator: json["creator"],
      relationTime: DateTime.tryParse(json["relationTime"] ?? ""),
      createTime: DateTime.tryParse(json["createTime"] ?? ""),
      updater: json["updater"],
      updateTime: DateTime.tryParse(json["updateTime"] ?? ""),
    );
  }
}
