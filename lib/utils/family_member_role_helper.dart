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

RoleEnums memberRoleEnums = RoleEnums.general;

void setRole(FamilyRespVo familyResp) {
  if (familyResp.roleId == RoleEnums.admin.id) {
    memberRoleEnums = RoleEnums.admin;
  }
}

bool familyMemberRoleHasAdmin() {
  return memberRoleEnums == RoleEnums.admin;
}

void clean() {
  memberRoleEnums = RoleEnums.general;
}
