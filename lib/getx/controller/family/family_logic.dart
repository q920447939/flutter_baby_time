import 'package:get/get.dart';

import '../../../model/baby/BabyInfoRespVO.dart';

class FamilyLogic extends GetxController {
  final familyRespVo = Rx<FamilyRespVo?>(null);

  void updateRx(newInfo) {
    familyRespVo.value = newInfo;
  }
}
