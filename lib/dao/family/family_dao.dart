import 'package:flutter_baby_time/getx/controller/manager_gex_controller.dart';

import '../../model/baby/BabyInfoRespVO.dart';
import '../../model/family/FamilyApplyRespVO.dart';
import '../../model/family/FamilyRelationRespVO.dart';
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

  static Future<bool?> updateApplyStatus(int id, applyStatus) async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.PUT,
      path: "/api/familyApply/updateApplyStatus",
      needLogin: true,
      needToken: true,
    ).add("id", id).add("applyStatus", applyStatus));
    return data;
  }

  static Future<List<FamilyRelationRespVo>?> familyManager() async {
    var request = AnonymousRequest(
      method: HttpMethod.GET,
      path: "/api/baby/family/familyManager",
      needLogin: true,
      needToken: true,
    ).add("familyId", familyLogic.get()!.id!);
    var data = await HiNet.getInstance().fire(request);
    var list = toObjList(data, FamilyRelationRespVo.fromJson);
    return list;
  }

  static Future<bool?> removeFamilyMember(int memberId) async {
    var request = AnonymousRequest(
      method: HttpMethod.GET,
      path: "/api/baby/family/removeFamilyMember",
      needLogin: true,
      needToken: true,
    ).add("familyId", familyLogic.get()!.id!).add("memberId", memberId);
    var data = await HiNet.getInstance().fire(request);
    return null != data && data;
  }

  static Future<bool?> setFamilyMemberRole(int memberId, int roleId) async {
    var request = AnonymousRequest(
      method: HttpMethod.GET,
      path: "/api/baby/family/setFamilyMemberRole",
      needLogin: true,
      needToken: true,
    )
        .add("familyId", familyLogic.get()!.id!)
        .add("memberId", memberId)
        .add("roleId", roleId);
    var data = await HiNet.getInstance().fire(request);
    return null != data && data;
  }
}
