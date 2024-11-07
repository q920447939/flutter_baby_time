import 'package:flutter_baby_time/app/modules/my_profile_module/my_profile_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class MyProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyProfileController());
  }
}