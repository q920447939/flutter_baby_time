import 'package:flutter_baby_time/page/my/baby_setting/sex_enums.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../main.dart';
import '../../../model/baby/BabyInfoRespVO.dart';
import '../../../utils/str_json_translate.dart';

class BabySettingController extends GetxController {
  final info = Rx<BabyInfoRespVo?>(null);
  static const String _Key = 'babyInfo';

  @override
  void onInit() {
    super.onInit();
    loadSp();
  }

  Future<void> loadSp() async {
    final spValue = SP.getString(_Key);
    if (null != spValue) {
      info.value = jsonStrToObj(spValue, BabyInfoRespVo.fromJson);
    }
  }

  saveSp() async {
    await SP.setString(_Key, objToJsonStr(info.value));
  }

  Future<void> updateRx(newInfo) async {
    info.value = newInfo;
    await saveSp();
  }

  Future<void> unBind() async {
    info.value = null;
    await SP.remove(_Key);
  }

  BabyInfoRespVo? get() {
    return info.value;
  }
}
