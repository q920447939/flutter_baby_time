class BabyUploadTagRespVo {
  BabyUploadTagRespVo({
    required this.id,
    required this.babyId,
    required this.tagName,
    required this.creator,
    required this.createTime,
    required this.updater,
    required this.updateTime,
  });

  final int? id;
  final int? babyId;
  final String? tagName;
  final String? creator;
  final DateTime? createTime;
  final String? updater;
  final DateTime? updateTime;

  factory BabyUploadTagRespVo.fromJson(Map<String, dynamic> json) {
    return BabyUploadTagRespVo(
      id: json["id"],
      babyId: json["babyId"],
      tagName: json["tagName"],
      creator: json["creator"],
      createTime: DateTime.tryParse(json["createTime"] ?? ""),
      updater: json["updater"],
      updateTime: DateTime.tryParse(json["updateTime"] ?? ""),
    );
  }
}
