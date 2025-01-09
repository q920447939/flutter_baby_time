import 'package:flutter_baby_time/main.dart';
import 'package:flutter_baby_time/utils/str_json_translate.dart';

import '../model/baby/BabyInfoRespVO.dart';

enum RoleEnums {
  admin(1, 'ADMIN', '管理员'),
  general(2, 'GENERAL', '普通用户');

  final int id;
  final String code;
  final String label;

  const RoleEnums(
    this.id,
    this.code,
    this.label,
  );

  static RoleEnums fromKey(int key) {
    return RoleEnums.values.firstWhere(
      (e) => e.id == key,
      orElse: () => RoleEnums.general,
    );
  }
}

class FamilyMemberRoleHelper {
  // 添加初始化方法
  static void init() {
    final roleStr = SP.getString("member_role");
    if (roleStr != null && roleStr.isNotEmpty) {
      final familyResp = jsonStrToObj(roleStr, FamilyRespVo.fromJson);
      setRole(familyResp);
    }
  }

  static Future<void> setRole(FamilyRespVo familyResp) async {
    if (familyResp.roleId == RoleEnums.admin.id) {
      await SP.setString("member_role", objToJsonStr(familyResp));
    }
  }

  static bool familyMemberRoleHasAdmin() {
    final roleStr = SP.getString("member_role");
    if (roleStr != null && roleStr.isNotEmpty) {
      final familyResp = jsonStrToObj(roleStr, FamilyRespVo.fromJson);
      return familyResp.roleId == RoleEnums.admin.id;
    }
    return false;
  }

  static bool familyMemberRoleHasAdminByRoleId(int roleId) {
    return roleId == RoleEnums.admin.id;
  }

  static Future<void> clean() async {
    await SP.remove("member_role");
  }
}
