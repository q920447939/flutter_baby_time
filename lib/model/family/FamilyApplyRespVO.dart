class FamilyApplyRespVo {
  FamilyApplyRespVo({
    required this.id,
    required this.applyFamilyId,
    required this.applyFamilyCode,
    required this.applyId,
    required this.applyStatus,
    required this.failReason,
    required this.creator,
    required this.createTime,
    required this.updater,
    required this.updateTime,
  });

  final int? id;
  final int? applyFamilyId;
  final String? applyFamilyCode;
  final int? applyId;
  final int? applyStatus;
  final String? failReason;
  final String? creator;
  final DateTime? createTime;
  final String? updater;
  final DateTime? updateTime;

  factory FamilyApplyRespVo.fromJson(Map<String, dynamic> json) {
    return FamilyApplyRespVo(
      id: json["id"],
      applyFamilyId: json["applyFamilyId"],
      applyFamilyCode: json["applyFamilyCode"],
      applyId: json["applyId"],
      applyStatus: json["applyStatus"],
      failReason: json["failReason"],
      creator: json["creator"],
      createTime: DateTime.tryParse(json["createTime"] ?? ""),
      updater: json["updater"],
      updateTime: DateTime.tryParse(json["updateTime"] ?? ""),
    );
  }
}
