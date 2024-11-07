import 'package:flutter_baby_time/app/modules/home_page_module/home_page_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class BottomBarPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
  }
}
