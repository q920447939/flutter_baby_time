import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'enhanced_decimal_formatter.dart';

enum Around { all, underline }

//限制输入长度 只能输入数字，可以通过 decimalPlaces 调整小数位
class LimitNumberTextField extends StatefulWidget {
  final double height;
  final String hintText;
  final int maxInputNumber;
  final int maxLine;
  final Function(String)? callback;
  int decimalPlaces;
  TextStyle? textStyle;
  TextStyle? hintStyle;
  Around? around = Around.all;
  TextEditingController? textEditingController;

  LimitNumberTextField({
    super.key,
    required this.height,
    required this.hintText,
    required this.maxInputNumber,
    required this.maxLine,
    required this.callback,
    this.decimalPlaces = 0,
    this.textStyle,
    this.hintStyle,
    this.around,
    this.textEditingController,
  });

  @override
  State<LimitNumberTextField> createState() => _LimitNumberTextFieldState();
}

class _LimitNumberTextFieldState extends State<LimitNumberTextField> {
  TextEditingController? _textEditingController;
  bool useDDefaultTextEditingController = false;

  @override
  void initState() {
    super.initState();
    if (null != widget.textEditingController) {
      _textEditingController = widget.textEditingController;
    } else {
      useDDefaultTextEditingController = true;
      _textEditingController = TextEditingController();
    }
  }

  @override
  void dispose() {
    if (useDDefaultTextEditingController) {
      _textEditingController?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget wid;
    Widget child = buildAutoSizeTextField();
    if (widget.around == Around.all) {
      wid = Container(
        height: widget.height,
        margin: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(
            width: 0.5,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        child: child,
      );
    } else if (widget.around == Around.underline) {
      wid = SizedBox(height: widget.height, child: child);
    } else {
      wid = buildAutoSizeTextField();
    }
    return wid;
  }

  AutoSizeTextField buildAutoSizeTextField() {
    return AutoSizeTextField(
      keyboardType:
          const TextInputType.numberWithOptions(decimal: true, signed: false),
      inputFormatters: [
        EnhancedDecimalFormatter(
          decimalPlaces: widget.decimalPlaces,
        ),
      ],
      controller: _textEditingController,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        fillColor: Colors.transparent,
        filled: false,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
        contentPadding: EdgeInsets.only(bottom: 8.h),
        counterText:
            '${_textEditingController?.text.length}/${widget.maxInputNumber}',
        isDense: true,
      ),
      textAlign: TextAlign.start,
      maxLines: 1,
      maxLength: widget.maxInputNumber,
      style:
          widget.textStyle ?? TextStyle(fontSize: 18.sp, color: Colors.black),
      minFontSize: 12,
      stepGranularity: 0.1,
      onChanged: (text) {
        setState(() {
          if (text.length > widget.maxInputNumber) {
            _textEditingController?.text =
                text.substring(0, widget.maxInputNumber);
            _textEditingController?.selection = TextSelection.fromPosition(
              TextPosition(offset: widget.maxInputNumber),
            );
          }
          widget.callback?.call(text);
        });
      },
    );
  }
}
