

import '../../main.dart';
import '../timer_handle/update_token_timer.dart';

void loginSucc(String token) {
  SP.setBool('isLogin', true);
  SP.setString('token', token);
  updateToken();
}

void loginOut() {
  SP.setBool('isLogin', false);
  SP.setString('token', '');
}
