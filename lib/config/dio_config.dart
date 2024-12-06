import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../dao/http/core/Interceptor/timing_interceptor.dart';
import 'server_config.dart';
import 'package:dio/io.dart';

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
    if (!kIsWeb) {
      //非web平台才能用代理
      initAdapter();
    }
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

void initAdapter() {
  _dio.httpClientAdapter = IOHttpClientAdapter()
    ..onHttpClientCreate = (client) {
      // Config the client.
      client.findProxy = (uri) {
        // Forward all request to proxy "localhost:8888".
        return 'PROXY ${ServerConfig().debugProxy}';
      };
      // You can also create a new HttpClient for Dio instead of returning,
      // but a client must being returned here.
      return client;
    };
}
