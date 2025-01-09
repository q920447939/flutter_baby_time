class FamilyRelationRespVo {
  FamilyRelationRespVo({
    required this.roleId,
    required this.roleName,
    required this.applyTime,
    required this.memberSimpleMoreResVo,
  });

  final int? roleId;
  final String? roleName;
  final DateTime? applyTime;
  final MemberSimpleMoreResVo? memberSimpleMoreResVo;

  factory FamilyRelationRespVo.fromJson(Map<String, dynamic> json) {
    return FamilyRelationRespVo(
      roleId: json["roleId"],
      roleName: json["roleName"],
      applyTime: DateTime.tryParse(json["applyTime"] ?? ""),
      memberSimpleMoreResVo: json["memberSimpleMoreResVO"] == null
          ? null
          : MemberSimpleMoreResVo.fromJson(json["memberSimpleMoreResVO"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "roleName": roleName,
        "applyTime": applyTime?.toIso8601String(),
        "memberSimpleMoreResVO": memberSimpleMoreResVo?.toJson(),
      };
}

class MemberSimpleMoreResVo {
  MemberSimpleMoreResVo({
    required this.id,
    required this.memberCode,
    required this.memberNickName,
    required this.avatar,
  });

  final int? id;
  final String? memberCode;
  final String? memberNickName;
  final String? avatar;

  factory MemberSimpleMoreResVo.fromJson(Map<String, dynamic> json) {
    return MemberSimpleMoreResVo(
      id: json["id"],
      memberCode: json["memberCode"],
      memberNickName: json["memberNickName"],
      avatar: json["avatar"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "memberCode": memberCode,
        "memberNickName": memberNickName,
        "avatar": avatar,
      };
}
