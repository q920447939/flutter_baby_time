class HiNetError implements Exception {
  final int code;
  final String msg;
  final dynamic data;

  HiNetError({required this.code, required this.msg, this.data});
}

class NoLoginError extends HiNetError {
  NoLoginError({int code = 401, String msg = "未登录", dynamic data})
      : super(code: code, msg: msg);
}

class NeedAuthError extends HiNetError {
  NeedAuthError({int code = 403, String msg = "", dynamic data})
      : super(code: code, msg: msg);
}
