import '../../app/modules/home_page_module/home_page_bindings.dart';
import '../../app/modules/home_page_module/home_page_page.dart';
import 'package:get/get.dart';

import '../../page/error_screen.dart';
import '../../page/home/home_page.dart';
import '../../widget/bottom_bar/bottom_bar_navigator.dart';
import '../../widget/bottom_bar/scaffold_with_navbar.dart';
import '../middleware/auth_middleware.dart';
import '../modules/home_page_module/home_page_controller.dart';
part './app_routes.dart';
/**
 * GetX Generator - fb.com/htngu.99
 * */

abstract class AppPages {
  static const INITIAL = Routes.bottomNavigationBar;

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
      name: Routes.bottomNavigationBar,
      page: () => ScaffoldWithNavBar(),
      requiresAuth: false,
    ),
    _createPage(
      name: Routes.HOME_PAGE,
      page: () => HomePage(),
      binding: HomePageBinding(),
      requiresAuth: false,
    ),
    _createPage(
      name: Routes.HOME_PAGE,
      page: () => BottomBarNavigator(),
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
