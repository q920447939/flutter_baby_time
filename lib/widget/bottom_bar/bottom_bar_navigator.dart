import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../model/app_config/navigator/app_navigator_config_model.dart';
import '../../page/home/home_page.dart';
import '../../utils/skeletonizer_helper.dart';
import 'bottom_bar_helper.dart';

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
    return FutureBuilder<void>(
        future: futureFetchData,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SkeletonizerWidget();
          } else {
            return const HomePage();
            /*return Consumer<BottomNavigatorBarIndexProvider>(builder:
                (BuildContext context,
                    BottomNavigatorBarIndexProvider
                        bottomNavigatorBarIndexProvider,
                    Widget? child) {
              return Container(
                padding: const EdgeInsets.only(bottom: 0, right: 5, left: 5),
                child: BottomNavigationBar(
                  selectedFontSize: 16.sp,
                  showSelectedLabels:
                      true, // Ensure selected text is always shown
                  showUnselectedLabels:
                      true, // Ensure unselected text is always shown
                  selectedItemColor:
                      Colors.blue, // Set the color for selected item text
                  unselectedItemColor:
                      Colors.grey, // Set the color for unselected item text
                  selectedLabelStyle: TextStyle(
                    color: Colors.blue, // Ensure selected text color
                  ),
                  unselectedLabelStyle: TextStyle(
                    color: Colors.grey, // Ensure unselected text color
                  ),
                  currentIndex: bottomNavigatorBarIndexProvider.getIndex(),
                  onTap: (index) {
                    Provider.of<BottomNavigatorBarIndexProvider>(context,
                            listen: false)
                        .modifyBottomNavigatorIndex(index);
                    context.go(appNavigatorConfigList[index].targetUri!);
                  },
                  items: items2,
                ),
              );
            });*/
          }
        });
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
