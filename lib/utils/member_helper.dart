import '../main.dart';

bool isLogin() {
  var isLogin = SP.getBool('isLogin');
  return null != isLogin && isLogin == true;
}
