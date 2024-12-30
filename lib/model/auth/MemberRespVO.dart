class MemberRespVo {
  MemberRespVo({
    required this.id,
    required this.registerChannel,
    required this.memberCode,
    required this.memberNickName,
    required this.memberSimpleId,
    required this.inviteMemberSimpleId,
    required this.avatar,
    required this.createTime,
  });

  final int? id;
  final int? registerChannel;
  final String? memberCode;
  final String? memberNickName;
  final int? memberSimpleId;
  final int? inviteMemberSimpleId;
  final String? avatar;
  final DateTime? createTime;

  factory MemberRespVo.fromJson(Map<String, dynamic> json) {
    return MemberRespVo(
      id: json["id"],
      registerChannel: json["registerChannel"],
      memberCode: json["memberCode"],
      memberNickName: json["memberNickName"],
      memberSimpleId: json["memberSimpleId"],
      inviteMemberSimpleId: json["inviteMemberSimpleId"],
      avatar: json["avatar"],
      createTime: DateTime.tryParse(json["createTime"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "registerChannel": registerChannel,
        "memberCode": memberCode,
        "memberNickName": memberNickName,
        "memberSimpleId": memberSimpleId,
        "inviteMemberSimpleId": inviteMemberSimpleId,
        "avatar": avatar,
        "createTime": createTime?.toIso8601String(),
      };
}
