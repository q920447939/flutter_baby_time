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
    required this.applyInfo,
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
  final ApplyInfo? applyInfo;

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
      applyInfo: json["applyInfo"] == null
          ? null
          : ApplyInfo.fromJson(json["applyInfo"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "applyFamilyId": applyFamilyId,
        "applyFamilyCode": applyFamilyCode,
        "applyId": applyId,
        "applyStatus": applyStatus,
        "failReason": failReason,
        "creator": creator,
        "createTime": createTime?.toIso8601String(),
        "updater": updater,
        "updateTime": updateTime?.toIso8601String(),
        "applyInfo": applyInfo?.toJson(),
      };
}

class ApplyInfo {
  ApplyInfo({
    required this.memberCode,
    required this.memberNickName,
    required this.avatar,
  });

  final String? memberCode;
  final String? memberNickName;
  final String? avatar;

  factory ApplyInfo.fromJson(Map<String, dynamic> json) {
    return ApplyInfo(
      memberCode: json["memberCode"],
      memberNickName: json["memberNickName"],
      avatar: json["avatar"],
    );
  }

  Map<String, dynamic> toJson() => {
        "memberCode": memberCode,
        "memberNickName": memberNickName,
        "avatar": avatar,
      };
}
