import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/config/material_app_config.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_baby_time/widget/button/default_button.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../getx/controller/manager_gex_controller.dart';
import '../../utils/datime_helper.dart';
import '../../widget/gap/gap_width.dart';
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
              onTap: () {},
              child: Align(
                alignment: Alignment.center,
                child: Stack(
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
                        TDIcons.photo,
                        size: 40,
                      ),
                    ),
                  ],
                ),
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
                      /*selected_6 =
                          '${selected['year'].toString().padLeft(4, '0')}-'
                          '${selected['month'].toString().padLeft(2, '0')}-'
                          '${selected['day'].toString().padLeft(2, '0')} ';*/
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
                      TDText(formatDate(birthDate)),
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
            DefaultButton(title: '保存', onPressed: () {}),
          ],
        ),
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
  }

  Widget _radioStatus(BuildContext context) {
    return TDRadioGroup(
      contentDirection: TDContentDirection.right,
      selectId: babyController.sex.value.value,
      onRadioGroupChange: (selectedId) {
        babyController.changeSex(selectedId ?? SexEnums.female.value);
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
