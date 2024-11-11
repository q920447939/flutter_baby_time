import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/config/go_router_config.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_baby_time/widget/gap/gap_width.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../design_pattern/view_model/ViewModel.dart';
import '../../router/has_bottom_navigator/shell_default_router.dart';
import '../home/view_model_controller.dart';
import 'baby_setting/baby_setting_controller.dart';
import 'global_setting/global_setting_controller.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  ViewModeController _viewModeController = Get.find();
  BabySettingController _babyController = Get.find();
  GlobalSettingController _globalSettingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GreyBaseScaffoldStack(
      title: '个人中心',
      showBackIcon: false,
      appBarSize: 0,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          gapHeightLarge(),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 80.w,
              child: TDAvatar(
                size: TDAvatarSize.large,
                type: TDAvatarType.normal,
                shape: TDAvatarShape.circle,
                defaultUrl: 'assets/img/baby_avator.jpeg',
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          gapHeightNormal(),
          _buildPersonInfo(),
          gapHeightSmall(),
          homeViewModel(context),
          gapHeightSmall(),
          _babySetting(),
          gapHeightSmall(),
          _buildGlobalBackgroundImage(),
          gapHeightSmall(),
          _buildTag(),
        ],
      ),
    );
  }

  GestureDetector _buildGlobalBackgroundImage() {
    return GestureDetector(
      onTap: () {
        SmartDialog.showToast('功能开发中');
      },
      child: ContainerWrapperCard(
          height: 50.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TDText(
                '背景',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() => TDText(
                      '' == _globalSettingController.globalBackgroundImage.value
                          ? '系统默认背景'
                          : '自定义')),
                  gapWidthSmall(),
                  Icon(Icons.arrow_right_outlined),
                ],
              ),
            ],
          )),
    );
  }

  ContainerWrapperCard homeViewModel(BuildContext context) {
    return ContainerWrapperCard(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TDText('首页预览模式'),
          GestureDetector(
            onTap: () async {
              await _changeReadModel();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() {
                  return TDText(
                    _viewModeController.currentMode.value.label,
                  );
                }),
                gapWidthSmall(),
                Icon(
                  Icons.arrow_right_outlined,
                  size: 18.w,
                  color: TDTheme.of(context).brandNormalColor,
                ),
                gapWidthSmall(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _changeReadModel() async {
    var result = await SmartDialog.show(
        tag: "_changeReadModel",
        builder: (c) {
          return ContainerWrapperCard(
            width: 200.w,
            height: 110.h,
            child: Center(
              child: _radioStatus(context),
            ),
          );
        });
    print("result is $result");
  }

  Widget _radioStatus(BuildContext context) {
    return TDRadioGroup(
      contentDirection: TDContentDirection.right,
      selectId: _viewModeController.currentMode.value.value,
      onRadioGroupChange: (selectedId) {
        _viewModeController.changeViewMode(ViewMode.fromString(selectedId));
        SmartDialog.dismiss(
            tag: "_changeReadModel", force: true, result: selectedId);
      },
      child: Column(
        children: _buildViewModelTDRadio(),
      ),
    );
  }

  List<Widget> _buildViewModelTDRadio() {
    return ViewMode.values.map((mode) {
      return TDRadio(
        id: mode.value,
        title: mode.label,
        radioStyle: TDRadioStyle.circle,
      );
    }).toList();
  }

  _babySetting() {
    return _buildRowInfo('宝宝资料', () {
      const BabySettingRoute().push(context);
    });
  }

  _buildTag() {
    return _buildRowInfo('标签管理', () {
      const TagSettingRoute().push(context);
    });
  }

  _buildPersonInfo() {
    return _buildRowInfo('昵称', () {
      const MyProfileRoute().push(context);
    });
  }

  _buildRowInfo(String leftText, GestureTapCallback onTap) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: ContainerWrapperCard(
          height: 50.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TDText(
                leftText,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_right_outlined),
                ],
              ),
            ],
          )),
    );
  }
}
