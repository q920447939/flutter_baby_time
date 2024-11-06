import '../request/base_request.dart';
import 'hi_net_response.dart';

class MockHiNetAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    return Future.delayed(Duration(milliseconds: 200), () {
      return HiNetResponse(
          data: "Mock",
          baseRequest: request,
          statusCode: 401,
          statusMessage: "请求成功");
    });
  }
}
