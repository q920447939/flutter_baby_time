import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_baby_time/getx/controller/manager_gex_controller.dart';
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
import '../../model/baby/BabyInfoRespVO.dart';
import '../../router/not_bottom_navigator/no_shell_default_router.dart';
import '../../utils/family_member_role_helper.dart';

class BabyCreateOrAddManagerPage extends StatefulWidget {
  List<BabyInfoRespVo> data;

  BabyCreateOrAddManagerPage({super.key, required this.data});

  @override
  State<BabyCreateOrAddManagerPage> createState() =>
      _BabyCreateOrAddManagerPageState();
}

class _BabyCreateOrAddManagerPageState
    extends State<BabyCreateOrAddManagerPage> {
  @override
  void initState() {
    super.initState();
    check();
  }

  Future<void> check() async {
    if (!FamilyMemberRoleHelper.familyMemberRoleHasAdmin() &&
        widget.data.isEmpty) {
      //不是管理员,并且没有宝宝信息
      await dialogFailure('管理员未添加宝宝信息,请等待管理员添加!');
      await dialogFailure('即将回到登录页');
      await memberLogic.clean();
      if (mounted) {
        context.go("/");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var len = widget.data.length;
    var notBaby = len == 0;

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
                notBaby
                    ? '您当前还未添加宝宝信息'
                    : '当前家庭[${familyLogic.get()!.familyName}],您当前拥有$len个宝宝',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              gapHeightSmall(),
              TDText(notBaby ? '新增宝宝信息' : '选择宝宝信息'),
              Gap(50.h),
              if (FamilyMemberRoleHelper.familyMemberRoleHasAdmin())
                DefaultButton(
                  title: '新增宝宝信息',
                  onPressed: () async {
                    context.push('/babyManager/create');
                  },
                ),
              gapHeightSmall(),
              if (!notBaby)
                DefaultButton(
                  title: '选择宝宝信息($len个)',
                  color: Color(0x9FF417FF),
                  onPressed: () {
                    BabySelectExistsPageRouter().push(context);
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

  Future<Object?> _dialogBaby(BuildContext context) async {
    return await showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return TDAlertDialog.vertical(title: '新增宝宝', buttons: [
          TDDialogButtonOptions(
              title: '新增',
              action: () {
                Navigator.pop(buildContext, 'create');
              },
              theme: TDButtonTheme.primary),
          TDDialogButtonOptions(
              title: '选择现有宝宝',
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
