import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';
import '../services/auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    // 获取本地存储的token
    final authService = Get.find<AuthService>();

    // 如果未登录且不是登录页面，重定向到登录页
    if (!authService.isAuthenticated && route != Routes.LOGIN) {
      return const RouteSettings(name: Routes.LOGIN);
    }
    return null;
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    return page;
  }
}
