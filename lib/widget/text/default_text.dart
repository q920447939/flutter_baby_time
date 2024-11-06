import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Text defaultText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 14.sp,
    ),
  );
}

TextStyle defaultHintTextStyle() {
  return TextStyle(color: Color(0xFFBDBDBD), fontSize: 12.sp);
}
