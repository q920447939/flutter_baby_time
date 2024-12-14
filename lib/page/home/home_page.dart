import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/page/home/home_view_model/time_line/time_lime_view_model.dart';
import 'package:flutter_baby_time/page/home/view_model_controller.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../dao/baby/baby_dao.dart';
import '../../design_pattern/view_model/ViewModel.dart';
import '../../model/baby/BabyInfoRespVO.dart';
import '../../model/uploadList/UploadListRespVO.dart';
import '../../router/has_bottom_navigator/shell_default_router.dart';
import '../../utils/calculate_age_helper.dart';
import '../../widget/container/container_wrapper_card.dart';
import '../../widget/future/future_.dart';
import '../../widget/gap/gap_height.dart';
import '../../widget/gap/gap_width.dart';
import '../my/baby_setting/baby_setting_controller.dart';
import 'home_view_model/fall/fall_load_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ViewModeController _viewModeController = Get.find();
  BabySettingController _babySettingController = Get.find();

  @override
  void initState() {
    fetch();
    super.initState();
  }

  Future<BabyInfoRespVo?> fetch() async {
    return await BabyDao.get();
  }

  @override
  Widget build(BuildContext context) {
    return WhiteBaseScaffoldStack(
        title: '',
        appBarSize: 0,
        showBackIcon: false,
        child: Column(
          children: [
            ContainerWrapperCard(
              margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
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
                        //defaultUrl: 'assets/img/baby_avator.jpeg',
                        avatarUrl: _babySettingController.babyNameAvatar.value,
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
                          Obx(
                            () => TDText(
                              _babySettingController.babyName.value,
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(
                            () => TDText(
                              _babySettingController.birthday.value == '未设置'
                                  ? _babySettingController.birthday.value
                                  : '${calculateAge(Jiffy.parse(_babySettingController.birthday.value, pattern: 'yyyy-MM-dd'))}(${Jiffy.parse(_babySettingController.birthday.value, pattern: 'yyyy-MM-dd').format(pattern: 'yyyy年M月d日')})',
                              style: TextStyle(fontSize: 12.sp),
                            ),
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
                TDBottomTabBarTabConfig(
                  tabText: '身高体重',
                  onTap: () {
                    const HeightWeightManageRoute().push(context);
                  },
                ),
              ],
            ),
            _viewModeController.currentMode == ViewMode.waterfall
                ? FallLoadViewModel(
                    height: 660.h,
                  )
                : TimeLimeViewModel(
                    height: 660.h,
                  )
          ],
        ));
  }
}
