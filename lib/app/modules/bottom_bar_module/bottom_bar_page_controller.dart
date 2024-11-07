import 'package:get/get.dart';

import '../../../page/home/home_page.dart';
import '../../../page/my/my_page.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class BottomBarPageController extends GetxController {
  var _curPage = MyPage().obs;

  get curPage => _curPage.value;

  set curPage(val) {
    _curPage.value = val;
    update();
  }
}
