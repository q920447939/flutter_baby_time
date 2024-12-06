import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../model/height_record/BabyHeightRecordRespVO.dart';
import '../../model/height_record/BabyHeightRecordStandardRelationRespVO.dart';
import '../../page/my/baby_setting/baby_setting_controller.dart';
import '../../utils/datime_helper.dart';
import '../http/core/hi_net.dart';
import '../http/request/base_request.dart';

class HeightRecordDao {
  static Future<List<BabyHeightRecordRespVo>?> getAllRecord() async {
    BabySettingController babyController = Get.find();

    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.GET,
      path: "/api/babyHeightRecord/getAllRecord",
      needLogin: true,
      needToken: true,
    ).add("babyId", babyController.babyId.value));
    if (null == data) {
      return null;
    }
    var list = data as List<dynamic>;
    List<BabyHeightRecordRespVo> resultList =
        list.map((json) => BabyHeightRecordRespVo.fromJson(json)).toList();
    return resultList;
  }

  static Future create(DateTime recordTime, double height) async {
    BabySettingController babyController = Get.find();

    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.POST,
      path: "/api/babyHeightRecord/create",
      needLogin: true,
      needToken: true,
    ).setBody({
      'babyId': babyController.babyId.value,
      'recordTime': formatDate(recordTime),
      'height': height,
    }));
  }

  static Future<List<BabyHeightRecordStandardRelationRespVo>?>
      getBabyHeightRecordStandardByCountryCode() async {
    BabySettingController babyController = Get.find();

    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.GET,
      path:
          "/api/babyHeightRecordStandard/getBabyHeightRecordStandardCountryCode",
      needLogin: true,
      needToken: true,
    ).add("babyId", babyController.babyId.value).add("countryCode", 'CN_ZH'));
    if (null == data) {
      return null;
    }
    var list = data as List<dynamic>;
    List<BabyHeightRecordStandardRelationRespVo> resultList = list
        .map((json) => BabyHeightRecordStandardRelationRespVo.fromJson(json))
        .toList();
    return resultList;
  }
}
