import '../main.dart';

bool isLogin() {
  var isLogin = SP.getBool('isLogin');
  return null != isLogin && isLogin == true;
}

saveToken(token) async {
  await SP.setString('token', token);
  await SP.setBool('isLogin', true);
}

//TODO
bool _isFirstUse = false;
isFirstUse() {
  return _isFirstUse;
}

updateFirstUse() {
  _isFirstUse = false;
}
