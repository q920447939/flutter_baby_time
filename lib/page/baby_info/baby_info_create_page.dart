import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/config/material_app_config.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_baby_time/widget/button/default_button.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_baby_time/widget/smart_dialog/smart_dialog_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../dao/baby/baby_dao.dart';
import '../../getx/controller/manager_gex_controller.dart';
import '../../utils/datime_helper.dart';
import '../../utils/premission/premission_helper.dart';
import '../../widget/gap/gap_width.dart';
import '../../widget/image_pick/ImagePickerType.dart';
import '../my/baby_setting/sex_enums.dart';

class BabyInfoCreatePage extends StatefulWidget {
  const BabyInfoCreatePage({super.key});

  @override
  State<BabyInfoCreatePage> createState() => _BabyInfoCreatePageState();
}

class _BabyInfoCreatePageState extends State<BabyInfoCreatePage> {
  TextEditingController _nickNameController = TextEditingController();
  SexEnums sex = SexEnums.female;

  DateTime birthDate = DateTime.now();

  var jiffy = Jiffy.now();

  String avatar = '';

  String selected_6 = '';

  @override
  void initState() {
    selected_6 = formatDate(birthDate);
    super.initState();
    // 在初始化时检查权限
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestPermission(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GreyBaseScaffoldStack(
      showBackIcon: false,
      title: '新增宝宝信息',
      child: ContainerWrapperCard(
        padding: EdgeInsets.all(10.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                var list = await ImagePickerHelper.pickAndUploadImages(
                    type: ImagePickerType.gallery);
                if (list.isNotEmpty) {
                  setState(() {
                    avatar = list.first;
                  });
                }
              },
              child: Align(
                alignment: Alignment.center,
                child: buildAvatar(),
              ),
            ),
            gapHeightLarge(),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: TDText('宝宝昵称'),
            ),
            TDInput(
              controller: _nickNameController,
              backgroundColor: Colors.white,
              hintText: '请输入宝宝昵称',
              maxLength: 10,
              onChanged: (text) {
                setState(() {});
              },
              onClearTap: () {
                setState(() {
                  _nickNameController.clear();
                });
              },
            ),
            gapHeightNormal(),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: TDText('宝宝性别'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 10.h),
              child: GestureDetector(
                onTap: () async {
                  await _changeRadio();
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TDText(sex.label),
                      Icon(Icons.arrow_right_outlined),
                    ]),
              ),
            ),
            SizedBox(
              height: 20.h,
              child: Container(
                alignment: Alignment.center,
                child: const TDDivider(),
              ),
            ),
            gapHeightNormal(),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: TDText('宝宝出生日期'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 10.h),
              child: GestureDetector(
                onTap: () {
                  TDPicker.showDatePicker(context, title: '选择出生日期',
                      onConfirm: (selected) {
                    if (selected.isNotEmpty) {
                      setState(() {
                        selected_6 =
                            '${selected['year'].toString().padLeft(4, '0')}-'
                            '${selected['month'].toString().padLeft(2, '0')}-'
                            '${selected['day'].toString().padLeft(2, '0')} ';
                      });
                    }
                    Navigator.of(context).pop();
                  }, useWeekDay: true, dateStart: [
                    2000,
                    01,
                    01
                  ], dateEnd: [
                    jiffy.year,
                    jiffy.month,
                    jiffy.daysInMonth
                  ], initialDate: [
                    jiffy.year,
                    jiffy.month,
                    jiffy.daysInMonth
                  ]);
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TDText(selected_6),
                      Icon(Icons.arrow_right_outlined),
                    ]),
              ),
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
                title: '保存',
                onPressed: () async {
                  if (avatar.isEmpty) {
                    await dialogFailure('头像不能为空');
                    return;
                  }
                  var res = await BabyDao.create({
                    "familyId": familyLogic.familyRespVo.value!.id,
                    "name": _nickNameController.text,
                    "avatarUrl": avatar,
                    "sex": sex.value,
                    "birthday": selected_6
                  });
                  if (null != res && res > 0) {
                    await dialogSuccess('新增宝宝信息成功', onDismiss: () {
                      context.go("/");
                    });
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget buildAvatar() {
    if (avatar.isEmpty) {
      return Stack(
        children: [
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: TDText('头像'),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 10,
            child: Icon(
              TDIcons.logo_adobe_photoshop_filled,
              size: 40,
            ),
          ),
        ],
      );
    }
    return SizedBox(
      height: 150.h,
      width: 150.w,
      child: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(avatar),
        radius: 75.w,
      ),
    );
  }

  Row buildRow(String leftText, {required Widget rightWidget}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TDText(
          leftText,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            rightWidget,
            gapWidthSmall(),
            Icon(Icons.arrow_right_outlined),
          ],
        ),
      ],
    );
  }

  Future<void> _changeRadio() async {
    var result = await SmartDialog.show(
        tag: "_changeRadio",
        builder: (c) {
          return ContainerWrapperCard(
            width: 200.w,
            height: 110.h,
            child: Center(
              child: _radioStatus(context),
            ),
          );
        });
    if (null != result) {
      setState(() {
        sex = SexEnums.fromString(result);
      });
    }
  }

  Widget _radioStatus(BuildContext context) {
    return TDRadioGroup(
      contentDirection: TDContentDirection.right,
      selectId: SexEnums.female.value,
      onRadioGroupChange: (selectedId) {
        SmartDialog.dismiss(
            tag: "_changeRadio", force: true, result: selectedId);
      },
      child: Column(
        children: _buildRadio(),
      ),
    );
  }

  List<Widget> _buildRadio() {
    return SexEnums.values.map((mode) {
      return TDRadio(
        id: mode.value,
        title: mode.label,
        radioStyle: TDRadioStyle.circle,
      );
    }).toList();
  }
}
