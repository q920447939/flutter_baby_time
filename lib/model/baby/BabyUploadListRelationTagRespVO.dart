class BabyUploadListRelationTagRespVo {
  BabyUploadListRelationTagRespVo({
    required this.id,
    required this.babyId,
    required this.babyUploadTagId,
    required this.creator,
    required this.createTime,
    required this.updater,
    required this.updateTime,
  });

  final int? id;
  final int? babyId;
  final int? babyUploadTagId;
  final String? creator;
  final DateTime? createTime;
  final String? updater;
  final DateTime? updateTime;

  factory BabyUploadListRelationTagRespVo.fromJson(Map<String, dynamic> json) {
    return BabyUploadListRelationTagRespVo(
      id: json["id"],
      babyId: json["babyId"],
      babyUploadTagId: json["babyUploadTagId"],
      creator: json["creator"],
      createTime: DateTime.tryParse(json["createTime"] ?? ""),
      updater: json["updater"],
      updateTime: DateTime.tryParse(json["updateTime"] ?? ""),
    );
  }
}
