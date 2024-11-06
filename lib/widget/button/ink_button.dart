import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InkButton extends StatefulWidget {
  String buttonText;
  VoidCallback? onTap;
  InkButton({super.key, required this.buttonText, this.onTap});

  @override
  State<InkButton> createState() => _InkButtonState();
}

class _InkButtonState extends State<InkButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.r),
          onTap: widget.onTap,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 15.h, 10.w, 20.h),
            child: Center(
              child: Text(
                widget.buttonText,
                style: TextStyle(color: Colors.white, fontSize: 20.sp),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
