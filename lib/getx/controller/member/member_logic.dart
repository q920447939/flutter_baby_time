import 'dart:convert';

import 'package:get/get.dart';

import '../../../main.dart';
import '../../../model/auth/MemberRespVO.dart';
import '../../../utils/str_json_translate.dart';

class MemberLogic extends GetxController {
  //未登录可能为空
  final memberInfo = Rxn<MemberRespVo>();
  static const String _Key = 'member_key';

  @override
  void onInit() {
    super.onInit();
    loadSp();
  }

  Future<void> loadSp() async {
    final spValue = SP.getString(_Key);
    if (null != spValue) {
      memberInfo.value = jsonStrToObj(spValue, MemberRespVo.fromJson);
    }
  }

  Future<void> updateMemberInfo(MemberRespVo newInfo) async {
    memberInfo.value = newInfo;
    await saveSp();
  }

  saveSp() async {
    await SP.setString(_Key, objToJsonStr(memberInfo.value));
  }

  MemberRespVo? get() {
    return memberInfo.value;
  }
}
