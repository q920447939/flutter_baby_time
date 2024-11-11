import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:flutter_baby_time/widget/smart_dialog/smart_dialog_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../widget/base_stack/base_stack.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  TextEditingController controller = TextEditingController();
  String nickName = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GreyBaseScaffoldStack(
      title: '昵称设置',
      appBarRightTitle: '保存',
      appBarRightClick: () {
        if (nickName.isEmpty || nickName == '') {
          dialogWarning('昵称不能为空');
          return;
        }
        dialogSuccess('保存成功');
        context.pop();
      },
      child: ContainerWrapperCard(
        margin: EdgeInsets.all(10.w),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10.h, 10.w, 10.h),
          child: Column(
            children: [
              TDText(''),
              TDInput(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black12),
                  color: Colors.black,
                ),
                type: TDInputType.cardStyle,
                leftLabel: '',
                controller: controller,
                hintText: '独特的昵称,有助于你的好友更快的认识你',
                maxLength: 20,
                additionInfo: '最大输入20个字符',
                onChanged: (text) {
                  setState(() {
                    nickName = text;
                  });
                },
                onClearTap: () {
                  controller.clear();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
