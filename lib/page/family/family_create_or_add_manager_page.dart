import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_baby_time/widget/button/default_button.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_baby_time/widget/smart_dialog/smart_dialog_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../dao/family/family_dao.dart';
import '../../getx/controller/manager_gex_controller.dart';
import '../../model/baby/BabyInfoRespVO.dart';
import '../../router/not_bottom_navigator/no_shell_default_router.dart';

class FamilyCreateOrAddManagerPage extends StatefulWidget {
  List<FamilyRespVo> data;

  FamilyCreateOrAddManagerPage({super.key, required this.data});

  @override
  State<FamilyCreateOrAddManagerPage> createState() =>
      _FamilyCreateOrAddManagerPageState();
}

class _FamilyCreateOrAddManagerPageState
    extends State<FamilyCreateOrAddManagerPage> {
  @override
  Widget build(BuildContext context) {
    var len = widget.data.length;
    var notFamily = len == 0;
    return GreyBaseScaffoldStack(
      showBackIcon: false,
      title: '',
      child: Center(
        child: ContainerWrapperCard(
          padding: EdgeInsets.all(
            10.w,
          ),
          height: 500.h,
          width: 400.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TDText(
                notFamily ? '您当前还未加入家庭' : '您当前已创建/加入$len个家庭',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              gapHeightSmall(),
              TDText(notFamily ? '让我们创建或加入一个家庭' : '您可以选择创建/加入新家庭或进入现有家庭'),
              Gap(50.h),
              DefaultButton(
                  title: '创建/加入新家庭',
                  onPressed: () async {
                    var res = await _dialogFamily(context);
                    if (mounted) {
                      if (null != res) {
                        if (res == 'create') {
                          context.push('/familyManager/create');
                        } else {
                          context.push("/familyManager/applyFamily");
                          //context.pushReplacement('');
                        }
                      }
                    }
                  }),
              gapHeightSmall(),
              if (!notFamily)
                DefaultButton(
                  title: '选择现有家庭($len个)',
                  color: Color(0x9FF417FF),
                  onPressed: () {
                    // 使用 FamilySelectExistsPageRouter 的方式来导航
                    FamilySelectExistsPageRouter().push(context);
                  },
                ),
              DefaultButton(
                title: '切换账号',
                color: Color(0x9FEC133B),
                onPressed: () async {
                  await memberLogic.clean();
                  if (mounted) {
                    context.go("/");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Object?> _dialogFamily(BuildContext context) async {
    return await showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return TDAlertDialog.vertical(title: '创建/加入新家庭', buttons: [
          TDDialogButtonOptions(
              title: '创建',
              action: () {
                Navigator.pop(buildContext, 'create');
              },
              theme: TDButtonTheme.primary),
          TDDialogButtonOptions(
              title: '加入',
              titleColor: TDTheme.of(context).brandColor7,
              action: () {
                Navigator.pop(buildContext, 'apply');
              },
              theme: TDButtonTheme.light),
        ]);
      },
    );
  }
}
