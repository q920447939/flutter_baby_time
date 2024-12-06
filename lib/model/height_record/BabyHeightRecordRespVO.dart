class BabyHeightRecordRespVo {
  BabyHeightRecordRespVo({
    required this.id,
    required this.babyId,
    required this.height,
    required this.version,
    required this.recordTime,
    required this.creator,
    required this.createTime,
    required this.updater,
    required this.updateTime,
  });

  final int? id;
  final int? babyId;
  final double? height;
  final int? version;
  final DateTime? recordTime;
  final String? creator;
  final DateTime? createTime;
  final String? updater;
  final DateTime? updateTime;

  factory BabyHeightRecordRespVo.fromJson(Map<String, dynamic> json) {
    return BabyHeightRecordRespVo(
      id: json["id"],
      babyId: json["babyId"],
      height: json["height"],
      version: json["version"],
      recordTime: DateTime.tryParse(json["recordTime"] ?? ""),
      creator: json["creator"],
      createTime: DateTime.tryParse(json["createTime"] ?? ""),
      updater: json["updater"],
      updateTime: DateTime.tryParse(json["updateTime"] ?? ""),
    );
  }
}
