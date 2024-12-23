import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/button/default_button.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_baby_time/widget/smart_dialog/smart_dialog_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../dao/family/family_dao.dart';
import '../../router/not_bottom_navigator/no_shell_default_router.dart';
import '../../widget/base_stack/base_stack.dart';
import '../../widget/container/container_wrapper_card.dart';

class FamilyApplyPage extends StatefulWidget {
  const FamilyApplyPage({super.key});

  @override
  State<FamilyApplyPage> createState() => _FamilyApplyPageState();
}

class _FamilyApplyPageState extends State<FamilyApplyPage> {
  TextEditingController controller = TextEditingController();
  TextEditingController _applyReasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GreyBaseScaffoldStack(
      showBackIcon: false,
      title: '',
      appBarRightTitle: '申请历史',
      appBarRightClick: () {
        FamilyApplyHistoryPageRouter().push(context);
      },
      child: Center(
        child: ContainerWrapperCard(
          padding: EdgeInsets.all(
            10.w,
          ),
          child: Column(
            children: [
              TDInput(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black12),
                  color: Colors.black,
                ),
                type: TDInputType.cardStyle,
                leftLabel: '家庭编号',
                controller: controller,
                hintText: '请输入家庭编号',
                maxLength: 6,
                additionInfo: '最多输入6个字符',
                onChanged: (text) {
                  setState(() {});
                },
                onClearTap: () {
                  controller.clear();
                  setState(() {});
                },
              ),
              gapHeightNormal(),
              TDInput(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black12),
                  color: Colors.black,
                ),
                type: TDInputType.cardStyle,
                leftLabel: '申请理由',
                controller: _applyReasonController,
                hintText: '请输入申请理由',
                maxLength: 20,
                additionInfo: '最多输入20个字符',
                onChanged: (text) {
                  setState(() {});
                },
                onClearTap: () {
                  _applyReasonController.clear();
                  setState(() {});
                },
              ),
              DefaultButton(
                title: '申请',
                onPressed: () async {
                  var res = await FamilyDao.apply(
                    {
                      "applyFamilyCode": controller.text,
                      "applyReason": _applyReasonController.text,
                    },
                  );
                  if (null != res) {
                    await dialogSuccess(
                      '发送申请成功,请等待管理员审核',
                    );
                    setState(() {
                      controller.clear();
                      _applyReasonController.clear();
                    });
                  }
                },
              ),
              Spacer(),
              Gap(30.h),
            ],
          ),
        ),
      ),
    );
  }
}
