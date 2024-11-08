import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_baby_time/widget/gap/gap_width.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import 'fall_load_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GreyBaseScaffoldStack(
        title: '',
        showBackIcon: false,
        appBarSize: 0,
        child: Column(
          children: [
            ContainerWrapperCard(
              margin: EdgeInsets.only(top: 5.h),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 61.w,
                      child: TDAvatar(
                        size: TDAvatarSize.medium,
                        type: TDAvatarType.normal,
                        shape: TDAvatarShape.circle,
                        defaultUrl: 'assets/img/baby_avator.jpeg',
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                  gapHeightNormal(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TDText(
                            '小熙熙',
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TDText(
                            '5岁 3个月',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          gapWidthNormal(),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            gapHeightNormal(),
            TDBottomTabBar(
              TDBottomTabBarBasicType.text,
              componentType: TDBottomTabBarComponentType.normal,
              useVerticalDivider: true,
              navigationTabs: [
                TDBottomTabBarTabConfig(
                  tabText: '推荐',
                  onTap: () {
                    //onTapTab(context, '标签1');
                  },
                ),
                TDBottomTabBarTabConfig(
                  tabText: '收藏',
                  onTap: () {
                    //onTapTab(context, '标签3');
                  },
                ),
                TDBottomTabBarTabConfig(
                  tabText: '标签',
                  onTap: () {
                    //onTapTab(context, '标签3');
                  },
                ),
              ],
            ),
            gapHeightSmall(),
            LazyLoadingStaggeredGrid(
              height: 692.h,
            ),
          ],
        ));
  }
}
