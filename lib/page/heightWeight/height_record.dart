import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../dao/height_record/height_dao.dart';
import '../../utils/datime_helper.dart';
import '../../widget/gap/gap_width.dart';
import '../../widget/smart_dialog/smart_dialog_helper.dart';
import 'height_weight_manager_parent.dart';

class HeightRecord extends HeightWeightManagerParent {
  final VoidCallback onUpdate;

  HeightRecord(this.onUpdate, {super.key});

  @override
  State<HeightRecord> createState() => _HeightRecordState();
}

class _HeightRecordState extends State<HeightRecord> {
  late TextEditingController heightController;

  String recordTime = '';
  var weekDayList = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
  var jiffy = Jiffy.now();
  late Jiffy lastYearDate;
  @override
  void initState() {
    super.initState();
    heightController = TextEditingController();

    lastYearDate = jiffy.subtract(years: 1);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        TDInput(
            type: TDInputType.special,
            controller: heightController,
            leftLabel: '身高',
            hintText: '请输入身高',
            backgroundColor: Colors.white,
            textAlign: TextAlign.end,
            rightWidget:
                TDText('cm', textColor: TDTheme.of(context).fontGyColor1)),
        gapHeightNormal(),
        GestureDetector(
          onTap: () {
            TDPicker.showDatePicker(context, title: '选择记录日期',
                onConfirm: (selected) {
              if (selected.isNotEmpty) {
                recordTime = '${selected['year'].toString().padLeft(4, '0')}-'
                    '${selected['month'].toString().padLeft(2, '0')}-'
                    '${selected['day'].toString().padLeft(2, '0')} ';
                //_babyController.changeBirthday(selected_6);
                setState(() {});
              }
              Navigator.of(context).pop();
            },
                useWeekDay: true,
                dateStart: [lastYearDate.year, 01, 01],
                dateEnd: [jiffy.year + 1, jiffy.month, jiffy.daysInMonth],
                initialDate: [jiffy.year, jiffy.month, jiffy.daysInMonth]);
          },
          child: buildRow(
            '记录时间',
          ),
        ),
        Gap(280.h),
        Align(
          alignment: Alignment.bottomCenter, // 对齐底部
          child: TDButton(
            disabled: recordTime.isEmpty || heightController.value.text.isEmpty,
            text: '确认',
            size: TDButtonSize.medium,
            type: TDButtonType.fill,
            shape: TDButtonShape.rectangle,
            theme: TDButtonTheme.primary,
            onTap: () async {
              await HeightRecordDao.create(parseDate(recordTime),
                  double.parse(heightController.value.text));
              await dialogSuccess('保存成功', onDismiss: () {
                SmartDialog.dismiss();
              });
              widget.onUpdate();
            },
          ),
        ),
      ],
    );
  }

  Widget buildRow(String leftText) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TDText(
            leftText,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              gapWidthSmall(),
              _buildRight(),
            ],
          ),
        ],
      ),
    );
  }

  _buildRight() {
    if (recordTime.isNotEmpty) {
      return TDText(recordTime);
    } else {
      return Icon(Icons.arrow_right_outlined);
    }
  }
}
