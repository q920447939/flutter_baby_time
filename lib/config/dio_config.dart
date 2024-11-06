import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../dao/http/core/Interceptor/timing_interceptor.dart';
import 'server_config.dart';

Dio _dio = Dio();
void initDioConfig() {
  HttpOverrides.global = MyHttpOverrides();
  if (ServerConfig().isDebug) {
    //_dio.interceptors.add(PrettyDioLogger());
    _dio.interceptors.add(TimingInterceptor());
    _dio.interceptors.add(
      PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: false,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90),
    );
  }
}

Dio getDioInstance() {
  return _dio;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
