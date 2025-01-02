import '../../main.dart';
import '../timer_handle/update_token_timer.dart';

void loginSucc(String token) {
  SP.setBool('isLogin', true);
  SP.setString('token', token);

  updateToken();
}

loginOut() async {
  await SP.remove('token');
  await SP.remove('isLogin');
  await SP.remove('babyInfo');
  await SP.remove('family_key');
  await SP.remove('member_key');
}
