import '../../app/modules/home_page_module/home_page_bindings.dart';
import '../../app/modules/home_page_module/home_page_page.dart';
import 'package:get/get.dart';

import '../../page/error_screen.dart';
import '../middleware/auth_middleware.dart';
import '../modules/home_page_module/home_page_controller.dart';
part './app_routes.dart';
/**
 * GetX Generator - fb.com/htngu.99
 * */

abstract class AppPages {
  static const INITIAL = Routes.HOME_PAGE;

  // 创建路由页面的辅助方法
  static GetPage _createPage({
    required String name,
    required GetPageBuilder page,
    Bindings? binding,
    bool requiresAuth = false,
  }) {
    return GetPage(
      name: name,
      page: page,
      binding: binding,
      middlewares: requiresAuth ? [AuthMiddleware()] : null,
    );
  }
  static final pages = [
    _createPage(
      name: Routes.HOME_PAGE,
      page: () =>  HomePagePage(),
      binding: HomePageBinding(),
      requiresAuth: false,
    ),
  ];

  static final unknownRoute = GetPage(
    name: Routes.NOT_FOUND,
    page: () => ErrorScreenPage(
      error: throw Exception('未找到该页面'),
    ),
  );
}
