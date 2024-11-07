import 'package:get/get.dart';

import '../routes/app_pages.dart';

class AuthService extends GetxService {
  final _isAuthenticated = false.obs;
  bool get isAuthenticated => _isAuthenticated.value;

  Future<void> login(String username, String password) async {
    // 实现登录逻辑
    _isAuthenticated.value = true;
  }

  Future<void> logout() async {
    // 实现登出逻辑
    _isAuthenticated.value = false;
    Get.offAllNamed(Routes.LOGIN);
  }
}
