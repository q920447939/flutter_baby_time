import 'base_request.dart';

class RegisterRequest extends BaseRequest {
  var useHttps = false;

  @override
  HttpMethod method() {
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "/api/authentication/register";
  }
}
