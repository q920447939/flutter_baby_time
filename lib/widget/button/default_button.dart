import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultButton extends StatefulWidget {
  final String title;
  VoidCallback? onPressed;
  bool allowClick = true;
  Color color;
  double? height;
  double? fontSize;
  DefaultButton({
    super.key,
    required this.title,
    this.onPressed,
    this.allowClick = true,
    this.color = const Color(0xFF1781F4),
    this.height,
    this.fontSize,
  });

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    var bottom2 = MediaQuery.of(context).viewInsets.bottom;
    print("bottom2: $bottom2");
    return GestureDetector(
      onTap: widget.allowClick ? widget.onPressed : null,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 10.h),
        child: Container(
          alignment: Alignment.center,
          height: widget.height ?? 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: widget.allowClick ? widget.color : Color(0xFF9CC9FA),
            boxShadow: [
              /**
                  offset 设置为 Offset(0, 8),表示阴影在容器底部向下偏移 8 个逻辑像素。
                  spreadRadius 设置为 -4,这将使阴影仅向内扩散,而不会向外扩散。
               */
              BoxShadow(
                color: Color(0xFF9CC9FA),
                offset: Offset(0, 8),
                blurRadius: 16,
                spreadRadius: -4,
              ),
            ],
          ),
          child: Center(
              child: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: widget.fontSize ?? 20.sp,
              letterSpacing: 2.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "SourceHanSerifCN",
            ),
          )),
        ),
      ),
    );
  }
}

Widget defaultBlueButton({
  required String title,
  VoidCallback? onPressed,
}) {
  return Container();
}
