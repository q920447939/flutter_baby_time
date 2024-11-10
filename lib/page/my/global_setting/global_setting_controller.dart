import 'package:flutter_baby_time/page/my/baby_setting/sex_enums.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../main.dart';

class GlobalSettingController extends GetxController {
  static const String _globalBackgroundImageKey = 'globalBackgroundImage';

  var globalBackgroundImage = "".obs;
  @override
  void onInit() {
    super.onInit();
    loadSp();
  }

  Future<void> loadSp() async {
    final spValue = SP.getString(_globalBackgroundImageKey);
    if (null != spValue) {
      globalBackgroundImage.value = spValue;
    }
  }

  void changeBirthday(String newValue) {
    globalBackgroundImage.value = newValue;
    saveSp(_globalBackgroundImageKey, newValue);
  }

  Future<void> saveSp(String key, String value) async {
    await SP.setString(key, value);
  }
}
