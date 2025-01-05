import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_baby_time/widget/smart_dialog/smart_dialog_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../dao/image/image_dao.dart';
import '../../../dao/upload_list/upload_list_dao.dart';
import '../../../getx/controller/manager_gex_controller.dart';
import '../../../utils/datime_helper.dart';
import '../../../utils/premission/premission_helper.dart';
import '../../../widget/base_stack/base_stack.dart';
import '../../../widget/container/container_wrapper_card.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nine_grid_view/nine_grid_view.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../widget/pick/pick_image_by_wechat/image_bean.dart';
import '../../../widget/pick/pick_image_by_wechat/picture_utils.dart';
import '../../../getx/controller/baby/baby_setting_controller.dart';

class UploadFilePage extends StatefulWidget {
  const UploadFilePage({Key? key}) : super(key: key);

  @override
  _UploadFilePageState createState() => _UploadFilePageState();
}

class _UploadFilePageState extends State<UploadFilePage> {
  String selected_6 = "请选择上传时间";

  List<TDUploadFile> files2 = [];

  List<File> _imageFiles = [];
  int moveAction = MotionEvent.actionUp;
  bool _canDelete = false;
  bool _disable = true;

  TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 在初始化时检查权限
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestPermission(context);
    });
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
              maxLength: 1000,
              maxLines: 8,
              controller: remarkController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: "记录新鲜事",
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
            height: 400.h,
            child: SingleChildScrollView(
              child: TDUpload(
                files: files2,
                multiple: true,
                max: 999,
                onError: print,
                onValidate: print,
                onChange: ((files, type) =>
                    onValueChanged(files2, files, type)),
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
            onTap: () async {
              //SmartDialog.showToast('获取到图片,共${_imageFiles.length}张');
              dialogLoading();
              var imageUrls = await ImageDao.uploadImageByFiles(_imageFiles);
              SmartDialog.dismiss();
              var b = await UploadListDao.uploadList({
                "babyId": babyController.get()!.id!,
                "uploadType": 1,
                "uploadTime": selected_6,
                "remark": remarkController.text,
                "uploadImageAddReqVO": {
                  "babyId": babyController.get()!.id!,
                  "imageUrls": imageUrls
                }
              });
              if (b) {
                await dialogSuccess('上传成功');
                setState(() {
                  selected_6 = "请选择上传时间";
                  remarkController.text = '';
                  _imageFiles = [];
                  _disable = true;
                  files2 = [];
                });
              } else {
                await dialogWarning('上传失败');
              }
            },
          ),
          Gap(50.h),
        ],
      )),
    );
  }

  void onValueChanged(List<TDUploadFile> fileList, List<TDUploadFile> value,
      TDUploadType event) {
    switch (event) {
      case TDUploadType.add:
        setState(() {
          fileList.addAll(value);
          _imageFiles = fileList.map((e) => e.file!).toList();
          _changeDisable();
        });
        break;
      case TDUploadType.remove:
        setState(() {
          fileList.removeWhere((element) => element.key == value[0].key);
          _imageFiles = fileList.map((e) => e.file!).toList();
          _changeDisable();
        });
        break;
    }
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
      initialDate: [jiffy.year, jiffy.month, jiffy.date],
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
