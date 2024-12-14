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
    await saveToken(data['token']);
    return true;
  }
}
