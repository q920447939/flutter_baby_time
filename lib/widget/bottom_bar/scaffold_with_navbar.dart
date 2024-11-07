import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../app/modules/bottom_bar_module/bottom_bar_page_controller.dart';
import '../../page/home/home_page.dart';
import 'bottom_bar_navigator.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget? child;
  BottomBarPageController homePageController =
      Get.find<BottomBarPageController>();

  ScaffoldWithNavBar({this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => homePageController.curPage,
      ),
      bottomNavigationBar: BottomBarNavigator(),
    );
  }
}
