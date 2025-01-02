import '../getx/controller/manager_gex_controller.dart';
import '../main.dart';
import '../model/baby/BabyInfoRespVO.dart';

Future<void> bindBaby(BabyInfoRespVo info) async {
  await babyController.updateRx(info);
}

Future<void> unbindBaby() async {
  await babyController.unBind();
}
