class UploadListRespVo {
  UploadListRespVo({
    required this.id,
    required this.babyId,
    required this.uploadType,
    required this.uploadUser,
    required this.uploadTime,
    required this.remark,
    required this.createTime,
    required this.memberSimpleResVo,
    required this.uploadDiscussRespVo,
    required this.uploadImageRespVo,
  });

  final int? id;
  final int? babyId;
  final int? uploadType;
  final int? uploadUser;
  final DateTime? uploadTime;
  final String? remark;
  final DateTime? createTime;
  final MemberSimpleResVo? memberSimpleResVo;
  final List<UploadDiscussRespVo> uploadDiscussRespVo;
  final List<UploadImageRespVo> uploadImageRespVo;

  factory UploadListRespVo.fromJson(Map<String, dynamic> json) {
    return UploadListRespVo(
      id: json["id"],
      babyId: json["babyId"],
      uploadType: json["uploadType"],
      uploadUser: json["uploadUser"],
      uploadTime: DateTime.tryParse(json["uploadTime"] ?? ""),
      remark: json["remark"],
      createTime: DateTime.tryParse(json["createTime"] ?? ""),
      memberSimpleResVo: json["memberSimpleResVO"] == null
          ? null
          : MemberSimpleResVo.fromJson(json["memberSimpleResVO"]),
      uploadDiscussRespVo: json["uploadDiscussRespVO"] == null
          ? []
          : List<UploadDiscussRespVo>.from(json["uploadDiscussRespVO"]!
              .map((x) => UploadDiscussRespVo.fromJson(x))),
      uploadImageRespVo: json["uploadImageRespVO"] == null
          ? []
          : List<UploadImageRespVo>.from(json["uploadImageRespVO"]!
              .map((x) => UploadImageRespVo.fromJson(x))),
    );
  }
}

class MemberSimpleResVo {
  MemberSimpleResVo({
    required this.memberCode,
    required this.memberNickName,
    required this.avatar,
  });

  final String? memberCode;
  final String? memberNickName;
  final String? avatar;

  factory MemberSimpleResVo.fromJson(Map<String, dynamic> json) {
    return MemberSimpleResVo(
      memberCode: json["memberCode"],
      memberNickName: json["memberNickName"],
      avatar: json["avatar"],
    );
  }
}

class UploadDiscussRespVo {
  UploadDiscussRespVo({
    required this.id,
    required this.babyId,
    required this.discussMemberId,
    required this.uploadId,
    required this.content,
    required this.createTime,
    required this.memberSimpleResVo,
  });

  final int? id;
  final int? babyId;
  final int? discussMemberId;
  final int? uploadId;
  final String? content;
  final DateTime? createTime;
  final MemberSimpleResVo? memberSimpleResVo;

  factory UploadDiscussRespVo.fromJson(Map<String, dynamic> json) {
    return UploadDiscussRespVo(
      id: json["id"],
      babyId: json["babyId"],
      discussMemberId: json["discussMemberId"],
      uploadId: json["uploadId"],
      content: json["content"],
      createTime: DateTime.tryParse(json["createTime"] ?? ""),
      memberSimpleResVo: json["memberSimpleResVO"] == null
          ? null
          : MemberSimpleResVo.fromJson(json["memberSimpleResVO"]),
    );
  }
}

class UploadImageRespVo {
  UploadImageRespVo({
    required this.id,
    required this.babyId,
    required this.uploadId,
    required this.imageUrl,
    required this.createTime,
  });

  final int? id;
  final int? babyId;
  final int? uploadId;
  final String? imageUrl;
  final DateTime? createTime;

  factory UploadImageRespVo.fromJson(Map<String, dynamic> json) {
    return UploadImageRespVo(
      id: json["id"],
      babyId: json["babyId"],
      uploadId: json["uploadId"],
      imageUrl: json["imageUrl"],
      createTime: DateTime.tryParse(json["createTime"] ?? ""),
    );
  }
}
