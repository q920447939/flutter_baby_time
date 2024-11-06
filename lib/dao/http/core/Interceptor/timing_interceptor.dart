import 'package:dio/dio.dart';

class TimingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['startTime'] = DateTime.now().millisecondsSinceEpoch;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final int startTime = response.requestOptions.extra['startTime'];
    final int endTime = DateTime.now().millisecondsSinceEpoch;
    final int duration = endTime - startTime;

    print('Request to ${response.requestOptions.uri} took $duration ms');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final int startTime = err.requestOptions.extra['startTime'];
    final int endTime = DateTime.now().millisecondsSinceEpoch;
    final int duration = endTime - startTime;

    print('Request to ${err.requestOptions.uri} failed after $duration ms');
    super.onError(err, handler);
  }
}
