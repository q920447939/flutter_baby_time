import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jiffy/jiffy.dart';

import '../../model/baby/BabyInfoRespVO.dart';
import '../../model/uploadList/UploadListRespVO.dart';
import '../../page/my/baby_setting/baby_setting_controller.dart';
import '../../page/my/baby_setting/sex_enums.dart';
import '../http/core/hi_net.dart';
import '../http/request/base_request.dart';

class BabyDao {
  static final BabySettingController _babyController = Get.find();

  static Future<BabyInfoRespVo?> get(id) async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.GET,
      path: "/api/baby/info/get",
      needLogin: true,
      needToken: true,
    ).add("id", id));
    if (null == data) {
      return null;
    }
    var babyInfoRespVo = BabyInfoRespVo.fromJson(data);
    _babyController.babyNameAvatar.value = babyInfoRespVo.avatarUrl!;
    _babyController.babyName.value = babyInfoRespVo.name!;
    _babyController.birthday.value =
        Jiffy.parseFromDateTime(babyInfoRespVo.birthday!)
            .format(pattern: 'yyyy-MM-dd');
    _babyController.sex.value =
        babyInfoRespVo.sex! == 1 ? SexEnums.man : SexEnums.female;
    return babyInfoRespVo;
  }

  static Future<List<UploadListRespVo>?> fetchUploadList(
      int pageNo, int pageSize, int babyId) async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.GET,
      path: "/api/baby/upload-list/page",
      needLogin: true,
      needToken: true,
    ).add("pageNo", pageNo).add("pageSize", pageSize).add("babyId", babyId));
    if (null == data) {
      return null;
    }
    var list = data['list'] as List<dynamic>;
    List<UploadListRespVo> resultList =
        list.map((json) => UploadListRespVo.fromJson(json)).toList();
    return resultList;
  }
}
