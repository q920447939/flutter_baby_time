import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class DefaultDividerWrapper extends StatelessWidget {
  final Color? color;
  final double? thickness;

  const DefaultDividerWrapper(
      {super.key, this.color = Colors.grey, this.thickness = 0.2});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      child: Container(
        alignment: Alignment.center,
        child: const TDDivider(),
      ),
    );
  }
}
