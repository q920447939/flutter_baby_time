import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../config/dio_config.dart';
import '../../../config/server_config.dart';
import '../request/base_request.dart';
import 'hi_error.dart';
import 'hi_net_response.dart';

class DioHiNetAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var options = Options(headers: request.head);
    /*dio.interceptors.add(PrettyDioLogger());
// customization
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));*/
    /*var httpProxy = dotenv.env['http_proxy'];
    if (null != httpProxy && "" != httpProxy.toString()) {
      dio.useProxy(httpProxy.toString());
    }*/
    //print("url is ${request.url()}");
    try {
      if (request.method() == HttpMethod.GET) {
        return await getDioInstance()
            .get(request.url(), options: options)
            .then((result) {
          // result = jsonDecode(result);
          /* print(
              "result statusCode is ${result.statusCode} , msg is ${result.statusMessage} , data is ${result.data}");*/
          if (ServerConfig().isDebug) {
            if (kDebugMode) {
              //print("result is ${result.data}");
            }
          }
          return HiNetResponse(
              data: result.data,
              baseRequest: request,
              statusCode: result.statusCode,
              statusMessage: result.statusMessage);
        });
      } else {
        return await getDioInstance()
            .post(request.url(), options: options, data: request.body)
            .then((result) {
          return HiNetResponse(
              data: result.data,
              baseRequest: request,
              statusCode: result.statusCode,
              statusMessage: result.statusMessage);
        });
      }
    } on DioError catch (e) {
      throw HiNetError(code: e.response?.statusCode ?? -1, msg: e.toString());
    }
  }

  _buildData(Response response, BaseRequest request) {
    return HiNetResponse(
        data: response.data ?? "",
        baseRequest: request,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        extra: response.extra);
  }
}
