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
}
