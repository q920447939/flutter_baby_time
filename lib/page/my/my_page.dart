import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_baby_time/widget/gap/gap_width.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../design_pattern/view_model/ViewModel.dart';
import '../home/view_model_controller.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  ViewModeController _viewModeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GreyBaseScaffoldStack(
      title: '',
      showBackIcon: false,
      appBarSize: 0,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Align(
            alignment: Alignment.centerLeft,
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
          ContainerWrapperCard(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TDText(
                  '首页预览模式',
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
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
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
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
}
