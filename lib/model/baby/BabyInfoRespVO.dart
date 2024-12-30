class BabyInfoRespVo {
  BabyInfoRespVo({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.sex,
    required this.birthday,
    required this.createTime,
    required this.familyRespVo,
  });

  final int? id;
  final String? name;
  final String? avatarUrl;
  final int? sex;
  final DateTime? birthday;
  final DateTime? createTime;
  final FamilyRespVo? familyRespVo;

  BabyInfoRespVo copyWith({
    int? id,
    String? name,
    String? avatarUrl,
    int? sex,
    DateTime? birthday,
    DateTime? createTime,
    FamilyRespVo? familyRespVo,
  }) {
    return BabyInfoRespVo(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      sex: sex ?? this.sex,
      birthday: birthday ?? this.birthday,
      createTime: createTime ?? this.createTime,
      familyRespVo: familyRespVo ?? this.familyRespVo,
    );
  }

  factory BabyInfoRespVo.fromJson(Map<String, dynamic> json) {
    return BabyInfoRespVo(
      id: json["id"],
      name: json["name"],
      avatarUrl: json["avatarUrl"],
      sex: json["sex"],
      birthday: DateTime.tryParse(json["birthday"] ?? ""),
      createTime: DateTime.tryParse(json["createTime"] ?? ""),
      familyRespVo: json["familyRespVO"] == null
          ? null
          : FamilyRespVo.fromJson(json["familyRespVO"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatarUrl": avatarUrl,
        "sex": sex,
        "birthday": birthday,
        "createTime": createTime?.toIso8601String(),
        "familyRespVO": familyRespVo?.toJson(),
      };
}

class FamilyRespVo {
  FamilyRespVo({
    required this.id,
    required this.familyName,
    required this.familyMemberCount,
    required this.createTime,
    required this.roleId,
    required this.roleName,
  });

  final int? id;
  final String? familyName;
  final int? familyMemberCount;
  final DateTime? createTime;
  final int? roleId;
  final String? roleName;

  factory FamilyRespVo.fromJson(Map<String, dynamic> json) {
    return FamilyRespVo(
      id: json["id"],
      familyName: json["familyName"],
      familyMemberCount: json["familyMemberCount"],
      createTime: DateTime.tryParse(json["createTime"] ?? ""),
      roleId: json["roleId"],
      roleName: json["roleName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "familyName": familyName,
        "familyMemberCount": familyMemberCount,
        "createTime": createTime?.toIso8601String(),
        "roleId": roleId,
        "roleName": roleName,
      };
}
