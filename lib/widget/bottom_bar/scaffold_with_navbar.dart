import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../page/home/home_page.dart';
import 'bottom_bar_navigator.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget? child;
  GoRouterState state;
  ScaffoldWithNavBar({required this.child, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomBarNavigator(),
    );
  }
}
