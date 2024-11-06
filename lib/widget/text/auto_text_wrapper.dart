import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//auto_text  封装
class AutoTextWrapper extends StatelessWidget {
  double? width;
  final double height;
  final String content;
  TextStyle? style;
  final int? maxLines;
  double? maxFontSize;
  double? minFontSize;
  double? stepGranularity;
  final TextAlign? textAlign;

  AutoTextWrapper({
    super.key,
    this.width,
    required this.height,
    required this.content,
    this.style,
    this.maxLines = 1,
    this.maxFontSize,
    this.minFontSize,
    this.stepGranularity = 1,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 150.sp,
      child: AutoSizeText(
        textAlign: textAlign,
        content,
        style: style ?? TextStyle(fontSize: 14.sp, color: Colors.black),
        maxLines: maxLines, // 设置最大行数
        overflow: TextOverflow.ellipsis, // 设置文本溢出时的处理方式
        maxFontSize: maxFontSize ?? double.infinity,
        minFontSize: minFontSize ?? 10,
        stepGranularity: stepGranularity ?? 1,
      ),
    );
  }
}

class AutoTextFixWrapper extends StatelessWidget {
  final double width;
  final double height;
  final String content;
  TextStyle? style;
  final int? maxLines;
  final double fontSize;
  AutoTextFixWrapper({
    super.key,
    required this.width,
    required this.height,
    required this.content,
    this.style,
    this.maxLines = 1,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return AutoTextWrapper(
      width: width,
      height: height,
      content: content,
      maxFontSize: fontSize,
      minFontSize: fontSize,
      style: style,
    );
  }
}
