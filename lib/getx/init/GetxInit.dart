import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../main.dart';
import '../../page/home/view_model_controller.dart';
import '../../page/my/baby_setting/baby_setting_controller.dart';

class GetxInit {
  Future<void> init() async {
    BabySettingController _babyController = Get.put(BabySettingController());
    await SP.remove("birthday");
    ViewModeController _viewModeController = Get.put(ViewModeController());
  }
}
