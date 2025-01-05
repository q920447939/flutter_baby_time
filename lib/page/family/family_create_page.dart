import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
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
import '../../getx/controller/manager_gex_controller.dart';
import '../../utils/premission/premission_helper.dart';
import '../../widget/image_pick/ImagePickerType.dart';

class FamilyCreatePage extends StatefulWidget {
  const FamilyCreatePage({super.key});

  @override
  State<FamilyCreatePage> createState() => _FamilyCreatePageState();
}

class _FamilyCreatePageState extends State<FamilyCreatePage> {
  TextEditingController _textEditingController = TextEditingController();
  String backgroundUrl = '';

  @override
  void initState() {
    super.initState();
    // 在初始化时检查权限
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestPermission(context);
    });
  }

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
              gapHeightLarge(),
              GestureDetector(
                onTap: () async {
                  var list = await ImagePickerHelper.pickAndUploadImages(
                      type: ImagePickerType.gallery);
                  if (list.isNotEmpty) {
                    setState(() {
                      backgroundUrl = list.first;
                    });
                  }
                },
                child: Align(
                  alignment: Alignment.center,
                  child: buildBackGround(),
                ),
              ),
              Spacer(),
              DefaultButton(
                title: '确认',
                allowClick: _textEditingController.value.text.isNotEmpty,
                onPressed: () async {
                  if (backgroundUrl.isEmpty) {
                    await dialogFailure('家庭背景图不能为空');
                    return;
                  }
                  var res = await FamilyDao.create(
                    {
                      "familyName": _textEditingController.value.text,
                      "familyBackgroundUrl": backgroundUrl,
                    },
                  );
                  if (null != res && res > 0) {
                    dialogSuccess('创建家庭成功', onDismiss: () {
                      context.go("/familyManager");
                    });
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

  Widget buildBackGround() {
    if (backgroundUrl.isEmpty) {
      return Stack(
        children: [
          Container(
            width: 350.w,
            height: 150.h,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Center(
              child: TDText('家庭背景图'),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 10,
            child: Icon(
              TDIcons.browse_gallery_filled,
              size: 20.w,
            ),
          ),
        ],
      );
    }
    return Stack(
      children: [
        // 背景层：模糊的放大图片
        Container(
          width: 350.w,
          height: 150.h,
          child: ClipRect(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: CachedNetworkImage(
                imageUrl: backgroundUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // 前景层：完整显示的图片
        Container(
          width: 350.w,
          height: 150.h,
          child: CachedNetworkImage(
            imageUrl: backgroundUrl,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
