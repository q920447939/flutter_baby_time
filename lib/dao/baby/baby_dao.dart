import 'package:jiffy/jiffy.dart';

import '../../getx/controller/manager_gex_controller.dart';
import '../../model/baby/BabyInfoRespVO.dart';
import '../../model/uploadList/UploadListRespVO.dart';
import '../../page/my/baby_setting/sex_enums.dart';
import '../../utils/response/response_utils.dart';
import '../http/core/hi_net.dart';
import '../http/request/base_request.dart';

class BabyDao {
  static Future<BabyInfoRespVo?> get() async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.GET,
      path: "/api/baby/info/get",
      needLogin: true,
      needToken: true,
    ).add("id", babyController.get()!.id!));
    if (null == data) {
      return null;
    }
    var babyInfoRespVo = BabyInfoRespVo.fromJson(data);
    babyController.updateRx(babyInfoRespVo);
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
        .add("babyId", babyController.get()!.id!);
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

  static Future<int?> create(params) async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.POST,
      path: "/api/baby/info/create",
      needLogin: true,
      needToken: true,
    ).setBody(params));
    return data;
  }

  static Future<bool?> updateInfo(params) async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.PUT,
      path: "/api/baby/info/update",
      needLogin: true,
      needToken: true,
    ).setBody(params));
    return data;
  }

  static Future<List<BabyInfoRespVo>?> fetchAllBaby() async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.GET,
      path: "/api/baby/info/fetchAllBaby",
      needLogin: true,
      needToken: true,
    ).add("familyId", familyLogic.get()!.id!));
    return toObjList(data, BabyInfoRespVo.fromJson);
  }
}
