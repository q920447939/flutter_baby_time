import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../main.dart';
import '../../page/heightWeight/controller/height_weight_manager_controller.dart';
import '../../page/home/view_model_controller.dart';
import '../../page/my/baby_setting/baby_setting_controller.dart';
import '../../page/my/global_setting/global_setting_controller.dart';

class GetxInit {
  Future<void> init() async {
    Get.put(BabySettingController());
    Get.put(ViewModeController());
    Get.put(GlobalSettingController());
    Get.put(HeightWeightManagerController());
  }
}
