import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class ConfirmDiaLog extends StatefulWidget {
  String title;
  String? content;

  VoidCallback? onConfirm;

  ConfirmDiaLog({
    super.key,
    required this.title,
    this.content,
    this.onConfirm,
  });

  @override
  State<ConfirmDiaLog> createState() => _ConfirmDiaLogState();
}

class _ConfirmDiaLogState extends State<ConfirmDiaLog> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.8;
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Center(
                child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 18.sp,
              ),
            )),
          ),
          if (widget.content != null)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
              child: Center(
                  child: Text(
                widget.content!,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              )),
            ),
          Expanded(
            child: Container(), // 占位符，将内容推到顶部
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    SmartDialog.dismiss();
                  },
                  child: Text('取消',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                      )),
                ),
                TextButton(
                  onPressed: widget.onConfirm,
                  child: Text(
                    '确认',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.sp,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
