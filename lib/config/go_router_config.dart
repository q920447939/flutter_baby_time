// Create a GoRouter with all your app routes
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../getx/controller/manager_gex_controller.dart';
import '../main.dart';
import '../router/error_router.dart';
import '../router/has_bottom_navigator/shell_default_router.dart'
    as shell_default_router;
import '../router/not_bottom_navigator/no_shell_default_router.dart'
    as no_shell_default_router;
import '../utils/member_helper.dart';
import '../widget/bottom_bar/scaffold_with_navbar.dart';
import '../widget/smart_dialog/smart_dialog_helper.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();
var goRouterBaseConfig = GoRouterBaseConfig();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithNavBar(
          child: child,
          state: state,
        );
      },
      routes: goRouterBaseConfig.hasBottomNavigatorRouterBaseList,
    ),
    ShellRoute(
      builder: (context, state, child) {
        return child;
      },
      routes: goRouterBaseConfig.notBottomNavigatorRouterBaseList,
    ),
  ],
  redirect: (context, state) {
/*    const isAuthenticated =
        true; // Add your logic to check whether a user is authenticated or not*/
    if (state.fullPath == null) {
      return null;
    }
    var fullPath = state.fullPath;
    if (fullPath == "/signup" || fullPath == "/signin") {
      return fullPath;
    }
    if (isFirstUse()) {
      return "/welcome";
    }
    var loginFlag = isLogin();

    if (!loginFlag) {
      return "/signin";
    }
    if (fullPath == "/familyManager/selectExists") {
      return fullPath;
    }
    if (null == familyLogic.familyRespVo.value) {
      if (fullPath == "/familyManager/create") {
        return fullPath;
      }
      //还没有绑定到家庭
      return "/familyManager";
    }

    return fullPath;
  },
  observers: [FlutterSmartDialog.observer],
  errorBuilder: (c, s) => ErrorRoute(error: s.error!).build(c, s),
);

class GoRouterBaseConfig {
  List<RouteBase> _hasBottomNavigatorRouterBaseList = [];
  List<RouteBase> _notBottomNavigatorRouterBaseList = [];

  get hasBottomNavigatorRouterBaseList => _hasBottomNavigatorRouterBaseList;

  get notBottomNavigatorRouterBaseList => _notBottomNavigatorRouterBaseList;

  GoRouterBaseConfig() {
    _hasBottomNavigatorRouterBaseList = [];
    _hasBottomNavigatorRouterBaseList.addAll(shell_default_router.$appRoutes);

    _notBottomNavigatorRouterBaseList = [];
    _notBottomNavigatorRouterBaseList
        .addAll(no_shell_default_router.$appRoutes);
  }
}
