import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//限制输入长度
class LimitStringTextField extends StatefulWidget {
  final double height;
  final String hintText;
  final int maxInputNumber;
  final int maxLine;
  final Function(String)? callback;
  const LimitStringTextField(
      {super.key,
      required this.height,
      required this.hintText,
      required this.maxInputNumber,
      required this.maxLine,
      required this.callback});

  @override
  State<LimitStringTextField> createState() => _LimitStringTextFieldState();
}

class _LimitStringTextFieldState extends State<LimitStringTextField> {
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
    return Container(
      height: widget.height,
      margin: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          width: 0.5,
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      child: AutoSizeTextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          counterText:
              '${_textEditingController?.text.length}/${widget.maxInputNumber}', // 显示字符计数
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey,
          ),
        ),
        textAlign: TextAlign.start, // 提示文字居中
        maxLines: 1,
        maxLength: widget.maxInputNumber, // 设置最大字符数
        style: TextStyle(fontSize: 18.sp, color: Colors.black),
        //maxFontSize: 20.sp,
        onChanged: (text) {
          setState(() {
            if (text.length > widget.maxInputNumber) {
              _textEditingController?.text =
                  text.substring(0, widget.maxInputNumber);
              _textEditingController?.selection = TextSelection.fromPosition(
                TextPosition(offset: widget.maxInputNumber),
              );
              return;
            }
            widget.callback?.call(text);
          });
        },
      ),
    );
  }
}
