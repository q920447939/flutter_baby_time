import '../../getx/controller/manager_gex_controller.dart';
import '../../model/baby/BabyUploadListRelationTagRespVO.dart';
import '../../model/baby/BabyUploadTagRespVO.dart';
import '../http/core/hi_net.dart';
import '../http/request/base_request.dart';

class UploadListDao {
  static Future<bool> uploadList(params) async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.POST,
      path: "/api/baby/upload-list/create",
      needLogin: true,
      needToken: true,
    ).setBody(params));
    if (null == data) {
      return false;
    }
    return true;
  }

  static Future<bool> discuss(params) async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.POST,
      path: "/api/baby/upload-discuss/create",
      needLogin: true,
      needToken: true,
    ).setBody(params));
    if (null == data) {
      return false;
    }
    return true;
  }

  static Future<List<BabyUploadTagRespVo>?> getBabyUploadTagAll() async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.GET,
      path: "/api/babyUploadTag/getBabyUploadTagAll",
      needLogin: true,
      needToken: true,
    ).add("babyId", babyController.babyId.value));
    if (null == data) {
      return null;
    }
    var list = data as List<dynamic>;
    List<BabyUploadTagRespVo> resultList =
        list.map((json) => BabyUploadTagRespVo.fromJson(json)).toList();
    return resultList;
  }

  static Future<bool> addTag(params) async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.POST,
      path: "/api/babyUploadTag/create",
      needLogin: true,
      needToken: true,
    ).setBody(params));
    if (null == data) {
      return false;
    }
    return true;
  }

  static Future<bool> removeTag(id) async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.DELETE,
      path: "/api/babyUploadTag/deleteById",
      needLogin: true,
      needToken: true,
    ).add("id", id));
    if (null == data) {
      return false;
    }
    return true;
  }
}
