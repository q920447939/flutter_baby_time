import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jiffy/jiffy.dart';

import '../../getx/controller/manager_gex_controller.dart';
import '../../model/baby/BabyInfoRespVO.dart';
import '../../model/uploadList/UploadListRespVO.dart';
import '../../page/my/baby_setting/baby_setting_controller.dart';
import '../../page/my/baby_setting/sex_enums.dart';
import '../http/core/hi_net.dart';
import '../http/request/base_request.dart';

class BabyDao {
  static Future<BabyInfoRespVo?> get() async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.GET,
      path: "/api/baby/info/get",
      needLogin: true,
      needToken: true,
    ).add("id", babyController.babyId.value));
    if (null == data) {
      return null;
    }
    var babyInfoRespVo = BabyInfoRespVo.fromJson(data);
    babyController.babyNameAvatar.value = babyInfoRespVo.avatarUrl!;
    babyController.babyName.value = babyInfoRespVo.name!;
    babyController.birthday.value =
        Jiffy.parseFromDateTime(babyInfoRespVo.birthday!)
            .format(pattern: 'yyyy-MM-dd');
    babyController.sex.value =
        babyInfoRespVo.sex! == 1 ? SexEnums.man : SexEnums.female;
    return babyInfoRespVo;
  }

  static Future<List<UploadListRespVo>?> fetchUploadList(
      int pageNo, int pageSize, bool queryCollect, bool? isCollect) async {
    var baseRequest = AnonymousRequest(
      method: HttpMethod.GET,
      path: "/api/baby/upload-list/page",
      needLogin: true,
      needToken: true,
    )
        .add("pageNo", pageNo)
        .add("pageSize", pageSize)
        .add("babyId", babyController.babyId.value);
    if (queryCollect) {
      baseRequest.add("isCollect", isCollect!);
    }
    var data = await HiNet.getInstance().fire(baseRequest);

    if (null == data) {
      return null;
    }
    var list = data['list'] as List<dynamic>;
    List<UploadListRespVo> resultList =
        list.map((json) => UploadListRespVo.fromJson(json)).toList();
    return resultList;
  }
}
