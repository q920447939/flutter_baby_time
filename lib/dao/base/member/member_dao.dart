import '../../../getx/controller/manager_gex_controller.dart';
import '../../../model/auth/MemberRespVO.dart';
import '../../../utils/member_helper.dart';
import '../../http/core/hi_net.dart';
import '../../http/request/base_request.dart';

class MemberDao {
  static Future<bool> get() async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.GET,
      path: "/api/member/get",
      needLogin: true,
      needToken: true,
    ));
    if (null == data) {
      return false;
    }
    memberLogic.updateMemberInfo(MemberRespVo.fromJson(data));
    return true;
  }
}
