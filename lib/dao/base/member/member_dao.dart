import '../../../getx/controller/manager_gex_controller.dart';
import '../../../model/auth/MemberRespVO.dart';
import '../../http/core/hi_net.dart';
import '../../http/request/base_request.dart';

class MemberDao {
  static Future<MemberRespVo?> get() async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.GET,
      path: "/api/member/get",
      needLogin: true,
      needToken: true,
    ));
    if (null == data) {
      return null;
    }
    var memberRespVo = MemberRespVo.fromJson(data);
    memberLogic.updateMemberInfo(memberRespVo);
    return memberRespVo;
  }

  static Future<bool> updateNickName(String nickName) async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.GET,
      path: "/api/member/updateNickName",
      needLogin: true,
      needToken: true,
    ).add("nickName", nickName));
    if (null == data) {
      return false;
    }
    await get();
    return true;
  }
}
