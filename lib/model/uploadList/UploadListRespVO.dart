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
  final List<UploadRespVo> uploadDiscussRespVo;
  final List<UploadRespVo> uploadImageRespVo;

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
          : List<UploadRespVo>.from(json["uploadDiscussRespVO"]!
              .map((x) => UploadRespVo.fromJson(x))),
      uploadImageRespVo: json["uploadImageRespVO"] == null
          ? []
          : List<UploadRespVo>.from(
              json["uploadImageRespVO"]!.map((x) => UploadRespVo.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "babyId": babyId,
        "uploadType": uploadType,
        "uploadUser": uploadUser,
        "uploadTime": uploadTime?.toIso8601String(),
        "remark": remark,
        "createTime": createTime?.toIso8601String(),
        "memberSimpleResVO": memberSimpleResVo?.toJson(),
        "uploadDiscussRespVO":
            uploadDiscussRespVo.map((x) => x?.toJson()).toList(),
        "uploadImageRespVO": uploadImageRespVo.map((x) => x?.toJson()).toList(),
      };
}

class MemberSimpleResVo {
  MemberSimpleResVo({
    required this.memberCode,
    required this.memberNickName,
    required this.avatar,
    required this.comment,
  });

  final String? memberCode;
  final String? memberNickName;
  final String? avatar;
  final Comment? comment;

  factory MemberSimpleResVo.fromJson(Map<String, dynamic> json) {
    return MemberSimpleResVo(
      memberCode: json["memberCode"],
      memberNickName: json["memberNickName"],
      avatar: json["avatar"],
      comment:
          json["@comment"] == null ? null : Comment.fromJson(json["@comment"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "memberCode": memberCode,
        "memberNickName": memberNickName,
        "avatar": avatar,
        "@comment": comment?.toJson(),
      };
}

class Comment {
  Comment({
    required this.avatar,
  });

  final String? avatar;

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      avatar: json["avatar"],
    );
  }

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
      };
}

class UploadRespVo {
  UploadRespVo({
    required this.id,
    required this.babyId,
    required this.uploadId,
    required this.content,
    required this.createTime,
    required this.imageUrl,
  });

  final int? id;
  final int? babyId;
  final int? uploadId;
  final String? content;
  final DateTime? createTime;
  final String? imageUrl;

  factory UploadRespVo.fromJson(Map<String, dynamic> json) {
    return UploadRespVo(
      id: json["id"],
      babyId: json["babyId"],
      uploadId: json["uploadId"],
      content: json["content"],
      createTime: DateTime.tryParse(json["createTime"] ?? ""),
      imageUrl: json["imageUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "babyId": babyId,
        "uploadId": uploadId,
        "content": content,
        "createTime": createTime?.toIso8601String(),
        "imageUrl": imageUrl,
      };
}
