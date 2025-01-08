import 'package:flutter_baby_time/utils/baby_helper.dart';

import '../../getx/controller/manager_gex_controller.dart';
import '../../getx/controller/member/member_logic.dart';
import '../../main.dart';
import '../../utils/family_helper.dart';
import '../../utils/family_member_role_helper.dart';
import '../timer_handle/update_token_timer.dart';

void loginSucc(String token) {
  SP.setBool('isLogin', true);
  SP.setString('token', token);

  updateToken();
}

loginOut() async {
  await unbindBaby();
  await unbindFamily();
  await memberLogic.clean();
  await FamilyMemberRoleHelper.clean();
}
