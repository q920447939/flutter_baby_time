import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultDividerWrapper extends StatelessWidget {
  final Color? color;
  final double? thickness;

  const DefaultDividerWrapper(
      {super.key, this.color = Colors.grey, this.thickness = 0.2});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      thickness: thickness,
      indent: 0.w,
      endIndent: 10.w,
    );
  }
}
