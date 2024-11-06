import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Base64ImageWidget extends StatelessWidget {
  final String base64String;

  const Base64ImageWidget({Key? key, required this.base64String})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 移除 base64 字符串开头的 "data:image/png;base64," 部分（如果存在）
    final strippedBase64 =
        base64String.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');

    // 解码 base64 字符串
    Uint8List bytes = base64Decode(strippedBase64);

    // 使用 Image.memory 显示图片
    return Image.memory(
      bytes,
      width: 80.w,
      height: 40.h,
      fit: BoxFit.contain,
    );
  }
}
