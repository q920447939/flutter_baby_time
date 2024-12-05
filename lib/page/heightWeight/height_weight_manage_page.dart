import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/page/heightWeight/height_record_body_1.dart';
import 'package:flutter_baby_time/page/heightWeight/weight_record.dart';
import 'package:flutter_baby_time/page/heightWeight/weight_record_body.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../widget/container/container_wrapper_card.dart';
import '../../widget/gap/gap_height.dart';
import '../../widget/smart_dialog/smart_dialog_helper.dart';
import 'controller/height_weight_manager_controller.dart';
import 'height_record.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'height_record_body_2.dart';

class HeightWeightManagePage extends StatefulWidget {
  const HeightWeightManagePage({super.key});

  @override
  State<HeightWeightManagePage> createState() => _HeightWeightManagePageState();
}

class _HeightWeightManagePageState extends State<HeightWeightManagePage> {
  String model = 'height';

  HeightWeightManagerController heightWeightManagerController = Get.find();
  int currentIndex = 0;

  Map<int, Widget> widgetBody1Map = {
    0: const HeightRecordBodyPage1(),
    1: const WeightRecordBodyPage(),
  };

  Map<int, Widget> widgetBody2Map = {
    0: const HeightRecordBodyPage2(),
    1: const WeightRecordBodyPage(),
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GreyBaseScaffoldStack(
      title: '身高体重管理',
      leftBackWidget: IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          if (context.canPop()) {
            context.go('/');
          }
        },
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 0.h, 5.w, 10.h),
        child: Column(
          children: [
            //Initialize the chart widget
            ContainerWrapperCard(
              height: 45.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
              ),
              child: TDBottomTabBar(
                TDBottomTabBarBasicType.text,
                componentType: TDBottomTabBarComponentType.normal,
                useSafeArea: false,
                showTopBorder: false,
                useVerticalDivider: true,
                currentIndex: currentIndex,
                navigationTabs: [
                  TDBottomTabBarTabConfig(
                    tabText: '身高',
                    onTap: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                  ),
                  TDBottomTabBarTabConfig(
                    tabText: '体重',
                    onTap: () {
                      setState(() {
                        currentIndex = 1;
                      });
                    },
                  ),
                ],
              ),
            ),
            gapHeightNormal(),
            ContainerWrapperCard(
              height: 350.h,
              child: widgetBody1Map[currentIndex]!,
            ),
            gapHeightNormal(),
            ContainerWrapperCard(
              height: 300.h,
              padding: EdgeInsets.fromLTRB(10.w, 5.h, 10.w, 5.h),
              child: widgetBody2Map[currentIndex]!,
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatButton(context),
    );
  }

  Widget _buildFloatButton(BuildContext context) {
    return TDFab(
      theme: TDFabTheme.primary,
      onClick: () async {
        await SmartDialog.show(
          useSystem: true,
          builder: (c) {
            return ContainerWrapperCard(
              height: 550.h,
              margin: EdgeInsets.all(10.w),
              padding: EdgeInsets.all(10.w),
              child: Column(
                children: [
                  //_horizontalCardStyle(c),
                  //gapHeightNormal(),
                  HeightRecord()
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _horizontalCardStyle(BuildContext context) {
    return TDRadioGroup(
      selectId: model,
      cardMode: true,
      showDivider: true,
      direction: Axis.horizontal,
      rowCount: 2,
      directionalTdRadios: const [
        TDRadio(
          id: 'height',
          title: '身高',
          cardMode: true,
        ),
        TDRadio(
          id: 'weight',
          title: '体重',
          cardMode: true,
        ),
      ],
      onRadioGroupChange: (model) {
        heightWeightManagerController.model.value = model!;
      },
    );
  }
}
