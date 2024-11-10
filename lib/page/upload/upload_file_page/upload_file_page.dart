import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../router/has_bottom_navigator/shell_default_router.dart';
import '../../../widget/base_stack/base_stack.dart';
import '../../../widget/container/container_wrapper_card.dart';
import '../../../widget/image_edit/image_edit_type.dart';
import '../../../widget/image_pick/image_pick_wrap.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nine_grid_view/nine_grid_view.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../widget/pick/pick_image/image_bean.dart';
import '../../../widget/pick/pick_image/picture_utils.dart';

class UploadFilePage extends StatefulWidget {
  const UploadFilePage({Key? key}) : super(key: key);

  @override
  _UploadFilePageState createState() => _UploadFilePageState();
}

class _UploadFilePageState extends State<UploadFilePage> {
  String selected_6 = "请选择上传时间";

  List<ImageBean> _imageList = [];

  List<File> _imageFiles = [];
  int moveAction = MotionEvent.actionUp;
  bool _canDelete = false;
  bool _disable = true;

  @override
  void initState() {
    super.initState();
  }

  selectPictures() async {
    final List<AssetEntity>? entitys = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(maxAssets: 9 - _imageFiles.length),
    );
    if (entitys == null) return;
    //遍历
    for (var entity in entitys) {
      File? imgFile = await entity.file;

      if (imgFile != null) {
        setState(() {
          _imageFiles.add(imgFile);
          _imageList = PictureUtils.getImageBean(_imageFiles);
          print('22222' + imgFile.path);
        });
      }
      _changeDisable();
    }
  }

  _changeDisable() {
    setState(() {
      if (_imageFiles.isEmpty || selected_6 == '请选择上传时间') {
        _disable = true;
        return;
      } else {
        _disable = false;
      }
    });
  }

  _loadAssets(BuildContext context) {
    // pick Images.
    PictureUtils.showSnackBar(context, "pick Images.");
  }

  @override
  Widget build(BuildContext context) {
    return GreyBaseScaffoldStack(
      title: '上传图片',
      floatingActionButton: moveAction == MotionEvent.actionUp
          ? null
          : FloatingActionButton(
              onPressed: () {},
              child: Icon(_canDelete ? Icons.delete : Icons.delete_outline),
            ),
      child: ContainerWrapperCard(
          child: ListView(
        //mainAxisAlignment: MainAxisAlignment.start,
        scrollDirection: Axis.vertical,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(25, 20, 30, 25),
            height: 200.h,
            child: TextField(
              maxLength: 100,
              maxLines: 8,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: "分享新鲜事",
                  hintStyle: TextStyle(color: Colors.black12)),
            ),
          ),
          SizedBox(
            height: 20.h,
            child: Container(
              alignment: Alignment.center,
              child: const TDDivider(),
            ),
          ),
          ContainerWrapperCard(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            height: 40.h,
            child: GestureDetector(
              onTap: () {
                _selectUploadTime();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TDText(
                    '上传时间',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  TDText(formatChineseDate(selected_6)),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
            child: Container(
              alignment: Alignment.center,
              child: const TDDivider(),
            ),
          ),
          ContainerWrapperCard(
            height: 420.h,
            child: SingleChildScrollView(
              child: DragSortView(
                _imageList,
                space: 5,
                margin: EdgeInsets.all(10.w),
                itemBuilder: (BuildContext context, int index) {
                  ImageBean bean = _imageList[index];
                  // It is recommended to use a thumbnail picture
                  return PictureUtils.getWidget(bean.thumbPath!);
                },
                initBuilder: (BuildContext context) {
                  return InkWell(
                    onTap: () {
                      selectPictures();
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        color: Color(0xFFF0F0F0),
                        child: Center(
                          child: Icon(
                            Icons.add,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                onDragListener: (MotionEvent event, double itemWidth) {
                  switch (event.action) {
                    case MotionEvent.actionDown:
                      moveAction = event.action!;
                      setState(() {});
                      break;
                    case MotionEvent.actionMove:
                      double x = event.globalX! + itemWidth;
                      double y = event.globalY! + itemWidth;
                      double maxX = MediaQuery.of(context).size.width - 1 * 100;
                      double maxY =
                          MediaQuery.of(context).size.height - 1 * 100;
                      //print('Sky24n maxX: $maxX, maxY: $maxY, x: $x, y: $y');
                      if (_canDelete && (x < maxX || y < maxY)) {
                        setState(() {
                          _canDelete = false;
                        });
                      } else if (!_canDelete && x > maxX && y > maxY) {
                        setState(() {
                          _canDelete = true;
                        });
                      }
                      break;
                    case MotionEvent.actionUp:
                      moveAction = event.action!;
                      if (_canDelete) {
                        setState(() {
                          _canDelete = false;
                        });
                        return true;
                      } else {
                        setState(() {});
                      }
                      break;
                  }
                  return false;
                },
              ),
            ),
          ),
          //Spacer(),
          TDButton(
            width: 150.w,
            text: '确认',
            size: TDButtonSize.medium,
            type: TDButtonType.fill,
            shape: TDButtonShape.rectangle,
            theme: TDButtonTheme.primary,
            disabled: _disable,
            onTap: () {
              SmartDialog.showToast('获取到图片,共${_imageFiles.length}张');
            },
          ),
          Gap(50.h),
        ],
      )),
    );
  }

  void _selectUploadTime() {
    var jiffy = Jiffy.now();
    var last10YearDate = jiffy.subtract(years: 10);
    TDPicker.showDatePicker(
      context,
      title: '选择上传日期',
      onConfirm: (selected) {
        if (selected.isNotEmpty) {
          selected_6 = '${selected['year'].toString().padLeft(4, '0')}-'
              '${selected['month'].toString().padLeft(2, '0')}-'
              '${selected['day'].toString().padLeft(2, '0')} ';
        }
        _changeDisable();
        Navigator.of(context).pop();
      },
      useWeekDay: true,
      dateStart: [
        last10YearDate.year,
        last10YearDate.month,
        last10YearDate.daysInMonth
      ],
      dateEnd: [jiffy.year, jiffy.month, jiffy.daysInMonth],
      initialDate: [
        last10YearDate.year,
        last10YearDate.month,
        last10YearDate.daysInMonth
      ],
    );
  }

  String formatChineseDate(String dateStr) {
    // 先解析字符串为DateTime
    try {
      DateTime date = DateFormat('yyyy-MM-dd').parse(dateStr);
      // 再格式化为中文格式，注意这里的M不用MM，这样可以去掉月份前面的0
      return DateFormat('yyyy年M月d日').format(date);
    } catch (e) {
      return dateStr;
    }
  }
}
