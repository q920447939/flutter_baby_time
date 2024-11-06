import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bottom_bar_navigator.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;
  final GoRouterState state;

  ScaffoldWithNavBar(this.child, this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomBarNavigator(),
    );
  }

  Map<String, List<String>> notBottomBarNavigatorPrefixLevelMap = {
    'my': [
      'tradeNavigator',
      'imageEdit',
      'recharge',
      'rechargeHistory',
    ],
    'perMission': [
      'perMissionCheck',
    ],
  };
}
