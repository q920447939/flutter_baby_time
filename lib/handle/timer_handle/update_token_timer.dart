import 'dart:async';


import '../../main.dart';
import '../../utils/member_helper.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

Timer? _timer;
void updateToken() {
  if (null != _timer) {
    _timer?.cancel();
    return;
  }
  if (isLogin()) {
    _timer = Timer.periodic(Duration(seconds: 60 * 5), (timer) {

    });
  }
}

bool checkTokenIsExpire() {
  var token = SP.getString('token');
  if (null == token || token == "") {
    return true;
  }
  try {
    final jwt = JWT.decode(token);
    var expireTime = jwt.payload['aud'][2];
    //判断是否超过 当前时间 ，expireTime 是 yyyy-mm-dd hh:mm:ss 类型
    if (expireTime is String) {
      var date = DateTime.parse(expireTime);
      //在当前时间之前 或者等于当前时间，说明已过期
      if (date.isBefore(DateTime.now()) ||
          date.isAtSameMomentAs(DateTime.now())) {
        return true;
      }

      return false;
    }
    return true;
  } on JWTExpiredException {
    print('jwt expired');
    return true;
  } on JWTException catch (ex) {
    print(ex.message); // ex: invalid signature
    return true;
  }
}
