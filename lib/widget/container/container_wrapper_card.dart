import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerWrapperCard extends StatelessWidget {
  double? width;
  double? height;
  Widget? child;
  BoxDecoration? decoration;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  ContainerWrapperCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.decoration,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      decoration: decoration ??
          BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
          ),
      child: child,
    );
  }
}
