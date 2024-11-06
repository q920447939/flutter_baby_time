import 'dart:convert';
import 'dart:developer';

import '../../../config/server_config.dart';


enum HttpMethod { GET, POST, PUT, DELETE }

abstract class BaseRequest {
  var pathParams;
  var useHttps = true;

  var body;

  BaseRequest() {
    addHead("tenant-id", ServerConfig().tenantId);
    addHead("v", ServerConfig().version);
  }

  String authority() {
    return "${ServerConfig().host}:${ServerConfig().port}";
  }

  HttpMethod method();

  String path();

  String basePath() {
    return "musk";
  }

  // Method to set body and convert to JSON if needed
  BaseRequest setBody(dynamic body) {
    this.body = jsonEncode(body);
    addHead("Content-Type", "application/json");
    return this;
  }

  String url() {
    Uri uri;
    var pathStr = basePath() + path();
    if (null != pathParams) {
      if (pathStr.endsWith("/")) {
        pathStr = "$pathStr$pathParams";
      } else {
        pathStr = "$pathStr/$pathParams";
      }
    }
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    log(uri.toString());
    return uri.toString();
  }

  bool needLogin();

  bool needToken() {
    return false;
  }

  Map<String, String> params = Map();

  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> head = Map();

  BaseRequest addHead(String k, Object v) {
    head[k] = v.toString();
    return this;
  }
}

class AnonymousRequest implements BaseRequest {
  final HttpMethod _method;
  final String _path;
  final bool _needLogin;
  final String Function()? _customBasePath;
  final bool _needToken;

  var pathParams;
  var useHttps = false;
  var body;
  Map<String, String> params = {};
  Map<String, dynamic> head = {};

  AnonymousRequest({
    required HttpMethod method,
    required String path,
    required bool needLogin,
    String Function()? customBasePath,
    bool? needToken,
  })  : _method = method,
        _path = path,
        _needLogin = needLogin,
        _customBasePath = customBasePath,
        _needToken = needToken ?? false {
    addHead("tenant-id", ServerConfig().tenantId);
    addHead("v", ServerConfig().version);
  }

  @override
  String authority() {
    return "${ServerConfig().host}:${ServerConfig().port}";
  }

  @override
  HttpMethod method() => _method;

  @override
  String path() => _path;

  @override
  String basePath() {
    return _customBasePath?.call() ?? "musk";
  }

  @override
  BaseRequest setBody(dynamic body, {bool serialize = true}) {
    if (serialize) {
      addHead("Content-Type", "application/json");
      this.body = jsonEncode(body);
    } else {
      this.body = body;
    }
    return this;
  }

  @override
  String url() {
    Uri uri;
    var pathStr = basePath() + path();
    if (pathParams != null) {
      if (pathStr.endsWith("/")) {
        pathStr = "$pathStr$pathParams";
      } else {
        pathStr = "$pathStr/$pathParams";
      }
    }
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    log(uri.toString());
    return uri.toString();
  }

  @override
  bool needLogin() => _needLogin;

  @override
  bool needToken() => _needToken;

  @override
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  @override
  BaseRequest addHead(String k, Object v) {
    head[k] = v.toString();
    return this;
  }
}
