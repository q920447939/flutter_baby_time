import 'base_request.dart';

class HomeRequest extends BaseRequest {
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
    return "/api/home/info";
  }
}
