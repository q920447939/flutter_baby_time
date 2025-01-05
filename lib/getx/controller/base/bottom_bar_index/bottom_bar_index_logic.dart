import 'package:get/get.dart';

class BottomBarIndexLogic extends GetxController {
  final _currIndex = 0.obs;

  int getCurrIndex() {
    return _currIndex.value;
  }

  void setCurrIndex(newValue) {
    _currIndex.value = newValue;
  }
}
