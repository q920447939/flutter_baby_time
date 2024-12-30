import 'dart:convert';

import 'package:get/get.dart';

import '../../../main.dart';
import '../../../model/baby/BabyInfoRespVO.dart';
import '../../../utils/str_json_translate.dart';

class FamilyLogic extends GetxController {
  final familyRespVo = Rx<FamilyRespVo?>(null);
  static const String _Key = 'family_key';

  @override
  void onInit() {
    super.onInit();
    loadSp();
  }

  Future<void> loadSp() async {
    final spValue = SP.getString(_Key);
    if (null != spValue) {
      familyRespVo.value = jsonStrToObj(spValue, FamilyRespVo.fromJson);
    }
  }

  saveSp() async {
    await SP.setString(_Key, objToJsonStr(familyRespVo.value));
  }

  Future<void> updateRx(newInfo) async {
    familyRespVo.value = newInfo;
    await saveSp();
  }

  Future<void> unBind() async {
    familyRespVo.value = null;
    await SP.remove(_Key);
  }

  FamilyRespVo? get() {
    return familyRespVo.value;
  }
}
