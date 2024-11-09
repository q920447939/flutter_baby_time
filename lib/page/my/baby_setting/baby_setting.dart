import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/page/my/baby_setting/sex_enums.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_baby_time/widget/gap/gap_width.dart';
import 'package:flutter_baby_time/widget/smart_dialog/smart_dialog_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import 'baby_setting_controller.dart';

class BabySetting extends StatefulWidget {
  const BabySetting({Key? key}) : super(key: key);

  @override
  _BabySettingState createState() => _BabySettingState();
}

class _BabySettingState extends State<BabySetting> {
  BabySettingController _babyController = Get.find();

  String selected_6 = '';
  var weekDayList = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var jiffy = Jiffy.now();
    var lastYearDate = jiffy.subtract(years: 1);

    return GreyBaseScaffoldStack(
      title: '宝宝资料',
      child: Column(
        children: [
          gapHeightNormal(),
          ContainerWrapperCard(
            height: 200.h,
            child: Center(
              child: TDAvatar(
                size: TDAvatarSize.large,
                type: TDAvatarType.normal,
                shape: TDAvatarShape.circle,
                defaultUrl: 'assets/img/baby_avator.jpeg',
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          gapHeightNormal(),
          ContainerWrapperCard(
            padding: EdgeInsets.all(10.w),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _changeBabyName();
                  },
                  child: buildRow(
                    '宝宝昵称',
                    rightWidget:
                        Obx(() => TDText(_babyController.babyName.value)),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                  child: Container(
                    alignment: Alignment.center,
                    child: const TDDivider(),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await _changeRadio();
                  },
                  child: buildRow(
                    '宝宝性别',
                    rightWidget:
                        Obx(() => TDText(_babyController.sex.value.label)),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                  child: Container(
                    alignment: Alignment.center,
                    child: const TDDivider(),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    TDPicker.showDatePicker(context, title: '选择出生日期',
                        onConfirm: (selected) {
                      if (selected.isNotEmpty) {
                        selected_6 =
                            '${selected['year'].toString().padLeft(4, '0')}-'
                            '${selected['month'].toString().padLeft(2, '0')}-'
                            '${selected['day'].toString().padLeft(2, '0')} ';
                        _babyController.changeBirthday(selected_6);
                      }
                      Navigator.of(context).pop();
                    }, useWeekDay: true, dateStart: [
                      1979,
                      01,
                      01
                    ], dateEnd: [
                      jiffy.year,
                      jiffy.month,
                      jiffy.daysInMonth
                    ], initialDate: [
                      lastYearDate.year,
                      lastYearDate.month,
                      lastYearDate.daysInMonth
                    ]);
                  },
                  child: buildRow(
                    '宝宝出生日',
                    rightWidget: Obx(() => TDText(_babyController
                                .birthday.value ==
                            '未设置'
                        ? _babyController.birthday.value
                        : formatChineseDate(_babyController.birthday.value))),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                  child: Container(
                    alignment: Alignment.center,
                    child: const TDDivider(),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: buildRow(
                    '更换主页背景',
                    rightWidget:
                        Obx(() => TDText(_babyController.babyName.value)),
                  ),
                ),
              ],
            ),
          ),
        ],
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

  Widget buildSelectRow(BuildContext context, String output, String title) {
    return Container(
      color: TDTheme.of(context).whiteColor1,
      height: 56.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                child: TDText(
                  title,
                  font: TDTheme.of(context).fontBodyLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    TDText(
                      output,
                      font: TDTheme.of(context).fontBodyLarge,
                      textColor:
                          TDTheme.of(context).fontGyColor3.withOpacity(0.4),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Icon(
                        TDIcons.chevron_right,
                        color:
                            TDTheme.of(context).fontGyColor3.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const TDDivider(
            margin: EdgeInsets.only(
              left: 16,
            ),
          )
        ],
      ),
    );
  }

  String formatChineseDate(String dateStr) {
    // 先解析字符串为DateTime
    DateTime date = DateFormat('yyyy-MM-dd').parse(dateStr);
    // 再格式化为中文格式，注意这里的M不用MM，这样可以去掉月份前面的0
    return DateFormat('yyyy年M月d日').format(date);
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
    print("result is $result");
  }

  Widget _radioStatus(BuildContext context) {
    return TDRadioGroup(
      contentDirection: TDContentDirection.right,
      selectId: _babyController.sex.value.value,
      onRadioGroupChange: (selectedId) {
        _babyController.changeSex(selectedId ?? SexEnums.female.value);
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

  Future<void> _changeBabyName() async {
    var result = await SmartDialog.show(
        tag: "babyName",
        builder: (_) {
          return ContainerWrapperCard(
            width: 350.w,
            height: 200.h,
            margin: EdgeInsets.only(bottom: 60.h),
            child: Column(
              children: [
                Container(
                  height: 100.h,
                  child: TDInput(
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
                ),
                gapHeightNormal(),
                TDButton(
                  text: '确认',
                  size: TDButtonSize.medium,
                  type: TDButtonType.fill,
                  shape: TDButtonShape.rectangle,
                  theme: TDButtonTheme.primary,
                  onTap: () {
                    if ("" == controller.value.text) {
                      dialogWarning('还没有输入宝宝名称哦');
                      return;
                    }
                    SmartDialog.dismiss(
                        tag: "babyName",
                        force: true,
                        result: controller.value.text);
                  },
                ),
              ],
            ),
          );
        });
    if (result != null && result != "") {
      _babyController.babyName.value = result;
    }
  }
}
