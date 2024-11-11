import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../widget/container/container_wrapper_card.dart';
import '../../widget/gap/gap_height.dart';
import '../../widget/smart_dialog/smart_dialog_helper.dart';

class HeightWeightManagePage extends StatefulWidget {
  const HeightWeightManagePage({super.key});

  @override
  State<HeightWeightManagePage> createState() => _HeightWeightManagePageState();
}

class _HeightWeightManagePageState extends State<HeightWeightManagePage> {
  @override
  Widget build(BuildContext context) {
    return GreyBaseScaffoldStack(
      title: '身高体重管理',
      child: ContainerWrapperCard(
        margin: EdgeInsets.all(10.w),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10.h, 10.w, 10.h),
          child: Column(
            children: [],
          ),
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
          builder: (c) {
            return ContainerWrapperCard(
              height: 500.h,
              margin: EdgeInsets.all(10.w),
              padding: EdgeInsets.all(10.w),
              child: Column(
                children: [
                  _horizontalCardStyle(c),
                  gapHeightNormal(),
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
      selectId: 'index:1',
      cardMode: true,
      showDivider: true,
      direction: Axis.horizontal,
      rowCount: 2,
      directionalTdRadios: const [
        TDRadio(
          id: 'index:0',
          title: '身高',
          cardMode: true,
        ),
        TDRadio(
          id: 'index:1',
          title: '体重',
          cardMode: true,
        ),
      ],
    );
  }
}
