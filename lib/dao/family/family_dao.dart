import '../../model/baby/BabyInfoRespVO.dart';
import '../../model/family/FamilyApplyRespVO.dart';
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

  static Future<int?> apply(params) async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.POST,
      path: "/api/familyApply/create",
      needLogin: true,
      needToken: true,
    ).setBody(params));
    return data;
  }

  static Future<List<FamilyApplyRespVo>?> applyPage(int pageNo, int pageSize,
      {String? applyFamilyCode}) async {
    var request = AnonymousRequest(
      method: HttpMethod.GET,
      path: "/api/familyApply/page",
      needLogin: true,
      needToken: true,
    ).add("pageNo", pageNo).add("pageSize", pageSize);
    if (null != applyFamilyCode) {
      request.add("applyFamilyCode", applyFamilyCode);
    }
    var data = await HiNet.getInstance().fire(request);
    var list = pageResToObjList(data, FamilyApplyRespVo.fromJson);
    return list;
  }
}
