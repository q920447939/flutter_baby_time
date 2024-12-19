class FamilyRespVo {
  FamilyRespVo({
    required this.id,
    required this.familyName,
    required this.familyMemberCount,
    required this.createTime,
  });

  final int? id;
  final String? familyName;
  final int? familyMemberCount;
  final DateTime? createTime;

  factory FamilyRespVo.fromJson(Map<String, dynamic> json) {
    return FamilyRespVo(
      id: json["id"],
      familyName: json["familyName"],
      familyMemberCount: json["familyMemberCount"],
      createTime: DateTime.tryParse(json["createTime"] ?? ""),
    );
  }
}
