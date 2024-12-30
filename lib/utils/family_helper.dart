import '../getx/controller/manager_gex_controller.dart';
import '../main.dart';
import '../model/baby/BabyInfoRespVO.dart';

Future<void> bindFamily(FamilyRespVo familyRespVo) async {
  await familyLogic.updateRx(familyRespVo);
}

Future<void> unbindFamily() async {
  await familyLogic.unBind();
}
