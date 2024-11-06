import 'base_request.dart';

class HomeNotifyRequest extends BaseRequest {
  var useHttps = false;

  @override
  HttpMethod method() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "/blk_b/notify/homeNotify";
  }
}
