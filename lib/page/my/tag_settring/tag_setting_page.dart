import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:flutter_baby_time/widget/future/future_.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../dao/upload_list/upload_list_dao.dart';
import '../../../getx/controller/manager_gex_controller.dart';
import '../../../model/baby/BabyUploadListRelationTagRespVO.dart';
import '../../../model/baby/BabyUploadTagRespVO.dart';
import '../../../widget/smart_dialog/smart_dialog_helper.dart';

class TagSettingPage extends StatefulWidget {
  const TagSettingPage({super.key});

  @override
  State<TagSettingPage> createState() => _TagSettingPageState();
}

class _TagSettingPageState extends State<TagSettingPage> {
  TextEditingController controller = TextEditingController();

  List<String> tagNameList = [];
  int maxTag = 100;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<List<BabyUploadTagRespVo>?> fetch() {
    return UploadListDao.getBabyUploadTagAll();
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
          child: FutureLoading(
              future: fetch(),
              builder: (_, list) {
                return _buildTag(list);
              }),
        ),
      ),
      floatingActionButton: _buildAddTag(context),
    );
  }

  Widget _buildAddTag(BuildContext context) {
    return TDFab(
      theme: TDFabTheme.primary,
      onClick: () async {
        if (maxTag == tagNameList.length) {
          dialogWarning('最多添加$maxTag个标签');
          return;
        }
        var name = await SmartDialog.show(
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
                      hintText: '请输入标签名称',
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
                      onTap: () async {
                        var newTag = controller.value.text;
                        if ("" == newTag) {
                          dialogWarning('还没有输入标签名称哦');
                          return;
                        }

                        if (tagNameList.contains(newTag)) {
                          dialogWarning('标签已存在');
                          return;
                        }
                        tagNameList.add(newTag);
                        var b = await UploadListDao.addTag({
                          "babyId": babyController.babyId.value,
                          "tagName": newTag
                        });

                        if (b) {
                          await dialogSuccess('添加标签成功',
                              displayTime: const Duration(seconds: 1));
                          SmartDialog.dismiss();
                        }
                      },
                    ),
                    gapHeightNormal(),
                  ],
                ),
              ),
            );
          },
        );
        print("tagNameList $tagNameList");
        controller.clear();
        setState(() {});
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

  _buildTags(BuildContext context, List<BabyUploadTagRespVo> list) {
    return list
        .map(
          (e) => TDTag(
            e.tagName!,
            needCloseIcon: true,
            onCloseTap: () async {
              var res = await _buildConfirmNormal(context);
              if (res == false) return;

              list.remove(e);
              tagNameList.remove(e.tagName);
              var b = await UploadListDao.removeTag(e.id);
              if (b) {
                await dialogSuccess('删除标签成功',
                    displayTime: const Duration(seconds: 1));
                setState(() {});
              }
            },
          ),
        )
        .toList();
  }

  _buildTag(List<BabyUploadTagRespVo>? list) {
    if (null == list || list.isEmpty) {
      tagNameList = [];
      return TDText(
        '还没有添加标签哦',
        style: TextStyle(color: Colors.grey.withOpacity(0.7)),
      );
    }
    tagNameList = list.map((e) => e.tagName!).toList();
    return Wrap(
      runSpacing: 10.w,
      spacing: 10.w,
      children: _buildTags(context, list),
    );
  }
}
