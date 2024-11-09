import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../model/app_config/navigator/app_navigator_config_model.dart';

class BottomBarNavigator extends StatefulWidget {
  BottomBarNavigator({super.key});

  @override
  State<BottomBarNavigator> createState() => _BottomBarNavigatorState();
}

class _BottomBarNavigatorState extends State<BottomBarNavigator> {
  List<SalomonBottomBarItem> items = [];
  List<BottomNavigationBarItem> items2 = [];
  List<NavigationConfigVo> appNavigatorConfigList = [];

  late var futureFetchData;

  @override
  void initState() {
    super.initState();
    futureFetchData = fetch();
  }

  Future<void> fetch() async {
    /* return await AppNavigatorDao.fetchNavigator().then((navigatorConfigList) {
      if (navigatorConfigList != null) {
        items2 = [];
        appNavigatorConfigList = navigatorConfigList;
        for (var item in navigatorConfigList) {
          items2.add(
            BottomNavigationBarItem(
              icon: SvgIcon(
                url: item.svgConfigVo!.svgUrl!,
              ),
              activeIcon: SvgIcon(
                url: item.svgConfigVo!.svgUrl!,
                size: 30.0, // selected icon size
              ),
              label: item.navigatorName!,
            ),
          );
        }
        bottomBarIndexMap(appNavigatorConfigList);
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return TDBottomTabBar(
      TDBottomTabBarBasicType.iconText,
      useVerticalDivider: false,
      navigationTabs: [
        TDBottomTabBarTabConfig(
          tabText: '首页',
          selectedIcon: Icon(
            TDIcons.home,
            size: 20.w,
            color: TDTheme.of(context).brandNormalColor,
          ),
          unselectedIcon: Icon(
            TDIcons.home,
            size: 20.w,
            color: TDTheme.of(context).brandNormalColor,
          ),
          onTap: () {
            context.go("/");
          },
        ),
        TDBottomTabBarTabConfig(
            tabText: '上传',
            selectedIcon: Icon(
              TDIcons.add,
              size: 20.w,
              color: Colors.red,
            ),
            unselectedIcon: Icon(
              TDIcons.add,
              size: 20.w,
              color: Colors.red,
            ),
            onTap: () {}),
        TDBottomTabBarTabConfig(
            tabText: '个人中心',
            selectedIcon: Icon(
              TDIcons.setting,
              size: 20.w,
              color: TDTheme.of(context).brandNormalColor,
            ),
            unselectedIcon: Icon(
              TDIcons.setting,
              size: 20.w,
              color: TDTheme.of(context).brandNormalColor,
            ),
            onTap: () {
              context.go("/my");
            }),
      ],
    );
  }
}

class SvgIcon extends StatelessWidget {
  final String url;
  final double size;
  final Color? color;

  const SvgIcon({
    Key? key,
    required this.url,
    this.size = 24.0,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      url,
      width: size,
      height: size,
    );
  }
}
