import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_baby_time/widget/button/default_button.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_baby_time/widget/smart_dialog/smart_dialog_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../dao/family/family_dao.dart';

class FamilyCreatePage extends StatefulWidget {
  const FamilyCreatePage({super.key});

  @override
  State<FamilyCreatePage> createState() => _FamilyCreatePageState();
}

class _FamilyCreatePageState extends State<FamilyCreatePage> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GreyBaseScaffoldStack(
      title: '创建家庭',
      child: ContainerWrapperCard(
        child: ContainerWrapperCard(
          child: Column(
            children: [
              TDInput(
                leftLabel: '家庭名称',
                controller: _textEditingController,
                backgroundColor: Colors.white,
                hintText: '请输入家庭名称',
                onChanged: (newVal) {
                  setState(() {});
                },
                onClearTap: () {
                  setState(() {});
                },
              ),
              SizedBox(
                height: 20.h,
                child: Container(
                  alignment: Alignment.center,
                  child: const TDDivider(),
                ),
              ),
              Spacer(),
              DefaultButton(
                title: '确认',
                allowClick: _textEditingController.value.text.isNotEmpty,
                onPressed: () async {
                  var res = await FamilyDao.create(
                      {"familyName": _textEditingController.value.text});
                  if (null != res && res > 0) {
                    await dialogSuccess('创建家庭成功');
                    if (mounted) {
                      context.go("/familyManager");
                    }
                  }
                },
              ),
              Gap(50.h),
            ],
          ),
        ),
      ),
    );
  }
}
