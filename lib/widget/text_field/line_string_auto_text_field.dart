import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LineStringAutoTextField extends StatefulWidget {
  final TextStyle? style;

  final String hintText;
  final TextStyle? hintTextStyle;
  final int maxInputNumber;
  final Function(String)? callback;
  const LineStringAutoTextField({
    super.key,
    required this.hintText,
    required this.maxInputNumber,
    required this.callback,
    this.style,
    this.hintTextStyle,
  });

  @override
  State<LineStringAutoTextField> createState() =>
      _LineStringAutoTextFieldState();
}

class _LineStringAutoTextFieldState extends State<LineStringAutoTextField> {
  TextEditingController? _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoSizeTextField(
      controller: _textEditingController,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: InputBorder.none,
        hintStyle: widget.hintTextStyle ??
            TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
      ),
      textAlign: TextAlign.start, // 提示文字居中
      style: widget.style ?? TextStyle(fontSize: 18.sp, color: Colors.black),
      //maxFontSize: 20.sp,
      onChanged: (text) {
        setState(() {
          widget.callback?.call(text);
        });
      },
    );
  }
}
