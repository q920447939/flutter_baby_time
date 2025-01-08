import 'package:flutter_baby_time/main.dart';
import 'package:flutter_baby_time/utils/str_json_translate.dart';

import '../model/baby/BabyInfoRespVO.dart';

enum RoleEnums {
  admin(
    1,
    'ADMIN',
  ),
  general(
    2,
    'GENERAL',
  );

  final int id;
  final String code;

  const RoleEnums(
    this.id,
    this.code,
  );

  static RoleEnums fromKey(int key) {
    return RoleEnums.values.firstWhere(
      (e) => e.id == key,
      orElse: () => RoleEnums.general,
    );
  }
}

class FamilyMemberRoleHelper {
  static RoleEnums memberRoleEnums = RoleEnums.general;

  // 添加初始化方法
  static void init() async {
    final roleStr = SP.getString("member_role");
    if (roleStr != null && roleStr.isNotEmpty) {
      final familyResp = jsonStrToObj(roleStr, FamilyRespVo.fromJson);
      setRole(familyResp);
    }
  }

  static Future<void> setRole(FamilyRespVo familyResp) async {
    if (familyResp.roleId == RoleEnums.admin.id) {
      memberRoleEnums = RoleEnums.admin;
      await SP.setString("member_role", objToJsonStr(familyResp));
    }
  }

  static bool familyMemberRoleHasAdmin() {
    return memberRoleEnums == RoleEnums.admin;
  }

  static Future<void> clean() async {
    memberRoleEnums = RoleEnums.general;
    await SP.remove("member_role");
  }
}
