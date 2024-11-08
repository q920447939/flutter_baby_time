import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_baby_time/page/my/my_page.dart';
import 'package:go_router/go_router.dart';

import '../../page/home/home_page.dart';

part 'shell_default_router.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
)
@immutable
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

@TypedGoRoute<MyRoute>(
  path: '/my',
)
@immutable
class MyRoute extends GoRouteData {
  const MyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MyPage();
  }
}
