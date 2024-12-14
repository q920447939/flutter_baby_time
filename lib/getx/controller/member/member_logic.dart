import 'package:get/get.dart';

import '../../../model/auth/MemberRespVO.dart';

class MemberLogic extends GetxController {
  //未登录可能为空
  final memberInfo = Rxn<MemberRespVo>();

  void updateMemberInfo(MemberRespVo newInfo) {
    memberInfo.value = newInfo;
  }
}
