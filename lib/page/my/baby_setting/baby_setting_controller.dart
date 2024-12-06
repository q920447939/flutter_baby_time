import 'package:flutter_baby_time/page/my/baby_setting/sex_enums.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../main.dart';

class BabySettingController extends GetxController {
  static const String _birthdayKey = 'birthday';
  static const String _sexKey = 'sex';
  static const String _babyNameKey = 'babyName';
  static const String _babyNameAvatarKey = 'babyNameAvatar';
  static const _babyIdKey = 'babyId';

  var babyName = "请设置宝宝名称".obs;
  var birthday = "未设置".obs;
  var sex = SexEnums.female.obs;
  var babyNameAvatar = 'assets/img/baby_avator.jpeg'.obs;

  var babyId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadSp();
  }

  Future<void> loadSp() async {
    final birthdaySp = SP.getString(_birthdayKey);
    if (null != birthdaySp) {
      birthday.value = birthdaySp;
    }

    final sexSp = SP.getString(_sexKey);
    if (null != sexSp) {
      sex.value = SexEnums.fromString(sexSp);
    }

    final babyNameSp = SP.getString(_babyNameKey);
    if (null != babyNameSp) {
      babyName.value = babyNameSp;
    }
    final babyNameAvatarSp = SP.getString(_babyNameAvatarKey);
    if (null != babyNameAvatarSp) {
      babyNameAvatar.value = babyNameAvatarSp;
    }
    final babyIdSp = SP.getInt(_babyIdKey);
    if (null != babyIdSp) {
      babyId.value = babyIdSp;
    }
  }

  void changeBirthday(String newValue) {
    birthday.value = newValue;
    saveSp(_birthdayKey, newValue);
  }

  void changeSex(String newValue) {
    sex.value = SexEnums.fromString(newValue);
    saveSp(_sexKey, newValue);
  }

  void changeBabyName(String newValue) {
    babyName.value = newValue;
    saveSp(_babyNameKey, newValue);
  }

  void changeBabyAvatar(String newValue) {
    babyNameAvatar.value = newValue;
    saveSp(_babyNameAvatarKey, newValue);
  }

  void changeBabyId(int newValue) {
    babyId.value = newValue;
    saveSpInt(_babyIdKey, newValue);
  }

  Future<void> saveSp(String key, String value) async {
    await SP.setString(key, value);
  }

  Future<void> saveSpInt(String key, int value) async {
    await SP.setInt(key, value);
  }
}
