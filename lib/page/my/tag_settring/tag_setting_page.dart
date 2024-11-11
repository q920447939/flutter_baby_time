import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../widget/smart_dialog/smart_dialog_helper.dart';

class TagSettingPage extends StatefulWidget {
  const TagSettingPage({super.key});

  @override
  State<TagSettingPage> createState() => _TagSettingPageState();
}

class _TagSettingPageState extends State<TagSettingPage> {
  List<String> tags = ['标签1', '标签2', '标签3'];
  int maxTag = 5;

  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GreyBaseScaffoldStack(
      title: '标签管理',
      child: ContainerWrapperCard(
        margin: EdgeInsets.all(10.w),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10.h, 10.w, 10.h),
          child: Wrap(
            runSpacing: 10.w,
            spacing: 10.w,
            children: _buildTags(context),
          ),
        ),
      ),
      floatingActionButton: _buildAddTag(context),
    );
  }

  Widget _buildAddTag(BuildContext context) {
    return TDFab(
      theme: TDFabTheme.primary,
      onClick: () async {
        if (maxTag == tags.length) {
          dialogWarning('最多添加$maxTag个标签');
          return;
        }
        await SmartDialog.show(
          builder: (_) {
            return ContainerWrapperCard(
              height: 200.h,
              margin: EdgeInsets.all(10.w),
              child: Center(
                child: Column(
                  children: [
                    TDInput(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.black12),
                        color: Colors.black,
                      ),
                      type: TDInputType.cardStyle,
                      leftLabel: '',
                      controller: controller,
                      hintText: '请输入昵称',
                      maxLength: 20,
                      additionInfo: '最大输入20个字符',
                      onChanged: (text) {},
                      onClearTap: () {
                        controller.clear();
                      },
                    ),
                    Spacer(),
                    TDButton(
                      text: '确认',
                      size: TDButtonSize.medium,
                      type: TDButtonType.fill,
                      shape: TDButtonShape.rectangle,
                      theme: TDButtonTheme.primary,
                      onTap: () {
                        var newTag = controller.value.text;
                        if ("" == newTag) {
                          dialogWarning('还没有输入标签名称哦');
                          return;
                        }

                        if (tags.contains(newTag)) {
                          dialogWarning('标签已存在');
                          return;
                        }
                        tags.add(newTag);
                        setState(() {});
                        SmartDialog.dismiss();
                      },
                    ),
                    gapHeightNormal(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  _buildConfirmNormal(BuildContext context) async {
    return await SmartDialog.show(builder: (_) {
      return TDAlertDialog(
        title: '删除标签',
        content: '确定删除标签吗?删除后无法恢复!',
        leftBtnAction: () {
          SmartDialog.dismiss(result: false);
        },
        rightBtnAction: () {
          SmartDialog.dismiss(result: true);
        },
      );
    });
  }

  _buildTags(BuildContext context) {
    return tags
        .map(
          (e) => TDTag(
            e,
            needCloseIcon: true,
            onCloseTap: () async {
              var res = await _buildConfirmNormal(context);
              if (res == false) return;
              tags.remove(e);
              setState(() {});
            },
          ),
        )
        .toList();
  }
}
