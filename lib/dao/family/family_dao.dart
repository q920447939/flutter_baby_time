import '../../model/baby/BabyInfoRespVO.dart';
import '../../utils/response/response_utils.dart';
import '../http/core/hi_net.dart';
import '../http/request/base_request.dart';

class FamilyDao {
  static Future<List<FamilyRespVo>?> get() async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.GET,
      path: "/api/baby/family/get",
      needLogin: true,
      needToken: true,
    ));
    return toObjList(data, FamilyRespVo.fromJson);
  }

  static Future<int?> create(params) async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.POST,
      path: "/api/baby/family/create",
      needLogin: true,
      needToken: true,
    ).setBody(params));
    return data;
  }
}
