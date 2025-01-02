import '../../../utils/member_helper.dart';
import '../../http/core/hi_net.dart';
import '../../http/request/base_request.dart';
import '../member/member_dao.dart';

class AuthDao {
  static Future<bool> login(params) async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.POST,
      path: "/api/authentication/login",
      needLogin: true,
      needToken: true,
    ).setBody(params));
    if (null == data) {
      return false;
    }
    await saveToken(data['token']);
    await MemberDao.get();
    return true;
  }

  static Future<bool> register(params) async {
    var data = await HiNet.getInstance().fire(AnonymousRequest(
      method: HttpMethod.POST,
      path: "/api/authentication/register",
      needLogin: true,
      needToken: true,
    ).setBody(params));
    if (null == data) {
      return false;
    }
    return true;
  }
}
